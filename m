Received: from eggs.gnu.org ([208.118.235.92]:35037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRgd5-0003uj-P5
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRgd1-0005dw-HC
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:49:58 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 20 Dec 2017 18:49:45 +0300
Message-Id: <20171220154945.88410-14-vsementsov@virtuozzo.com>
In-Reply-To: <20171220154945.88410-1-vsementsov@virtuozzo.com>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v9 13/13] iotests: add dirty bitmap postcopy
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
---
 tests/qemu-iotests/199        | 105 ++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/199.out    |   5 ++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |   7 ++-
 4 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/199
 create mode 100644 tests/qemu-iotests/199.out

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
new file mode 100755
index 0000000000..f872040a81
--- /dev/null
+++ b/tests/qemu-iotests/199
@@ -0,0 +1,105 @@
+#!/usr/bin/env python
+#
+# Tests for dirty bitmaps postcopy migration.
+#
+# Copyright (c) 2016-2017 Virtuozzo International GmbH. All rights reserved.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import os
+import iotests
+import time
+from iotests import qemu_img
+
+disk_a = os.path.join(iotests.test_dir, 'disk_a')
+disk_b = os.path.join(iotests.test_dir, 'disk_b')
+size = '256G'
+fifo = os.path.join(iotests.test_dir, 'mig_fifo')
+
+class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
+
+    def tearDown(self):
+        self.vm_a.shutdown()
+        self.vm_b.shutdown()
+        os.remove(disk_a)
+        os.remove(disk_b)
+        os.remove(fifo)
+
+    def setUp(self):
+        os.mkfifo(fifo)
+        qemu_img('create', '-f', iotests.imgfmt, disk_a, size)
+        qemu_img('create', '-f', iotests.imgfmt, disk_b, size)
+        self.vm_a = iotests.VM(path_suffix='a').add_drive(disk_a)
+        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b)
+        self.vm_b.add_incoming("exec: cat '" + fifo + "'")
+        self.vm_a.launch()
+        self.vm_b.launch()
+
+    def test_postcopy(self):
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
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2'], supported_cache_modes=['none'])
diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/199.out
new file mode 100644
index 0000000000..ae1213e6f8
--- /dev/null
+++ b/tests/qemu-iotests/199.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index e879c7ebc7..7c1f499802 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -197,4 +197,5 @@
 196 rw auto quick
 197 rw auto quick
 198 rw auto
+199 rw auto
 200 rw auto
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
