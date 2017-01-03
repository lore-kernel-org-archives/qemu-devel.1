Received: from eggs.gnu.org ([2001:4830:134:3::10]:55189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOM2r-0005cP-HV
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOM2q-0007kG-9l
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:10:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cOM2q-0007k5-1C
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:10:16 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  3 Jan 2017 18:10:05 +0800
Message-Id: <1483438205-31110-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1483438205-31110-1-git-send-email-peterx@redhat.com>
References: <1483438205-31110-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [kvm-unit-tests PATCH v2 2/2] run_tests: allow run
 tests in parallel
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

We provide a new parameter "-j" for the run_tests.sh, which can be used
to specify how many run queues we want for the tests. Default queue
length is 1, which is the old behavior.

Quick test on my laptop (4 cores, 2 threads each) shows 3x speed boost:

   |-----------------+-----------|
   | command         | time used |
   |-----------------+-----------|
   | run_test.sh     | 75s       |
   | run_test.sh -j8 | 27s       |
   |-----------------+-----------|

Suggested-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 run_tests.sh           | 12 ++++++++++--
 scripts/functions.bash | 15 ++++++++++++++-
 scripts/global.bash    | 11 +++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/run_tests.sh b/run_tests.sh
index e1bb3a6..a4fc895 100755
--- a/run_tests.sh
+++ b/run_tests.sh
@@ -14,10 +14,11 @@ function usage()
 {
 cat <<EOF
=20
-Usage: $0 [-g group] [-h] [-v]
+Usage: $0 [-g group] [-h] [-v] [-j N]
=20
     -g: Only execute tests in the given group
     -h: Output this help text
+    -j: Execute tests in parallel
     -v: Enables verbose mode
=20
 Set the environment variable QEMU=3D/path/to/qemu-system-ARCH to
@@ -29,7 +30,7 @@ EOF
 RUNTIME_arch_run=3D"./$TEST_DIR/run"
 source scripts/runtime.bash
=20
-while getopts "g:hv" opt; do
+while getopts "g:hj:v" opt; do
     case $opt in
         g)
             only_group=3D$OPTARG
@@ -38,6 +39,13 @@ while getopts "g:hv" opt; do
             usage
             exit
             ;;
+        j)
+            ut_run_queues=3D$OPTARG
+            if ! is_number "$ut_run_queues"; then
+                echo "Invalid -j option: $ut_run_queues"
+                exit 1
+            fi
+            ;;
         v)
             verbose=3D"yes"
             ;;
diff --git a/scripts/functions.bash b/scripts/functions.bash
index d1d2e1c..acb306b 100644
--- a/scripts/functions.bash
+++ b/scripts/functions.bash
@@ -1,9 +1,18 @@
+source scripts/global.bash
+
 function run_task()
 {
 	local testname=3D"$2"
=20
+	while [[ "$(jobs | wc -l)" =3D=3D $ut_run_queues ]]; do
+		# wait for any background test to finish
+		wait -n
+	done
+
 	RUNTIME_log_file=3D"${ut_log_dir}/${testname}.log"
-	"$@"
+
+	# start the testcase in the background
+	"$@" &
 }
=20
 function for_each_unittest()
@@ -53,5 +62,9 @@ function for_each_unittest()
 		fi
 	done
 	run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" =
"$check" "$accel" "$timeout"
+
+	# wait all task finish
+	wait
+
 	exec {fd}<&-
 }
diff --git a/scripts/global.bash b/scripts/global.bash
index 77b0b29..52095bd 100644
--- a/scripts/global.bash
+++ b/scripts/global.bash
@@ -1,2 +1,13 @@
 : ${ut_log_dir:=3Dlogs}
 : ${ut_log_summary:=3D${ut_log_dir}/SUMMARY}
+: ${ut_run_queues:=3D1}
+
+function ut_in_parallel()
+{
+    [[ $ut_run_queues !=3D 1 ]]
+}
+
+function is_number()
+{
+    [[ "$1" =3D~ ^[0-9]+$ ]]
+}
--=20
2.7.4
