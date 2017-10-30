Received: from eggs.gnu.org ([2001:4830:134:3::10]:43204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9D08-0006LB-He
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9D03-0006bU-Di
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:33:24 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 30 Oct 2017 19:33:09 +0300
Message-Id: <20171030163309.75770-15-vsementsov@virtuozzo.com>
In-Reply-To: <20171030163309.75770-1-vsementsov@virtuozzo.com>
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v8 14/14] iotests: add persistent bitmap
 migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

Test that persistent bitmap migrates and its persistance property
migrates too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/169     | 21 ++++++++++++++++++---
 tests/qemu-iotests/169.out |  4 ++--
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index 4ecef2f23f..b0270f40f7 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -46,7 +46,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         self.vm_a.launch()
         self.vm_b.launch()
 
-    def test_migration(self):
+    def do_test_migration(self, persistent=False):
         self.init(0x400000000) # 1G
         granularity = 512
         regions = [
@@ -55,8 +55,13 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
             { 'start': 0x399900000, 'count': 0x100000  }
             ]
 
-        result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
-                               name='bitmap', granularity=granularity)
+        if persistent:
+            result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
+                                   name='bitmap', granularity=granularity,
+                                   persistent=True, autoload=True)
+        else:
+            result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
+                                   name='bitmap', granularity=granularity)
         self.assert_qmp(result, 'return', {});
 
         for r in regions:
@@ -77,10 +82,20 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         self.assertNotEqual(self.vm_b.event_wait("RESUME"), None)
         time.sleep(2)
 
+        if persistent:
+            self.vm_b.shutdown()
+            self.vm_b.launch()
+
         result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap')
         self.assert_qmp(result, 'return/sha256', sha256);
 
+    def test_migration(self):
+        self.do_test_migration()
+
+    def test_migration_persistent(self):
+        self.do_test_migration(persistent=True)
+
     def test_postcopy(self):
         self.init(0x4000000000) # 256G
         write_size = 0x40000000
diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/169.out
index fbc63e62f8..8d7e996700 100644
--- a/tests/qemu-iotests/169.out
+++ b/tests/qemu-iotests/169.out
@@ -1,5 +1,5 @@
-..
+...
 ----------------------------------------------------------------------
-Ran 2 tests
+Ran 3 tests
 
 OK
-- 
2.11.1
