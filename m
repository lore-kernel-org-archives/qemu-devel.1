Received: from eggs.gnu.org ([2001:4830:134:3::10]:43561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWma-0006iM-Q9
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmZ-00017e-ED
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:43 +0200
Message-Id: <1499447335-6125-89-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 088/100] iotests: test qcow2 persistent dirty
 bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170628120530.31251-27-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/165     | 105 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/165.out |   5 +++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 111 insertions(+)
 create mode 100755 tests/qemu-iotests/165
 create mode 100644 tests/qemu-iotests/165.out

diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
new file mode 100755
index 0000000..74d7b79
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
index 0000000..ae1213e
--- /dev/null
+++ b/tests/qemu-iotests/165.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 613d596..7d86715 100644
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
1.8.3.1
