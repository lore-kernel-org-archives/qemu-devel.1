Received: from eggs.gnu.org ([209.51.188.92]:41826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7o3-0004F8-Eb
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7o1-00024d-DI
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:22:35 -0500
Received: from m15-113.126.com ([220.181.15.113]:56446)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7ny-00022U-7K
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:22:32 -0500
From: Fei Li <lifei1214@126.com>
Date: Mon, 28 Jan 2019 22:22:15 +0800
Message-Id: <20190128142217.12979-8-lifei1214@126.com>
In-Reply-To: <20190128142217.12979-1-lifei1214@126.com>
References: <20190128142217.12979-1-lifei1214@126.com>
Subject: [Qemu-devel] [PATCH for-4.0 09/11] qemu_thread: supplement error
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
Cc: Markus Armbruster <armbru@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Fei Li <fli@suse.com>

From: Fei Li <fli@suse.com>

Update qemu_thread_create()'s callers by
- setting an error on qemu_thread_create() failure for callers that
  set an error on failure;
- reporting the error and returning failure for callers that return
  an error code on failure;
- reporting the error and setting some state for callers that just
  report errors and choose not to continue on.

Besides, make compress_threads_save_cleanup() cope with partially
initialized comp_param[i] to adapt to the new qemu_thread_create()
failure case.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c    | 35 +++++++++++++-------
 migration/postcopy-ram.c | 16 ++++++---
 migration/ram.c          | 70 ++++++++++++++++++++++++++--------------
 migration/savevm.c       | 12 ++++---
 4 files changed, 89 insertions(+), 44 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1da71211c8..0034ca1334 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -447,10 +447,13 @@ static void process_incoming_migration_co(void *opaque)
             goto fail;
         }
 
-        /* TODO: let the further caller handle the error instead of abort() */
-        qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
-                           colo_process_incoming_thread, mis,
-                           QEMU_THREAD_JOINABLE, &error_abort);
+        if (qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
+                               colo_process_incoming_thread, mis,
+                               QEMU_THREAD_JOINABLE, &local_err) < 0) {
+            error_reportf_err(local_err, "failed to create "
+                              "colo_process_incoming_thread: ");
+            goto fail;
+        }
         mis->have_colo_incoming_thread = true;
         qemu_coroutine_yield();
 
@@ -2349,6 +2352,7 @@ out:
 static int open_return_path_on_source(MigrationState *ms,
                                       bool create_thread)
 {
+    Error *local_err = NULL;
 
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
     if (!ms->rp_state.from_dst_file) {
@@ -2362,10 +2366,15 @@ static int open_return_path_on_source(MigrationState *ms,
         return 0;
     }
 
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&ms->rp_state.rp_thread, "return path",
-                       source_return_path_thread, ms,
-                       QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(&ms->rp_state.rp_thread, "return path",
+                           source_return_path_thread, ms,
+                           QEMU_THREAD_JOINABLE, &local_err) < 0) {
+        error_reportf_err(local_err,
+                          "failed to create source_return_path_thread: ");
+        qemu_fclose(ms->rp_state.from_dst_file);
+        ms->rp_state.from_dst_file = NULL;
+        return -1;
+     }
 
     trace_open_return_path_on_source_continue();
 
@@ -3201,9 +3210,13 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         migrate_fd_cleanup(s);
         return;
     }
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
-                       QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
+                           QEMU_THREAD_JOINABLE, &error_in) < 0) {
+        error_reportf_err(error_in, "failed to create migration_thread: ");
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        migrate_fd_cleanup(s);
+        return;
+    }
     s->migration_thread_running = true;
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 221ea24919..0934a1403a 100644
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
+    if (qemu_thread_create(&mis->fault_thread, "postcopy/fault",
+                           postcopy_ram_fault_thread, mis,
+                           QEMU_THREAD_JOINABLE, &local_err) < 0) {
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
index 700ea229e0..66b8b764f1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -441,6 +441,14 @@ static void compress_threads_save_cleanup(void)
 
     thread_count = migrate_compress_threads();
     for (i = 0; i < thread_count; i++) {
+        qemu_mutex_lock(&comp_param[i].mutex);
+        comp_param[i].quit = true;
+        qemu_cond_signal(&comp_param[i].cond);
+        qemu_mutex_unlock(&comp_param[i].mutex);
+
+        qemu_mutex_destroy(&comp_param[i].mutex);
+        qemu_cond_destroy(&comp_param[i].cond);
+
         /*
          * we use it as a indicator which shows if the thread is
          * properly init'd or not
@@ -448,15 +456,7 @@ static void compress_threads_save_cleanup(void)
         if (!comp_param[i].file) {
             break;
         }
-
-        qemu_mutex_lock(&comp_param[i].mutex);
-        comp_param[i].quit = true;
-        qemu_cond_signal(&comp_param[i].cond);
-        qemu_mutex_unlock(&comp_param[i].mutex);
-
         qemu_thread_join(compress_threads + i);
-        qemu_mutex_destroy(&comp_param[i].mutex);
-        qemu_cond_destroy(&comp_param[i].cond);
         deflateEnd(&comp_param[i].stream);
         g_free(comp_param[i].originbuf);
         qemu_fclose(comp_param[i].file);
@@ -473,6 +473,7 @@ static void compress_threads_save_cleanup(void)
 static int compress_threads_save_setup(void)
 {
     int i, thread_count;
+    Error *local_err = NULL;
 
     if (!migrate_use_compression()) {
         return 0;
@@ -483,6 +484,9 @@ static int compress_threads_save_setup(void)
     qemu_cond_init(&comp_done_cond);
     qemu_mutex_init(&comp_done_lock);
     for (i = 0; i < thread_count; i++) {
+        qemu_mutex_init(&comp_param[i].mutex);
+        qemu_cond_init(&comp_param[i].cond);
+        comp_param[i].quit = false;
         comp_param[i].originbuf = g_try_malloc(TARGET_PAGE_SIZE);
         if (!comp_param[i].originbuf) {
             goto exit;
@@ -499,13 +503,16 @@ static int compress_threads_save_setup(void)
          */
         comp_param[i].file = qemu_fopen_ops(NULL, &empty_ops);
         comp_param[i].done = true;
-        comp_param[i].quit = false;
-        qemu_mutex_init(&comp_param[i].mutex);
-        qemu_cond_init(&comp_param[i].cond);
-        /* TODO: let the further caller handle the error instead of abort() */
-        qemu_thread_create(compress_threads + i, "compress",
-                           do_data_compress, comp_param + i,
-                           QEMU_THREAD_JOINABLE, &error_abort);
+        if (qemu_thread_create(compress_threads + i, "compress",
+                               do_data_compress, comp_param + i,
+                               QEMU_THREAD_JOINABLE, &local_err) < 0) {
+            error_reportf_err(local_err, "failed to create do_data_compress: ");
+            deflateEnd(&comp_param[i].stream);
+            g_free(comp_param[i].originbuf);
+            qemu_fclose(comp_param[i].file);
+            comp_param[i].file = NULL;
+            goto exit;
+        }
     }
     return 0;
 
@@ -1076,9 +1083,14 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
         p->c = QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
         p->running = true;
-        /* TODO: let the further caller handle the error instead of abort() */
-        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE, &error_abort);
+        if (qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
+                               QEMU_THREAD_JOINABLE, &local_err) < 0) {
+            migrate_set_error(migrate_get_current(), local_err);
+            error_reportf_err(local_err,
+                              "failed to create multifd_send_thread: ");
+            multifd_save_cleanup();
+            return;
+        }
 
         atomic_inc(&multifd_send_state->count);
     }
