Received: from eggs.gnu.org ([2001:4830:134:3::10]:41305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8G1-0005YX-8S
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8Fw-0001FL-9P
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eg8Fw-0001Ek-17
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54F4372669
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 12:09:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 29 Jan 2018 13:09:21 +0100
Message-Id: <20180129120932.12874-3-quintela@redhat.com>
In-Reply-To: <20180129120932.12874-1-quintela@redhat.com>
References: <20180129120932.12874-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 02/13] migration: Route errors down through
 migration_channel_connect
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Route async errors (especially from sockets) down through
migration_channel_connect and on to migrate_fd_connect where they
can be cleaned up.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/channel.c    | 34 +++++++++++++++++-----------------
 migration/channel.h    |  3 ++-
 migration/exec.c       |  2 +-
 migration/fd.c         |  2 +-
 migration/socket.c     |  4 +---
 migration/tls.c        |  3 +--
 migration/trace-events |  2 +-
 7 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index fdb7ddbd17..c5eaf0fa0e 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -55,29 +55,29 @@ void migration_channel_process_incoming(QIOChannel *ioc)
  * @s: Current migration state
  * @ioc: Channel to which we are connecting
  * @hostname: Where we want to connect
+ * @error: Error indicating failure to connect, free'd here
  */
 void migration_channel_connect(MigrationState *s,
                                QIOChannel *ioc,
-                               const char *hostname)
+                               const char *hostname,
+                               Error *error)
 {
     trace_migration_set_outgoing_channel(
-        ioc, object_get_typename(OBJECT(ioc)), hostname);
+        ioc, object_get_typename(OBJECT(ioc)), hostname, error);
+
+    if (!error) {
+        if (s->parameters.tls_creds &&
+            *s->parameters.tls_creds &&
+            !object_dynamic_cast(OBJECT(ioc),
+                                 TYPE_QIO_CHANNEL_TLS)) {
+            migration_tls_channel_connect(s, ioc, hostname, &error);
+        } else {
+            QEMUFile *f = qemu_fopen_channel_output(ioc);
+
+            s->to_dst_file = f;
 
-    if (s->parameters.tls_creds &&
-        *s->parameters.tls_creds &&
-        !object_dynamic_cast(OBJECT(ioc),
-                             TYPE_QIO_CHANNEL_TLS)) {
-        Error *local_err = NULL;
-        migration_tls_channel_connect(s, ioc, hostname, &local_err);
-        if (local_err) {
-            migrate_fd_error(s, local_err);
-            error_free(local_err);
         }
-    } else {
-        QEMUFile *f = qemu_fopen_channel_output(ioc);
-
-        s->to_dst_file = f;
-
-        migrate_fd_connect(s, NULL);
     }
+    migrate_fd_connect(s, error);
+    error_free(error);
 }
diff --git a/migration/channel.h b/migration/channel.h
index e4b40579a1..67a461c28a 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -22,5 +22,6 @@ void migration_channel_process_incoming(QIOChannel *ioc);
 
 void migration_channel_connect(MigrationState *s,
                                QIOChannel *ioc,
-                               const char *hostname);
+                               const char *hostname,
+                               Error *error_in);
 #endif
diff --git a/migration/exec.c b/migration/exec.c
index f3be1baf2e..c9537974ad 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -39,7 +39,7 @@ void exec_start_outgoing_migration(MigrationState *s, const char *command, Error
     }
 
     qio_channel_set_name(ioc, "migration-exec-outgoing");
-    migration_channel_connect(s, ioc, NULL);
+    migration_channel_connect(s, ioc, NULL, NULL);
     object_unref(OBJECT(ioc));
 }
 
diff --git a/migration/fd.c b/migration/fd.c
index 30de4b9847..6284a97cba 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -39,7 +39,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
     }
 
     qio_channel_set_name(QIO_CHANNEL(ioc), "migration-fd-outgoing");
-    migration_channel_connect(s, ioc, NULL);
+    migration_channel_connect(s, ioc, NULL, NULL);
     object_unref(OBJECT(ioc));
 }
 
diff --git a/migration/socket.c b/migration/socket.c
index 3a8232dd2d..e090097077 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -79,12 +79,10 @@ static void socket_outgoing_migration(QIOTask *task,
 
     if (qio_task_propagate_error(task, &err)) {
         trace_migration_socket_outgoing_error(error_get_pretty(err));
-        migrate_fd_error(data->s, err);
-        error_free(err);
     } else {
         trace_migration_socket_outgoing_connected(data->hostname);
-        migration_channel_connect(data->s, sioc, data->hostname);
     }
+    migration_channel_connect(data->s, sioc, data->hostname, err);
     object_unref(OBJECT(sioc));
 }
 
diff --git a/migration/tls.c b/migration/tls.c
index 026a008667..a29b35b33c 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -118,11 +118,10 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
 
     if (qio_task_propagate_error(task, &err)) {
         trace_migration_tls_outgoing_handshake_error(error_get_pretty(err));
-        migrate_fd_error(s, err);
     } else {
         trace_migration_tls_outgoing_handshake_complete();
-        migration_channel_connect(s, ioc, NULL);
     }
+    migration_channel_connect(s, ioc, NULL, err);
     object_unref(OBJECT(ioc));
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index 6f29fcc686..93961dea16 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -114,7 +114,7 @@ migrate_transferred(uint64_t tranferred, uint64_t time_spent, double bandwidth,
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
-migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
+migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname, void *err)  "ioc=%p ioctype=%s hostname=%s err=%p"
 
 # migration/rdma.c
 qemu_rdma_accept_incoming_migration(void) ""
-- 
2.14.3
