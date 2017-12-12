Received: from eggs.gnu.org ([2001:4830:134:3::10]:55150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eOn3h-0001Sl-JQ
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 11:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eOn3f-00066t-Pu
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 11:05:29 -0500
Received: from [195.214.232.25] (port=19424 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eOn3f-00063t-6i
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 11:05:27 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 12 Dec 2017 19:04:50 +0300
Message-Id: <20171212160450.17510-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171212160450.17510-1-vsementsov@virtuozzo.com>
References: <20171212160450.17510-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 3/3] iotests: add dirty bitmap migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, crosa@redhat.com, ehabkost@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, jsnow@redhat.com

The test creates two vms (vm_a, vm_b), create dirty bitmap in
the first one, do several writes to corresponding device and
then migrate vm_a to vm_b with dirty bitmaps.

For now, only migration through shared storage for persistent
bitmaps is available, so it is tested here. Only offline variant
is tested for now (a kind of suspend-resume), as it is needed
to test that this case is successfully fixed by recent patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/169     | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/169.out |  5 +++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 88 insertions(+)
 create mode 100755 tests/qemu-iotests/169
 create mode 100644 tests/qemu-iotests/169.out

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
new file mode 100755
index 0000000000..282970df8a
--- /dev/null
+++ b/tests/qemu-iotests/169
@@ -0,0 +1,82 @@
+#!/usr/bin/env python
+#
+# Tests for dirty bitmaps migration.
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
+disk = os.path.join(iotests.test_dir, 'disk')
+migfile = os.path.join(iotests.test_dir, 'migfile')
+
+class TestPersistentDirtyBitmapSuspendResume(iotests.QMPTestCase):
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
+    def test_migration_persistent_shared_offline(self):
+        """ A kind of suspend-resume """
+        granularity = 512
+        regions = [
+            { 'start': 0,           'count': 0x10000 },
+            { 'start': 0xf0000,     'count': 0x10000 },
+            { 'start': 0xa0201,     'count': 0x1000  }
+            ]
+
+        result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
+                               name='bitmap0', granularity=granularity,
+                               persistent=True, autoload=True)
+        self.assert_qmp(result, 'return', {});
+
+        for r in regions:
+            self.vm_a.hmp_qemu_io('drive0',
+                                  'write %d %d' % (r['start'], r['count']))
+
+        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive0', name='bitmap0')
+        sha256 = result['return']['sha256']
+
+        result = self.vm_a.qmp('migrate', uri='exec:cat>' + migfile)
+        self.assert_qmp(result, 'return', {});
+        self.assertNotEqual(self.vm_a.event_wait("STOP"), None)
+        self.vm_a.shutdown()
+
+        self.vm_b.launch()
+        self.vm_b.event_wait("RESUME", timeout=10.0)
+
+        result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive0', name='bitmap0')
+        self.assert_qmp(result, 'return/sha256', sha256);
+
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2'])
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
index 3e688678dd..e879c7ebc7 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -169,6 +169,7 @@
 162 auto quick
 163 rw auto quick
 165 rw auto quick
+169 rw auto quick
 170 rw auto quick
 171 rw auto quick
 172 auto
-- 
2.11.1
