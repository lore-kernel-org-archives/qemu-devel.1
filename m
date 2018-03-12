Received: from eggs.gnu.org ([2001:4830:134:3::10]:35311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evOGX-0003AF-HY
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evOGU-0007mr-Rh
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:17:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evOGU-0007l9-MQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:17:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6CF8240201A3
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 14:17:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 12 Mar 2018 14:17:14 +0000
Message-Id: <20180312141714.7223-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 REPOST] migration: convert socket
 server to QIONetListener
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Instead of creating a QIOChannelSocket directly for the migration
server socket, use a QIONetListener. This provides the ability
to listen on multiple sockets at the same time, so enables
full support for IPv4/IPv6 dual stack.

For example,   '$QEMU -incoming tcp::9000' now correctly listens
on both 0.0.0.0 and :: at the same time, instead of only on 0.0.0.0.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 migration/socket.c | 48 ++++++++++++++++--------------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/migration/socket.c b/migration/socket.c
index 8a93fb1af5..122d8ccfbe 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -24,6 +24,7 @@
 #include "migration.h"
 #include "qemu-file.h"
 #include "io/channel-socket.h"
+#include "io/net-listener.h"
 #include "trace.h"
 
 
@@ -129,34 +130,20 @@ void unix_start_outgoing_migration(MigrationState *s,
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
     if (migration_has_all_channels()) {
         /* Close listening socket as its no longer needed */
-        qio_channel_close(ioc, NULL);
-        return G_SOURCE_REMOVE;
-    } else {
-        return G_SOURCE_CONTINUE;
+        qio_net_listener_disconnect(listener);
+
+        object_unref(OBJECT(listener));
     }
 }
 
@@ -164,21 +151,18 @@ out:
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
         return;
     }
 
-    qio_channel_add_watch(QIO_CHANNEL(listen_ioc),
-                          G_IO_IN,
-                          socket_accept_incoming_migration,
-                          listen_ioc,
-                          (GDestroyNotify)object_unref);
+    qio_net_listener_set_client_func(listener,
+                                     socket_accept_incoming_migration,
+                                     NULL, NULL);
 }
 
 void tcp_start_incoming_migration(const char *host_port, Error **errp)
-- 
2.14.3
