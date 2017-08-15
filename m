Received: from eggs.gnu.org ([2001:4830:134:3::10]:49475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVGR-0001oJ-9l
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:23:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVGM-0005CG-Cs
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:23:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dhVGM-0005Bj-3f
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:23:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 633AE2C96E0
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 06:17:23 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 15 Aug 2017 14:17:03 +0800
Message-Id: <1502777827-18874-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1502777827-18874-1-git-send-email-peterx@redhat.com>
References: <1502777827-18874-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 2/6] migration: return incoming task tag for
 sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

For socket based incoming migration, we attached a background task onto
main loop to handle the acception of connections. We never had a way to
destroy it before, only if we finished the migration.

Let's allow socket_start_incoming_migration() to return the source tag
of the listening async work, so that we may be able to clean it up in
the future.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/socket.c | 36 ++++++++++++++++++++++++------------
 migration/socket.h |  4 ++--
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/migration/socket.c b/migration/socket.c
index 9fc6cb3..6ee51ef 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -158,8 +158,12 @@ out:
 }
 
 
-static void socket_start_incoming_migration(SocketAddress *saddr,
-                                            Error **errp)
+/*
+ * Returns the tag ID of the watch that is attached to global main
+ * loop (>0), or zero if failure detected.
+ */
+static guint socket_start_incoming_migration(SocketAddress *saddr,
+                                             Error **errp)
 {
     QIOChannelSocket *listen_ioc = qio_channel_socket_new();
 
@@ -168,30 +172,38 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
 
     if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0) {
         object_unref(OBJECT(listen_ioc));
-        return;
+        return 0;
     }
 
-    qio_channel_add_watch(QIO_CHANNEL(listen_ioc),
-                          G_IO_IN,
-                          socket_accept_incoming_migration,
-                          listen_ioc,
-                          (GDestroyNotify)object_unref);
+    return qio_channel_add_watch(QIO_CHANNEL(listen_ioc),
+                                 G_IO_IN,
+                                 socket_accept_incoming_migration,
+                                 listen_ioc,
+                                 (GDestroyNotify)object_unref);
 }
 
-void tcp_start_incoming_migration(const char *host_port, Error **errp)
+guint tcp_start_incoming_migration(const char *host_port, Error **errp)
 {
     Error *err = NULL;
     SocketAddress *saddr = tcp_build_address(host_port, &err);
+    guint tag;
+
     if (!err) {
-        socket_start_incoming_migration(saddr, &err);
+        tag = socket_start_incoming_migration(saddr, &err);
     }
     error_propagate(errp, err);
     qapi_free_SocketAddress(saddr);
+
+    return tag;
 }
 
-void unix_start_incoming_migration(const char *path, Error **errp)
+guint unix_start_incoming_migration(const char *path, Error **errp)
 {
     SocketAddress *saddr = unix_build_address(path);
-    socket_start_incoming_migration(saddr, errp);
+    guint tag;
+
+    tag = socket_start_incoming_migration(saddr, errp);
     qapi_free_SocketAddress(saddr);
+
+    return tag;
 }
diff --git a/migration/socket.h b/migration/socket.h
index 6b91e9d..bc8a59a 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -16,12 +16,12 @@
 
 #ifndef QEMU_MIGRATION_SOCKET_H
 #define QEMU_MIGRATION_SOCKET_H
-void tcp_start_incoming_migration(const char *host_port, Error **errp);
+guint tcp_start_incoming_migration(const char *host_port, Error **errp);
 
 void tcp_start_outgoing_migration(MigrationState *s, const char *host_port,
                                   Error **errp);
 
-void unix_start_incoming_migration(const char *path, Error **errp);
+guint unix_start_incoming_migration(const char *path, Error **errp);
 
 void unix_start_outgoing_migration(MigrationState *s, const char *path,
                                    Error **errp);
-- 
2.7.4
