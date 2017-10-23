Received: from eggs.gnu.org ([2001:4830:134:3::10]:35734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHD-0005ck-1M
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHA-0008To-SO
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6fHA-0008Sj-J8
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C58904E906
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 16:08:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Oct 2017 18:07:47 +0200
Message-Id: <20171023160800.20540-9-quintela@redhat.com>
In-Reply-To: <20171023160800.20540-1-quintela@redhat.com>
References: <20171023160800.20540-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 08/21] migration: Wait for semaphore before
 completing migration
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

Wait for a semaphore before completing the migration,
if the previously added capability was enabled.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 38 ++++++++++++++++++++++++++++++++++++++
 migration/migration.h |  3 +++
 2 files changed, 41 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index f15372e007..ef84d2c1fb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1958,6 +1958,39 @@ fail:
 }
 
 /**
+ * migration_maybe_pause: Pause if required to by
+ * migrate_pause_before_switchover called with the iothread locked
+ * Returns: 0 on success
+ */
+static int migration_maybe_pause(MigrationState *s, int *current_active_state)
+{
+    if (!migrate_pause_before_switchover()) {
+        return 0;
+    }
+
+    /* Since leaving this state is not atomic with posting the semaphore
+     * it's possible that someone could have issued multiple migrate_continue
+     * and the semaphore is incorrectly positive at this point;
+     * the docs say it's undefined to reinit a semaphore that's already
+     * init'd, so use timedwait to eat up any existing posts.
+     */
+    while (qemu_sem_timedwait(&s->pause_sem, 1) == 0) {
+        /* This block intentionally left blank */
+    }
+
+    qemu_mutex_unlock_iothread();
+    migrate_set_state(&s->state, *current_active_state,
+                      MIGRATION_STATUS_PRE_SWITCHOVER);
+    qemu_sem_wait(&s->pause_sem);
+    migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
+                      MIGRATION_STATUS_DEVICE);
+    *current_active_state = MIGRATION_STATUS_DEVICE;
+    qemu_mutex_lock_iothread();
+
+    return s->state == MIGRATION_STATUS_DEVICE ? 0 : -EINVAL;
+}
+
+/**
  * migration_completion: Used by migration_thread when there's not much left.
  *   The caller 'breaks' the loop when this returns.
  *
@@ -1983,6 +2016,9 @@ static void migration_completion(MigrationState *s, int current_active_state,
             bool inactivate = !migrate_colo_enabled();
             ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
             if (ret >= 0) {
+                ret = migration_maybe_pause(s, &current_active_state);
+            }
+            if (ret >= 0) {
                 qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
                 ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
                                                          inactivate);
@@ -2363,6 +2399,7 @@ static void migration_instance_finalize(Object *obj)
 
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
+    qemu_sem_destroy(&ms->pause_sem);
 }
 
 static void migration_instance_init(Object *obj)
@@ -2373,6 +2410,7 @@ static void migration_instance_init(Object *obj)
     ms->state = MIGRATION_STATUS_NONE;
     ms->xbzrle_cache_size = DEFAULT_MIGRATE_CACHE_SIZE;
     ms->mbps = -1;
+    qemu_sem_init(&ms->pause_sem, 0);
 
     params->tls_hostname = g_strdup("");
     params->tls_creds = g_strdup("");
diff --git a/migration/migration.h b/migration/migration.h
index 969866303e..cd988a99b9 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -121,6 +121,9 @@ struct MigrationState
     /* Flag set once the migration thread called bdrv_inactivate_all */
     bool block_inactive;
 
+    /* Migration is paused due to pause-before-switchover */
+    QemuSemaphore pause_sem;
+
     /* The semaphore is used to notify COLO thread that failover is finished */
     QemuSemaphore colo_exit_sem;
 
-- 
2.13.6
