Received: from eggs.gnu.org ([2001:4830:134:3::10]:41981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4Unx-0007Z0-BA
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4Unl-0007Em-7O
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:33:21 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 17 Oct 2017 12:31:53 -0400
Message-Id: <4a332a99c2dd670f119bd1f0b8e6ff98f4ff9193.1508257445.git.jcody@redhat.com>
In-Reply-To: <cover.1508257445.git.jcody@redhat.com>
References: <cover.1508257445.git.jcody@redhat.com>
In-Reply-To: <cover.1508257445.git.jcody@redhat.com>
References: <cover.1508257445.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v5 08/10] qemu-iotests: modify python tests to
 run from subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com

Also removes any intermediate file deletion; this is no longer needed,
as 'check' will take care of that once the test is completed (unless
the user requests to save files on failure, and the test fails)

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/030 |  82 ++++++------
 tests/qemu-iotests/040 | 128 +++++++++----------
 tests/qemu-iotests/041 | 333 +++++++++++++++++++++++++------------------------
 tests/qemu-iotests/044 |  11 +-
 tests/qemu-iotests/045 |  42 +++----
 tests/qemu-iotests/055 |  97 +++++++-------
 tests/qemu-iotests/056 |  39 +++---
 tests/qemu-iotests/057 |   4 +-
 tests/qemu-iotests/065 |  13 +-
 tests/qemu-iotests/096 |   8 +-
 tests/qemu-iotests/118 | 200 ++++++++++++++---------------
 tests/qemu-iotests/124 |  24 ++--
 tests/qemu-iotests/129 |   6 +-
 tests/qemu-iotests/132 |  19 ++-
 tests/qemu-iotests/136 |   7 +-
 tests/qemu-iotests/139 |  33 +++--
 tests/qemu-iotests/147 |  41 +++---
 tests/qemu-iotests/148 |  33 +++--
 tests/qemu-iotests/152 |  21 ++--
 tests/qemu-iotests/155 |  54 ++++----
 tests/qemu-iotests/163 |  42 +++----
 tests/qemu-iotests/165 |  11 +-
 22 files changed, 581 insertions(+), 667 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 1883894..6e52509 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -23,27 +23,24 @@ import os
 import iotests
 from iotests import qemu_img, qemu_io
 
-backing_img = os.path.join(iotests.test_dir, 'backing.img')
-mid_img = os.path.join(iotests.test_dir, 'mid.img')
-test_img = os.path.join(iotests.test_dir, 'test.img')
 
 class TestSingleDrive(iotests.QMPTestCase):
     image_len = 1 * 1024 * 1024 # MB
 
     def setUp(self):
-        iotests.create_image(backing_img, TestSingleDrive.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, mid_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % mid_img, test_img)
-        qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 512', backing_img)
-        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 524288 512', mid_img)
-        self.vm = iotests.VM().add_drive("blkdebug::" + test_img, "backing.node-name=mid")
+        self.backing_img = os.path.join(self.workdir, 'backing.img')
+        self.mid_img = os.path.join(self.workdir, 'mid.img')
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        iotests.create_image(self.backing_img, TestSingleDrive.image_len)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.backing_img, self.mid_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.mid_img, self.test_img)
+        qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 512', self.backing_img)
+        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 524288 512', self.mid_img)
+        self.vm = iotests.VM().add_drive("blkdebug::" + self.test_img, "backing.node-name=mid")
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(mid_img)
-        os.remove(backing_img)
 
     def test_stream(self):
         self.assert_no_active_block_jobs()
@@ -56,15 +53,15 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
         self.vm.shutdown()
 
-        self.assertEqual(qemu_io('-f', 'raw', '-c', 'map', backing_img),
-                         qemu_io('-f', iotests.imgfmt, '-c', 'map', test_img),
+        self.assertEqual(qemu_io('-f', 'raw', '-c', 'map', self.backing_img),
+                         qemu_io('-f', iotests.imgfmt, '-c', 'map', self.test_img),
                          'image file map does not match backing file after streaming')
 
     def test_stream_intermediate(self):
         self.assert_no_active_block_jobs()
 
-        self.assertNotEqual(qemu_io('-f', 'raw', '-rU', '-c', 'map', backing_img),
-                            qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', mid_img),
+        self.assertNotEqual(qemu_io('-f', 'raw', '-rU', '-c', 'map', self.backing_img),
+                            qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.mid_img),
                             'image file map matches backing file before streaming')
 
         result = self.vm.qmp('block-stream', device='mid', job_id='stream-mid')
@@ -75,8 +72,8 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
         self.vm.shutdown()
 
-        self.assertEqual(qemu_io('-f', 'raw', '-c', 'map', backing_img),
-                         qemu_io('-f', iotests.imgfmt, '-c', 'map', mid_img),
+        self.assertEqual(qemu_io('-f', 'raw', '-c', 'map', self.backing_img),
+                         qemu_io('-f', iotests.imgfmt, '-c', 'map', self.mid_img),
                          'image file map does not match backing file after streaming')
 
     def test_stream_pause(self):
@@ -107,18 +104,18 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
         self.vm.shutdown()
 
-        self.assertEqual(qemu_io('-f', 'raw', '-c', 'map', backing_img),
-                         qemu_io('-f', iotests.imgfmt, '-c', 'map', test_img),
+        self.assertEqual(qemu_io('-f', 'raw', '-c', 'map', self.backing_img),
+                         qemu_io('-f', iotests.imgfmt, '-c', 'map', self.test_img),
                          'image file map does not match backing file after streaming')
 
     def test_stream_no_op(self):
         self.assert_no_active_block_jobs()
 
         # The image map is empty before the operation
-        empty_map = qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', test_img)
+        empty_map = qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.test_img)
 
         # This is a no-op: no data should ever be copied from the base image
-        result = self.vm.qmp('block-stream', device='drive0', base=mid_img)
+        result = self.vm.qmp('block-stream', device='drive0', base=self.mid_img)
         self.assert_qmp(result, 'return', {})
 
         self.wait_until_completed()
@@ -126,13 +123,13 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
         self.vm.shutdown()
 
-        self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', test_img),
+        self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', self.test_img),
                          empty_map, 'image file map changed after a no-op')
 
     def test_stream_partial(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0', base=backing_img)
+        result = self.vm.qmp('block-stream', device='drive0', base=self.backing_img)
         self.assert_qmp(result, 'return', {})
 
         self.wait_until_completed()
@@ -140,8 +137,8 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
         self.vm.shutdown()
 
-        self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', mid_img),
-                         qemu_io('-f', iotests.imgfmt, '-c', 'map', test_img),
+        self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', self.mid_img),
+                         qemu_io('-f', iotests.imgfmt, '-c', 'map', self.test_img),
                          'image file map does not match backing file after streaming')
 
     def test_device_not_found(self):
@@ -157,7 +154,6 @@ class TestParallelOps(iotests.QMPTestCase):
     num_ops = 4 # Number of parallel block-stream operations
     num_imgs = num_ops * 2 + 1
     image_len = num_ops * 1024 * 1024
-    imgs = []
 
     def setUp(self):
         opts = []
@@ -167,7 +163,7 @@ class TestParallelOps(iotests.QMPTestCase):
         for i in range(self.num_imgs):
             img_depth = self.num_imgs - i - 1
             opts.append("backing." * img_depth + "node-name=node%d" % i)
-            self.imgs.append(os.path.join(iotests.test_dir, 'img-%d.img' % i))
+            self.imgs.append(os.path.join(self.workdir, 'img-%d.img' % i))
 
         # Create all images
         iotests.create_image(self.imgs[0], self.image_len)
@@ -192,8 +188,6 @@ class TestParallelOps(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        for img in self.imgs:
-            os.remove(img)
 
     # Test that it's possible to run several block-stream operations
     # in parallel in the same snapshot chain
@@ -395,8 +389,8 @@ class TestQuorum(iotests.QMPTestCase):
 
         # Initialize file names and command-line options
         for i in range(self.num_children):
-            child_img = os.path.join(iotests.test_dir, 'img-%d.img' % i)
-            backing_img = os.path.join(iotests.test_dir, 'backing-%d.img' % i)
+            child_img = os.path.join(self.workdir, 'img-%d.img' % i)
+            backing_img = os.path.join(self.workdir, 'backing-%d.img' % i)
             self.children.append(child_img)
             self.backing.append(backing_img)
             qemu_img('create', '-f', iotests.imgfmt, backing_img, '1M')
@@ -414,10 +408,6 @@ class TestQuorum(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        for img in self.children:
-            os.remove(img)
-        for img in self.backing:
-            os.remove(img)
 
     def test_stream_quorum(self):
         if not iotests.supports_quorum():
@@ -446,6 +436,8 @@ class TestSmallerBackingFile(iotests.QMPTestCase):
     image_len = 2 * backing_len
 
     def setUp(self):
+        backing_img = os.path.join(self.workdir, 'backing.img')
+        test_img = os.path.join(self.workdir, 'test.img')
         iotests.create_image(backing_img, self.backing_len)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img, str(self.image_len))
         self.vm = iotests.VM().add_drive(test_img)
@@ -495,6 +487,8 @@ new_state = "1"
 
 class TestEIO(TestErrors):
     def setUp(self):
+        backing_img = os.path.join(self.workdir, 'backing.img')
+        test_img = os.path.join(self.workdir, 'test.img')
         self.blkdebug_file = backing_img + ".blkdebug"
         iotests.create_image(backing_img, TestErrors.image_len)
         self.create_blkdebug_file(self.blkdebug_file, "read_aio", 5)
@@ -507,9 +501,6 @@ class TestEIO(TestErrors):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
-        os.remove(self.blkdebug_file)
 
     def test_report(self):
         self.assert_no_active_block_jobs()
@@ -637,6 +628,8 @@ class TestEIO(TestErrors):
 
 class TestENOSPC(TestErrors):
     def setUp(self):
+        backing_img = os.path.join(self.workdir, 'backing.img')
+        test_img = os.path.join(self.workdir, 'test.img')
         self.blkdebug_file = backing_img + ".blkdebug"
         iotests.create_image(backing_img, TestErrors.image_len)
         self.create_blkdebug_file(self.blkdebug_file, "read_aio", 28)
@@ -649,9 +642,6 @@ class TestENOSPC(TestErrors):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
-        os.remove(self.blkdebug_file)
 
     def test_enospc(self):
         self.assert_no_active_block_jobs()
@@ -695,6 +685,8 @@ class TestStreamStop(iotests.QMPTestCase):
     image_len = 8 * 1024 * 1024 * 1024 # GB
 
     def setUp(self):
+        backing_img = os.path.join(self.workdir, 'backing.img')
+        test_img = os.path.join(self.workdir, 'test.img')
         qemu_img('create', backing_img, str(TestStreamStop.image_len))
         qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 32M', backing_img)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
@@ -704,8 +696,6 @@ class TestStreamStop(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
 
     def test_stream_stop(self):
         self.assert_no_active_block_jobs()
@@ -724,6 +714,8 @@ class TestSetSpeed(iotests.QMPTestCase):
     image_len = 80 * 1024 * 1024 # MB
 
     def setUp(self):
+        backing_img = os.path.join(self.workdir, 'backing.img')
+        test_img = os.path.join(self.workdir, 'test.img')
         qemu_img('create', backing_img, str(TestSetSpeed.image_len))
         qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 32M', backing_img)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
@@ -733,8 +725,6 @@ class TestSetSpeed(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
 
     # This is a short performance test which is not run by default.
     # Invoke "IMGFMT=qed ./030 TestSetSpeed.perf_test_throughput"
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index c284d08..c4ba9bb 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -28,9 +28,6 @@ from iotests import qemu_img, qemu_io
 import struct
 import errno
 
-backing_img = os.path.join(iotests.test_dir, 'backing.img')
-mid_img = os.path.join(iotests.test_dir, 'mid.img')
-test_img = os.path.join(iotests.test_dir, 'test.img')
 
 class ImageCommitTestCase(iotests.QMPTestCase):
     '''Abstract base class for image commit test cases'''
@@ -76,12 +73,15 @@ class TestSingleDrive(ImageCommitTestCase):
     test_len = 1 * 1024 * 256
 
     def setUp(self):
-        iotests.create_image(backing_img, self.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, mid_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % mid_img, test_img)
-        qemu_io('-f', 'raw', '-c', 'write -P 0xab 0 524288', backing_img)
-        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288', mid_img)
-        self.vm = iotests.VM().add_drive(test_img, "node-name=top,backing.node-name=mid,backing.backing.node-name=base", interface="none")
+        self.backing_img = os.path.join(self.workdir, 'backing.img')
+        self.mid_img = os.path.join(self.workdir, 'mid.img')
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        iotests.create_image(self.backing_img, self.image_len)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.backing_img, self.mid_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.mid_img, self.test_img)
+        qemu_io('-f', 'raw', '-c', 'write -P 0xab 0 524288', self.backing_img)
+        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288', self.mid_img)
+        self.vm = iotests.VM().add_drive(self.test_img, "node-name=top,backing.node-name=mid,backing.backing.node-name=base", interface="none")
         if iotests.qemu_default_machine == 's390-ccw-virtio':
             self.vm.add_device("virtio-scsi-ccw")
         else:
@@ -92,52 +92,49 @@ class TestSingleDrive(ImageCommitTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(mid_img)
-        os.remove(backing_img)
 
     def test_commit(self):
-        self.run_commit_test(mid_img, backing_img)
-        self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 524288', backing_img).find("verification failed"))
-        self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xef 524288 524288', backing_img).find("verification failed"))
+        self.run_commit_test(self.mid_img, self.backing_img)
+        self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 524288', self.backing_img).find("verification failed"))
+        self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xef 524288 524288', self.backing_img).find("verification failed"))
 
     def test_device_not_found(self):
-        result = self.vm.qmp('block-commit', device='nonexistent', top='%s' % mid_img)
+        result = self.vm.qmp('block-commit', device='nonexistent', top='%s' % self.mid_img)
         self.assert_qmp(result, 'error/class', 'DeviceNotFound')
 
     def test_top_same_base(self):
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('block-commit', device='drive0', top='%s' % backing_img, base='%s' % backing_img)
+        result = self.vm.qmp('block-commit', device='drive0', top='%s' % self.backing_img, base='%s' % self.backing_img)
         self.assert_qmp(result, 'error/class', 'GenericError')
-        self.assert_qmp(result, 'error/desc', 'Base \'%s\' not found' % backing_img)
+        self.assert_qmp(result, 'error/desc', 'Base \'%s\' not found' % self.backing_img)
 
     def test_top_invalid(self):
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('block-commit', device='drive0', top='badfile', base='%s' % backing_img)
+        result = self.vm.qmp('block-commit', device='drive0', top='badfile', base='%s' % self.backing_img)
         self.assert_qmp(result, 'error/class', 'GenericError')
         self.assert_qmp(result, 'error/desc', 'Top image file badfile not found')
 
     def test_base_invalid(self):
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('block-commit', device='drive0', top='%s' % mid_img, base='badfile')
+        result = self.vm.qmp('block-commit', device='drive0', top='%s' % self.mid_img, base='badfile')
         self.assert_qmp(result, 'error/class', 'GenericError')
         self.assert_qmp(result, 'error/desc', 'Base \'badfile\' not found')
 
     def test_top_is_active(self):
-        self.run_commit_test(test_img, backing_img, need_ready=True)
-        self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 524288', backing_img).find("verification failed"))
-        self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xef 524288 524288', backing_img).find("verification failed"))
+        self.run_commit_test(self.test_img, self.backing_img, need_ready=True)
+        self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 524288', self.backing_img).find("verification failed"))
+        self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xef 524288 524288', self.backing_img).find("verification failed"))
 
     def test_top_is_default_active(self):
         self.run_default_commit_test()
-        self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 524288', backing_img).find("verification failed"))
-        self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xef 524288 524288', backing_img).find("verification failed"))
+        self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 524288', self.backing_img).find("verification failed"))
+        self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xef 524288 524288', self.backing_img).find("verification failed"))
 
     def test_top_and_base_reversed(self):
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('block-commit', device='drive0', top='%s' % backing_img, base='%s' % mid_img)
+        result = self.vm.qmp('block-commit', device='drive0', top='%s' % self.backing_img, base='%s' % self.mid_img)
         self.assert_qmp(result, 'error/class', 'GenericError')
-        self.assert_qmp(result, 'error/desc', 'Base \'%s\' not found' % mid_img)
+        self.assert_qmp(result, 'error/desc', 'Base \'%s\' not found' % self.mid_img)
 
     # When the job is running on a BB that is automatically deleted on hot
     # unplug, the job is cancelled when the device disappears
@@ -146,8 +143,8 @@ class TestSingleDrive(ImageCommitTestCase):
             return
 
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('block-commit', device='drive0', top=mid_img,
-                             base=backing_img, speed=(self.image_len / 4))
+        result = self.vm.qmp('block-commit', device='drive0', top=self.mid_img,
+                             base=self.backing_img, speed=(self.image_len / 4))
         self.assert_qmp(result, 'return', {})
         result = self.vm.qmp('device_del', id='scsi0')
         self.assert_qmp(result, 'return', {})
@@ -174,18 +171,18 @@ class TestSingleDrive(ImageCommitTestCase):
             return
 
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('block-commit', device='drive0', top=mid_img,
-                             base=backing_img, speed=(self.image_len / 4))
+        result = self.vm.qmp('block-commit', device='drive0', top=self.mid_img,
+                             base=self.backing_img, speed=(self.image_len / 4))
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/file', test_img)
+        self.assert_qmp(result, 'return[0]/inserted/file', self.test_img)
         self.assert_qmp(result, 'return[0]/inserted/drv', iotests.imgfmt)
-        self.assert_qmp(result, 'return[0]/inserted/backing_file', mid_img)
+        self.assert_qmp(result, 'return[0]/inserted/backing_file', self.mid_img)
         self.assert_qmp(result, 'return[0]/inserted/backing_file_depth', 2)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', test_img)
-        self.assert_qmp(result, 'return[0]/inserted/image/backing-image/filename', mid_img)
-        self.assert_qmp(result, 'return[0]/inserted/image/backing-image/backing-image/filename', backing_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.test_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/backing-image/filename', self.mid_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/backing-image/backing-image/filename', self.backing_img)
 
         result = self.vm.qmp('query-blockstats')
         self.assert_qmp(result, 'return[0]/node-name', 'top')
@@ -202,19 +199,24 @@ class TestRelativePaths(ImageCommitTestCase):
     dir1 = "dir1"
     dir2 = "dir2/"
     dir3 = "dir2/dir3/"
+    backing_img = ""
+    mid_img = ""
+    test_img = ""
+    backing_img_abs = ""
+    mid_img_abs = ""
 
-    test_img = os.path.join(iotests.test_dir, dir3, 'test.img')
     mid_img = "../mid.img"
     backing_img = "../dir1/backing.img"
 
-    backing_img_abs = os.path.join(iotests.test_dir, dir1, 'backing.img')
-    mid_img_abs = os.path.join(iotests.test_dir, dir2, 'mid.img')
 
     def setUp(self):
+        self.test_img = os.path.join(self.workdir, self.dir3, 'test.img')
+        self.backing_img_abs = os.path.join(self.workdir, self.dir1, 'backing.img')
+        self.mid_img_abs = os.path.join(self.workdir, self.dir2, 'mid.img')
         try:
-            os.mkdir(os.path.join(iotests.test_dir, self.dir1))
-            os.mkdir(os.path.join(iotests.test_dir, self.dir2))
-            os.mkdir(os.path.join(iotests.test_dir, self.dir3))
+            os.mkdir(os.path.join(self.workdir, self.dir1))
+            os.mkdir(os.path.join(self.workdir, self.dir2))
+            os.mkdir(os.path.join(self.workdir, self.dir3))
         except OSError as exception:
             if exception.errno != errno.EEXIST:
                 raise
@@ -230,16 +232,6 @@ class TestRelativePaths(ImageCommitTestCase):
 
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
@@ -284,25 +276,25 @@ class TestSetSpeed(ImageCommitTestCase):
     image_len = 80 * 1024 * 1024 # MB
 
     def setUp(self):
-        qemu_img('create', backing_img, str(TestSetSpeed.image_len))
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, mid_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % mid_img, test_img)
-        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 0 512', test_img)
-        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288', mid_img)
-        self.vm = iotests.VM().add_drive(test_img)
+        self.backing_img = os.path.join(self.workdir, 'backing.img')
+        self.mid_img = os.path.join(self.workdir, 'mid.img')
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        qemu_img('create', self.backing_img, str(TestSetSpeed.image_len))
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.backing_img, self.mid_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.mid_img, self.test_img)
+        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 0 512', self.test_img)
+        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288', self.mid_img)
+        self.vm = iotests.VM().add_drive(self.test_img)
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(mid_img)
-        os.remove(backing_img)
 
     def test_set_speed(self):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp('block-commit', device='drive0', top=mid_img, speed=1024 * 1024)
+        result = self.vm.qmp('block-commit', device='drive0', top=self.mid_img, speed=1024 * 1024)
         self.assert_qmp(result, 'return', {})
 
         # Ensure the speed we set was accepted
@@ -317,12 +309,12 @@ class TestActiveZeroLengthImage(TestSingleDrive):
 
 class TestReopenOverlay(ImageCommitTestCase):
     image_len = 1024 * 1024
-    img0 = os.path.join(iotests.test_dir, '0.img')
-    img1 = os.path.join(iotests.test_dir, '1.img')
-    img2 = os.path.join(iotests.test_dir, '2.img')
-    img3 = os.path.join(iotests.test_dir, '3.img')
 
     def setUp(self):
+        self.img0 = os.path.join(self.workdir, '0.img')
+        self.img1 = os.path.join(self.workdir, '1.img')
+        self.img2 = os.path.join(self.workdir, '2.img')
+        self.img3 = os.path.join(self.workdir, '3.img')
         iotests.create_image(self.img0, self.image_len)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.img0, self.img1)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.img1, self.img2)
