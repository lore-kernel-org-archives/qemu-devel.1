Received: from eggs.gnu.org ([2001:4830:134:3::10]:48106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWbnh-0003I0-Lb
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:41:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWbng-0001AW-Lq
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:41:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWbng-00019z-Ci
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:41:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82DAF80472
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 05:41:15 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 13:40:42 +0800
Message-Id: <20180103054043.25719-11-peterx@redhat.com>
In-Reply-To: <20180103054043.25719-1-peterx@redhat.com>
References: <20180103054043.25719-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 10/11] migration: major cleanup for migrate
 iterations
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

The major work for migration iterations are to move RAM/block/... data
via qemu_savevm_state_iterate().  Generalize those part into a single
function.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 90 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 35 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2629f907e9..c6c39738d2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2056,11 +2056,11 @@ static int migration_maybe_pause(MigrationState *s,
  *   The caller 'breaks' the loop when this returns.
  *
  * @s: Current migration state
- * @current_active_state: The migration state we expect to be in
  */
-static void migration_completion(MigrationState *s, int current_active_state)
+static void migration_completion(MigrationState *s)
 {
     int ret;
+    int current_active_state = s->state;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         qemu_mutex_lock_iothread();
@@ -2199,6 +2199,51 @@ static void migration_update_statistics(MigrationState *s,
                               bandwidth, threshold_size);
 }
 
+/* Migration thread iteration status */
+typedef enum {
+    MIG_ITERATE_RESUME,         /* Resume current iteration */
+    MIG_ITERATE_SKIP,           /* Skip current iteration */
+    MIG_ITERATE_BREAK,          /* Break the loop */
+} MigIterateState;
+
+/*
+ * Return true if continue to the next iteration directly, false
+ * otherwise.
+ */
+static MigIterateState migration_iteration_run(MigrationState *s)
+{
+    uint64_t pending_size, pend_post, pend_nonpost;
+    bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
+
+    qemu_savevm_state_pending(s->to_dst_file, s->threshold_size,
+                              &pend_nonpost, &pend_post);
+    pending_size = pend_nonpost + pend_post;
+
+    trace_migrate_pending(pending_size, s->threshold_size,
+                          pend_post, pend_nonpost);
+
+    if (pending_size && pending_size >= s->threshold_size) {
+        /* Still a significant amount to transfer */
+        if (migrate_postcopy() && !in_postcopy &&
+            pend_nonpost <= s->threshold_size &&
+            atomic_read(&s->start_postcopy)) {
+            if (postcopy_start(s)) {
+                error_report("%s: postcopy failed to start", __func__);
+            }
+            return MIG_ITERATE_SKIP;
+        }
+        /* Just another iteration step */
+        qemu_savevm_state_iterate(s->to_dst_file,
+            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    } else {
+        trace_migration_thread_low_pending(pending_size);
+        migration_completion(s);
+        return MIG_ITERATE_BREAK;
+    }
+
+    return MIG_ITERATE_RESUME;
+}
+
 /*
  * Master migration thread on the source VM.
  * It drives the migration and pumps the data down the outgoing channel.
@@ -2207,9 +2252,6 @@ static void *migration_thread(void *opaque)
 {
     MigrationState *s = opaque;
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
-    bool entered_postcopy = false;
-    /* The active state we expect to be in; ACTIVE or POSTCOPY_ACTIVE */
-    enum MigrationStatus current_active_state = MIGRATION_STATUS_ACTIVE;
 
     rcu_register_thread();
 
@@ -2249,43 +2291,21 @@ static void *migration_thread(void *opaque)
     while (s->state == MIGRATION_STATUS_ACTIVE ||
            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
         int64_t current_time;
-        uint64_t pending_size;
 
         if (!qemu_file_rate_limit(s->to_dst_file)) {
-            uint64_t pend_post, pend_nonpost;
-
-            qemu_savevm_state_pending(s->to_dst_file, s->threshold_size,
-                                      &pend_nonpost, &pend_post);
-            pending_size = pend_nonpost + pend_post;
-            trace_migrate_pending(pending_size, s->threshold_size,
-                                  pend_post, pend_nonpost);
-            if (pending_size && pending_size >= s->threshold_size) {
-                /* Still a significant amount to transfer */
-
-                if (migrate_postcopy() &&
-                    s->state != MIGRATION_STATUS_POSTCOPY_ACTIVE &&
-                    pend_nonpost <= s->threshold_size &&
-                    atomic_read(&s->start_postcopy)) {
-
-                    if (!postcopy_start(s)) {
-                        current_active_state = MIGRATION_STATUS_POSTCOPY_ACTIVE;
-                        entered_postcopy = true;
-                    }
-
-                    continue;
-                }
-                /* Just another iteration step */
-                qemu_savevm_state_iterate(s->to_dst_file, entered_postcopy);
-            } else {
-                trace_migration_thread_low_pending(pending_size);
-                migration_completion(s, current_active_state);
+            MigIterateState iter_state = migration_iteration_run(s);
+            if (iter_state == MIG_ITERATE_SKIP) {
+                continue;
+            } else if (iter_state == MIG_ITERATE_BREAK) {
                 break;
             }
         }
 
         if (qemu_file_get_error(s->to_dst_file)) {
-            migrate_set_state(&s->state, current_active_state,
-                              MIGRATION_STATUS_FAILED);
+            if (migration_is_setup_or_active(s->state)) {
+                migrate_set_state(&s->state, s->state,
+                                  MIGRATION_STATUS_FAILED);
+            }
             trace_migration_thread_file_err();
             break;
         }
-- 
2.14.3
