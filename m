Received: from eggs.gnu.org ([2001:4830:134:3::10]:49938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3L8-0007mk-QL
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3L7-0003iH-Rw
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eb3L7-0003hl-Is
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9ECC04E4CA
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:54:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 15 Jan 2018 12:53:02 +0100
Message-Id: <20180115115309.23982-21-quintela@redhat.com>
In-Reply-To: <20180115115309.23982-1-quintela@redhat.com>
References: <20180115115309.23982-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 20/27] migration: introduce downtime_start
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

From: Peter Xu <peterx@redhat.com>

Introduce MigrationState.downtime_start to replace the local variable
"start_time" in migration_thread to avoid passing things around.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 12 ++++--------
 migration/migration.h |  2 ++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e26f80d9aa..fff2823ad5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2094,16 +2094,14 @@ static int migration_maybe_pause(MigrationState *s,
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
+        s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
         s->vm_was_running = runstate_is_running();
         ret = global_state_store();
@@ -2209,7 +2207,6 @@ static void *migration_thread(void *opaque)
      * measured bandwidth
      */
     int64_t threshold_size = 0;
-    int64_t start_time = initial_time;
     int64_t end_time;
     bool entered_postcopy = false;
     /* The active state we expect to be in; ACTIVE or POSTCOPY_ACTIVE */
@@ -2280,8 +2277,7 @@ static void *migration_thread(void *opaque)
                 qemu_savevm_state_iterate(s->to_dst_file, entered_postcopy);
             } else {
                 trace_migration_thread_low_pending(pending_size);
-                migration_completion(s, current_active_state,
-                                     &start_time);
+                migration_completion(s, current_active_state);
                 break;
             }
         }
@@ -2332,7 +2328,7 @@ static void *migration_thread(void *opaque)
         uint64_t transferred_bytes = qemu_ftell(s->to_dst_file);
         s->total_time = end_time - s->start_time;
         if (!entered_postcopy) {
-            s->downtime = end_time - start_time;
+            s->downtime = end_time - s->downtime_start;
         }
         if (s->total_time) {
             s->mbps = (((double) transferred_bytes * 8.0) /
diff --git a/migration/migration.h b/migration/migration.h
index 4cae263992..0aad12f9a1 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -119,6 +119,8 @@ struct MigrationState
     int64_t start_time;
     /* Total time used by latest migration (ms) */
     int64_t total_time;
+    /* Timestamp when VM is down (ms) to migrate the last stuff */
+    int64_t downtime_start;
     int64_t downtime;
     int64_t expected_downtime;
     bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
-- 
2.14.3
