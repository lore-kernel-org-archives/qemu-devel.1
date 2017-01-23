Received: from eggs.gnu.org ([2001:4830:134:3::10]:33766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEC-0002ER-Aw
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEA-00036L-S5
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmEA-00036B-JQ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:38 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFFAB3D944
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:12 +0100
Message-Id: <1485207141-1941-9-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-1-git-send-email-quintela@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 08/17] migration: create multifd migration
 threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

Creation of the threads, nothing inside yet.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h |   4 ++
 migration/migration.c         |   6 ++
 migration/ram.c               | 150 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 515569d..f119ba0 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -249,6 +249,10 @@ MigrationState *migrate_get_current(void);

 int migrate_multifd_threads(void);
 int migrate_multifd_group(void);
+void migrate_multifd_send_threads_create(void);
+void migrate_multifd_send_threads_join(void);
+void migrate_multifd_recv_threads_create(void);
+void migrate_multifd_recv_threads_join(void);

 void migrate_compress_threads_create(void);
 void migrate_compress_threads_join(void);
diff --git a/migration/migration.c b/migration/migration.c
index 9bde01b..ab48f06 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -344,6 +344,7 @@ static void process_incoming_migration_bh(void *opaque)
                           MIGRATION_STATUS_FAILED);
         error_report_err(local_err);
         migrate_decompress_threads_join();
+        migrate_multifd_recv_threads_join();
         exit(EXIT_FAILURE);
     }

@@ -368,6 +369,7 @@ static void process_incoming_migration_bh(void *opaque)
         runstate_set(global_state_get_runstate());
     }
     migrate_decompress_threads_join();
