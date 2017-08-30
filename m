Received: from eggs.gnu.org ([2001:4830:134:3::10]:56387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6Ew-0001RU-UI
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6Et-0004xw-1N
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:19 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 30 Aug 2017 12:52:46 -0400
Message-Id: <aba8a2b58f34b56281e63e5e9404eb0aab016836.1504111803.git.jcody@redhat.com>
In-Reply-To: <cover.1504111803.git.jcody@redhat.com>
References: <cover.1504111803.git.jcody@redhat.com>
In-Reply-To: <cover.1504111803.git.jcody@redhat.com>
References: <cover.1504111803.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/5] qemu-iotests: make python tests attempt
 to leave intermediate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com

Now that 'check' will clean up after tests, try and make python
tests leave intermediate files so that they might be inspectable
on failure.

This isn't perfect; the python unittest framework runs multiple
tests, even if previous tests failed.  So we need to make sure that
each test still begins with a "clean" slate, to prevent false
positives or tainted test runs.

Rather than delete images in the unittest tearDown, invert this
and delete images to be used in that test at the beginning of the
setUp.  This is to make sure that the test run is not inadvertently
using file droppings from previous runs.  We must use 'blind_remove'
then for these, as the files might not exist yet, but we don't want
to throw an error for that.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/030 |  8 +++---
 tests/qemu-iotests/040 | 35 ++++++++++---------------
 tests/qemu-iotests/041 | 70 +++++++++++++++++++++-----------------------------
 tests/qemu-iotests/044 |  8 ++----
 tests/qemu-iotests/045 | 14 +++++-----
 tests/qemu-iotests/055 | 36 +++++++++-----------------
 tests/qemu-iotests/056 | 13 ++++------
 tests/qemu-iotests/057 |  6 ++---
 tests/qemu-iotests/065 |  6 ++---
 tests/qemu-iotests/096 |  5 ++--
 tests/qemu-iotests/118 | 31 ++++++++++------------
 tests/qemu-iotests/124 | 21 +++++----------
 tests/qemu-iotests/132 |  9 +++----
 tests/qemu-iotests/136 |  3 ++-
 tests/qemu-iotests/139 |  6 ++---
 tests/qemu-iotests/147 | 16 ++++--------
 tests/qemu-iotests/148 |  7 ++---
 tests/qemu-iotests/152 |  9 +++----
 tests/qemu-iotests/155 | 15 +++++------
 tests/qemu-iotests/165 |  6 ++---
 20 files changed, 130 insertions(+), 194 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index d745cb4..051fb0c 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -21,7 +21,7 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import qemu_img, qemu_io, blind_remove
 
 backing_img = os.path.join(iotests.test_dir, 'backing.img')
 mid_img = os.path.join(iotests.test_dir, 'mid.img')
@@ -31,6 +31,9 @@ class TestSingleDrive(iotests.QMPTestCase):
     image_len = 1 * 1024 * 1024 # MB
 
     def setUp(self):
+        blind_remove(test_img)
+        blind_remove(mid_img)
+        blind_remove(backing_img)
         iotests.create_image(backing_img, TestSingleDrive.image_len)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, mid_img)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % mid_img, test_img)
@@ -41,9 +44,6 @@ class TestSingleDrive(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(mid_img)
-        os.remove(backing_img)
 
     def test_stream(self):
         self.assert_no_active_block_jobs()
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 95b7510..736afa7 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -24,7 +24,7 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import qemu_img, qemu_io, blind_remove
 import struct
 import errno
 
@@ -76,6 +76,9 @@ class TestSingleDrive(ImageCommitTestCase):
     test_len = 1 * 1024 * 256
 
     def setUp(self):
+        blind_remove(test_img)
+        blind_remove(mid_img)
+        blind_remove(backing_img)
         iotests.create_image(backing_img, self.image_len)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, mid_img)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % mid_img, test_img)
@@ -88,9 +91,6 @@ class TestSingleDrive(ImageCommitTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(mid_img)
-        os.remove(backing_img)
 
     def test_commit(self):
         self.run_commit_test(mid_img, backing_img)
@@ -214,6 +214,9 @@ class TestRelativePaths(ImageCommitTestCase):
         except OSError as exception:
             if exception.errno != errno.EEXIST:
                 raise
+        blind_remove(self.test_img)
+        blind_remove(self.mid_img_abs)
+        blind_remove(self.backing_img_abs)
         iotests.create_image(self.backing_img_abs, TestRelativePaths.image_len)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.backing_img_abs, self.mid_img_abs)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.mid_img_abs, self.test_img)
