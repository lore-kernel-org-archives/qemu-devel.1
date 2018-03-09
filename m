Received: from eggs.gnu.org ([2001:4830:134:3::10]:34342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlS-0001hW-8t
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlP-0007a8-4w
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:21:02 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:32 +0100
Message-Id: <20180309161933.8168-56-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 55/56] iotests: Tweak 030 in order to trigger a
 race condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

This patch tweaks TestParallelOps in iotest 030 so it allocates data
in smaller regions (256KB/512KB instead of 512KB/1MB) and the
block-stream job in test_stream_commit() only needs to copy data that
is at the very end of the image.

This way when the block-stream job is awakened it will finish right
away without any chance of being stopped by block_job_sleep_ns(). This
triggers the bug that was fixed by 3d5d319e1221082974711af1d09d82f and
1a63a907507fbbcfaee3f622907ec24 and is therefore a more useful test
case for parallel block jobs.

After this patch the aforementiond bug can also be reproduced with the
test_stream_parallel() test case.

Since with this change the stream job in test_stream_commit() finishes
early, this patch introduces a similar test case where both jobs are
slowed down so they can actually run in parallel.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Cc: John Snow <jsnow@redhat.com>
Message-id: 20180306130121.30243-1-berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/030     | 52 ++++++++++++++++++++++++++++++++++++++--------
 tests/qemu-iotests/030.out |  4 ++--
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 457984b8e9..b5f88959aa 100755
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
@@ -176,14 +176,14 @@ class TestParallelOps(iotests.QMPTestCase):
                      '-o', 'backing_file=%s' % self.imgs[i-1], self.imgs[i])
 
         # Put data into the images we are copying data from
-        for i in range(self.num_imgs / 2):
-            img_index = i * 2 + 1
-            # Alternate between 512k and 1M.
+        odd_img_indexes = [x for x in reversed(range(self.num_imgs)) if x % 2 == 1]
+        for i in range(len(odd_img_indexes)):
+            # Alternate between 256KB and 512KB.
             # This way jobs will not finish in the same order they were created
-            num_kb = 512 + 512 * (i % 2)
+            num_kb = 256 + 256 * (i % 2)
             qemu_io('-f', iotests.imgfmt,
-                    '-c', 'write -P %d %d %d' % (i, i*1024*1024, num_kb * 1024),
-                    self.imgs[img_index])
+                    '-c', 'write -P 0xFF %dk %dk' % (i * 512, num_kb),
+                    self.imgs[odd_img_indexes[i]])
 
         # Attach the drive to the VM
         self.vm = iotests.VM()
@@ -318,12 +318,14 @@ class TestParallelOps(iotests.QMPTestCase):
         self.wait_until_completed(drive='commit-drive0')
 
     # Test a block-stream and a block-commit job in parallel
-    def test_stream_commit(self):
+    # Here the stream job is supposed to finish quickly in order to reproduce
+    # the scenario that triggers the bug fixed in 3d5d319e1221 and 1a63a907507
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
2.13.6
