Received: from eggs.gnu.org ([2001:4830:134:3::10]:34781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewAGJ-000392-FT
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewAGI-0004DC-Lb
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:32:27 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 14 Mar 2018 18:32:11 +0100
Message-Id: <20180314173213.18563-4-kwolf@redhat.com>
In-Reply-To: <20180314173213.18563-1-kwolf@redhat.com>
References: <20180314173213.18563-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] tests/multiboot: Test exit code for every
 qemu run
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, jack.schwartz@oracle.com, anatol.pomozov@gmail.com, ppandit@redhat.com

Testing the exit code only once after a whole group of tests has
completed is not enough, it catches errors only in the very last qemu
invocation. We need to have the check after each qemu run.

The logging and diff with the reference output is still done once per
group to keep things more managable. This is not a problem because the
log file accumulates the output of all runs.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/multiboot/run_test.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
index 0278148b43..bc9c3670af 100755
--- a/tests/multiboot/run_test.sh
+++ b/tests/multiboot/run_test.sh
@@ -38,6 +38,17 @@ run_qemu() {
     ret=$?
 
     cat test.out >> test.log
+
+    debugexit=$((ret & 0x1))
+    ret=$((ret >> 1))
+
+    if [ $debugexit != 1 ]; then
+        printf %b "\e[31m ?? \e[0m $kernel $* (no debugexit used, exit code $ret)\n"
+        pass=0
+    elif [ $ret != 0 ]; then
+        printf %b "\e[31mFAIL\e[0m $kernel $* (exit code $ret)\n"
+        pass=0
+    fi
 }
 
 mmap() {
@@ -61,19 +72,8 @@ make all
 for t in mmap modules; do
 
     echo > test.log
-    $t
-
-    debugexit=$((ret & 0x1))
-    ret=$((ret >> 1))
     pass=1
-
-    if [ $debugexit != 1 ]; then
-        printf %b "\e[31m ?? \e[0m $t (no debugexit used, exit code $ret)\n"
-        pass=0
-    elif [ $ret != 0 ]; then
-        printf %b "\e[31mFAIL\e[0m $t (exit code $ret)\n"
-        pass=0
-    fi
+    $t
 
     if ! diff $t.out test.log > /dev/null 2>&1; then
         printf %b "\e[31mFAIL\e[0m $t (output difference)\n"
-- 
2.13.6
