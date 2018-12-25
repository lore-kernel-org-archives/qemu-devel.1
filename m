Received: from eggs.gnu.org ([208.118.235.92]:33313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnLL-0001qm-Gy
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnLI-0003zp-8I
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:59 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:58376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gbnLH-0003vx-RC
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:56 -0500
From: Fei Li <fli@suse.com>
Date: Tue, 25 Dec 2018 22:04:46 +0800
Message-Id: <20181225140449.15786-14-fli@suse.com>
In-Reply-To: <20181225140449.15786-1-fli@suse.com>
References: <20181225140449.15786-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH for-4.0 v9 13/16] qemu_thread: supplement error
 handling for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: lifei1214@126.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

Update qemu_thread_create()'s callers by
- setting an error on qemu_thread_create() failure for callers that
  set an error on failure;
- reporting the error and returning failure for callers that return
  an error code on failure;
- reporting the error and setting some state for callers that just
  report errors and choose not to continue on.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
---
 migration/migration.c    | 33 ++++++++++++++++++++++-----------
 migration/postcopy-ram.c | 16 ++++++++++++----
 migration/ram.c          | 44 ++++++++++++++++++++++++++++++--------------
 migration/savevm.c       | 12 ++++++++----
 4 files changed, 72 insertions(+), 33 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ea5839ff0d..9654bde101 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -447,10 +447,13 @@ static void process_incoming_migration_co(void *opaque)
             goto fail;
         }
 
-        /* TODO: let the further caller handle the error instead of abort() */
-        qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
-                           colo_process_incoming_thread, mis,
-                           QEMU_THREAD_JOINABLE, &error_abort);
+        if (!qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
+                                colo_process_incoming_thread, mis,
+                                QEMU_THREAD_JOINABLE, &local_err)) {
+            error_reportf_err(local_err, "failed to create "
+                              "colo_process_incoming_thread: ");
+            goto fail;
+        }
         mis->have_colo_incoming_thread = true;
         qemu_coroutine_yield();
 
@@ -2347,6 +2350,7 @@ out:
 static int open_return_path_on_source(MigrationState *ms,
                                       bool create_thread)
 {
+    Error *local_err = NULL;
 
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
     if (!ms->rp_state.from_dst_file) {
@@ -2360,10 +2364,13 @@ static int open_return_path_on_source(MigrationState *ms,
         return 0;
     }
 
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&ms->rp_state.rp_thread, "return path",
-                       source_return_path_thread, ms,
-                       QEMU_THREAD_JOINABLE, &error_abort);
+    if (!qemu_thread_create(&ms->rp_state.rp_thread, "return path",
+                            source_return_path_thread, ms,
+                            QEMU_THREAD_JOINABLE, &local_err)) {
+        error_reportf_err(local_err,
+                          "failed to create source_return_path_thread: ");
+        return -1;
+     }
 
     trace_open_return_path_on_source_continue();
 
@@ -3193,9 +3200,13 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         migrate_fd_cleanup(s);
         return;
     }
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
-                       QEMU_THREAD_JOINABLE, &error_abort);
+    if (!qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
+                            QEMU_THREAD_JOINABLE, &error_in)) {
+        error_reportf_err(error_in, "failed to create migration_thread: ");
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        migrate_fd_cleanup(s);
+        return;
+    }
     s->migration_thread_running = true;
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 221ea24919..80bfa9c4a2 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1083,6 +1083,8 @@ retry:
 
 int postcopy_ram_enable_notify(MigrationIncomingState *mis)
 {
+    Error *local_err = NULL;
+
     /* Open the fd for the kernel to give us userfaults */
     mis->userfault_fd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
     if (mis->userfault_fd == -1) {
@@ -1109,10 +1111,16 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
     }
 
     qemu_sem_init(&mis->fault_thread_sem, 0);
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&mis->fault_thread, "postcopy/fault",
-                       postcopy_ram_fault_thread, mis,
-                       QEMU_THREAD_JOINABLE, &error_abort);
+    if (!qemu_thread_create(&mis->fault_thread, "postcopy/fault",
+                            postcopy_ram_fault_thread, mis,
+                            QEMU_THREAD_JOINABLE, &local_err)) {
+        error_reportf_err(local_err,
+                          "failed to create postcopy_ram_fault_thread: ");
+        close(mis->userfault_event_fd);
+        close(mis->userfault_fd);
+        qemu_sem_destroy(&mis->fault_thread_sem);
+        return -1;
+    }
     qemu_sem_wait(&mis->fault_thread_sem);
     qemu_sem_destroy(&mis->fault_thread_sem);
     mis->have_fault_thread = true;