+    migrate_multifd_recv_threads_join();
     /*
      * This must happen after any state changes since as soon as an external
      * observer sees this event they might start to prod at the VM assuming
@@ -433,6 +435,7 @@ static void process_incoming_migration_co(void *opaque)
                           MIGRATION_STATUS_FAILED);
         error_report("load of migration failed: %s", strerror(-ret));
         migrate_decompress_threads_join();
+        migrate_multifd_recv_threads_join();
         exit(EXIT_FAILURE);
     }

@@ -445,6 +448,7 @@ void migration_fd_process_incoming(QEMUFile *f)
     Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, f);

     migrate_decompress_threads_create();
+    migrate_multifd_recv_threads_create();
     qemu_file_set_blocking(f, false);
     qemu_coroutine_enter(co);
 }
@@ -974,6 +978,7 @@ static void migrate_fd_cleanup(void *opaque)
         qemu_mutex_lock_iothread();

         migrate_compress_threads_join();
+        migrate_multifd_send_threads_join();
         qemu_fclose(s->to_dst_file);
         s->to_dst_file = NULL;
     }
@@ -2020,6 +2025,7 @@ void migrate_fd_connect(MigrationState *s)
     }

     migrate_compress_threads_create();
+    migrate_multifd_send_threads_create();
     qemu_thread_create(&s->thread, "migration", migration_thread, s,
                        QEMU_THREAD_JOINABLE);
     s->migration_thread_running = true;
diff --git a/migration/ram.c b/migration/ram.c
index cea213e..939f364 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -382,6 +382,156 @@ void migrate_compress_threads_create(void)
     }
 }

+/* Multiple fd's */
+
+struct MultiFDSendParams {
+    QemuThread thread;
+    QemuCond cond;
+    QemuMutex mutex;
+    bool quit;
+};
+typedef struct MultiFDSendParams MultiFDSendParams;
+
+static MultiFDSendParams *multifd_send;
+
+static void *multifd_send_thread(void *opaque)
+{
+    MultiFDSendParams *params = opaque;
+
+    qemu_mutex_lock(&params->mutex);
+    while (!params->quit){
+        qemu_cond_wait(&params->cond, &params->mutex);
+    }
+    qemu_mutex_unlock(&params->mutex);
+
+    return NULL;
+}
+
+static void terminate_multifd_send_threads(void)
+{
+    int i, thread_count;
+
+    thread_count = migrate_multifd_threads();
+    for (i = 0; i < thread_count; i++) {
+        qemu_mutex_lock(&multifd_send[i].mutex);
+        multifd_send[i].quit = true;
+        qemu_cond_signal(&multifd_send[i].cond);
+        qemu_mutex_unlock(&multifd_send[i].mutex);
+    }
+}
+
+void migrate_multifd_send_threads_join(void)
+{
+    int i, thread_count;
+
+    if (!migrate_use_multifd()) {
+        return;
+    }
+    terminate_multifd_send_threads();
+    thread_count = migrate_multifd_threads();
+    for (i = 0; i < thread_count; i++) {
+        qemu_thread_join(&multifd_send[i].thread);
+        qemu_mutex_destroy(&multifd_send[i].mutex);
+        qemu_cond_destroy(&multifd_send[i].cond);
+    }
+    g_free(multifd_send);
+    multifd_send = NULL;
+}
+
+void migrate_multifd_send_threads_create(void)
+{
+    int i, thread_count;
+
+    if (!migrate_use_multifd()) {
+        return;
+    }
+    thread_count = migrate_multifd_threads();
+    multifd_send = g_new0(MultiFDSendParams, thread_count);
+    for (i = 0; i < thread_count; i++) {
+        char thread_name[15];
+        qemu_mutex_init(&multifd_send[i].mutex);
+        qemu_cond_init(&multifd_send[i].cond);
+        multifd_send[i].quit = false;
+        snprintf(thread_name, 15, "multifd_send_%d", i);
+        qemu_thread_create(&multifd_send[i].thread, thread_name,
+                           multifd_send_thread, &multifd_send[i],
+                           QEMU_THREAD_JOINABLE);
+    }
+}
+
+struct MultiFDRecvParams {
+    QemuThread thread;
+    QemuCond cond;
+    QemuMutex mutex;
+    bool quit;
+};
+typedef struct MultiFDRecvParams MultiFDRecvParams;
+
+static MultiFDRecvParams *multifd_recv;
+
+static void *multifd_recv_thread(void *opaque)
+{
+    MultiFDRecvParams *params = opaque;
+ 
+    qemu_mutex_lock(&params->mutex);
+    while (!params->quit){
+        qemu_cond_wait(&params->cond, &params->mutex);
+    }
+    qemu_mutex_unlock(&params->mutex);
+
+    return NULL;
+}
+
+static void terminate_multifd_recv_threads(void)
+{
+    int i, thread_count;
+
+    thread_count = migrate_multifd_threads();
+    for (i = 0; i < thread_count; i++) {
+        qemu_mutex_lock(&multifd_recv[i].mutex);
+        multifd_recv[i].quit = true;
+        qemu_cond_signal(&multifd_recv[i].cond);
+        qemu_mutex_unlock(&multifd_recv[i].mutex);
+    }
+}
+
+void migrate_multifd_recv_threads_join(void)
+{
+    int i, thread_count;
+
+    if (!migrate_use_multifd()) {
+        return;
+    }
+    terminate_multifd_recv_threads();
+    thread_count = migrate_multifd_threads();
+    for (i = 0; i < thread_count; i++) {
+        qemu_thread_join(&multifd_recv[i].thread);
+        qemu_mutex_destroy(&multifd_recv[i].mutex);
+        qemu_cond_destroy(&multifd_recv[i].cond);
+    }
+    g_free(multifd_recv);
+    multifd_recv = NULL;
+}
+
+void migrate_multifd_recv_threads_create(void)
+{
+    int i, thread_count;
+
+    if (!migrate_use_multifd()) {
+        return;
+    }
+    thread_count = migrate_multifd_threads();
+    multifd_recv = g_new0(MultiFDRecvParams, thread_count);
+    for (i = 0; i < thread_count; i++) {
+        qemu_mutex_init(&multifd_recv[i].mutex);
+        qemu_cond_init(&multifd_recv[i].cond);
+        multifd_recv[i].quit = false;
+        qemu_thread_create(&multifd_recv[i].thread, "multifd_recv",
+                           multifd_recv_thread, &multifd_recv[i],
+                           QEMU_THREAD_JOINABLE);
+    }
+}
+
 /**
  * save_page_header: Write page header to wire
  *
-- 
2.9.3
