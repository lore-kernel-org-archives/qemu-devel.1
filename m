Received: from eggs.gnu.org ([2001:4830:134:3::10]:51390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctiJK-0001v1-Mf
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 18:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctiJJ-0000fR-Gd
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 18:12:54 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 31 Mar 2017 00:12:43 +0200
Message-Id: <20170330221243.17333-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] iotests: Fix test 147
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This test has been broken by changing NBD's blockdev-add interface (from
taking a SocketAddress to taking a SocketAddressFlat). This patch makes
it work again.

Unfortunately, we cannot just flatten all of the addresses because
nbd-server-start still takes a plain SocketAddress. Therefore, we need
both and this is most easily achieved by writing the SocketAddress into
the code and flattening it where necessary.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
I can be convinced to squash this into Markus' patch "nbd: Tidy up
blockdev-add interface" which is the reason this test broke. I
personally don't have a strong opinion on the matter other than "We
won't get Markus to send a v4".
---
 tests/qemu-iotests/147 | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index cca75c562c..32afea63d4 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -30,6 +30,13 @@ NBD_PORT = 10811
 test_img = os.path.join(iotests.test_dir, 'test.img')
 unix_socket = os.path.join(iotests.test_dir, 'nbd.socket')
 
+
+def flatten_sock_addr(crumpled_address):
+    result = { 'type': crumpled_address['type'] }
+    result.update(crumpled_address['data'])
+    return result
+
+
 class NBDBlockdevAddBase(iotests.QMPTestCase):
     def blockdev_add_options(self, address, export=None):
         options = { 'node-name': 'nbd-blockdev',
@@ -85,13 +92,15 @@ class QemuNBD(NBDBlockdevAddBase):
                         'host': 'localhost',
                         'port': str(NBD_PORT)
                     } }
-        self.client_test('nbd://localhost:%i' % NBD_PORT, address)
+        self.client_test('nbd://localhost:%i' % NBD_PORT,
+                         flatten_sock_addr(address))
 
     def test_unix(self):
         self._server_up('-k', unix_socket)
         address = { 'type': 'unix',
                     'data': { 'path': unix_socket } }
-        self.client_test('nbd+unix://?socket=' + unix_socket, address)
+        self.client_test('nbd+unix://?socket=' + unix_socket,
+                         flatten_sock_addr(address))
 
 
 class BuiltinNBD(NBDBlockdevAddBase):
@@ -134,7 +143,7 @@ class BuiltinNBD(NBDBlockdevAddBase):
                     } }
         self._server_up(address)
         self.client_test('nbd://localhost:%i/nbd-export' % NBD_PORT,
-                         address, 'nbd-export')
+                         flatten_sock_addr(address), 'nbd-export')
         self._server_down()
 
     def test_inet6(self):
@@ -149,10 +158,10 @@ class BuiltinNBD(NBDBlockdevAddBase):
                      'file': {
                          'driver': 'nbd',
                          'export': 'nbd-export',
-                         'server': address
+                         'server': flatten_sock_addr(address)
                      } }
         self._server_up(address)
-        self.client_test(filename, address, 'nbd-export')
+        self.client_test(filename, flatten_sock_addr(address), 'nbd-export')
         self._server_down()
 
     def test_unix(self):
@@ -160,7 +169,7 @@ class BuiltinNBD(NBDBlockdevAddBase):
                     'data': { 'path': unix_socket } }
         self._server_up(address)
         self.client_test('nbd+unix:///nbd-export?socket=' + unix_socket,
-                         address, 'nbd-export')
+                         flatten_sock_addr(address), 'nbd-export')
         self._server_down()
 
     def test_fd(self):
@@ -182,9 +191,9 @@ class BuiltinNBD(NBDBlockdevAddBase):
                      'file': {
                          'driver': 'nbd',
                          'export': 'nbd-export',
-                         'server': address
+                         'server': flatten_sock_addr(address)
                      } }
-        self.client_test(filename, address, 'nbd-export')
+        self.client_test(filename, flatten_sock_addr(address), 'nbd-export')
 
         self._server_down()
 
-- 
2.12.1
