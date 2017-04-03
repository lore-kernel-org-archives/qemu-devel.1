Received: from eggs.gnu.org ([2001:4830:134:3::10]:45735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv405-0006Q5-5j
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv400-0007SL-GI
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 17:33:49 +0200
Message-Id: <20170403153355.19722-10-mreitz@redhat.com>
In-Reply-To: <20170403153355.19722-1-mreitz@redhat.com>
References: <20170403153355.19722-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 09/15] nbd: Tidy up blockdev-add interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Markus Armbruster <armbru@redhat.com>

SocketAddress is a simple union, and simple unions are awkward: they
have their variant members wrapped in a "data" object on the wire, and
require additional indirections in C.  I intend to limit its use to
existing external interfaces, and convert all internal interfaces to
SocketAddressFlat.

BlockdevOptionsNbd is an external interface using SocketAddress.  We
already use SocketAddressFlat elsewhere in blockdev-add.  Replace it
by SocketAddressFlat while we can (it's new in 2.9) for simplicity and
consistency.  For example,

    { "execute": "blockdev-add",
      "arguments": { "node-name": "foo", "driver": "nbd",
                     "server": { "type": "inet",
		                 "data": { "host": "localhost",
				           "port": "12345" } } } }

becomes

    { "execute": "blockdev-add",
      "arguments": { "node-name": "foo", "driver": "nbd",
                     "server": { "type": "inet",
		                 "host": "localhost", "port": "12345" } } }

Since the internal interfaces still take SocketAddress, this requires
conversion function socket_address_crumple().  It'll go away when I
update the interfaces.

Unfortunately, SocketAddress is also visible in -drive since 2.8:

    -drive if=none,driver=nbd,server.type=inet,server.data.host=127.0.0.1,server.data.port=12345

Nobody should be using it, as it's fairly new and has never been
documented, so adding still more compatibility gunk to keep it working
isn't worth the trouble.  You now have to use

    -drive if=none,driver=nbd,server.type=inet,server.host=127.0.0.1,server.port=12345

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-id: 1490895797-29094-9-git-send-email-armbru@redhat.com

[mreitz: Change iotest 147 accordingly]

Because of this interface change, iotest 147 has to be adapted.
Unfortunately, we cannot just flatten all of the addresses because
nbd-server-start still takes a plain SocketAddress. Therefore, we need
both and this is most easily achieved by writing the SocketAddress into
the code and flattening it where necessary.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170330221243.17333-1-mreitz@redhat.com

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json   |  2 +-
 block/nbd.c            | 53 ++++++++++++++++++++++++++------------------------
 tests/qemu-iotests/147 | 25 ++++++++++++++++--------
 3 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 8de39d143a..e4d8a63575 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2847,7 +2847,7 @@
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsNbd',
-  'data': { 'server': 'SocketAddress',
+  'data': { 'server': 'SocketAddressFlat',
             '*export': 'str',
             '*tls-creds': 'str' } }
 
diff --git a/block/nbd.c b/block/nbd.c
index 11e3ba75fa..8bb29a90bb 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -47,7 +47,7 @@ typedef struct BDRVNBDState {
     NBDClientSession client;
 
     /* For nbd_refresh_filename() */
-    SocketAddress *saddr;
+    SocketAddressFlat *saddr;
     char *export, *tlscredsid;
 } BDRVNBDState;
 
@@ -95,7 +95,7 @@ static int nbd_parse_uri(const char *filename, QDict *options)
             goto out;
         }
         qdict_put(options, "server.type", qstring_from_str("unix"));
-        qdict_put(options, "server.data.path",
+        qdict_put(options, "server.path",
                   qstring_from_str(qp->p[0].value));
     } else {
         QString *host;
@@ -116,10 +116,10 @@ static int nbd_parse_uri(const char *filename, QDict *options)
         }
 
         qdict_put(options, "server.type", qstring_from_str("inet"));
-        qdict_put(options, "server.data.host", host);
+        qdict_put(options, "server.host", host);
 
         port_str = g_strdup_printf("%d", uri->port ?: NBD_DEFAULT_PORT);
-        qdict_put(options, "server.data.port", qstring_from_str(port_str));
+        qdict_put(options, "server.port", qstring_from_str(port_str));
         g_free(port_str);
     }
 
@@ -197,7 +197,7 @@ static void nbd_parse_filename(const char *filename, QDict *options,
     /* are we a UNIX or TCP socket? */
     if (strstart(host_spec, "unix:", &unixpath)) {
         qdict_put(options, "server.type", qstring_from_str("unix"));
-        qdict_put(options, "server.data.path", qstring_from_str(unixpath));
+        qdict_put(options, "server.path", qstring_from_str(unixpath));
     } else {
         InetSocketAddress *addr = NULL;
 
@@ -207,8 +207,8 @@ static void nbd_parse_filename(const char *filename, QDict *options,
         }
 
         qdict_put(options, "server.type", qstring_from_str("inet"));
-        qdict_put(options, "server.data.host", qstring_from_str(addr->host));
-        qdict_put(options, "server.data.port", qstring_from_str(addr->port));
+        qdict_put(options, "server.host", qstring_from_str(addr->host));
+        qdict_put(options, "server.port", qstring_from_str(addr->port));
         qapi_free_InetSocketAddress(addr);
     }
 
@@ -248,20 +248,21 @@ static bool nbd_process_legacy_socket_options(QDict *output_options,
         }
 
         qdict_put(output_options, "server.type", qstring_from_str("unix"));
-        qdict_put(output_options, "server.data.path", qstring_from_str(path));
+        qdict_put(output_options, "server.path", qstring_from_str(path));
     } else if (host) {
         qdict_put(output_options, "server.type", qstring_from_str("inet"));
-        qdict_put(output_options, "server.data.host", qstring_from_str(host));
-        qdict_put(output_options, "server.data.port",
+        qdict_put(output_options, "server.host", qstring_from_str(host));
+        qdict_put(output_options, "server.port",
                   qstring_from_str(port ?: stringify(NBD_DEFAULT_PORT)));
     }
 
     return true;
 }
 
