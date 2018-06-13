Received: from eggs.gnu.org ([2001:4830:134:3::10]:48118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fT2zJ-0002Gv-8c
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fT2zH-0000uj-4M
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:26:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fT2zG-0000uJ-VM
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:26:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9556D4021CC5
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 10:26:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 13 Jun 2018 11:26:41 +0100
Message-Id: <20180613102642.23995-3-dgilbert@redhat.com>
In-Reply-To: <20180613102642.23995-1-dgilbert@redhat.com>
References: <20180613102642.23995-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] migration: Wake rate limiting for urgent
 requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com
Cc: jdenemar@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Rate limiting sleeps the migration thread for a while when it runs
out of bandwidth; but sometimes we want to wake up to get on with
something more urgent (like a postcopy request).  Here we use
a semaphore with a timedwait instead of a simple sleep; Incrementing
the sempahore will wake it up sooner.  Anything that consumes
these urgent events must decrement the sempahore.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c  | 35 +++++++++++++++++++++++++++++++----
 migration/migration.h  |  8 ++++++++
 migration/trace-events |  2 ++
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3a50d4c35c..108c3d7142 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2852,6 +2852,16 @@ static void migration_iteration_finish(MigrationState *s)
     qemu_mutex_unlock_iothread();
 }
 
+void migration_make_urgent_request(void)
+{
+    qemu_sem_post(&migrate_get_current()->rate_limit_sem);
+}
+
+void migration_consume_urgent_request(void)
+{
+    qemu_sem_wait(&migrate_get_current()->rate_limit_sem);
+}
+
 /*
  * Master migration thread on the source VM.
  * It drives the migration and pumps the data down the outgoing channel.
@@ -2861,6 +2871,7 @@ static void *migration_thread(void *opaque)
     MigrationState *s = opaque;
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     MigThrError thr_error;
+    bool urgent = false;
 
     rcu_register_thread();
 
@@ -2901,7 +2912,7 @@ static void *migration_thread(void *opaque)
            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
         int64_t current_time;
 
-        if (!qemu_file_rate_limit(s->to_dst_file)) {
+        if (urgent || !qemu_file_rate_limit(s->to_dst_file)) {
             MigIterateState iter_state = migration_iteration_run(s);
             if (iter_state == MIG_ITERATE_SKIP) {
                 continue;
@@ -2932,10 +2943,24 @@ static void *migration_thread(void *opaque)
 
         migration_update_counters(s, current_time);
 
+        urgent = false;
         if (qemu_file_rate_limit(s->to_dst_file)) {
-            /* usleep expects microseconds */
-            g_usleep((s->iteration_start_time + BUFFER_DELAY -
-                      current_time) * 1000);
+            /* Wait for a delay to do rate limiting OR
+             * something urgent to post the semaphore.
+             */
+            int ms = s->iteration_start_time + BUFFER_DELAY - current_time;
+            trace_migration_thread_ratelimit_pre(ms);
+            if (qemu_sem_timedwait(&s->rate_limit_sem, ms) == 0) {
+                /* We were worken by one or more urgent things but
+                 * the timedwait will have consumed one of them.
+                 * The service routine for the urgent wake will dec
+                 * the semaphore itself for each item it consumes,
+                 * so add this one we just eat back.
+                 */
+                qemu_sem_post(&s->rate_limit_sem);
+                urgent = true;
+            }
+            trace_migration_thread_ratelimit_post(urgent);
         }
     }
 
@@ -3109,6 +3134,7 @@ static void migration_instance_finalize(Object *obj)
     qemu_mutex_destroy(&ms->qemu_file_lock);
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
+    qemu_sem_destroy(&ms->rate_limit_sem);
     qemu_sem_destroy(&ms->pause_sem);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
     qemu_sem_destroy(&ms->postcopy_pause_rp_sem);
@@ -3147,6 +3173,7 @@ static void migration_instance_init(Object *obj)
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
+    qemu_sem_init(&ms->rate_limit_sem, 0);
     qemu_mutex_init(&ms->qemu_file_lock);
 }
 
diff --git a/migration/migration.h b/migration/migration.h
index 31d3ed12dc..64a7b33735 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -121,6 +121,11 @@ struct MigrationState
      */
     QemuMutex qemu_file_lock;
 
+    /*
+     * Used to allow urgent requests to override rate limiting.
+     */
+    QemuSemaphore rate_limit_sem;
+
     /* bytes already send at the beggining of current interation */
     uint64_t iteration_initial_bytes;
     /* time at the start of current iteration */
@@ -287,4 +292,7 @@ void init_dirty_bitmap_incoming_migration(void);
 #define qemu_ram_foreach_block \
   #warning "Use qemu_ram_foreach_block_migratable in migration code"
 
+void migration_make_urgent_request(void);
+void migration_consume_urgent_request(void);
+
 #endif
diff --git a/migration/trace-events b/migration/trace-events
index 4a768eaaeb..3f67758893 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -108,6 +108,8 @@ migration_return_path_end_before(void) ""
 migration_return_path_end_after(int rp_error) "%d"
 migration_thread_after_loop(void) ""
 migration_thread_file_err(void) ""
+migration_thread_ratelimit_pre(int ms) "%d ms"
+migration_thread_ratelimit_post(int urgent) "urgent: %d"
 migration_thread_setup_complete(void) ""
 open_return_path_on_source(void) ""
 open_return_path_on_source_continue(void) ""
-- 
2.17.1
