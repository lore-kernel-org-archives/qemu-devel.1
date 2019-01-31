Received: from eggs.gnu.org ([209.51.188.92]:37851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0iu-0000J2-KU
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0is-0000Od-Ko
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:00:56 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 31 Jan 2019 01:59:45 +0100
Message-Id: <20190131005945.20149-14-mreitz@redhat.com>
In-Reply-To: <20190131005945.20149-1-mreitz@redhat.com>
References: <20190131005945.20149-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/13] iotests: Allow 147 to be run concurrently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

To do this, we need to allow creating the NBD server on various ports
instead of a single one (which may not even work if you run just one
instance, because something entirely else might be using that port).

So we just pick a random port in [32768, 32768 + 1024) and try to create
a server there.  If that fails, we just retry until something sticks.

For the IPv6 test, we need a different range, though (just above that
one).  This is because "localhost" resolves to both 127.0.0.1 and ::1.
This means that if you bind to it, it will bind to both, if possible, or
just one if the other is already in use.  Therefore, if the IPv6 test
has already taken [::1]:some_port and we then try to take
localhost:some_port, that will work -- only the second server will be
bound to 127.0.0.1:some_port alone and not [::1]:some_port in addition.
So we have two different servers on the same port, one for IPv4 and one
for IPv6.

But when we then try to connect to the server through
localhost:some_port, we will always end up at the IPv6 one (as long as
it is up), and this may not be the one we want.

Thus, we must make sure not to create an IPv6-only NBD server on the
same port as a normal "dual-stack" NBD server -- which is done by using
distinct port ranges, as explained above.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20181221234750.23577-4-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/147 | 98 +++++++++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 30 deletions(-)

diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 3e10a9969e..82513279b0 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -19,13 +19,17 @@
 #
=20
 import os
+import random
 import socket
 import stat
 import time
 import iotests
-from iotests import cachemode, imgfmt, qemu_img, qemu_nbd
+from iotests import cachemode, imgfmt, qemu_img, qemu_nbd, qemu_nbd_pipe
=20
-NBD_PORT =3D 10811
+NBD_PORT_START      =3D 32768
+NBD_PORT_END        =3D NBD_PORT_START + 1024
+NBD_IPV6_PORT_START =3D NBD_PORT_END
+NBD_IPV6_PORT_END   =3D NBD_IPV6_PORT_START + 1024
=20
 test_img =3D os.path.join(iotests.test_dir, 'test.img')
 unix_socket =3D os.path.join(iotests.test_dir, 'nbd.socket')
@@ -88,17 +92,29 @@ class QemuNBD(NBDBlockdevAddBase):
         except OSError:
             pass
=20
+    def _try_server_up(self, *args):
+        status, msg =3D qemu_nbd_pipe('-f', imgfmt, test_img, *args)
+        if status =3D=3D 0:
+            return True
+        if 'Address already in use' in msg:
+            return False
+        self.fail(msg)
+
     def _server_up(self, *args):
-        self.assertEqual(qemu_nbd('-f', imgfmt, test_img, *args), 0)
+        self.assertTrue(self._try_server_up(*args))
=20
     def test_inet(self):
-        self._server_up('-b', 'localhost', '-p', str(NBD_PORT))
+        while True:
+            nbd_port =3D random.randrange(NBD_PORT_START, NBD_PORT_END)
+            if self._try_server_up('-b', 'localhost', '-p', str(nbd_port=
)):
+                break
+
         address =3D { 'type': 'inet',
                     'data': {
                         'host': 'localhost',
-                        'port': str(NBD_PORT)
+                        'port': str(nbd_port)
                     } }
-        self.client_test('nbd://localhost:%i' % NBD_PORT,
+        self.client_test('nbd://localhost:%i' % nbd_port,
                          flatten_sock_addr(address))
=20
     def test_unix(self):
@@ -130,8 +146,13 @@ class BuiltinNBD(NBDBlockdevAddBase):
         except OSError:
             pass
=20
-    def _server_up(self, address, export_name=3DNone, export_name2=3DNon=
e):
+    # Returns False on EADDRINUSE; fails an assertion on other errors.
+    # Returns True on success.
+    def _try_server_up(self, address, export_name=3DNone, export_name2=3D=
None):
         result =3D self.server.qmp('nbd-server-start', addr=3Daddress)
+        if 'error' in result and \
+           'Address already in use' in result['error']['desc']:
+            return False
         self.assert_qmp(result, 'return', {})
=20
         if export_name is None:
@@ -146,20 +167,28 @@ class BuiltinNBD(NBDBlockdevAddBase):
                                      name=3Dexport_name2)
             self.assert_qmp(result, 'return', {})
