Received: from eggs.gnu.org ([2001:4830:134:3::10]:59285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dxYW5-0003hM-0B
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dxYW1-0008Db-Q2
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:06:12 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 28 Sep 2017 16:06:05 +0300
Message-Id: <20170928130605.79666-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170912094622.GC29136@localhost.localdomain>
References: <20170912094622.GC29136@localhost.localdomain>
Subject: [Qemu-devel] [PATCH] iotests: test clearing unknown
 autoclear_features by qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mreitz@redhat.com
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

Test clearing unknown autoclear_features by qcow2 on incoming
migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Here is a test, related to this problem, which fails with SIGABRT on master
and is successful on 2.9

I've tried to fix it by some interchanges in bdrv_invalidate_cache but
unsuccessfully...

 tests/qemu-iotests/196     | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/196.out |  5 ++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 69 insertions(+)
 create mode 100755 tests/qemu-iotests/196
 create mode 100644 tests/qemu-iotests/196.out

diff --git a/tests/qemu-iotests/196 b/tests/qemu-iotests/196
new file mode 100755
index 0000000000..9ffbc723c2
--- /dev/null
+++ b/tests/qemu-iotests/196
@@ -0,0 +1,63 @@
+#!/usr/bin/env python
+#
+# Test clearing unknown autoclear_features flag by qcow2 after
+# migration. This test mimics migration to older qemu.
+#
+# Copyright (c) 2017 Parallels International GmbH
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
+from iotests import qemu_img
+
+disk = os.path.join(iotests.test_dir, 'disk')
+migfile = os.path.join(iotests.test_dir, 'migfile')
+
+class TestInvalidateAutoclear(iotests.QMPTestCase):
+
+    def tearDown(self):
+        self.vm_a.shutdown()
+        self.vm_b.shutdown()
+        os.remove(disk)
+        os.remove(migfile)
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, disk, '1M')
+
+        self.vm_a = iotests.VM(path_suffix='a').add_drive(disk)
+        self.vm_a.launch()
+
+        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk)
+        self.vm_b.add_incoming("exec: cat '" + migfile + "'")
+
+    def test_migration(self):
+        result = self.vm_a.qmp('migrate', uri='exec:cat>' + migfile)
+        self.assert_qmp(result, 'return', {});
+        self.assertNotEqual(self.vm_a.event_wait("STOP"), None)
+
+        with open(disk, 'r+b') as f:
+            f.seek(88) # first byte of autoclear_features field
+            f.write(b'\xff')
+
+        self.vm_b.launch()
+        self.assertNotEqual(self.vm_b.event_wait("RESUME"), None)
+
+        with open(disk, 'rb') as f:
+            f.seek(88)
+            self.assertEqual(f.read(1), b'\x00')
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2'])
diff --git a/tests/qemu-iotests/196.out b/tests/qemu-iotests/196.out
new file mode 100644
index 0000000000..ae1213e6f8
--- /dev/null
+++ b/tests/qemu-iotests/196.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index cdccee319e..be219ca5fd 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -191,3 +191,4 @@
 192 rw auto quick
 194 rw auto migration quick
 195 rw auto quick
+196 rw auto quick
-- 
2.11.1