@@ -226,16 +229,6 @@ class TestRelativePaths(ImageCommitTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(self.test_img)
-        os.remove(self.mid_img_abs)
-        os.remove(self.backing_img_abs)
-        try:
-            os.rmdir(os.path.join(iotests.test_dir, self.dir1))
-            os.rmdir(os.path.join(iotests.test_dir, self.dir3))
-            os.rmdir(os.path.join(iotests.test_dir, self.dir2))
-        except OSError as exception:
-            if exception.errno != errno.EEXIST and exception.errno != errno.ENOTEMPTY:
-                raise
 
     def test_commit(self):
         self.run_commit_test(self.mid_img, self.backing_img)
@@ -280,6 +273,9 @@ class TestSetSpeed(ImageCommitTestCase):
     image_len = 80 * 1024 * 1024 # MB
 
     def setUp(self):
+        blind_remove(test_img)
+        blind_remove(mid_img)
+        blind_remove(backing_img)
         qemu_img('create', backing_img, str(TestSetSpeed.image_len))
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, mid_img)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % mid_img, test_img)
@@ -290,9 +286,6 @@ class TestSetSpeed(ImageCommitTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(mid_img)
-        os.remove(backing_img)
 
     def test_set_speed(self):
         self.assert_no_active_block_jobs()
@@ -319,6 +312,10 @@ class TestReopenOverlay(ImageCommitTestCase):
     img3 = os.path.join(iotests.test_dir, '3.img')
 
     def setUp(self):
+        blind_remove(self.img0)
+        blind_remove(self.img1)
+        blind_remove(self.img2)
+        blind_remove(self.img3)
         iotests.create_image(self.img0, self.image_len)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.img0, self.img1)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.img1, self.img2)
