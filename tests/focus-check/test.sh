#!/bin/bash
. ../assert.sh
FLOW=$1

printf "\nStop any already-running server."
assert_ok "$FLOW" stop .

printf "\nFull check:\n"
assert_errors "$FLOW" check .

printf "\nFull focus-check:\n"
assert_errors "$FLOW" check .

printf "\nFocused check on a file with local errors but no dependency or reverse dependency:\n"
assert_errors "$FLOW" focus-check test.js

printf "\nFocused check on a file with no local errors but a dependency:\n"
assert_errors "$FLOW" focus-check a.js

printf "\nFocused check on a file with no local errors but a reverse dependency:\n"
assert_errors "$FLOW" focus-check b.js

printf "\nFocused check on two files with overlapping errors:\n"
assert_errors "$FLOW" focus-check {a,b}.js

printf "\nFocused check on multiple files with disjoint sets of errors:\n"
assert_errors "$FLOW" focus-check {a,b,test}.js

printf "\nFocused check on a file and a directory:\n"
assert_errors "$FLOW" focus-check test.js dir

printf "\nFocused check on files specified in list.txt:\n"
assert_errors "$FLOW" focus-check --input-file=list.txt 

printf "\nDone!\n"
