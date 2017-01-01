Received: from eggs.gnu.org ([2001:4830:134:3::10]:60933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cNdTk-0006jy-Ca
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 05:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cNdTj-0002gK-3I
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 05:35:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cNdTi-0002eG-QX
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 05:35:03 -0500
From: Peter Xu <peterx@redhat.com>
Date: Sun,  1 Jan 2017 18:34:46 +0800
Message-Id: <1483266886-25050-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1483266886-25050-1-git-send-email-peterx@redhat.com>
References: <1483266886-25050-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 2/2] run_tests: allow run tests
 in parallel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>, peterx@redhat.com, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>

run_task.sh is getting slow. This patch is trying to make it faster by
running the tests concurrently.

First of all, we provide a new parameter "-j" for the run_tests.sh,
which can be used to specify how many run queues we want for the tests.
When "-j" is not provided, we'll keep the old behavior.

When the tests are running concurrently, we will use seperate log file
for each test case (currently located in logs/ dir, with name
test.TESTNAME.log), to avoid test logs messing up with each other.

A quick test on my laptop (x86 with 4 cores and 2 threads, so 8
processors) shows 3x improvement on overall test time:

   |-----------------+-----------|
   | command         | time used |
   |-----------------+-----------|
   | run_test.sh     | 75s       |
   | run_test.sh -j8 | 27s       |
   |-----------------+-----------|

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 run_tests.sh            |  19 +++++-
 scripts/functions.bash  |  20 ++++++-
 scripts/global.bash     |  13 ++++
 scripts/mkstandalone.sh |   1 +
 scripts/task.bash       | 156 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 205 insertions(+), 4 deletions(-)
 create mode 100644 scripts/task.bash

diff --git a/run_tests.sh b/run_tests.sh
index a04bfce..8794aa0 100755
--- a/run_tests.sh
+++ b/run_tests.sh
@@ -8,16 +8,18 @@ if [ ! -f config.mak ]; then
 fi
 source config.mak
 source scripts/global.bash
+source scripts/task.bash
 source scripts/functions.bash
 
 function usage()
 {
 cat <<EOF
 
-Usage: $0 [-g group] [-h] [-v]
+Usage: $0 [-g group] [-h] [-v] [-j N]
 
     -g: Only execute tests in the given group
     -h: Output this help text
+    -j: Execute tests in parallel
     -v: Enables verbose mode
 
 Set the environment variable QEMU=/path/to/qemu-system-ARCH to
@@ -29,7 +31,7 @@ EOF
 RUNTIME_arch_run="./$TEST_DIR/run"
 source scripts/runtime.bash
 
-while getopts "g:hv" opt; do
+while getopts "g:hj:v" opt; do
     case $opt in
         g)
             only_group=$OPTARG
@@ -38,6 +40,13 @@ while getopts "g:hv" opt; do
             usage
             exit
             ;;
+        j)
+            ut_run_queues=$OPTARG
+            if ! is_number "$ut_run_queues"; then
+                echo "Invalid -j option: $ut_run_queues"
+                exit 1
+            fi
+            ;;
         v)
             verbose="yes"
             ;;
@@ -57,6 +66,12 @@ RUNTIME_log_stdout () {
     fi
 }
 
+if ut_in_parallel; then
+    rm -rf $ut_log_dir
+    mkdir $ut_log_dir
+    task_set_queue_num $ut_run_queues
+fi
+
 config=$TEST_DIR/unittests.cfg
 rm -f $ut_default_log_file
 printf "BUILD_HEAD=$(cat build-head)\n\n" > $ut_default_log_file
diff --git a/scripts/functions.bash b/scripts/functions.bash
index 90daed4..0da08e6 100644
--- a/scripts/functions.bash
+++ b/scripts/functions.bash
@@ -1,7 +1,18 @@
+source scripts/global.bash
+source scripts/task.bash
+
 function run_task()
 {
-	RUNTIME_log_file=$ut_default_log_file
-	"$@"
+	local testname="$2"
+
+	if ut_in_parallel; then
+		RUNTIME_log_file="${ut_log_dir}/test.${testname}.log"
+		# run in background
+		task_enqueue "$@"
+	else
+		RUNTIME_log_file=$ut_default_log_file
+		"$@"
+	fi
 }
 
 function for_each_unittest()
@@ -51,5 +62,10 @@ function for_each_unittest()
 		fi
 	done
 	run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+
+	if ut_in_parallel; then
+		task_wait_all
+	fi
+
 	exec {fd}<&-
 }
diff --git a/scripts/global.bash b/scripts/global.bash
index 9076785..dfcf0fe 100644
--- a/scripts/global.bash
+++ b/scripts/global.bash
@@ -1 +1,14 @@
 : ${ut_default_log_file:=test.log}
