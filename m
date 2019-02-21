Received: from eggs.gnu.org ([209.51.188.92]:33484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gwqFP-0004dW-IN
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gwqFJ-0000di-4t
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:26:46 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Thu, 21 Feb 2019 18:26:38 +0300
Message-Id: <1550762799-830661-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1550762799-830661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1550762799-830661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] iotests: 030 TestParallelOps non-shared
 base node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berto@igalia.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

The test case TestParallelOps::test_stream_parallel in #030 fails
if a base node is protected by the block-stream running job that
includes the base node into the job node list (block_job_add_bdrv)
without BLK_PERM_GRAPH_MOD shared permission.
The block-stream job would own the base node not allowing it to go
away due to the graph modification, e.g. when a filter node is
inserted above a top node of the parallel job. That's, the base
node was shared between the two parallel jobs.
This patch excludes sharing the node by inserting additional nodes
inbetween.
Furthermore, the block-stream job needs to own base node as the
limit to copy-on-read operation.
The insertion of additional nodes incures changes of node numbers
in two other cases:
test_overlapping_1
test_stream_base_node_name
because the nodes with written data got other numbers.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/030 | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 276e06b..c801be1 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -153,7 +153,8 @@ class TestSingleDrive(iotests.QMPTestCase):
 
 class TestParallelOps(iotests.QMPTestCase):
     num_ops = 4 # Number of parallel block-stream operations
-    num_imgs = num_ops * 2 + 1
+    step = 3 # base + source + target
+    num_imgs = num_ops * step
     image_len = num_ops * 512 * 1024
     imgs = []
 
@@ -174,14 +175,15 @@ class TestParallelOps(iotests.QMPTestCase):
                      '-o', 'backing_file=%s' % self.imgs[i-1], self.imgs[i])
 
         # Put data into the images we are copying data from
-        odd_img_indexes = [x for x in reversed(range(self.num_imgs)) if x % 2 == 1]
-        for i in range(len(odd_img_indexes)):
+        source_img_indexes = \
+            list(reversed(list(range(self.num_imgs)[1::self.step])))
+        for i in range(len(source_img_indexes)):
             # Alternate between 256KB and 512KB.
             # This way jobs will not finish in the same order they were created
             num_kb = 256 + 256 * (i % 2)
             qemu_io('-f', iotests.imgfmt,
                     '-c', 'write -P 0xFF %dk %dk' % (i * 512, num_kb),
-                    self.imgs[odd_img_indexes[i]])
+                    self.imgs[source_img_indexes[i]])
 
         # Attach the drive to the VM
         self.vm = iotests.VM()
@@ -199,14 +201,14 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # Check that the maps don't match before the streaming operations
-        for i in range(2, self.num_imgs, 2):
+        for i in range(2, self.num_imgs, self.step):
             self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[i]),
                                 qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[i-1]),
                                 'image file map matches backing file before streaming')
 
         # Create all streaming jobs
         pending_jobs = []
-        for i in range(2, self.num_imgs, 2):
+        for i in range(2, self.num_imgs, self.step):
             node_name = 'node%d' % i
             job_id = 'stream-%s' % node_name
             pending_jobs.append(job_id)
@@ -226,7 +228,7 @@ class TestParallelOps(iotests.QMPTestCase):
         self.vm.shutdown()
 
         # Check that all maps match now
-        for i in range(2, self.num_imgs, 2):
+        for i in range(2, self.num_imgs, self.step):
             self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[i]),
                              qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[i-1]),
                              'image file map does not match backing file after streaming')
@@ -237,16 +239,16 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # Set a speed limit to make sure that this job blocks the rest
-        result = self.vm.qmp('block-stream', device='node4', job_id='stream-node4', base=self.imgs[1], speed=1024*1024)
+        result = self.vm.qmp('block-stream', device='node5', job_id='stream-node5', base=self.imgs[1], speed=1024*1024)
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('block-stream', device='node5', job_id='stream-node5', base=self.imgs[2])
+        result = self.vm.qmp('block-stream', device='node6', job_id='stream-node6', base=self.imgs[2])
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         result = self.vm.qmp('block-stream', device='node3', job_id='stream-node3', base=self.imgs[2])
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-        result = self.vm.qmp('block-stream', device='node4', job_id='stream-node4-v2')
+        result = self.vm.qmp('block-stream', device='node5', job_id='stream-node5-v2')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         # block-commit should also fail if it touches nodes used by the stream job
@@ -260,7 +262,7 @@ class TestParallelOps(iotests.QMPTestCase):
         result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[0], top=self.imgs[1], job_id='commit-node0')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-        self.wait_until_completed(drive='stream-node4')
+        self.wait_until_completed(drive='stream-node5')
         self.assert_no_active_block_jobs()
 
     # Similar to test_overlapping_1, but with block-commit
@@ -383,8 +385,8 @@ class TestParallelOps(iotests.QMPTestCase):
     def test_stream_base_node_name(self):
         self.assert_no_active_block_jobs()
 
-        self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[4]),
-                            qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[3]),
+        self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[5]),
+                            qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[4]),
                             'image file map matches backing file before streaming')
 
         # Error: the base node does not exist
@@ -404,7 +406,7 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         # Success: the base node is a backing file of the top node
-        result = self.vm.qmp('block-stream', device='node4', base_node='node2', job_id='stream')
+        result = self.vm.qmp('block-stream', device='node5', base_node='node3', job_id='stream')
         self.assert_qmp(result, 'return', {})
 
         self.wait_until_completed(drive='stream')
@@ -412,8 +414,8 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
         self.vm.shutdown()
 
-        self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[4]),
-                         qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[3]),
+        self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[5]),
+                         qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[4]),
                          'image file map matches backing file after streaming')
 
 class TestQuorum(iotests.QMPTestCase):
-- 
1.8.3.1
