Received: from eggs.gnu.org ([2001:4830:134:3::10]:38266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJZk-0006x1-9G
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJZj-00016S-56
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:11:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJZi-00014x-Ss
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:10:59 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:22 +0800
Message-Id: <20171108060130.3772-25-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 24/32] migration: return incoming task tag
 for sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

For socket based incoming migration, we attached a background task onto
main loop to handle the acception of connections. We never had a way to
destroy it before, only if we finished the migration.

Let's allow socket_start_incoming_migration() to return the source tag
of the listening async work, so that we may be able to clean it up in
the future.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/socket.c | 36 ++++++++++++++++++++++++------------
 migration/socket.h |  4 ++--
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/migration/socket.c b/migration/socket.c
index 4879f11e0f..e8f3325155 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -162,8 +162,12 @@ out:
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
 
@@ -172,30 +176,38 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
 
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
+    guint tag = 0;
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
index 6b91e9db38..bc8a59aee4 100644
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
2.13.6
