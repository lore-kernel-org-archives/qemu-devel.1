Received: from eggs.gnu.org ([2001:4830:134:3::10]:34010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvAaA-0005kl-Pb
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvAa9-0001Wb-0P
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dvAa8-0001VZ-O9
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DEABD267C4
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 23:08:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 22 Sep 2017 01:08:02 +0200
Message-Id: <20170921230812.7095-9-quintela@redhat.com>
In-Reply-To: <20170921230812.7095-1-quintela@redhat.com>
References: <20170921230812.7095-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 08/18] migration: Create multifd migration
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Creation of the threads, nothing inside yet.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--

Use pointers instead of long array names
Move to use semaphores instead of conditions as paolo suggestion

Put all the state inside one struct.
Use a counter for the number of threads created.  Needed during cancellation.

Add error return to thread creation

Add id field

Rename functions to multifd_save/load_setup/cleanup
Change recv parameters to a pointer to struct
Change back to a struct
Use Error * for _cleanup
---
 migration/migration.c |  26 +++++++
 migration/ram.c       | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++
 migration/ram.h       |   5 ++
 3 files changed, 233 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 494c6eb435..336da038f5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -281,6 +281,10 @@ static void process_incoming_migration_bh(void *opaque)
      */
     qemu_announce_self();
 
+    if (multifd_load_cleanup(&local_err) != 0) {
+        error_report_err(local_err);
+        autostart = false;
+    }
     /* If global state section was not received or we are in running
        state, we need to obey autostart. Any other state is set with
        runstate_set. */
@@ -353,10 +357,15 @@ static void process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
+        Error *local_err = NULL;
+
         migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_FAILED);
         error_report("load of migration failed: %s", strerror(-ret));
         qemu_fclose(mis->from_src_file);
+        if (multifd_load_cleanup(&local_err) != 0) {
+            error_report_err(local_err);
+        }
         exit(EXIT_FAILURE);
     }
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
@@ -368,6 +377,12 @@ void migration_fd_process_incoming(QEMUFile *f)
     Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    if (multifd_load_setup() != 0) {
+        /* We haven't been able to create multifd threads
+           nothing better to do */
+        exit(EXIT_FAILURE);
+    }
+
     if (!mis->from_src_file) {
         mis->from_src_file = f;
     }
@@ -1020,6 +1035,8 @@ static void migrate_fd_cleanup(void *opaque)
     s->cleanup_bh = NULL;
 
     if (s->to_dst_file) {
+        Error *local_err = NULL;
+
         trace_migrate_fd_cleanup();
         qemu_mutex_unlock_iothread();
         if (s->migration_thread_running) {
@@ -1028,6 +1045,9 @@ static void migrate_fd_cleanup(void *opaque)
         }
         qemu_mutex_lock_iothread();
 
+        if (multifd_save_cleanup(&local_err) != 0) {
+            error_report_err(local_err);
+        }
         qemu_fclose(s->to_dst_file);
         s->to_dst_file = NULL;
     }
@@ -2217,6 +2237,12 @@ void migrate_fd_connect(MigrationState *s)
         }
     }
 
+    if (multifd_save_setup() != 0) {
+        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
+                          MIGRATION_STATUS_FAILED);
+        migrate_fd_cleanup(s);
+        return;
+    }
     qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
                        QEMU_THREAD_JOINABLE);
     s->migration_thread_running = true;
diff --git a/migration/ram.c b/migration/ram.c
index e18b3e2d4f..bb369e72d4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -356,6 +356,208 @@ static void compress_threads_save_setup(void)
     }
 }
 
+/* Multiple fd's */
+
+struct MultiFDSendParams {
+    uint8_t id;
+    char *name;
+    QemuThread thread;
+    QemuSemaphore sem;
+    QemuMutex mutex;
+    bool quit;
+};
+typedef struct MultiFDSendParams MultiFDSendParams;
+
+struct {
+    MultiFDSendParams *params;
+    /* number of created threads */
+    int count;
+} *multifd_send_state;
+
+static void terminate_multifd_send_threads(Error *errp)
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
+int multifd_save_cleanup(Error **errp)
+{
+    int i;
+    int ret = 0;
+
+    if (!migrate_use_multifd()) {
+        return 0;
+    }
+    terminate_multifd_send_threads(NULL);
+    for (i = 0; i < multifd_send_state->count; i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+
+        qemu_thread_join(&p->thread);
+        qemu_mutex_destroy(&p->mutex);
+        qemu_sem_destroy(&p->sem);
+        g_free(p->name);
+        p->name = NULL;
+    }
+    g_free(multifd_send_state->params);
+    multifd_send_state->params = NULL;
+    g_free(multifd_send_state);
+    multifd_send_state = NULL;
+    return ret;
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
+int multifd_save_setup(void)
+{
+    int thread_count;
+    uint8_t i;
+
+    if (!migrate_use_multifd()) {
+        return 0;
+    }
+    thread_count = migrate_multifd_channels();
+    multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
+    multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
+    multifd_send_state->count = 0;
+    for (i = 0; i < thread_count; i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+
+        qemu_mutex_init(&p->mutex);
+        qemu_sem_init(&p->sem, 0);
+        p->quit = false;
+        p->id = i;
+        p->name = g_strdup_printf("multifdsend_%d", i);
+        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
+                           QEMU_THREAD_JOINABLE);
+
+        multifd_send_state->count++;
+    }
+    return 0;
+}
+
+struct MultiFDRecvParams {
+    uint8_t id;
+    char *name;
+    QemuThread thread;
+    QemuSemaphore sem;
+    QemuMutex mutex;
+    bool quit;
+};
+typedef struct MultiFDRecvParams MultiFDRecvParams;
+
+struct {
+    MultiFDRecvParams *params;
+    /* number of created threads */
+    int count;
+} *multifd_recv_state;
+
+static void terminate_multifd_recv_threads(Error *errp)
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
+int multifd_load_cleanup(Error **errp)
+{
+    int i;
+    int ret = 0;
+
+    if (!migrate_use_multifd()) {
+        return 0;
+    }
+    terminate_multifd_recv_threads(NULL);
+    for (i = 0; i < multifd_recv_state->count; i++) {
+        MultiFDRecvParams *p = &multifd_recv_state->params[i];
+
+        qemu_thread_join(&p->thread);
+        qemu_mutex_destroy(&p->mutex);
+        qemu_sem_destroy(&p->sem);
+        g_free(p->name);
+        p->name = NULL;
+    }
+    g_free(multifd_recv_state->params);
+    multifd_recv_state->params = NULL;
+    g_free(multifd_recv_state);
+    multifd_recv_state = NULL;
+
+    return ret;
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
+int multifd_load_setup(void)
+{
+    int thread_count;
+    uint8_t i;
+
+    if (!migrate_use_multifd()) {
+        return 0;
+    }
+    thread_count = migrate_multifd_channels();
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
+        p->name = g_strdup_printf("multifdrecv_%d", i);
+        qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
+                           QEMU_THREAD_JOINABLE);
+        multifd_recv_state->count++;
+    }
+    return 0;
+}
+
 /**
  * save_page_header: write page header to wire
  *
diff --git a/migration/ram.h b/migration/ram.h
index c081fde86c..4a72d66503 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -39,6 +39,11 @@ int64_t xbzrle_cache_resize(int64_t new_size);
 uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
 
+int multifd_save_setup(void);
+int multifd_save_cleanup(Error **errp);
+int multifd_load_setup(void);
+int multifd_load_cleanup(Error **errp);
+
 uint64_t ram_pagesize_summary(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
-- 
2.13.5
