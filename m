Received: from eggs.gnu.org ([2001:4830:134:3::10]:58822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Pgb-00060p-5W
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Pga-0003rF-4K
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:56:45 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 11:55:55 +0800
Message-Id: <20170421035606.448-10-famz@redhat.com>
In-Reply-To: <20170421035606.448-1-famz@redhat.com>
References: <20170421035606.448-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v14 09/20] iotests: 055: Don't attach the
 target image already for drive-backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Double attach is not a valid usage of the target image, drive-backup
will open the blockdev itself so skip the add_drive call in this case.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/055 | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index aafcd24..ba4da65 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -458,17 +458,18 @@ class TestDriveCompression(iotests.QMPTestCase):
         except OSError:
             pass
 
-    def do_prepare_drives(self, fmt, args):
+    def do_prepare_drives(self, fmt, args, attach_target):
         self.vm = iotests.VM().add_drive(test_img)
 
         qemu_img('create', '-f', fmt, blockdev_target_img,
                  str(TestDriveCompression.image_len), *args)
-        self.vm.add_drive(blockdev_target_img, format=fmt, interface="none")
+        if attach_target:
+            self.vm.add_drive(blockdev_target_img, format=fmt, interface="none")
 
         self.vm.launch()
 
-    def do_test_compress_complete(self, cmd, format, **args):
-        self.do_prepare_drives(format['type'], format['args'])
+    def do_test_compress_complete(self, cmd, format, attach_target, **args):
+        self.do_prepare_drives(format['type'], format['args'], attach_target)
 
         self.assert_no_active_block_jobs()
 
@@ -484,15 +485,16 @@ class TestDriveCompression(iotests.QMPTestCase):
 
     def test_complete_compress_drive_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_complete('drive-backup', format,
+            self.do_test_compress_complete('drive-backup', format, False,
                                            target=blockdev_target_img, mode='existing')
 
     def test_complete_compress_blockdev_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_complete('blockdev-backup', format, target='drive1')
+            self.do_test_compress_complete('blockdev-backup', format, True,
+                                           target='drive1')
 
-    def do_test_compress_cancel(self, cmd, format, **args):
-        self.do_prepare_drives(format['type'], format['args'])
+    def do_test_compress_cancel(self, cmd, format, attach_target, **args):
+        self.do_prepare_drives(format['type'], format['args'], attach_target)
 
         self.assert_no_active_block_jobs()
 
@@ -506,15 +508,16 @@ class TestDriveCompression(iotests.QMPTestCase):
 
     def test_compress_cancel_drive_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_cancel('drive-backup', format,
+            self.do_test_compress_cancel('drive-backup', format, False,
                                          target=blockdev_target_img, mode='existing')
 
     def test_compress_cancel_blockdev_backup(self):
        for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_cancel('blockdev-backup', format, target='drive1')
+            self.do_test_compress_cancel('blockdev-backup', format, True,
+                                         target='drive1')
 
-    def do_test_compress_pause(self, cmd, format, **args):
-        self.do_prepare_drives(format['type'], format['args'])
+    def do_test_compress_pause(self, cmd, format, attach_target, **args):
+        self.do_prepare_drives(format['type'], format['args'], attach_target)
 
         self.assert_no_active_block_jobs()
 
@@ -546,12 +549,13 @@ class TestDriveCompression(iotests.QMPTestCase):
 
     def test_compress_pause_drive_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_pause('drive-backup', format,
+            self.do_test_compress_pause('drive-backup', format, False,
                                         target=blockdev_target_img, mode='existing')
 
     def test_compress_pause_blockdev_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_pause('blockdev-backup', format, target='drive1')
+            self.do_test_compress_pause('blockdev-backup', format, True,
+                                        target='drive1')
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['raw', 'qcow2'])
-- 
2.9.3
