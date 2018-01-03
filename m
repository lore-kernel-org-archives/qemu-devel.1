Received: from eggs.gnu.org ([2001:4830:134:3::10]:47929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWbnV-00035s-1q
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWbnU-00010h-2m
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:41:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWbnT-0000yv-Ql
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:41:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0002E81DE9
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 05:41:02 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 13:40:38 +0800
Message-Id: <20180103054043.25719-7-peterx@redhat.com>
In-Reply-To: <20180103054043.25719-1-peterx@redhat.com>
References: <20180103054043.25719-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 06/11] migration: introduce vm_down_start_time
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

Introduce MigrationState.vm_down_start_time to replace the local
variable "start_time" in migration_thread to avoid passing things around.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 12 ++++--------
 migration/migration.h |  2 ++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 62b3766852..2d8b47197e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2055,16 +2055,14 @@ static int migration_maybe_pause(MigrationState *s,
  *
  * @s: Current migration state
  * @current_active_state: The migration state we expect to be in
- * @*start_time: Pointer to time to update
  */
-static void migration_completion(MigrationState *s, int current_active_state,
-                                 int64_t *start_time)
+static void migration_completion(MigrationState *s, int current_active_state)
 {
     int ret;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         qemu_mutex_lock_iothread();
-        *start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+        s->vm_down_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
         s->old_vm_running = runstate_is_running();
         ret = global_state_store();
@@ -2170,7 +2168,6 @@ static void *migration_thread(void *opaque)
      * measured bandwidth
      */
     int64_t threshold_size = 0;
-    int64_t start_time = initial_time;
     int64_t end_time;
     bool entered_postcopy = false;
     /* The active state we expect to be in; ACTIVE or POSTCOPY_ACTIVE */
@@ -2241,8 +2238,7 @@ static void *migration_thread(void *opaque)
                 qemu_savevm_state_iterate(s->to_dst_file, entered_postcopy);
             } else {
                 trace_migration_thread_low_pending(pending_size);
-                migration_completion(s, current_active_state,
-                                     &start_time);
+                migration_completion(s, current_active_state);
                 break;
             }
         }
@@ -2293,7 +2289,7 @@ static void *migration_thread(void *opaque)
         uint64_t transferred_bytes = qemu_ftell(s->to_dst_file);
         s->mig_total_time = end_time - s->mig_start_time;
         if (!entered_postcopy) {
-            s->downtime = end_time - start_time;
+            s->downtime = end_time - s->vm_down_start_time;
         }
         if (s->mig_total_time) {
             s->mbps = (((double) transferred_bytes * 8.0) /
diff --git a/migration/migration.h b/migration/migration.h
index 0f5df2367c..3ab5506233 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -107,6 +107,8 @@ struct MigrationState
     int64_t mig_start_time;
     /* Total time used by latest migration (ms) */
     int64_t mig_total_time;
+    /* Timestamp when VM is down (ms) to migrate the last stuff */
+    int64_t vm_down_start_time;
     int64_t downtime;
     int64_t expected_downtime;
     bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
-- 
2.14.3