@@ -333,10 +325,6 @@ class TestReopenOverlay(ImageCommitTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(self.img0)
-        os.remove(self.img1)
-        os.remove(self.img2)
-        os.remove(self.img3)
 
     # This tests what happens when the overlay image of the 'top' node
     # needs to be reopened in read-write mode in order to update the
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index a860a31..3b73f11 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -23,38 +23,26 @@ import os
 import iotests
 from iotests import qemu_img, qemu_io
 
-backing_img = os.path.join(iotests.test_dir, 'backing.img')
-target_backing_img = os.path.join(iotests.test_dir, 'target-backing.img')
-test_img = os.path.join(iotests.test_dir, 'test.img')
-target_img = os.path.join(iotests.test_dir, 'target.img')
-
-quorum_img1 = os.path.join(iotests.test_dir, 'quorum1.img')
-quorum_img2 = os.path.join(iotests.test_dir, 'quorum2.img')
-quorum_img3 = os.path.join(iotests.test_dir, 'quorum3.img')
-quorum_repair_img = os.path.join(iotests.test_dir, 'quorum_repair.img')
-quorum_snapshot_file = os.path.join(iotests.test_dir, 'quorum_snapshot.img')
 
 class TestSingleDrive(iotests.QMPTestCase):
     image_len = 1 * 1024 * 1024 # MB
     qmp_cmd = 'drive-mirror'
-    qmp_target = target_img
 
     def setUp(self):
-        iotests.create_image(backing_img, self.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
-        self.vm = iotests.VM().add_drive(test_img, "node-name=top,backing.node-name=base")
+        self.backing_img = os.path.join(self.workdir, 'backing.img')
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        self.qmp_target = self.target_img
+        iotests.create_image(self.backing_img, self.image_len)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.backing_img, self.test_img)
+        self.vm = iotests.VM().add_drive(self.test_img, "node-name=top,backing.node-name=base")
         if iotests.qemu_default_machine == 'pc':
             self.vm.add_drive(None, 'media=cdrom', 'ide')
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
+        pass
 
     def test_complete(self):
         self.assert_no_active_block_jobs()
@@ -65,9 +53,9 @@ class TestSingleDrive(iotests.QMPTestCase):
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/file', target_img)
+        self.assert_qmp(result, 'return[0]/inserted/file', self.target_img)
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after mirroring')
 
     def test_cancel(self):
@@ -79,7 +67,7 @@ class TestSingleDrive(iotests.QMPTestCase):
 
         self.cancel_and_wait(force=True)
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/file', test_img)
+        self.assert_qmp(result, 'return[0]/inserted/file', self.test_img)
         self.vm.shutdown()
 
     def test_cancel_after_ready(self):
@@ -91,9 +79,9 @@ class TestSingleDrive(iotests.QMPTestCase):
 
         self.wait_ready_and_cancel()
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/file', test_img)
+        self.assert_qmp(result, 'return[0]/inserted/file', self.test_img)
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after mirroring')
 
     def test_pause(self):
@@ -117,7 +105,7 @@ class TestSingleDrive(iotests.QMPTestCase):
 
         self.complete_and_wait()
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after mirroring')
 
     def test_small_buffer(self):
@@ -130,41 +118,41 @@ class TestSingleDrive(iotests.QMPTestCase):
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/file', target_img)
+        self.assert_qmp(result, 'return[0]/inserted/file', self.target_img)
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after mirroring')
 
     def test_small_buffer2(self):
         self.assert_no_active_block_jobs()
 
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=%d,size=%d'
-                        % (self.image_len, self.image_len), target_img)
+                        % (self.image_len, self.image_len), self.target_img)
         result = self.vm.qmp(self.qmp_cmd, device='drive0', sync='full',
                              buf_size=65536, mode='existing', target=self.qmp_target)
         self.assert_qmp(result, 'return', {})
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/file', target_img)
+        self.assert_qmp(result, 'return[0]/inserted/file', self.target_img)
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after mirroring')
 
     def test_large_cluster(self):
         self.assert_no_active_block_jobs()
 
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=%d,backing_file=%s'
-                        % (self.image_len, backing_img), target_img)
+                        % (self.image_len, self.backing_img), self.target_img)
         result = self.vm.qmp(self.qmp_cmd, device='drive0', sync='full',
                              mode='existing', target=self.qmp_target)
         self.assert_qmp(result, 'return', {})
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/file', target_img)
+        self.assert_qmp(result, 'return[0]/inserted/file', self.target_img)
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after mirroring')
 
     # Tests that the insertion of the mirror_top filter node doesn't make a
@@ -177,12 +165,12 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/file', test_img)
+        self.assert_qmp(result, 'return[0]/inserted/file', self.test_img)
         self.assert_qmp(result, 'return[0]/inserted/drv', iotests.imgfmt)
-        self.assert_qmp(result, 'return[0]/inserted/backing_file', backing_img)
+        self.assert_qmp(result, 'return[0]/inserted/backing_file', self.backing_img)
         self.assert_qmp(result, 'return[0]/inserted/backing_file_depth', 1)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', test_img)
-        self.assert_qmp(result, 'return[0]/inserted/image/backing-image/filename', backing_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.test_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/backing-image/filename', self.backing_img)
 
         result = self.vm.qmp('query-blockstats')
         self.assert_qmp(result, 'return[0]/node-name', 'top')
@@ -190,12 +178,12 @@ class TestSingleDrive(iotests.QMPTestCase):
 
         self.cancel_and_wait(force=True)
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/file', test_img)
+        self.assert_qmp(result, 'return[0]/inserted/file', self.test_img)
         self.assert_qmp(result, 'return[0]/inserted/drv', iotests.imgfmt)
-        self.assert_qmp(result, 'return[0]/inserted/backing_file', backing_img)
+        self.assert_qmp(result, 'return[0]/inserted/backing_file', self.backing_img)
         self.assert_qmp(result, 'return[0]/inserted/backing_file_depth', 1)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', test_img)
-        self.assert_qmp(result, 'return[0]/inserted/image/backing-image/filename', backing_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.test_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/backing-image/filename', self.backing_img)
 
         result = self.vm.qmp('query-blockstats')
         self.assert_qmp(result, 'return[0]/node-name', 'top')
@@ -223,14 +211,14 @@ class TestSingleDrive(iotests.QMPTestCase):
 
 class TestSingleBlockdev(TestSingleDrive):
     qmp_cmd = 'blockdev-mirror'
-    qmp_target = 'node1'
 
     def setUp(self):
         TestSingleDrive.setUp(self)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, target_img)
+        self.qmp_target = 'node1'
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.backing_img, self.target_img)
         args = {'driver': iotests.imgfmt,
                 'node-name': self.qmp_target,
-                'file': { 'filename': target_img, 'driver': 'file' } }
+                'file': { 'filename': self.target_img, 'driver': 'file' } }
         result = self.vm.qmp("blockdev-add", **args)
         self.assert_qmp(result, 'return', {})
 
@@ -256,51 +244,52 @@ class TestSingleBlockdevUnalignedLength(TestSingleBlockdev):
 
 class TestMirrorNoBacking(iotests.QMPTestCase):
     image_len = 2 * 1024 * 1024 # MB
+    target_backing_img = ""
+    backing_img = ""
+    test_img = ""
+    target_img = ""
 
     def setUp(self):
