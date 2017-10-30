Received: from eggs.gnu.org ([2001:4830:134:3::10]:52915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e988L-0005WE-IH
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e988H-0007om-5D
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e988G-0007oN-TK
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A9CC356D8
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 11:21:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 30 Oct 2017 12:21:11 +0100
Message-Id: <20171030112112.6952-6-quintela@redhat.com>
In-Reply-To: <20171030112112.6952-1-quintela@redhat.com>
References: <20171030112112.6952-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] migration: Now set the migration uri
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 25 ++++++++++++++++++-------
 migration/migration.h |  2 ++
 migration/socket.c    |  7 +++++++
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3e48d37880..507226907b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -240,10 +240,21 @@ void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
     }
 }
 
+void migrate_set_uri(const char *uri, Error **errp)
+{
+    MigrateSetParameters p = {
+        .has_uri = true,
+        .uri = (char *)uri,
+    };
+
+    qmp_migrate_set_parameters(&p, errp);
+}
+
 void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p;
 
+    migrate_set_uri(uri, errp);
     qapi_event_send_migration(MIGRATION_STATUS_SETUP, &error_abort);
     if (!strcmp(uri, "defer")) {
         deferred_incoming_migration(errp);
@@ -1363,7 +1374,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         error_setg(errp, "Guest is waiting for an incoming migration");
         return;
     }
-
+    migrate_set_uri(uri, errp);
     if (migration_is_blocked(errp)) {
         return;
     }
@@ -1388,20 +1399,20 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
 
     s = migrate_init();
 
-    if (strstart(uri, "tcp:", &p)) {
+    if (strstart(s->parameters.uri, "tcp:", &p)) {
         tcp_start_outgoing_migration(s, p, &local_err);
 #ifdef CONFIG_RDMA
-    } else if (strstart(uri, "rdma:", &p)) {
+    } else if (strstart(s->parameters.uri, "rdma:", &p)) {
         rdma_start_outgoing_migration(s, p, &local_err);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
+    } else if (strstart(s->parameters.uri, "exec:", &p)) {
         exec_start_outgoing_migration(s, p, &local_err);
-    } else if (strstart(uri, "unix:", &p)) {
+    } else if (strstart(s->parameters.uri, "unix:", &p)) {
         unix_start_outgoing_migration(s, p, &local_err);
-    } else if (strstart(uri, "fd:", &p)) {
+    } else if (strstart(s->parameters.uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
     } else {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "s->parameters.uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
diff --git a/migration/migration.h b/migration/migration.h
index 663415fe48..cb0ab4807a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -210,4 +210,6 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
 void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
                               ram_addr_t start, size_t len);
 
+void migrate_set_uri(const char *uri, Error **errp);
+
 #endif
diff --git a/migration/socket.c b/migration/socket.c
index 3a8232dd2d..c3ab81d1fb 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -187,7 +187,14 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp)
     Error *err = NULL;
     SocketAddress *saddr = tcp_build_address(host_port, &err);
     if (!err) {
+        char *new_uri;
         socket_start_incoming_migration(saddr, &err);
+        if (!err) {
+            new_uri = g_strdup_printf("tcp:%s:%s", saddr->u.inet.host,
+                                      saddr->u.inet.port);
+            migrate_set_uri(new_uri, &err);
+            g_free(new_uri);
+        }
     }
     qapi_free_SocketAddress(saddr);
     error_propagate(errp, err);
-- 
2.13.6
