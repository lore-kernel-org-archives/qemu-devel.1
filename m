Received: from eggs.gnu.org ([2001:4830:134:3::10]:40635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eP9DM-0003PO-Es
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eP9DI-00025F-HS
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:44:56 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 13 Dec 2017 16:44:32 +0100
Message-Id: <20171213154432.18097-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2] iotests: Tweak 030 in order to trigger a
 race condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

This patch tweaks TestParallelOps in iotest 030 so it allocates data
in smaller regions (256KB/512KB instead of 512KB/1MB) and the
block-stream job in test_stream_commit() only needs to copy data that
is at the very end of the image.

This way when the block-stream job is awakend it will finish right
away without any chance of being stopped by block_job_sleep_ns(). This
triggers the bug that was fixed by 3d5d319e1221082974711af1d09d82f07
and is therefore a more useful test case for parallel block jobs.

After this patch the aforementiond bug can also be reproduced with the
test_stream_parallel() test case.

Since with this change the stream job in test_stream_commit() finishes
early, this patch introduces a similar test case where both jobs are
slowed down so they can actually run in parallel.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/030     | 48 +++++++++++++++++++++++++++++++++++++++-------
 tests/qemu-iotests/030.out |  4 ++--
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 457984b8e9..44ad1e311f 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -156,7 +156,7 @@ class TestSingleDrive(iotests.QMPTestCase):
 class TestParallelOps(iotests.QMPTestCase):
     num_ops = 4 # Number of parallel block-stream operations
     num_imgs = num_ops * 2 + 1
-    image_len = num_ops * 1024 * 1024
+    image_len = num_ops * 512 * 1024
     imgs = []
 
     def setUp(self):
@@ -177,12 +177,12 @@ class TestParallelOps(iotests.QMPTestCase):
 
         # Put data into the images we are copying data from
         for i in range(self.num_imgs / 2):
-            img_index = i * 2 + 1
-            # Alternate between 512k and 1M.
+            img_index = self.num_imgs - i * 2 - 2
+            # Alternate between 256KB and 512KB.
             # This way jobs will not finish in the same order they were created
-            num_kb = 512 + 512 * (i % 2)
+            num_kb = 256 + 256 * (i % 2)
             qemu_io('-f', iotests.imgfmt,
-                    '-c', 'write -P %d %d %d' % (i, i*1024*1024, num_kb * 1024),
+                    '-c', 'write -P 0xFF %dk %dk' % (i * 512, num_kb),
                     self.imgs[img_index])
 
         # Attach the drive to the VM
@@ -318,12 +318,14 @@ class TestParallelOps(iotests.QMPTestCase):
         self.wait_until_completed(drive='commit-drive0')
 
     # Test a block-stream and a block-commit job in parallel
-    def test_stream_commit(self):
+    # Here the stream job is supposed to finish quickly in order to reproduce
+    # the scenario that triggers the bug fixed in 3d5d319e1221082974711af1d09
+    def test_stream_commit_1(self):
         self.assertLessEqual(8, self.num_imgs)
         self.assert_no_active_block_jobs()
 
         # Stream from node0 into node2
-        result = self.vm.qmp('block-stream', device='node2', job_id='node2')
+        result = self.vm.qmp('block-stream', device='node2', base_node='node0', job_id='node2')
         self.assert_qmp(result, 'return', {})
 
         # Commit from the active layer into node3
@@ -348,6 +350,38 @@ class TestParallelOps(iotests.QMPTestCase):
 
         self.assert_no_active_block_jobs()
 
+    # This is similar to test_stream_commit_1 but both jobs are slowed
+    # down so they can run in parallel for a little while.
+    def test_stream_commit_2(self):
+        self.assertLessEqual(8, self.num_imgs)
+        self.assert_no_active_block_jobs()
+
+        # Stream from node0 into node4
+        result = self.vm.qmp('block-stream', device='node4', base_node='node0', job_id='node4', speed=1024*1024)
+        self.assert_qmp(result, 'return', {})
+
+        # Commit from the active layer into node5
+        result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[5], speed=1024*1024)
+        self.assert_qmp(result, 'return', {})
+
+        # Wait for all jobs to be finished.
+        pending_jobs = ['node4', 'drive0']
+        while len(pending_jobs) > 0:
+            for event in self.vm.get_qmp_events(wait=True):
+                if event['event'] == 'BLOCK_JOB_COMPLETED':
+                    node_name = self.dictpath(event, 'data/device')
+                    self.assertTrue(node_name in pending_jobs)
+                    self.assert_qmp_absent(event, 'data/error')
+                    pending_jobs.remove(node_name)
+                if event['event'] == 'BLOCK_JOB_READY':
+                    self.assert_qmp(event, 'data/device', 'drive0')
+                    self.assert_qmp(event, 'data/type', 'commit')
+                    self.assert_qmp_absent(event, 'data/error')
+                    self.assertTrue('drive0' in pending_jobs)
+                    self.vm.qmp('block-job-complete', device='drive0')
+
+        self.assert_no_active_block_jobs()
+
     # Test the base_node parameter
     def test_stream_base_node_name(self):
         self.assert_no_active_block_jobs()
diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
index 391c8573ca..42314e9c00 100644
--- a/tests/qemu-iotests/030.out
+++ b/tests/qemu-iotests/030.out
@@ -1,5 +1,5 @@
-.......................
+........................
 ----------------------------------------------------------------------
-Ran 23 tests
+Ran 24 tests
 
 OK
-- 
2.11.0