-        iotests.create_image(backing_img, TestMirrorNoBacking.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
-        self.vm = iotests.VM().add_drive(test_img)
+        self.target_backing_img = os.path.join(self.workdir, 'target-backing.img')
+        self.backing_img = os.path.join(self.workdir, 'backing.img')
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        iotests.create_image(self.backing_img, TestMirrorNoBacking.image_len)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.backing_img, self.test_img)
+        self.vm = iotests.VM().add_drive(self.test_img)
         self.vm.launch()
 
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
 
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, target_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.backing_img, self.target_img)
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             mode='existing', target=target_img)
+                             mode='existing', target=self.target_img)
         self.assert_qmp(result, 'return', {})
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/file', target_img)
+        self.assert_qmp(result, 'return[0]/inserted/file', self.target_img)
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after mirroring')
 
     def test_cancel(self):
         self.assert_no_active_block_jobs()
 
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, target_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.backing_img, self.target_img)
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             mode='existing', target=target_img)
+                             mode='existing', target=self.target_img)
         self.assert_qmp(result, 'return', {})
 
         self.wait_ready_and_cancel()
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/file', test_img)
+        self.assert_qmp(result, 'return[0]/inserted/file', self.test_img)
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after mirroring')
 
     def test_large_cluster(self):
@@ -308,67 +297,67 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
 
         # qemu-img create fails if the image is not there
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'size=%d'
-                        %(TestMirrorNoBacking.image_len), target_backing_img)
+                        %(TestMirrorNoBacking.image_len), self.target_backing_img)
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=%d,backing_file=%s'
-                        % (TestMirrorNoBacking.image_len, target_backing_img), target_img)
+                        % (TestMirrorNoBacking.image_len, self.target_backing_img), self.target_img)
 
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             mode='existing', target=target_img)
+                             mode='existing', target=self.target_img)
         self.assert_qmp(result, 'return', {})
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/file', target_img)
+        self.assert_qmp(result, 'return[0]/inserted/file', self.target_img)
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after mirroring')
 
 class TestMirrorResized(iotests.QMPTestCase):
     backing_len = 1 * 1024 * 1024 # MB
     image_len = 2 * 1024 * 1024 # MB
+    backing_img = ''
+    test_img = ''
+    target_img = ''
 
     def setUp(self):
-        iotests.create_image(backing_img, TestMirrorResized.backing_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
-        qemu_img('resize', test_img, '2M')
-        self.vm = iotests.VM().add_drive(test_img)
+        self.backing_img = os.path.join(self.workdir, 'backing.img')
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        iotests.create_image(self.backing_img, TestMirrorResized.backing_len)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.backing_img, self.test_img)
+        qemu_img('resize', self.test_img, '2M')
+        self.vm = iotests.VM().add_drive(self.test_img)
         self.vm.launch()
 
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
 
         result = self.vm.qmp('drive-mirror', device='drive0', sync='top',
-                             target=target_img)
+                             target=self.target_img)
         self.assert_qmp(result, 'return', {})
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/file', target_img)
+        self.assert_qmp(result, 'return[0]/inserted/file', self.target_img)
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after mirroring')
 
     def test_complete_full(self):
         self.assert_no_active_block_jobs()
 
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img)
+                             target=self.target_img)
         self.assert_qmp(result, 'return', {})
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/file', target_img)
+        self.assert_qmp(result, 'return[0]/inserted/file', self.target_img)
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after mirroring')
 
 class TestReadErrors(iotests.QMPTestCase):
@@ -377,6 +366,9 @@ class TestReadErrors(iotests.QMPTestCase):
     # this should be a multiple of twice the default granularity
     # so that we hit this offset first in state 1
     MIRROR_GRANULARITY = 1024 * 1024
+    backing_img = ''
+    test_img = ''
+    target_img = ''
 
     def create_blkdebug_file(self, name, event, errno):
         file = open(name, 'w')
@@ -402,31 +394,30 @@ new_state = "1"
         file.close()
 
     def setUp(self):
-        self.blkdebug_file = backing_img + ".blkdebug"
-        iotests.create_image(backing_img, TestReadErrors.image_len)
+        self.backing_img = os.path.join(self.workdir, 'backing.img')
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        self.blkdebug_file = self.backing_img + ".blkdebug"
+        iotests.create_image(self.backing_img, TestReadErrors.image_len)
         self.create_blkdebug_file(self.blkdebug_file, "read_aio", 5)
         qemu_img('create', '-f', iotests.imgfmt,
                  '-o', 'backing_file=blkdebug:%s:%s,backing_fmt=raw'
-                       % (self.blkdebug_file, backing_img),
-                 test_img)
+                       % (self.blkdebug_file, self.backing_img),
+                 self.test_img)
         # Write something for tests that use sync='top'
         qemu_io('-c', 'write %d 512' % (self.MIRROR_GRANULARITY + 65536),
-                        test_img)
-        self.vm = iotests.VM().add_drive(test_img)
+                        self.test_img)
+        self.vm = iotests.VM().add_drive(self.test_img)
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(target_img)
-        os.remove(backing_img)
-        os.remove(self.blkdebug_file)
 
     def test_report_read(self):
         self.assert_no_active_block_jobs()
 
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img)
+                             target=self.target_img)
         self.assert_qmp(result, 'return', {})
 
         completed = False
@@ -453,7 +444,7 @@ new_state = "1"
         self.assert_no_active_block_jobs()
 
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img, on_source_error='ignore')
+                             target=self.target_img, on_source_error='ignore')
         self.assert_qmp(result, 'return', {})
 
         event = self.vm.get_qmp_event(wait=True)
@@ -471,10 +462,10 @@ new_state = "1"
         # Test COW into the target image.  The first half of the
         # cluster at MIRROR_GRANULARITY has to be copied from
         # backing_img, even though sync='top'.
-        qemu_img('create', '-f', iotests.imgfmt, '-ocluster_size=131072,backing_file=%s' %(backing_img), target_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-ocluster_size=131072,backing_file=%s' %(self.backing_img), self.target_img)
         result = self.vm.qmp('drive-mirror', device='drive0', sync='top',
                              on_source_error='ignore',
-                             mode='existing', target=target_img)
+                             mode='existing', target=self.target_img)
         self.assert_qmp(result, 'return', {})
 
         event = self.vm.get_qmp_event(wait=True)
@@ -487,15 +478,15 @@ new_state = "1"
         self.vm.shutdown()
 
         # Detach blkdebug to compare images successfully
-        qemu_img('rebase', '-f', iotests.imgfmt, '-u', '-b', backing_img, test_img)
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        qemu_img('rebase', '-f', iotests.imgfmt, '-u', '-b', self.backing_img, self.test_img)
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after mirroring')
 
     def test_stop_read(self):
         self.assert_no_active_block_jobs()
 
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img, on_source_error='stop')
+                             target=self.target_img, on_source_error='stop')
         self.assert_qmp(result, 'return', {})
 
         error = False
@@ -557,27 +548,26 @@ new_state = "1"
         file.close()
 
     def setUp(self):
-        self.blkdebug_file = target_img + ".blkdebug"
-        iotests.create_image(backing_img, TestWriteErrors.image_len)
+        self.backing_img = os.path.join(self.workdir, 'backing.img')
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        self.blkdebug_file = self.target_img + ".blkdebug"
+        iotests.create_image(self.backing_img, TestWriteErrors.image_len)
         self.create_blkdebug_file(self.blkdebug_file, "write_aio", 5)
-        qemu_img('create', '-f', iotests.imgfmt, '-obacking_file=%s' %(backing_img), test_img)
-        self.vm = iotests.VM().add_drive(test_img)
-        self.target_img = 'blkdebug:%s:%s' % (self.blkdebug_file, target_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-osize=%d' %(TestWriteErrors.image_len), target_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-obacking_file=%s' %(self.backing_img), self.test_img)
+        self.vm = iotests.VM().add_drive(self.test_img)
+        self.blkdebug_target_img = 'blkdebug:%s:%s' % (self.blkdebug_file, self.target_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-osize=%d' %(TestWriteErrors.image_len), self.target_img)
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(target_img)
-        os.remove(backing_img)
-        os.remove(self.blkdebug_file)
 
     def test_report_write(self):
         self.assert_no_active_block_jobs()
 
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             mode='existing', target=self.target_img)
+                             mode='existing', target=self.blkdebug_target_img)
         self.assert_qmp(result, 'return', {})
 
         completed = False
@@ -604,7 +594,7 @@ new_state = "1"
         self.assert_no_active_block_jobs()
 
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             mode='existing', target=self.target_img,
+                             mode='existing', target=self.blkdebug_target_img,
                              on_target_error='ignore')
         self.assert_qmp(result, 'return', {})
 
@@ -621,7 +611,7 @@ new_state = "1"
         self.assert_no_active_block_jobs()
 
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             mode='existing', target=self.target_img,
+                             mode='existing', target=self.blkdebug_target_img,
                              on_target_error='stop')
         self.assert_qmp(result, 'return', {})
 
@@ -655,24 +645,27 @@ new_state = "1"
 
 class TestSetSpeed(iotests.QMPTestCase):
     image_len = 80 * 1024 * 1024 # MB
+    backing_img = ''
+    test_img = ''
+    target_img = ''
 
     def setUp(self):
-        qemu_img('create', backing_img, str(TestSetSpeed.image_len))
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
-        self.vm = iotests.VM().add_drive(test_img)
+        self.backing_img = os.path.join(self.workdir, 'backing.img')
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        qemu_img('create', self.backing_img, str(TestSetSpeed.image_len))
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.backing_img, self.test_img)
+        self.vm = iotests.VM().add_drive(self.test_img)
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
-        os.remove(target_img)
 
     def test_set_speed(self):
         self.assert_no_active_block_jobs()
 
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img)
+                             target=self.target_img)
         self.assert_qmp(result, 'return', {})
 
         # Default speed is 0
@@ -692,7 +685,7 @@ class TestSetSpeed(iotests.QMPTestCase):
 
         # Check setting speed in drive-mirror works
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img, speed=4*1024*1024)
+                             target=self.target_img, speed=4*1024*1024)
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block-jobs')
@@ -705,13 +698,13 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img, speed=-1)
+                             target=self.target_img, speed=-1)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         self.assert_no_active_block_jobs()
 
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img)
+                             target=self.target_img)
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('block-job-set-speed', device='drive0', speed=-1)
@@ -721,22 +714,24 @@ class TestSetSpeed(iotests.QMPTestCase):
 
 class TestUnbackedSource(iotests.QMPTestCase):
     image_len = 2 * 1024 * 1024 # MB
+    test_img = ''
+    target_img = ''
 
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, test_img,
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        qemu_img('create', '-f', iotests.imgfmt, self.test_img,
                  str(TestUnbackedSource.image_len))
-        self.vm = iotests.VM().add_drive(test_img)
+        self.vm = iotests.VM().add_drive(self.test_img)
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(target_img)
 
     def test_absolute_paths_full(self):
         self.assert_no_active_block_jobs()
         result = self.vm.qmp('drive-mirror', device='drive0',
-                             sync='full', target=target_img,
+                             sync='full', target=self.target_img,
                              mode='absolute-paths')
         self.assert_qmp(result, 'return', {})
         self.complete_and_wait()
@@ -745,7 +740,7 @@ class TestUnbackedSource(iotests.QMPTestCase):
     def test_absolute_paths_top(self):
         self.assert_no_active_block_jobs()
         result = self.vm.qmp('drive-mirror', device='drive0',
-                             sync='top', target=target_img,
+                             sync='top', target=self.target_img,
                              mode='absolute-paths')
         self.assert_qmp(result, 'return', {})
         self.complete_and_wait()
@@ -754,7 +749,7 @@ class TestUnbackedSource(iotests.QMPTestCase):
     def test_absolute_paths_none(self):
         self.assert_no_active_block_jobs()
         result = self.vm.qmp('drive-mirror', device='drive0',
-                             sync='none', target=target_img,
+                             sync='none', target=self.target_img,
                              mode='absolute-paths')
         self.assert_qmp(result, 'return', {})
         self.complete_and_wait()
@@ -762,26 +757,28 @@ class TestUnbackedSource(iotests.QMPTestCase):
 
 class TestGranularity(iotests.QMPTestCase):
     image_len = 10 * 1024 * 1024 # MB
+    test_img = ''
+    target_img = ''
 
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, test_img,
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        qemu_img('create', '-f', iotests.imgfmt, self.test_img,
                  str(TestGranularity.image_len))
         qemu_io('-c', 'write 0 %d' % (self.image_len),
-                test_img)
-        self.vm = iotests.VM().add_drive(test_img)
+                self.test_img)
+        self.vm = iotests.VM().add_drive(self.test_img)
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after mirroring')
-        os.remove(test_img)
-        os.remove(target_img)
 
     def test_granularity(self):
         self.assert_no_active_block_jobs()
         result = self.vm.qmp('drive-mirror', device='drive0',
-                             sync='full', target=target_img,
+                             sync='full', target=self.target_img,
                              mode='absolute-paths', granularity=8192)
         self.assert_qmp(result, 'return', {})
         event = self.vm.get_qmp_event(wait=60.0)
@@ -794,9 +791,21 @@ class TestRepairQuorum(iotests.QMPTestCase):
     """ This class test quorum file repair using drive-mirror.
         It's mostly a fork of TestSingleDrive """
     image_len = 1 * 1024 * 1024 # MB
-    IMAGES = [ quorum_img1, quorum_img2, quorum_img3 ]
+    quorum_img1 = ''
+    quorum_img2 = ''
+    quorum_img3 = ''
+    quroum_repair_img = ''
+    quorum_snapshot_file = ''
+
+    IMAGES = [ ]
 
     def setUp(self):
+        self.quorum_img1 = os.path.join(self.workdir, 'quorum1.img')
+        self.quorum_img2 = os.path.join(self.workdir, 'quorum2.img')
+        self.quorum_img3 = os.path.join(self.workdir, 'quorum3.img')
+        self.quorum_repair_img = os.path.join(self.workdir, 'quorum_repair.img')
+        self.quorum_snapshot_file = os.path.join(self.workdir, 'quorum_snapshot.img')
+        self.IMAGES = [ self.quorum_img1, self.quorum_img2, self.quorum_img3 ]
         self.vm = iotests.VM()
 
         if iotests.qemu_default_machine == 'pc':
@@ -823,12 +832,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
 
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
@@ -838,15 +841,15 @@ class TestRepairQuorum(iotests.QMPTestCase):
 
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', node_name="repair0", replaces="img1",
-                             target=quorum_repair_img, format=iotests.imgfmt)
+                             target=self.quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'return', {})
 
         self.complete_and_wait(drive="job0")
-        self.assert_has_block_node("repair0", quorum_repair_img)
+        self.assert_has_block_node("repair0", self.quorum_repair_img)
         # TODO: a better test requiring some QEMU infrastructure will be added
         #       to check that this file is really driven by quorum
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(quorum_img2, quorum_repair_img),
+        self.assertTrue(iotests.compare_images(self.quorum_img2, self.quorum_repair_img),
                         'target image does not match source after mirroring')
 
     def test_cancel(self):
