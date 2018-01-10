Received: from eggs.gnu.org ([2001:4830:134:3::10]:40145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFn5-00063o-Ll
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFn2-0004Io-DH
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eZFn2-0004FU-45
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 163AD7EA93
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 12:47:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 10 Jan 2018 13:47:10 +0100
Message-Id: <20180110124723.11879-2-quintela@redhat.com>
In-Reply-To: <20180110124723.11879-1-quintela@redhat.com>
References: <20180110124723.11879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 01/14] migration: Make migrate_fd_error()
 the owner of the Error
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

So far, we had to free the error after each caller, so just do it
here.  Once there, tls.c was leaking the error.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/channel.c   |  1 -
 migration/migration.c | 10 ++++------
 migration/migration.h |  4 ++--
 migration/socket.c    |  1 -
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 70ec7ea3b7..1dd2ae1530 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -71,7 +71,6 @@ void migration_channel_connect(MigrationState *s,
         migration_tls_channel_connect(s, ioc, hostname, &local_err);
         if (local_err) {
             migrate_fd_error(s, local_err);
-            error_free(local_err);
         }
     } else {
         QEMUFile *f = qemu_fopen_channel_output(ioc);
diff --git a/migration/migration.c b/migration/migration.c
index a5be4592a6..085e88c625 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1159,16 +1159,14 @@ static void migrate_fd_cleanup(void *opaque)
     block_cleanup_parameters(s);
 }
 
-void migrate_set_error(MigrationState *s, const Error *error)
+void migrate_set_error(MigrationState *s, Error *error)
 {
     qemu_mutex_lock(&s->error_mutex);
-    if (!s->error) {
-        s->error = error_copy(error);
-    }
+    error_propagate(&s->error, error);
     qemu_mutex_unlock(&s->error_mutex);
 }
 
-void migrate_fd_error(MigrationState *s, const Error *error)
+void migrate_fd_error(MigrationState *s, Error *error)
 {
     trace_migrate_fd_error(error_get_pretty(error));
     assert(s->to_dst_file == NULL);
@@ -1448,7 +1446,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     }
 
     if (local_err) {
-        migrate_fd_error(s, local_err);
+        migrate_fd_error(s, error_copy(local_err));
         error_propagate(errp, local_err);
         return;
     }
diff --git a/migration/migration.h b/migration/migration.h
index 2c8c53847a..29a7b79a39 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -177,8 +177,8 @@ bool  migration_has_all_channels(void);
 
 uint64_t migrate_max_downtime(void);
 
-void migrate_set_error(MigrationState *s, const Error *error);
-void migrate_fd_error(MigrationState *s, const Error *error);
+void migrate_set_error(MigrationState *s, Error *error);
+void migrate_fd_error(MigrationState *s, Error *error);
 
 void migrate_fd_connect(MigrationState *s);
 
diff --git a/migration/socket.c b/migration/socket.c
index 248a798543..6d49903978 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -81,7 +81,6 @@ static void socket_outgoing_migration(QIOTask *task,
     if (qio_task_propagate_error(task, &err)) {
         trace_migration_socket_outgoing_error(error_get_pretty(err));
         migrate_fd_error(data->s, err);
-        error_free(err);
     } else {
         trace_migration_socket_outgoing_connected(data->hostname);
         migration_channel_connect(data->s, sioc, data->hostname);
-- 
2.14.3
