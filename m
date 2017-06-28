Received: from eggs.gnu.org ([2001:4830:134:3::10]:60317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj5-0006QL-S3
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj2-00032T-UM
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:43 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:33625 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQBj2-0002v5-H1
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:40 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Jun 2017 15:05:26 +0300
Message-Id: <20170628120530.31251-27-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-1-vsementsov@virtuozzo.com>
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v22 26/30] iotests: test qcow2 persistent dirty
 bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/165     | 105 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/165.out |   5 +++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 111 insertions(+)
 create mode 100755 tests/qemu-iotests/165
 create mode 100644 tests/qemu-iotests/165.out

diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
new file mode 100755
index 0000000000..74d7b79a0b
--- /dev/null
+++ b/tests/qemu-iotests/165
@@ -0,0 +1,105 @@
+#!/usr/bin/env python
+#
+# Tests for persistent dirty bitmaps.
+#
+# Copyright: Vladimir Sementsov-Ogievskiy 2015-2017
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
+import re
+import iotests
+from iotests import qemu_img
+
+disk = os.path.join(iotests.test_dir, 'disk')
+disk_size = 0x40000000 # 1G
+
+# regions for qemu_io: (start, count) in bytes
+regions1 = ((0,        0x100000),
+            (0x200000, 0x100000))
+
+regions2 = ((0x10000000, 0x20000),
+            (0x3fff0000, 0x10000))
+
+class TestPersistentDirtyBitmap(iotests.QMPTestCase):
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, disk, str(disk_size))
+
+    def tearDown(self):
+        os.remove(disk)
+
+    def mkVm(self):
+        return iotests.VM().add_drive(disk)
+
+    def mkVmRo(self):
+        return iotests.VM().add_drive(disk, opts='readonly=on')
+
+    def getSha256(self):
+        result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
+                             node='drive0', name='bitmap0')
+        return result['return']['sha256']
+
+    def checkBitmap(self, sha256):
+        result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
+                             node='drive0', name='bitmap0')
+        self.assert_qmp(result, 'return/sha256', sha256);
+
+    def writeRegions(self, regions):
+        for r in regions:
+            self.vm.hmp_qemu_io('drive0',
+                                'write %d %d' % r)
+
+    def qmpAddBitmap(self):
+        self.vm.qmp('block-dirty-bitmap-add', node='drive0',
+                    name='bitmap0', persistent=True, autoload=True)
+
+    def test_persistent(self):
+        self.vm = self.mkVm()
+        self.vm.launch()
+        self.qmpAddBitmap()
+
+        self.writeRegions(regions1)
+        sha256 = self.getSha256()
+
+        self.vm.shutdown()
+
+        self.vm = self.mkVmRo()
+        self.vm.launch()
+        self.vm.shutdown()
+
+        #catch 'Persistent bitmaps are lost' possible error
+        log = self.vm.get_log()
+        log = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
+        log = re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
+        if log:
+            print log
+
+        self.vm = self.mkVm()
+        self.vm.launch()
+
+        self.checkBitmap(sha256)
+        self.writeRegions(regions2)
+        sha256 = self.getSha256()
+
+        self.vm.shutdown()
+        self.vm.launch()
+
+        self.checkBitmap(sha256)
+
+        self.vm.shutdown()
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2'])
diff --git a/tests/qemu-iotests/165.out b/tests/qemu-iotests/165.out
new file mode 100644
index 0000000000..ae1213e6f8
--- /dev/null
+++ b/tests/qemu-iotests/165.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index a6acafffd7..ad09b8005b 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -163,6 +163,7 @@
 159 rw auto quick
 160 rw auto quick
 162 auto quick
+165 rw auto quick
 170 rw auto quick
 171 rw auto quick
 172 auto
-- 
2.11.1