@@ -857,13 +860,13 @@ class TestRepairQuorum(iotests.QMPTestCase):
 
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', node_name="repair0", replaces="img1",
-                             target=quorum_repair_img, format=iotests.imgfmt)
+                             target=self.quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'return', {})
 
         self.cancel_and_wait(drive="job0", force=True)
         # here we check that the last registered quorum file has not been
         # swapped out and unref
-        self.assert_has_block_node(None, quorum_img3)
+        self.assert_has_block_node(None, self.quorum_img3)
         self.vm.shutdown()
 
     def test_cancel_after_ready(self):
@@ -874,15 +877,15 @@ class TestRepairQuorum(iotests.QMPTestCase):
 
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', node_name="repair0", replaces="img1",
-                             target=quorum_repair_img, format=iotests.imgfmt)
+                             target=self.quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'return', {})
 
         self.wait_ready_and_cancel(drive="job0")
         # here we check that the last registered quorum file has not been
         # swapped out and unref
-        self.assert_has_block_node(None, quorum_img3)
+        self.assert_has_block_node(None, self.quorum_img3)
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(quorum_img2, quorum_repair_img),
+        self.assertTrue(iotests.compare_images(self.quorum_img2, self.quorum_repair_img),
                         'target image does not match source after mirroring')
 
     def test_pause(self):
@@ -893,7 +896,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
 
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', node_name="repair0", replaces="img1",
-                             target=quorum_repair_img, format=iotests.imgfmt)
+                             target=self.quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'return', {})
 
         self.pause_job('job0')
@@ -910,7 +913,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
 
         self.complete_and_wait(drive="job0")
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(quorum_img2, quorum_repair_img),
+        self.assertTrue(iotests.compare_images(self.quorum_img2, self.quorum_repair_img),
                         'target image does not match source after mirroring')
 
     def test_medium_not_found(self):
@@ -924,7 +927,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
                              sync='full',
                              node_name='repair0',
                              replaces='img1',
-                             target=quorum_repair_img, format=iotests.imgfmt)
+                             target=self.quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
     def test_image_not_found(self):
@@ -933,7 +936,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
 
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', node_name='repair0', replaces='img1',
-                             mode='existing', target=quorum_repair_img,
+                             mode='existing', target=self.quorum_repair_img,
                              format=iotests.imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
@@ -945,7 +948,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
                              device='nonexistent', sync='full',
                              node_name='repair0',
                              replaces='img1',
-                             target=quorum_repair_img, format=iotests.imgfmt)
+                             target=self.quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
     def test_wrong_sync_mode(self):
@@ -955,7 +958,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
         result = self.vm.qmp('drive-mirror', device='quorum0', job_id='job0',
                              node_name='repair0',
                              replaces='img1',
-                             target=quorum_repair_img, format=iotests.imgfmt)
+                             target=self.quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
     def test_no_node_name(self):
@@ -964,7 +967,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
 
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', replaces='img1',
-                             target=quorum_repair_img, format=iotests.imgfmt)
+                             target=self.quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
     def test_nonexistent_replaces(self):
@@ -973,7 +976,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
 
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', node_name='repair0', replaces='img77',
-                             target=quorum_repair_img, format=iotests.imgfmt)
+                             target=self.quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
     def test_after_a_quorum_snapshot(self):
@@ -981,21 +984,21 @@ class TestRepairQuorum(iotests.QMPTestCase):
             return
 
         result = self.vm.qmp('blockdev-snapshot-sync', node_name='img1',
-                             snapshot_file=quorum_snapshot_file,
+                             snapshot_file=self.quorum_snapshot_file,
                              snapshot_node_name="snap1");
 
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', node_name='repair0', replaces="img1",
-                             target=quorum_repair_img, format=iotests.imgfmt)
+                             target=self.quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', node_name='repair0', replaces="snap1",
-                             target=quorum_repair_img, format=iotests.imgfmt)
+                             target=self.quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'return', {})
 
         self.complete_and_wait('job0')
-        self.assert_has_block_node("repair0", quorum_repair_img)
+        self.assert_has_block_node("repair0", self.quorum_repair_img)
         # TODO: a better test requiring some QEMU infrastructure will be added
         #       to check that this file is really driven by quorum
         self.vm.shutdown()
diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
index 11ea0f4..c051250 100755
--- a/tests/qemu-iotests/044
+++ b/tests/qemu-iotests/044
@@ -27,7 +27,6 @@ from iotests import qemu_img, qemu_img_verbose, qemu_io
 import struct
 import subprocess
 
-test_img = os.path.join(iotests.test_dir, 'test.img')
 
 class TestRefcountTableGrowth(iotests.QMPTestCase):
     '''Abstract base class for image mirroring test cases'''
@@ -99,18 +98,18 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
 
 
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=512', test_img, '16G')
-        self.preallocate(test_img)
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=512', self.test_img, '16G')
+        self.preallocate(self.test_img)
         pass
 
 
     def tearDown(self):
-        os.remove(test_img)
         pass
 
     def test_grow_refcount_table(self):
-        qemu_io('-c', 'write 3800M 1M', test_img)
-        qemu_img_verbose('check' , test_img)
+        qemu_io('-c', 'write 3800M 1M', self.test_img)
+        qemu_img_verbose('check' , self.test_img)
         pass
 
 if __name__ == '__main__':
diff --git a/tests/qemu-iotests/045 b/tests/qemu-iotests/045
index 6be8fc4..3f025b9 100755
--- a/tests/qemu-iotests/045
+++ b/tests/qemu-iotests/045
@@ -22,26 +22,25 @@ import os
 import iotests
 from iotests import qemu_img
 
-image0 = os.path.join(iotests.test_dir, 'image0')
-image1 = os.path.join(iotests.test_dir, 'image1')
-image2 = os.path.join(iotests.test_dir, 'image2')
-image3 = os.path.join(iotests.test_dir, 'image3')
-image4 = os.path.join(iotests.test_dir, 'image4')
-
 class TestFdSets(iotests.QMPTestCase):
 
     def setUp(self):
+        self.image0 = os.path.join(self.workdir, 'image0')
+        self.image1 = os.path.join(self.workdir, 'image1')
+        self.image2 = os.path.join(self.workdir, 'image2')
+        self.image3 = os.path.join(self.workdir, 'image3')
+        self.image4 = os.path.join(self.workdir, 'image4')
         self.vm = iotests.VM()
-        qemu_img('create', '-f', iotests.imgfmt, image0, '128K')
-        qemu_img('create', '-f', iotests.imgfmt, image1, '128K')
-        qemu_img('create', '-f', iotests.imgfmt, image2, '128K')
-        qemu_img('create', '-f', iotests.imgfmt, image3, '128K')
-        qemu_img('create', '-f', iotests.imgfmt, image4, '128K')
-        self.file0 = open(image0, 'r')
-        self.file1 = open(image1, 'w+')
-        self.file2 = open(image2, 'r')
-        self.file3 = open(image3, 'r')
-        self.file4 = open(image4, 'r')
+        qemu_img('create', '-f', iotests.imgfmt, self.image0, '128K')
+        qemu_img('create', '-f', iotests.imgfmt, self.image1, '128K')
+        qemu_img('create', '-f', iotests.imgfmt, self.image2, '128K')
+        qemu_img('create', '-f', iotests.imgfmt, self.image3, '128K')
+        qemu_img('create', '-f', iotests.imgfmt, self.image4, '128K')
+        self.file0 = open(self.image0, 'r')
+        self.file1 = open(self.image1, 'w+')
+        self.file2 = open(self.image2, 'r')
+        self.file3 = open(self.image3, 'r')
+        self.file4 = open(self.image4, 'r')
         self.vm.add_fd(self.file0.fileno(), 1, 'image0:r')
         self.vm.add_fd(self.file1.fileno(), 1, 'image1:w+')
         self.vm.add_fd(self.file2.fileno(), 0, 'image2:r')
@@ -57,11 +56,6 @@ class TestFdSets(iotests.QMPTestCase):
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
@@ -128,8 +122,9 @@ class TestFdSets(iotests.QMPTestCase):
 # Add fd at runtime, there are two ways: monitor related or fdset related
 class TestSCMFd(iotests.QMPTestCase):
     def setUp(self):
+        self.image0 = os.path.join(self.workdir, 'image0')
         self.vm = iotests.VM()
-        qemu_img('create', '-f', iotests.imgfmt, image0, '128K')
+        qemu_img('create', '-f', iotests.imgfmt, self.image0, '128K')
         # Add an unused monitor, to verify it works fine when two monitor
         # instances present
         self.vm.add_monitor_telnet("0",4445)
@@ -137,10 +132,9 @@ class TestSCMFd(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(image0)
 
     def _send_fd_by_SCM(self):
-        ret = self.vm.send_fd_scm(image0)
+        ret = self.vm.send_fd_scm(self.image0)
         self.assertEqual(ret, 0, 'Failed to send fd with UNIX SCM')
 
     def test_add_fd(self):
diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index e1206ca..4527ecf 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -26,8 +26,6 @@ import iotests
 from iotests import qemu_img, qemu_io
 
 test_img = os.path.join(iotests.test_dir, 'test.img')
-target_img = os.path.join(iotests.test_dir, 'target.img')
-blockdev_target_img = os.path.join(iotests.test_dir, 'blockdev-target.img')
 
 image_len = 64 * 1024 * 1024 # MB
 
@@ -40,27 +38,23 @@ def setUpModule():
     qemu_io('-f', iotests.imgfmt, '-c', 'write -P0xdc 32M 124k', test_img)
     qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x33 67043328 64k', test_img)
 
-def tearDownModule():
-    os.remove(test_img)
 
 
 class TestSingleDrive(iotests.QMPTestCase):
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        self.blockdev_target_img = os.path.join(self.workdir, 'blockdev-target.img')
+        qemu_img('create', '-f', iotests.imgfmt, self.blockdev_target_img, str(image_len))
 
         self.vm = iotests.VM().add_drive(test_img)
-        self.vm.add_drive(blockdev_target_img, interface="none")
+        self.vm.add_drive(self.blockdev_target_img, interface="none")
         if iotests.qemu_default_machine == 'pc':
             self.vm.add_drive(None, 'media=cdrom', 'ide')
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(blockdev_target_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
+        pass
 
     def do_test_cancel(self, cmd, target):
         self.assert_no_active_block_jobs()
@@ -72,7 +66,7 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_qmp(event, 'data/type', 'backup')
 
     def test_cancel_drive_backup(self):
-        self.do_test_cancel('drive-backup', target_img)
+        self.do_test_cancel('drive-backup', self.target_img)
 
     def test_cancel_blockdev_backup(self):
         self.do_test_cancel('blockdev-backup', 'drive1')
@@ -108,17 +102,17 @@ class TestSingleDrive(iotests.QMPTestCase):
                         'target image does not match source after backup')
 
     def test_pause_drive_backup(self):
-        self.do_test_pause('drive-backup', target_img, target_img)
+        self.do_test_pause('drive-backup', self.target_img, self.target_img)
 
     def test_pause_blockdev_backup(self):
-        self.do_test_pause('blockdev-backup', 'drive1', blockdev_target_img)
+        self.do_test_pause('blockdev-backup', 'drive1', self.blockdev_target_img)
 
     def test_medium_not_found(self):
         if iotests.qemu_default_machine != 'pc':
             return
 
         result = self.vm.qmp('drive-backup', device='drive2', # CD-ROM
-                             target=target_img, sync='full')
+                             target=self.target_img, sync='full')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
     def test_medium_not_found_blockdev_backup(self):
@@ -131,12 +125,12 @@ class TestSingleDrive(iotests.QMPTestCase):
 
     def test_image_not_found(self):
         result = self.vm.qmp('drive-backup', device='drive0',
-                             target=target_img, sync='full', mode='existing')
+                             target=self.target_img, sync='full', mode='existing')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
     def test_invalid_format(self):
         result = self.vm.qmp('drive-backup', device='drive0',
-                             target=target_img, sync='full',
+                             target=self.target_img, sync='full',
                              format='spaghetti-noodles')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
@@ -146,7 +140,7 @@ class TestSingleDrive(iotests.QMPTestCase):
 
     def test_device_not_found(self):
         self.do_test_device_not_found('drive-backup', device='nonexistent',
-                                      target=target_img, sync='full')
+                                      target=self.target_img, sync='full')
 
         self.do_test_device_not_found('blockdev-backup', device='nonexistent',
                                       target='drive0', sync='full')
@@ -164,19 +158,17 @@ class TestSingleDrive(iotests.QMPTestCase):
 
 class TestSetSpeed(iotests.QMPTestCase):
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        self.blockdev_target_img = os.path.join(self.workdir, 'blockdev-target.img')
+        qemu_img('create', '-f', iotests.imgfmt, self.blockdev_target_img, str(image_len))
 
         self.vm = iotests.VM().add_drive(test_img)
-        self.vm.add_drive(blockdev_target_img, interface="none")
+        self.vm.add_drive(self.blockdev_target_img, interface="none")
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(blockdev_target_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
+        pass
 
     def do_test_set_speed(self, cmd, target):
         self.assert_no_active_block_jobs()
@@ -215,7 +207,7 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.assert_qmp(event, 'data/type', 'backup')
 
     def test_set_speed_drive_backup(self):
-        self.do_test_set_speed('drive-backup', target_img)
+        self.do_test_set_speed('drive-backup', self.target_img)
 
     def test_set_speed_blockdev_backup(self):
         self.do_test_set_speed('blockdev-backup', 'drive1')
@@ -241,28 +233,27 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.assert_qmp(event, 'data/type', 'backup')
 
     def test_set_speed_invalid_drive_backup(self):
-        self.do_test_set_speed_invalid('drive-backup', target_img)
+        self.do_test_set_speed_invalid('drive-backup', self.target_img)
 
     def test_set_speed_invalid_blockdev_backup(self):
         self.do_test_set_speed_invalid('blockdev-backup',  'drive1')
 
 class TestSingleTransaction(iotests.QMPTestCase):
+
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        self.blockdev_target_img = os.path.join(self.workdir, 'blockdev-target.img')
+        qemu_img('create', '-f', iotests.imgfmt, self.blockdev_target_img, str(image_len))
 
         self.vm = iotests.VM().add_drive(test_img)
-        self.vm.add_drive(blockdev_target_img, interface="none")
+        self.vm.add_drive(self.blockdev_target_img, interface="none")
         if iotests.qemu_default_machine == 'pc':
             self.vm.add_drive(None, 'media=cdrom', 'ide')
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(blockdev_target_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
+        pass
 
     def do_test_cancel(self, cmd, target):
         self.assert_no_active_block_jobs()
@@ -281,7 +272,7 @@ class TestSingleTransaction(iotests.QMPTestCase):
         self.assert_qmp(event, 'data/type', 'backup')
 
     def test_cancel_drive_backup(self):
-        self.do_test_cancel('drive-backup', target_img)
+        self.do_test_cancel('drive-backup', self.target_img)
 
     def test_cancel_blockdev_backup(self):
         self.do_test_cancel('blockdev-backup', 'drive1')
@@ -322,10 +313,10 @@ class TestSingleTransaction(iotests.QMPTestCase):
                         'target image does not match source after backup')
 
     def test_pause_drive_backup(self):
-        self.do_test_pause('drive-backup', target_img, target_img)
+        self.do_test_pause('drive-backup', self.target_img, self.target_img)
 
     def test_pause_blockdev_backup(self):
-        self.do_test_pause('blockdev-backup', 'drive1', blockdev_target_img)
+        self.do_test_pause('blockdev-backup', 'drive1', self.blockdev_target_img)
 
     def do_test_medium_not_found(self, cmd, target):
         if iotests.qemu_default_machine != 'pc':
@@ -341,7 +332,7 @@ class TestSingleTransaction(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
 
     def test_medium_not_found_drive_backup(self):
-        self.do_test_medium_not_found('drive-backup', target_img)
+        self.do_test_medium_not_found('drive-backup', self.target_img)
 
     def test_medium_not_found_blockdev_backup(self):
         self.do_test_medium_not_found('blockdev-backup', 'drive1')
@@ -351,7 +342,7 @@ class TestSingleTransaction(iotests.QMPTestCase):
                 'type': 'drive-backup',
                 'data': { 'device': 'drive0',
                           'mode': 'existing',
-                          'target': target_img,
+                          'target': self.target_img,
                           'sync': 'full' },
             }
         ])
