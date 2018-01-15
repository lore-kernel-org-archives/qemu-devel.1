Received: from eggs.gnu.org ([2001:4830:134:3::10]:50052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3LI-0007vC-9k
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3LH-0003o9-42
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eb3LG-0003ng-R7
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E33287E427
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:54:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 15 Jan 2018 12:53:05 +0100
Message-Id: <20180115115309.23982-24-quintela@redhat.com>
In-Reply-To: <20180115115309.23982-1-quintela@redhat.com>
References: <20180115115309.23982-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 23/27] migration: cleanup stats update into
 function
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

We have quite a few lines in migration_thread() that calculates some
statistics for the migration interations.  Isolate it into a single
function to improve readability.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 84 ++++++++++++++++++++++++++++++---------------------
 migration/migration.h | 11 +++++++
 2 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6023218ffa..d7f85aa460 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1303,6 +1303,8 @@ MigrationState *migrate_init(void)
     s->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     s->total_time = 0;
     s->vm_was_running = false;
+    s->iteration_initial_bytes = 0;
+    s->threshold_size = 0;
     return s;
 }
 
@@ -2209,6 +2211,43 @@ static void migration_calculate_complete(MigrationState *s)
     }
 }
 
+static void migration_update_counters(MigrationState *s,
+                                      int64_t current_time)
+{
+    uint64_t transferred, time_spent;
+    int64_t threshold_size;
+    double bandwidth;
+
+    if (current_time < s->iteration_start_time + BUFFER_DELAY) {
+        return;
+    }
+
+    transferred = qemu_ftell(s->to_dst_file) - s->iteration_initial_bytes;
+    time_spent = current_time - s->iteration_start_time;
+    bandwidth = (double)transferred / time_spent;
+    threshold_size = bandwidth * s->parameters.downtime_limit;
+
+    s->mbps = (((double) transferred * 8.0) /
+               ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
+
+    /*
+     * if we haven't sent anything, we don't want to
+     * recalculate. 10000 is a small enough number for our purposes
+     */
+    if (ram_counters.dirty_pages_rate && transferred > 10000) {
+        s->expected_downtime = ram_counters.dirty_pages_rate *
+            qemu_target_page_size() / bandwidth;
+    }
+
+    qemu_file_reset_rate_limit(s->to_dst_file);
+
+    s->iteration_start_time = current_time;
+    s->iteration_initial_bytes = qemu_ftell(s->to_dst_file);
+
+    trace_migrate_transferred(transferred, time_spent,
+                              bandwidth, threshold_size);
+}
+
 /*
  * Master migration thread on the source VM.
  * It drives the migration and pumps the data down the outgoing channel.
@@ -2216,22 +2255,15 @@ static void migration_calculate_complete(MigrationState *s)
 static void *migration_thread(void *opaque)
 {
     MigrationState *s = opaque;
-    /* Used by the bandwidth calcs, updated later */
-    int64_t initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
-    int64_t initial_bytes = 0;
-    /*
-     * The final stage happens when the remaining data is smaller than
-     * this threshold; it's calculated from the requested downtime and
-     * measured bandwidth
-     */
-    int64_t threshold_size = 0;
     bool entered_postcopy = false;
     /* The active state we expect to be in; ACTIVE or POSTCOPY_ACTIVE */
     enum MigrationStatus current_active_state = MIGRATION_STATUS_ACTIVE;
 
     rcu_register_thread();
 
+    s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+
     qemu_savevm_state_header(s->to_dst_file);
 
     /*
@@ -2271,17 +2303,17 @@ static void *migration_thread(void *opaque)
         if (!qemu_file_rate_limit(s->to_dst_file)) {
             uint64_t pend_post, pend_nonpost;
 
-            qemu_savevm_state_pending(s->to_dst_file, threshold_size,
+            qemu_savevm_state_pending(s->to_dst_file, s->threshold_size,
                                       &pend_nonpost, &pend_post);
             pending_size = pend_nonpost + pend_post;
-            trace_migrate_pending(pending_size, threshold_size,
+            trace_migrate_pending(pending_size, s->threshold_size,
                                   pend_post, pend_nonpost);
-            if (pending_size && pending_size >= threshold_size) {
+            if (pending_size && pending_size >= s->threshold_size) {
                 /* Still a significant amount to transfer */
 
                 if (migrate_postcopy() &&
                     s->state != MIGRATION_STATUS_POSTCOPY_ACTIVE &&
-                    pend_nonpost <= threshold_size &&
+                    pend_nonpost <= s->threshold_size &&
                     atomic_read(&s->start_postcopy)) {
 
                     if (!postcopy_start(s)) {
@@ -2306,33 +2338,15 @@ static void *migration_thread(void *opaque)
             trace_migration_thread_file_err();
             break;
         }
+
         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-        if (current_time >= initial_time + BUFFER_DELAY) {
-            uint64_t transferred_bytes = qemu_ftell(s->to_dst_file) -
-                                         initial_bytes;
-            uint64_t time_spent = current_time - initial_time;
-            double bandwidth = (double)transferred_bytes / time_spent;
-            threshold_size = bandwidth * s->parameters.downtime_limit;
 
-            s->mbps = (((double) transferred_bytes * 8.0) /
-                    ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
+        migration_update_counters(s, current_time);
 
-            trace_migrate_transferred(transferred_bytes, time_spent,
-                                      bandwidth, threshold_size);
-            /* if we haven't sent anything, we don't want to recalculate
-               10000 is a small enough number for our purposes */
-            if (ram_counters.dirty_pages_rate && transferred_bytes > 10000) {
-                s->expected_downtime = ram_counters.dirty_pages_rate *
-                    qemu_target_page_size() / bandwidth;
-            }
-
-            qemu_file_reset_rate_limit(s->to_dst_file);
-            initial_time = current_time;
-            initial_bytes = qemu_ftell(s->to_dst_file);
-        }
         if (qemu_file_rate_limit(s->to_dst_file)) {
             /* usleep expects microseconds */
-            g_usleep((initial_time + BUFFER_DELAY - current_time)*1000);
+            g_usleep((s->iteration_start_time + BUFFER_DELAY -
+                      current_time) * 1000);
         }
     }
 
diff --git a/migration/migration.h b/migration/migration.h
index 0aad12f9a1..f2bc1aaf85 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -102,6 +102,17 @@ struct MigrationState
     QEMUBH *cleanup_bh;
     QEMUFile *to_dst_file;
 
+    /* bytes already send at the beggining of current interation */
+    uint64_t iteration_initial_bytes;
+    /* time at the start of current iteration */
+    int64_t iteration_start_time;
+    /*
+     * The final stage happens when the remaining data is smaller than
+     * this threshold; it's calculated from the requested downtime and
+     * measured bandwidth
+     */
+    int64_t threshold_size;
+
     /* params from 'migrate-set-parameters' */
     MigrationParameters parameters;
 
-- 
2.14.3
