Received: from eggs.gnu.org ([2001:4830:134:3::10]:42147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f6EpJ-0003kk-7e
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f6EpG-0002vQ-46
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:26:13 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 11 Apr 2018 15:26:06 +0300
Message-Id: <20180411122606.367301-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180411122606.367301-1-vsementsov@virtuozzo.com>
References: <20180411122606.367301-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/2] iotests: fix 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, jsnow@redhat.com

Improve and fix 169:
    - use MIGRATION events instead of RESUME
    - make a TODO: enable dirty-bitmaps capability for offline case
    - recreate vm_b without -incoming near test end

This (likely) fixes racy faults at least of the following types:

    - timeout on waiting for RESUME event
    - sha256 mismatch on line 136 (142 after this patch)
    - fail to self.vm_b.launch() on line 135 (141 now after this patch)

And surely fixes cat processes, left after test finish.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/169 | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index 153b10b6e7..f243db9955 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -31,6 +31,8 @@ disk_a = os.path.join(iotests.test_dir, 'disk_a')
 disk_b = os.path.join(iotests.test_dir, 'disk_b')
 size = '1M'
 mig_file = os.path.join(iotests.test_dir, 'mig_file')
+mig_cmd = 'exec: cat > ' + mig_file
+incoming_cmd = 'exec: cat ' + mig_file
 
 
 class TestDirtyBitmapMigration(iotests.QMPTestCase):
@@ -49,7 +51,6 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         self.vm_a.launch()
 
         self.vm_b = iotests.VM(path_suffix='b')
-        self.vm_b.add_incoming("exec: cat '" + mig_file + "'")
 
     def add_bitmap(self, vm, granularity, persistent):
         params = {'node': 'drive0',
@@ -86,36 +87,30 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
                    (0xa0201, 0x1000))
 
         should_migrate = migrate_bitmaps or persistent and shared_storage
+        mig_caps = [{'capability': 'events', 'state': True}]
+        if migrate_bitmaps:
+            mig_caps.append({'capability': 'dirty-bitmaps', 'state': True})
 
+        result = self.vm_a.qmp('migrate-set-capabilities',
+                               capabilities=mig_caps)
+        self.assert_qmp(result, 'return', {})
+
+        self.vm_b.add_incoming(incoming_cmd if online else "defer")
         self.vm_b.add_drive(disk_a if shared_storage else disk_b)
 
         if online:
             os.mkfifo(mig_file)
             self.vm_b.launch()
+            result = self.vm_b.qmp('migrate-set-capabilities',
+                                   capabilities=mig_caps)
+            self.assert_qmp(result, 'return', {})
 
         self.add_bitmap(self.vm_a, granularity, persistent)
         for r in regions:
             self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % r)
         sha256 = self.get_bitmap_hash(self.vm_a)
 
-        if migrate_bitmaps:
-            capabilities = [{'capability': 'dirty-bitmaps', 'state': True}]
-
-            result = self.vm_a.qmp('migrate-set-capabilities',
-                                   capabilities=capabilities)
-            self.assert_qmp(result, 'return', {})
-
-            if online:
-                result = self.vm_b.qmp('migrate-set-capabilities',
-                                       capabilities=capabilities)
-                self.assert_qmp(result, 'return', {})
-
-        result = self.vm_a.qmp('migrate-set-capabilities',
-                               capabilities=[{'capability': 'events',
-                                              'state': True}])
-        self.assert_qmp(result, 'return', {})
-
-        result = self.vm_a.qmp('migrate', uri='exec:cat>' + mig_file)
+        result = self.vm_a.qmp('migrate', uri=mig_cmd)
         while True:
             event = self.vm_a.event_wait('MIGRATION')
             if event['data']['status'] == 'completed':
@@ -124,14 +119,25 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         if not online:
             self.vm_a.shutdown()
             self.vm_b.launch()
-            # TODO enable bitmap capability for vm_b in this case
+            result = self.vm_b.qmp('migrate-set-capabilities',
+                                   capabilities=mig_caps)
+            self.assert_qmp(result, 'return', {})
+            result = self.vm_b.qmp('migrate-incoming', uri=incoming_cmd)
+            self.assert_qmp(result, 'return', {})
 
-        self.vm_b.event_wait("RESUME", timeout=10.0)
+        while True:
+            event = self.vm_b.event_wait('MIGRATION')
+            if event['data']['status'] == 'completed':
+                break
 
         self.check_bitmap(self.vm_b, sha256 if should_migrate else False)
 
         if should_migrate:
             self.vm_b.shutdown()
+            # recreate vm_b, as we don't want -incoming option (this will lead
+            # to "cat" process left alive after test finish)
+            self.vm_b = iotests.VM(path_suffix='b')
+            self.vm_b.add_drive(disk_a if shared_storage else disk_b)
             self.vm_b.launch()
             self.check_bitmap(self.vm_b, sha256 if persistent else False)
 
-- 
2.11.1
