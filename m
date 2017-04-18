Received: from eggs.gnu.org ([2001:4830:134:3::10]:46320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d0WyR-0003s1-O4
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d0WyQ-0007lf-J0
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:31:31 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 18 Apr 2017 13:31:23 -0400
Message-Id: <fa564521b3660d574057fde906624e621d518c92.1492536554.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 1/1] qemu-iotests: _cleanup_qemu must
 be called on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

For the tests that use the common.qemu functions for running a QEMU
process, _cleanup_qemu must be called in the exit function.

If it is not, if the qemu process aborts, then not all of the droppings
are cleaned up (e.g. pidfile, fifos).

This updates those tests that did not have a cleanup in qemu-iotests.

(I swapped spaces for tabs in test 102 as well)

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/028 |  1 +
 tests/qemu-iotests/094 | 11 ++++++++---
 tests/qemu-iotests/102 |  5 +++--
 tests/qemu-iotests/109 |  1 +
 tests/qemu-iotests/117 |  1 +
 tests/qemu-iotests/130 |  1 +
 tests/qemu-iotests/140 |  1 +
 tests/qemu-iotests/141 |  1 +
 tests/qemu-iotests/143 |  1 +
 9 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 7783e57..97a8869 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -32,6 +32,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
+    _cleanup_qemu
     rm -f "${TEST_IMG}.copy"
     _cleanup_test_img
 }
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index 0ba0b0c..37042f6 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -27,7 +27,14 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-trap "exit \$status" 0 1 2 3 15
+_cleanup()
+{
+    _cleanup_qemu
+    _cleanup_test_img
+    rm -f "$TEST_DIR/source.$IMGFMT"
+}
+
+trap "cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
@@ -73,8 +80,6 @@ _send_qemu_cmd $QEMU_HANDLE \
 
 wait=1 _cleanup_qemu
 
-_cleanup_test_img
-rm -f "$TEST_DIR/source.$IMGFMT"
 
 # success, all done
 echo '*** done'
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index 64b4af9..87db1bb 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -25,11 +25,12 @@ seq=$(basename $0)
 echo "QA output created by $seq"
 
 here=$PWD
-status=1	# failure is the default!
+status=1    # failure is the default!
 
 _cleanup()
 {
-	_cleanup_test_img
+    _cleanup_qemu
+    _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index f980b0c..4781387 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -29,6 +29,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
+    _cleanup_qemu
     rm -f $TEST_IMG.src
 	_cleanup_test_img
 }
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 9385b3f..9ebfc4b 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -29,6 +29,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
+    _cleanup_qemu
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index ecc8a5b..d4d148b 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -31,6 +31,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
+    _cleanup_qemu
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index 49f9df4..8c80a5a 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -33,6 +33,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
+    _cleanup_qemu
     _cleanup_test_img
     rm -f "$TEST_DIR/nbd"
 }
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index b2617e5..b1956d4 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -29,6 +29,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
+    _cleanup_qemu
     _cleanup_test_img
     rm -f "$TEST_DIR/{b,m,o}.$IMGFMT"
 }
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index ec4ef22..5ff1944 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -29,6 +29,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
+    _cleanup_qemu
     rm -f "$TEST_DIR/nbd"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
-- 
2.9.3
