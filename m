Received: from eggs.gnu.org ([2001:4830:134:3::10]:53934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEexG-0006JB-7k
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEexC-0004Ns-VU
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:24:58 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 18:24:07 +0100
Message-Id: <20171114172417.7654-11-mreitz@redhat.com>
In-Reply-To: <20171114172417.7654-1-mreitz@redhat.com>
References: <20171114172417.7654-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 10/20] iotests: Make 055 less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

First of all, test 055 does a valiant job of invoking pause_drive()
sometimes, but that is worth nothing without blkdebug.  So the first
thing to do is to sprinkle a couple of "blkdebug::" in there -- with the
exception of the transaction tests, because the blkdebug break points
make the transaction QMP command hang (which is bad).  In that case, we
can get away with throttling the block job that it effectively is
paused.

Then, 055 usually does not pause the drive before starting a block job
that should be cancelled.  This means that the backup job might be
completed already before block-job-cancel is invoked; thus making the
test either fail (currently) or moot if cancel_and_wait() ignored this
condition.  Fix this by pausing the drive before starting the job.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20171109203025.27493-4-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/055 | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index e1206caf9b..8a5d9fd269 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -48,7 +48,7 @@ class TestSingleDrive(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
 
-        self.vm = iotests.VM().add_drive(test_img)
+        self.vm = iotests.VM().add_drive('blkdebug::' + test_img)
         self.vm.add_drive(blockdev_target_img, interface="none")
         if iotests.qemu_default_machine == 'pc':
             self.vm.add_drive(None, 'media=cdrom', 'ide')
@@ -65,10 +65,11 @@ class TestSingleDrive(iotests.QMPTestCase):
     def do_test_cancel(self, cmd, target):
         self.assert_no_active_block_jobs()
 
+        self.vm.pause_drive('drive0')
         result = self.vm.qmp(cmd, device='drive0', target=target, sync='full')
         self.assert_qmp(result, 'return', {})
 
-        event = self.cancel_and_wait()
+        event = self.cancel_and_wait(resume=True)
         self.assert_qmp(event, 'data/type', 'backup')
 
     def test_cancel_drive_backup(self):
@@ -166,7 +167,7 @@ class TestSetSpeed(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
 
-        self.vm = iotests.VM().add_drive(test_img)
+        self.vm = iotests.VM().add_drive('blkdebug::' + test_img)
         self.vm.add_drive(blockdev_target_img, interface="none")
         self.vm.launch()
 
@@ -246,6 +247,8 @@ class TestSetSpeed(iotests.QMPTestCase):
     def test_set_speed_invalid_blockdev_backup(self):
         self.do_test_set_speed_invalid('blockdev-backup',  'drive1')
 
+# Note: We cannot use pause_drive() here, or the transaction command
+#       would stall.  Instead, we limit the block job speed here.
 class TestSingleTransaction(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(image_len))
@@ -271,7 +274,8 @@ class TestSingleTransaction(iotests.QMPTestCase):
                 'type': cmd,
                 'data': { 'device': 'drive0',
                           'target': target,
-                          'sync': 'full' },
+                          'sync': 'full',
+                          'speed': 64 * 1024 },
             }
         ])
 
@@ -289,12 +293,12 @@ class TestSingleTransaction(iotests.QMPTestCase):
     def do_test_pause(self, cmd, target, image):
         self.assert_no_active_block_jobs()
 
-        self.vm.pause_drive('drive0')
         result = self.vm.qmp('transaction', actions=[{
                 'type': cmd,
                 'data': { 'device': 'drive0',
                           'target': target,
-                          'sync': 'full' },
+                          'sync': 'full',
+                          'speed': 64 * 1024 },
             }
         ])
         self.assert_qmp(result, 'return', {})
@@ -302,7 +306,9 @@ class TestSingleTransaction(iotests.QMPTestCase):
         result = self.vm.qmp('block-job-pause', device='drive0')
         self.assert_qmp(result, 'return', {})
 
-        self.vm.resume_drive('drive0')
+        result = self.vm.qmp('block-job-set-speed', device='drive0', speed=0)
+        self.assert_qmp(result, 'return', {})
+
         self.pause_job('drive0')
 
         result = self.vm.qmp('query-block-jobs')
@@ -461,7 +467,7 @@ class TestDriveCompression(iotests.QMPTestCase):
             pass
 
     def do_prepare_drives(self, fmt, args, attach_target):
-        self.vm = iotests.VM().add_drive(test_img)
+        self.vm = iotests.VM().add_drive('blkdebug::' + test_img)
 
         qemu_img('create', '-f', fmt, blockdev_target_img,
                  str(TestDriveCompression.image_len), *args)
@@ -500,10 +506,11 @@ class TestDriveCompression(iotests.QMPTestCase):
 
         self.assert_no_active_block_jobs()
 
+        self.vm.pause_drive('drive0')
         result = self.vm.qmp(cmd, device='drive0', sync='full', compress=True, **args)
         self.assert_qmp(result, 'return', {})
 
-        event = self.cancel_and_wait()
+        event = self.cancel_and_wait(resume=True)
         self.assert_qmp(event, 'data/type', 'backup')
 
         self.vm.shutdown()
-- 
2.13.6
