Received: from eggs.gnu.org ([2001:4830:134:3::10]:46466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpzG-0006OC-BA
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpzB-0003mc-Nm
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:07:06 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 10 Aug 2017 17:04:48 +0100
Message-Id: <20170810160451.32723-6-berrange@redhat.com>
In-Reply-To: <20170810160451.32723-1-berrange@redhat.com>
References: <20170810160451.32723-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 5/8] migration: convert socket server to
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

Instead of creating a QIOChannelSocket directly for the migration
server socket, use a QIONetListener. This provides the ability
to listen on multiple sockets at the same time, so enables
full support for IPv4/IPv6 dual stack.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 migration/socket.c         | 44 ++++++++++++++------------------------------
 tests/test-sockets-proto.c |  3 +--
 2 files changed, 15 insertions(+), 32 deletions(-)

diff --git a/migration/socket.c b/migration/socket.c
index 757d3821a1..34811addc5 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -24,6 +24,7 @@
 #include "migration.h"
 #include "qemu-file.h"
 #include "io/channel-socket.h"
+#include "io/net-listener.h"
 #include "trace.h"
 
 
@@ -130,53 +131,36 @@ void unix_start_outgoing_migration(MigrationState *s,
 }
 
 
-static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
-                                                 GIOCondition condition,
-                                                 gpointer opaque)
+static void socket_accept_incoming_migration(QIONetListener *listener,
+                                             QIOChannelSocket *cioc,
+                                             gpointer opaque)
 {
-    QIOChannelSocket *sioc;
-    Error *err = NULL;
-
-    sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
-                                     &err);
-    if (!sioc) {
-        error_report("could not accept migration connection (%s)",
-                     error_get_pretty(err));
-        goto out;
-    }
-
     trace_migration_socket_incoming_accepted();
 
-    qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-incoming");
-    migration_channel_process_incoming(QIO_CHANNEL(sioc));
-    object_unref(OBJECT(sioc));
+    qio_channel_set_name(QIO_CHANNEL(cioc), "migration-socket-incoming");
+    migration_channel_process_incoming(QIO_CHANNEL(cioc));
 
-out:
     /* Close listening socket as its no longer needed */
-    qio_channel_close(ioc, NULL);
-    return FALSE; /* unregister */
+    qio_net_listener_disconnect(listener);
+
+    object_unref(OBJECT(listener));
 }
 
 
 static void socket_start_incoming_migration(SocketAddress *saddr,
                                             Error **errp)
 {
-    QIOChannelSocket *listen_ioc = qio_channel_socket_new();
+    QIONetListener *listener = qio_net_listener_new();
 
-    qio_channel_set_name(QIO_CHANNEL(listen_ioc),
-                         "migration-socket-listener");
+    qio_net_listener_set_name(listener, "migration-socket-listener");
 
-    if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0) {
-        object_unref(OBJECT(listen_ioc));
+    if (qio_net_listener_open_sync(listener, saddr, errp) < 0) {
+        object_unref(OBJECT(listener));
         qapi_free_SocketAddress(saddr);
         return;
     }
 
-    qio_channel_add_watch(QIO_CHANNEL(listen_ioc),
-                          G_IO_IN,
-                          socket_accept_incoming_migration,
-                          listen_ioc,
-                          (GDestroyNotify)object_unref);
+    qio_net_listener_set_client_func(listener, socket_accept_incoming_migration, NULL, NULL);
     qapi_free_SocketAddress(saddr);
 }
 
diff --git a/tests/test-sockets-proto.c b/tests/test-sockets-proto.c
index 1d6beda59f..1495369696 100644
--- a/tests/test-sockets-proto.c
+++ b/tests/test-sockets-proto.c
@@ -70,8 +70,7 @@ typedef struct {
 static QSocketsData test_data[] = {
     /* Migrate with "" address */
     /* XXX all settings with =off are disabled due to inet_parse() bug */
-    /* XXX multilistener bug - should be .ipv6 = 1 */
-    { .ipv4 = 1, .ipv6 = -1, .error = false,
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
       .name = "/sockets/migrate/wildcard/all",
       .args = "-incoming tcp::9000" },
     { .ipv4 = 1, .ipv6 = 0, .error = false,
-- 
2.13.3
