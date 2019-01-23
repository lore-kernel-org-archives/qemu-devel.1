Received: from eggs.gnu.org ([209.51.188.92]:41999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMKX-0002ys-26
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMKU-0002r2-2n
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmMKT-0002mM-Kr
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:45 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 23 Jan 2019 17:27:34 +0000
Message-Id: <20190123172740.32452-11-berrange@redhat.com>
In-Reply-To: <20190123172740.32452-1-berrange@redhat.com>
References: <20190123172740.32452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/16] chardev: split up
 qmp_chardev_open_socket connection code
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

In qmp_chardev_open_socket the code for connecting client chardevs is
split across two conditionals far apart with some server chardev code in
the middle. Split up the method so that code for client connection setup
is separate from code for server connection setup.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 96 +++++++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 36 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 222adbbad3..90dafef7d4 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1005,6 +1005,61 @@ static gboolean socket_reconnect_timeout(gpointer =
opaque)
 }
=20
=20
+static int qmp_chardev_open_socket_server(Chardev *chr,
+                                          bool is_telnet,
+                                          bool is_waitconnect,
+                                          Error **errp)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    char *name;
+    if (is_telnet) {
+        s->do_telnetopt =3D 1;
+    }
+    s->listener =3D qio_net_listener_new();
+
+    name =3D g_strdup_printf("chardev-tcp-listener-%s", chr->label);
+    qio_net_listener_set_name(s->listener, name);
+    g_free(name);
+
+    if (qio_net_listener_open_sync(s->listener, s->addr, errp) < 0) {
+        object_unref(OBJECT(s->listener));
+        s->listener =3D NULL;
+        return -1;
+    }
+
+    qapi_free_SocketAddress(s->addr);
+    s->addr =3D socket_local_address(s->listener->sioc[0]->fd, errp);
+    update_disconnected_filename(s);
+
+    if (is_waitconnect) {
+        tcp_chr_accept_server_sync(chr);
+    } else {
+        qio_net_listener_set_client_func_full(s->listener,
+                                              tcp_chr_accept,
+                                              chr, NULL,
+                                              chr->gcontext);
+    }
+
+    return 0;
+}
+
+
+static int qmp_chardev_open_socket_client(Chardev *chr,
+                                          int64_t reconnect,
+                                          Error **errp)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+
+    if (reconnect > 0) {
+        s->reconnect_time =3D reconnect;
+        tcp_chr_connect_client_async(chr);
+        return 0;
+    } else {
+        return tcp_chr_connect_client_sync(chr, errp);
+    }
+}
+
+
 static bool qmp_chardev_validate_socket(ChardevSocket *sock,
                                         SocketAddress *addr,
                                         Error **errp)
@@ -1147,44 +1202,13 @@ static void qmp_chardev_open_socket(Chardev *chr,
=20
     update_disconnected_filename(s);
=20
-    if (is_listen) {
-        if (is_telnet || is_tn3270) {
-            s->do_telnetopt =3D 1;
+    if (s->is_listen) {
+        if (qmp_chardev_open_socket_server(chr, is_telnet || is_tn3270,
+                                           is_waitconnect, errp) < 0) {
+            return;
         }
-    } else if (reconnect > 0) {
-        s->reconnect_time =3D reconnect;
-    }
-
-    if (s->reconnect_time) {
-        tcp_chr_connect_client_async(chr);
     } else {
-        if (s->is_listen) {
-            char *name;
-            s->listener =3D qio_net_listener_new();
-
-            name =3D g_strdup_printf("chardev-tcp-listener-%s", chr->lab=
el);
-            qio_net_listener_set_name(s->listener, name);
-            g_free(name);
-
-            if (qio_net_listener_open_sync(s->listener, s->addr, errp) <=
 0) {
-                object_unref(OBJECT(s->listener));
-                s->listener =3D NULL;
-                return;
-            }
-
-            qapi_free_SocketAddress(s->addr);
-            s->addr =3D socket_local_address(s->listener->sioc[0]->fd, e=
rrp);
-            update_disconnected_filename(s);
-
-            if (is_waitconnect) {
-                tcp_chr_accept_server_sync(chr);
-            } else {
-                qio_net_listener_set_client_func_full(s->listener,
-                                                      tcp_chr_accept,
-                                                      chr, NULL,
-                                                      chr->gcontext);
-            }
-        } else if (tcp_chr_connect_client_sync(chr, errp) < 0) {
+        if (qmp_chardev_open_socket_client(chr, reconnect, errp) < 0) {
             return;
         }
     }
--=20
2.20.1
