Received: from eggs.gnu.org ([2001:4830:134:3::10]:40675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSj-0005Cw-Jw
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSi-0002xm-9c
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:01 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  1 Oct 2018 13:29:22 +0300
Message-Id: <20181001102928.20533-13-vsementsov@virtuozzo.com>
In-Reply-To: <20181001102928.20533-1-vsementsov@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 12/18] iotests: prepare 055 to graph changes
 during backup job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Backup will append fleecing-hook node above source node, so, we can't
resume by device name (because resume don't search recursively through
backing chain).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/055 | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 3437c11507..be5451e1c5 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -48,7 +48,8 @@ class TestSingleDrive(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
 
-        self.vm = iotests.VM().add_drive('blkdebug::' + test_img)
+        self.vm = iotests.VM().add_drive('blkdebug::' + test_img,
+                                         'node-name=source')
         self.vm.add_drive(blockdev_target_img, interface="none")
         if iotests.qemu_default_machine == 'pc':
             self.vm.add_drive(None, 'media=cdrom', 'ide')
@@ -69,7 +70,7 @@ class TestSingleDrive(iotests.QMPTestCase):
         result = self.vm.qmp(cmd, device='drive0', target=target, sync='full')
         self.assert_qmp(result, 'return', {})
 
-        event = self.cancel_and_wait(resume=True)
+        event = self.cancel_and_wait(resume=True, resume_node='source')
         self.assert_qmp(event, 'data/type', 'backup')
 
     def test_cancel_drive_backup(self):
@@ -87,7 +88,7 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
 
         self.pause_job('drive0', wait=False)
-        self.vm.resume_drive('drive0')
+        self.vm.resume_drive('source')
         self.pause_wait('drive0')
 
         result = self.vm.qmp('query-block-jobs')
@@ -165,7 +166,8 @@ class TestSetSpeed(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
 
-        self.vm = iotests.VM().add_drive('blkdebug::' + test_img)
+        self.vm = iotests.VM().add_drive('blkdebug::' + test_img,
+                                         'node-name=source')
         self.vm.add_drive(blockdev_target_img, interface="none")
         self.vm.launch()
 
@@ -197,7 +199,7 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.assert_qmp(result, 'return[0]/device', 'drive0')
         self.assert_qmp(result, 'return[0]/speed', 8 * 1024 * 1024)
 
-        event = self.cancel_and_wait(resume=True)
+        event = self.cancel_and_wait(resume=True, resume_node='source')
         self.assert_qmp(event, 'data/type', 'backup')
 
         # Check setting speed option works
@@ -210,7 +212,7 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.assert_qmp(result, 'return[0]/device', 'drive0')
         self.assert_qmp(result, 'return[0]/speed', 4 * 1024 * 1024)
 
-        event = self.cancel_and_wait(resume=True)
+        event = self.cancel_and_wait(resume=True, resume_node='source')
         self.assert_qmp(event, 'data/type', 'backup')
 
     def test_set_speed_drive_backup(self):
@@ -236,7 +238,7 @@ class TestSetSpeed(iotests.QMPTestCase):
         result = self.vm.qmp('block-job-set-speed', device='drive0', speed=-1)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-        event = self.cancel_and_wait(resume=True)
+        event = self.cancel_and_wait(resume=True, resume_node='source')
         self.assert_qmp(event, 'data/type', 'backup')
 
     def test_set_speed_invalid_drive_backup(self):
@@ -464,7 +466,8 @@ class TestDriveCompression(iotests.QMPTestCase):
             pass
 
     def do_prepare_drives(self, fmt, args, attach_target):
-        self.vm = iotests.VM().add_drive('blkdebug::' + test_img)
+        self.vm = iotests.VM().add_drive('blkdebug::' + test_img,
+                                         'node-name=source')
 
         qemu_img('create', '-f', fmt, blockdev_target_img,
                  str(TestDriveCompression.image_len), *args)
@@ -507,7 +510,7 @@ class TestDriveCompression(iotests.QMPTestCase):
         result = self.vm.qmp(cmd, device='drive0', sync='full', compress=True, **args)
         self.assert_qmp(result, 'return', {})
 
-        event = self.cancel_and_wait(resume=True)
+        event = self.cancel_and_wait(resume=True, resume_node='source')
         self.assert_qmp(event, 'data/type', 'backup')
 
         self.vm.shutdown()
@@ -532,7 +535,7 @@ class TestDriveCompression(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
 
         self.pause_job('drive0', wait=False)
-        self.vm.resume_drive('drive0')
+        self.vm.resume_drive('source')
         self.pause_wait('drive0')
 
         result = self.vm.qmp('query-block-jobs')
-- 
2.18.0
