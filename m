Received: from eggs.gnu.org ([2001:4830:134:3::10]:41872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds5Ov-00066n-6d
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds5Ou-0006Pe-7Q
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ds5Ou-0006O9-00
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04EDA81E14
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:00:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 13 Sep 2017 12:59:38 +0200
Message-Id: <20170913105953.13760-6-quintela@redhat.com>
In-Reply-To: <20170913105953.13760-1-quintela@redhat.com>
References: <20170913105953.13760-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v8 05/20] migration: Improve migration thread
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
---
 migration/migration.c | 19 ++++++++++++++++---
 migration/migration.h |  7 ++++++-
 migration/ram.c       |  2 +-
 migration/tls.c       |  1 -
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index bac4a99277..adc07e442a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1013,19 +1013,30 @@ static void migrate_fd_cleanup(void *opaque)
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
@@ -2244,6 +2255,7 @@ static void migration_instance_finalize(Object *obj)
     MigrationState *ms = MIGRATION_OBJ(obj);
     MigrationParameters *params = &ms->parameters;
 
+    qemu_mutex_destroy(&ms->error_mutex);
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
 }
@@ -2256,6 +2268,7 @@ static void migration_instance_init(Object *obj)
     ms->state = MIGRATION_STATUS_NONE;
     ms->xbzrle_cache_size = DEFAULT_MIGRATE_CACHE_SIZE;
     ms->mbps = -1;
+    qemu_mutex_init(&ms->error_mutex);
 
     params->tls_hostname = g_strdup("");
     params->tls_creds = g_strdup("");
diff --git a/migration/migration.h b/migration/migration.h
index 1881e4a754..9a81b8a70a 100644
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
diff --git a/migration/ram.c b/migration/ram.c
index e18b3e2d4f..e0179fc838 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1789,7 +1789,7 @@ int ram_discard_range(const char *rbname, uint64_t start, size_t length)
     RAMBlock *rb = qemu_ram_block_by_name(rbname);
 
     if (!rb) {
-        error_report("ram_discard_range: Failed to find block '%s'", rbname);
+        error_report("ram_discard_rang0e: Failed to find block '%s'", rbname);
         goto err;
     }
 
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
