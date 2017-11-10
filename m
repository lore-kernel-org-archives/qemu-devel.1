Received: from eggs.gnu.org ([2001:4830:134:3::10]:52772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDI1B-0006he-TZ
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDI18-0000ni-N1
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:43:21 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Nov 2017 23:42:59 +0100
Message-Id: <20171110224302.14424-2-mreitz@redhat.com>
In-Reply-To: <20171110224302.14424-1-mreitz@redhat.com>
References: <20171110224302.14424-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 1/4] iotests: Make BD-{remove,
 insert}-medium use @id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

In some cases, these commands still use the deprecated @device
parameter.  Fix that so we can later drop that parameter from their
interface.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/118 | 184 +++++++++++++++++++++++--------------------------
 tests/qemu-iotests/155 |  60 ++++++++--------
 2 files changed, 113 insertions(+), 131 deletions(-)

diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index 8a9e838c90..ca6965d23c 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -28,6 +28,14 @@ from iotests import qemu_img
 old_img = os.path.join(iotests.test_dir, 'test0.img')
 new_img = os.path.join(iotests.test_dir, 'test1.img')
 
+def interface_to_device_name(interface):
+    if interface == 'ide':
+        return 'ide-cd'
+    elif interface == 'floppy':
+        return 'floppy'
+    else:
+        return None
+
 class ChangeBaseClass(iotests.QMPTestCase):
     has_opened = False
     has_closed = False
@@ -63,7 +71,7 @@ class ChangeBaseClass(iotests.QMPTestCase):
 
 class GeneralChangeTestsBaseClass(ChangeBaseClass):
 
-    device_name = None
+    device_name = 'qdev0'
 
     def test_change(self):
         result = self.vm.qmp('change', device='drive0', target=new_img,
@@ -79,14 +87,9 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
     def test_blockdev_change_medium(self):
-        if self.device_name is not None:
-            result = self.vm.qmp('blockdev-change-medium',
-                                 id=self.device_name, filename=new_img,
-                                 format=iotests.imgfmt)
-        else:
-            result = self.vm.qmp('blockdev-change-medium',
-                                 device='drive0', filename=new_img,
-                                 format=iotests.imgfmt)
+        result = self.vm.qmp('blockdev-change-medium',
+                             id=self.device_name, filename=new_img,
+                             format=iotests.imgfmt)
 
         self.assert_qmp(result, 'return', {})
 
@@ -99,10 +102,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
     def test_eject(self):
-        if self.device_name is not None:
-            result = self.vm.qmp('eject', id=self.device_name, force=True)
-        else:
-            result = self.vm.qmp('eject', device='drive0', force=True)
+        result = self.vm.qmp('eject', id=self.device_name, force=True)
         self.assert_qmp(result, 'return', {})
 
         self.wait_for_open()
@@ -113,10 +113,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
     def test_tray_eject_change(self):
-        if self.device_name is not None:
-            result = self.vm.qmp('eject', id=self.device_name, force=True)
-        else:
-            result = self.vm.qmp('eject', device='drive0', force=True)
+        result = self.vm.qmp('eject', id=self.device_name, force=True)
         self.assert_qmp(result, 'return', {})
 
         self.wait_for_open()
@@ -126,12 +123,8 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
             self.assert_qmp(result, 'return[0]/tray_open', True)
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
-        if self.device_name is not None:
-            result = self.vm.qmp('blockdev-change-medium', id=self.device_name,
-                                 filename=new_img, format=iotests.imgfmt)
-        else:
-            result = self.vm.qmp('blockdev-change-medium', device='drive0',
-                                 filename=new_img, format=iotests.imgfmt)
+        result = self.vm.qmp('blockdev-change-medium', id=self.device_name,
+                             filename=new_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'return', {})
 
         self.wait_for_close()
@@ -142,12 +135,8 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
     def test_tray_open_close(self):
-        if self.device_name is not None:
-            result = self.vm.qmp('blockdev-open-tray',
-                                 id=self.device_name, force=True)
-        else:
-            result = self.vm.qmp('blockdev-open-tray',
-                                 device='drive0', force=True)
+        result = self.vm.qmp('blockdev-open-tray',
+                             id=self.device_name, force=True)
         self.assert_qmp(result, 'return', {})
 
         self.wait_for_open()
@@ -160,10 +149,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         else:
             self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        if self.device_name is not None:
-            result = self.vm.qmp('blockdev-close-tray', id=self.device_name)
-        else:
-            result = self.vm.qmp('blockdev-close-tray', device='drive0')
+        result = self.vm.qmp('blockdev-close-tray', id=self.device_name)
         self.assert_qmp(result, 'return', {})
 
         if self.has_real_tray or not self.was_empty:
@@ -178,7 +164,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
             self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
     def test_tray_eject_close(self):
-        result = self.vm.qmp('eject', device='drive0', force=True)
+        result = self.vm.qmp('eject', id=self.device_name, force=True)
         self.assert_qmp(result, 'return', {})
 
         self.wait_for_open()
@@ -188,10 +174,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
             self.assert_qmp(result, 'return[0]/tray_open', True)
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
-        if self.device_name is not None:
-            result = self.vm.qmp('blockdev-close-tray', id=self.device_name)
-        else:
-            result = self.vm.qmp('blockdev-close-tray', device='drive0')
+        result = self.vm.qmp('blockdev-close-tray', id=self.device_name)
         self.assert_qmp(result, 'return', {})
 
         self.wait_for_close()
@@ -202,7 +185,8 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
     def test_tray_open_change(self):
-        result = self.vm.qmp('blockdev-open-tray', device='drive0', force=True)
+        result = self.vm.qmp('blockdev-open-tray', id=self.device_name,
+                                                   force=True)
         self.assert_qmp(result, 'return', {})
 
         self.wait_for_open()
@@ -215,7 +199,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         else:
             self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-change-medium', device='drive0',
+        result = self.vm.qmp('blockdev-change-medium', id=self.device_name,
                                                        filename=new_img,
                                                        format=iotests.imgfmt)
         self.assert_qmp(result, 'return', {})
@@ -235,12 +219,8 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
                                     'driver': 'file'})
         self.assert_qmp(result, 'return', {})
 
