Received: from eggs.gnu.org ([2001:4830:134:3::10]:43271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9D0A-0006Me-Jj
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9D03-0006cX-La
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:33:26 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 30 Oct 2017 19:33:08 +0300
Message-Id: <20171030163309.75770-14-vsementsov@virtuozzo.com>
In-Reply-To: <20171030163309.75770-1-vsementsov@virtuozzo.com>
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v8 13/14] iotests: add dirty bitmap postcopy
 test
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

Test
- start two vms (vm_a, vm_b)

- in a
    - do writes from set A
    - do writes from set B
    - fix bitmap sha256
    - clear bitmap
    - do writes from set A
    - start migration
- than, in b
    - wait vm start (postcopy should start)
    - do writes from set B
    - check bitmap sha256

The test should verify postcopy migration and then merging with delta
(changes in target, during postcopy process).

Reduce supported cache modes to only 'none', because with cache on time
from source.STOP to target.RESUME is unpredictable and we can fail with
timout while waiting for target.RESUME.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/169        | 74 +++++++++++++++++++++++++++++++++++++------
 tests/qemu-iotests/169.out    |  4 +--
 tests/qemu-iotests/iotests.py |  7 +++-
 3 files changed, 72 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index 7630ecbe51..4ecef2f23f 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -29,8 +29,14 @@ fifo = os.path.join(iotests.test_dir, 'mig_fifo')
 
 class TestDirtyBitmapMigration(iotests.QMPTestCase):
 
-    def setUp(self):
-        size = 0x400000000 # 1G
+    def tearDown(self):
+        self.vm_a.shutdown()
+        self.vm_b.shutdown()
+        os.remove(disk_a)
+        os.remove(disk_b)
+        os.remove(fifo)
+
+    def init(self, size):
         os.mkfifo(fifo)
         qemu_img('create', '-f', iotests.imgfmt, disk_a, str(size))
         qemu_img('create', '-f', iotests.imgfmt, disk_b, str(size))
@@ -40,14 +46,8 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         self.vm_a.launch()
         self.vm_b.launch()
 
-    def tearDown(self):
-        self.vm_a.shutdown()
-        self.vm_b.shutdown()
-        os.remove(disk_a)
-        os.remove(disk_b)
-        os.remove(fifo)
-
     def test_migration(self):
+        self.init(0x400000000) # 1G
         granularity = 512
         regions = [
             { 'start': 0,           'count': 0x100000 },
@@ -81,6 +81,60 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
                                node='drive0', name='bitmap')
         self.assert_qmp(result, 'return/sha256', sha256);
 
+    def test_postcopy(self):
+        self.init(0x4000000000) # 256G
+        write_size = 0x40000000
+        granularity = 512
+        chunk = 4096
+
+        result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
+                               name='bitmap', granularity=granularity)
+        self.assert_qmp(result, 'return', {});
+
+        s = 0
+        while s < write_size:
+            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
+            s += 0x10000
+        s = 0x8000
+        while s < write_size:
+            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
+            s += 0x10000
+
+        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive0', name='bitmap')
+        sha256 = result['return']['sha256']
+
+        result = self.vm_a.qmp('block-dirty-bitmap-clear', node='drive0',
+                               name='bitmap')
+        self.assert_qmp(result, 'return', {});
+        s = 0
+        while s < write_size:
+            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
+            s += 0x10000
+
+        result = self.vm_a.qmp('migrate-set-capabilities',
+                               capabilities=[{'capability': 'dirty-bitmaps',
+                                              'state': True}])
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm_a.qmp('migrate', uri='exec:cat>' + fifo)
+        self.assertNotEqual(self.vm_a.event_wait("STOP"), None)
+        self.assertNotEqual(self.vm_b.event_wait("RESUME"), None)
+
+        s = 0x8000
+        while s < write_size:
+            self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
+            s += 0x10000
+
+        result = self.vm_b.qmp('query-block');
+        while len(result['return'][0]['dirty-bitmaps']) > 1:
+            time.sleep(2)
+            result = self.vm_b.qmp('query-block');
+
+        result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive0', name='bitmap')
+
+        self.assert_qmp(result, 'return/sha256', sha256);
 
 if __name__ == '__main__':
-    iotests.main()
+    iotests.main(supported_fmts=['qcow2'], supported_cache_modes=['none'])
diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/169.out
index ae1213e6f8..fbc63e62f8 100644
--- a/tests/qemu-iotests/169.out
+++ b/tests/qemu-iotests/169.out
@@ -1,5 +1,5 @@
-.
+..
 ----------------------------------------------------------------------
-Ran 1 tests
+Ran 2 tests
 
 OK
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 95454c1893..88f73d6441 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -432,6 +432,10 @@ def verify_platform(supported_oses=['linux']):
     if True not in [sys.platform.startswith(x) for x in supported_oses]:
         notrun('not suitable for this OS: %s' % sys.platform)
 
+def verify_cache_mode(supported_cache_modes=[]):
+    if supported_cache_modes and (cachemode not in supported_cache_modes):
+        notrun('not suitable for this cache mode: %s' % cachemode)
+
 def supports_quorum():
     return 'quorum' in qemu_img_pipe('--help')
 
@@ -440,7 +444,7 @@ def verify_quorum():
     if not supports_quorum():
         notrun('quorum support missing')
 
-def main(supported_fmts=[], supported_oses=['linux']):
+def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[]):
     '''Run tests'''
 
     global debug
@@ -457,6 +461,7 @@ def main(supported_fmts=[], supported_oses=['linux']):
     verbosity = 1
     verify_image_format(supported_fmts)
     verify_platform(supported_oses)
+    verify_cache_mode(supported_cache_modes)
 
     # We need to filter out the time taken from the output so that qemu-iotest
     # can reliably diff the results against master output.
-- 
2.11.1
