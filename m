Received: from eggs.gnu.org ([2001:4830:134:3::10]:51630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvUIc-0004tr-8B
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 17:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvUIa-0003KX-0R
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 17:16:18 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 30 Aug 2018 17:16:05 -0400
Message-Id: <20180830211605.13683-3-jsnow@redhat.com>
In-Reply-To: <20180830211605.13683-1-jsnow@redhat.com>
References: <20180830211605.13683-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] HACK: test blockdev-backup instead of
 drive-backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

This is just a real chainsaw job on 124 to prove that we can
indeed use blockdev-backup interchangeably with drive-backup
for incremental backups.

A nicer test will follow once I refactor this a bit to look
a little less like the Texas Chainsaw Massacre.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/124 | 99 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 67 insertions(+), 32 deletions(-)

diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index 3ea4ac53f5..b5a1f5e248 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -49,7 +49,7 @@ def transaction_bitmap_clear(node, name, **kwargs):
 
 
 def transaction_drive_backup(device, target, **kwargs):
-    return transaction_action('drive-backup', job_id=device, device=device,
+    return transaction_action('blockdev-backup', job_id=device, device=device,
                               target=target, **kwargs)
 
 
@@ -146,10 +146,22 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
 
 
     def do_qmp_backup(self, error='Input/output error', **kwargs):
-        res = self.vm.qmp('drive-backup', **kwargs)
+        res = self.vm.qmp('blockdev-backup', **kwargs)
         self.assert_qmp(res, 'return', {})
         return self.wait_qmp_backup(kwargs['device'], error)
 
+    def _FIXME_new_target(self, name, fmt, filename):
+        result = self.vm.qmp('blockdev-add',
+                             node_name=name,
+                             driver=fmt,
+                             file={"driver": "file",
+                                   "filename": filename})
+        self.assert_qmp(result, 'return', {})
+
+    def _FIXME_del_target(self, name):
+        result = self.vm.qmp('blockdev-del',
+                             node_name=name)
+        self.assert_qmp(result, 'return', {})
 
     def ignore_job_status_change_events(self):
         while True:
@@ -185,11 +197,13 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
     def create_anchor_backup(self, drive=None):
         if drive is None:
             drive = self.drives[-1]
+        self.img_create(drive['backup'], drive['fmt'])
+        self._FIXME_new_target('target', drive['fmt'], drive['backup'])
         res = self.do_qmp_backup(job_id=drive['id'],
                                  device=drive['id'], sync='full',
-                                 format=drive['fmt'], target=drive['backup'])
+                                 target='target')
+        self._FIXME_del_target('target')
         self.assertTrue(res)
-        self.files.append(drive['backup'])
         return drive['backup']
 
 
@@ -197,9 +211,12 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
         if bitmap is None:
             bitmap = self.bitmaps[-1]
         _, reference = bitmap.last_target()
+        self.img_create(reference, bitmap.drive['fmt'])
+        self._FIXME_new_target('target', bitmap.drive['fmt'], reference)
         res = self.do_qmp_backup(job_id=bitmap.drive['id'],
                                  device=bitmap.drive['id'], sync='full',
-                                 format=bitmap.drive['fmt'], target=reference)
+                                 target='target')
+        self._FIXME_del_target('target')
         self.assertTrue(res)
 
 
@@ -223,19 +240,19 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
         return target
 
 
-    def create_incremental(self, bitmap=None, parent=None,
-                           parentFormat=None, validate=True):
+    def create_incremental(self, bitmap=None, parent=None, validate=True):
         if bitmap is None:
             bitmap = self.bitmaps[-1]
         if parent is None:
             parent, _ = bitmap.last_target()
 
         target = self.prepare_backup(bitmap, parent)
+        self._FIXME_new_target('target', bitmap.drive['fmt'], target)
         res = self.do_qmp_backup(job_id=bitmap.drive['id'],
                                  device=bitmap.drive['id'],
                                  sync='incremental', bitmap=bitmap.name,
-                                 format=bitmap.drive['fmt'], target=target,
-                                 mode='existing')
+                                 target='target')
+        self._FIXME_del_target('target')
         if not res:
             bitmap.del_target();
             self.assertFalse(validate)
@@ -331,10 +348,11 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
 
         # Create a cluster_size=128k full backup / "anchor" backup
         self.img_create(drive0['backup'], cluster_size='128k')
+        self.img_create(drive0['backup'], drive0['fmt'])
+        self._FIXME_new_target('target', drive0['fmt'], drive0['backup'])
         self.assertTrue(self.do_qmp_backup(device=drive0['id'], sync='full',
-                                           format=drive0['fmt'],
-                                           target=drive0['backup'],
-                                           mode='existing'))
+                                           target='target'))
+        self._FIXME_del_target('target')
 
         # Create bitmap and dirty it with some new writes.
         # overwrite [32736, 32799] which will dirty bitmap clusters at
@@ -356,12 +374,12 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
         self.img_create(target, bitmap0.drive['fmt'], cluster_size='128k')
 
         # Perform Incremental Backup
