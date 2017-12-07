Received: from eggs.gnu.org ([2001:4830:134:3::10]:47237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMySW-0003bm-VX
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMySU-0008BW-2J
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:36 -0500
Received: from [195.214.232.25] (port=33163 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eMyST-00086f-Hw
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:34 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Dec 2017 18:51:00 +0300
Message-Id: <20171207155102.66622-5-vsementsov@virtuozzo.com>
In-Reply-To: <20171207155102.66622-1-vsementsov@virtuozzo.com>
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 4/6] iotest 147: add cases to test new @name
 parameter of nbd-server-add
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
 tests/qemu-iotests/147     | 68 +++++++++++++++++++++++++++++++++++++---------
 tests/qemu-iotests/147.out |  4 +--
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 90f40ed245..d2081df84b 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -38,8 +38,8 @@ def flatten_sock_addr(crumpled_address):
 
 
 class NBDBlockdevAddBase(iotests.QMPTestCase):
-    def blockdev_add_options(self, address, export=None):
-        options = { 'node-name': 'nbd-blockdev',
+    def blockdev_add_options(self, address, export, node_name):
+        options = { 'node-name': node_name,
                     'driver': 'raw',
                     'file': {
                         'driver': 'nbd',
@@ -50,23 +50,28 @@ class NBDBlockdevAddBase(iotests.QMPTestCase):
             options['file']['export'] = export
         return options
 
-    def client_test(self, filename, address, export=None):
-        bao = self.blockdev_add_options(address, export)
+    def client_test(self, filename, address, export=None,
+                    node_name='nbd-blockdev', delete=True):
+        bao = self.blockdev_add_options(address, export, node_name)
         result = self.vm.qmp('blockdev-add', **bao)
         self.assert_qmp(result, 'return', {})
 
+        found = False
         result = self.vm.qmp('query-named-block-nodes')
         for node in result['return']:
-            if node['node-name'] == 'nbd-blockdev':
+            if node['node-name'] == node_name:
+                found = True
                 if isinstance(filename, str):
                     self.assert_qmp(node, 'image/filename', filename)
                 else:
                     self.assert_json_filename_equal(node['image']['filename'],
                                                     filename)
                 break
+        self.assertTrue(found)
 
-        result = self.vm.qmp('blockdev-del', node_name='nbd-blockdev')
-        self.assert_qmp(result, 'return', {})
+        if delete:
+            result = self.vm.qmp('blockdev-del', node_name=node_name)
+            self.assert_qmp(result, 'return', {})
 
 
 class QemuNBD(NBDBlockdevAddBase):
@@ -125,26 +130,63 @@ class BuiltinNBD(NBDBlockdevAddBase):
         except OSError:
             pass
 
-    def _server_up(self, address):
+    def _server_up(self, address, export_name=None, export_name2=None):
         result = self.server.qmp('nbd-server-start', addr=address)
         self.assert_qmp(result, 'return', {})
 
-        result = self.server.qmp('nbd-server-add', device='nbd-export')
+        if export_name is None:
+            result = self.server.qmp('nbd-server-add', device='nbd-export')
+        else:
+            result = self.server.qmp('nbd-server-add', device='nbd-export',
+                                     name=export_name)
         self.assert_qmp(result, 'return', {})
 
+        if export_name2 is not None:
+            result = self.server.qmp('nbd-server-add', device='nbd-export',
+                                     name=export_name2)
+            self.assert_qmp(result, 'return', {})
+
+
     def _server_down(self):
         result = self.server.qmp('nbd-server-stop')
         self.assert_qmp(result, 'return', {})
 
-    def test_inet(self):
+    def do_test_inet(self, export_name=None):
         address = { 'type': 'inet',
                     'data': {
                         'host': 'localhost',
                         'port': str(NBD_PORT)
                     } }
-        self._server_up(address)
-        self.client_test('nbd://localhost:%i/nbd-export' % NBD_PORT,
-                         flatten_sock_addr(address), 'nbd-export')
+        self._server_up(address, export_name)
+        export_name = export_name or 'nbd-export'
+        self.client_test('nbd://localhost:%i/%s' % (NBD_PORT, export_name),
+                         flatten_sock_addr(address), export_name)
+        self._server_down()
+
+    def test_inet_default_export_name(self):
+        self.do_test_inet()
+
+    def test_inet_same_export_name(self):
+        self.do_test_inet('nbd-export')
+
+    def test_inet_different_export_name(self):
+        self.do_test_inet('shadow')
+
+    def test_inet_two_exports(self):
+        address = { 'type': 'inet',
+                    'data': {
+                        'host': 'localhost',
+                        'port': str(NBD_PORT)
+                    } }
+        self._server_up(address, 'exp1', 'exp2')
+        self.client_test('nbd://localhost:%i/%s' % (NBD_PORT, 'exp1'),
+                         flatten_sock_addr(address), 'exp1', 'node1', False)
+        self.client_test('nbd://localhost:%i/%s' % (NBD_PORT, 'exp2'),
+                         flatten_sock_addr(address), 'exp2', 'node2', False)
+        result = self.vm.qmp('blockdev-del', node_name='node1')
+        self.assert_qmp(result, 'return', {})
+        result = self.vm.qmp('blockdev-del', node_name='node2')
+        self.assert_qmp(result, 'return', {})
         self._server_down()
 
     def test_inet6(self):
diff --git a/tests/qemu-iotests/147.out b/tests/qemu-iotests/147.out
index 3f8a935a08..dae404e278 100644
--- a/tests/qemu-iotests/147.out
+++ b/tests/qemu-iotests/147.out
@@ -1,5 +1,5 @@
-......
+.........
 ----------------------------------------------------------------------
-Ran 6 tests
+Ran 9 tests
 
 OK
-- 
2.11.1
