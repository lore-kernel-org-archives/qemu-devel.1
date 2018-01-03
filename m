Received: from eggs.gnu.org ([2001:4830:134:3::10]:56673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi28-0006gd-Jj
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi27-00024z-AH
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWi27-00023v-0t
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37CA681DFF
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:20:34 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 20:20:09 +0800
Message-Id: <20180103122017.14794-6-peterx@redhat.com>
In-Reply-To: <20180103122017.14794-1-peterx@redhat.com>
References: <20180103122017.14794-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/13] migration: move vm_old_running into
 global state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Firstly, it was passed around.  Let's just move it into MigrationState
just like many other variables as state of migration, renaming it to
vm_was_running.

One thing to mention is that for postcopy, we actually don't need this
knowledge at all since postcopy can't resume a VM even if it fails (we
can see that from the old code too: when we try to resume we also check
against "entered_postcopy" variable).  So further we do this:

- in postcopy_start(), we don't update vm_old_running since useless
- in migration_thread(), we don't need to check entered_postcopy when
  resume, since it's only used for precopy.

Comment this out too for that variable definition.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 17 +++++++----------
 migration/migration.h |  6 ++++++
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 343368c089..ca0c600178 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1272,6 +1272,7 @@ MigrationState *migrate_init(void)
 
     s->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     s->total_time = 0;
+    s->vm_was_running = false;
     return s;
 }
 
@@ -1846,7 +1847,7 @@ static int await_return_path_close_on_source(MigrationState *ms)
  * Switch from normal iteration to postcopy
  * Returns non-0 on error
  */
-static int postcopy_start(MigrationState *ms, bool *old_vm_running)
+static int postcopy_start(MigrationState *ms)
 {
     int ret;
     QIOChannelBuffer *bioc;
@@ -1864,7 +1865,6 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
     trace_postcopy_start_set_run();
 
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
-    *old_vm_running = runstate_is_running();
     global_state_store();
     ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
@@ -2055,11 +2055,9 @@ static int migration_maybe_pause(MigrationState *s,
  *
  * @s: Current migration state
  * @current_active_state: The migration state we expect to be in
- * @*old_vm_running: Pointer to old_vm_running flag
  * @*start_time: Pointer to time to update
  */
 static void migration_completion(MigrationState *s, int current_active_state,
-                                 bool *old_vm_running,
                                  int64_t *start_time)
 {
     int ret;
@@ -2068,7 +2066,7 @@ static void migration_completion(MigrationState *s, int current_active_state,
         qemu_mutex_lock_iothread();
         *start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
-        *old_vm_running = runstate_is_running();
+        s->vm_was_running = runstate_is_running();
         ret = global_state_store();
 
         if (!ret) {
@@ -2174,7 +2172,6 @@ static void *migration_thread(void *opaque)
     int64_t threshold_size = 0;
     int64_t start_time = initial_time;
     int64_t end_time;
-    bool old_vm_running = false;
     bool entered_postcopy = false;
     /* The active state we expect to be in; ACTIVE or POSTCOPY_ACTIVE */
     enum MigrationStatus current_active_state = MIGRATION_STATUS_ACTIVE;
@@ -2233,7 +2230,7 @@ static void *migration_thread(void *opaque)
                     pend_nonpost <= threshold_size &&
                     atomic_read(&s->start_postcopy)) {
 
-                    if (!postcopy_start(s, &old_vm_running)) {
+                    if (!postcopy_start(s)) {
                         current_active_state = MIGRATION_STATUS_POSTCOPY_ACTIVE;
                         entered_postcopy = true;
                     }
@@ -2245,7 +2242,7 @@ static void *migration_thread(void *opaque)
             } else {
                 trace_migration_thread_low_pending(pending_size);
                 migration_completion(s, current_active_state,
-                                     &old_vm_running, &start_time);
+                                     &start_time);
                 break;
             }
         }
@@ -2318,9 +2315,9 @@ static void *migration_thread(void *opaque)
             * Fixme: we will run VM in COLO no matter its old running state.
             * After exited COLO, we will keep running.
             */
-            old_vm_running = true;
+            s->vm_was_running = true;
         }
-        if (old_vm_running && !entered_postcopy) {
+        if (s->vm_was_running) {
             vm_start();
         } else {
             if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
diff --git a/migration/migration.h b/migration/migration.h
index 233ad68705..45053ae8c5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -111,6 +111,12 @@ struct MigrationState
     int64_t expected_downtime;
     bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t setup_time;
+    /*
+     * Whether guest was running when we enter the completion stage.
+     * If migration is interrupted by any reason, we need to continue
+     * running the guest on source.
+     */
+    bool vm_was_running;
 
     /* Flag set once the migration has been asked to enter postcopy */
     bool start_postcopy;
-- 
2.14.3
