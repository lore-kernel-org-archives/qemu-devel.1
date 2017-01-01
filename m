Received: from eggs.gnu.org ([2001:4830:134:3::10]:60918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cNdTe-0006gm-P2
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 05:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cNdTd-0002Zh-Tx
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 05:34:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cNdTd-0002Yx-Oa
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 05:34:57 -0500
From: Peter Xu <peterx@redhat.com>
Date: Sun,  1 Jan 2017 18:34:45 +0800
Message-Id: <1483266886-25050-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1483266886-25050-1-git-send-email-peterx@redhat.com>
References: <1483266886-25050-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 1/2] run_tests: provide
 RUNTIME_log_file
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

Prepare that we may use different log file for different tests in the
future (i.e., to run tests in parallel).

Added another new file (scripts/global.bash) to store future global vars
and function clips.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 run_tests.sh           | 13 +++++++------
 scripts/functions.bash |  9 +++++++--
 scripts/global.bash    |  1 +
 3 files changed, 15 insertions(+), 8 deletions(-)
 create mode 100644 scripts/global.bash

diff --git a/run_tests.sh b/run_tests.sh
index 254129d..a04bfce 100755
--- a/run_tests.sh
+++ b/run_tests.sh
@@ -7,6 +7,7 @@ if [ ! -f config.mak ]; then
     exit 1
 fi
 source config.mak
+source scripts/global.bash
 source scripts/functions.bash
 
 function usage()
@@ -46,17 +47,17 @@ while getopts "g:hv" opt; do
     esac
 done
 
-RUNTIME_log_stderr () { cat >> test.log; }
+# RUNTIME_log_file will be configured later
+RUNTIME_log_stderr () { cat >> $RUNTIME_log_file; }
 RUNTIME_log_stdout () {
     if [ "$PRETTY_PRINT_STACKS" = "yes" ]; then
-        ./scripts/pretty_print_stacks.py $1 >> test.log
+        ./scripts/pretty_print_stacks.py $1 >> $RUNTIME_log_file
     else
-        cat >> test.log
+        cat >> $RUNTIME_log_file
     fi
 }
 
-
 config=$TEST_DIR/unittests.cfg
-rm -f test.log
-printf "BUILD_HEAD=$(cat build-head)\n\n" > test.log
+rm -f $ut_default_log_file
+printf "BUILD_HEAD=$(cat build-head)\n\n" > $ut_default_log_file
 for_each_unittest $config run
diff --git a/scripts/functions.bash b/scripts/functions.bash
index ee9143c..90daed4 100644
--- a/scripts/functions.bash
+++ b/scripts/functions.bash
@@ -1,3 +1,8 @@
+function run_task()
+{
+	RUNTIME_log_file=$ut_default_log_file
+	"$@"
+}
 
 function for_each_unittest()
 {
@@ -17,7 +22,7 @@ function for_each_unittest()
 
 	while read -u $fd line; do
 		if [[ "$line" =~ ^\[(.*)\]$ ]]; then
-			"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+			run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
 			testname=${BASH_REMATCH[1]}
 			smp=1
 			kernel=""
@@ -45,6 +50,6 @@ function for_each_unittest()
 			timeout=${BASH_REMATCH[1]}
 		fi
 	done
-	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+	run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
 	exec {fd}<&-
 }
diff --git a/scripts/global.bash b/scripts/global.bash
new file mode 100644
index 0000000..9076785
--- /dev/null
+++ b/scripts/global.bash
@@ -0,0 +1 @@
+: ${ut_default_log_file:=test.log}
-- 
2.7.4
