Received: from eggs.gnu.org ([2001:4830:134:3::10]:36782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5p-0007pX-3x
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5j-00082z-VJ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:09 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:8881 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5j-00080P-Du
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:03 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:55 +0300
Message-Id: <20170203154757.36140-17-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 16/18] iotests: add test for nbd dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/180     | 133 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/180.out |   5 ++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 139 insertions(+)
 create mode 100755 tests/qemu-iotests/180
 create mode 100644 tests/qemu-iotests/180.out

diff --git a/tests/qemu-iotests/180 b/tests/qemu-iotests/180
new file mode 100755
index 0000000000..e8238a064a
--- /dev/null
+++ b/tests/qemu-iotests/180
@@ -0,0 +1,133 @@
+#!/usr/bin/env python
+#
+# Test case for NBD's bitmap export
+# Copyright (C) 2017 Virtuozzo.
+#
+# derived from io test 147, original copyright:
+# Copyright (C) 2016 Red Hat, Inc.
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
+import socket
+import stat
+import time
+import iotests
+from iotests import cachemode, imgfmt, qemu_img, qemu_nbd
+
+NBD_PORT = 10811
+
+test_img = os.path.join(iotests.test_dir, 'test.img')
+unix_socket = os.path.join(iotests.test_dir, 'nbd.socket')
+
+class NBDBlockdevAddBase(iotests.QMPTestCase):
+    def blockdev_add_options(self, address, export=None):
+        options = { 'node-name': 'nbd-blockdev',
+                    'driver': 'raw',
+                    'file': {
+                        'driver': 'nbd',
+                        'server': address,
+                        'bitmap': 'mega'
+                    } }
+        if export is not None:
+            options['file']['export'] = export
+        return options
+
+    def client_test(self, filename, address, sha256, export=None):
+        bao = self.blockdev_add_options(address, export)
+        result = self.vm.qmp('blockdev-add', **bao)
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('query-named-block-nodes')
+        for node in result['return']:
+            if node['node-name'] == 'nbd-blockdev':
+                if isinstance(filename, str):
+                    self.assert_qmp(node, 'image/filename', filename)
+                else:
+                    self.assert_json_filename_equal(node['image']['filename'],
+                                                    filename)
+                break
+
+        result = self.vm.qmp('block-dirty-bitmap-load',
+                             node='nbd-blockdev', name='mega')
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='nbd-blockdev', name='mega')
+        self.assert_qmp(result, 'return/sha256', sha256);
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, test_img, '0x400000000')
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+        self.server = iotests.VM('.server')
+        self.server.add_drive_raw('if=none,id=nbd-export,' +
+                                  'file=%s,' % test_img +
+                                  'format=%s,' % imgfmt +
+                                  'cache=%s' % cachemode)
+        self.server.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+        self.server.shutdown()
+        os.remove(test_img)
+
+    def _server_up(self, address):
+        result = self.server.qmp('nbd-server-start', addr=address)
+        self.assert_qmp(result, 'return', {})
+
+        result = self.server.qmp('nbd-server-add', device='nbd-export')
+        self.assert_qmp(result, 'return', {})
+
+    def _server_down(self):
+        result = self.server.qmp('nbd-server-stop')
+        self.assert_qmp(result, 'return', {})
+
+    def test_export_bitmap(self):
+        address = { 'type': 'inet',
+                    'data': {
+                        'host': 'localhost',
+                        'port': str(NBD_PORT)
+                    } }
+
+        granularity = 65536
+        regions = [
+            { 'start': 0,           'count': 0x100000 },
+            { 'start': 0x100000000, 'count': 0x200000  },
+            { 'start': 0x399900000, 'count': 0x100000  }
+            ]
+
+        result = self.server.qmp('block-dirty-bitmap-add', node='nbd-export',
+                                 name='mega', granularity=granularity)
+        self.assert_qmp(result, 'return', {});
+
+        for r in regions:
+            self.server.hmp_qemu_io('nbd-export',
+                                    'write %d %d' % (r['start'], r['count']))
+
+        result = self.server.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='nbd-export', name='mega')
+        sha256 = result['return']['sha256']
+
+        self._server_up(address)
+        self.client_test('nbd://localhost:%i/nbd-export' % NBD_PORT,
+                         address, sha256, 'nbd-export')
+        #self._server_down()
+
+if __name__ == '__main__':
+    # Need to support image creation
+    iotests.main(supported_fmts=['vpc', 'parallels', 'qcow', 'vdi', 'qcow2',
+                                 'vmdk', 'raw', 'vhdx', 'qed'])
diff --git a/tests/qemu-iotests/180.out b/tests/qemu-iotests/180.out
new file mode 100644
index 0000000000..ae1213e6f8
--- /dev/null
+++ b/tests/qemu-iotests/180.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 866c1a032d..9d06d3f862 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -165,3 +165,4 @@
 170 rw auto quick
 171 rw auto quick
 172 auto
+180 auto
-- 
2.11.0