-        if self.device_name is not None:
-            result = self.vm.qmp('blockdev-open-tray',
-                                 id=self.device_name, force=True)
-        else:
-            result = self.vm.qmp('blockdev-open-tray',
-                                 device='drive0', force=True)
+        result = self.vm.qmp('blockdev-open-tray',
+                             id=self.device_name, force=True)
         self.assert_qmp(result, 'return', {})
 
         self.wait_for_open()
@@ -253,11 +233,8 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         else:
             self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        if self.device_name is not None:
-            result = self.vm.qmp('x-blockdev-remove-medium',
-                                 id=self.device_name)
-        else:
-            result = self.vm.qmp('x-blockdev-remove-medium', device='drive0')
+        result = self.vm.qmp('x-blockdev-remove-medium',
+                             id=self.device_name)
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
@@ -265,12 +242,8 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
             self.assert_qmp(result, 'return[0]/tray_open', True)
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
-        if self.device_name is not None:
-            result = self.vm.qmp('x-blockdev-insert-medium',
-                                 id=self.device_name, node_name='new')
-        else:
-            result = self.vm.qmp('x-blockdev-insert-medium',
-                                 device='drive0', node_name='new')
+        result = self.vm.qmp('x-blockdev-insert-medium',
+                             id=self.device_name, node_name='new')
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
@@ -278,10 +251,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
             self.assert_qmp(result, 'return[0]/tray_open', True)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
-        if self.device_name is not None:
-            result = self.vm.qmp('blockdev-close-tray', id=self.device_name)
-        else:
-            result = self.vm.qmp('blockdev-close-tray', device='drive0')
+        result = self.vm.qmp('blockdev-close-tray', id=self.device_name)
         self.assert_qmp(result, 'return', {})
 
         self.wait_for_close()
@@ -292,7 +262,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
     def test_close_on_closed(self):
