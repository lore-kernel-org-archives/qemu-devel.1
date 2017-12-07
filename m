Received: from eggs.gnu.org ([2001:4830:134:3::10]:45923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMzgR-0004K1-R2
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:10:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMzgO-0000I5-Ly
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:10:03 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  7 Dec 2017 19:08:34 +0200
Message-Id: <20171207170834.15843-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] iotests: Tweak 030 in order to trigger a race
 condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This patch tweaks TestParallelOps in iotest 030 so it allocates data
in smaller regions (256KB/512KB instead of 512KB/1MB) and the
block-stream job in test_stream_commit() only needs to copy data that
is at the very end of the image.

This way when the block-stream job is waken up it will finish right
away without any chance of being stopped by block_job_sleep_ns(). This
triggers the bug that was fixed by 3d5d319e1221082974711af1d09d82f07
and is therefore a more useful test case for parallel block jobs.

After this patch the aforementiond bug can also be reproduced with the
test_stream_parallel() test case.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/030 | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 457984b8e9..230eb761dd 100755
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
@@ -323,7 +323,7 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # Stream from node0 into node2
-        result = self.vm.qmp('block-stream', device='node2', job_id='node2')
+        result = self.vm.qmp('block-stream', device='node2', base_node='node0', job_id='node2')
         self.assert_qmp(result, 'return', {})
 
         # Commit from the active layer into node3
-- 
2.11.0