=20
+        return True
+
+    def _server_up(self, address, export_name=3DNone, export_name2=3DNon=
e):
+        self.assertTrue(self._try_server_up(address, export_name, export=
_name2))
=20
     def _server_down(self):
         result =3D self.server.qmp('nbd-server-stop')
         self.assert_qmp(result, 'return', {})
=20
     def do_test_inet(self, export_name=3DNone):
-        address =3D { 'type': 'inet',
-                    'data': {
-                        'host': 'localhost',
-                        'port': str(NBD_PORT)
-                    } }
-        self._server_up(address, export_name)
+        while True:
+            nbd_port =3D random.randrange(NBD_PORT_START, NBD_PORT_END)
+            address =3D { 'type': 'inet',
+                        'data': {
+                            'host': 'localhost',
+                            'port': str(nbd_port)
+                        } }
+            if self._try_server_up(address, export_name):
+                break
+
         export_name =3D export_name or 'nbd-export'
-        self.client_test('nbd://localhost:%i/%s' % (NBD_PORT, export_nam=
e),
+        self.client_test('nbd://localhost:%i/%s' % (nbd_port, export_nam=
e),
                          flatten_sock_addr(address), export_name)
         self._server_down()
=20
@@ -173,15 +202,19 @@ class BuiltinNBD(NBDBlockdevAddBase):
         self.do_test_inet('shadow')
=20
     def test_inet_two_exports(self):
-        address =3D { 'type': 'inet',
-                    'data': {
-                        'host': 'localhost',
-                        'port': str(NBD_PORT)
-                    } }
-        self._server_up(address, 'exp1', 'exp2')
-        self.client_test('nbd://localhost:%i/%s' % (NBD_PORT, 'exp1'),
+        while True:
+            nbd_port =3D random.randrange(NBD_PORT_START, NBD_PORT_END)
+            address =3D { 'type': 'inet',
+                        'data': {
+                            'host': 'localhost',
+                            'port': str(nbd_port)
+                        } }
+            if self._try_server_up(address, 'exp1', 'exp2'):
+                break
+
+        self.client_test('nbd://localhost:%i/%s' % (nbd_port, 'exp1'),
                          flatten_sock_addr(address), 'exp1', 'node1', Fa=
lse)
-        self.client_test('nbd://localhost:%i/%s' % (NBD_PORT, 'exp2'),
+        self.client_test('nbd://localhost:%i/%s' % (nbd_port, 'exp2'),
                          flatten_sock_addr(address), 'exp2', 'node2', Fa=
lse)
         result =3D self.vm.qmp('blockdev-del', node_name=3D'node1')
         self.assert_qmp(result, 'return', {})
@@ -197,20 +230,25 @@ class BuiltinNBD(NBDBlockdevAddBase):
         except socket.gaierror:
             # IPv6 not available, skip
             return
-        address =3D { 'type': 'inet',
-                    'data': {
-                        'host': '::1',
-                        'port': str(NBD_PORT),
-                        'ipv4': False,
-                        'ipv6': True
-                    } }
+
+        while True:
+            nbd_port =3D random.randrange(NBD_IPV6_PORT_START, NBD_IPV6_=
PORT_END)
+            address =3D { 'type': 'inet',
+                        'data': {
+                            'host': '::1',
+                            'port': str(nbd_port),
+                            'ipv4': False,
+                            'ipv6': True
+                        } }
+            if self._try_server_up(address):
+                break
+
         filename =3D { 'driver': 'raw',
                      'file': {
                          'driver': 'nbd',
                          'export': 'nbd-export',
                          'server': flatten_sock_addr(address)
                      } }
-        self._server_up(address)
         self.client_test(filename, flatten_sock_addr(address), 'nbd-expo=
rt')
         self._server_down()
=20
--=20
2.20.1
