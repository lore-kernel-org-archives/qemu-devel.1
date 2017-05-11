Received: from eggs.gnu.org ([2001:4830:134:3::10]:36140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8p9r-0001SI-TL
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8p9q-0006p5-Sx
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:10 +0200
Message-Id: <1494513181-7900-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/58] iotests: 030: Prepare for image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

qemu-img and qemu-io commands when guest is running need "-U" option,
add it.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/030 | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 0d472d5..e00c11b 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -63,8 +63,8 @@ class TestSingleDrive(iotests.QMPTestCase):
     def test_stream_intermediate(self):
         self.assert_no_active_block_jobs()
 
-        self.assertNotEqual(qemu_io('-f', 'raw', '-c', 'map', backing_img),
-                            qemu_io('-f', iotests.imgfmt, '-c', 'map', mid_img),
+        self.assertNotEqual(qemu_io('-f', 'raw', '-rU', '-c', 'map', backing_img),
+                            qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', mid_img),
                             'image file map matches backing file before streaming')
 
         result = self.vm.qmp('block-stream', device='mid', job_id='stream-mid')
@@ -114,7 +114,7 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # The image map is empty before the operation
-        empty_map = qemu_io('-f', iotests.imgfmt, '-c', 'map', test_img)
+        empty_map = qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', test_img)
 
         # This is a no-op: no data should ever be copied from the base image
         result = self.vm.qmp('block-stream', device='drive0', base=mid_img)
@@ -197,8 +197,8 @@ class TestParallelOps(iotests.QMPTestCase):
 
         # Check that the maps don't match before the streaming operations
         for i in range(2, self.num_imgs, 2):
-            self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[i]),
-                                qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[i-1]),
+            self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[i]),
+                                qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[i-1]),
                                 'image file map matches backing file before streaming')
 
         # Create all streaming jobs
@@ -351,8 +351,8 @@ class TestParallelOps(iotests.QMPTestCase):
     def test_stream_base_node_name(self):
         self.assert_no_active_block_jobs()
 
-        self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[4]),
-                            qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[3]),
+        self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[4]),
+                            qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[3]),
                             'image file map matches backing file before streaming')
 
         # Error: the base node does not exist
@@ -422,8 +422,8 @@ class TestQuorum(iotests.QMPTestCase):
         if not iotests.supports_quorum():
             return
 
-        self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', self.children[0]),
-                            qemu_io('-f', iotests.imgfmt, '-c', 'map', self.backing[0]),
+        self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.children[0]),
+                            qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.backing[0]),
                             'image file map matches backing file before streaming')
 
         self.assert_no_active_block_jobs()
-- 
1.8.3.1
