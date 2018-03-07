Received: from eggs.gnu.org ([2001:4830:134:3::10]:59607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoE-0004sj-Eq
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWo9-00068X-Fr
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1etWo9-000653-9S
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52A1A4173D27
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:00:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Mar 2018 11:59:50 +0100
Message-Id: <20180307110010.2205-5-quintela@redhat.com>
In-Reply-To: <20180307110010.2205-1-quintela@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 04/24] migration: Set the migration tcp port
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
index 31b16a335b..c398665de7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -268,6 +268,16 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
     return migrate_send_rp_message(mis, msg_type, msglen, bufc);
 }
 
+void migrate_set_port(const uint16_t port, Error **errp)
+{
+    MigrateSetParameters p = {
+        .has_x_tcp_port = true,
+        .x_tcp_port = port,
+    };
+
+    qmp_migrate_set_parameters(&p, errp);
+}
+
 void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p;
diff --git a/migration/migration.h b/migration/migration.h
index 08c5d2ded1..f40014cf94 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -234,4 +234,6 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
 int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
                               ram_addr_t start, size_t len);
 
+void migrate_set_port(const uint16_t port, Error **errp);
+
 #endif
diff --git a/migration/socket.c b/migration/socket.c
index e090097077..08606c665d 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 
 #include "qemu-common.h"
 #include "qemu/error-report.h"
@@ -160,17 +161,24 @@ out:
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
@@ -178,14 +186,28 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
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
@@ -194,6 +216,9 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp)
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
