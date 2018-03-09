Received: from eggs.gnu.org ([2001:4830:134:3::10]:44854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euE85-0003aa-Py
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euE84-0005g6-Cs
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:15:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60692 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1euE84-0005fr-7A
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:15:56 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Mar 2018 17:15:16 +0800
Message-Id: <20180309091535.13315-5-peterx@redhat.com>
In-Reply-To: <20180309091535.13315-1-peterx@redhat.com>
References: <20180309091535.13315-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 04/23] migration: allow dst vm pause on
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

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
 migration/migration.c  |  1 +
 migration/migration.h  |  3 +++
 migration/savevm.c     | 63 ++++++++++++++++++++++++++++++++++++++++++++++++--
 migration/trace-events |  2 ++
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 84afed174d..91a4ebba8f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -157,6 +157,7 @@ MigrationIncomingState *migration_incoming_get_current(void)
         memset(&mis_current, 0, sizeof(MigrationIncomingState));
         qemu_mutex_init(&mis_current.rp_mutex);
         qemu_event_init(&mis_current.main_thread_load_event, false);
+        qemu_sem_init(&mis_current.postcopy_pause_sem_dst, 0);
         once = true;
     }
     return &mis_current;
diff --git a/migration/migration.h b/migration/migration.h
index 5774b25358..9a2de4ba9b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -61,6 +61,9 @@ struct MigrationIncomingState {
     /* The coroutine we should enter (back) after failover */
     Coroutine *migration_incoming_co;
     QemuSemaphore colo_incoming_sem;
+
+    /* notify PAUSED postcopy incoming migrations to try to continue */
+    QemuSemaphore postcopy_pause_sem_dst;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 358c5b51e2..babcff4844 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1549,8 +1549,8 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
  */
 static void *postcopy_ram_listen_thread(void *opaque)
 {
-    QEMUFile *f = opaque;
     MigrationIncomingState *mis = migration_incoming_get_current();
+    QEMUFile *f = mis->from_src_file;
     int load_res;
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
@@ -1564,6 +1564,14 @@ static void *postcopy_ram_listen_thread(void *opaque)
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
 
@@ -1646,7 +1654,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     /* Start up the listening thread and wait for it to signal ready */
     qemu_sem_init(&mis->listen_thread_sem, 0);
     qemu_thread_create(&mis->listen_thread, "postcopy/listen",
-                       postcopy_ram_listen_thread, mis->from_src_file,
+                       postcopy_ram_listen_thread, NULL,
                        QEMU_THREAD_DETACHED);
     qemu_sem_wait(&mis->listen_thread_sem);
     qemu_sem_destroy(&mis->listen_thread_sem);
@@ -2031,11 +2039,44 @@ void qemu_loadvm_state_cleanup(void)
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
 
@@ -2080,6 +2121,24 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
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
index 7afbb3e791..8685a62c98 100644
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
