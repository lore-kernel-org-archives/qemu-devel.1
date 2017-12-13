Received: from eggs.gnu.org ([2001:4830:134:3::10]:51331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhK-0000hS-QX
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhI-0001r3-53
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:14 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 18:35:52 -0300
Message-Id: <20171213213557.26561-2-f4bug@amsat.org>
In-Reply-To: <20171213213557.26561-1-f4bug@amsat.org>
References: <20171213213557.26561-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/6] iotests.py: split BlockQMPTestCase class
 of QMPTestCase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Add a new class BlockQMPTestCase based on QMPTestCase, which only contains the
block methods. This will allow to reuse the generic methods in the next patch.

Patch created mostly mechanically.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qemu-iotests/iotests.py |  4 ++++
 tests/qemu-iotests/030        | 14 +++++++-------
 tests/qemu-iotests/040        |  2 +-
 tests/qemu-iotests/041        | 20 ++++++++++----------
 tests/qemu-iotests/044        |  2 +-
 tests/qemu-iotests/045        |  4 ++--
 tests/qemu-iotests/055        |  8 ++++----
 tests/qemu-iotests/056        |  4 ++--
 tests/qemu-iotests/057        |  2 +-
 tests/qemu-iotests/065        |  2 +-
 tests/qemu-iotests/093        |  6 +++---
 tests/qemu-iotests/096        |  2 +-
 tests/qemu-iotests/118        |  2 +-
 tests/qemu-iotests/124        |  2 +-
 tests/qemu-iotests/129        |  2 +-
 tests/qemu-iotests/132        |  2 +-
 tests/qemu-iotests/136        |  2 +-
 tests/qemu-iotests/139        |  2 +-
 tests/qemu-iotests/147        |  2 +-
 tests/qemu-iotests/148        |  2 +-
 tests/qemu-iotests/152        |  2 +-
 tests/qemu-iotests/155        |  2 +-
 tests/qemu-iotests/163        |  2 +-
 tests/qemu-iotests/165        |  2 +-
 tests/qemu-iotests/196        |  2 +-
 25 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 457984b8e9..2bb96d5ea9 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -27,7 +27,7 @@ backing_img = os.path.join(iotests.test_dir, 'backing.img')
 mid_img = os.path.join(iotests.test_dir, 'mid.img')
 test_img = os.path.join(iotests.test_dir, 'test.img')
 
-class TestSingleDrive(iotests.QMPTestCase):
+class TestSingleDrive(iotests.BlockQMPTestCase):
     image_len = 1 * 1024 * 1024 # MB
 
     def setUp(self):
@@ -153,7 +153,7 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
 
 
-class TestParallelOps(iotests.QMPTestCase):
+class TestParallelOps(iotests.BlockQMPTestCase):
     num_ops = 4 # Number of parallel block-stream operations
     num_imgs = num_ops * 2 + 1
     image_len = num_ops * 1024 * 1024
@@ -385,7 +385,7 @@ class TestParallelOps(iotests.QMPTestCase):
                          qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[3]),
                          'image file map matches backing file after streaming')
 
-class TestQuorum(iotests.QMPTestCase):
+class TestQuorum(iotests.BlockQMPTestCase):
     num_children = 3
     children = []
     backing = []
@@ -441,7 +441,7 @@ class TestQuorum(iotests.QMPTestCase):
                          qemu_io('-f', iotests.imgfmt, '-c', 'map', self.backing[0]),
                          'image file map does not match backing file after streaming')
 
-class TestSmallerBackingFile(iotests.QMPTestCase):
+class TestSmallerBackingFile(iotests.BlockQMPTestCase):
     backing_len = 1 * 1024 * 1024 # MB
     image_len = 2 * backing_len
 
