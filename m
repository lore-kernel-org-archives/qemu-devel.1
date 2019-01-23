Received: from eggs.gnu.org ([209.51.188.92]:41734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMJl-0002Lt-9D
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMJj-0002UH-9f
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmMJh-0002T1-GC
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:27:59 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 23 Jan 2019 17:27:27 +0000
Message-Id: <20190123172740.32452-4-berrange@redhat.com>
In-Reply-To: <20190123172740.32452-1-berrange@redhat.com>
References: <20190123172740.32452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/16] chardev: fix validation of options
 for QMP created chardevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Yongji Xie <elohimes@gmail.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The TLS creds option is not valid with certain address types. The user
config was only checked for errors when parsing legacy QemuOpts, thus
the user could pass unsupported values via QMP.

Pull all code for validating options out into a new method
qmp_chardev_validate_socket, that is called from the main
qmp_chardev_open_socket method. This adds a missing check for rejecting
TLS creds with the vsock address type.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 92 +++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 26 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index eaa8e8b68f..e85250b624 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -987,6 +987,65 @@ static gboolean socket_reconnect_timeout(gpointer op=
aque)
     return false;
 }
=20
+
+static bool qmp_chardev_validate_socket(ChardevSocket *sock,
+                                        SocketAddress *addr,
+                                        Error **errp)
+{
+    /* Validate any options which have a dependency on address type */
+    switch (addr->type) {
+    case SOCKET_ADDRESS_TYPE_FD:
+        if (sock->has_reconnect) {
+            error_setg(errp,
+                       "'reconnect' option is incompatible with "
+                       "'fd' address type");
+            return false;
+        }
+        if (sock->has_tls_creds &&
+            !(sock->has_server && sock->server)) {
+            error_setg(errp,
+                       "'tls_creds' option is incompatible with "
+                       "'fd' address type as client");
+            return false;
+        }
+        break;
+
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        if (sock->has_tls_creds) {
+            error_setg(errp,
+                       "'tls_creds' option is incompatible with "
+                       "'unix' address type");
+            return false;
+        }
+        break;
+
+    case SOCKET_ADDRESS_TYPE_INET:
+        break;
+
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        if (sock->has_tls_creds) {
+            error_setg(errp,
+                       "'tls_creds' option is incompatible with "
+                       "'vsock' address type");
+            return false;
+        }
+
+    default:
+        break;
+    }
+
+    /* Validate any options which have a dependancy on client vs server =
*/
+    if (!(sock->has_server && sock->server)) {
+        if (sock->has_websocket && sock->websocket) {
+            error_setg(errp, "%s", "Websocket client is not implemented"=
);
+            return false;
+        }
+    }
+
+    return true;
+}
+
+
 static void qmp_chardev_open_socket(Chardev *chr,
                                     ChardevBackend *backend,
                                     bool *be_opened,
@@ -1004,11 +1063,6 @@ static void qmp_chardev_open_socket(Chardev *chr,
     QIOChannelSocket *sioc =3D NULL;
     SocketAddress *addr;
=20
-    if (!is_listen && is_websock) {
-        error_setg(errp, "%s", "Websocket client is not implemented");
-        goto error;
-    }
-
     s->is_listen =3D is_listen;
     s->is_telnet =3D is_telnet;
     s->is_tn3270 =3D is_tn3270;
@@ -1049,10 +1103,10 @@ static void qmp_chardev_open_socket(Chardev *chr,
=20
     s->addr =3D addr =3D socket_address_flatten(sock->addr);
=20
-    if (sock->has_reconnect && addr->type =3D=3D SOCKET_ADDRESS_TYPE_FD)=
 {
-        error_setg(errp, "'reconnect' option is incompatible with 'fd'")=
;
+    if (!qmp_chardev_validate_socket(sock, addr, errp)) {
         goto error;
     }
+
     qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
     /* TODO SOCKET_ADDRESS_FD where fd has AF_UNIX */
     if (addr->type =3D=3D SOCKET_ADDRESS_TYPE_UNIX) {
@@ -1140,27 +1194,12 @@ static void qemu_chr_parse_socket(QemuOpts *opts,=
 ChardevBackend *backend,
         return;
     }
=20
-    backend->type =3D CHARDEV_BACKEND_KIND_SOCKET;
-    if (path) {
-        if (tls_creds) {
-            error_setg(errp, "TLS can only be used over TCP socket");
-            return;
-        }
-    } else if (host) {
-        if (!port) {
-            error_setg(errp, "chardev: socket: no port given");
-            return;
-        }
-    } else if (fd) {
-        /* We don't know what host to validate against when in client mo=
de */
-        if (tls_creds && !is_listen) {
-            error_setg(errp, "TLS can not be used with pre-opened client=
 FD");
-            return;
-        }
-    } else {
-        g_assert_not_reached();
+    if (host && !port) {
+        error_setg(errp, "chardev: socket: no port given");
+        return;
     }
=20
+    backend->type =3D CHARDEV_BACKEND_KIND_SOCKET;
     sock =3D backend->u.socket.data =3D g_new0(ChardevSocket, 1);
     qemu_chr_parse_common(opts, qapi_ChardevSocket_base(sock));
=20
@@ -1178,6 +1217,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
     sock->wait =3D is_waitconnect;
     sock->has_reconnect =3D qemu_opt_find(opts, "reconnect");
     sock->reconnect =3D reconnect;
+    sock->has_tls_creds =3D tls_creds;
     sock->tls_creds =3D g_strdup(tls_creds);
=20
     addr =3D g_new0(SocketAddressLegacy, 1);
--=20
2.20.1
