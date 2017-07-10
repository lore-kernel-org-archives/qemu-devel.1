Received: from eggs.gnu.org ([2001:4830:134:3::10]:47108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dUba5-0000fF-W5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dUba3-0001Oz-GP
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:30:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 10 Jul 2017 19:30:28 +0300
Message-Id: <20170710163029.129912-16-vsementsov@virtuozzo.com>
In-Reply-To: <20170710163029.129912-1-vsementsov@virtuozzo.com>
References: <20170710163029.129912-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v7 15/16] iotests: add dirty bitmap migration
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

The test starts two vms (vm_a, vm_b), create dirty bitmap in
the first one, do several writes to corresponding device and
then migrate vm_a to vm_b with dirty bitmaps.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/169     | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/169.out |  5 +++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 92 insertions(+)
 create mode 100755 tests/qemu-iotests/169
 create mode 100644 tests/qemu-iotests/169.out

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
new file mode 100755
index 0000000000..ec6cd46a4d
--- /dev/null
+++ b/tests/qemu-iotests/169
@@ -0,0 +1,86 @@
+#!/usr/bin/env python
+#
+# Tests for dirty bitmaps migration.
+#
+# Copyright (C) Vladimir Sementsov-Ogievskiy 2015-2016
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
+fifo = os.path.join(iotests.test_dir, 'mig_fifo')
+
+class TestDirtyBitmapMigration(iotests.QMPTestCase):
+
+    def setUp(self):
+        size = 0x400000000 # 1G
+        os.mkfifo(fifo)
+        qemu_img('create', '-f', iotests.imgfmt, disk_a, str(size))
+        qemu_img('create', '-f', iotests.imgfmt, disk_b, str(size))
+        self.vm_a = iotests.VM(path_suffix='a').add_drive(disk_a)
+        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b)
+        self.vm_b.add_incoming_migration("exec: cat '" + fifo + "'")
+        self.vm_a.launch()
+        self.vm_b.launch()
+
+    def tearDown(self):
+        self.vm_a.shutdown()
+        self.vm_b.shutdown()
+        os.remove(disk_a)
+        os.remove(disk_b)
+        os.remove(fifo)
+
+    def test_migration(self):
+        granularity = 512
+        regions = [
+            { 'start': 0,           'count': 0x100000 },
+            { 'start': 0x100000000, 'count': 0x200000  },
+            { 'start': 0x399900000, 'count': 0x100000  }
+            ]
+
+        result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
+                               name='bitmap', granularity=granularity)
+        self.assert_qmp(result, 'return', {});
+
+        for r in regions:
+            self.vm_a.hmp_qemu_io('drive0',
+                                  'write %d %d' % (r['start'], r['count']))
+
+        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive0', name='bitmap')
+        sha256 = result['return']['sha256']
+
+        result = self.vm_a.qmp('migrate-set-capabilities',
+                               capabilities=[{'capability': 'dirty-bitmaps',
+                                              'state': True}])
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm_a.qmp('migrate', uri='exec:cat>' + fifo)
+        self.assertNotEqual(self.vm_a.event_wait("STOP"), None)
+        self.assertNotEqual(self.vm_b.event_wait("RESUME"), None)
+        time.sleep(2)
+
+        result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive0', name='bitmap')
+        self.assert_qmp(result, 'return/sha256', sha256);
+
+
+if __name__ == '__main__':
+    iotests.main()
diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/169.out
new file mode 100644
index 0000000000..ae1213e6f8
--- /dev/null
+++ b/tests/qemu-iotests/169.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 40bef995fe..a0b7972879 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -165,6 +165,7 @@
 160 rw auto quick
 162 auto quick
 165 rw auto quick
+169 rw auto quick
 170 rw auto quick
 171 rw auto quick
 172 auto
-- 
2.11.1