@@ -464,7 +464,7 @@ class TestSmallerBackingFile(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
         self.vm.shutdown()
 
-class TestErrors(iotests.QMPTestCase):
+class TestErrors(iotests.BlockQMPTestCase):
     image_len = 2 * 1024 * 1024 # MB
 
     # this should match STREAM_BUFFER_SIZE/512 in block/stream.c
@@ -694,7 +694,7 @@ class TestENOSPC(TestErrors):
         self.assert_no_active_block_jobs()
         self.vm.shutdown()
 
-class TestStreamStop(iotests.QMPTestCase):
+class TestStreamStop(iotests.BlockQMPTestCase):
     image_len = 8 * 1024 * 1024 * 1024 # GB
 
     def setUp(self):
@@ -723,7 +723,7 @@ class TestStreamStop(iotests.QMPTestCase):
 
         self.cancel_and_wait(resume=True)
 
-class TestSetSpeed(iotests.QMPTestCase):
+class TestSetSpeed(iotests.BlockQMPTestCase):
     image_len = 80 * 1024 * 1024 # MB
 
     def setUp(self):
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 90b5b4f2ad..1da0e7afec 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -32,7 +32,7 @@ backing_img = os.path.join(iotests.test_dir, 'backing.img')
 mid_img = os.path.join(iotests.test_dir, 'mid.img')
 test_img = os.path.join(iotests.test_dir, 'test.img')
 
-class ImageCommitTestCase(iotests.QMPTestCase):
+class ImageCommitTestCase(iotests.BlockQMPTestCase):
     '''Abstract base class for image commit test cases'''
 
     def wait_for_complete(self, need_ready=False):
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index a860a31e9a..e7ff6d4ea1 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -34,7 +34,7 @@ quorum_img3 = os.path.join(iotests.test_dir, 'quorum3.img')
 quorum_repair_img = os.path.join(iotests.test_dir, 'quorum_repair.img')
 quorum_snapshot_file = os.path.join(iotests.test_dir, 'quorum_snapshot.img')
 
-class TestSingleDrive(iotests.QMPTestCase):
+class TestSingleDrive(iotests.BlockQMPTestCase):
     image_len = 1 * 1024 * 1024 # MB
     qmp_cmd = 'drive-mirror'
     qmp_target = target_img
@@ -254,7 +254,7 @@ class TestSingleDriveUnalignedLength(TestSingleDrive):
 class TestSingleBlockdevUnalignedLength(TestSingleBlockdev):
     image_len = 1025 * 1024
 
-class TestMirrorNoBacking(iotests.QMPTestCase):
+class TestMirrorNoBacking(iotests.BlockQMPTestCase):
     image_len = 2 * 1024 * 1024 # MB
 
     def setUp(self):
@@ -323,7 +323,7 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
         self.assertTrue(iotests.compare_images(test_img, target_img),
                         'target image does not match source after mirroring')
 
-class TestMirrorResized(iotests.QMPTestCase):
+class TestMirrorResized(iotests.BlockQMPTestCase):
     backing_len = 1 * 1024 * 1024 # MB
     image_len = 2 * 1024 * 1024 # MB
 
@@ -371,7 +371,7 @@ class TestMirrorResized(iotests.QMPTestCase):
         self.assertTrue(iotests.compare_images(test_img, target_img),
                         'target image does not match source after mirroring')
 
-class TestReadErrors(iotests.QMPTestCase):
+class TestReadErrors(iotests.BlockQMPTestCase):
     image_len = 2 * 1024 * 1024 # MB
 
     # this should be a multiple of twice the default granularity
@@ -526,7 +526,7 @@ new_state = "1"
         self.assert_no_active_block_jobs()
         self.vm.shutdown()
 
-class TestWriteErrors(iotests.QMPTestCase):
+class TestWriteErrors(iotests.BlockQMPTestCase):
     image_len = 2 * 1024 * 1024 # MB
 
     # this should be a multiple of twice the default granularity
@@ -653,7 +653,7 @@ new_state = "1"
         self.assert_no_active_block_jobs()
         self.vm.shutdown()
 
-class TestSetSpeed(iotests.QMPTestCase):
+class TestSetSpeed(iotests.BlockQMPTestCase):
     image_len = 80 * 1024 * 1024 # MB
 
     def setUp(self):
@@ -719,7 +719,7 @@ class TestSetSpeed(iotests.QMPTestCase):
 
         self.wait_ready_and_cancel()
 
-class TestUnbackedSource(iotests.QMPTestCase):
+class TestUnbackedSource(iotests.BlockQMPTestCase):
     image_len = 2 * 1024 * 1024 # MB
 
     def setUp(self):
@@ -760,7 +760,7 @@ class TestUnbackedSource(iotests.QMPTestCase):
         self.complete_and_wait()
         self.assert_no_active_block_jobs()
 
-class TestGranularity(iotests.QMPTestCase):
+class TestGranularity(iotests.BlockQMPTestCase):
     image_len = 10 * 1024 * 1024 # MB
 
     def setUp(self):
@@ -790,7 +790,7 @@ class TestGranularity(iotests.QMPTestCase):
         self.complete_and_wait(drive='drive0', wait_ready=False)
         self.assert_no_active_block_jobs()
 
-class TestRepairQuorum(iotests.QMPTestCase):
+class TestRepairQuorum(iotests.BlockQMPTestCase):
     """ This class test quorum file repair using drive-mirror.
         It's mostly a fork of TestSingleDrive """
     image_len = 1 * 1024 * 1024 # MB
@@ -1002,7 +1002,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
 
 # Test mirroring with a source that does not have any parents (not even a
 # BlockBackend)
-class TestOrphanedSource(iotests.QMPTestCase):
+class TestOrphanedSource(iotests.BlockQMPTestCase):
     def setUp(self):
         blk0 = { 'node-name': 'src',
                  'driver': 'null-co' }
diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
index 11ea0f4d35..4237d5187a 100755
--- a/tests/qemu-iotests/044
+++ b/tests/qemu-iotests/044
@@ -29,7 +29,7 @@ import subprocess
 
 test_img = os.path.join(iotests.test_dir, 'test.img')
 
-class TestRefcountTableGrowth(iotests.QMPTestCase):
+class TestRefcountTableGrowth(iotests.BlockQMPTestCase):
     '''Abstract base class for image mirroring test cases'''
 
     def preallocate(self, name):
diff --git a/tests/qemu-iotests/045 b/tests/qemu-iotests/045
index 6be8fc4912..c1f813b2cc 100755
--- a/tests/qemu-iotests/045
+++ b/tests/qemu-iotests/045
@@ -28,7 +28,7 @@ image2 = os.path.join(iotests.test_dir, 'image2')
 image3 = os.path.join(iotests.test_dir, 'image3')
 image4 = os.path.join(iotests.test_dir, 'image4')
 
-class TestFdSets(iotests.QMPTestCase):
+class TestFdSets(iotests.BlockQMPTestCase):
 
     def setUp(self):
         self.vm = iotests.VM()
@@ -126,7 +126,7 @@ class TestFdSets(iotests.QMPTestCase):
         self.vm.shutdown()
 
 # Add fd at runtime, there are two ways: monitor related or fdset related
-class TestSCMFd(iotests.QMPTestCase):
+class TestSCMFd(iotests.BlockQMPTestCase):
     def setUp(self):
         self.vm = iotests.VM()
         qemu_img('create', '-f', iotests.imgfmt, image0, '128K')
diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 8a5d9fd269..935c1e60a3 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -44,7 +44,7 @@ def tearDownModule():
     os.remove(test_img)
 
 
-class TestSingleDrive(iotests.QMPTestCase):
+class TestSingleDrive(iotests.BlockQMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
 
@@ -163,7 +163,7 @@ class TestSingleDrive(iotests.QMPTestCase):
                              target='drive0', sync='full')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-class TestSetSpeed(iotests.QMPTestCase):
+class TestSetSpeed(iotests.BlockQMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
 
@@ -249,7 +249,7 @@ class TestSetSpeed(iotests.QMPTestCase):
 
 # Note: We cannot use pause_drive() here, or the transaction command
 #       would stall.  Instead, we limit the block job speed here.
-class TestSingleTransaction(iotests.QMPTestCase):
+class TestSingleTransaction(iotests.BlockQMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
 
@@ -453,7 +453,7 @@ class TestSingleTransaction(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
 
-class TestDriveCompression(iotests.QMPTestCase):
+class TestDriveCompression(iotests.BlockQMPTestCase):
     image_len = 64 * 1024 * 1024 # MB
     fmt_supports_compression = [{'type': 'qcow2', 'args': ()},
                                 {'type': 'vmdk', 'args': ('-o', 'subformat=streamOptimized')}]
diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index 04f2c3c841..dedebf1a66 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -29,7 +29,7 @@ backing_img = os.path.join(iotests.test_dir, 'backing.img')
 test_img = os.path.join(iotests.test_dir, 'test.img')
 target_img = os.path.join(iotests.test_dir, 'target.img')
 
-class TestSyncModesNoneAndTop(iotests.QMPTestCase):
+class TestSyncModesNoneAndTop(iotests.BlockQMPTestCase):
     image_len = 64 * 1024 * 1024 # MB
 
     def setUp(self):
@@ -82,7 +82,7 @@ class TestSyncModesNoneAndTop(iotests.QMPTestCase):
         time.sleep(1)
         self.assertEqual(-1, qemu_io('-c', 'read -P0x41 0 512', target_img).find("verification failed"))
 
-class TestBeforeWriteNotifier(iotests.QMPTestCase):
+class TestBeforeWriteNotifier(iotests.BlockQMPTestCase):
     def setUp(self):
         self.vm = iotests.VM().add_drive_raw("file=blkdebug::null-co://,id=drive0,align=65536,driver=blkdebug")
         self.vm.launch()
diff --git a/tests/qemu-iotests/057 b/tests/qemu-iotests/057
index 9f0a5a3057..092fff8ed2 100755
--- a/tests/qemu-iotests/057
+++ b/tests/qemu-iotests/057
@@ -27,7 +27,7 @@ from iotests import qemu_img, qemu_io
 
 test_drv_base_name = 'drive'
 
-class ImageSnapshotTestCase(iotests.QMPTestCase):
+class ImageSnapshotTestCase(iotests.BlockQMPTestCase):
     image_len = 120 * 1024 * 1024 # MB
 
     def __init__(self, *args):
diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index 72aa9707c7..a30f117a2e 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -28,7 +28,7 @@ import unittest
 
 test_img = os.path.join(iotests.test_dir, 'test.img')
 
-class TestImageInfoSpecific(iotests.QMPTestCase):
+class TestImageInfoSpecific(iotests.BlockQMPTestCase):
     '''Abstract base class for ImageInfoSpecific tests'''
 
     def setUp(self):
diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index 5c36a5fb4d..c8bca994ba 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -23,7 +23,7 @@ import iotests
 
 nsec_per_sec = 1000000000
 
-class ThrottleTestCase(iotests.QMPTestCase):
+class ThrottleTestCase(iotests.BlockQMPTestCase):
     test_img = "null-aio://"
     max_drives = 3
 
@@ -211,7 +211,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
 class ThrottleTestCoroutine(ThrottleTestCase):
     test_img = "null-co://"
 
-class ThrottleTestGroupNames(iotests.QMPTestCase):
+class ThrottleTestGroupNames(iotests.BlockQMPTestCase):
     test_img = "null-aio://"
     max_drives = 3
 
@@ -308,7 +308,7 @@ class ThrottleTestGroupNames(iotests.QMPTestCase):
             groupname = "group%d" % i
             self.verify_name(devname, groupname)
 
-class ThrottleTestRemovableMedia(iotests.QMPTestCase):
+class ThrottleTestRemovableMedia(iotests.BlockQMPTestCase):
     def setUp(self):
         self.vm = iotests.VM()
         if iotests.qemu_default_machine == 's390-ccw-virtio':
diff --git a/tests/qemu-iotests/096 b/tests/qemu-iotests/096
index aeeb3753cf..21368455e5 100644
--- a/tests/qemu-iotests/096
+++ b/tests/qemu-iotests/096
@@ -22,7 +22,7 @@
 import iotests
 import os
 
-class TestLiveSnapshot(iotests.QMPTestCase):
+class TestLiveSnapshot(iotests.BlockQMPTestCase):
     base_img = os.path.join(iotests.test_dir, 'base.img')
     target_img = os.path.join(iotests.test_dir, 'target.img')
     group = 'mygroup'
diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index 8a9e838c90..5fccfd6bff 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -28,7 +28,7 @@ from iotests import qemu_img
 old_img = os.path.join(iotests.test_dir, 'test0.img')
 new_img = os.path.join(iotests.test_dir, 'test1.img')
 
-class ChangeBaseClass(iotests.QMPTestCase):
+class ChangeBaseClass(iotests.BlockQMPTestCase):
     has_opened = False
     has_closed = False
 
diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index 8e76e62f93..94a04caa51 100644
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -91,7 +91,7 @@ class Bitmap:
                 try_remove(image)
 
 
-class TestIncrementalBackupBase(iotests.QMPTestCase):
+class TestIncrementalBackupBase(iotests.BlockQMPTestCase):
     def __init__(self, *args):
         super(TestIncrementalBackupBase, self).__init__(*args)
         self.bitmaps = list()
diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index 9e87e1c8d9..4201094bc1 100644
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -22,7 +22,7 @@ import os
 import iotests
 import time
 
-class TestStopWithBlockJob(iotests.QMPTestCase):
+class TestStopWithBlockJob(iotests.BlockQMPTestCase):
     test_img = os.path.join(iotests.test_dir, 'test.img')
     target_img = os.path.join(iotests.test_dir, 'target.img')
     base_img = os.path.join(iotests.test_dir, 'base.img')
diff --git a/tests/qemu-iotests/132 b/tests/qemu-iotests/132
index f53ef6e391..ec18274424 100644
--- a/tests/qemu-iotests/132
+++ b/tests/qemu-iotests/132
@@ -26,7 +26,7 @@ from iotests import qemu_img, qemu_io
 test_img = os.path.join(iotests.test_dir, 'test.img')
 target_img = os.path.join(iotests.test_dir, 'target.img')
 
-class TestSingleDrive(iotests.QMPTestCase):
+class TestSingleDrive(iotests.BlockQMPTestCase):
     image_len = 2 * 1024 * 1024 # MB
 
     def setUp(self):
diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index 88b97ea7c6..76ce358ea6 100644
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -29,7 +29,7 @@ bad_sector = 8192
 bad_offset = bad_sector * 512
 blkdebug_file = os.path.join(iotests.test_dir, 'blkdebug.conf')
 
-class BlockDeviceStatsTestCase(iotests.QMPTestCase):
+class BlockDeviceStatsTestCase(iotests.BlockQMPTestCase):
     test_img = "null-aio://"
     total_rd_bytes = 0
     total_rd_ops = 0
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index f8f02808a9..57457a8eab 100644
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -30,7 +30,7 @@ if iotests.qemu_default_machine == 's390-ccw-virtio':
 else:
     default_virtio_blk = 'virtio-blk-pci'
 
-class TestBlockdevDel(iotests.QMPTestCase):
+class TestBlockdevDel(iotests.BlockQMPTestCase):
 
     def setUp(self):
         iotests.qemu_img('create', '-f', iotests.imgfmt, base_img, '1M')
diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 90f40ed245..03603ca0ea 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -37,7 +37,7 @@ def flatten_sock_addr(crumpled_address):
     return result
 
 
-class NBDBlockdevAddBase(iotests.QMPTestCase):
+class NBDBlockdevAddBase(iotests.BlockQMPTestCase):
     def blockdev_add_options(self, address, export=None):
         options = { 'node-name': 'nbd-blockdev',
                     'driver': 'raw',
diff --git a/tests/qemu-iotests/148 b/tests/qemu-iotests/148
index e01b061fe7..1b1153e4d8 100644
--- a/tests/qemu-iotests/148
+++ b/tests/qemu-iotests/148
@@ -34,7 +34,7 @@ event_rate = 1000000000
 sector_size = 512
 offset = 10
 
-class TestQuorumEvents(iotests.QMPTestCase):
+class TestQuorumEvents(iotests.BlockQMPTestCase):
     read_pattern = 'quorum'
 
     def create_blkdebug_file(self, blkdebug_file, bad_sector):
diff --git a/tests/qemu-iotests/152 b/tests/qemu-iotests/152
index fec546d033..f949a9a5cf 100644
--- a/tests/qemu-iotests/152
+++ b/tests/qemu-iotests/152
@@ -25,7 +25,7 @@ from iotests import qemu_img
 test_img = os.path.join(iotests.test_dir, 'test.img')
 target_img = os.path.join(iotests.test_dir, 'target.img')
 
-class TestUnaligned(iotests.QMPTestCase):
+class TestUnaligned(iotests.BlockQMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, test_img, '512')
         self.vm = iotests.VM().add_drive(test_img)
diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index 0b86ea4e5c..5314205b72 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -46,7 +46,7 @@ target_img = os.path.join(iotests.test_dir, 'target.' + iotests.imgfmt)
 #                      target_blockdev_backing is not None
 #                      (None: same as target_backing)
 
-class BaseClass(iotests.QMPTestCase):
+class BaseClass(iotests.BlockQMPTestCase):
     target_blockdev_backing = None
     target_real_backing = None
 
diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
index 403842354e..b2ca3fa7d8 100644
--- a/tests/qemu-iotests/163
+++ b/tests/qemu-iotests/163
@@ -28,7 +28,7 @@ def size_to_int(str):
     suff = ['B', 'K', 'M', 'G', 'T']
     return int(str[:-1]) * 1024**suff.index(str[-1:])
 
-class ShrinkBaseClass(iotests.QMPTestCase):
+class ShrinkBaseClass(iotests.BlockQMPTestCase):
     image_len = '128M'
     shrink_size = '10M'
     chunk_size = '16M'
diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index a3932db3de..31b4e3e562 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -33,7 +33,7 @@ regions1 = ((0x0fff00, 0x10000),
 regions2 = ((0x10000000, 0x20000),
             (0x3fff0000, 0x10000))
 
-class TestPersistentDirtyBitmap(iotests.QMPTestCase):
+class TestPersistentDirtyBitmap(iotests.BlockQMPTestCase):
 
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, disk, str(disk_size))
diff --git a/tests/qemu-iotests/196 b/tests/qemu-iotests/196
index 4116ebc92b..9c06095ac4 100755
--- a/tests/qemu-iotests/196
+++ b/tests/qemu-iotests/196
@@ -26,7 +26,7 @@ from iotests import qemu_img
 disk = os.path.join(iotests.test_dir, 'disk')
 migfile = os.path.join(iotests.test_dir, 'migfile')
 
-class TestInvalidateAutoclear(iotests.QMPTestCase):
+class TestInvalidateAutoclear(iotests.BlockQMPTestCase):
 
     def tearDown(self):
         self.vm_a.shutdown()
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 6f057904a9..e1f892c46f 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -315,6 +315,10 @@ class QMPTestCase(unittest.TestCase):
         result = self.dictpath(d, path)
         self.assertEqual(result, value, 'values not equal "%s" and "%s"' % (str(result), str(value)))
 
+
+class BlockQMPTestCase(QMPTestCase):
+    '''Abstract base class for Block QMP test cases'''
+
     def assert_no_active_block_jobs(self):
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return', [])
-- 
2.15.1