@@ -1357,9 +1369,13 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     p->num_packets = 1;
 
     p->running = true;
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
-                       QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
+                           QEMU_THREAD_JOINABLE, &local_err) < 0) {
+        error_propagate_prepend(errp, local_err,
+                                "failed to create multifd_recv_thread: ");
+        multifd_recv_terminate_threads(local_err);
+        return false;
+    }
     atomic_inc(&multifd_recv_state->count);
     return atomic_read(&multifd_recv_state->count) ==
            migrate_multifd_channels();
@@ -3631,6 +3647,7 @@ static void compress_threads_load_cleanup(void)
 static int compress_threads_load_setup(QEMUFile *f)
 {
     int i, thread_count;
+    Error *local_err = NULL;
 
     if (!migrate_use_compression()) {
         return 0;
@@ -3652,10 +3669,13 @@ static int compress_threads_load_setup(QEMUFile *f)
         qemu_cond_init(&decomp_param[i].cond);
         decomp_param[i].done = true;
         decomp_param[i].quit = false;
-        /* TODO: let the further caller handle the error instead of abort() */
-        qemu_thread_create(decompress_threads + i, "decompress",
-                           do_data_decompress, decomp_param + i,
-                           QEMU_THREAD_JOINABLE, &error_abort);
+        if (qemu_thread_create(decompress_threads + i, "decompress",
+                               do_data_decompress, decomp_param + i,
+                               QEMU_THREAD_JOINABLE, &local_err) < 0) {
+            error_reportf_err(local_err,
+                              "failed to create do_data_decompress: ");
+            goto exit;
+        }
     }
     return 0;
 exit:
diff --git a/migration/savevm.c b/migration/savevm.c
index d5b45843b6..310cecbf8f 100644
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
+    if (qemu_thread_create(&mis->listen_thread, "postcopy/listen",
+                           postcopy_ram_listen_thread, NULL,
+                           QEMU_THREAD_DETACHED, &local_err) < 0) {
+        error_reportf_err(local_err,
+                          "failed to create postcopy_ram_listen_thread: ");
+        qemu_sem_destroy(&mis->listen_thread_sem);
+        return -1;
+    }
     qemu_sem_wait(&mis->listen_thread_sem);
     qemu_sem_destroy(&mis->listen_thread_sem);
 
-- 
2.17.2 (Apple Git-113)
