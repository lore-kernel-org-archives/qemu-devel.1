Received: from eggs.gnu.org ([2001:4830:134:3::10]:56477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLH-0004Mv-WE
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLG-0005uU-Ov
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnPLG-0005u6-Go
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:50 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4CAF61BB9
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 12:44:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Mar 2017 13:44:26 +0100
Message-Id: <20170313124434.1043-9-quintela@redhat.com>
In-Reply-To: <20170313124434.1043-1-quintela@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 08/16] migration: Create multifd migration
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

--

Use pointers instead of long array names
Move to use semaphores instead of conditions as paolo suggestion

Put all the state inside one struct.
Use a counter for the number of threads created.  Needed during cancellation.

Add error return to thread creation

Add id field

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |   4 +
 migration/migration.c         |  15 ++++
 migration/ram.c               | 188 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index bacde15..e8b9fcb 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -267,6 +267,10 @@ MigrationState *migrate_get_current(void);
 
 int migrate_multifd_threads(void);
 int migrate_multifd_group(void);
+int migrate_multifd_send_threads_create(void);
+void migrate_multifd_send_threads_join(void);
+int migrate_multifd_recv_threads_create(void);
+void migrate_multifd_recv_threads_join(void);
 
 void migrate_compress_threads_create(void);
 void migrate_compress_threads_join(void);
diff --git a/migration/migration.c b/migration/migration.c
index 4cc45a4..5bbd688 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -348,6 +348,7 @@ static void process_incoming_migration_bh(void *opaque)
                           MIGRATION_STATUS_FAILED);
         error_report_err(local_err);
         migrate_decompress_threads_join();
+        migrate_multifd_recv_threads_join();
         exit(EXIT_FAILURE);
     }
 
@@ -372,6 +373,7 @@ static void process_incoming_migration_bh(void *opaque)
         runstate_set(global_state_get_runstate());
     }
     migrate_decompress_threads_join();
+    migrate_multifd_recv_threads_join();
     /*
      * This must happen after any state changes since as soon as an external
      * observer sees this event they might start to prod at the VM assuming
@@ -438,6 +440,7 @@ static void process_incoming_migration_co(void *opaque)
                           MIGRATION_STATUS_FAILED);
         error_report("load of migration failed: %s", strerror(-ret));
         migrate_decompress_threads_join();
+        migrate_multifd_recv_threads_join();
         exit(EXIT_FAILURE);
     }
 
@@ -450,6 +453,11 @@ void migration_fd_process_incoming(QEMUFile *f)
     Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, f);
 
     migrate_decompress_threads_create();
+    if (migrate_multifd_recv_threads_create() != 0) {
+        /* We haven't been able to create multifd threads
+           nothing better to do */
+        exit(EXIT_FAILURE);
+    }
     qemu_file_set_blocking(f, false);
     qemu_coroutine_enter(co);
 }
@@ -983,6 +991,7 @@ static void migrate_fd_cleanup(void *opaque)
         qemu_mutex_lock_iothread();
 
         migrate_compress_threads_join();
+        migrate_multifd_send_threads_join();
         qemu_fclose(s->to_dst_file);
         s->to_dst_file = NULL;
     }
@@ -2144,6 +2153,12 @@ void migrate_fd_connect(MigrationState *s)
     }
 
     migrate_compress_threads_create();
+    if (migrate_multifd_send_threads_create() != 0) {
+        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
+                          MIGRATION_STATUS_FAILED);
+        migrate_fd_cleanup(s);
+        return;
+    }
     qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
                        QEMU_THREAD_JOINABLE);
     s->migration_thread_running = true;
diff --git a/migration/ram.c b/migration/ram.c
index aa51dbd..ee32fa8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -382,6 +382,194 @@ void migrate_compress_threads_create(void)
     }
 }
 
