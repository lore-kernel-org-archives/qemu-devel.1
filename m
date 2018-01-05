Received: from eggs.gnu.org ([2001:4830:134:3::10]:38619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXYxW-0002GP-9C
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 15:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXYxV-0005nW-2L
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 15:51:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eXYxU-0005m5-Ma
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 15:51:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C576FC051793
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 20:51:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  5 Jan 2018 21:51:09 +0100
Message-Id: <20180105205109.683-3-quintela@redhat.com>
In-Reply-To: <20180105205109.683-1-quintela@redhat.com>
References: <20180105205109.683-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/2] migration: Set the migration tcp port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

We can set the port parameter as zero.  This patch lets us know what
port the system was choosen for us.  Now we can migrate to this place.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

This was migrate_set_uri(), but as we only need the tcp_port, change
to that one.
---
 migration/migration.c | 10 ++++++++++
 migration/migration.h |  2 ++
 migration/socket.c    | 35 ++++++++++++++++++++++++++++++-----
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4cdd8ee31b..6257c2ddb7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -245,6 +245,16 @@ void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
     }
 }
 
+void migrate_set_port(const uint16_t port, Error **errp)
+{
+    MigrateSetParameters p = {
+        .has_tcp_port = true,
+        .tcp_port = port,
+    };
+
+    qmp_migrate_set_parameters(&p, errp);
+}
+
 void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p;
diff --git a/migration/migration.h b/migration/migration.h
index d84bc550b1..2c8c53847a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -223,4 +223,6 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
 void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
                               ram_addr_t start, size_t len);
 
+void migrate_set_port(const uint16_t port, Error **errp);
+
 #endif
diff --git a/migration/socket.c b/migration/socket.c
index 3a8232dd2d..248a798543 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 
 #include "qemu-common.h"
 #include "qemu/error-report.h"
@@ -162,17 +163,24 @@ out:
 }
 
 
-static void socket_start_incoming_migration(SocketAddress *saddr,
-                                            Error **errp)
+static SocketAddress *socket_start_incoming_migration(SocketAddress *saddr,
+                                                      Error **errp)
 {
     QIOChannelSocket *listen_ioc = qio_channel_socket_new();
+    SocketAddress *address;
 
     qio_channel_set_name(QIO_CHANNEL(listen_ioc),
                          "migration-socket-listener");
 
     if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0) {
         object_unref(OBJECT(listen_ioc));
-        return;
+        return NULL;
+    }
+
+    address = qio_channel_socket_get_local_address(listen_ioc, errp);
+    if (address < 0) {
+        object_unref(OBJECT(listen_ioc));
+        return NULL;
     }
 
     qio_channel_add_watch(QIO_CHANNEL(listen_ioc),
@@ -180,14 +188,28 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
                           socket_accept_incoming_migration,
                           listen_ioc,
                           (GDestroyNotify)object_unref);
+    return address;
 }
 
 void tcp_start_incoming_migration(const char *host_port, Error **errp)
 {
     Error *err = NULL;
     SocketAddress *saddr = tcp_build_address(host_port, &err);
+
     if (!err) {
-        socket_start_incoming_migration(saddr, &err);
+        SocketAddress *address = socket_start_incoming_migration(saddr, &err);
+
+        if (address) {
+            unsigned long long port;
+
+            if (parse_uint_full(address->u.inet.port, &port, 10) < 0) {
+                error_setg(errp, "error parsing port in '%s'",
+                           address->u.inet.port);
+            } else {
+                migrate_set_port(port, errp);
+            }
+            qapi_free_SocketAddress(address);
+        }
     }
     qapi_free_SocketAddress(saddr);
     error_propagate(errp, err);
@@ -196,6 +218,9 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp)
 void unix_start_incoming_migration(const char *path, Error **errp)
 {
     SocketAddress *saddr = unix_build_address(path);
-    socket_start_incoming_migration(saddr, errp);
+    SocketAddress *address;
+
+    address = socket_start_incoming_migration(saddr, errp);
+    qapi_free_SocketAddress(address);
     qapi_free_SocketAddress(saddr);
 }
-- 
2.14.3