-        result = self.vm.qmp('blockdev-close-tray', device='drive0')
+        result = self.vm.qmp('blockdev-close-tray', id=self.device_name)
         # Should be a no-op
         self.assert_qmp(result, 'return', {})
         self.assertEquals(self.vm.get_qmp_events(wait=False), [])
@@ -301,7 +271,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         if not self.has_real_tray:
             return
 
-        result = self.vm.qmp('x-blockdev-remove-medium', device='drive0')
+        result = self.vm.qmp('x-blockdev-remove-medium', id=self.device_name)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
     def test_insert_on_closed(self):
@@ -315,7 +285,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
                                    'driver': 'file'})
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('x-blockdev-insert-medium', device='drive0',
+        result = self.vm.qmp('x-blockdev-insert-medium', id=self.device_name,
                                                        node_name='new')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
@@ -326,12 +296,10 @@ class TestInitiallyFilled(GeneralChangeTestsBaseClass):
         qemu_img('create', '-f', iotests.imgfmt, old_img, '1440k')
         qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
         self.vm = iotests.VM()
-        if interface == 'ide':
-            self.device_name = 'qdev0'
-            self.vm.add_drive(old_img, 'media=%s' % media, 'none')
-            self.vm.add_device('ide-cd,drive=drive0,id=%s' % self.device_name)
-        else:
-            self.vm.add_drive(old_img, 'media=%s' % media, interface)
+        self.vm.add_drive(old_img, 'media=%s' % media, 'none')
+        self.vm.add_device('%s,drive=drive0,id=%s' %
+                           (interface_to_device_name(interface),
+                            self.device_name))
         self.vm.launch()
 
     def tearDown(self):
@@ -347,12 +315,12 @@ class TestInitiallyFilled(GeneralChangeTestsBaseClass):
                                    'driver': 'file'})
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('blockdev-open-tray', device='drive0')
+        result = self.vm.qmp('blockdev-open-tray', id=self.device_name)
         self.assert_qmp(result, 'return', {})
 
         self.wait_for_open()
 
-        result = self.vm.qmp('x-blockdev-insert-medium', device='drive0',
+        result = self.vm.qmp('x-blockdev-insert-medium', id=self.device_name,
                                                        node_name='new')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
@@ -361,7 +329,10 @@ class TestInitiallyEmpty(GeneralChangeTestsBaseClass):
 
     def setUp(self, media, interface):
         qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
-        self.vm = iotests.VM().add_drive(None, 'media=%s' % media, interface)
+        self.vm = iotests.VM().add_drive(None, 'media=%s' % media, 'none')
+        self.vm.add_device('%s,drive=drive0,id=%s' %
+                           (interface_to_device_name(interface),
+                            self.device_name))
         self.vm.launch()
 
     def tearDown(self):
@@ -369,12 +340,12 @@ class TestInitiallyEmpty(GeneralChangeTestsBaseClass):
         os.remove(new_img)
 
     def test_remove_on_empty(self):
-        result = self.vm.qmp('blockdev-open-tray', device='drive0')
+        result = self.vm.qmp('blockdev-open-tray', id=self.device_name)
         self.assert_qmp(result, 'return', {})
 
         self.wait_for_open()
 
-        result = self.vm.qmp('x-blockdev-remove-medium', device='drive0')
+        result = self.vm.qmp('x-blockdev-remove-medium', id=self.device_name)
         # Should be a no-op
         self.assert_qmp(result, 'return', {})
 
@@ -410,6 +381,8 @@ class TestFloppyInitiallyEmpty(TestInitiallyEmpty):
         self.has_opened = True
 
 class TestChangeReadOnly(ChangeBaseClass):
+    device_name = 'qdev0'
+
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, old_img, '1440k')
         qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