+        self._FIXME_new_target('target', bitmap0.drive['fmt'], target)
         self.assertTrue(self.do_qmp_backup(device=bitmap0.drive['id'],
                                            sync='incremental',
                                            bitmap=bitmap0.name,
-                                           format=bitmap0.drive['fmt'],
-                                           target=target,
-                                           mode='existing'))
+                                           target='target'))
+        self._FIXME_del_target('target')
         self.make_reference_backup(bitmap0)
 
         # Add the backing file, then compare and exit.
@@ -388,15 +406,18 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
                                           ('0x64', '32736k', '64k')))
         bitmap1 = self.add_bitmap('bitmap1', drive0)
 
+        # Create and mount image
+        self.img_create(drive0['backup'], drive0['fmt'])
+        self._FIXME_new_target('target', drive0['fmt'], drive0['backup'])
+
         result = self.vm.qmp('transaction', actions=[
             transaction_bitmap_clear(bitmap0.drive['id'], bitmap0.name),
             transaction_bitmap_clear(bitmap1.drive['id'], bitmap1.name),
-            transaction_drive_backup(drive0['id'], drive0['backup'],
-                                     sync='full', format=drive0['fmt'])
+            transaction_drive_backup(drive0['id'], 'target', sync='full')
         ])
         self.assert_qmp(result, 'return', {})
         self.wait_until_completed(drive0['id'])
-        self.files.append(drive0['backup'])
+        self._FIXME_del_target('target')
 
         self.hmp_io_writes(drive0['id'], (('0x9a', 0, 512),
                                           ('0x55', '8M', '352k'),
@@ -464,16 +485,18 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
         target0 = self.prepare_backup(dr0bm0)
         target1 = self.prepare_backup(dr1bm0)
 
+        # Mount targets
+        self._FIXME_new_target('target0', drive0['fmt'], target0)
+        self._FIXME_new_target('target1', drive1['fmt'], target1)
+
         # Ask for a new incremental backup per-each drive,
         # expecting drive1's backup to fail. In the 'race' test,
         # we expect drive1 to attempt to cancel the empty drive0 job.
         transaction = [
-            transaction_drive_backup(drive0['id'], target0, sync='incremental',
-                                     format=drive0['fmt'], mode='existing',
-                                     bitmap=dr0bm0.name),
-            transaction_drive_backup(drive1['id'], target1, sync='incremental',
-                                     format=drive1['fmt'], mode='existing',
-                                     bitmap=dr1bm0.name)
+            transaction_drive_backup(drive0['id'], 'target0',
+                                     sync='incremental', bitmap=dr0bm0.name),
+            transaction_drive_backup(drive1['id'], 'target1',
+                                     sync='incremental', bitmap=dr1bm0.name)
         ]
         result = self.vm.qmp('transaction', actions=transaction,
                              properties={'completion-mode': 'grouped'} )
@@ -490,6 +513,10 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
         self.assertFalse(self.vm.get_qmp_events(wait=False))
         self.assert_no_active_block_jobs()
 
+        # Unmount targets
+        self._FIXME_del_target('target0')
+        self._FIXME_del_target('target1')
+
         # Delete drive0's successful target and eliminate our record of the
         # unsuccessful drive1 target.
         dr0bm0.del_target()
@@ -499,9 +526,11 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
             self.vm.shutdown()
             return
 
-        # Re-run the same transaction:
+        # Re-run the same transaction; create and mount images
         target0 = self.prepare_backup(dr0bm0)
         target1 = self.prepare_backup(dr1bm0)
+        self._FIXME_new_target('target0', drive0['fmt'], target0)
+        self._FIXME_new_target('target1', drive1['fmt'], target1)
 
         # Re-run the exact same transaction.
         result = self.vm.qmp('transaction', actions=transaction,
@@ -516,6 +545,9 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
         self.assertFalse(self.vm.get_qmp_events(wait=False))
         self.assert_no_active_block_jobs()
 
+        self._FIXME_del_target('target0')
+        self._FIXME_del_target('target1')
+
         # And the images should of course validate.
         self.vm.shutdown()
         self.check_backups()
@@ -544,19 +576,22 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
 
     def test_sync_dirty_bitmap_missing(self):
         self.assert_no_active_block_jobs()
-        self.files.append(self.err_img)
-        result = self.vm.qmp('drive-backup', device=self.drives[0]['id'],
-                             sync='incremental', format=self.drives[0]['fmt'],
-                             target=self.err_img)
+        self.img_create(self.err_img, iotests.imgfmt)
+        self._FIXME_new_target('err0', iotests.imgfmt, self.err_img)
+        result = self.vm.qmp('blockdev-backup', device=self.drives[0]['id'],
+                             sync='incremental', target='err0')
+        self._FIXME_del_target('err0')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
 
     def test_sync_dirty_bitmap_not_found(self):
         self.assert_no_active_block_jobs()
-        self.files.append(self.err_img)
-        result = self.vm.qmp('drive-backup', device=self.drives[0]['id'],
+        self.img_create(self.err_img, iotests.imgfmt)
+        self._FIXME_new_target('err0', iotests.imgfmt, self.err_img)
+        result = self.vm.qmp('blockdev-backup', device=self.drives[0]['id'],
                              sync='incremental', bitmap='unknown',
-                             format=self.drives[0]['fmt'], target=self.err_img)
+                             target='err0')
+        self._FIXME_del_target('err0')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
 
-- 
2.14.4