diff --git a/migration/ram.c b/migration/ram.c
index eed1daf302..1e24a78eaa 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -473,6 +473,7 @@ static void compress_threads_save_cleanup(void)
 static int compress_threads_save_setup(void)
 {
     int i, thread_count;
+    Error *local_err = NULL;
 
     if (!migrate_use_compression()) {
         return 0;
@@ -502,10 +503,12 @@ static int compress_threads_save_setup(void)
         comp_param[i].quit = false;
         qemu_mutex_init(&comp_param[i].mutex);
         qemu_cond_init(&comp_param[i].cond);
-        /* TODO: let the further caller handle the error instead of abort() */
-        qemu_thread_create(compress_threads + i, "compress",
-                           do_data_compress, comp_param + i,
-                           QEMU_THREAD_JOINABLE, &error_abort);
+        if (!qemu_thread_create(compress_threads + i, "compress",
+                                do_data_compress, comp_param + i,
+                                QEMU_THREAD_JOINABLE, &local_err)) {
+            error_reportf_err(local_err, "failed to create do_data_compress: ");
+            goto exit;
+        }
     }
     return 0;
 
@@ -1076,9 +1079,14 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
         p->c = QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
         p->running = true;
-        /* TODO: let the further caller handle the error instead of abort() */
-        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE, &error_abort);
+        if (!qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
+                                QEMU_THREAD_JOINABLE, &local_err)) {
+            migrate_set_error(migrate_get_current(), local_err);
+            error_reportf_err(local_err,
+                              "failed to create multifd_send_thread: ");
+            multifd_save_cleanup();
+            return;
+        }
 
         atomic_inc(&multifd_send_state->count);
     }
@@ -1357,9 +1365,13 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     p->num_packets = 1;
 
     p->running = true;
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
-                       QEMU_THREAD_JOINABLE, &error_abort);
+    if (!qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
+                            QEMU_THREAD_JOINABLE, &local_err)) {
+        error_propagate_prepend(errp, local_err,
+                                "failed to create multifd_recv_thread: ");
+        multifd_recv_terminate_threads(local_err);
+        return false;
+    }
     atomic_inc(&multifd_recv_state->count);
     return atomic_read(&multifd_recv_state->count) ==
            migrate_multifd_channels();
@@ -3625,6 +3637,7 @@ static void compress_threads_load_cleanup(void)
 static int compress_threads_load_setup(QEMUFile *f)
 {
     int i, thread_count;
+    Error *local_err = NULL;
 
     if (!migrate_use_compression()) {
         return 0;
@@ -3646,10 +3659,13 @@ static int compress_threads_load_setup(QEMUFile *f)
         qemu_cond_init(&decomp_param[i].cond);
         decomp_param[i].done = true;
         decomp_param[i].quit = false;
-        /* TODO: let the further caller handle the error instead of abort() */
-        qemu_thread_create(decompress_threads + i, "decompress",
-                           do_data_decompress, decomp_param + i,
-                           QEMU_THREAD_JOINABLE, &error_abort);
+        if (!qemu_thread_create(decompress_threads + i, "decompress",
+                                do_data_decompress, decomp_param + i,
+                                QEMU_THREAD_JOINABLE, &local_err)) {
+            error_reportf_err(local_err,
+                              "failed to create do_data_decompress: ");
+            goto exit;
+        }
     }
     return 0;
 exit:
diff --git a/migration/savevm.c b/migration/savevm.c
index 46ce7af239..b8bdcde5d8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1747,10 +1747,14 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     mis->have_listen_thread = true;
     /* Start up the listening thread and wait for it to signal ready */
     qemu_sem_init(&mis->listen_thread_sem, 0);
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&mis->listen_thread, "postcopy/listen",
-                       postcopy_ram_listen_thread, NULL,
-                       QEMU_THREAD_DETACHED, &error_abort);
+    if (!qemu_thread_create(&mis->listen_thread, "postcopy/listen",
+                            postcopy_ram_listen_thread, NULL,
+                            QEMU_THREAD_DETACHED, &local_err)) {
+        error_reportf_err(local_err,
+                          "failed to create postcopy_ram_listen_thread: ");
+        qemu_sem_destroy(&mis->listen_thread_sem);
+        return -1;
+    }
     qemu_sem_wait(&mis->listen_thread_sem);
     qemu_sem_destroy(&mis->listen_thread_sem);
 
-- 
2.13.7