@@ -425,14 +398,15 @@ class TestChangeReadOnly(ChangeBaseClass):
     def test_ro_ro_retain(self):
         os.chmod(old_img, 0444)
         os.chmod(new_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk,read-only=on', 'floppy')
+        self.vm.add_drive(old_img, 'media=disk,read-only=on', 'none')
+        self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-change-medium', device='drive0',
+        result = self.vm.qmp('blockdev-change-medium', id=self.device_name,
                                                        filename=new_img,
                                                        format=iotests.imgfmt,
                                                        read_only_mode='retain')
@@ -444,14 +418,15 @@ class TestChangeReadOnly(ChangeBaseClass):
 
     def test_ro_rw_retain(self):
         os.chmod(old_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk,read-only=on', 'floppy')
+        self.vm.add_drive(old_img, 'media=disk,read-only=on', 'none')
+        self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-change-medium', device='drive0',
+        result = self.vm.qmp('blockdev-change-medium', id=self.device_name,
                                                        filename=new_img,
                                                        format=iotests.imgfmt,
                                                        read_only_mode='retain')
@@ -463,14 +438,15 @@ class TestChangeReadOnly(ChangeBaseClass):
 
     def test_rw_ro_retain(self):
         os.chmod(new_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk', 'floppy')
+        self.vm.add_drive(old_img, 'media=disk', 'none')
+        self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-change-medium', device='drive0',
+        result = self.vm.qmp('blockdev-change-medium', id=self.device_name,
                                                        filename=new_img,
                                                        format=iotests.imgfmt,
                                                        read_only_mode='retain')
@@ -484,7 +460,8 @@ class TestChangeReadOnly(ChangeBaseClass):
 
     def test_ro_rw(self):
         os.chmod(old_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk,read-only=on', 'floppy')
+        self.vm.add_drive(old_img, 'media=disk,read-only=on', 'none')
+        self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
@@ -492,7 +469,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
         result = self.vm.qmp('blockdev-change-medium',
-                             device='drive0',
+                             id=self.device_name,
                              filename=new_img,
                              format=iotests.imgfmt,
                              read_only_mode='read-write')
@@ -504,7 +481,8 @@ class TestChangeReadOnly(ChangeBaseClass):
 
     def test_rw_ro(self):
         os.chmod(new_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk', 'floppy')
+        self.vm.add_drive(old_img, 'media=disk', 'none')
+        self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
@@ -512,7 +490,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
         result = self.vm.qmp('blockdev-change-medium',
-                             device='drive0',
+                             id=self.device_name,
                              filename=new_img,
                              format=iotests.imgfmt,
                              read_only_mode='read-only')
@@ -523,7 +501,8 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
     def test_make_rw_ro(self):
-        self.vm.add_drive(old_img, 'media=disk', 'floppy')
+        self.vm.add_drive(old_img, 'media=disk', 'none')
+        self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
@@ -531,7 +510,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
         result = self.vm.qmp('blockdev-change-medium',
-                             device='drive0',
+                             id=self.device_name,
                              filename=new_img,
                              format=iotests.imgfmt,
                              read_only_mode='read-only')
@@ -543,7 +522,8 @@ class TestChangeReadOnly(ChangeBaseClass):
 
     def test_make_ro_rw(self):
         os.chmod(new_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk', 'floppy')
+        self.vm.add_drive(old_img, 'media=disk', 'none')
+        self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
@@ -551,7 +531,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
         result = self.vm.qmp('blockdev-change-medium',
-                             device='drive0',
+                             id=self.device_name,
                              filename=new_img,
                              format=iotests.imgfmt,
                              read_only_mode='read-write')
@@ -563,14 +543,15 @@ class TestChangeReadOnly(ChangeBaseClass):
 
     def test_make_rw_ro_by_retain(self):
         os.chmod(old_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk,read-only=on', 'floppy')
+        self.vm.add_drive(old_img, 'media=disk,read-only=on', 'none')
+        self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-change-medium', device='drive0',
+        result = self.vm.qmp('blockdev-change-medium', id=self.device_name,
                                                        filename=new_img,
                                                        format=iotests.imgfmt,
                                                        read_only_mode='retain')
@@ -582,14 +563,15 @@ class TestChangeReadOnly(ChangeBaseClass):
 
     def test_make_ro_rw_by_retain(self):
         os.chmod(new_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk', 'floppy')
+        self.vm.add_drive(old_img, 'media=disk', 'none')
+        self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-change-medium', device='drive0',
+        result = self.vm.qmp('blockdev-change-medium', id=self.device_name,
                                                        filename=new_img,
                                                        format=iotests.imgfmt,
                                                        read_only_mode='retain')
@@ -601,7 +583,8 @@ class TestChangeReadOnly(ChangeBaseClass):
 
     def test_rw_ro_cycle(self):
         os.chmod(new_img, 0444)
-        self.vm.add_drive(old_img, 'media=disk', 'floppy')
+        self.vm.add_drive(old_img, 'media=disk', 'none')
+        self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
@@ -620,13 +603,13 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('x-blockdev-remove-medium', device='drive0')
+        result = self.vm.qmp('x-blockdev-remove-medium', id=self.device_name)
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
-        result = self.vm.qmp('x-blockdev-insert-medium', device='drive0',
+        result = self.vm.qmp('x-blockdev-insert-medium', id=self.device_name,
                                                        node_name='new')
         self.assert_qmp(result, 'return', {})
 
@@ -644,11 +627,14 @@ TestInitiallyEmpty = None
 
 
 class TestBlockJobsAfterCycle(ChangeBaseClass):
+    device_name = 'qdev0'
+
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, old_img, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, old_img, '1440K')
 
         self.vm = iotests.VM()
         self.vm.add_drive_raw("id=drive0,driver=null-co,if=none")
+        self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
         self.vm.launch()
 
         result = self.vm.qmp('query-block')
@@ -656,7 +642,7 @@ class TestBlockJobsAfterCycle(ChangeBaseClass):
 
         # For device-less BBs, calling blockdev-open-tray or blockdev-close-tray
         # is not necessary
-        result = self.vm.qmp('x-blockdev-remove-medium', device='drive0')
+        result = self.vm.qmp('x-blockdev-remove-medium', id=self.device_name)
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
@@ -669,7 +655,7 @@ class TestBlockJobsAfterCycle(ChangeBaseClass):
                                    'driver': 'file'})
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('x-blockdev-insert-medium', device='drive0',
+        result = self.vm.qmp('x-blockdev-insert-medium', id=self.device_name,
                                                        node_name='node0')
         self.assert_qmp(result, 'return', {})
 
diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index 0b86ea4e5c..fc9fa975be 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -51,36 +51,30 @@ class BaseClass(iotests.QMPTestCase):
     target_real_backing = None
 
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, back0_img, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, back0_img, '1440K')
         qemu_img('create', '-f', iotests.imgfmt, '-b', back0_img, back1_img)
         qemu_img('create', '-f', iotests.imgfmt, '-b', back1_img, back2_img)
         qemu_img('create', '-f', iotests.imgfmt, '-b', back2_img, source_img)
 
         self.vm = iotests.VM()
-        self.vm.add_drive(None, '', 'none')
-        self.vm.launch()
-
         # Add the BDS via blockdev-add so it stays around after the mirror block
         # job has been completed
-        result = self.vm.qmp('blockdev-add',
-                             node_name='source',
-                             driver=iotests.imgfmt,
-                             file={'driver': 'file',
-                                   'filename': source_img})
-        self.assert_qmp(result, 'return', {})
-
-        result = self.vm.qmp('x-blockdev-insert-medium',
-                             device='drive0', node_name='source')
-        self.assert_qmp(result, 'return', {})
+        blockdev = {'node-name': 'source',
+                    'driver': iotests.imgfmt,
+                    'file': {'driver': 'file',
+                             'filename': source_img}}
+        self.vm.add_blockdev(self.qmp_to_opts(blockdev))
+        self.vm.add_device('floppy,id=qdev0,drive=source')
+        self.vm.launch()
 
         self.assertIntactSourceBackingChain()
 
         if self.existing:
             if self.target_backing:
                 qemu_img('create', '-f', iotests.imgfmt,
-                         '-b', self.target_backing, target_img, '1M')
+                         '-b', self.target_backing, target_img, '1440K')
             else:
-                qemu_img('create', '-f', iotests.imgfmt, target_img, '1M')
+                qemu_img('create', '-f', iotests.imgfmt, target_img, '1440K')
 
             if self.cmd == 'blockdev-mirror':
                 options = { 'node-name': 'target',
@@ -104,11 +98,11 @@ class BaseClass(iotests.QMPTestCase):
         except OSError:
             pass
 
-    def findBlockNode(self, node_name, id=None):
-        if id:
+    def findBlockNode(self, node_name, qdev=None):
+        if qdev:
             result = self.vm.qmp('query-block')
             for device in result['return']:
-                if device['device'] == id:
+                if device['qdev'] == qdev:
                     if node_name:
                         self.assert_qmp(device, 'inserted/node-name', node_name)
                     return device['inserted']
@@ -118,7 +112,7 @@ class BaseClass(iotests.QMPTestCase):
                 if node['node-name'] == node_name:
                     return node
 
-        self.fail('Cannot find node %s/%s' % (id, node_name))
+        self.fail('Cannot find node %s/%s' % (qdev, node_name))
 
     def assertIntactSourceBackingChain(self):
         node = self.findBlockNode('source')
@@ -155,22 +149,23 @@ class BaseClass(iotests.QMPTestCase):
 class MirrorBaseClass(BaseClass):
     def runMirror(self, sync):
         if self.cmd == 'blockdev-mirror':
-            result = self.vm.qmp(self.cmd, device='drive0', sync=sync,
-                                 target='target')
+            result = self.vm.qmp(self.cmd, job_id='mirror-job', device='source',
+                                 sync=sync, target='target')
         else:
             if self.existing:
                 mode = 'existing'
             else:
                 mode = 'absolute-paths'
-            result = self.vm.qmp(self.cmd, device='drive0', sync=sync,
-                                 target=target_img, format=iotests.imgfmt,
-                                 mode=mode, node_name='target')
+            result = self.vm.qmp(self.cmd, job_id='mirror-job', device='source',
+                                 sync=sync, target=target_img,
+                                 format=iotests.imgfmt, mode=mode,
+                                 node_name='target')
 
         self.assert_qmp(result, 'return', {})
 
         self.vm.event_wait('BLOCK_JOB_READY')
 
-        result = self.vm.qmp('block-job-complete', device='drive0')
+        result = self.vm.qmp('block-job-complete', device='mirror-job')
         self.assert_qmp(result, 'return', {})
 
         self.vm.event_wait('BLOCK_JOB_COMPLETED')
@@ -178,21 +173,21 @@ class MirrorBaseClass(BaseClass):
     def testFull(self):
         self.runMirror('full')
 
-        node = self.findBlockNode('target', 'drive0')
+        node = self.findBlockNode('target', 'qdev0')
         self.assertCorrectBackingImage(node, None)
         self.assertIntactSourceBackingChain()
 
     def testTop(self):
         self.runMirror('top')
 
-        node = self.findBlockNode('target', 'drive0')
+        node = self.findBlockNode('target', 'qdev0')
         self.assertCorrectBackingImage(node, back2_img)
         self.assertIntactSourceBackingChain()
 
     def testNone(self):
         self.runMirror('none')
 
-        node = self.findBlockNode('target', 'drive0')
+        node = self.findBlockNode('target', 'qdev0')
         self.assertCorrectBackingImage(node, source_img)
         self.assertIntactSourceBackingChain()
 
@@ -233,17 +228,18 @@ class TestCommit(BaseClass):
     existing = False
 
     def testCommit(self):
-        result = self.vm.qmp('block-commit', device='drive0', base=back1_img)
+        result = self.vm.qmp('block-commit', job_id='commit-job',
+                             device='source', base=back1_img)
         self.assert_qmp(result, 'return', {})
 
         self.vm.event_wait('BLOCK_JOB_READY')
 
-        result = self.vm.qmp('block-job-complete', device='drive0')
+        result = self.vm.qmp('block-job-complete', device='commit-job')
         self.assert_qmp(result, 'return', {})
 
         self.vm.event_wait('BLOCK_JOB_COMPLETED')
 
-        node = self.findBlockNode(None, 'drive0')
+        node = self.findBlockNode(None, 'qdev0')
         self.assert_qmp(node, 'image' + '/backing-image' * 0 + '/filename',
                         back1_img)
         self.assert_qmp(node, 'image' + '/backing-image' * 1 + '/filename',
-- 
2.13.6
