Received: from eggs.gnu.org ([2001:4830:134:3::10]:37139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS0Vo-0003J5-Lc
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS0Vm-0007hp-Jd
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:31:32 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 07:31:14 -0500
Message-Id: <20170703123114.17103-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3] tests: Avoid non-portable 'echo -ARG'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, stefanha@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

POSIX says that backslashes in the arguments to 'echo', as well as
any use of 'echo -n' and 'echo -e', are non-portable; it recommends
people should favor 'printf' instead.  This is definitely true where
we do not control which shell is running (such as in makefile snippets
or in documentation examples).  But even for scripts where we
require bash (and therefore, where echo does what we want by default),
it is still possible to use 'shopt -s xpg_echo' to change bash's
behavior of echo.  And setting a good example never hurts when we are
not sure if a snippet will be copied from a bash-only script to a
general shell script (although I don't change the use of non-portable
\e for ESC when we know the running shell is bash).

Replace 'echo -n "..."' with 'printf %s "..."', and 'echo -e "..."'
with 'printf %b "...\n"', with the optimization that the %s/%b
argument can be omitted if the string being printed contains no
substitutions that could result in '%' (trivial if there are no
$ or `, but also possible when using things like $ret that are
known to be numeric given the assignment to ret just above).

In the qemu-iotests check script, fix unusual shell quoting
that would result in word-splitting if 'date' outputs a space.

In test 051, take an opportunity to shorten the line.

In test 068, get rid of a pointless second invocation of bash.

CC: qemu-trivial@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: use 'printf %s' in a few more places that substitute [Max]
v2: be robust to potential % in substitutions
---
 qemu-options.hx             |  4 ++--
 tests/multiboot/run_test.sh | 10 +++++-----
 tests/qemu-iotests/051      |  7 ++++---
 tests/qemu-iotests/068      |  2 +-
 tests/qemu-iotests/142      | 48 ++++++++++++++++++++++-----------------------
 tests/qemu-iotests/171      | 14 ++++++-------
 tests/qemu-iotests/check    | 18 ++++++++---------
 tests/rocker/all            | 10 +++++-----
 tests/tcg/cris/Makefile     |  8 ++++----
 9 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 297bd8a..05a0474 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4363,7 +4363,7 @@ The simplest (insecure) usage is to provide the secret inline

 The simplest secure usage is to provide the secret via a file

- # echo -n "letmein" > mypasswd.txt
+ # printf "letmein" > mypasswd.txt
  # $QEMU -object secret,id=sec0,file=mypasswd.txt,format=raw

 For greater security, AES-256-CBC should be used. To illustrate usage,
@@ -4391,7 +4391,7 @@ telling openssl to base64 encode the result, but it could be left
 as raw bytes if desired.

 @example
- # SECRET=$(echo -n "letmein" |
+ # SECRET=$(printf "letmein" |
             openssl enc -aes-256-cbc -a -K $KEY -iv $IV)
 @end example

diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
index 78d7edf..9a1cd59 100755
--- a/tests/multiboot/run_test.sh
+++ b/tests/multiboot/run_test.sh
@@ -26,7 +26,7 @@ run_qemu() {
     local kernel=$1
     shift

-    echo -e "\n\n=== Running test case: $kernel $@ ===\n" >> test.log
+    printf %b "\n\n=== Running test case: $kernel $@ ===\n\n" >> test.log

     $QEMU \
         -kernel $kernel \
@@ -68,21 +68,21 @@ for t in mmap modules; do
     pass=1

     if [ $debugexit != 1 ]; then
-        echo -e "\e[31m ?? \e[0m $t (no debugexit used, exit code $ret)"
+        printf "\e[31m ?? \e[0m $t (no debugexit used, exit code $ret)\n"
         pass=0
     elif [ $ret != 0 ]; then
-        echo -e "\e[31mFAIL\e[0m $t (exit code $ret)"
+        printf "\e[31mFAIL\e[0m $t (exit code $ret)\n"
         pass=0
     fi

     if ! diff $t.out test.log > /dev/null 2>&1; then
-        echo -e "\e[31mFAIL\e[0m $t (output difference)"
+        printf "\e[31mFAIL\e[0m $t (output difference)\n"
         diff -u $t.out test.log
         pass=0
     fi

     if [ $pass == 1 ]; then
-        echo -e "\e[32mPASS\e[0m $t"
+        printf "\e[32mPASS\e[0m $t\n"
     fi

 done
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 26c29de..c3c08bf 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -217,7 +217,7 @@ run_qemu -drive driver=null-co,cache=invalid_value
 # Test 142 checks the direct=on cases

 for cache in writeback writethrough unsafe invalid_value; do
-    echo -e "info block\ninfo block file\ninfo block backing\ninfo block backing-file" | \
+    printf "info block %s\n" '' file backing backing-file | \
     run_qemu -drive file="$TEST_IMG",cache=$cache,backing.file.filename="$TEST_IMG.base",backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=$device_id -nodefaults
 done

@@ -325,8 +325,9 @@ echo "qemu-io $device_id \"write -P 0x22 0 4k\"" | run_qemu -drive file="$TEST_I

 $QEMU_IO -c "read -P 0x22 0 4k" "$TEST_IMG" | _filter_qemu_io

-echo -e "qemu-io $device_id \"write -P 0x33 0 4k\"\ncommit $device_id" | run_qemu -drive file="$TEST_IMG",snapshot=on,if=none,id=$device_id\
-                                                                       | _filter_qemu_io
+printf "qemu-io $device_id \"write -P 0x33 0 4k\"\ncommit $device_id\n" |
+    run_qemu -drive file="$TEST_IMG",snapshot=on,if=none,id=$device_id |
+    _filter_qemu_io

 $QEMU_IO -c "read -P 0x33 0 4k" "$TEST_IMG" | _filter_qemu_io

diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 3801b65..cfa0f2a 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -76,7 +76,7 @@ for extra_args in \
     _make_test_img $IMG_SIZE

     # Give qemu some time to boot before saving the VM state
-    bash -c 'sleep 1; echo -e "savevm 0\nquit"' | _qemu $extra_args
+    { sleep 1; printf "savevm 0\nquit\n"; } | _qemu $extra_args
     # Now try to continue from that VM state (this should just work)
     echo quit | _qemu $extra_args -loadvm 0
 done
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 9a5b713..1639c83 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -94,36 +94,36 @@ function check_cache_all()
     # cache.direct is supposed to be inherited by both bs->file and
     # bs->backing

-    echo -e "cache.direct=on on none0"
+    printf "cache.direct=on on none0\n"
     echo "$hmp_cmds" | run_qemu -drive "$files","$ids",cache.direct=on | grep -e "Cache" -e "[Cc]annot|[Cc]ould not|[Cc]an't"
-    echo -e "\ncache.direct=on on file"
+    printf "\ncache.direct=on on file\n"
     echo "$hmp_cmds" | run_qemu -drive "$files","$ids",file.cache.direct=on | grep -e "Cache" -e "[Cc]annot|[Cc]ould not|[Cc]an't"
-    echo -e "\ncache.direct=on on backing"
+    printf "\ncache.direct=on on backing\n"
     echo "$hmp_cmds" | run_qemu -drive "$files","$ids",backing.cache.direct=on | grep -e "Cache" -e "[Cc]annot|[Cc]ould not|[Cc]an't"
-    echo -e "\ncache.direct=on on backing-file"
+    printf "\ncache.direct=on on backing-file\n"
     echo "$hmp_cmds" | run_qemu -drive "$files","$ids",backing.file.cache.direct=on | grep -e "Cache" -e "[Cc]annot|[Cc]ould not|[Cc]an't"

     # cache.writeback is supposed to be inherited by bs->backing; bs->file
     # always gets cache.writeback=on

-    echo -e "\n\ncache.writeback=off on none0"
+    printf "\n\ncache.writeback=off on none0\n"
     echo "$hmp_cmds" | run_qemu -drive "$files","$ids",cache.writeback=off | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
-    echo -e "\ncache.writeback=off on file"
+    printf "\ncache.writeback=off on file\n"
     echo "$hmp_cmds" | run_qemu -drive "$files","$ids",file.cache.writeback=off | grep -e "doesn't" -e "does not"
-    echo -e "\ncache.writeback=off on backing"
+    printf "\ncache.writeback=off on backing\n"
     echo "$hmp_cmds" | run_qemu -drive "$files","$ids",backing.cache.writeback=off | grep -e "doesn't" -e "does not"
-    echo -e "\ncache.writeback=off on backing-file"
+    printf "\ncache.writeback=off on backing-file\n"
     echo "$hmp_cmds" | run_qemu -drive "$files","$ids",backing.file.cache.writeback=off | grep -e "doesn't" -e "does not"

     # cache.no-flush is supposed to be inherited by both bs->file and bs->backing

-    echo -e "\n\ncache.no-flush=on on none0"
+    printf "\n\ncache.no-flush=on on none0\n"
     echo "$hmp_cmds" | run_qemu -drive "$files","$ids",cache.no-flush=on | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
-    echo -e "\ncache.no-flush=on on file"
+    printf "\ncache.no-flush=on on file\n"
     echo "$hmp_cmds" | run_qemu -drive "$files","$ids",file.cache.no-flush=on | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
-    echo -e "\ncache.no-flush=on on backing"
+    printf "\ncache.no-flush=on on backing\n"
     echo "$hmp_cmds" | run_qemu -drive "$files","$ids",backing.cache.no-flush=on | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
-    echo -e "\ncache.no-flush=on on backing-file"
+    printf "\ncache.no-flush=on on backing-file\n"
     echo "$hmp_cmds" | run_qemu -drive "$files","$ids",backing.file.cache.no-flush=on | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
 }

@@ -236,35 +236,35 @@ function check_cache_all_separate()
 {
     # Check cache.direct

-    echo -e "cache.direct=on on blk"
+    printf "cache.direct=on on blk\n"
     echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img",cache.direct=on | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
-    echo -e "\ncache.direct=on on file"
+    printf "\ncache.direct=on on file\n"
     echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file",cache.direct=on -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
-    echo -e "\ncache.direct=on on backing"
+    printf "\ncache.direct=on on backing\n"
     echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk",cache.direct=on -drive "$drv_file" -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
-    echo -e "\ncache.direct=on on backing-file"
+    printf "\ncache.direct=on on backing-file\n"
     echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile",cache.direct=on -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"

     # Check cache.writeback

-    echo -e "\n\ncache.writeback=off on blk"
+    printf "\n\ncache.writeback=off on blk\n"
     echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img",cache.writeback=off | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
-    echo -e "\ncache.writeback=off on file"
+    printf "\ncache.writeback=off on file\n"
     echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file",cache.writeback=off -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
-    echo -e "\ncache.writeback=off on backing"
+    printf "\ncache.writeback=off on backing\n"
     echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk",cache.writeback=off -drive "$drv_file" -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
-    echo -e "\ncache.writeback=off on backing-file"
+    printf "\ncache.writeback=off on backing-file\n"
     echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile",cache.writeback=off -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"

     # Check cache.no-flush

-    echo -e "\n\ncache.no-flush=on on blk"
+    printf "\n\ncache.no-flush=on on blk\n"
     echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img",cache.no-flush=on | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
-    echo -e "\ncache.no-flush=on on file"
+    printf "\ncache.no-flush=on on file\n"
     echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file",cache.no-flush=on -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
-    echo -e "\ncache.no-flush=on on backing"
+    printf "\ncache.no-flush=on on backing\n"
     echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk",cache.no-flush=on -drive "$drv_file" -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
-    echo -e "\ncache.no-flush=on on backing-file"
+    printf "\ncache.no-flush=on on backing-file\n"
     echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile",cache.no-flush=on -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
 }

diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index 257be10..54298ad 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -45,15 +45,15 @@ _supported_os Linux

 # Create JSON with options
 img_json() {
-    echo -n 'json:{"driver":"raw", '
-    echo -n "\"offset\":\"$img_offset\", "
+    printf 'json:{"driver":"raw", '
+    printf "\"offset\":\"$img_offset\", "
     if [ "$img_size" -ne -1 ] ; then
-        echo -n "\"size\":\"$img_size\", "
+        printf "\"size\":\"$img_size\", "
     fi
-    echo -n '"file": {'
-    echo -n    '"driver":"file", '
-    echo -n    "\"filename\":\"$TEST_IMG\" "
-    echo -n "} }"
+    printf '"file": {'
+    printf    '"driver":"file", '
+    printf %s "\"filename\":\"$TEST_IMG\" "
+    printf "} }"
 }

 do_general_test() {
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 4b1c674..30af0eb 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -141,7 +141,7 @@ _wallclock()
 _timestamp()
 {
     now=`date "+%T"`
-    echo -n " [$now]"
+    printf " [$now]"
 }

 _wrapup()
@@ -255,7 +255,7 @@ seq="check"
 for seq in $list
 do
     err=false
-    echo -n "$seq"
+    printf %s "$seq"
     if [ -n "$TESTS_REMAINING_LOG" ] ; then
         sed -e "s/$seq//" -e 's/  / /' -e 's/^ *//' $TESTS_REMAINING_LOG > $TESTS_REMAINING_LOG.tmp
         mv $TESTS_REMAINING_LOG.tmp $TESTS_REMAINING_LOG
@@ -281,9 +281,9 @@ do
         rm -f $seq.out.bad
         lasttime=`sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE`
         if [ "X$lasttime" != X ]; then
-                echo -n " ${lasttime}s ..."
+                printf %s " ${lasttime}s ..."
         else
-                echo -n "        "        # prettier output with timestamps.
+                printf "        "        # prettier output with timestamps.
         fi
         rm -f core $seq.notrun

@@ -291,7 +291,7 @@ do
         echo "$seq" > "${TEST_DIR}"/check.sts

         start=`_wallclock`
-        $timestamp && echo -n "        ["`date "+%T"`"]"
+        $timestamp && printf "        [$(date "+%T")]"

         if [ "$(head -n 1 "$source_iotests/$seq")" == "#!/usr/bin/env python" ]; then
             run_command="$PYTHON $seq"
@@ -314,21 +314,21 @@ do

         if [ -f core ]
         then
-            echo -n " [dumped core]"
+            printf " [dumped core]"
             mv core $seq.core
             err=true
         fi

         if [ -f $seq.notrun ]
         then
-            $timestamp || echo -n " [not run] "
-            $timestamp && echo " [not run]" && echo -n "        $seq -- "
+            $timestamp || printf " [not run] "
+            $timestamp && echo " [not run]" && printf "        $seq -- "
             cat $seq.notrun
             notrun="$notrun $seq"
         else
             if [ $sts -ne 0 ]
             then
-                echo -n " [failed, exit status $sts]"
+                printf " [failed, exit status $sts]"
                 err=true
             fi

diff --git a/tests/rocker/all b/tests/rocker/all
index d5ae963..3f9b786 100755
--- a/tests/rocker/all
+++ b/tests/rocker/all
@@ -1,19 +1,19 @@
-echo -n "Running port test...              "
+printf "Running port test...              "
 ./port
 if [ $? -eq 0 ]; then echo "pass"; else echo "FAILED"; exit 1; fi

-echo -n "Running bridge test...            "
+printf "Running bridge test...            "
 ./bridge
 if [ $? -eq 0 ]; then echo "pass"; else echo "FAILED"; exit 1; fi

-echo -n "Running bridge STP test...        "
+printf "Running bridge STP test...        "
 ./bridge-stp
 if [ $? -eq 0 ]; then echo "pass"; else echo "FAILED"; exit 1; fi

-echo -n "Running bridge VLAN test...       "
+printf "Running bridge VLAN test...       "
 ./bridge-vlan
 if [ $? -eq 0 ]; then echo "pass"; else echo "FAILED"; exit 1; fi

-echo -n "Running bridge VLAN STP test...   "
+printf "Running bridge VLAN STP test...   "
 ./bridge-vlan-stp
 if [ $? -eq 0 ]; then echo "pass"; else echo "FAILED"; exit 1; fi
diff --git a/tests/tcg/cris/Makefile b/tests/tcg/cris/Makefile
index 6b3dba4..664b30c 100644
--- a/tests/tcg/cris/Makefile
+++ b/tests/tcg/cris/Makefile
@@ -150,17 +150,17 @@ check_addcv17.tst: crtv10.o sysv10.o
 build: $(CRT) $(SYS) $(TESTCASES)

 check: $(CRT) $(SYS) $(TESTCASES)
-	@echo -e "\nQEMU simulator."
+	@printf "\nQEMU simulator.\n"
 	for case in $(TESTCASES); do \
-		echo -n "$$case "; \
+		printf %s "$$case "; \
 		SIMARGS=; \
 		case $$case in *v17*) SIMARGS="-cpu crisv17";; esac; \
 		$(SIM) $$SIMARGS ./$$case; \
 	done
 check-g: $(CRT) $(SYS) $(TESTCASES)
-	@echo -e "\nGDB simulator."
+	@printf "\nGDB simulator.\n"
 	@for case in $(TESTCASES); do \
-		echo -n "$$case "; \
+		printf %s "$$case "; \
 		$(SIMG) $$case; \
 	done

-- 
2.9.4
