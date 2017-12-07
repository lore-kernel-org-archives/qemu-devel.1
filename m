Received: from eggs.gnu.org ([2001:4830:134:3::10]:47235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMySW-0003bk-VV
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMySU-0008BP-0g
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:37 -0500
Received: from [195.214.232.25] (port=38302 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eMyST-00086c-Gf
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:33 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Dec 2017 18:51:02 +0300
Message-Id: <20171207155102.66622-7-vsementsov@virtuozzo.com>
In-Reply-To: <20171207155102.66622-1-vsementsov@virtuozzo.com>
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 6/6] iotest 201: new test for qmp
 nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/201     | 130 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/201.out |   5 ++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 136 insertions(+)
 create mode 100644 tests/qemu-iotests/201
 create mode 100644 tests/qemu-iotests/201.out

diff --git a/tests/qemu-iotests/201 b/tests/qemu-iotests/201
new file mode 100644
index 0000000000..28d0324195
--- /dev/null
+++ b/tests/qemu-iotests/201
@@ -0,0 +1,130 @@
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
+nbd_port = '10900'
+nbd_uri = 'nbd+tcp://localhost:' + nbd_port + '/exp'
+disk = os.path.join(iotests.test_dir, 'disk')
+
+class TestNbdServerRemove(iotests.QMPTestCase):
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, disk, '1M')
+
+        self.vm = iotests.VM().add_drive(disk)
+        self.vm.launch()
+
+        address = {
+            'type': 'inet',
+            'data': {
+                'host': 'localhost',
+                'port': nbd_port
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
+        os.remove(disk)
+
+    def remove_export(self, name, force=None):
+        if force is None:
+            result = self.vm.qmp('nbd-server-remove', name=name)
+        else:
+            result = self.vm.qmp('nbd-server-remove', name=name, force=force)
+        self.assert_qmp(result, 'return', {})
+
+    def assertExportNotFound(self, name):
+        result = self.vm.qmp('nbd-server-remove', name=name)
+        self.assert_qmp(result, 'error/desc', "Export 'exp' is not found")
+
+    def assertReadOk(self, qemu_io_output):
+        self.assertEqual(filter_qemu_io(qemu_io_output).strip(),
+                'read 512/512 bytes at offset 0\n' +
+                '512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)')
+
+    def assertReadFailed(self, qemu_io_output):
+        self.assertEqual(filter_qemu_io(qemu_io_output).strip(),
+                         'read failed: Input/output error')
+
+    def assertConnectFailed(self, qemu_io_output):
+        self.assertEqual(filter_qemu_io(qemu_io_output).strip(),
+                         "can't open device nbd+tcp://localhost:10900/exp: " +
+                         "Requested export not available\nserver reported: " +
+                         "export 'exp' not present")
+
+    def do_test_connect_after_remove(self, force=None):
+        args = ('-r', '-f', 'raw', '-c', 'read 0 512', nbd_uri)
+        self.assertReadOk(qemu_io(*args))
+        self.remove_export('exp', force)
+        self.assertExportNotFound('exp')
+        self.assertConnectFailed(qemu_io(*args))
+
+    def test_connect_after_remove_default(self):
+        self.do_test_connect_after_remove()
+
+    def test_connect_after_remove_safe(self):
+        self.do_test_connect_after_remove(False)
+
+    def test_connect_after_remove_force(self):
+        self.do_test_connect_after_remove(True)
+
+    def do_test_remove_during_connect(self, force=None):
+        qio = QemuIoInteractive('-r', '-f', 'raw', nbd_uri)
+        self.assertReadOk(qio.cmd('read 0 512'))
+        self.remove_export('exp', force)
+        if force:
+            self.assertReadFailed(qio.cmd('read 0 512'))
+            self.assertExportNotFound('exp')
+        else:
+            self.assertReadOk(qio.cmd('read 0 512'))
+        qio.close()
+        self.assertExportNotFound('exp')
+
+    def test_remove_during_connect_default(self):
+        self.do_test_remove_during_connect()
+
+    def test_remove_during_connect_safe(self):
+        self.do_test_remove_during_connect(False)
+
+    def test_remove_during_connect_force(self):
+        self.do_test_remove_during_connect(True)
+
+    def test_remove_during_connect_safe_force(self):
+        qio = QemuIoInteractive('-r', '-f', 'raw', nbd_uri)
+        self.assertReadOk(qio.cmd('read 0 512'))
+        self.remove_export('exp', False)
+        self.assertReadOk(qio.cmd('read 0 512'))
+        self.remove_export('exp', True)
+        self.assertExportNotFound('exp')
+        self.assertReadFailed(qio.cmd('read 0 512'))
+        qio.close()
+
+
+if __name__ == '__main__':
+    iotests.main()
diff --git a/tests/qemu-iotests/201.out b/tests/qemu-iotests/201.out
new file mode 100644
index 0000000000..2f7d3902f2
--- /dev/null
+++ b/tests/qemu-iotests/201.out
@@ -0,0 +1,5 @@
+.......
+----------------------------------------------------------------------
+Ran 7 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 3e688678dd..15df7678b3 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -197,3 +197,4 @@
 197 rw auto quick
 198 rw auto
 200 rw auto
+201 rw auto quick
-- 
2.11.1
