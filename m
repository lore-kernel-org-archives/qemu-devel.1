Received: from eggs.gnu.org ([2001:4830:134:3::10]:50463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QT-0007aC-Ha
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QQ-0004LM-HL
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45792 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ew9QQ-0004KX-D3
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 020134068036
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 16:38:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 14 Mar 2018 17:38:34 +0100
Message-Id: <20180314163838.7158-5-quintela@redhat.com>
In-Reply-To: <20180314163838.7158-1-quintela@redhat.com>
References: <20180314163838.7158-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v6 4/8] migration: Create x-socket-address
 parameter
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

It will be used to store the uri parameter. We want this only for tcp,
so we don't set it for other uris.  We need it to know what port is
migration running.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

This used to be uri parameter, but it has so many troubles to
reproduce that it don't just make sense.

This used to be a port parameter.  I was asked to move to
SocketAddress, done.
I also merged the setting of the migration tcp port in this one
because now I need to free the address, and this makes it easier.
---
 hmp.c                 |  6 ++++++
 migration/migration.c | 18 ++++++++++++++++++
 migration/migration.h |  2 ++
 migration/socket.c    | 27 ++++++++++++++++++++++-----
 qapi/migration.json   | 14 ++++++++++++--
 5 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/hmp.c b/hmp.c
index ba9e299ee2..eee84cfd5f 100644
--- a/hmp.c
+++ b/hmp.c
@@ -355,6 +355,12 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
+        if (params->has_x_socket_address) {
+            monitor_printf(mon, "%s: %s\n",
+                MigrationParameter_str(MIGRATION_PARAMETER_X_SOCKET_ADDRESS),
+                SocketAddress_to_str("", params->x_socket_address,
+                                     false, false));
+        }
     }
 
     qapi_free_MigrationParameters(params);
diff --git a/migration/migration.c b/migration/migration.c
index 6a4780ef6f..3b811c213a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -31,6 +31,8 @@
 #include "migration/vmstate.h"
 #include "block/block.h"
 #include "qapi/error.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-sockets.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
@@ -268,6 +270,14 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
     return migrate_send_rp_message(mis, msg_type, msglen, bufc);
 }
 
+void migrate_set_address(SocketAddress *address)
+{
+    MigrationState *s = migrate_get_current();
+
+    s->parameters.has_x_socket_address = true;
+    s->parameters.x_socket_address = address;
+}
+
 void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p;
@@ -545,6 +555,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->x_multifd_page_count = s->parameters.x_multifd_page_count;
     params->has_xbzrle_cache_size = true;
     params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
+    if (s->parameters.x_socket_address) {
+        params->has_x_socket_address = true;
+        params->x_socket_address = QAPI_CLONE(SocketAddress,
+                                              s->parameters.x_socket_address);
+    }
 
     return params;
 }
@@ -2542,6 +2557,9 @@ static void migration_instance_finalize(Object *obj)
     qemu_mutex_destroy(&ms->error_mutex);
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
+    if (params->x_socket_address) {
+        qapi_free_SocketAddress(params->x_socket_address);
+    }
     qemu_sem_destroy(&ms->pause_sem);
     error_free(ms->error);
 }
diff --git a/migration/migration.h b/migration/migration.h
index 08c5d2ded1..36b9c70fd6 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -234,4 +234,6 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
 int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
                               ram_addr_t start, size_t len);
 
+void migrate_set_address(SocketAddress *address);
+
 #endif
diff --git a/migration/socket.c b/migration/socket.c
index 8a93fb1af5..52db0c0c09 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 
 #include "qemu-common.h"
 #include "qemu/error-report.h"
@@ -161,17 +162,24 @@ out:
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
@@ -179,14 +187,20 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
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
+            migrate_set_address(address);
+        }
     }
     qapi_free_SocketAddress(saddr);
     error_propagate(errp, err);
@@ -195,6 +209,9 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp)
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
diff --git a/qapi/migration.json b/qapi/migration.json
index 7f465a1902..a881321de2 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -6,6 +6,7 @@
 ##
 
 { 'include': 'common.json' }
+{ 'include': 'sockets.json' }
 
 ##
 # @MigrationStats:
@@ -490,6 +491,9 @@
 #                     and a power of 2
 #                     (Since 2.11)
 #
+# @x-socket-address: Only used for tcp, to know what the real port is
+#                    (Since 2.12)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -498,7 +502,7 @@
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'x-multifd-channels', 'x-multifd-page-count',
-           'xbzrle-cache-size' ] }
+           'xbzrle-cache-size', 'x-socket-address' ] }
 
 ##
 # @MigrateSetParameters:
@@ -566,6 +570,7 @@
 #                     needs to be a multiple of the target page size
 #                     and a power of 2
 #                     (Since 2.11)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -667,6 +672,10 @@
 #                     needs to be a multiple of the target page size
 #                     and a power of 2
 #                     (Since 2.11)
+#
+# @x-socket-address: Only used for tcp, to know what the real port is
+#                    (Since 2.12)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -683,7 +692,8 @@
             '*block-incremental': 'bool' ,
             '*x-multifd-channels': 'uint8',
             '*x-multifd-page-count': 'uint32',
-            '*xbzrle-cache-size': 'size' } }
+            '*xbzrle-cache-size': 'size',
+            '*x-socket-address': 'SocketAddress'} }
 
 ##
 # @query-migrate-parameters:
-- 
2.14.3
