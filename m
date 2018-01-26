Received: from eggs.gnu.org ([2001:4830:134:3::10]:60053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6UV-0003KQ-Vm
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6UU-0002gt-CL
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:04:35 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 26 Jan 2018 10:04:09 -0600
Message-Id: <20180126160411.4033-7-eblake@redhat.com>
In-Reply-To: <20180126160411.4033-1-eblake@redhat.com>
References: <20180126160411.4033-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 6/8] iotest 205: new test for qmp
 nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180119135719.24745-6-vsementsov@virtuozzo.com>
[eblake: adjust to next available test number]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/205     | 156 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/205.out |   5 ++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 162 insertions(+)
 create mode 100644 tests/qemu-iotests/205
 create mode 100644 tests/qemu-iotests/205.out

diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
new file mode 100644
index 00000000000..10388920dc3
--- /dev/null
+++ b/tests/qemu-iotests/205
@@ -0,0 +1,156 @@
+#!/usr/bin/env python
+#
+# Tests for qmp command nbd-server-remove.
+#
+# Copyright (c) 2017 Virtuozzo International GmbH
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
+import sys
+import iotests
+import time
+from iotests import qemu_img, qemu_io, filter_qemu_io, QemuIoInteractive
+
+nbd_sock = 'nbd_sock'
+nbd_uri = 'nbd+unix:///exp?socket=' + nbd_sock
+disk = os.path.join(iotests.test_dir, 'disk')
+
+
+class TestNbdServerRemove(iotests.QMPTestCase):
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, disk, '1M')
+
+        self.vm = iotests.VM().add_drive(disk)
+        self.vm.launch()
+
+        address = {
+            'type': 'unix',
+            'data': {
+                'path': nbd_sock
+            }
+        }
+
+        result = self.vm.qmp('nbd-server-start', addr=address)
+        self.assert_qmp(result, 'return', {})
+        result = self.vm.qmp('nbd-server-add', device='drive0', name='exp')
+        self.assert_qmp(result, 'return', {})
+
+    def tearDown(self):
+        self.vm.shutdown()
+        os.remove(nbd_sock)
+        os.remove(disk)
+
+    def remove_export(self, name, mode=None):
+        if mode is None:
+            return self.vm.qmp('nbd-server-remove', name=name)
+        else:
+            return self.vm.qmp('nbd-server-remove', name=name, mode=mode)
+
+    def assertExportNotFound(self, name):
+        result = self.vm.qmp('nbd-server-remove', name=name)
+        self.assert_qmp(result, 'error/desc', "Export 'exp' is not found")
+
+    def assertExistingClients(self, result):
+        self.assert_qmp(result, 'error/desc', "export 'exp' still in use")
+
+    def assertReadOk(self, qemu_io_output):
+        self.assertEqual(
+                filter_qemu_io(qemu_io_output).strip(),
+                'read 512/512 bytes at offset 0\n' +
+                '512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)')
+
+    def assertReadFailed(self, qemu_io_output):
+        self.assertEqual(filter_qemu_io(qemu_io_output).strip(),
+                         'read failed: Input/output error')
+
+    def assertConnectFailed(self, qemu_io_output):
+        self.assertEqual(filter_qemu_io(qemu_io_output).strip(),
+                         "can't open device " + nbd_uri +
+                         ": Requested export not available\n"
+                         "server reported: export 'exp' not present")
+
+    def do_test_connect_after_remove(self, mode=None):
+        args = ('-r', '-f', 'raw', '-c', 'read 0 512', nbd_uri)
+        self.assertReadOk(qemu_io(*args))
+
+        result = self.remove_export('exp', mode)
+        self.assert_qmp(result, 'return', {})
+
+        self.assertExportNotFound('exp')
+        self.assertConnectFailed(qemu_io(*args))
+
+    def test_connect_after_remove_default(self):
+        self.do_test_connect_after_remove()
+
+    def test_connect_after_remove_safe(self):
+        self.do_test_connect_after_remove('safe')
+
+    def test_connect_after_remove_force(self):
+        self.do_test_connect_after_remove('hard')
+
+    def do_test_remove_during_connect_safe(self, mode=None):
+        qio = QemuIoInteractive('-r', '-f', 'raw', nbd_uri)
+        self.assertReadOk(qio.cmd('read 0 512'))
+
+        result = self.remove_export('exp', mode)
+        self.assertExistingClients(result)
+
+        self.assertReadOk(qio.cmd('read 0 512'))
+
+        qio.close()
+
+        result = self.remove_export('exp', mode)
+        self.assert_qmp(result, 'return', {})
+
+        self.assertExportNotFound('exp')
+
+    def test_remove_during_connect_default(self):
+        self.do_test_remove_during_connect_safe()
+
+    def test_remove_during_connect_safe(self):
+        self.do_test_remove_during_connect_safe('safe')
+
+    def test_remove_during_connect_hard(self):
+        qio = QemuIoInteractive('-r', '-f', 'raw', nbd_uri)
+        self.assertReadOk(qio.cmd('read 0 512'))
+
+        result = self.remove_export('exp', 'hard')
+        self.assert_qmp(result, 'return', {})
+
+        self.assertReadFailed(qio.cmd('read 0 512'))
+        self.assertExportNotFound('exp')
+
+        qio.close()
+
+    def test_remove_during_connect_safe_hard(self):
+        qio = QemuIoInteractive('-r', '-f', 'raw', nbd_uri)
+        self.assertReadOk(qio.cmd('read 0 512'))
+
+        result = self.remove_export('exp', 'safe')
+        self.assertExistingClients(result)
+
+        self.assertReadOk(qio.cmd('read 0 512'))
+
+        result = self.remove_export('exp', 'hard')
+        self.assert_qmp(result, 'return', {})
+
+        self.assertExportNotFound('exp')
+        self.assertReadFailed(qio.cmd('read 0 512'))
+        qio.close()
+
+
+if __name__ == '__main__':
+    iotests.main()
diff --git a/tests/qemu-iotests/205.out b/tests/qemu-iotests/205.out
new file mode 100644
index 00000000000..2f7d3902f23
--- /dev/null
+++ b/tests/qemu-iotests/205.out
@@ -0,0 +1,5 @@
+.......
+----------------------------------------------------------------------
+Ran 7 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 8fc4f62cca6..a2dfe79d862 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -201,3 +201,4 @@
 202 rw auto quick
 203 rw auto
 204 rw auto quick
+205 rw auto quick
-- 
2.14.3
