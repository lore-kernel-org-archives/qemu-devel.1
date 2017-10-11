Received: from eggs.gnu.org ([2001:4830:134:3::10]:56018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e2MS1-0005Hu-Mu
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e2MS0-0004s2-J9
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:13:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e2MS0-0004rg-9n
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:13:52 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 11 Oct 2017 20:13:13 +0100
Message-Id: <20171011191317.24157-4-dgilbert@redhat.com>
In-Reply-To: <20171011191317.24157-1-dgilbert@redhat.com>
References: <20171011191317.24157-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] migration: Wait for semaphore before
 completing migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com, wangjie88@huawei.com, quintela@redhat.com, peterx@redhat.com, mreitz@redhat.com
Cc: berrange@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Wait for a semaphore before completing the migration,
if the previously added capability was enabled.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 migration/migration.h |  3 +++
 2 files changed, 50 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index e1a87c3d23..b411a7bb63 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1967,6 +1967,46 @@ fail:
 }
 
 /**
+ * migration_maybe_pause: Pause if required to by migrate_pause_before_device
+ * called with the iothread locked
+ * Returns: 0 on success
+ */
+static int migration_maybe_pause(MigrationState *s, int *current_active_state)
+{
+    int ret;
+    if (!migrate_pause_before_device()) {
+        return 0;
+    }
+    ret = bdrv_inactivate_all();
+    if (ret) {
+        error_report("%s: bdrv_inactivate_all() failed (%d)",
+                     __func__, ret);
+        return ret;
+    }
+
+    s->block_inactive = true;
+
+    /* Since leaving this state is not atomic with posting the semaphore
+     * it's possible that someone could have issued multiple migrate_continue
+     * and the semaphore is incorrectly positive at this point;
+     * the docs say it's undefined to reinit a semaphore that's already
+     * init'd, so use timedwait to eat up any existing posts.
+     */
+    while (qemu_sem_timedwait(&s->pause_sem, 1) == 0);
+
+    qemu_mutex_unlock_iothread();
+    migrate_set_state(&s->state, *current_active_state,
+                      MIGRATION_STATUS_PAUSE_BEFORE_DEVICE);
+    qemu_sem_wait(&s->pause_sem);
+    migrate_set_state(&s->state, MIGRATION_STATUS_PAUSE_BEFORE_DEVICE,
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
@@ -1992,6 +2032,11 @@ static void migration_completion(MigrationState *s, int current_active_state,
             bool inactivate = !migrate_colo_enabled();
             ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
             if (ret >= 0) {
+                ret = migration_maybe_pause(s, &current_active_state);
+                /* If this worked it will already have inactivated */
+                inactivate &= !migrate_pause_before_device();
+            }
+            if (ret >= 0) {
                 qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
                 ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
                                                          inactivate);
@@ -2372,6 +2417,7 @@ static void migration_instance_finalize(Object *obj)
 
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
+    qemu_sem_destroy(&ms->pause_sem);
 }
 
 static void migration_instance_init(Object *obj)
@@ -2382,6 +2428,7 @@ static void migration_instance_init(Object *obj)
     ms->state = MIGRATION_STATUS_NONE;
     ms->xbzrle_cache_size = DEFAULT_MIGRATE_CACHE_SIZE;
     ms->mbps = -1;
+    qemu_sem_init(&ms->pause_sem, 0);
 
     params->tls_hostname = g_strdup("");
     params->tls_creds = g_strdup("");
diff --git a/migration/migration.h b/migration/migration.h
index 37feea5453..447e8b3f79 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -121,6 +121,9 @@ struct MigrationState
     /* Flag set once the migration thread called bdrv_inactivate_all */
     bool block_inactive;
 
+    /* Migration is paused due to pause-before-device */
+    QemuSemaphore pause_sem;
+
     /* The semaphore is used to notify COLO thread that failover is finished */
     QemuSemaphore colo_exit_sem;
 
-- 
2.13.6
