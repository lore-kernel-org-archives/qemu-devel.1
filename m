Received: from eggs.gnu.org ([2001:4830:134:3::10]:56550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAFI0-00051j-NH
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAFHz-0005QV-VF
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:39:52 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 15 May 2017 14:39:40 +0200
Message-Id: <1494851980-6831-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-iotests: Test streaming with missing job
 ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, kchamart@redhat.com, qemu-devel@nongnu.org

This adds a small test for the image streaming error path for failing
block_job_create(), which would have found the null pointer dereference
in commit a170a91f.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/030     | 4 ++++
 tests/qemu-iotests/030.out | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index e00c11b..feee861 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -147,6 +147,10 @@ class TestSingleDrive(iotests.QMPTestCase):
         result = self.vm.qmp('block-stream', device='nonexistent')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
+    def test_job_id_missing(self):
+        result = self.vm.qmp('block-stream', device='mid')
+        self.assert_qmp(result, 'error/class', 'GenericError')
+
 
 class TestParallelOps(iotests.QMPTestCase):
     num_ops = 4 # Number of parallel block-stream operations
diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
index 84bfd63..391c857 100644
--- a/tests/qemu-iotests/030.out
+++ b/tests/qemu-iotests/030.out
@@ -1,5 +1,5 @@
-......................
+.......................
 ----------------------------------------------------------------------
-Ran 22 tests
+Ran 23 tests
 
 OK
-- 
1.8.3.1
