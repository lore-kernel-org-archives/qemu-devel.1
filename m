Received: from eggs.gnu.org ([2001:4830:134:3::10]:46545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpzJ-0006Pf-7S
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpzH-0003rc-J2
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:07:09 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 10 Aug 2017 17:04:49 +0100
Message-Id: <20170810160451.32723-7-berrange@redhat.com>
In-Reply-To: <20170810160451.32723-1-berrange@redhat.com>
References: <20170810160451.32723-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 6/8] chardev: convert the socket server to
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
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

Instead of creating a QIOChannelSocket directly for the chardev
server socket, use a QIONetListener. This provides the ability
to listen on multiple sockets at the same time, so enables
full support for IPv4/IPv6 dual stack.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 chardev/char-socket.c      | 70 ++++++++++++++++++----------------------------
 tests/test-sockets-proto.c |  8 ++----
 2 files changed, 29 insertions(+), 49 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1ae730a4cb..96ff2a3ff4 100644
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
@@ -404,9 +404,8 @@ static void tcp_chr_disconnect(Chardev *chr)
 
     tcp_chr_free_connection(chr);
 
-    if (s->listen_ioc) {
-        s->listen_tag = qio_channel_add_watch(
-            QIO_CHANNEL(s->listen_ioc), G_IO_IN, tcp_chr_accept, chr, NULL);
+    if (s->listener) {
+        qio_net_listener_set_client_func(s->listener, tcp_chr_accept, chr, NULL);
     }
     update_disconnected_filename(s);
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
@@ -704,9 +703,8 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
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
@@ -738,24 +736,14 @@ static int tcp_chr_add_client(Chardev *chr, int fd)
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
@@ -769,9 +757,10 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
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
@@ -799,12 +788,9 @@ static void char_socket_finalize(Object *obj)
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
@@ -937,29 +923,27 @@ static void qmp_chardev_open_socket(Chardev *chr,
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
+                qio_net_listener_set_client_func(s->listener, tcp_chr_accept, chr, NULL);
             }
         } else if (qemu_chr_wait_connected(chr, errp) < 0) {
             goto error;
diff --git a/tests/test-sockets-proto.c b/tests/test-sockets-proto.c
index 1495369696..a92389bef6 100644
--- a/tests/test-sockets-proto.c
+++ b/tests/test-sockets-proto.c
@@ -18,7 +18,7 @@ typedef struct {
     const char *name;
     const char *args;
     int ipv4; /* 0 -> disabled, 1 -> enabled */
-    int ipv6; /* 0 -> disabled, 1 -> enabled, -1 -> check getaddrinfo() order */
+    int ipv6; /* 0 -> disabled, 1 -> enabled */
     bool error;
 } QSocketsData;
 
@@ -189,8 +189,7 @@ static QSocketsData test_data[] = {
 
 
     /* Chardev with "" address */
-    /* XXX multilistener bug - should be .ipv6 = 1 */
-    { .ipv4 = 1, .ipv6 = -1, .error = false,
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
       .name = "/sockets/chardev/wildcard/all",
       .args = "-chardev socket,id=cdev0,host=,port=9000,server,nowait" },
     { .ipv4 = 1, .ipv6 = 0, .error = false,
@@ -911,9 +910,6 @@ int main(int argc, char **argv)
 
     for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
         QSocketsData *data = &test_data[i];
-        if (data->ipv6 == -1) {
-            data->ipv6 = ipv6_first ? 1 : 0;
-        }
         g_test_add_data_func(data->name, data, test_listen);
     }
 
-- 
2.13.3