@@ -362,7 +353,7 @@ class TestSingleTransaction(iotests.QMPTestCase):
                 'type': 'drive-backup',
                 'data': { 'device': 'nonexistent',
                           'mode': 'existing',
-                          'target': target_img,
+                          'target': self.target_img,
                           'sync': 'full' },
             }
         ])
@@ -410,7 +401,7 @@ class TestSingleTransaction(iotests.QMPTestCase):
                 'type': 'drive-backup',
                 'data': { 'device': 'nonexistent',
                           'mode': 'existing',
-                          'target': target_img,
+                          'target': self.target_img,
                           'sync': 'full' },
             }, {
                 'type': 'Abort',
@@ -452,21 +443,21 @@ class TestDriveCompression(iotests.QMPTestCase):
     fmt_supports_compression = [{'type': 'qcow2', 'args': ()},
                                 {'type': 'vmdk', 'args': ('-o', 'subformat=streamOptimized')}]
 
+    def setUp(self):
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        self.blockdev_target_img = os.path.join(self.workdir, 'blockdev-target.img')
+
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(blockdev_target_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
+        pass
 
     def do_prepare_drives(self, fmt, args, attach_target):
         self.vm = iotests.VM().add_drive(test_img)
 
-        qemu_img('create', '-f', fmt, blockdev_target_img,
+        qemu_img('create', '-f', fmt, self.blockdev_target_img,
                  str(TestDriveCompression.image_len), *args)
         if attach_target:
-            self.vm.add_drive(blockdev_target_img, format=fmt, interface="none")
+            self.vm.add_drive(self.blockdev_target_img, format=fmt, interface="none")
 
         self.vm.launch()
 
@@ -481,14 +472,14 @@ class TestDriveCompression(iotests.QMPTestCase):
         self.wait_until_completed()
 
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, blockdev_target_img,
+        self.assertTrue(iotests.compare_images(test_img, self.blockdev_target_img,
                                                iotests.imgfmt, format['type']),
                         'target image does not match source after backup')
 
     def test_complete_compress_drive_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
             self.do_test_compress_complete('drive-backup', format, False,
-                                           target=blockdev_target_img, mode='existing')
+                                           target=self.blockdev_target_img, mode='existing')
 
     def test_complete_compress_blockdev_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
@@ -511,7 +502,7 @@ class TestDriveCompression(iotests.QMPTestCase):
     def test_compress_cancel_drive_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
             self.do_test_compress_cancel('drive-backup', format, False,
-                                         target=blockdev_target_img, mode='existing')
+                                         target=self.blockdev_target_img, mode='existing')
 
     def test_compress_cancel_blockdev_backup(self):
        for format in TestDriveCompression.fmt_supports_compression:
@@ -546,14 +537,14 @@ class TestDriveCompression(iotests.QMPTestCase):
         self.wait_until_completed()
 
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, blockdev_target_img,
+        self.assertTrue(iotests.compare_images(test_img, self.blockdev_target_img,
                                                iotests.imgfmt, format['type']),
                         'target image does not match source after backup')
 
     def test_compress_pause_drive_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
             self.do_test_compress_pause('drive-backup', format, False,
-                                        target=blockdev_target_img, mode='existing')
+                                        target=self.blockdev_target_img, mode='existing')
 
     def test_compress_pause_blockdev_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index 04f2c3c..47da53f 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -25,50 +25,45 @@ import os
 import iotests
 from iotests import qemu_img, qemu_io, create_image
 
-backing_img = os.path.join(iotests.test_dir, 'backing.img')
-test_img = os.path.join(iotests.test_dir, 'test.img')
-target_img = os.path.join(iotests.test_dir, 'target.img')
 
 class TestSyncModesNoneAndTop(iotests.QMPTestCase):
     image_len = 64 * 1024 * 1024 # MB
 
     def setUp(self):
-        create_image(backing_img, TestSyncModesNoneAndTop.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % backing_img, test_img)
-        qemu_io('-c', 'write -P0x41 0 512', test_img)
-        qemu_io('-c', 'write -P0xd5 1M 32k', test_img)
-        qemu_io('-c', 'write -P0xdc 32M 124k', test_img)
-        qemu_io('-c', 'write -P0xdc 67043328 64k', test_img)
-        self.vm = iotests.VM().add_drive(test_img)
+        self.backing_img = os.path.join(self.workdir, 'backing.img')
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        create_image(self.backing_img, TestSyncModesNoneAndTop.image_len)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=%s' % self.backing_img, self.test_img)
+        qemu_io('-c', 'write -P0x41 0 512', self.test_img)
+        qemu_io('-c', 'write -P0xd5 1M 32k', self.test_img)
+        qemu_io('-c', 'write -P0xdc 32M 124k', self.test_img)
+        qemu_io('-c', 'write -P0xdc 67043328 64k', self.test_img)
+        self.vm = iotests.VM().add_drive(self.test_img)
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
+        pass
 
     def test_complete_top(self):
         self.assert_no_active_block_jobs()
         result = self.vm.qmp('drive-backup', device='drive0', sync='top',
-                             format=iotests.imgfmt, target=target_img)
+                             format=iotests.imgfmt, target=self.target_img)
         self.assert_qmp(result, 'return', {})
 
         self.wait_until_completed(check_offset=False)
 
         self.assert_no_active_block_jobs()
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after backup')
 
     def test_cancel_sync_none(self):
         self.assert_no_active_block_jobs()
 
         result = self.vm.qmp('drive-backup', device='drive0',
-                             sync='none', target=target_img)
+                             sync='none', target=self.target_img)
         self.assert_qmp(result, 'return', {})
         time.sleep(1)
         self.vm.hmp_qemu_io('drive0', 'write -P0x5e 0 512')
@@ -80,21 +75,21 @@ class TestSyncModesNoneAndTop(iotests.QMPTestCase):
 
         self.vm.shutdown()
         time.sleep(1)
-        self.assertEqual(-1, qemu_io('-c', 'read -P0x41 0 512', target_img).find("verification failed"))
+        self.assertEqual(-1, qemu_io('-c', 'read -P0x41 0 512', self.target_img).find("verification failed"))
 
 class TestBeforeWriteNotifier(iotests.QMPTestCase):
     def setUp(self):
+        self.target_img = os.path.join(self.workdir, 'target.img')
         self.vm = iotests.VM().add_drive_raw("file=blkdebug::null-co://,id=drive0,align=65536,driver=blkdebug")
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(target_img)
 
     def test_before_write_notifier(self):
         self.vm.pause_drive("drive0")
         result = self.vm.qmp('drive-backup', device='drive0',
-                             sync='full', target=target_img,
+                             sync='full', target=self.target_img,
                              format="file", speed=1)
         self.assert_qmp(result, 'return', {})
         result = self.vm.qmp('block-job-pause', device="drive0")
diff --git a/tests/qemu-iotests/057 b/tests/qemu-iotests/057
index 9f0a5a3..00b07d3 100755
--- a/tests/qemu-iotests/057
+++ b/tests/qemu-iotests/057
@@ -38,7 +38,7 @@ class ImageSnapshotTestCase(iotests.QMPTestCase):
         self.vm = iotests.VM()
         for i in range(0, image_num):
             filename = '%s%d' % (test_img_base_name, i)
-            img = os.path.join(iotests.test_dir, filename)
+            img = os.path.join(self.workdir, filename)
             device = '%s%d' % (test_drv_base_name, i)
             qemu_img('create', '-f', iotests.imgfmt, img, str(self.image_len))
             self.vm.add_drive(img)
@@ -49,8 +49,6 @@ class ImageSnapshotTestCase(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        for dev_expect in self.expect:
-            os.remove(dev_expect['image'])
 
     def createSnapshotInTransaction(self, snapshot_num, abort = False):
         actions = []
diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index 72aa970..6c67f7d 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -26,19 +26,18 @@ import iotests
 from iotests import qemu_img, qemu_img_pipe
 import unittest
 
-test_img = os.path.join(iotests.test_dir, 'test.img')
 
 class TestImageInfoSpecific(iotests.QMPTestCase):
     '''Abstract base class for ImageInfoSpecific tests'''
+    test_img = ''
 
     def setUp(self):
+        self.test_img = os.path.join(self.workdir, 'test.img')
         if self.img_options is None:
             self.skipTest('Skipping abstract test class')
         qemu_img('create', '-f', iotests.imgfmt, '-o', self.img_options,
-                 test_img, '128K')
+                 self.test_img, '128K')
 
-    def tearDown(self):
-        os.remove(test_img)
 
 class TestQemuImgInfo(TestImageInfoSpecific):
     '''Abstract base class for qemu-img info tests'''
@@ -48,13 +47,13 @@ class TestQemuImgInfo(TestImageInfoSpecific):
     human_compare = None
 
     def test_json(self):
-        data = json.loads(qemu_img_pipe('info', '--output=json', test_img))
+        data = json.loads(qemu_img_pipe('info', '--output=json', self.test_img))
         data = data['format-specific']
         self.assertEqual(data['type'], iotests.imgfmt)
         self.assertEqual(data['data'], self.json_compare)
 
     def test_human(self):
-        data = qemu_img_pipe('info', '--output=human', test_img).split('\n')
+        data = qemu_img_pipe('info', '--output=human', self.test_img).split('\n')
         data = data[(data.index('Format specific information:') + 1)
                     :data.index('')]
         for field in data:
@@ -71,7 +70,7 @@ class TestQMP(TestImageInfoSpecific):
 
     def setUp(self):
         self.TestImageInfoSpecific.setUp(self)
-        self.vm = iotests.VM().add_drive(test_img, self.qemu_options)
+        self.vm = iotests.VM().add_drive(self.test_img, self.qemu_options)
         self.vm.launch()
 
     def tearDown(self):
diff --git a/tests/qemu-iotests/096 b/tests/qemu-iotests/096
index aeeb375..b9388ec 100644
--- a/tests/qemu-iotests/096
+++ b/tests/qemu-iotests/096
@@ -23,13 +23,15 @@ import iotests
 import os
 
 class TestLiveSnapshot(iotests.QMPTestCase):
-    base_img = os.path.join(iotests.test_dir, 'base.img')
-    target_img = os.path.join(iotests.test_dir, 'target.img')
+    base_img = ''
+    target_img = ''
     group = 'mygroup'
     iops = 6000
     iops_size = 1024
 
     def setUp(self):
+        self.base_img = os.path.join(self.workdir, 'base.img')
+        self.target_img = os.path.join(self.workdir, 'target.img')
         opts = []
         opts.append('node-name=base')
         opts.append('throttling.group=%s' % self.group)
