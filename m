Received: from eggs.gnu.org ([2001:4830:134:3::10]:45815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fhjDi-0002AO-BT
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fhjDg-0007xN-TS
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:22:22 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 23 Jul 2018 18:22:10 -0400
Message-Id: <20180723222210.11077-8-jsnow@redhat.com>
In-Reply-To: <20180723222210.11077-1-jsnow@redhat.com>
References: <20180723222210.11077-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 7/7] iotests: 169: add cases for source
 vm resuming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Test that we can resume source vm after [failed] migration, and bitmaps
are ok.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/169     | 59 +++++++++++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/169.out |  4 ++--
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index 24027da8e1..9cd8853d3c 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -77,6 +77,57 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
             self.assert_qmp(result, 'error/desc',
                             "Dirty bitmap 'bitmap0' not found");
 
+    def do_test_migration_resume_source(self, persistent, migrate_bitmaps):
+        granularity = 512
+
+        # regions = ((start, count), ...)
+        regions = ((0, 0x10000),
+                   (0xf0000, 0x10000),
+                   (0xa0201, 0x1000))
+
+        mig_caps = [{'capability': 'events', 'state': True}]
+        if migrate_bitmaps:
+            mig_caps.append({'capability': 'dirty-bitmaps', 'state': True})
+
+        result = self.vm_a.qmp('migrate-set-capabilities',
+                               capabilities=mig_caps)
+        self.assert_qmp(result, 'return', {})
+
+        self.add_bitmap(self.vm_a, granularity, persistent)
+        for r in regions:
+            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % r)
+        sha256 = self.get_bitmap_hash(self.vm_a)
+
+        result = self.vm_a.qmp('migrate', uri=mig_cmd)
+        while True:
+            event = self.vm_a.event_wait('MIGRATION')
+            if event['data']['status'] == 'completed':
+                break
+
+        # test that bitmap is still here
+        self.check_bitmap(self.vm_a, False if persistent else sha256)
+
+        self.vm_a.qmp('cont')
+
+        # test that bitmap is still here after invalidation
+        self.check_bitmap(self.vm_a, sha256)
+
+        # shutdown and check that invalidation didn't fail
+        self.vm_a.shutdown()
+
+        # catch 'Could not reopen qcow2 layer: Bitmap already exists'
+        # possible error
+        log = self.vm_a.get_log()
+        log = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
+        log = re.sub(r'^(wrote .* bytes at offset .*\n.*KiB.*ops.*sec.*\n){3}',
+                     '', log)
+        log = re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
+        self.assertEqual(log, '')
+
+        # test that bitmap is still persistent
+        self.vm_a.launch()
+        self.check_bitmap(self.vm_a, sha256 if persistent else False)
+
     def do_test_migration(self, persistent, migrate_bitmaps, online,
                           shared_storage):
         granularity = 512
@@ -157,7 +208,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
 
 def inject_test_case(klass, name, method, *args, **kwargs):
     mc = operator.methodcaller(method, *args, **kwargs)
-    setattr(klass, 'test_' + name, new.instancemethod(mc, None, klass))
+    setattr(klass, 'test_' + method + name, new.instancemethod(mc, None, klass))
 
 for cmb in list(itertools.product((True, False), repeat=4)):
     name = ('_' if cmb[0] else '_not_') + 'persistent_'
@@ -168,6 +219,12 @@ for cmb in list(itertools.product((True, False), repeat=4)):
     inject_test_case(TestDirtyBitmapMigration, name, 'do_test_migration',
                      *list(cmb))
 
+for cmb in list(itertools.product((True, False), repeat=2)):
+    name = ('_' if cmb[0] else '_not_') + 'persistent_'
+    name += ('_' if cmb[1] else '_not_') + 'migbitmap'
+
+    inject_test_case(TestDirtyBitmapMigration, name,
+                     'do_test_migration_resume_source', *list(cmb))
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'])
diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/169.out
index b6f257674e..3a89159833 100644
--- a/tests/qemu-iotests/169.out
+++ b/tests/qemu-iotests/169.out
@@ -1,5 +1,5 @@
-................
+....................
 ----------------------------------------------------------------------
-Ran 16 tests
+Ran 20 tests
 
 OK
-- 
2.14.4
