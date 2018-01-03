Received: from eggs.gnu.org ([2001:4830:134:3::10]:48072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWbnf-0003FE-8y
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWbne-00018Y-40
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:41:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWbnd-00017t-Qv
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:41:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03A475F7AC
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 05:41:13 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 13:40:41 +0800
Message-Id: <20180103054043.25719-10-peterx@redhat.com>
In-Reply-To: <20180103054043.25719-1-peterx@redhat.com>
References: <20180103054043.25719-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 09/11] migration: cleanup stats update into
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
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

We have quite a few lines in migration_thread() that calculates some
statistics for the migration interations.  Isolate it into a single
function to improve readability.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 82 +++++++++++++++++++++++++++++----------------------
 migration/migration.h | 13 ++++++++
 2 files changed, 59 insertions(+), 36 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index bfcba24caa..2629f907e9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1273,6 +1273,8 @@ MigrationState *migrate_init(void)
     s->mig_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     s->mig_total_time = 0;
     s->old_vm_running = false;
+    s->initial_bytes = 0;
+    s->threshold_size = 0;
     return s;
 }
 
@@ -2164,6 +2166,39 @@ static void migration_calculate_complete(MigrationState *s)
     }
 }
 
+static void migration_update_statistics(MigrationState *s,
+                                        int64_t current_time)
+{
+    uint64_t transferred = qemu_ftell(s->to_dst_file) - s->initial_bytes;
+    uint64_t time_spent = current_time - s->initial_time;
+    double bandwidth = (double)transferred / time_spent;
+    int64_t threshold_size = bandwidth * s->parameters.downtime_limit;
+
+    if (current_time < s->initial_time + BUFFER_DELAY) {
+        return;
+    }
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
+    s->initial_time = current_time;
+    s->initial_bytes = qemu_ftell(s->to_dst_file);
+
+    trace_migrate_transferred(transferred, time_spent,
+                              bandwidth, threshold_size);
+}
+
 /*
  * Master migration thread on the source VM.
  * It drives the migration and pumps the data down the outgoing channel.
@@ -2171,22 +2206,15 @@ static void migration_calculate_complete(MigrationState *s)
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
 
+    s->initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+
     qemu_savevm_state_header(s->to_dst_file);
 
     /*
@@ -2226,17 +2254,17 @@ static void *migration_thread(void *opaque)
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
@@ -2261,33 +2289,15 @@ static void *migration_thread(void *opaque)
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
-
-            s->mbps = (((double) transferred_bytes * 8.0) /
-                    ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
-
-            trace_migrate_transferred(transferred_bytes, time_spent,
-                                      bandwidth, threshold_size);
-            /* if we haven't sent anything, we don't want to recalculate
-               10000 is a small enough number for our purposes */
-            if (ram_counters.dirty_pages_rate && transferred_bytes > 10000) {
-                s->expected_downtime = ram_counters.dirty_pages_rate *
-                    qemu_target_page_size() / bandwidth;
-            }
 
-            qemu_file_reset_rate_limit(s->to_dst_file);
-            initial_time = current_time;
-            initial_bytes = qemu_ftell(s->to_dst_file);
-        }
+        /* Conditionally update statistics */
+        migration_update_statistics(s, current_time);
+
         if (qemu_file_rate_limit(s->to_dst_file)) {
             /* usleep expects microseconds */
-            g_usleep((initial_time + BUFFER_DELAY - current_time)*1000);
+            g_usleep((s->initial_time + BUFFER_DELAY - current_time) * 1000);
         }
     }
 
diff --git a/migration/migration.h b/migration/migration.h
index 3ab5506233..248f7d9a5c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -90,6 +90,19 @@ struct MigrationState
     QEMUBH *cleanup_bh;
     QEMUFile *to_dst_file;
 
+    /*
+     * Migration thread statistic variables, mostly used in
+     * migration_thread() iterations only.
+     */
+    uint64_t initial_bytes;
+    int64_t initial_time;
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
