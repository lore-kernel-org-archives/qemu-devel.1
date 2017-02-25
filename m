Received: from eggs.gnu.org ([2001:4830:134:3::10]:33997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chi4c-0000X2-0U
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 14:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chi4Z-0007oa-Bt
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 14:32:05 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 25 Feb 2017 22:31:52 +0300
Message-Id: <20170225193155.447462-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170225193155.447462-1-vsementsov@virtuozzo.com>
References: <20170225193155.447462-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/4] iotests: add migration corner cases test
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/175     | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/175.out |  5 ++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 77 insertions(+)
 create mode 100644 tests/qemu-iotests/175
 create mode 100644 tests/qemu-iotests/175.out

diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
new file mode 100644
index 0000000000..ef86c70db5
--- /dev/null
+++ b/tests/qemu-iotests/175
@@ -0,0 +1,71 @@
+#!/usr/bin/env python
+#
+# Test migration corner-cases
+#
+# Copyright (C) Vladimir Sementsov-Ogievskiy 2017
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
+
+class TestMigrationCornerCases(iotests.QMPTestCase):
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, disk, '10M')
+        self.vm = iotests.VM().add_drive(disk)
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+        os.remove(disk)
+
+    def test_migrate_reset_cont_write(self):
+        result = self.vm.qmp('migrate', uri='exec:cat>/dev/null')
+        self.assert_qmp(result, 'return', {})
+        time.sleep(4)
+
+        result = self.vm.qmp('human-monitor-command',
+                             command_line='system_reset')
+        self.assert_qmp(result, 'return', '')
+
+        result = self.vm.qmp('cont')
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('human-monitor-command',
+                             command_line='qemu-io drive0 "write 0 512"')
+        self.assert_qmp(result, 'return', '')
+
+    def test_migrate_savevm(self):
+        result = self.vm.qmp('migrate', uri='exec:cat>/dev/null')
+        self.assert_qmp(result, 'return', {})
+        time.sleep(4)
+
+        result = self.vm.qmp('human-monitor-command', command_line='savevm')
+        self.assert_qmp(result, 'return', '')
+
+    def test_savevm_set_speed_savevm(self):
+        for i in range(10):
+            result = self.vm.qmp('human-monitor-command', command_line='savevm')
+            self.assert_qmp(result, 'return', '')
+
+            result = self.vm.qmp('migrate_set_speed', value=9223372036853727232)
+            self.assert_qmp(result, 'return', {})
+
+if __name__ == '__main__':
+    iotests.main()
diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
new file mode 100644
index 0000000000..8d7e996700
--- /dev/null
+++ b/tests/qemu-iotests/175.out
@@ -0,0 +1,5 @@
+...
+----------------------------------------------------------------------
+Ran 3 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 985b9a6a36..1f4bf03185 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -167,3 +167,4 @@
 172 auto
 173 rw auto
 174 auto
+175 auto quick
-- 
2.11.1
