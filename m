Received: from eggs.gnu.org ([2001:4830:134:3::10]:35754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJR6-00082r-Be
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJR5-0006Tg-5s
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:02:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJR4-0006TU-T0
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:02:03 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:04 +0800
Message-Id: <20171108060130.3772-7-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 06/32] migration: allow dst vm pause on
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  |  1 +
 migration/migration.h  |  3 +++
 migration/savevm.c     | 60 ++++++++++++++++++++++++++++++++++++++++++++++++--
 migration/trace-events |  2 ++
 4 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 46e7ca36a4..b166e19785 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -150,6 +150,7 @@ MigrationIncomingState *migration_incoming_get_current(void)
         memset(&mis_current, 0, sizeof(MigrationIncomingState));
         qemu_mutex_init(&mis_current.rp_mutex);
         qemu_event_init(&mis_current.main_thread_load_event, false);
+        qemu_sem_init(&mis_current.postcopy_pause_sem_dst, 0);
         once = true;
     }
     return &mis_current;
diff --git a/migration/migration.h b/migration/migration.h
index 36aaa13f50..55894ecb79 100644
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
index 1da0255cd7..93e308ebf0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1529,8 +1529,8 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
  */
 static void *postcopy_ram_listen_thread(void *opaque)
 {
-    QEMUFile *f = opaque;
     MigrationIncomingState *mis = migration_incoming_get_current();
+    QEMUFile *f = mis->from_src_file;
     int load_res;
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
@@ -1544,6 +1544,14 @@ static void *postcopy_ram_listen_thread(void *opaque)
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
 
@@ -1626,7 +1634,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     /* Start up the listening thread and wait for it to signal ready */
     qemu_sem_init(&mis->listen_thread_sem, 0);
     qemu_thread_create(&mis->listen_thread, "postcopy/listen",
-                       postcopy_ram_listen_thread, mis->from_src_file,
+                       postcopy_ram_listen_thread, NULL,
                        QEMU_THREAD_DETACHED);
     qemu_sem_wait(&mis->listen_thread_sem);
     qemu_sem_destroy(&mis->listen_thread_sem);
@@ -2011,11 +2019,44 @@ void qemu_loadvm_state_cleanup(void)
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
 
@@ -2060,6 +2101,21 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
 out:
     if (ret < 0) {
         qemu_file_set_error(f, ret);
+
+        /*
+         * Detect whether it is:
+         *
+         * 1. postcopy running
+         * 2. network failure (-EIO)
+         *
+         * If so, we try to wait for a recovery.
+         */
+        if (mis->state == MIGRATION_STATUS_POSTCOPY_ACTIVE &&
+            ret == -EIO && postcopy_pause_incoming(mis)) {
+            /* Reset f to point to the newly created channel */
+            f = mis->from_src_file;
+            goto retry;
+        }
     }
     return ret;
 }
diff --git a/migration/trace-events b/migration/trace-events
index da1c63a933..bed1646cd6 100644
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
2.13.6
