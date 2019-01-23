Received: from eggs.gnu.org ([209.51.188.92]:41913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMKU-0002wF-D3
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMKT-0002pl-6u
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmMKR-0002kk-3Z
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:44 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 23 Jan 2019 17:27:33 +0000
Message-Id: <20190123172740.32452-10-berrange@redhat.com>
In-Reply-To: <20190123172740.32452-1-berrange@redhat.com>
References: <20190123172740.32452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/16] chardev: split tcp_chr_wait_connected
 into two methods
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

The tcp_chr_wait_connected method can deal with either server or client
chardevs, but some callers only care about one of these possibilities.
The tcp_chr_wait_connected method will also need some refactoring to
reliably deal with its primary goal of allowing a device frontend to
wait for an established connection, which will interfere with other
callers.

Split it into two methods, one responsible for server initiated
connections, the other responsible for client initiated connections.
In doing this split the tcp_char_connect_async() method is renamed
to become consistent with naming of the new methods.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 59 +++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 8a5e5c2fe7..222adbbad3 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -886,30 +886,47 @@ static void tcp_chr_accept(QIONetListener *listener=
,
     tcp_chr_new_client(chr, cioc);
 }
=20
-static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
+
+static int tcp_chr_connect_client_sync(Chardev *chr, Error **errp)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    QIOChannelSocket *sioc =3D qio_channel_socket_new();
+    tcp_chr_set_client_ioc_name(chr, sioc);
+    if (qio_channel_socket_connect_sync(sioc, s->addr, errp) < 0) {
+        object_unref(OBJECT(sioc));
+        return -1;
+    }
+    tcp_chr_new_client(chr, sioc);
+    object_unref(OBJECT(sioc));
+    return 0;
+}
+
+
+static void tcp_chr_accept_server_sync(Chardev *chr)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
     QIOChannelSocket *sioc;
+    info_report("QEMU waiting for connection on: %s",
+                chr->filename);
+    sioc =3D qio_net_listener_wait_client(s->listener);
+    tcp_chr_set_client_ioc_name(chr, sioc);
+    tcp_chr_new_client(chr, sioc);
+    object_unref(OBJECT(sioc));
+}
+
=20
+static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
     /* It can't wait on s->connected, since it is set asynchronously
      * in TLS and telnet cases, only wait for an accepted socket */
     while (!s->ioc) {
         if (s->is_listen) {
-            info_report("QEMU waiting for connection on: %s",
-                        chr->filename);
-            sioc =3D qio_net_listener_wait_client(s->listener);
-            tcp_chr_set_client_ioc_name(chr, sioc);
-            tcp_chr_new_client(chr, sioc);
-            object_unref(OBJECT(sioc));
+            tcp_chr_accept_server_sync(chr);
         } else {
-            sioc =3D qio_channel_socket_new();
-            tcp_chr_set_client_ioc_name(chr, sioc);
-            if (qio_channel_socket_connect_sync(sioc, s->addr, errp) < 0=
) {
-                object_unref(OBJECT(sioc));
+            if (tcp_chr_connect_client_sync(chr, errp) < 0) {
                 return -1;
             }
-            tcp_chr_new_client(chr, sioc);
-            object_unref(OBJECT(sioc));
         }
     }
=20
@@ -958,7 +975,7 @@ cleanup:
     object_unref(OBJECT(sioc));
 }
=20
-static void tcp_chr_connect_async(Chardev *chr)
+static void tcp_chr_connect_client_async(Chardev *chr)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
     QIOChannelSocket *sioc;
@@ -982,7 +999,7 @@ static gboolean socket_reconnect_timeout(gpointer opa=
que)
         return false;
     }
=20
-    tcp_chr_connect_async(chr);
+    tcp_chr_connect_client_async(chr);
=20
     return false;
 }
@@ -1139,7 +1156,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     }
=20
     if (s->reconnect_time) {
-        tcp_chr_connect_async(chr);
+        tcp_chr_connect_client_async(chr);
     } else {
         if (s->is_listen) {
             char *name;
@@ -1159,17 +1176,15 @@ static void qmp_chardev_open_socket(Chardev *chr,
             s->addr =3D socket_local_address(s->listener->sioc[0]->fd, e=
rrp);
             update_disconnected_filename(s);
=20
-            if (is_waitconnect &&
-                qemu_chr_wait_connected(chr, errp) < 0) {
-                return;
-            }
-            if (!s->ioc) {
+            if (is_waitconnect) {
+                tcp_chr_accept_server_sync(chr);
+            } else {
                 qio_net_listener_set_client_func_full(s->listener,
                                                       tcp_chr_accept,
                                                       chr, NULL,
                                                       chr->gcontext);
             }
-        } else if (qemu_chr_wait_connected(chr, errp) < 0) {
+        } else if (tcp_chr_connect_client_sync(chr, errp) < 0) {
             return;
         }
     }
--=20
2.20.1
