Received: from eggs.gnu.org ([2001:4830:134:3::10]:57800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIM-000815-7q
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIK-0004w5-AS
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdKIK-0004va-1J
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:08 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F464128D
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 17:20:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Feb 2017 18:19:42 +0100
Message-Id: <1487006388-7966-7-git-send-email-quintela@redhat.com>
In-Reply-To: <1487006388-7966-1-git-send-email-quintela@redhat.com>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 06/12] migration: Create multifd migration
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

--

Use pointers instead of long array names
Move to use semaphores instead of conditions as paolo suggestion
---
 include/migration/migration.h |   4 +
 migration/migration.c         |   6 ++
 migration/ram.c               | 168 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 3c7f165..13fac75 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -256,6 +256,10 @@ MigrationState *migrate_get_current(void);

 int migrate_multifd_threads(void);
 int migrate_multifd_group(void);
+void migrate_multifd_send_threads_create(void);
+void migrate_multifd_send_threads_join(void);
+void migrate_multifd_recv_threads_create(void);
+void migrate_multifd_recv_threads_join(void);

 void migrate_compress_threads_create(void);
 void migrate_compress_threads_join(void);
diff --git a/migration/migration.c b/migration/migration.c
index 2b2d0a8..d2705d7 100644
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
@@ -2100,6 +2105,7 @@ void migrate_fd_connect(MigrationState *s)
     }

     migrate_compress_threads_create();
+    migrate_multifd_send_threads_create();
     qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
                        QEMU_THREAD_JOINABLE);
     s->migration_thread_running = true;
diff --git a/migration/ram.c b/migration/ram.c
index 4422ee8..0cb19cf 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -382,6 +382,174 @@ void migrate_compress_threads_create(void)
     }
 }

+/* Multiple fd's */
+
+struct MultiFDSendParams {
+    QemuThread thread;
+    QemuSemaphore sem;
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
+    while (true) {
+        qemu_mutex_lock(&params->mutex);
+        if (params->quit) {
+            qemu_mutex_unlock(&params->mutex);
+            break;
+        }
+        qemu_mutex_unlock(&params->mutex);
+        qemu_sem_wait(&params->sem);
+    }
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
+        MultiFDSendParams *p = &multifd_send[i];
+
+        qemu_mutex_lock(&p->mutex);
+        p->quit = true;
+        qemu_sem_post(&p->sem);
+        qemu_mutex_unlock(&p->mutex);
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
+        MultiFDSendParams *p = &multifd_send[i];
+
+        qemu_thread_join(&p->thread);
+        qemu_mutex_destroy(&p->mutex);
+        qemu_sem_destroy(&p->sem);
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
+        MultiFDSendParams *p = &multifd_send[i];
+
+        qemu_mutex_init(&p->mutex);
+        qemu_sem_init(&p->sem, 0);
+        p->quit = false;
+        snprintf(thread_name, 15, "multifd_send_%d", i);
+        qemu_thread_create(&p->thread, thread_name, multifd_send_thread, p,
+                           QEMU_THREAD_JOINABLE);
+    }
+}
+
+struct MultiFDRecvParams {
+    QemuThread thread;
+    QemuSemaphore sem;
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
+    while (true) {
+        qemu_mutex_lock(&params->mutex);
+        if (params->quit) {
+            qemu_mutex_unlock(&params->mutex);
+            break;
+        }
+        qemu_mutex_unlock(&params->mutex);
+        qemu_sem_wait(&params->sem);
+    }
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
+        MultiFDRecvParams *p = &multifd_recv[i];
+
+        qemu_mutex_lock(&p->mutex);
+        p->quit = true;
+        qemu_sem_post(&p->sem);
+        qemu_mutex_unlock(&p->mutex);
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
+        MultiFDRecvParams *p = &multifd_recv[i];
+
+        qemu_thread_join(&p->thread);
+        qemu_mutex_destroy(&p->mutex);
+        qemu_sem_destroy(&p->sem);
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
+        MultiFDRecvParams *p = &multifd_recv[i];
+
+        qemu_mutex_init(&p->mutex);
+        qemu_sem_init(&p->sem, 0);
+        p->quit = false;
+        qemu_thread_create(&p->thread, "multifd_recv", multifd_recv_thread, p,
+                           QEMU_THREAD_JOINABLE);
+    }
+}
+
 /**
  * save_page_header: Write page header to wire
  *
-- 
2.7.4
