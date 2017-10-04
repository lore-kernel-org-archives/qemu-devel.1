Received: from eggs.gnu.org ([2001:4830:134:3::10]:55011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCR-0004pz-Q2
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCQ-0002oF-NQ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dzhCQ-0002ng-El
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 748C45D5EB
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 10:46:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  4 Oct 2017 12:46:26 +0200
Message-Id: <20171004104636.7963-3-quintela@redhat.com>
In-Reply-To: <20171004104636.7963-1-quintela@redhat.com>
References: <20171004104636.7963-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v9 02/12] migration: Improve migration thread
 error handling
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

We now report errors also when we finish migration, not only on info
migrate.  We plan to use this error from several places, and we want
the first error to happen to win, so we add an mutex to order it.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 19 ++++++++++++++++---
 migration/migration.h |  7 ++++++-
 migration/tls.c       |  1 -
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 98429dc843..468f51cfa7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1071,19 +1071,30 @@ static void migrate_fd_cleanup(void *opaque)
                           MIGRATION_STATUS_CANCELLED);
     }
 
+    if (s->error) {
+        /* It is used on info migrate.  We can't free it */
+        error_report_err(error_copy(s->error));
+    }
     notifier_list_notify(&migration_state_notifiers, s);
     block_cleanup_parameters(s);
 }
 
+void migrate_set_error(MigrationState *s, const Error *error)
+{
+    qemu_mutex_lock(&s->error_mutex);
+    if (!s->error) {
+        s->error = error_copy(error);
+    }
+    qemu_mutex_unlock(&s->error_mutex);
+}
+
 void migrate_fd_error(MigrationState *s, const Error *error)
 {
     trace_migrate_fd_error(error_get_pretty(error));
     assert(s->to_dst_file == NULL);
     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_FAILED);
-    if (!s->error) {
-        s->error = error_copy(error);
-    }
+    migrate_set_error(s, error);
     notifier_list_notify(&migration_state_notifiers, s);
     block_cleanup_parameters(s);
 }
@@ -2355,6 +2366,7 @@ static void migration_instance_finalize(Object *obj)
     MigrationState *ms = MIGRATION_OBJ(obj);
     MigrationParameters *params = &ms->parameters;
 
+    qemu_mutex_destroy(&ms->error_mutex);
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
 }
@@ -2367,6 +2379,7 @@ static void migration_instance_init(Object *obj)
     ms->state = MIGRATION_STATUS_NONE;
     ms->xbzrle_cache_size = DEFAULT_MIGRATE_CACHE_SIZE;
     ms->mbps = -1;
+    qemu_mutex_init(&ms->error_mutex);
 
     params->tls_hostname = g_strdup("");
     params->tls_creds = g_strdup("");
diff --git a/migration/migration.h b/migration/migration.h
index b83cceadc4..51c0ac2e71 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -129,8 +129,12 @@ struct MigrationState
     int64_t colo_checkpoint_time;
     QEMUTimer *colo_delay_timer;
 
-    /* The last error that occurred */
+    /* The first error that has occurred.
+       We used the mutex to be able to return the 1st error message */
     Error *error;
+    /* mutex to protect errp */
+    QemuMutex error_mutex;
+
     /* Do we have to clean up -b/-i from old migrate parameters */
     /* This feature is deprecated and will be removed */
     bool must_remove_block_options;
@@ -159,6 +163,7 @@ bool  migration_has_all_channels(void);
 
 uint64_t migrate_max_downtime(void);
 
+void migrate_set_error(MigrationState *s, const Error *error);
 void migrate_fd_error(MigrationState *s, const Error *error);
 
 void migrate_fd_connect(MigrationState *s);
diff --git a/migration/tls.c b/migration/tls.c
index 596e8790bd..026a008667 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -119,7 +119,6 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
     if (qio_task_propagate_error(task, &err)) {
         trace_migration_tls_outgoing_handshake_error(error_get_pretty(err));
         migrate_fd_error(s, err);
-        error_free(err);
     } else {
         trace_migration_tls_outgoing_handshake_complete();
         migration_channel_connect(s, ioc, NULL);
-- 
2.13.5
