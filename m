Received: from eggs.gnu.org ([2001:4830:134:3::10]:56852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1wc4-0000lo-EP
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 12:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1wc1-00071y-Kh
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 12:10:48 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 30 Mar 2018 19:10:40 +0300
Message-Id: <20180330161040.350271-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] iotests: fix 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Use MIGRATION events instead of RESUME. Also, make a TODO: enable
dirty-bitmaps capability for offline case.

This (likely) fixes racy faults at least of the following types:

    - timeout on waiting for RESUME event
    - sha256 mismatch on 136 (138 after this patch)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

This patch is a true change for the test anyway. But I don't understand,
why (and do really) it fixes the things. And I'm not sure about do we
really have a bug in bitmap migration or persistence. So, it's up to you,
take it into 2.12... 

It was already discussed, that "STOP" event is bad for tests. What about
"RESUME"? How can we miss it? And sha256 mismatch is really something
strange.

Max, please check, do it fix 169 for you.

 tests/qemu-iotests/169 | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index 153b10b6e7..5e525ab9d5 100755
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
@@ -124,9 +119,16 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
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
 
-- 
2.11.1
