Received: from eggs.gnu.org ([2001:4830:134:3::10]:56807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhym-00054X-Lg
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyl-0007Sg-GD
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:28 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyl-0007SF-6x
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:27 -0500
Received: by mail-wr0-x242.google.com with SMTP id s66so22904335wrc.9
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:58 +0100
Message-Id: <1513790098-9815-47-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 46/46] chardev: convert the socket server to
 QIONetListener
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

Instead of creating a QIOChannelSocket directly for the chardev
server socket, use a QIONetListener. This provides the ability
to listen on multiple sockets at the same time, so enables
full support for IPv4/IPv6 dual stack.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20171218135417.28301-2-berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c | 73 +++++++++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 43 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 53eda8e..630a7f2 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -25,6 +25,7 @@
 #include "chardev/char.h"
 #include "io/channel-socket.h"
 #include "io/channel-tls.h"
+#include "io/net-listener.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
@@ -40,8 +41,7 @@ typedef struct {
     Chardev parent;
     QIOChannel *ioc; /* Client I/O channel */
     QIOChannelSocket *sioc; /* Client master channel */
-    QIOChannelSocket *listen_ioc;
-    guint listen_tag;
+    QIONetListener *listener;
     QCryptoTLSCreds *tls_creds;
     int connected;
     int max_size;
@@ -93,9 +93,9 @@ static void check_report_connect_error(Chardev *chr,
     qemu_chr_socket_restart_timer(chr);
 }
 
-static gboolean tcp_chr_accept(QIOChannel *chan,
-                               GIOCondition cond,
-                               void *opaque);
+static void tcp_chr_accept(QIONetListener *listener,
+                           QIOChannelSocket *cioc,
+                           void *opaque);
 
 static int tcp_chr_read_poll(void *opaque);
 static void tcp_chr_disconnect(Chardev *chr);
@@ -401,9 +401,9 @@ static void tcp_chr_disconnect(Chardev *chr)
 
     tcp_chr_free_connection(chr);
 
-    if (s->listen_ioc && s->listen_tag == 0) {
-        s->listen_tag = qio_channel_add_watch(
-            QIO_CHANNEL(s->listen_ioc), G_IO_IN, tcp_chr_accept, chr, NULL);
+    if (s->listener) {
+        qio_net_listener_set_client_func(s->listener, tcp_chr_accept,
+                                         chr, NULL);
     }
     update_disconnected_filename(s);
     if (emit_close) {
@@ -702,9 +702,8 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
     if (s->do_nodelay) {
         qio_channel_set_delay(s->ioc, false);
     }
-    if (s->listen_tag) {
-        g_source_remove(s->listen_tag);
-        s->listen_tag = 0;
+    if (s->listener) {
+        qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
     }
 
     if (s->tls_creds) {
@@ -736,24 +735,14 @@ static int tcp_chr_add_client(Chardev *chr, int fd)
     return ret;
 }
 
-static gboolean tcp_chr_accept(QIOChannel *channel,
-                               GIOCondition cond,
-                               void *opaque)
+static void tcp_chr_accept(QIONetListener *listener,
+                           QIOChannelSocket *cioc,
+                           void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
-    QIOChannelSocket *sioc;
-
-    sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(channel),
-                                     NULL);
-    if (!sioc) {
-        return TRUE;
-    }
-
-    tcp_chr_new_client(chr, sioc);
 
-    object_unref(OBJECT(sioc));
-
-    return TRUE;
+    tcp_chr_set_client_ioc_name(chr, cioc);
+    tcp_chr_new_client(chr, cioc);
 }
 
 static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
@@ -767,9 +756,10 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
         if (s->is_listen) {
             info_report("QEMU waiting for connection on: %s",
                         chr->filename);
-            qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true, NULL);
-            tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
-            qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), false, NULL);
+            sioc = qio_net_listener_wait_client(s->listener);
+            tcp_chr_set_client_ioc_name(chr, sioc);
+            tcp_chr_new_client(chr, sioc);
+            object_unref(OBJECT(sioc));
         } else {
             sioc = qio_channel_socket_new();
             tcp_chr_set_client_ioc_name(chr, sioc);
@@ -797,12 +787,9 @@ static void char_socket_finalize(Object *obj)
         s->reconnect_timer = 0;
     }
     qapi_free_SocketAddress(s->addr);
-    if (s->listen_tag) {
-        g_source_remove(s->listen_tag);
-        s->listen_tag = 0;
-    }
-    if (s->listen_ioc) {
-        object_unref(OBJECT(s->listen_ioc));
+    if (s->listener) {
+        qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
+        object_unref(OBJECT(s->listener));
     }
     if (s->tls_creds) {
         object_unref(OBJECT(s->tls_creds));
@@ -935,29 +922,29 @@ static void qmp_chardev_open_socket(Chardev *chr,
     } else {
         if (s->is_listen) {
             char *name;
-            sioc = qio_channel_socket_new();
+            s->listener = qio_net_listener_new();
 
             name = g_strdup_printf("chardev-tcp-listener-%s", chr->label);
-            qio_channel_set_name(QIO_CHANNEL(sioc), name);
+            qio_net_listener_set_name(s->listener, name);
             g_free(name);
 
-            if (qio_channel_socket_listen_sync(sioc, s->addr, errp) < 0) {
+            if (qio_net_listener_open_sync(s->listener, s->addr, errp) < 0) {
+                object_unref(OBJECT(s->listener));
+                s->listener = NULL;
                 goto error;
             }
 
             qapi_free_SocketAddress(s->addr);
-            s->addr = socket_local_address(sioc->fd, errp);
+            s->addr = socket_local_address(s->listener->sioc[0]->fd, errp);
             update_disconnected_filename(s);
 
-            s->listen_ioc = sioc;
             if (is_waitconnect &&
                 qemu_chr_wait_connected(chr, errp) < 0) {
                 return;
             }
             if (!s->ioc) {
-                s->listen_tag = qio_channel_add_watch(
-                    QIO_CHANNEL(s->listen_ioc), G_IO_IN,
-                    tcp_chr_accept, chr, NULL);
+                qio_net_listener_set_client_func(s->listener, tcp_chr_accept,
+                                                 chr, NULL);
             }
         } else if (qemu_chr_wait_connected(chr, errp) < 0) {
             goto error;
-- 
1.8.3.1
