Received: from eggs.gnu.org ([2001:4830:134:3::10]:34753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrG1-0000om-7P
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFz-0005pk-PK
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1evrFz-0005ou-GV
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:51 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 13 Mar 2018 17:14:40 -0400
Message-Id: <20180313211441.5179-13-jsnow@redhat.com>
In-Reply-To: <20180313211441.5179-1-jsnow@redhat.com>
References: <20180313211441.5179-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 12/13] iotests: add dirty bitmap migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

The test starts two vms (vm_a, vm_b), create dirty bitmap in
the first one, do several writes to corresponding device and
then migrate vm_a to vm_b.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20180313180320.339796-13-vsementsov@virtuozzo.com
---
 tests/qemu-iotests/169     | 156 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/169.out |   5 ++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 162 insertions(+)
 create mode 100755 tests/qemu-iotests/169
 create mode 100644 tests/qemu-iotests/169.out

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
new file mode 100755
index 0000000000..3a8db91f6f
--- /dev/null
+++ b/tests/qemu-iotests/169
@@ -0,0 +1,156 @@
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
+import itertools
+import operator
+import new
+from iotests import qemu_img
+
+
+disk_a = os.path.join(iotests.test_dir, 'disk_a')
+disk_b = os.path.join(iotests.test_dir, 'disk_b')
+size = '1M'
+mig_file = os.path.join(iotests.test_dir, 'mig_file')
+
+
+class TestDirtyBitmapMigration(iotests.QMPTestCase):
+    def tearDown(self):
+        self.vm_a.shutdown()
+        self.vm_b.shutdown()
+        os.remove(disk_a)
+        os.remove(disk_b)
+        os.remove(mig_file)
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, disk_a, size)
+        qemu_img('create', '-f', iotests.imgfmt, disk_b, size)
+
+        self.vm_a = iotests.VM(path_suffix='a').add_drive(disk_a)
+        self.vm_a.launch()
+
+        self.vm_b = iotests.VM(path_suffix='b')
+        self.vm_b.add_incoming("exec: cat '" + mig_file + "'")
+
+    def add_bitmap(self, vm, granularity, persistent):
+        params = {'node': 'drive0',
+                  'name': 'bitmap0',
+                  'granularity': granularity}
+        if persistent:
+            params['persistent'] = True
+            params['autoload'] = True
+
+        result = vm.qmp('block-dirty-bitmap-add', **params)
+        self.assert_qmp(result, 'return', {});
+
+    def get_bitmap_hash(self, vm):
+        result = vm.qmp('x-debug-block-dirty-bitmap-sha256',
+                        node='drive0', name='bitmap0')
+        return result['return']['sha256']
+
+    def check_bitmap(self, vm, sha256):
+        result = vm.qmp('x-debug-block-dirty-bitmap-sha256',
+                        node='drive0', name='bitmap0')
+        if sha256:
+            self.assert_qmp(result, 'return/sha256', sha256);
+        else:
+            self.assert_qmp(result, 'error/desc',
+                            "Dirty bitmap 'bitmap0' not found");
+
+    def do_test_migration(self, persistent, migrate_bitmaps, online,
+                          shared_storage):
+        granularity = 512
+
+        # regions = ((start, count), ...)
+        regions = ((0, 0x10000),
+                   (0xf0000, 0x10000),
+                   (0xa0201, 0x1000))
+
+        should_migrate = migrate_bitmaps or persistent and shared_storage
+
+        self.vm_b.add_drive(disk_a if shared_storage else disk_b)
+
+        if online:
+            os.mkfifo(mig_file)
+            self.vm_b.launch()
+
+        self.add_bitmap(self.vm_a, granularity, persistent)
+        for r in regions:
+            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % r)
+        sha256 = self.get_bitmap_hash(self.vm_a)
+
+        if migrate_bitmaps:
+            capabilities = [{'capability': 'dirty-bitmaps', 'state': True}]
+
+            result = self.vm_a.qmp('migrate-set-capabilities',
+                                   capabilities=capabilities)
+            self.assert_qmp(result, 'return', {})
+
+            if online:
+                result = self.vm_b.qmp('migrate-set-capabilities',
+                                       capabilities=capabilities)
+                self.assert_qmp(result, 'return', {})
+
+        result = self.vm_a.qmp('migrate-set-capabilities',
+                               capabilities=[{'capability': 'events',
+                                              'state': True}])
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm_a.qmp('migrate', uri='exec:cat>' + mig_file)
+        while True:
+            event = self.vm_a.event_wait('MIGRATION')
+            if event['data']['status'] == 'completed':
+                break
+
+        if not online:
+            self.vm_a.shutdown()
+            self.vm_b.launch()
+            # TODO enable bitmap capability for vm_b in this case
+
+        self.vm_b.event_wait("RESUME", timeout=10.0)
+
+        self.check_bitmap(self.vm_b, sha256 if should_migrate else False)
+
+        if should_migrate:
+            self.vm_b.shutdown()
+            self.vm_b.launch()
+            self.check_bitmap(self.vm_b, sha256 if persistent else False)
+
+
+def inject_test_case(klass, name, method, *args, **kwargs):
+    mc = operator.methodcaller(method, *args, **kwargs)
+    setattr(klass, 'test_' + name, new.instancemethod(mc, None, klass))
+
+for cmb in list(itertools.product((True, False), repeat=3)):
+    name = ('_' if cmb[0] else '_not_') + 'persistent_'
+    name += ('_' if cmb[1] else '_not_') + 'migbitmap_'
+    name += '_online' if cmb[2] else '_offline'
+
+    # TODO fix shared-storage bitmap migration and enable cases for it
+    args = list(cmb) + [False]
+
+    inject_test_case(TestDirtyBitmapMigration, name, 'do_test_migration',
+                     *args)
+
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2'])
diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/169.out
new file mode 100644
index 0000000000..594c16f49f
--- /dev/null
+++ b/tests/qemu-iotests/169.out
@@ -0,0 +1,5 @@
+........
+----------------------------------------------------------------------
+Ran 8 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index c401791fcd..c7dc59897e 100644
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
2.14.3
