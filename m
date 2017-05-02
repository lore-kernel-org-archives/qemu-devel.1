Received: from eggs.gnu.org ([2001:4830:134:3::10]:60391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5anC-0003iL-Ic
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5anB-0008US-MA
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:36:50 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  3 May 2017 00:35:42 +0800
Message-Id: <20170502163558.7611-8-famz@redhat.com>
In-Reply-To: <20170502163558.7611-1-famz@redhat.com>
References: <20170502163558.7611-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v17 07/23] iotests: 030: Prepare for image
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, famz@redhat.com, Max Reitz <mreitz@redhat.com>, eblake@redhat.com

qemu-img and qemu-io commands when guest is running need "-U" option,
add it.

Signed-off-by: Fam Zheng <famz@redhat.com>
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
2.9.3
