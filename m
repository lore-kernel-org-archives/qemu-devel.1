Received: from eggs.gnu.org ([2001:4830:134:3::10]:48300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1foAFv-0007eh-6I
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1foAFu-0004wv-0t
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:27:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 10 Aug 2018 18:26:58 +0200
Message-Id: <20180810162658.6562-3-kwolf@redhat.com>
In-Reply-To: <20180810162658.6562-1-kwolf@redhat.com>
References: <20180810162658.6562-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qemu-iotests: Test commit with
 top-node/base-node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This adds some tests for block-commit with the new options top-node and
base-node (taking node names) instead of top and base (taking file
names).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/040     | 52 ++++++++++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/040.out |  4 ++--
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 1beb5e6dab..1cb1ceeb33 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -57,9 +57,12 @@ class ImageCommitTestCase(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
         self.vm.shutdown()
 
-    def run_commit_test(self, top, base, need_ready=False):
+    def run_commit_test(self, top, base, need_ready=False, node_names=False):
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('block-commit', device='drive0', top=top, base=base)
+        if node_names:
+            result = self.vm.qmp('block-commit', device='drive0', top_node=top, base_node=base)
+        else:
+            result = self.vm.qmp('block-commit', device='drive0', top=top, base=base)
         self.assert_qmp(result, 'return', {})
         self.wait_for_complete(need_ready)
 
@@ -101,6 +104,11 @@ class TestSingleDrive(ImageCommitTestCase):
         self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 524288', backing_img).find("verification failed"))
         self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xef 524288 524288', backing_img).find("verification failed"))
 
+    def test_commit_node(self):
+        self.run_commit_test("mid", "base", node_names=True)
+        self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 524288', backing_img).find("verification failed"))
+        self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xef 524288 524288', backing_img).find("verification failed"))
+
     def test_device_not_found(self):
         result = self.vm.qmp('block-commit', device='nonexistent', top='%s' % mid_img)
         self.assert_qmp(result, 'error/class', 'DeviceNotFound')
@@ -123,6 +131,30 @@ class TestSingleDrive(ImageCommitTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
         self.assert_qmp(result, 'error/desc', 'Base \'badfile\' not found')
 
+    def test_top_node_invalid(self):
+        self.assert_no_active_block_jobs()
+        result = self.vm.qmp('block-commit', device='drive0', top_node='badfile', base_node='base')
+        self.assert_qmp(result, 'error/class', 'GenericError')
+        self.assert_qmp(result, 'error/desc', "Cannot find device= nor node_name=badfile")
+
+    def test_base_node_invalid(self):
+        self.assert_no_active_block_jobs()
+        result = self.vm.qmp('block-commit', device='drive0', top_node='mid', base_node='badfile')
+        self.assert_qmp(result, 'error/class', 'GenericError')
+        self.assert_qmp(result, 'error/desc', "Cannot find device= nor node_name=badfile")
+
+    def test_top_path_and_node(self):
+        self.assert_no_active_block_jobs()
+        result = self.vm.qmp('block-commit', device='drive0', top_node='mid', base_node='base', top='%s' % mid_img)
+        self.assert_qmp(result, 'error/class', 'GenericError')
+        self.assert_qmp(result, 'error/desc', "'top-node' and 'top' are mutually exclusive")
+
+    def test_base_path_and_node(self):
+        self.assert_no_active_block_jobs()
+        result = self.vm.qmp('block-commit', device='drive0', top_node='mid', base_node='base', base='%s' % backing_img)
+        self.assert_qmp(result, 'error/class', 'GenericError')
+        self.assert_qmp(result, 'error/desc', "'base-node' and 'base' are mutually exclusive")
+
     def test_top_is_active(self):
         self.run_commit_test(test_img, backing_img, need_ready=True)
         self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 524288', backing_img).find("verification failed"))
@@ -139,6 +171,22 @@ class TestSingleDrive(ImageCommitTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
         self.assert_qmp(result, 'error/desc', 'Base \'%s\' not found' % mid_img)
 
+    def test_top_and_base_node_reversed(self):
+        self.assert_no_active_block_jobs()
+        result = self.vm.qmp('block-commit', device='drive0', top_node='base', base_node='top')
+        self.assert_qmp(result, 'error/class', 'GenericError')
+        self.assert_qmp(result, 'error/desc', "'top' is not in this backing file chain")
+
+    def test_top_node_in_wrong_chain(self):
+        self.assert_no_active_block_jobs()
+
+        result = self.vm.qmp('blockdev-add', driver='null-co', node_name='null')
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('block-commit', device='drive0', top_node='null', base_node='base')
+        self.assert_qmp(result, 'error/class', 'GenericError')
+        self.assert_qmp(result, 'error/desc', "'null' is not in this backing file chain")
+
     # When the job is running on a BB that is automatically deleted on hot
     # unplug, the job is cancelled when the device disappears
     def test_hot_unplug(self):
diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
index e20a75ce4f..802ffaa0c0 100644
--- a/tests/qemu-iotests/040.out
+++ b/tests/qemu-iotests/040.out
@@ -1,5 +1,5 @@
-.............................
+...........................................
 ----------------------------------------------------------------------
-Ran 29 tests
+Ran 43 tests
 
 OK
-- 
2.13.6
