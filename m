Received: from eggs.gnu.org ([2001:4830:134:3::10]:32806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eejvt-0005sG-DJ
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:59:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eejvs-0004p2-Kg
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:59:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eejvs-0004nk-Dj
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:59:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B8EE78232
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 15:59:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 25 Jan 2018 15:59:15 +0000
Message-Id: <20180125155915.3226-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: convert socket server to
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
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Instead of creating a QIOChannelSocket directly for the migration
server socket, use a QIONetListener. This provides the ability
to listen on multiple sockets at the same time, so enables
full support for IPv4/IPv6 dual stack.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 migration/socket.c | 48 ++++++++++++++++--------------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/migration/socket.c b/migration/socket.c
index 3a8232dd2d..d0ef50765c 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -24,6 +24,7 @@
 #include "migration.h"
 #include "qemu-file.h"
 #include "io/channel-socket.h"
+#include "io/net-listener.h"
 #include "trace.h"
 
 
@@ -130,34 +131,20 @@ void unix_start_outgoing_migration(MigrationState *s,
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
 
@@ -165,21 +152,18 @@ out:
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