+/* Multiple fd's */
+
+struct MultiFDSendParams {
+    int id;
+    QemuThread thread;
+    QemuSemaphore sem;
+    QemuMutex mutex;
+    bool quit;
+};
+typedef struct MultiFDSendParams MultiFDSendParams;
+
+struct {
+    MultiFDSendParams *params;
+    /* number o6 created threads */
+    int count;
+} *multifd_send_state;
+
+static void terminate_multifd_send_threads(void)
+{
+    int i;
+
+    for (i = 0; i < multifd_send_state->count; i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
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
+    int i;
+
+    if (!migrate_use_multifd()) {
+        return;
+    }
+    terminate_multifd_send_threads();
+    for (i = 0; i < multifd_send_state->count; i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+
+        qemu_thread_join(&p->thread);
+        qemu_mutex_destroy(&p->mutex);
+        qemu_sem_destroy(&p->sem);
+    }
+    g_free(multifd_send_state->params);
+    multifd_send_state->params = NULL;
+    g_free(multifd_send_state);
+    multifd_send_state = NULL;
+}
+
+static void *multifd_send_thread(void *opaque)
+{
+    MultiFDSendParams *p = opaque;
+
+    while (true) {
+        qemu_mutex_lock(&p->mutex);
+        if (p->quit) {
+            qemu_mutex_unlock(&p->mutex);
+            break;
+        }
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_wait(&p->sem);
+    }
+
+    return NULL;
+}
+
+int migrate_multifd_send_threads_create(void)
+{
+    int i, thread_count;
+
+    if (!migrate_use_multifd()) {
+        return 0;
+    }
+    thread_count = migrate_multifd_threads();
+    multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
+    multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
+    multifd_send_state->count = 0;
+    for (i = 0; i < thread_count; i++) {
+        char thread_name[15];
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+
+        qemu_mutex_init(&p->mutex);
+        qemu_sem_init(&p->sem, 0);
+        p->quit = false;
+        p->id = i;
+        snprintf(thread_name, 15, "multifd_send_%d", i);
+        qemu_thread_create(&p->thread, thread_name, multifd_send_thread, p,
+                           QEMU_THREAD_JOINABLE);
+        multifd_send_state->count++;
+    }
+    return 0;
+}
+
+struct MultiFDRecvParams {
+    int id;
+    QemuThread thread;
+    QemuSemaphore sem;
+    QemuMutex mutex;
+    bool quit;
+};
+typedef struct MultiFDRecvParams MultiFDRecvParams;
+
+struct {
+    MultiFDRecvParams *params;
+    /* number o6 created threads */
+    int count;
+} *multifd_recv_state;
+
+static void terminate_multifd_recv_threads(void)
+{
+    int i;
+
+    for (i = 0; i < multifd_recv_state->count; i++) {
+        MultiFDRecvParams *p = &multifd_recv_state->params[i];
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
+    int i;
+
+    if (!migrate_use_multifd()) {
+        return;
+    }
+    terminate_multifd_recv_threads();
+    for (i = 0; i < multifd_recv_state->count; i++) {
+        MultiFDRecvParams *p = &multifd_recv_state->params[i];
+
+        qemu_thread_join(&p->thread);
+        qemu_mutex_destroy(&p->mutex);
+        qemu_sem_destroy(&p->sem);
+    }
+    g_free(multifd_recv_state->params);
+    multifd_recv_state->params = NULL;
+    g_free(multifd_recv_state);
+    multifd_recv_state = NULL;
+}
+
+static void *multifd_recv_thread(void *opaque)
+{
+    MultiFDRecvParams *p = opaque;
+
+    while (true) {
+        qemu_mutex_lock(&p->mutex);
+        if (p->quit) {
+            qemu_mutex_unlock(&p->mutex);
+            break;
+        }
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_wait(&p->sem);
+    }
+
+    return NULL;
+}
+
+int migrate_multifd_recv_threads_create(void)
+{
+    int i, thread_count;
+
+    if (!migrate_use_multifd()) {
+        return 0;
+    }
+    thread_count = migrate_multifd_threads();
+    multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
+    multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
+    multifd_recv_state->count = 0;
+    for (i = 0; i < thread_count; i++) {
+        MultiFDRecvParams *p = &multifd_recv_state->params[i];
+
+        qemu_mutex_init(&p->mutex);
+        qemu_sem_init(&p->sem, 0);
+        p->quit = false;
+        p->id = i;
+        qemu_thread_create(&p->thread, "multifd_recv", multifd_recv_thread, p,
+                           QEMU_THREAD_JOINABLE);
+        multifd_recv_state->count++;
+    }
+    return 0;
+}
+
 /**
  * save_page_header: Write page header to wire
  *
-- 
2.9.3
