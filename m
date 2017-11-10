Received: from eggs.gnu.org ([2001:4830:134:3::10]:54306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eDDWU-0002ie-UZ
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:55:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eDDWQ-0006tA-Se
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:55:22 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:48670 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eDDWQ-0006sF-Gn
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:55:18 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 10 Nov 2017 20:54:57 +0300
Message-Id: <20171110175457.30173-1-vsementsov@virtuozzo.com>
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
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, dgilbert@redhat.com, quintela@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Test clearing unknown autoclear_features by qcow2 on incoming
migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all!

This patch shows degradation, added in 2.10 in commit

commit 9c5e6594f15b7364624a3ad40306c396c93a2145
Author: Kevin Wolf <kwolf@redhat.com>
Date:   Thu May 4 18:52:40 2017 +0200

    block: Fix write/resize permissions for inactive images

The problem:
When on incoming migration with shared storage we reopen image to RW mode
we call bdrv_invalidate_cache it firstly call drv->bdrv_invalidate_cache and
only after it, through "parent->role->activate(parent, &local_err);" we set
appropriate RW permission.

Because of this, if drv->bdrv_invalidate_cache wants to write something
(image is RW and BDRV_O_INACTIVE is not set) it goes into
"bdrv_aligned_pwritev: Assertion `child->perm & BLK_PERM_WRITE' failed"

One case, when qcow2_invalidate_cache wants to write
something - when it wants to clear some unknown autoclear features. So,
here is a test for it.

Another case is when we try to migrate persistent dirty bitmaps through
shared storage, on invalidate_cache qcow2 will try to set DIRTY bit in
all loaded bitmaps.

Kevin, what do you think? I understand that operation order should be changed
somehow in bdrv_invalidate_cache, but I'm not sure about how "parent->role->.."
things works and can we safely move this part from function end to the middle.

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
index 24e5ad1b79..78d01d9516 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -193,4 +193,5 @@
 192 rw auto quick
 194 rw auto migration quick
 195 rw auto quick
+196 rw auto quick
 197 rw auto quick
-- 
2.11.1
