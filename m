Received: from eggs.gnu.org ([2001:4830:134:3::10]:58892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTr0T-00007H-V7
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTr0S-0006d9-QL
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:51:22 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Jun 2018 16:51:01 +0100
Message-Id: <20180615155103.11924-5-berrange@redhat.com>
In-Reply-To: <20180615155103.11924-1-berrange@redhat.com>
References: <20180615155103.11924-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] chardev: add support for authorization for
 TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Currently any client which can complete the TLS handshake is able to use
a chardev server. The server admin can turn on the 'verify-peer' option
for the x509 creds to require the client to provide a x509
certificate. This means the client will have to acquire a certificate
from the CA before they are permitted to use the chardev server. This is
still a fairly low bar.

This adds a 'tls-authz=OBJECT-ID' option to the socket chardev backend
which takes the ID of a previously added 'QAuthZ' object instance. This
will be used to validate the client's x509 distinguished name. Clients
failing the check will not be permitted to use the chardev server.

For example to setup authorization that only allows connection from a
client whose x509 certificate distinguished name contains 'CN=fred', you
would use:

  $QEMU -object tls-creds-x509,id=tls0,dir=/home/berrange/qemutls,\
                endpoint=server,verify-peer=yes \
        -object authz-simple,id=authz0,policy=deny,\
                rules.0.match=\*CN=fred,rules.0.policy=allow \
        -chardev socket,host=127.0.0.1,port=9000,server,\
	         tls-creds=tls0,tls-authz=authz0 \
        ...other qemud args...

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 chardev/char-socket.c | 11 ++++++++++-
 chardev/char.c        |  3 +++
 qapi/char.json        |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 159e69c3b1..d0c9d26025 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -53,6 +53,7 @@ typedef struct {
     QIONetListener *listener;
     GSource *hup_source;
     QCryptoTLSCreds *tls_creds;
+    char *tls_authz;
     int connected;
     int max_size;
     int do_telnetopt;
@@ -729,7 +730,7 @@ static void tcp_chr_tls_init(Chardev *chr)
     if (s->is_listen) {
         tioc = qio_channel_tls_new_server(
             s->ioc, s->tls_creds,
-            NULL, /* XXX Use an ACL */
+            s->tls_authz,
             &err);
     } else {
         tioc = qio_channel_tls_new_client(
@@ -881,6 +882,7 @@ static void char_socket_finalize(Object *obj)
     if (s->tls_creds) {
         object_unref(OBJECT(s->tls_creds));
     }
+    g_free(s->tls_authz);
 
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
@@ -986,6 +988,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
             }
         }
     }
+    s->tls_authz = g_strdup(sock->tls_authz);
 
     s->addr = addr = socket_address_flatten(sock->addr);
 
@@ -1066,6 +1069,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     const char *fd = qemu_opt_get(opts, "fd");
     const char *tls_creds = qemu_opt_get(opts, "tls-creds");
     SocketAddressLegacy *addr;
+    const char *tls_authz = qemu_opt_get(opts, "tls-authz");
     ChardevSocket *sock;
 
     if ((!!path + !!fd + !!host) != 1) {
@@ -1094,6 +1098,10 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     } else {
         g_assert_not_reached();
     }
+    if (tls_authz && !tls_creds) {
+        error_setg(errp, "Authorization can only be used when TLS is enabled");
+        return;
+    }
 
     sock = backend->u.socket.data = g_new0(ChardevSocket, 1);
     qemu_chr_parse_common(opts, qapi_ChardevSocket_base(sock));
@@ -1111,6 +1119,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     sock->has_reconnect = true;
     sock->reconnect = reconnect;
     sock->tls_creds = g_strdup(tls_creds);
+    sock->tls_authz = g_strdup(tls_authz);
 
     addr = g_new0(SocketAddressLegacy, 1);
     if (path) {
diff --git a/chardev/char.c b/chardev/char.c
index 76d866e6fe..d28c16ccca 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -837,6 +837,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "tls-creds",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "tls-authz",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "width",
             .type = QEMU_OPT_NUMBER,
diff --git a/qapi/char.json b/qapi/char.json
index ae19dcd1ed..284f3ee4f1 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -242,6 +242,7 @@
 # @addr: socket address to listen on (server=true)
 #        or connect to (server=false)
 # @tls-creds: the ID of the TLS credentials object (since 2.6)
+# @tls-authz: the ID of the QAuthZ authorization object (since 2.13)
 # @server: create server socket (default: true)
 # @wait: wait for incoming connection on server
 #        sockets (default: false).
@@ -259,6 +260,7 @@
 ##
 { 'struct': 'ChardevSocket', 'data': { 'addr'       : 'SocketAddressLegacy',
                                      '*tls-creds'  : 'str',
+                                     '*tls-authz'  : 'str',
                                      '*server'    : 'bool',
                                      '*wait'      : 'bool',
                                      '*nodelay'   : 'bool',
-- 
2.17.0
