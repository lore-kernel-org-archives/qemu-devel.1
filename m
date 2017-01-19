Received: from eggs.gnu.org ([2001:4830:134:3::10]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUDrl-0008SK-HK
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUDrf-0003Fy-N3
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:39:05 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 19 Jan 2017 22:38:06 +0800
Message-Id: <20170119143816.21972-7-famz@redhat.com>
In-Reply-To: <20170119143816.21972-1-famz@redhat.com>
References: <20170119143816.21972-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v10 06/16] iotests: 055: Don't attach the drive
 to vm for drive-backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, rjones@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/055 | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 1d3fd04..20a7596 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -455,17 +455,18 @@ class TestDriveCompression(iotests.QMPTestCase):
         except OSError:
             pass
 
-    def do_prepare_drives(self, fmt, args):
+    def do_prepare_drives(self, fmt, args, attach):
         self.vm = iotests.VM().add_drive(test_img)
 
         qemu_img('create', '-f', fmt, blockdev_target_img,
                  str(TestDriveCompression.image_len), *args)
-        self.vm.add_drive(blockdev_target_img, format=fmt)
+        if attach:
+            self.vm.add_drive(blockdev_target_img, format=fmt)
 
         self.vm.launch()
 
-    def do_test_compress_complete(self, cmd, format, **args):
-        self.do_prepare_drives(format['type'], format['args'])
+    def do_test_compress_complete(self, cmd, format, attach, **args):
+        self.do_prepare_drives(format['type'], format['args'], attach)
 
         self.assert_no_active_block_jobs()
 
@@ -481,15 +482,16 @@ class TestDriveCompression(iotests.QMPTestCase):
 
     def test_complete_compress_drive_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_complete('drive-backup', format,
+            self.do_test_compress_complete('drive-backup', format, attach=False,
                                            target=blockdev_target_img, mode='existing')
 
     def test_complete_compress_blockdev_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_complete('blockdev-backup', format, target='drive1')
+            self.do_test_compress_complete('blockdev-backup', format,
+                                           attach=True, target='drive1')
 
-    def do_test_compress_cancel(self, cmd, format, **args):
-        self.do_prepare_drives(format['type'], format['args'])
+    def do_test_compress_cancel(self, cmd, format, attach, **args):
+        self.do_prepare_drives(format['type'], format['args'], attach)
 
         self.assert_no_active_block_jobs()
 
@@ -503,15 +505,16 @@ class TestDriveCompression(iotests.QMPTestCase):
 
     def test_compress_cancel_drive_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_cancel('drive-backup', format,
+            self.do_test_compress_cancel('drive-backup', format, attach=False,
                                          target=blockdev_target_img, mode='existing')
 
     def test_compress_cancel_blockdev_backup(self):
        for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_cancel('blockdev-backup', format, target='drive1')
+            self.do_test_compress_cancel('blockdev-backup', format, attach=True,
+                                         target='drive1')
 
-    def do_test_compress_pause(self, cmd, format, **args):
-        self.do_prepare_drives(format['type'], format['args'])
+    def do_test_compress_pause(self, cmd, format, attach, **args):
+        self.do_prepare_drives(format['type'], format['args'], attach)
 
         self.assert_no_active_block_jobs()
 
@@ -543,12 +546,13 @@ class TestDriveCompression(iotests.QMPTestCase):
 
     def test_compress_pause_drive_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_pause('drive-backup', format,
+            self.do_test_compress_pause('drive-backup', format, attach=False,
                                         target=blockdev_target_img, mode='existing')
 
     def test_compress_pause_blockdev_backup(self):
         for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_pause('blockdev-backup', format, target='drive1')
+            self.do_test_compress_pause('blockdev-backup', format, attach=True,
+                                        target='drive1')
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['raw', 'qcow2'])
-- 
2.9.3