@@ -41,8 +43,6 @@ class TestLiveSnapshot(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(self.base_img)
-        os.remove(self.target_img)
 
     def checkConfig(self, active_layer):
         result = self.vm.qmp('query-block')
diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index 8a9e838..b011780 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -25,12 +25,17 @@ import time
 import iotests
 from iotests import qemu_img
 
-old_img = os.path.join(iotests.test_dir, 'test0.img')
-new_img = os.path.join(iotests.test_dir, 'test1.img')
 
 class ChangeBaseClass(iotests.QMPTestCase):
     has_opened = False
     has_closed = False
+    old_img = ''
+    new_img = ''
+
+    def setUp(self):
+        self.old_img = os.path.join(self.workdir, 'test0.img')
+        self.new_img = os.path.join(self.workdir, 'test1.img')
+
 
     def process_events(self):
         for event in self.vm.get_qmp_events(wait=False):
@@ -62,11 +67,15 @@ class ChangeBaseClass(iotests.QMPTestCase):
             self.fail('Timeout while waiting for the tray to close')
 
 class GeneralChangeTestsBaseClass(ChangeBaseClass):
+    ChangeBaseClass = ChangeBaseClass
 
     device_name = None
 
+    def setUp(self):
+        self.ChangeBaseClass.setUp(self);
+
     def test_change(self):
-        result = self.vm.qmp('change', device='drive0', target=new_img,
+        result = self.vm.qmp('change', device='drive0', target=self.new_img,
                                        arg=iotests.imgfmt)
         self.assert_qmp(result, 'return', {})
 
@@ -76,16 +85,16 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         result = self.vm.qmp('query-block')
         if self.has_real_tray:
             self.assert_qmp(result, 'return[0]/tray_open', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
 
     def test_blockdev_change_medium(self):
         if self.device_name is not None:
             result = self.vm.qmp('blockdev-change-medium',
-                                 id=self.device_name, filename=new_img,
+                                 id=self.device_name, filename=self.new_img,
                                  format=iotests.imgfmt)
         else:
             result = self.vm.qmp('blockdev-change-medium',
-                                 device='drive0', filename=new_img,
+                                 device='drive0', filename=self.new_img,
                                  format=iotests.imgfmt)
 
         self.assert_qmp(result, 'return', {})
@@ -96,7 +105,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         result = self.vm.qmp('query-block')
         if self.has_real_tray:
             self.assert_qmp(result, 'return[0]/tray_open', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
 
     def test_eject(self):
         if self.device_name is not None:
@@ -128,10 +137,10 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
 
         if self.device_name is not None:
             result = self.vm.qmp('blockdev-change-medium', id=self.device_name,
-                                 filename=new_img, format=iotests.imgfmt)
+                                 filename=self.new_img, format=iotests.imgfmt)
         else:
             result = self.vm.qmp('blockdev-change-medium', device='drive0',
-                                 filename=new_img, format=iotests.imgfmt)
+                                 filename=self.new_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'return', {})
 
         self.wait_for_close()
@@ -139,7 +148,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         result = self.vm.qmp('query-block')
         if self.has_real_tray:
             self.assert_qmp(result, 'return[0]/tray_open', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
 
     def test_tray_open_close(self):
         if self.device_name is not None:
@@ -158,7 +167,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         if self.was_empty == True:
             self.assert_qmp_absent(result, 'return[0]/inserted')
         else:
-            self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+            self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
         if self.device_name is not None:
             result = self.vm.qmp('blockdev-close-tray', id=self.device_name)
@@ -175,7 +184,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         if self.was_empty == True:
             self.assert_qmp_absent(result, 'return[0]/inserted')
         else:
-            self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+            self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
     def test_tray_eject_close(self):
         result = self.vm.qmp('eject', device='drive0', force=True)
@@ -213,10 +222,10 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         if self.was_empty == True:
             self.assert_qmp_absent(result, 'return[0]/inserted')
         else:
-            self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+            self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
         result = self.vm.qmp('blockdev-change-medium', device='drive0',
-                                                       filename=new_img,
+                                                       filename=self.new_img,
                                                        format=iotests.imgfmt)
         self.assert_qmp(result, 'return', {})
 
@@ -225,13 +234,13 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         result = self.vm.qmp('query-block')
         if self.has_real_tray:
             self.assert_qmp(result, 'return[0]/tray_open', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
 
     def test_cycle(self):
         result = self.vm.qmp('blockdev-add',
                              node_name='new',
                              driver=iotests.imgfmt,
-                             file={'filename': new_img,
+                             file={'filename': self.new_img,
                                     'driver': 'file'})
         self.assert_qmp(result, 'return', {})
 
@@ -251,7 +260,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         if self.was_empty == True:
             self.assert_qmp_absent(result, 'return[0]/inserted')
         else:
-            self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+            self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
         if self.device_name is not None:
             result = self.vm.qmp('x-blockdev-remove-medium',
@@ -276,7 +285,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         result = self.vm.qmp('query-block')
         if self.has_real_tray:
             self.assert_qmp(result, 'return[0]/tray_open', True)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
 
         if self.device_name is not None:
             result = self.vm.qmp('blockdev-close-tray', id=self.device_name)
@@ -289,7 +298,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         result = self.vm.qmp('query-block')
         if self.has_real_tray:
             self.assert_qmp(result, 'return[0]/tray_open', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
 
     def test_close_on_closed(self):
         result = self.vm.qmp('blockdev-close-tray', device='drive0')
@@ -311,7 +320,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         result = self.vm.qmp('blockdev-add',
                              node_name='new',
                              driver=iotests.imgfmt,
-                             file={'filename': new_img,
+                             file={'filename': self.new_img,
                                    'driver': 'file'})
         self.assert_qmp(result, 'return', {})
 
@@ -321,29 +330,29 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
 
 class TestInitiallyFilled(GeneralChangeTestsBaseClass):
     was_empty = False
+    GeneralChangeTestsBaseClass = GeneralChangeTestsBaseClass
 
     def setUp(self, media, interface):
-        qemu_img('create', '-f', iotests.imgfmt, old_img, '1440k')
-        qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
+        self.GeneralChangeTestsBaseClass.setUp(self)
+        qemu_img('create', '-f', iotests.imgfmt, self.old_img, '1440k')
+        qemu_img('create', '-f', iotests.imgfmt, self.new_img, '1440k')
         self.vm = iotests.VM()
         if interface == 'ide':
             self.device_name = 'qdev0'
-            self.vm.add_drive(old_img, 'media=%s' % media, 'none')
+            self.vm.add_drive(self.old_img, 'media=%s' % media, 'none')
             self.vm.add_device('ide-cd,drive=drive0,id=%s' % self.device_name)
         else:
-            self.vm.add_drive(old_img, 'media=%s' % media, interface)
+            self.vm.add_drive(self.old_img, 'media=%s' % media, interface)
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(old_img)
-        os.remove(new_img)
 
     def test_insert_on_filled(self):
         result = self.vm.qmp('blockdev-add',
                              node_name='new',
                              driver=iotests.imgfmt,
-                             file={'filename': new_img,
+                             file={'filename': self.new_img,
                                    'driver': 'file'})
         self.assert_qmp(result, 'return', {})
 
@@ -358,15 +367,16 @@ class TestInitiallyFilled(GeneralChangeTestsBaseClass):
 
 class TestInitiallyEmpty(GeneralChangeTestsBaseClass):
     was_empty = True
+    GeneralChangeTestsBaseClass = GeneralChangeTestsBaseClass
 
     def setUp(self, media, interface):
-        qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
+        self.GeneralChangeTestsBaseClass.setUp(self)
+        qemu_img('create', '-f', iotests.imgfmt, self.new_img, '1440k')
         self.vm = iotests.VM().add_drive(None, 'media=%s' % media, interface)
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(new_img)
 
     def test_remove_on_empty(self):
         result = self.vm.qmp('blockdev-open-tray', device='drive0')
@@ -411,67 +421,64 @@ class TestFloppyInitiallyEmpty(TestInitiallyEmpty):
 
 class TestChangeReadOnly(ChangeBaseClass):
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, old_img, '1440k')
-        qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
+        ChangeBaseClass.setUp(self)
+        qemu_img('create', '-f', iotests.imgfmt, self.old_img, '1440k')
+        qemu_img('create', '-f', iotests.imgfmt, self.new_img, '1440k')
         self.vm = iotests.VM()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.chmod(old_img, 0666)
-        os.chmod(new_img, 0666)
-        os.remove(old_img)
-        os.remove(new_img)
 
     def test_ro_ro_retain(self):
-        os.chmod(old_img, 0444)
-        os.chmod(new_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk,read-only=on', 'floppy')
+        os.chmod(self.old_img, 0444)
+        os.chmod(self.new_img, 0444)
+        self.vm.add_drive(self.old_img, 'media=disk,read-only=on', 'floppy')
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
         result = self.vm.qmp('blockdev-change-medium', device='drive0',
-                                                       filename=new_img,
+                                                       filename=self.new_img,
                                                        format=iotests.imgfmt,
                                                        read_only_mode='retain')
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
 
     def test_ro_rw_retain(self):
-        os.chmod(old_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk,read-only=on', 'floppy')
+        os.chmod(self.old_img, 0444)
+        self.vm.add_drive(self.old_img, 'media=disk,read-only=on', 'floppy')
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
         result = self.vm.qmp('blockdev-change-medium', device='drive0',
-                                                       filename=new_img,
+                                                       filename=self.new_img,
                                                        format=iotests.imgfmt,
                                                        read_only_mode='retain')
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
 
     def test_rw_ro_retain(self):
-        os.chmod(new_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk', 'floppy')
+        os.chmod(self.new_img, 0444)
+        self.vm.add_drive(self.old_img, 'media=disk', 'floppy')
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
         result = self.vm.qmp('blockdev-change-medium', device='drive0',
-                                                       filename=new_img,
+                                                       filename=self.new_img,
                                                        format=iotests.imgfmt,
                                                        read_only_mode='retain')
         self.assert_qmp(result, 'error/class', 'GenericError')
@@ -480,145 +487,145 @@ class TestChangeReadOnly(ChangeBaseClass):
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
     def test_ro_rw(self):
-        os.chmod(old_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk,read-only=on', 'floppy')
+        os.chmod(self.old_img, 0444)
+        self.vm.add_drive(self.old_img, 'media=disk,read-only=on', 'floppy')
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
         result = self.vm.qmp('blockdev-change-medium',
                              device='drive0',
-                             filename=new_img,
+                             filename=self.new_img,
                              format=iotests.imgfmt,
                              read_only_mode='read-write')
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
 
     def test_rw_ro(self):
-        os.chmod(new_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk', 'floppy')
+        os.chmod(self.new_img, 0444)
+        self.vm.add_drive(self.old_img, 'media=disk', 'floppy')
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
         result = self.vm.qmp('blockdev-change-medium',
                              device='drive0',
-                             filename=new_img,
+                             filename=self.new_img,
                              format=iotests.imgfmt,
                              read_only_mode='read-only')
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
 
     def test_make_rw_ro(self):
-        self.vm.add_drive(old_img, 'media=disk', 'floppy')
+        self.vm.add_drive(self.old_img, 'media=disk', 'floppy')
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
         result = self.vm.qmp('blockdev-change-medium',
                              device='drive0',
-                             filename=new_img,
+                             filename=self.new_img,
                              format=iotests.imgfmt,
                              read_only_mode='read-only')
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
 
     def test_make_ro_rw(self):
-        os.chmod(new_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk', 'floppy')
+        os.chmod(self.new_img, 0444)
+        self.vm.add_drive(self.old_img, 'media=disk', 'floppy')
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
         result = self.vm.qmp('blockdev-change-medium',
                              device='drive0',
-                             filename=new_img,
+                             filename=self.new_img,
                              format=iotests.imgfmt,
                              read_only_mode='read-write')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
     def test_make_rw_ro_by_retain(self):
-        os.chmod(old_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk,read-only=on', 'floppy')
+        os.chmod(self.old_img, 0444)
+        self.vm.add_drive(self.old_img, 'media=disk,read-only=on', 'floppy')
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
         result = self.vm.qmp('blockdev-change-medium', device='drive0',
-                                                       filename=new_img,
+                                                       filename=self.new_img,
                                                        format=iotests.imgfmt,
                                                        read_only_mode='retain')
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
 
     def test_make_ro_rw_by_retain(self):
-        os.chmod(new_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk', 'floppy')
+        os.chmod(self.new_img, 0444)
+        self.vm.add_drive(self.old_img, 'media=disk', 'floppy')
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
         result = self.vm.qmp('blockdev-change-medium', device='drive0',
-                                                       filename=new_img,
+                                                       filename=self.new_img,
                                                        format=iotests.imgfmt,
                                                        read_only_mode='retain')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
     def test_rw_ro_cycle(self):
-        os.chmod(new_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk', 'floppy')
+        os.chmod(self.new_img, 0444)
+        self.vm.add_drive(self.old_img, 'media=disk', 'floppy')
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
         result = self.vm.qmp('blockdev-add',
                              node_name='new',
                              driver=iotests.imgfmt,
                              read_only=True,
-                             file={'filename': new_img,
+                             file={'filename': self.new_img,
                                     'driver': 'file'})
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
         result = self.vm.qmp('x-blockdev-remove-medium', device='drive0')
         self.assert_qmp(result, 'return', {})
@@ -632,11 +639,11 @@ class TestChangeReadOnly(ChangeBaseClass):
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
 
 GeneralChangeTestsBaseClass = None
 TestInitiallyFilled = None
@@ -644,8 +651,10 @@ TestInitiallyEmpty = None
 
 
 class TestBlockJobsAfterCycle(ChangeBaseClass):
+    ChangeBaseClass = ChangeBaseClass
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, old_img, '1M')
+        self.ChangeBaseClass.setUp(self)
+        qemu_img('create', '-f', iotests.imgfmt, self.old_img, '1M')
 
         self.vm = iotests.VM()
         self.vm.add_drive_raw("id=drive0,driver=null-co,if=none")
@@ -665,7 +674,7 @@ class TestBlockJobsAfterCycle(ChangeBaseClass):
         result = self.vm.qmp('blockdev-add',
                              node_name='node0',
                              driver=iotests.imgfmt,
-                             file={'filename': old_img,
+                             file={'filename': self.old_img,
                                    'driver': 'file'})
         self.assert_qmp(result, 'return', {})
 
@@ -674,15 +683,10 @@ class TestBlockJobsAfterCycle(ChangeBaseClass):
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.old_img)
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(old_img)
-        try:
-            os.remove(new_img)
-        except OSError:
-            pass
 
     def test_snapshot_and_commit(self):
         # We need backing file support
@@ -690,15 +694,15 @@ class TestBlockJobsAfterCycle(ChangeBaseClass):
             return
 
         result = self.vm.qmp('blockdev-snapshot-sync', device='drive0',
-                                                       snapshot_file=new_img,
+                                                       snapshot_file=self.new_img,
                                                        format=iotests.imgfmt)
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
-        self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
+        self.assert_qmp(result, 'return[0]/inserted/image/filename', self.new_img)
         self.assert_qmp(result,
                         'return[0]/inserted/image/backing-image/filename',
-                        old_img)
+                        self.old_img)
 
         result = self.vm.qmp('block-commit', device='drive0')
         self.assert_qmp(result, 'return', {})
diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index 8e76e62..91ca06d 100644
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -54,11 +54,12 @@ def transaction_drive_backup(device, target, **kwargs):
 
 
 class Bitmap:
-    def __init__(self, name, drive):
+    def __init__(self, name, drive, workdir=iotests.test_dir):
         self.name = name
         self.drive = drive
         self.num = 0
         self.backups = list()
+        self.workdir = workdir
 
     def base_target(self):
         return (self.drive['backup'], None)
@@ -67,7 +68,7 @@ class Bitmap:
         if num is None:
             num = self.num
         self.num = num + 1
-        base = os.path.join(iotests.test_dir,
+        base = os.path.join(self.workdir,
                             "%s.%s." % (self.drive['id'], self.name))
         suff = "%i.%s" % (num, self.drive['fmt'])
         target = base + "inc" + suff
@@ -85,12 +86,6 @@ class Bitmap:
             try_remove(image)
         self.num -= 1
 
-    def cleanup(self):
-        for backup in self.backups:
-            for image in backup:
-                try_remove(image)
-
-
 class TestIncrementalBackupBase(iotests.QMPTestCase):
     def __init__(self, *args):
         super(TestIncrementalBackupBase, self).__init__(*args)
@@ -98,7 +93,7 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
         self.files = list()
         self.drives = list()
         self.vm = iotests.VM()
-        self.err_img = os.path.join(iotests.test_dir, 'err.%s' % iotests.imgfmt)
+        self.err_img = os.path.join(self.workdir, 'err.%s' % iotests.imgfmt)
 
 
     def setUp(self):
@@ -118,9 +113,9 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
 
     def add_node(self, node_id, fmt=iotests.imgfmt, path=None, backup=None):
         if path is None:
-            path = os.path.join(iotests.test_dir, '%s.%s' % (node_id, fmt))
+            path = os.path.join(self.workdir, '%s.%s' % (node_id, fmt))
         if backup is None:
-            backup = os.path.join(iotests.test_dir,
+            backup = os.path.join(self.workdir,
                                   '%s.full.backup.%s' % (node_id, fmt))
 
         self.drives.append({
@@ -196,7 +191,7 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
 
 
     def add_bitmap(self, name, drive, **kwargs):
-        bitmap = Bitmap(name, drive)
+        bitmap = Bitmap(name, drive, self.workdir)
         self.bitmaps.append(bitmap)
         result = self.vm.qmp('block-dirty-bitmap-add', node=drive['id'],
                              name=bitmap.name, **kwargs)
@@ -273,11 +268,6 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        for bitmap in self.bitmaps:
-            bitmap.cleanup()
-        for filename in self.files:
-            try_remove(filename)
-
 
 
 class TestIncrementalBackup(TestIncrementalBackupBase):
diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index 9e87e1c..8293649 100644
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -23,11 +23,11 @@ import iotests
 import time
 
 class TestStopWithBlockJob(iotests.QMPTestCase):
-    test_img = os.path.join(iotests.test_dir, 'test.img')
-    target_img = os.path.join(iotests.test_dir, 'target.img')
-    base_img = os.path.join(iotests.test_dir, 'base.img')
 
     def setUp(self):
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        self.base_img = os.path.join(self.workdir, 'base.img')
         iotests.qemu_img('create', '-f', iotests.imgfmt, self.base_img, "1G")
         iotests.qemu_img('create', '-f', iotests.imgfmt, self.test_img, "-b", self.base_img)
         iotests.qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x5d 1M 128M', self.test_img)
diff --git a/tests/qemu-iotests/132 b/tests/qemu-iotests/132
index f53ef6e..3ca6f06 100644
--- a/tests/qemu-iotests/132
+++ b/tests/qemu-iotests/132
@@ -23,36 +23,31 @@ import os
 import iotests
 from iotests import qemu_img, qemu_io
 
-test_img = os.path.join(iotests.test_dir, 'test.img')
-target_img = os.path.join(iotests.test_dir, 'target.img')
 
 class TestSingleDrive(iotests.QMPTestCase):
     image_len = 2 * 1024 * 1024 # MB
 
     def setUp(self):
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        self.target_img = os.path.join(self.workdir, 'target.img')
         # Write data to the image so we can compare later
-        qemu_img('create', '-f', iotests.imgfmt, test_img, str(TestSingleDrive.image_len))
-        qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x5d 0 2M', test_img)
+        qemu_img('create', '-f', iotests.imgfmt, self.test_img, str(TestSingleDrive.image_len))
+        qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x5d 0 2M', self.test_img)
 
-        self.vm = iotests.VM().add_drive(test_img, 'discard=unmap')
+        self.vm = iotests.VM().add_drive(self.test_img, 'discard=unmap')
         self.vm.launch()
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
 
     def test_mirror_discard(self):
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img)
+                             target=self.target_img)
         self.assert_qmp(result, 'return', {})
         self.vm.hmp_qemu_io('drive0', 'discard 0 64k')
         self.complete_and_wait('drive0')
         self.vm.shutdown()
-        self.assertTrue(iotests.compare_images(test_img, target_img),
+        self.assertTrue(iotests.compare_images(self.test_img, self.target_img),
                         'target image does not match source after mirroring')
 
 if __name__ == '__main__':
diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index 4b99489..8109d63 100644
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -27,7 +27,6 @@ nsec_per_sec = 1000000000
 op_latency = nsec_per_sec / 1000 # See qtest_latency_ns in accounting.c
 bad_sector = 8192
 bad_offset = bad_sector * 512
-blkdebug_file = os.path.join(iotests.test_dir, 'blkdebug.conf')
 
 class BlockDeviceStatsTestCase(iotests.QMPTestCase):
     test_img = "null-aio://"
@@ -53,7 +52,7 @@ class BlockDeviceStatsTestCase(iotests.QMPTestCase):
         raise Exception("Device not found for blockstats: %s" % device)
 
     def create_blkdebug_file(self):
-        file = open(blkdebug_file, 'w')
+        file = open(self.blkdebug_file, 'w')
         file.write('''
 [inject-error]
 event = "read_aio"
@@ -68,6 +67,7 @@ sector = "%d"
         file.close()
 
     def setUp(self):
+        self.blkdebug_file = os.path.join(self.workdir, 'blkdebug.conf')
         drive_args = []
         drive_args.append("stats-intervals.0=%d" % interval_length)
         drive_args.append("stats-account-invalid=%s" %
@@ -76,7 +76,7 @@ sector = "%d"
                           (self.account_failed and "on" or "off"))
         self.create_blkdebug_file()
         self.vm = iotests.VM().add_drive('blkdebug:%s:%s' %
-                                         (blkdebug_file, self.test_img),
+                                         (self.blkdebug_file, self.test_img),
                                          ','.join(drive_args))
         self.vm.launch()
         # Set an initial value for the clock
@@ -84,7 +84,6 @@ sector = "%d"
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(blkdebug_file)
 
     def accounted_ops(self, read = False, write = False, flush = False):
         ops = 0
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index f8f0280..7699dd2 100644
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -23,8 +23,6 @@ import os
 import iotests
 import time
 
-base_img = os.path.join(iotests.test_dir, 'base.img')
-new_img = os.path.join(iotests.test_dir, 'new.img')
 if iotests.qemu_default_machine == 's390-ccw-virtio':
     default_virtio_blk = 'virtio-blk-ccw'
 else:
@@ -33,7 +31,9 @@ else:
 class TestBlockdevDel(iotests.QMPTestCase):
 
     def setUp(self):
-        iotests.qemu_img('create', '-f', iotests.imgfmt, base_img, '1M')
+        self.base_img = os.path.join(self.workdir, 'base.img')
+        self.new_img = os.path.join(self.workdir, 'new.img')
+        iotests.qemu_img('create', '-f', iotests.imgfmt, self.base_img, '1M')
         self.vm = iotests.VM()
         if iotests.qemu_default_machine == 's390-ccw-virtio':
             self.vm.add_device("virtio-scsi-ccw,id=virtio-scsi")
@@ -44,9 +44,6 @@ class TestBlockdevDel(iotests.QMPTestCase):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(base_img)
-        if os.path.isfile(new_img):
-            os.remove(new_img)
 
     # Check whether a BlockDriverState exists
     def checkBlockDriverState(self, node, must_exist = True):
@@ -64,7 +61,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
                 'node-name': node,
                 'file': {'driver': 'file',
                          'node-name': file_node,
-                         'filename': base_img}}
+                         'filename': self.base_img}}
         result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
         self.assert_qmp(result, 'return', {})
         self.checkBlockDriverState(node)
@@ -74,12 +71,12 @@ class TestBlockdevDel(iotests.QMPTestCase):
     def addBlockDriverStateOverlay(self, node):
         self.checkBlockDriverState(node, False)
         iotests.qemu_img('create', '-u', '-f', iotests.imgfmt,
-                         '-b', base_img, new_img, '1M')
+                         '-b', self.base_img, self.new_img, '1M')
         opts = {'driver': iotests.imgfmt,
                 'node-name': node,
                 'backing': None,
                 'file': {'driver': 'file',
-                         'filename': new_img}}
+                         'filename': self.new_img}}
         result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
         self.assert_qmp(result, 'return', {})
         self.checkBlockDriverState(node)
@@ -143,7 +140,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.checkBlockDriverState(node)
         self.checkBlockDriverState(overlay, False)
         opts = {'node-name': node,
-                'snapshot-file': new_img,
+                'snapshot-file': self.new_img,
                 'snapshot-node-name': overlay,
                 'format': iotests.imgfmt}
         result = self.vm.qmp('blockdev-snapshot-sync', conv_keys=False, **opts)
@@ -166,7 +163,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.checkBlockDriverState(new_node, False)
         opts = {'device': node,
                 'job-id': node,
-                'target': new_img,
+                'target': self.new_img,
                 'node-name': new_node,
                 'sync': 'top',
                 'format': iotests.imgfmt}
@@ -189,7 +186,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         image = {'driver': iotests.imgfmt,
                  'node-name': node,
                  'file': {'driver': 'file',
-                          'filename': base_img}}
+                          'filename': self.base_img}}
         opts = {'driver': 'blkdebug',
                 'node-name': debug,
                 'image': image}
@@ -205,15 +202,15 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.checkBlockDriverState(test, False)
         self.checkBlockDriverState(raw, False)
         self.checkBlockDriverState(blkverify, False)
-        iotests.qemu_img('create', '-f', iotests.imgfmt, new_img, '1M')
+        iotests.qemu_img('create', '-f', iotests.imgfmt, self.new_img, '1M')
         node_0 = {'driver': iotests.imgfmt,
                   'node-name': test,
                   'file': {'driver': 'file',
-                           'filename': base_img}}
+                           'filename': self.base_img}}
         node_1 = {'driver': iotests.imgfmt,
                   'node-name': raw,
                   'file': {'driver': 'file',
-                           'filename': new_img}}
+                           'filename': self.new_img}}
         opts = {'driver': 'blkverify',
                 'node-name': blkverify,
                 'test': node_0,
@@ -229,15 +226,15 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.checkBlockDriverState(child0, False)
         self.checkBlockDriverState(child1, False)
         self.checkBlockDriverState(quorum, False)
-        iotests.qemu_img('create', '-f', iotests.imgfmt, new_img, '1M')
+        iotests.qemu_img('create', '-f', iotests.imgfmt, self.new_img, '1M')
         child_0 = {'driver': iotests.imgfmt,
                    'node-name': child0,
                    'file': {'driver': 'file',
-                            'filename': base_img}}
+                            'filename': self.base_img}}
         child_1 = {'driver': iotests.imgfmt,
                    'node-name': child1,
                    'file': {'driver': 'file',
-                            'filename': new_img}}
+                            'filename': self.new_img}}
         opts = {'driver': 'quorum',
                 'node-name': quorum,
                 'vote-threshold': 1,
diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index db34838..09194cc 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -27,8 +27,6 @@ from iotests import cachemode, imgfmt, qemu_img, qemu_nbd
 
 NBD_PORT = 10811
 
-test_img = os.path.join(iotests.test_dir, 'test.img')
-unix_socket = os.path.join(iotests.test_dir, 'nbd.socket')
 
 
 def flatten_sock_addr(crumpled_address):
@@ -38,6 +36,11 @@ def flatten_sock_addr(crumpled_address):
 
 
 class NBDBlockdevAddBase(iotests.QMPTestCase):
+
+    def setUp(self):
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        self.unix_socket = os.path.join(self.workdir, 'nbd.socket')
+
     def blockdev_add_options(self, address, export=None):
         options = { 'node-name': 'nbd-blockdev',
                     'driver': 'raw',
@@ -70,20 +73,16 @@ class NBDBlockdevAddBase(iotests.QMPTestCase):
 
 class QemuNBD(NBDBlockdevAddBase):
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, test_img, '64k')
+        NBDBlockdevAddBase.setUp(self)
+        qemu_img('create', '-f', iotests.imgfmt, self.test_img, '64k')
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
-        self.assertEqual(qemu_nbd('-f', imgfmt, test_img, *args), 0)
+        self.assertEqual(qemu_nbd('-f', imgfmt, self.test_img, *args), 0)
 
     def test_inet(self):
         self._server_up('-p', str(NBD_PORT))
@@ -96,21 +95,22 @@ class QemuNBD(NBDBlockdevAddBase):
                          flatten_sock_addr(address))
 
     def test_unix(self):
-        self._server_up('-k', unix_socket)
+        self._server_up('-k', self.unix_socket)
         address = { 'type': 'unix',
-                    'data': { 'path': unix_socket } }
-        self.client_test('nbd+unix://?socket=' + unix_socket,
+                    'data': { 'path': self.unix_socket } }
+        self.client_test('nbd+unix://?socket=' + self.unix_socket,
                          flatten_sock_addr(address))
 
 
 class BuiltinNBD(NBDBlockdevAddBase):
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, test_img, '64k')
+        NBDBlockdevAddBase.setUp(self)
+        qemu_img('create', '-f', iotests.imgfmt, self.test_img, '64k')
         self.vm = iotests.VM()
         self.vm.launch()
         self.server = iotests.VM('.server')
         self.server.add_drive_raw('if=none,id=nbd-export,' +
-                                  'file=%s,' % test_img +
+                                  'file=%s,' % self.test_img +
                                   'format=%s,' % imgfmt +
                                   'cache=%s' % cachemode)
         self.server.launch()
@@ -118,11 +118,6 @@ class BuiltinNBD(NBDBlockdevAddBase):
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
@@ -173,18 +168,18 @@ class BuiltinNBD(NBDBlockdevAddBase):
 
     def test_unix(self):
         address = { 'type': 'unix',
-                    'data': { 'path': unix_socket } }
+                    'data': { 'path': self.unix_socket } }
         self._server_up(address)
-        self.client_test('nbd+unix:///nbd-export?socket=' + unix_socket,
+        self.client_test('nbd+unix:///nbd-export?socket=' + self.unix_socket,
                          flatten_sock_addr(address), 'nbd-export')
         self._server_down()
 
     def test_fd(self):
         self._server_up({ 'type': 'unix',
-                          'data': { 'path': unix_socket } })
+                          'data': { 'path': self.unix_socket } })
 
         sockfd = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
-        sockfd.connect(unix_socket)
+        sockfd.connect(self.unix_socket)
 
         result = self.vm.send_fd_scm(str(sockfd.fileno()))
         self.assertEqual(result, 0, 'Failed to send socket FD')
diff --git a/tests/qemu-iotests/148 b/tests/qemu-iotests/148
index e01b061..9e66616 100644
--- a/tests/qemu-iotests/148
+++ b/tests/qemu-iotests/148
@@ -22,14 +22,6 @@
 import os
 import iotests
 
-imgs = (os.path.join(iotests.test_dir, 'quorum0.img'),
-        os.path.join(iotests.test_dir, 'quorum1.img'),
-        os.path.join(iotests.test_dir, 'quorum2.img'))
-
-img_conf = (os.path.join(iotests.test_dir, 'quorum0.conf'),
-            os.path.join(iotests.test_dir, 'quorum1.conf'),
-            os.path.join(iotests.test_dir, 'quorum2.conf'))
-
 event_rate = 1000000000
 sector_size = 512
 offset = 10
@@ -48,15 +40,23 @@ sector = "%d"
         file.close()
 
     def setUp(self):
+        self.imgs = (os.path.join(self.workdir, 'quorum0.img'),
+                     os.path.join(self.workdir, 'quorum1.img'),
+                     os.path.join(self.workdir, 'quorum2.img'))
+
+        self.img_conf = (os.path.join(self.workdir, 'quorum0.conf'),
+                         os.path.join(self.workdir, 'quorum1.conf'),
+                         os.path.join(self.workdir, 'quorum2.conf'))
+
         driveopts = ['driver=quorum', 'vote-threshold=2']
         driveopts.append('read-pattern=%s' % self.read_pattern)
-        for i in range(len(imgs)):
-            iotests.qemu_img('create', '-f', iotests.imgfmt, imgs[i], '1M')
-            self.create_blkdebug_file(img_conf[i], i + offset)
+        for i in range(len(self.imgs)):
+            iotests.qemu_img('create', '-f', iotests.imgfmt, self.imgs[i], '1M')
+            self.create_blkdebug_file(self.img_conf[i], i + offset)
             driveopts.append('children.%d.driver=%s' % (i, iotests.imgfmt))
             driveopts.append('children.%d.file.driver=blkdebug' % i)
-            driveopts.append('children.%d.file.config=%s' % (i, img_conf[i]))
-            driveopts.append('children.%d.file.image.filename=%s' % (i, imgs[i]))
+            driveopts.append('children.%d.file.config=%s' % (i, self.img_conf[i]))
+            driveopts.append('children.%d.file.image.filename=%s' % (i, self.imgs[i]))
             driveopts.append('children.%d.node-name=img%d' % (i, i))
         self.vm = iotests.VM()
         self.vm.add_drive(None, opts = ','.join(driveopts))
@@ -64,9 +64,6 @@ sector = "%d"
 
     def tearDown(self):
         self.vm.shutdown()
-        for i in range(len(imgs)):
-            os.remove(imgs[i])
-            os.remove(img_conf[i])
 
     def do_check_event(self, node, sector = 0):
         if node == None:
@@ -107,7 +104,7 @@ sector = "%d"
 
         # I/O errors in different children: all events are emitted
         delay = 10
-        for i in range(len(imgs)):
+        for i in range(len(self.imgs)):
             self.vm.hmp_qemu_io("drive0", "aio_read %d %d" %
                                 ((offset + i) * sector_size, sector_size))
             self.vm.qtest("clock_step %d" % delay)
@@ -119,7 +116,7 @@ sector = "%d"
 
         # I/O errors in different children: all events are emitted
         delay = 2 * event_rate
-        for i in range(len(imgs)):
+        for i in range(len(self.imgs)):
             self.vm.hmp_qemu_io("drive0", "aio_read %d %d" %
                                 ((offset + i) * sector_size, sector_size))
             self.vm.qtest("clock_step %d" % delay)
diff --git a/tests/qemu-iotests/152 b/tests/qemu-iotests/152
index fec546d..07f713d 100644
--- a/tests/qemu-iotests/152
+++ b/tests/qemu-iotests/152
@@ -22,39 +22,34 @@ import os
 import iotests
 from iotests import qemu_img
 
-test_img = os.path.join(iotests.test_dir, 'test.img')
-target_img = os.path.join(iotests.test_dir, 'target.img')
 
 class TestUnaligned(iotests.QMPTestCase):
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, test_img, '512')
-        self.vm = iotests.VM().add_drive(test_img)
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        self.target_img = os.path.join(self.workdir, 'target.img')
+        qemu_img('create', '-f', iotests.imgfmt, self.test_img, '512')
+        self.vm = iotests.VM().add_drive(self.test_img)
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
-                             granularity=65536, target=target_img)
+                             granularity=65536, target=self.target_img)
         self.complete_and_wait()
         self.vm.shutdown()
-        self.assertEqual(iotests.image_size(test_img), iotests.image_size(target_img),
+        self.assertEqual(iotests.image_size(self.test_img), iotests.image_size(self.target_img),
                          "Target size doesn't match source when granularity when unaligend")
 
     def test_unaligned_with_update(self):
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             granularity=65536, target=target_img)
+                             granularity=65536, target=self.target_img)
         self.wait_ready()
         self.vm.hmp_qemu_io('drive0', 'write 0 512')
         self.complete_and_wait(wait_ready=False)
         self.vm.shutdown()
-        self.assertEqual(iotests.image_size(test_img), iotests.image_size(target_img),
+        self.assertEqual(iotests.image_size(self.test_img), iotests.image_size(self.target_img),
                          "Target size doesn't match source when granularity when unaligend")
 
 
diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index 0b86ea4..66a84e6 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -25,11 +25,6 @@ import os
 import iotests
 from iotests import qemu_img
 
-back0_img = os.path.join(iotests.test_dir, 'back0.' + iotests.imgfmt)
-back1_img = os.path.join(iotests.test_dir, 'back1.' + iotests.imgfmt)
-back2_img = os.path.join(iotests.test_dir, 'back2.' + iotests.imgfmt)
-source_img = os.path.join(iotests.test_dir, 'source.' + iotests.imgfmt)
-target_img = os.path.join(iotests.test_dir, 'target.' + iotests.imgfmt)
 
 
 # Class variables for controlling its behavior:
@@ -51,10 +46,15 @@ class BaseClass(iotests.QMPTestCase):
     target_real_backing = None
 
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, back0_img, '1M')
-        qemu_img('create', '-f', iotests.imgfmt, '-b', back0_img, back1_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-b', back1_img, back2_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-b', back2_img, source_img)
+        self.back0_img = os.path.join(self.workdir, 'back0.' + iotests.imgfmt)
+        self.back1_img = os.path.join(self.workdir, 'back1.' + iotests.imgfmt)
+        self.back2_img = os.path.join(self.workdir, 'back2.' + iotests.imgfmt)
+        self.source_img = os.path.join(self.workdir, 'source.' + iotests.imgfmt)
+        self.target_img = os.path.join(self.workdir, 'target.' + iotests.imgfmt)
+        qemu_img('create', '-f', iotests.imgfmt, self.back0_img, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, '-b', self.back0_img, self.back1_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-b', self.back1_img, self.back2_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-b', self.back2_img, self.source_img)
 
         self.vm = iotests.VM()
         self.vm.add_drive(None, '', 'none')
@@ -66,7 +66,7 @@ class BaseClass(iotests.QMPTestCase):
                              node_name='source',
                              driver=iotests.imgfmt,
                              file={'driver': 'file',
-                                   'filename': source_img})
+                                   'filename': self.source_img})
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('x-blockdev-insert-medium',
@@ -78,15 +78,15 @@ class BaseClass(iotests.QMPTestCase):
         if self.existing:
             if self.target_backing:
                 qemu_img('create', '-f', iotests.imgfmt,
-                         '-b', self.target_backing, target_img, '1M')
+                         '-b', self.target_backing, self.target_img, '1M')
             else:
-                qemu_img('create', '-f', iotests.imgfmt, target_img, '1M')
+                qemu_img('create', '-f', iotests.imgfmt, self.target_img, '1M')
 
             if self.cmd == 'blockdev-mirror':
                 options = { 'node-name': 'target',
                             'driver': iotests.imgfmt,
                             'file': { 'driver': 'file',
-                                      'filename': target_img } }
+                                      'filename': self.target_img } }
                 if self.target_blockdev_backing:
                     options['backing'] = self.target_blockdev_backing
 
@@ -95,14 +95,6 @@ class BaseClass(iotests.QMPTestCase):
 
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
@@ -124,13 +116,13 @@ class BaseClass(iotests.QMPTestCase):
         node = self.findBlockNode('source')
 
         self.assert_qmp(node, 'image' + '/backing-image' * 0 + '/filename',
-                        source_img)
+                        self.source_img)
         self.assert_qmp(node, 'image' + '/backing-image' * 1 + '/filename',
-                        back2_img)
+                        self.back2_img)
         self.assert_qmp(node, 'image' + '/backing-image' * 2 + '/filename',
-                        back1_img)
+                        self.back1_img)
         self.assert_qmp(node, 'image' + '/backing-image' * 3 + '/filename',
-                        back0_img)
+                        self.back0_img)
         self.assert_qmp_absent(node, 'image' + '/backing-image' * 4)
 
     def assertCorrectBackingImage(self, node, default_image):
@@ -163,7 +155,7 @@ class MirrorBaseClass(BaseClass):
             else:
                 mode = 'absolute-paths'
             result = self.vm.qmp(self.cmd, device='drive0', sync=sync,
-                                 target=target_img, format=iotests.imgfmt,
+                                 target=self.target_img, format=iotests.imgfmt,
                                  mode=mode, node_name='target')
 
         self.assert_qmp(result, 'return', {})
@@ -186,14 +178,14 @@ class MirrorBaseClass(BaseClass):
         self.runMirror('top')
 
         node = self.findBlockNode('target', 'drive0')
-        self.assertCorrectBackingImage(node, back2_img)
+        self.assertCorrectBackingImage(node, self.back2_img)
         self.assertIntactSourceBackingChain()
 
     def testNone(self):
         self.runMirror('none')
 
         node = self.findBlockNode('target', 'drive0')
-        self.assertCorrectBackingImage(node, source_img)
+        self.assertCorrectBackingImage(node, self.source_img)
         self.assertIntactSourceBackingChain()
 
 
@@ -233,7 +225,7 @@ class TestCommit(BaseClass):
     existing = False
 
     def testCommit(self):
-        result = self.vm.qmp('block-commit', device='drive0', base=back1_img)
+        result = self.vm.qmp('block-commit', device='drive0', base=self.back1_img)
         self.assert_qmp(result, 'return', {})
 
         self.vm.event_wait('BLOCK_JOB_READY')
@@ -245,9 +237,9 @@ class TestCommit(BaseClass):
 
         node = self.findBlockNode(None, 'drive0')
         self.assert_qmp(node, 'image' + '/backing-image' * 0 + '/filename',
-                        back1_img)
+                        self.back1_img)
         self.assert_qmp(node, 'image' + '/backing-image' * 1 + '/filename',
-                        back0_img)
+                        self.back0_img)
         self.assert_qmp_absent(node, 'image' + '/backing-image' * 2 +
                                '/filename')
 
diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
index 4038423..7940618 100644
--- a/tests/qemu-iotests/163
+++ b/tests/qemu-iotests/163
@@ -21,8 +21,6 @@
 import os, random, iotests, struct, qcow2
 from iotests import qemu_img, qemu_io, image_size
 
-test_img = os.path.join(iotests.test_dir, 'test.img')
-check_img = os.path.join(iotests.test_dir, 'check.img')
 
 def size_to_int(str):
     suff = ['B', 'K', 'M', 'G', 'T']
@@ -81,41 +79,39 @@ class ShrinkBaseClass(iotests.QMPTestCase):
     }
 
     def setUp(self):
+        self.test_img = os.path.join(self.workdir, 'test.img')
+        self.check_img = os.path.join(self.workdir, 'check.img')
         if iotests.imgfmt == 'raw':
-            qemu_img('create', '-f', iotests.imgfmt, test_img, self.image_len)
-            qemu_img('create', '-f', iotests.imgfmt, check_img,
+            qemu_img('create', '-f', iotests.imgfmt, self.test_img, self.image_len)
+            qemu_img('create', '-f', iotests.imgfmt, self.check_img,
                      self.shrink_size)
         else:
             qemu_img('create', '-f', iotests.imgfmt,
                      '-o', 'cluster_size=' + self.cluster_size +
                      ',refcount_bits=' + self.refcount_bits,
-                     test_img, self.image_len)
+                     self.test_img, self.image_len)
             qemu_img('create', '-f', iotests.imgfmt,
                      '-o', 'cluster_size=%s'% self.cluster_size,
-                     check_img, self.shrink_size)
-        qemu_io('-c', 'write -P 0xff 0 ' + self.shrink_size, check_img)
-
-    def tearDown(self):
-        os.remove(test_img)
-        os.remove(check_img)
+                     self.check_img, self.shrink_size)
+        qemu_io('-c', 'write -P 0xff 0 ' + self.shrink_size, self.check_img)
 
     def image_verify(self):
-        self.assertEqual(image_size(test_img), image_size(check_img),
+        self.assertEqual(image_size(self.test_img), image_size(self.check_img),
                          "Verifying image size")
-        self.image_check[iotests.imgfmt](self, test_img)
+        self.image_check[iotests.imgfmt](self, self.test_img)
 
         if iotests.imgfmt == 'raw':
             return
-        self.assertEqual(qemu_img('check', test_img), 0,
+        self.assertEqual(qemu_img('check', self.test_img), 0,
                          "Verifying image corruption")
 
     def test_empty_image(self):
-        qemu_img('resize',  '-f', iotests.imgfmt, '--shrink', test_img,
+        qemu_img('resize',  '-f', iotests.imgfmt, '--shrink', self.test_img,
                  self.shrink_size)
 
         self.assertEqual(
-            qemu_io('-c', 'read -P 0x00 %s'%self.shrink_size, test_img),
-            qemu_io('-c', 'read -P 0x00 %s'%self.shrink_size, check_img),
+            qemu_io('-c', 'read -P 0x00 %s'%self.shrink_size, self.test_img),
+            qemu_io('-c', 'read -P 0x00 %s'%self.shrink_size, self.check_img),
             "Verifying image content")
 
         self.image_verify()
@@ -124,12 +120,12 @@ class ShrinkBaseClass(iotests.QMPTestCase):
         for offs in range(0, size_to_int(self.image_len),
                           size_to_int(self.chunk_size)):
             qemu_io('-c', 'write -P 0xff %d %s' % (offs, self.chunk_size),
-                    test_img)
+                    self.test_img)
 
-        qemu_img('resize',  '-f', iotests.imgfmt, '--shrink', test_img,
+        qemu_img('resize',  '-f', iotests.imgfmt, '--shrink', self.test_img,
                  self.shrink_size)
 
-        self.assertEqual(qemu_img("compare", test_img, check_img), 0,
+        self.assertEqual(qemu_img("compare", self.test_img, self.check_img), 0,
                          "Verifying image content")
 
         self.image_verify()
@@ -140,12 +136,12 @@ class ShrinkBaseClass(iotests.QMPTestCase):
         random.shuffle(offs_list)
         for offs in offs_list:
             qemu_io('-c', 'write -P 0xff %d %s' % (offs, self.chunk_size),
-                    test_img)
+                    self.test_img)
 
-        qemu_img('resize',  '-f', iotests.imgfmt, '--shrink', test_img,
+        qemu_img('resize',  '-f', iotests.imgfmt, '--shrink', self.test_img,
                  self.shrink_size)
 
-        self.assertEqual(qemu_img("compare", test_img, check_img), 0,
+        self.assertEqual(qemu_img("compare", self.test_img, self.check_img), 0,
                          "Verifying image content")
 
         self.image_verify()
diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index a3932db..6672fa9 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -23,7 +23,6 @@ import re
 import iotests
 from iotests import qemu_img
 
-disk = os.path.join(iotests.test_dir, 'disk')
 disk_size = 0x40000000 # 1G
 
 # regions for qemu_io: (start, count) in bytes
@@ -36,16 +35,14 @@ regions2 = ((0x10000000, 0x20000),
 class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, disk, str(disk_size))
-
-    def tearDown(self):
-        os.remove(disk)
+        self.disk = os.path.join(self.workdir, 'disk')
+        qemu_img('create', '-f', iotests.imgfmt, self.disk, str(disk_size))
 
     def mkVm(self):
-        return iotests.VM().add_drive(disk)
+        return iotests.VM().add_drive(self.disk)
 
     def mkVmRo(self):
-        return iotests.VM().add_drive(disk, opts='readonly=on')
+        return iotests.VM().add_drive(self.disk, opts='readonly=on')
 
     def getSha256(self):
         result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
-- 
2.9.5
