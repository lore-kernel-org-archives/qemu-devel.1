Received: from eggs.gnu.org ([2001:4830:134:3::10]:46645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFis2-0003HX-Ia
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFis1-0008CK-DB
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:47:58 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 16:47:39 +0100
Message-Id: <20171117154739.32565-3-kwolf@redhat.com>
In-Reply-To: <20171117154739.32565-1-kwolf@redhat.com>
References: <20171117154739.32565-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 2/2] iotests: test clearing unknown
 autoclear_features by qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Test clearing unknown autoclear_features by qcow2 on incoming
migration.

[ kwolf: Fixed wait for destination VM startup ]

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/196     | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/196.out |  5 ++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 72 insertions(+)
 create mode 100755 tests/qemu-iotests/196
 create mode 100644 tests/qemu-iotests/196.out

diff --git a/tests/qemu-iotests/196 b/tests/qemu-iotests/196
new file mode 100755
index 0000000000..4116ebc92b
--- /dev/null
+++ b/tests/qemu-iotests/196
@@ -0,0 +1,66 @@
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
+        while True:
+            result = self.vm_b.qmp('query-status')
+            if result['return']['status'] == 'running':
+                break
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
index 83b839bbe3..1fad602152 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -193,5 +193,6 @@
 192 rw auto quick
 194 rw auto migration quick
 195 rw auto quick
+196 rw auto quick
 197 rw auto quick
 198 rw auto
-- 
2.13.6
