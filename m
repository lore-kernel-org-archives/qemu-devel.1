Received: from eggs.gnu.org ([2001:4830:134:3::10]:46216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpz4-0006Fb-TR
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpz3-0003iV-Ks
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:06:54 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 10 Aug 2017 17:04:47 +0100
Message-Id: <20170810160451.32723-5-berrange@redhat.com>
In-Reply-To: <20170810160451.32723-1-berrange@redhat.com>
References: <20170810160451.32723-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 4/8] blockdev: convert qemu-nbd server to
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

Instead of creating a QIOChannelSocket directly for the NBD
server socket, use a QIONetListener. This provides the ability
to listen on multiple sockets at the same time, so enables
full support for IPv4/IPv6 dual stack.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-nbd.c | 50 +++++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index b8666bb575..dcde7ac75c 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -38,6 +38,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qom/object_interfaces.h"
 #include "io/channel-socket.h"
+#include "io/net-listener.h"
 #include "crypto/init.h"
 #include "trace/control.h"
 #include "qemu-version.h"
@@ -63,8 +64,7 @@ static int persistent = 0;
 static enum { RUNNING, TERMINATE, TERMINATING, TERMINATED } state;
 static int shared = 1;
 static int nb_fds;
-static QIOChannelSocket *server_ioc;
-static int server_watch = -1;
+static QIONetListener *server;
 static QCryptoTLSCreds *tlscreds;
 
 static void usage(const char *name)
@@ -345,44 +345,24 @@ static void nbd_client_closed(NBDClient *client, bool negotiated)
     nbd_client_put(client);
 }
 
-static gboolean nbd_accept(QIOChannel *ioc, GIOCondition cond, gpointer opaque)
+static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc, gpointer opaque)
 {
-    QIOChannelSocket *cioc;
-
-    cioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
-                                     NULL);
-    if (!cioc) {
-        return TRUE;
-    }
-
     if (state >= TERMINATE) {
-        object_unref(OBJECT(cioc));
-        return TRUE;
+        return;
     }
 
     nb_fds++;
     nbd_update_server_watch();
     nbd_client_new(newproto ? NULL : exp, cioc,
                    tlscreds, NULL, nbd_client_closed);
-    object_unref(OBJECT(cioc));
-
-    return TRUE;
 }
 
 static void nbd_update_server_watch(void)
 {
     if (nbd_can_accept()) {
-        if (server_watch == -1) {
-            server_watch = qio_channel_add_watch(QIO_CHANNEL(server_ioc),
-                                                 G_IO_IN,
-                                                 nbd_accept,
-                                                 NULL, NULL);
-        }
+        qio_net_listener_set_client_func(server, nbd_accept, NULL, NULL);
     } else {
-        if (server_watch != -1) {
-            g_source_remove(server_watch);
-            server_watch = -1;
-        }
+        qio_net_listener_set_client_func(server, NULL, NULL, NULL);
     }
 }
 
@@ -917,24 +897,28 @@ int main(int argc, char **argv)
         snprintf(sockpath, 128, SOCKET_PATH, basename(device));
     }
 
+    server = qio_net_listener_new();
     if (socket_activation == 0) {
-        server_ioc = qio_channel_socket_new();
         saddr = nbd_build_socket_address(sockpath, bindto, port);
-        if (qio_channel_socket_listen_sync(server_ioc, saddr, &local_err) < 0) {
-            object_unref(OBJECT(server_ioc));
+        if (qio_net_listener_open_sync(server, saddr, &local_err) < 0) {
+            object_unref(OBJECT(server));
             error_report_err(local_err);
-            return 1;
+            exit(EXIT_FAILURE);
         }
     } else {
+        QIOChannelSocket *sioc;
         /* See comment in check_socket_activation above. */
         assert(socket_activation == 1);
-        server_ioc = qio_channel_socket_new_fd(FIRST_SOCKET_ACTIVATION_FD,
-                                               &local_err);
-        if (server_ioc == NULL) {
+        sioc = qio_channel_socket_new_fd(FIRST_SOCKET_ACTIVATION_FD,
+                                         &local_err);
+        if (sioc == NULL) {
+            object_unref(OBJECT(server));
             error_report("Failed to use socket activation: %s",
                          error_get_pretty(local_err));
             exit(EXIT_FAILURE);
         }
+        qio_net_listener_add(server, sioc);
+        object_unref(OBJECT(sioc));
     }
 
     if (qemu_init_main_loop(&local_err)) {
-- 
2.13.3
