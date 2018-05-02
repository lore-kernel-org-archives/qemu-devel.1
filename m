Received: from eggs.gnu.org ([2001:4830:134:3::10]:34758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpIu-0006KP-Ue
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpIr-0002kR-R6
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDpIr-0002k5-Gx
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:05 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 18:47:20 +0800
Message-Id: <20180502104740.12123-5-peterx@redhat.com>
In-Reply-To: <20180502104740.12123-1-peterx@redhat.com>
References: <20180502104740.12123-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 04/24] migration: allow dst vm pause on
 postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

When there is IO error on the incoming channel (e.g., network down),
instead of bailing out immediately, we allow the dst vm to switch to the
new POSTCOPY_PAUSE state. Currently it is still simple - it waits the
new semaphore, until someone poke it for another attempt.

One note is that here on ram loading thread we cannot detect the
POSTCOPY_ACTIVE state, but we need to detect the more specific
POSTCOPY_INCOMING_RUNNING state, to make sure we have already loaded all
the device states.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h  |  3 +++
 migration/migration.c  |  1 +
 migration/savevm.c     | 63 ++++++++++++++++++++++++++++++++++++++++++++++++--
 migration/trace-events |  2 ++
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 9bf3418973..ad96cc2c85 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -73,6 +73,9 @@ struct MigrationIncomingState {
      * live migration, to calculate vCPU block time
      * */
     struct PostcopyBlocktimeContext *blocktime_ctx;
+
+    /* notify PAUSED postcopy incoming migrations to try to continue */
+    QemuSemaphore postcopy_pause_sem_dst;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
diff --git a/migration/migration.c b/migration/migration.c
index b9dac8c3b9..5ad3a79354 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -159,6 +159,7 @@ MigrationIncomingState *migration_incoming_get_current(void)
                                                    sizeof(struct PostCopyFD));
         qemu_mutex_init(&mis_current.rp_mutex);
         qemu_event_init(&mis_current.main_thread_load_event, false);
+        qemu_sem_init(&mis_current.postcopy_pause_sem_dst, 0);
 
         init_dirty_bitmap_incoming_migration();
 
diff --git a/migration/savevm.c b/migration/savevm.c
index e2be02afe4..8ad99b1eaa 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1564,8 +1564,8 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
  */
 static void *postcopy_ram_listen_thread(void *opaque)
 {
-    QEMUFile *f = opaque;
     MigrationIncomingState *mis = migration_incoming_get_current();
+    QEMUFile *f = mis->from_src_file;
     int load_res;
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
@@ -1579,6 +1579,14 @@ static void *postcopy_ram_listen_thread(void *opaque)
      */
     qemu_file_set_blocking(f, true);
     load_res = qemu_loadvm_state_main(f, mis);
+
+    /*
+     * This is tricky, but, mis->from_src_file can change after it
+     * returns, when postcopy recovery happened. In the future, we may
+     * want a wrapper for the QEMUFile handle.
+     */
+    f = mis->from_src_file;
+
     /* And non-blocking again so we don't block in any cleanup */
     qemu_file_set_blocking(f, false);
 
@@ -1668,7 +1676,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     /* Start up the listening thread and wait for it to signal ready */
     qemu_sem_init(&mis->listen_thread_sem, 0);
     qemu_thread_create(&mis->listen_thread, "postcopy/listen",
-                       postcopy_ram_listen_thread, mis->from_src_file,
+                       postcopy_ram_listen_thread, NULL,
                        QEMU_THREAD_DETACHED);
     qemu_sem_wait(&mis->listen_thread_sem);
     qemu_sem_destroy(&mis->listen_thread_sem);
@@ -2055,11 +2063,44 @@ void qemu_loadvm_state_cleanup(void)
     }
 }
 
+/* Return true if we should continue the migration, or false. */
+static bool postcopy_pause_incoming(MigrationIncomingState *mis)
+{
+    trace_postcopy_pause_incoming();
+
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                      MIGRATION_STATUS_POSTCOPY_PAUSED);
+
+    assert(mis->from_src_file);
+    qemu_file_shutdown(mis->from_src_file);
+    qemu_fclose(mis->from_src_file);
+    mis->from_src_file = NULL;
+
+    assert(mis->to_src_file);
+    qemu_file_shutdown(mis->to_src_file);
+    qemu_mutex_lock(&mis->rp_mutex);
+    qemu_fclose(mis->to_src_file);
+    mis->to_src_file = NULL;
+    qemu_mutex_unlock(&mis->rp_mutex);
+
+    error_report("Detected IO failure for postcopy. "
+                 "Migration paused.");
+
+    while (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        qemu_sem_wait(&mis->postcopy_pause_sem_dst);
+    }
+
+    trace_postcopy_pause_incoming_continued();
+
+    return true;
+}
+
 static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
 {
     uint8_t section_type;
     int ret = 0;
 
+retry:
     while (true) {
         section_type = qemu_get_byte(f);
 
@@ -2104,6 +2145,24 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
 out:
     if (ret < 0) {
         qemu_file_set_error(f, ret);
+
+        /*
+         * Detect whether it is:
+         *
+         * 1. postcopy running (after receiving all device data, which
+         *    must be in POSTCOPY_INCOMING_RUNNING state.  Note that
+         *    POSTCOPY_INCOMING_LISTENING is still not enough, it's
+         *    still receiving device states).
+         * 2. network failure (-EIO)
+         *
+         * If so, we try to wait for a recovery.
+         */
+        if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
+            ret == -EIO && postcopy_pause_incoming(mis)) {
+            /* Reset f to point to the newly created channel */
+            f = mis->from_src_file;
+            goto retry;
+        }
     }
     return ret;
 }
diff --git a/migration/trace-events b/migration/trace-events
index 409b4b8be3..e23ec019be 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -100,6 +100,8 @@ open_return_path_on_source(void) ""
 open_return_path_on_source_continue(void) ""
 postcopy_start(void) ""
 postcopy_pause_continued(void) ""
+postcopy_pause_incoming(void) ""
+postcopy_pause_incoming_continued(void) ""
 postcopy_start_set_run(void) ""
 source_return_path_thread_bad_end(void) ""
 source_return_path_thread_end(void) ""
-- 
2.14.3