+: ${ut_log_dir:=logs}
+# how many run queues for the unit tests
+: ${ut_run_queues:=1}
+
+function ut_in_parallel()
+{
+    [[ $ut_run_queues != 1 ]]
+}
+
+function is_number()
+{
+    [[ "$1" =~ ^[0-9]+$ ]]
+}
diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
index d2bae19..b6c23c6 100755
--- a/scripts/mkstandalone.sh
+++ b/scripts/mkstandalone.sh
@@ -5,6 +5,7 @@ if [ ! -f config.mak ]; then
 	exit 1
 fi
 source config.mak
+source scripts/global.bash
 source scripts/functions.bash
 
 escape ()
diff --git a/scripts/task.bash b/scripts/task.bash
new file mode 100644
index 0000000..4b74e0e
--- /dev/null
+++ b/scripts/task.bash
@@ -0,0 +1,156 @@
+###################################################################
+#
+# This is a bash library to allow run multiple tasks in the
+# background.
+#
+# Exported interface:
+#
+# - task_enqueue:     enqueue a command to run in the bg
+# - task_wait_all:    wait until all the tasks are finished
+#
+# A sample test code:
+#
+#   source task.bash
+#   for i in $(seq 10); do
+#       task_enqueue sleep $i
+#   done
+#   task_wait_all
+#
+# NOTE: SIGUSR1 is used to deliver task notifications.
+#
+# Author(s): Peter Xu <peterx@redhat.com>
+#
+###################################################################
+
+task_debug=false                # debug flag
+task_max_n=5                    # concurrent task number
+
+# stores the main process that sourced this library
+task_main_pid=$$
+task_cur_n=0
+
+declare -a task_pid_list
+
+task_set_queue_num()
+{
+    task_max_n=$1
+}
+
+__task_print()
+{
+    echo "$@" >&2
+}
+
+__task_debug()
+{
+    if $task_debug; then
+        __task_print "$@"
+    fi
+}
+
+__task_sig_handler()
+{
+    local i pid
+
+    # wait for a short time to make sure the subprocess that has sent
+    # this signal has totally quit. 200ms should be far enough in most
+    # systems.
+    sleep 0.2
+
+    __task_debug "Detected child die"
+
+    for (( i=0; i<$task_max_n; i++ )); do
+        pid="${task_pid_list[$i]}"
+        if [[ -z "$pid" ]]; then
+            __task_debug "  Task slot $i empty"
+            continue;
+        fi
+        if ! kill -0 $pid &> /dev/null; then
+            __task_debug "  Child $pid died"
+            task_pid_list[$i]=""
+        else
+            __task_debug "  Child $pid still working"
+        fi
+    done
+}
+trap __task_sig_handler SIGUSR1
+
+__task_cur_move()
+{
+    task_cur_n=$(( $task_cur_n + 1 ))
+    if [[ $task_cur_n == $task_max_n ]]; then
+        task_cur_n=0
+    fi
+    __task_debug "Moving task pointer to $task_cur_n"
+}
+
+__task_run()
+{
+    "$@"
+    kill -USR1 $task_main_pid
+    __task_debug "Child $BASHPID quitting"
+}
+
+task_enqueue()
+{
+    local slot ret
+    local miss_cnt=0
+
+    # try to find an empty slot and run the task. If the queue is
+    # full, we wait until we got empty slot.
+    while :; do
+        if [[ -z "${task_pid_list[$task_cur_n]}" ]]; then
+            __task_debug "Found avail slot $task_cur_n"
+            slot=$task_cur_n
+            __task_cur_move
+            break
+        fi
+        __task_cur_move
+        miss_cnt=$(( $miss_cnt + 1 ))
+        if [[ $miss_cnt == $task_max_n ]]; then
+            # we looped over the tasks, no free slot, then we wait for
+            # any of them to quit. Here "wait" can be interrupted by
+            # retcode 138 (ECHILD) or 0 (when no child exists any
+            # more). Other retcode should be errornous.
+            __task_debug "Failed to find empty slot, will wait"
+            wait
+            ret=$?
+            if [[ $ret != 0 && $ret != 138 ]]; then
+                __task_print "Error: wait retcode illegal: $ret"
+                exit 1
+            fi
+            # we should have at least one empty slot now, reset the
+            # miss counter and retry. Logically we will for sure have
+            # an empty slot in the next iteration.
+            miss_cnt=0
+        fi
+    done
+
+    __task_debug "Starting task at slot $slot: '$@'"
+    __task_run "$@" &
+
+    task_pid_list[$slot]=$!
+}
+
+task_wait_all()
+{
+    local ret=0
+
+    while :; do
+        wait
+        ret=$?
+        if [[ $ret == 0 ]]; then
+            # all childs quited
+            return 0
+        elif [[ $ret == 138 ]]; then
+            # one of the child may have quited, but we need to wait
+            # more
+            continue
+        else
+            # this should not happen, if happens, we dump error
+            # and stop the loop
+            __task_print "Error: wait() failed with ret: $ret"
+            return 1
+        fi
+    done
+}
-- 
2.7.4