@@ -329,10 +326,6 @@ class TestReopenOverlay(ImageCommitTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(self.img0)
-        os.remove(self.img1)
-        os.remove(self.img2)
-        os.remove(self.img3)
 
     # This tests what happens when the overlay image of the 'top' node
     # needs to be reopened in read-write mode in order to update the
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index a860a31..2654256 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -21,7 +21,7 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import qemu_img, qemu_io, blind_remove
 
 backing_img = os.path.join(iotests.test_dir, 'backing.img')
 target_backing_img = os.path.join(iotests.test_dir, 'target-backing.img')
@@ -40,6 +40,9 @@ class TestSingleDrive(iotests.QMPTestCase):
     qmp_target = target_img
 
     def setUp(self):
+        blind_remove(test_img)
+        blind_remove(backing_img)
+        blind_remove(target_img)
         iotests.create_image(backing_img, self.image_len)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
         self.vm = iotests.VM().add_drive(test_img, "node-name=top,backing.node-name=base")
@@ -49,12 +52,6 @@ class TestSingleDrive(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
 
     def test_complete(self):
         self.assert_no_active_block_jobs()
@@ -258,6 +255,10 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
     image_len = 2 * 1024 * 1024 # MB
 
     def setUp(self):
+        blind_remove(test_img)
+        blind_remove(backing_img)
+        blind_remove(target_backing_img)
+        blind_remove(target_img)
         iotests.create_image(backing_img, TestMirrorNoBacking.image_len)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
         self.vm = iotests.VM().add_drive(test_img)
@@ -265,13 +266,6 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
-        try:
-            os.remove(target_backing_img)
-        except:
-            pass
-        os.remove(target_img)
 
     def test_complete(self):
         self.assert_no_active_block_jobs()
@@ -328,6 +322,9 @@ class TestMirrorResized(iotests.QMPTestCase):
     image_len = 2 * 1024 * 1024 # MB
 
     def setUp(self):
+        blind_remove(test_img)
+        blind_remove(backing_img)
+        blind_remove(target_img)
         iotests.create_image(backing_img, TestMirrorResized.backing_len)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
         qemu_img('resize', test_img, '2M')
@@ -336,12 +333,6 @@ class TestMirrorResized(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
 
     def test_complete_top(self):
         self.assert_no_active_block_jobs()
@@ -403,6 +394,10 @@ new_state = "1"
 
     def setUp(self):
         self.blkdebug_file = backing_img + ".blkdebug"
+        blind_remove(test_img)
+        blind_remove(target_img)
+        blind_remove(backing_img)
+        blind_remove(self.blkdebug_file)
         iotests.create_image(backing_img, TestReadErrors.image_len)
         self.create_blkdebug_file(self.blkdebug_file, "read_aio", 5)
         qemu_img('create', '-f', iotests.imgfmt,
@@ -417,10 +412,6 @@ new_state = "1"
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(target_img)
-        os.remove(backing_img)
-        os.remove(self.blkdebug_file)
 
     def test_report_read(self):
         self.assert_no_active_block_jobs()
@@ -558,6 +549,10 @@ new_state = "1"
 
     def setUp(self):
         self.blkdebug_file = target_img + ".blkdebug"
+        blind_remove(test_img)
+        blind_remove(target_img)
+        blind_remove(backing_img)
+        blind_remove(self.blkdebug_file)
         iotests.create_image(backing_img, TestWriteErrors.image_len)
         self.create_blkdebug_file(self.blkdebug_file, "write_aio", 5)
         qemu_img('create', '-f', iotests.imgfmt, '-obacking_file=%s' %(backing_img), test_img)
@@ -568,10 +563,6 @@ new_state = "1"
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(target_img)
-        os.remove(backing_img)
-        os.remove(self.blkdebug_file)
 
     def test_report_write(self):
         self.assert_no_active_block_jobs()
@@ -657,6 +648,9 @@ class TestSetSpeed(iotests.QMPTestCase):
     image_len = 80 * 1024 * 1024 # MB
 
     def setUp(self):
+        blind_remove(test_img)
+        blind_remove(backing_img)
+        blind_remove(target_img)
         qemu_img('create', backing_img, str(TestSetSpeed.image_len))
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
         self.vm = iotests.VM().add_drive(test_img)
@@ -664,9 +658,6 @@ class TestSetSpeed(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
-        os.remove(target_img)
 
     def test_set_speed(self):
         self.assert_no_active_block_jobs()
@@ -723,6 +714,8 @@ class TestUnbackedSource(iotests.QMPTestCase):
     image_len = 2 * 1024 * 1024 # MB
 
     def setUp(self):
+        blind_remove(test_img)
+        blind_remove(target_img)
         qemu_img('create', '-f', iotests.imgfmt, test_img,
                  str(TestUnbackedSource.image_len))
         self.vm = iotests.VM().add_drive(test_img)
@@ -730,8 +723,6 @@ class TestUnbackedSource(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(target_img)
 
     def test_absolute_paths_full(self):
         self.assert_no_active_block_jobs()
@@ -764,6 +755,8 @@ class TestGranularity(iotests.QMPTestCase):
     image_len = 10 * 1024 * 1024 # MB
 
     def setUp(self):
+        blind_remove(test_img)
+        blind_remove(target_img)
         qemu_img('create', '-f', iotests.imgfmt, test_img,
                  str(TestGranularity.image_len))
         qemu_io('-c', 'write 0 %d' % (self.image_len),
@@ -775,8 +768,6 @@ class TestGranularity(iotests.QMPTestCase):
         self.vm.shutdown()
         self.assertTrue(iotests.compare_images(test_img, target_img),
                         'target image does not match source after mirroring')
-        os.remove(test_img)
-        os.remove(target_img)
 
     def test_granularity(self):
         self.assert_no_active_block_jobs()
@@ -797,6 +788,9 @@ class TestRepairQuorum(iotests.QMPTestCase):
     IMAGES = [ quorum_img1, quorum_img2, quorum_img3 ]
 
     def setUp(self):
+        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_file ]:
+            blind_remove(i)
+
         self.vm = iotests.VM()
 
         if iotests.qemu_default_machine == 'pc':
@@ -823,12 +817,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_file ]:
-            # Do a try/except because the test may have deleted some images
-            try:
-                os.remove(i)
-            except OSError:
-                pass
 
     def test_complete(self):
         if not iotests.supports_quorum():
diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
index 11ea0f4..6b1a897 100755
--- a/tests/qemu-iotests/044
+++ b/tests/qemu-iotests/044
@@ -23,7 +23,7 @@ import os
 import qcow2
 from qcow2 import QcowHeader
 import iotests
-from iotests import qemu_img, qemu_img_verbose, qemu_io
+from iotests import qemu_img, qemu_img_verbose, qemu_io, blind_remove
 import struct
 import subprocess
 
@@ -99,15 +99,11 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
 
 
     def setUp(self):
+        blind_remove(test_img)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=512', test_img, '16G')
         self.preallocate(test_img)
         pass
 
-
-    def tearDown(self):
-        os.remove(test_img)
-        pass
-
     def test_grow_refcount_table(self):
         qemu_io('-c', 'write 3800M 1M', test_img)
         qemu_img_verbose('check' , test_img)
diff --git a/tests/qemu-iotests/045 b/tests/qemu-iotests/045
index 6be8fc4..2edb84a 100755
--- a/tests/qemu-iotests/045
+++ b/tests/qemu-iotests/045
@@ -20,7 +20,7 @@
 
 import os
 import iotests
-from iotests import qemu_img
+from iotests import qemu_img, blind_remove
 
 image0 = os.path.join(iotests.test_dir, 'image0')
 image1 = os.path.join(iotests.test_dir, 'image1')
@@ -31,6 +31,11 @@ image4 = os.path.join(iotests.test_dir, 'image4')
 class TestFdSets(iotests.QMPTestCase):
 
     def setUp(self):
+        blind_remove(image0)
+        blind_remove(image1)
+        blind_remove(image2)
+        blind_remove(image3)
+        blind_remove(image4)
         self.vm = iotests.VM()
         qemu_img('create', '-f', iotests.imgfmt, image0, '128K')
         qemu_img('create', '-f', iotests.imgfmt, image1, '128K')
@@ -57,11 +62,6 @@ class TestFdSets(iotests.QMPTestCase):
         self.file2.close()
         self.file3.close()
         self.file4.close()
-        os.remove(image0)
-        os.remove(image1)
-        os.remove(image2)
-        os.remove(image3)
-        os.remove(image4)
 
     def test_query_fdset(self):
         result = self.vm.qmp('query-fdsets')
@@ -128,6 +128,7 @@ class TestFdSets(iotests.QMPTestCase):
 # Add fd at runtime, there are two ways: monitor related or fdset related
 class TestSCMFd(iotests.QMPTestCase):
     def setUp(self):
+        blind_remove(image0)
         self.vm = iotests.VM()
         qemu_img('create', '-f', iotests.imgfmt, image0, '128K')
         # Add an unused monitor, to verify it works fine when two monitor
@@ -137,7 +138,6 @@ class TestSCMFd(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(image0)
 
     def _send_fd_by_SCM(self):
         ret = self.vm.send_fd_scm(image0)
diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index e1206ca..50588f8 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -23,7 +23,7 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import qemu_img, qemu_io, blind_remove
 
 test_img = os.path.join(iotests.test_dir, 'test.img')
 target_img = os.path.join(iotests.test_dir, 'target.img')
@@ -32,6 +32,7 @@ blockdev_target_img = os.path.join(iotests.test_dir, 'blockdev-target.img')
 image_len = 64 * 1024 * 1024 # MB
 
 def setUpModule():
+    blind_remove(test_img)
     qemu_img('create', '-f', iotests.imgfmt, test_img, str(image_len))
     qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x11 0 64k', test_img)
     qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x00 64k 128k', test_img)
@@ -40,12 +41,11 @@ def setUpModule():
     qemu_io('-f', iotests.imgfmt, '-c', 'write -P0xdc 32M 124k', test_img)
     qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x33 67043328 64k', test_img)
 
-def tearDownModule():
-    os.remove(test_img)
-
 
 class TestSingleDrive(iotests.QMPTestCase):
     def setUp(self):
+        blind_remove(blockdev_target_img)
+        blind_remove(target_img)
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
 
         self.vm = iotests.VM().add_drive(test_img)
@@ -56,11 +56,6 @@ class TestSingleDrive(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(blockdev_target_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
 
     def do_test_cancel(self, cmd, target):
         self.assert_no_active_block_jobs()
@@ -164,6 +159,8 @@ class TestSingleDrive(iotests.QMPTestCase):
 
 class TestSetSpeed(iotests.QMPTestCase):
     def setUp(self):
+        blind_remove(blockdev_target_img)
+        blind_remove(target_img)
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
 
         self.vm = iotests.VM().add_drive(test_img)
@@ -172,11 +169,6 @@ class TestSetSpeed(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(blockdev_target_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
 
     def do_test_set_speed(self, cmd, target):
         self.assert_no_active_block_jobs()
@@ -248,6 +240,8 @@ class TestSetSpeed(iotests.QMPTestCase):
 
 class TestSingleTransaction(iotests.QMPTestCase):
     def setUp(self):
+        blind_remove(blockdev_target_img)
+        blind_remove(target_img)
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
 
         self.vm = iotests.VM().add_drive(test_img)
@@ -258,11 +252,6 @@ class TestSingleTransaction(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(blockdev_target_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
 
     def do_test_cancel(self, cmd, target):
         self.assert_no_active_block_jobs()
@@ -452,13 +441,12 @@ class TestDriveCompression(iotests.QMPTestCase):
     fmt_supports_compression = [{'type': 'qcow2', 'args': ()},
                                 {'type': 'vmdk', 'args': ('-o', 'subformat=streamOptimized')}]
 
+    def setUp(self):
+        blind_remove(blockdev_target_img)
+        blind_remove(target_img)
+
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(blockdev_target_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
 
     def do_prepare_drives(self, fmt, args, attach_target):
         self.vm = iotests.VM().add_drive(test_img)
diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index 04f2c3c..3aefb93 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -23,7 +23,7 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io, create_image
+from iotests import qemu_img, qemu_io, create_image, blind_remove
 
 backing_img = os.path.join(iotests.test_dir, 'backing.img')
 test_img = os.path.join(iotests.test_dir, 'test.img')
@@ -33,6 +33,9 @@ class TestSyncModesNoneAndTop(iotests.QMPTestCase):
     image_len = 64 * 1024 * 1024 # MB
 
     def setUp(self):
+        blind_remove(test_img)
+        blind_remove(backing_img)
+        blind_remove(target_img)
         create_image(backing_img, TestSyncModesNoneAndTop.image_len)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
         qemu_io('-c', 'write -P0x41 0 512', test_img)
@@ -44,12 +47,6 @@ class TestSyncModesNoneAndTop(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
 
     def test_complete_top(self):
         self.assert_no_active_block_jobs()
@@ -84,12 +81,12 @@ class TestSyncModesNoneAndTop(iotests.QMPTestCase):
 
 class TestBeforeWriteNotifier(iotests.QMPTestCase):
     def setUp(self):
+        blind_remove(target_img)
         self.vm = iotests.VM().add_drive_raw("file=blkdebug::null-co://,id=drive0,align=65536,driver=blkdebug")
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(target_img)
 
     def test_before_write_notifier(self):
         self.vm.pause_drive("drive0")
diff --git a/tests/qemu-iotests/057 b/tests/qemu-iotests/057
index 9f0a5a3..0d99959 100755
--- a/tests/qemu-iotests/057
+++ b/tests/qemu-iotests/057
@@ -23,7 +23,7 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import qemu_img, qemu_io, blind_remove
 
 test_drv_base_name = 'drive'
 
@@ -36,6 +36,8 @@ class ImageSnapshotTestCase(iotests.QMPTestCase):
 
     def _setUp(self, test_img_base_name, image_num):
         self.vm = iotests.VM()
+        for dev_expect in self.expect:
+            blind_remove(dev_expect['image'])
         for i in range(0, image_num):
             filename = '%s%d' % (test_img_base_name, i)
             img = os.path.join(iotests.test_dir, filename)
@@ -49,8 +51,6 @@ class ImageSnapshotTestCase(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        for dev_expect in self.expect:
-            os.remove(dev_expect['image'])
 
     def createSnapshotInTransaction(self, snapshot_num, abort = False):
         actions = []
diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index 72aa970..b63ee13 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -23,7 +23,7 @@ import os
 import re
 import json
 import iotests
-from iotests import qemu_img, qemu_img_pipe
+from iotests import qemu_img, qemu_img_pipe, blind_remove
 import unittest
 
 test_img = os.path.join(iotests.test_dir, 'test.img')
@@ -32,14 +32,12 @@ class TestImageInfoSpecific(iotests.QMPTestCase):
     '''Abstract base class for ImageInfoSpecific tests'''
 
     def setUp(self):
+        blind_remove(test_img)
         if self.img_options is None:
             self.skipTest('Skipping abstract test class')
         qemu_img('create', '-f', iotests.imgfmt, '-o', self.img_options,
                  test_img, '128K')
 
-    def tearDown(self):
-        os.remove(test_img)
-
 class TestQemuImgInfo(TestImageInfoSpecific):
     '''Abstract base class for qemu-img info tests'''
 
diff --git a/tests/qemu-iotests/096 b/tests/qemu-iotests/096
index aeeb375..d1c4902 100644
--- a/tests/qemu-iotests/096
+++ b/tests/qemu-iotests/096
@@ -21,6 +21,7 @@
 
 import iotests
 import os
+from iotests import blind_remove
 
 class TestLiveSnapshot(iotests.QMPTestCase):
     base_img = os.path.join(iotests.test_dir, 'base.img')
@@ -30,6 +31,8 @@ class TestLiveSnapshot(iotests.QMPTestCase):
     iops_size = 1024
 
     def setUp(self):
+        blind_remove(self.base_img)
+        blind_remove(self.target_img)
         opts = []
         opts.append('node-name=base')
         opts.append('throttling.group=%s' % self.group)
@@ -41,8 +44,6 @@ class TestLiveSnapshot(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(self.base_img)
-        os.remove(self.target_img)
 
     def checkConfig(self, active_layer):
         result = self.vm.qmp('query-block')
diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index 8a9e838..d90ea98 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -23,7 +23,7 @@ import os
 import stat
 import time
 import iotests
-from iotests import qemu_img
+from iotests import qemu_img, blind_remove
 
 old_img = os.path.join(iotests.test_dir, 'test0.img')
 new_img = os.path.join(iotests.test_dir, 'test1.img')
@@ -323,6 +323,8 @@ class TestInitiallyFilled(GeneralChangeTestsBaseClass):
     was_empty = False
 
     def setUp(self, media, interface):
+        blind_remove(old_img)
+        blind_remove(new_img)
         qemu_img('create', '-f', iotests.imgfmt, old_img, '1440k')
         qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
         self.vm = iotests.VM()
@@ -336,8 +338,6 @@ class TestInitiallyFilled(GeneralChangeTestsBaseClass):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(old_img)
-        os.remove(new_img)
 
     def test_insert_on_filled(self):
         result = self.vm.qmp('blockdev-add',
@@ -360,13 +360,13 @@ class TestInitiallyEmpty(GeneralChangeTestsBaseClass):
     was_empty = True
 
     def setUp(self, media, interface):
+        blind_remove(new_img)
         qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
         self.vm = iotests.VM().add_drive(None, 'media=%s' % media, interface)
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(new_img)
 
     def test_remove_on_empty(self):
         result = self.vm.qmp('blockdev-open-tray', device='drive0')
@@ -411,16 +411,16 @@ class TestFloppyInitiallyEmpty(TestInitiallyEmpty):
 
 class TestChangeReadOnly(ChangeBaseClass):
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, old_img, '1440k')
-        qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
-        self.vm = iotests.VM()
-
-    def tearDown(self):
-        self.vm.shutdown()
         os.chmod(old_img, 0666)
         os.chmod(new_img, 0666)
-        os.remove(old_img)
-        os.remove(new_img)
+        blind_remove(old_img)
+        blind_remove(new_img)
+        qemu_img('create', '-f', iotests.imgfmt, old_img, '1440k')
+        qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
+        self.vm = iotests.VM()
+
+    def tearDown(self):
+        self.vm.shutdown()
 
     def test_ro_ro_retain(self):
         os.chmod(old_img, 0444)
@@ -645,6 +645,8 @@ TestInitiallyEmpty = None
 
 class TestBlockJobsAfterCycle(ChangeBaseClass):
     def setUp(self):
+        blind_remove(old_img)
+        blind_remove(new_img)
         qemu_img('create', '-f', iotests.imgfmt, old_img, '1M')
 
         self.vm = iotests.VM()
@@ -678,11 +680,6 @@ class TestBlockJobsAfterCycle(ChangeBaseClass):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(old_img)
-        try:
-            os.remove(new_img)
-        except OSError:
-            pass
 
     def test_snapshot_and_commit(self):
         # We need backing file support
diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index 8e76e62..1aabe64 100644
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -22,20 +22,13 @@
 
 import os
 import iotests
+from iotests import blind_remove
 
 
 def io_write_patterns(img, patterns):
     for pattern in patterns:
         iotests.qemu_io('-c', 'write -P%s %s %s' % pattern, img)
 
-
-def try_remove(img):
-    try:
-        os.remove(img)
-    except OSError:
-        pass
-
-
 def transaction_action(action, **kwargs):
     return {
         'type': action,
@@ -82,13 +75,13 @@ class Bitmap:
 
     def del_target(self):
         for image in self.backups.pop():
-            try_remove(image)
+            blind_remove(image)
         self.num -= 1
 
     def cleanup(self):
         for backup in self.backups:
             for image in backup:
-                try_remove(image)
+                blind_remove(image)
 
 
 class TestIncrementalBackupBase(iotests.QMPTestCase):
@@ -102,6 +95,10 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
 
 
     def setUp(self):
+        for filename in self.files:
+            blind_remove(filename)
+        for bitmap in self.bitmaps:
+            bitmap.cleanup()
         # Create a base image with a distinctive patterning
         drive0 = self.add_node('drive0')
         self.img_create(drive0['file'], drive0['fmt'])
@@ -273,10 +270,6 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        for bitmap in self.bitmaps:
-            bitmap.cleanup()
-        for filename in self.files:
-            try_remove(filename)
 
 
 
diff --git a/tests/qemu-iotests/132 b/tests/qemu-iotests/132
index f53ef6e..375d9ed 100644
--- a/tests/qemu-iotests/132
+++ b/tests/qemu-iotests/132
@@ -21,7 +21,7 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import qemu_img, qemu_io, blind_remove
 
 test_img = os.path.join(iotests.test_dir, 'test.img')
 target_img = os.path.join(iotests.test_dir, 'target.img')
@@ -30,6 +30,8 @@ class TestSingleDrive(iotests.QMPTestCase):
     image_len = 2 * 1024 * 1024 # MB
 
     def setUp(self):
+        blind_remove(test_img)
+        blind_remove(target_img)
         # Write data to the image so we can compare later
         qemu_img('create', '-f', iotests.imgfmt, test_img, str(TestSingleDrive.image_len))
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x5d 0 2M', test_img)
@@ -39,11 +41,6 @@ class TestSingleDrive(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
 
     def test_mirror_discard(self):
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index 4b99489..7209cfc 100644
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -21,6 +21,7 @@
 
 import iotests
 import os
+from iotests import blind_remove
 
 interval_length = 10
 nsec_per_sec = 1000000000
@@ -68,6 +69,7 @@ sector = "%d"
         file.close()
 
     def setUp(self):
+        blind_remove(blkdebug_file)
         drive_args = []
         drive_args.append("stats-intervals.0=%d" % interval_length)
         drive_args.append("stats-account-invalid=%s" %
@@ -84,7 +86,6 @@ sector = "%d"
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(blkdebug_file)
 
     def accounted_ops(self, read = False, write = False, flush = False):
         ops = 0
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 50cf40f..7d05bfb 100644
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -22,6 +22,7 @@
 import os
 import iotests
 import time
+from iotests import blind_remove
 
 base_img = os.path.join(iotests.test_dir, 'base.img')
 new_img = os.path.join(iotests.test_dir, 'new.img')
@@ -29,6 +30,8 @@ new_img = os.path.join(iotests.test_dir, 'new.img')
 class TestBlockdevDel(iotests.QMPTestCase):
 
     def setUp(self):
+        blind_remove(base_img)
+        blind_remove(new_img)
         iotests.qemu_img('create', '-f', iotests.imgfmt, base_img, '1M')
         self.vm = iotests.VM()
         self.vm.add_device("virtio-scsi-pci,id=virtio-scsi")
@@ -36,9 +39,6 @@ class TestBlockdevDel(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(base_img)
-        if os.path.isfile(new_img):
-            os.remove(new_img)
 
     # Check whether a BlockDriverState exists
     def checkBlockDriverState(self, node, must_exist = True):
diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index db34838..baf72d0 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -23,7 +23,7 @@ import socket
 import stat
 import time
 import iotests
-from iotests import cachemode, imgfmt, qemu_img, qemu_nbd
+from iotests import cachemode, imgfmt, qemu_img, qemu_nbd, blind_remove
 
 NBD_PORT = 10811
 
@@ -70,17 +70,14 @@ class NBDBlockdevAddBase(iotests.QMPTestCase):
 
 class QemuNBD(NBDBlockdevAddBase):
     def setUp(self):
+        blind_remove(test_img)
+        blind_remove(unix_socket)
         qemu_img('create', '-f', iotests.imgfmt, test_img, '64k')
         self.vm = iotests.VM()
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        try:
-            os.remove(unix_socket)
-        except OSError:
-            pass
 
     def _server_up(self, *args):
         self.assertEqual(qemu_nbd('-f', imgfmt, test_img, *args), 0)
@@ -105,6 +102,8 @@ class QemuNBD(NBDBlockdevAddBase):
 
 class BuiltinNBD(NBDBlockdevAddBase):
     def setUp(self):
+        blind_remove(test_img)
+        blind_remove(unix_socket)
         qemu_img('create', '-f', iotests.imgfmt, test_img, '64k')
         self.vm = iotests.VM()
         self.vm.launch()
@@ -118,11 +117,6 @@ class BuiltinNBD(NBDBlockdevAddBase):
     def tearDown(self):
         self.vm.shutdown()
         self.server.shutdown()
-        os.remove(test_img)
-        try:
-            os.remove(unix_socket)
-        except OSError:
-            pass
 
     def _server_up(self, address):
         result = self.server.qmp('nbd-server-start', addr=address)
diff --git a/tests/qemu-iotests/148 b/tests/qemu-iotests/148
index e01b061..562df85 100644
--- a/tests/qemu-iotests/148
+++ b/tests/qemu-iotests/148
@@ -21,6 +21,7 @@
 
 import os
 import iotests
+from iotests import blind_remove
 
 imgs = (os.path.join(iotests.test_dir, 'quorum0.img'),
         os.path.join(iotests.test_dir, 'quorum1.img'),
@@ -48,6 +49,9 @@ sector = "%d"
         file.close()
 
     def setUp(self):
+        for i in range(len(imgs)):
+            blind_remove(imgs[i])
+            blind_remove(img_conf[i])
         driveopts = ['driver=quorum', 'vote-threshold=2']
         driveopts.append('read-pattern=%s' % self.read_pattern)
         for i in range(len(imgs)):
@@ -64,9 +68,6 @@ sector = "%d"
 
     def tearDown(self):
         self.vm.shutdown()
-        for i in range(len(imgs)):
-            os.remove(imgs[i])
-            os.remove(img_conf[i])
 
     def do_check_event(self, node, sector = 0):
         if node == None:
diff --git a/tests/qemu-iotests/152 b/tests/qemu-iotests/152
index fec546d..b2a92db 100644
--- a/tests/qemu-iotests/152
+++ b/tests/qemu-iotests/152
@@ -20,24 +20,21 @@
 
 import os
 import iotests
-from iotests import qemu_img
+from iotests import qemu_img, blind_remove
 
 test_img = os.path.join(iotests.test_dir, 'test.img')
 target_img = os.path.join(iotests.test_dir, 'target.img')
 
 class TestUnaligned(iotests.QMPTestCase):
     def setUp(self):
+        blind_remove(test_img)
+        blind_remove(target_img)
         qemu_img('create', '-f', iotests.imgfmt, test_img, '512')
         self.vm = iotests.VM().add_drive(test_img)
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
 
     def test_unaligned(self):
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index 0b86ea4..4c0aa2e 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -23,7 +23,7 @@
 
 import os
 import iotests
-from iotests import qemu_img
+from iotests import qemu_img, blind_remove
 
 back0_img = os.path.join(iotests.test_dir, 'back0.' + iotests.imgfmt)
 back1_img = os.path.join(iotests.test_dir, 'back1.' + iotests.imgfmt)
@@ -51,6 +51,11 @@ class BaseClass(iotests.QMPTestCase):
     target_real_backing = None
 
     def setUp(self):
+        blind_remove(source_img)
+        blind_remove(back2_img)
+        blind_remove(back1_img)
+        blind_remove(back0_img)
+        blind_remove(target_img)
         qemu_img('create', '-f', iotests.imgfmt, back0_img, '1M')
         qemu_img('create', '-f', iotests.imgfmt, '-b', back0_img, back1_img)
         qemu_img('create', '-f', iotests.imgfmt, '-b', back1_img, back2_img)
@@ -95,14 +100,6 @@ class BaseClass(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(source_img)
-        os.remove(back2_img)
-        os.remove(back1_img)
-        os.remove(back0_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
 
     def findBlockNode(self, node_name, id=None):
         if id:
diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index 74d7b79..cd6fff7 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -21,7 +21,7 @@
 import os
 import re
 import iotests
-from iotests import qemu_img
+from iotests import qemu_img, blind_remove
 
 disk = os.path.join(iotests.test_dir, 'disk')
 disk_size = 0x40000000 # 1G
@@ -36,11 +36,9 @@ regions2 = ((0x10000000, 0x20000),
 class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
     def setUp(self):
+        blind_remove(disk)
         qemu_img('create', '-f', iotests.imgfmt, disk, str(disk_size))
 
-    def tearDown(self):
-        os.remove(disk)
-
     def mkVm(self):
         return iotests.VM().add_drive(disk)
 
-- 
2.9.5
