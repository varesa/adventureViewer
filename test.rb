#!/bin/env ruby

require 'rubygems'
require 'json'
require 'readline'

prompt = '> '

def load_adventure(filename)
	file_contents = open(filename).read
	return JSON.parse(file_contents)
end

questions = load_adventure("questions.json")
pointer = 1
running = true

while running do
	q = questions[pointer.to_s]
	puts q['text']
	option_ids = q['options'].keys.sort
	for id in option_ids do
		puts "#{id}) #{q['options'][id.to_s]['text']}"
	end
	ans = Readline.readline(prompt)
	if ans == 'q' then
		puts "Quiting"
		running = false
	else
		valid = false
		for id in option_ids do
			if ans == id.to_s then
				pointer = q['options'][id.to_s]['goto'].to_i
				valid = true
			end
		end
	end
end
