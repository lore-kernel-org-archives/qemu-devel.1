Received: from eggs.gnu.org ([2001:4830:134:3::10]:56776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi2L-0006rr-8C
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi2J-0002K1-Sn
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWi2J-0002J4-Iv
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74A6BC0AE086
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:20:46 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 20:20:13 +0800
Message-Id: <20180103122017.14794-10-peterx@redhat.com>
In-Reply-To: <20180103122017.14794-1-peterx@redhat.com>
References: <20180103122017.14794-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/13] migration: cleanup stats update into
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
 migration/migration.c | 86 ++++++++++++++++++++++++++++++---------------------
 migration/migration.h | 11 +++++++
 2 files changed, 61 insertions(+), 36 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4dd21f8636..de872801e6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1273,6 +1273,8 @@ MigrationState *migrate_init(void)
     s->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     s->total_time = 0;
     s->vm_was_running = false;
+    s->iteration_initial_bytes = 0;
+    s->threshold_size = 0;
     return s;
 }
 
@@ -2170,6 +2172,43 @@ static void migration_calculate_complete(MigrationState *s)
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
@@ -2177,22 +2216,15 @@ static void migration_calculate_complete(MigrationState *s)
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
@@ -2232,17 +2264,17 @@ static void *migration_thread(void *opaque)
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
@@ -2267,33 +2299,15 @@ static void *migration_thread(void *opaque)
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
+        migration_update_counters(s, current_time);
+
         if (qemu_file_rate_limit(s->to_dst_file)) {
             /* usleep expects microseconds */
-            g_usleep((initial_time + BUFFER_DELAY - current_time)*1000);
+            g_usleep((s->iteration_start_time + BUFFER_DELAY -
+                      current_time) * 1000);
         }
     }
 
diff --git a/migration/migration.h b/migration/migration.h
index 867383f18d..786d971ce2 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -90,6 +90,17 @@ struct MigrationState
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
