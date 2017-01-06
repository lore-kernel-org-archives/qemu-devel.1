Received: from eggs.gnu.org ([2001:4830:134:3::10]:53492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cPLHG-00024f-2q
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cPLHE-00074e-SI
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:33:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cPLHE-00074I-Ko
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:33:12 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  6 Jan 2017 11:33:00 +0800
Message-Id: <1483673581-7843-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1483673581-7843-1-git-send-email-peterx@redhat.com>
References: <1483673581-7843-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v3 1/2] run_tests: put logs into
 per-test file
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

We were using test.log before to keep all the test logs. This patch
creates one log file per test case under logs/ directory with name
"TESTNAME.log".

A new file global.bash is added to store global informations.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Makefile               |  4 ++--
 run_tests.sh           | 14 ++++++++------
 scripts/functions.bash | 11 +++++++++--
 scripts/global.bash    |  2 ++
 4 files changed, 21 insertions(+), 10 deletions(-)
 create mode 100644 scripts/global.bash

diff --git a/Makefile b/Makefile
index a32333b..f632c6c 100644
--- a/Makefile
+++ b/Makefile
@@ -94,9 +94,9 @@ libfdt_clean:
 	$(LIBFDT_objdir)/.*.d
 
 distclean: clean libfdt_clean
-	$(RM) lib/asm config.mak $(TEST_DIR)-run test.log msr.out cscope.* \
+	$(RM) lib/asm config.mak $(TEST_DIR)-run msr.out cscope.* \
 	      build-head
-	$(RM) -r tests
+	$(RM) -r tests logs
 
 cscope: cscope_dirs = lib lib/libfdt lib/linux $(TEST_DIR) $(ARCH_LIBDIRS) lib/asm-generic
 cscope:
diff --git a/run_tests.sh b/run_tests.sh
index 254129d..e1bb3a6 100755
--- a/run_tests.sh
+++ b/run_tests.sh
@@ -7,6 +7,7 @@ if [ ! -f config.mak ]; then
     exit 1
 fi
 source config.mak
+source scripts/global.bash
 source scripts/functions.bash
 
 function usage()
@@ -46,17 +47,18 @@ while getopts "g:hv" opt; do
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
+rm -rf $ut_log_dir
+mkdir $ut_log_dir
+printf "BUILD_HEAD=$(cat build-head)\n\n" > $ut_log_summary
 for_each_unittest $config run
diff --git a/scripts/functions.bash b/scripts/functions.bash
index ee9143c..d1d2e1c 100644
--- a/scripts/functions.bash
+++ b/scripts/functions.bash
@@ -1,3 +1,10 @@
+function run_task()
+{
+	local testname="$2"
+
+	RUNTIME_log_file="${ut_log_dir}/${testname}.log"
+	"$@"
+}
 
 function for_each_unittest()
 {
@@ -17,7 +24,7 @@ function for_each_unittest()
 
 	while read -u $fd line; do
 		if [[ "$line" =~ ^\[(.*)\]$ ]]; then
-			"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+			run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
 			testname=${BASH_REMATCH[1]}
 			smp=1
 			kernel=""
@@ -45,6 +52,6 @@ function for_each_unittest()
 			timeout=${BASH_REMATCH[1]}
 		fi
 	done
-	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
+	run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
 	exec {fd}<&-
 }
diff --git a/scripts/global.bash b/scripts/global.bash
new file mode 100644
index 0000000..77b0b29
--- /dev/null
+++ b/scripts/global.bash
@@ -0,0 +1,2 @@
+: ${ut_log_dir:=logs}
+: ${ut_log_summary:=${ut_log_dir}/SUMMARY}
-- 
2.7.4