-static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options, Error **errp)
+static SocketAddressFlat *nbd_config(BDRVNBDState *s, QDict *options,
+                                     Error **errp)
 {
-    SocketAddress *saddr = NULL;
+    SocketAddressFlat *saddr = NULL;
     QDict *addr = NULL;
     QObject *crumpled_addr = NULL;
     Visitor *iv = NULL;
@@ -287,7 +288,7 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options, Error **errp)
      * visitor expects the former.
      */
     iv = qobject_input_visitor_new(crumpled_addr);
-    visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
+    visit_type_SocketAddressFlat(iv, NULL, &saddr, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto done;
@@ -306,9 +307,10 @@ NBDClientSession *nbd_get_client_session(BlockDriverState *bs)
     return &s->client;
 }
 
-static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
+static QIOChannelSocket *nbd_establish_connection(SocketAddressFlat *saddr_flat,
                                                   Error **errp)
 {
+    SocketAddress *saddr = socket_address_crumple(saddr_flat);
     QIOChannelSocket *sioc;
     Error *local_err = NULL;
 
@@ -318,6 +320,7 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
     qio_channel_socket_connect_sync(sioc,
                                     saddr,
                                     &local_err);
+    qapi_free_SocketAddress(saddr);
     if (local_err) {
         error_propagate(errp, local_err);
         return NULL;
@@ -409,7 +412,7 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto error;
     }
 
-    /* Translate @host, @port, and @path to a SocketAddress */
+    /* Translate @host, @port, and @path to a SocketAddressFlat */
     if (!nbd_process_legacy_socket_options(options, opts, errp)) {
         goto error;
     }
@@ -430,11 +433,11 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         }
 
         /* TODO SOCKET_ADDRESS_KIND_FD where fd has AF_INET or AF_INET6 */
-        if (s->saddr->type != SOCKET_ADDRESS_KIND_INET) {
+        if (s->saddr->type != SOCKET_ADDRESS_FLAT_TYPE_INET) {
             error_setg(errp, "TLS only supported over IP sockets");
             goto error;
         }
-        hostname = s->saddr->u.inet.data->host;
+        hostname = s->saddr->u.inet.host;
     }
 
     /* establish TCP connection, return error if it fails
@@ -457,7 +460,7 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         object_unref(OBJECT(tlscreds));
     }
     if (ret < 0) {
-        qapi_free_SocketAddress(s->saddr);
+        qapi_free_SocketAddressFlat(s->saddr);
         g_free(s->export);
         g_free(s->tlscredsid);
     }
@@ -483,7 +486,7 @@ static void nbd_close(BlockDriverState *bs)
 
     nbd_client_close(bs);
 
-    qapi_free_SocketAddress(s->saddr);
+    qapi_free_SocketAddressFlat(s->saddr);
     g_free(s->export);
     g_free(s->tlscredsid);
 }
@@ -514,15 +517,15 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     Visitor *ov;
     const char *host = NULL, *port = NULL, *path = NULL;
 
-    if (s->saddr->type == SOCKET_ADDRESS_KIND_INET) {
-        const InetSocketAddress *inet = s->saddr->u.inet.data;
+    if (s->saddr->type == SOCKET_ADDRESS_FLAT_TYPE_INET) {
+        const InetSocketAddress *inet = &s->saddr->u.inet;
         if (!inet->has_ipv4 && !inet->has_ipv6 && !inet->has_to) {
             host = inet->host;
             port = inet->port;
         }
-    } else if (s->saddr->type == SOCKET_ADDRESS_KIND_UNIX) {
-        path = s->saddr->u.q_unix.data->path;
-    }
+    } else if (s->saddr->type == SOCKET_ADDRESS_FLAT_TYPE_UNIX) {
+        path = s->saddr->u.q_unix.path;
+    } /* else can't represent as pseudo-filename */
 
     qdict_put(opts, "driver", qstring_from_str("nbd"));
 
@@ -541,7 +544,7 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     }
 
     ov = qobject_output_visitor_new(&saddr_qdict);
-    visit_type_SocketAddress(ov, NULL, &s->saddr, &error_abort);
+    visit_type_SocketAddressFlat(ov, NULL, &s->saddr, &error_abort);
     visit_complete(ov, &saddr_qdict);
     visit_free(ov);
     qdict_put_obj(opts, "server", saddr_qdict);
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
