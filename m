Received: from eggs.gnu.org ([2001:4830:134:3::10]:40353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFnF-00068i-02
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFnC-0004XC-J5
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eZFnC-0004W7-AL
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6246A61D07
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 12:47:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 10 Jan 2018 13:47:16 +0100
Message-Id: <20180110124723.11879-8-quintela@redhat.com>
In-Reply-To: <20180110124723.11879-1-quintela@redhat.com>
References: <20180110124723.11879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 07/14] migration: Create thread
 infrastructure for multifd recv side
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

We make the locking and the transfer of information specific, even if we
are still receiving things through the main thread.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

We split when we create the main channel and where we start the main
migration thread, so we wait for the creation of the other threads.

Use multifd_clear_pages().
Don't remove object_unref()
We use correctly the channel numbres
Denife multifd_new_channel/multifd_recv_thread in this patch, that is
where it is used.
rename migrate_new_channel to migrate_new_send_channel
Add ToDo comment
Add trace
---
 migration/migration.c  |   5 +-
 migration/migration.h  |   1 +
 migration/ram.c        | 129 ++++++++++++++++++++++++++++++++++++++++++++++---
 migration/socket.c     |   3 ++
 migration/trace-events |   2 +
 5 files changed, 132 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 77fc17f723..1545f3a0b0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -406,7 +406,7 @@ static void migration_incoming_setup(QEMUFile *f)
     qemu_file_set_blocking(f, false);
 }
 
-static void migration_incoming_process(void)
+void migration_incoming_process(void)
 {
     Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
     qemu_coroutine_enter(co);
@@ -424,7 +424,8 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
 
     if (!mis->from_src_file) {
         QEMUFile *f = qemu_fopen_channel_input(ioc);
-        migration_fd_process_incoming(f);
+        migration_incoming_setup(f);
+        return;
     }
     multifd_recv_new_channel(ioc);
 }
diff --git a/migration/migration.h b/migration/migration.h
index 29a7b79a39..7de193a9c0 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -172,6 +172,7 @@ void migrate_set_state(int *state, int old_state, int new_state);
 
 void migration_fd_process_incoming(QEMUFile *f);
 void migration_ioc_process_incoming(QIOChannel *ioc);
+void migration_incoming_process(void);
 
 bool  migration_has_all_channels(void);
 
diff --git a/migration/ram.c b/migration/ram.c
index 19c8089c4b..8443806f12 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -660,13 +660,20 @@ static uint16_t multifd_send_page(RAMBlock *block, ram_addr_t offset,
 }
 
 struct MultiFDRecvParams {
+    /* not changed */
     uint8_t id;
     char *name;
     QemuThread thread;
     QIOChannel *c;
+    QemuSemaphore ready;
     QemuSemaphore sem;
     QemuMutex mutex;
+    /* proteced by param mutex */
     bool quit;
+    /* how many patches has sent this channel */
+    uint32_t packets_recv;
+    multifd_pages_t *pages;
+    bool done;
 };
 typedef struct MultiFDRecvParams MultiFDRecvParams;
 
@@ -676,6 +683,7 @@ struct {
     int count;
     /* Should we finish */
     bool quit;
+    multifd_pages_t *pages;
 } *multifd_recv_state;
 
 static void terminate_multifd_recv_threads(Error *errp)
@@ -721,15 +729,51 @@ int multifd_load_cleanup(Error **errp)
         socket_recv_channel_unref(p->c);
         g_free(p->name);
         p->name = NULL;
+        multifd_pages_clear(p->pages);
+        p->pages = NULL;
     }
     g_free(multifd_recv_state->params);
     multifd_recv_state->params = NULL;
+    multifd_pages_clear(multifd_recv_state->pages);
+    multifd_recv_state->pages = NULL;
     g_free(multifd_recv_state);
     multifd_recv_state = NULL;
 
     return ret;
 }
 
+static void *multifd_recv_thread(void *opaque)
+{
+    MultiFDRecvParams *p = opaque;
+
+    qemu_sem_post(&p->ready);
+    while (true) {
+        qemu_mutex_lock(&p->mutex);
+        if (p->quit) {
+            qemu_mutex_unlock(&p->mutex);
+            break;
+        }
+        if (p->pages->used) {
+            p->pages->used = 0;
+
+            trace_multifd_recv(p->id, p->pages->seq, p->pages->used);
+
+            /* ToDo: receive pages here */
+
+            p->done = true;
+            p->packets_recv++;
+            qemu_mutex_unlock(&p->mutex);
+            qemu_sem_post(&p->ready);
+            continue;
+        }
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_wait(&p->sem);
+    }
+    trace_multifd_recv_thread(p->id, p->packets_recv);
+
+    return NULL;
+}
+
 int multifd_load_setup(void)
 {
     int thread_count;
@@ -742,6 +786,8 @@ int multifd_load_setup(void)
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
     multifd_recv_state->count = 0;
     multifd_recv_state->quit = false;
+    multifd_pages_init(&multifd_recv_state->pages,
+                       migrate_multifd_page_count());
     return 0;
 }
 
@@ -752,7 +798,80 @@ int multifd_created_channels(void)
 
 void multifd_recv_new_channel(QIOChannel *ioc)
 {
-    socket_recv_channel_unref(ioc);
+    MultiFDRecvParams *p;
+    MultiFDInit_t msg;
+    Error *local_err = NULL;
+    size_t ret;
+
+    ret = qio_channel_read_all(ioc, (char *)&msg, sizeof(msg), &local_err);
+    if (ret != 0) {
+        terminate_multifd_recv_threads(local_err);
+        return;
+    }
+
+    if (memcmp(msg.uuid, &qemu_uuid, sizeof(qemu_uuid))) {
+        char *uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
+        error_setg(&local_err, "multifd: received uuid '%s' and expected "
+                   "uuid '%s' for channel %hhd", msg.uuid, uuid, msg.id);
+        g_free(uuid);
+        terminate_multifd_recv_threads(local_err);
+        return;
+    }
+
+    p = &multifd_recv_state->params[msg.id];
+    if (p->id != 0) {
+        error_setg(&local_err, "multifd: received id '%d' already setup'",
+                   msg.id);
+        terminate_multifd_recv_threads(local_err);
+        return;
+    }
+    qemu_mutex_init(&p->mutex);
+    qemu_sem_init(&p->sem, 0);
+    qemu_sem_init(&p->ready, 0);
+    p->quit = false;
+    p->id = msg.id;
+    p->done = false;
+    multifd_pages_init(&p->pages, migrate_multifd_page_count());
+    p->c = ioc;
+    multifd_recv_state->count++;
+    p->name = g_strdup_printf("multifdrecv_%d", msg.id);
+    socket_recv_channel_ref(ioc);
+
+    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
+                       QEMU_THREAD_JOINABLE);
+    if (multifd_recv_state->count == migrate_multifd_channels()) {
+        migration_incoming_process();
+    }
+}
+
+static void multifd_recv_page(RAMBlock *block, ram_addr_t offset,
+                              uint8_t *address, uint16_t fd_num)
+{
+    int thread_count;
+    MultiFDRecvParams *p;
+    multifd_pages_t *pages = multifd_recv_state->pages;
+
+    pages->iov[pages->used].iov_base = address;
+    pages->iov[pages->used].iov_len = TARGET_PAGE_SIZE;
+    pages->used++;
+
+    if (fd_num == MULTIFD_CONTINUE) {
+        return;
+    }
+
+    thread_count = migrate_multifd_channels();
+    assert(fd_num < thread_count);
+    p = &multifd_recv_state->params[fd_num];
+
+    qemu_sem_wait(&p->ready);
+
+    qemu_mutex_lock(&p->mutex);
+    p->done = false;
+    p->pages->used = 0;
+    multifd_recv_state->pages = p->pages;
+    p->pages = pages;
+    qemu_mutex_unlock(&p->mutex);
+    qemu_sem_post(&p->sem);
 }
 
 /**
@@ -3042,6 +3161,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     }
 
     while (!postcopy_running && !ret && !(flags & RAM_SAVE_FLAG_EOS)) {
+        RAMBlock *block = NULL;
         ram_addr_t addr, total_ram_bytes;
         void *host = NULL;
         uint16_t fd_num;
@@ -3066,7 +3186,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
                      RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE |
                      RAM_SAVE_FLAG_MULTIFD_PAGE)) {
-            RAMBlock *block = ram_block_from_stream(f, flags);
+            block = ram_block_from_stream(f, flags);
 
             host = host_from_ram_block_offset(block, addr);
             if (!host) {
@@ -3157,10 +3277,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 
         case RAM_SAVE_FLAG_MULTIFD_PAGE:
             fd_num = qemu_get_be16(f);
-            if (fd_num != 0) {
-                /* this is yet an unused variable, changed later */
-                fd_num = fd_num;
-            }
+            multifd_recv_page(block, addr, host, fd_num);
             qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
             break;
 
diff --git a/migration/socket.c b/migration/socket.c
index aedabee8a1..ba23442175 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -192,6 +192,9 @@ out:
     if (migration_has_all_channels()) {
         /* Close listening socket as its no longer needed */
         qio_channel_close(ioc, NULL);
+        if (!migrate_use_multifd()) {
+            migration_incoming_process();
+        }
         return G_SOURCE_REMOVE;
     } else {
         return G_SOURCE_CONTINUE;
diff --git a/migration/trace-events b/migration/trace-events
index 61ee21a13e..06aef4d4a3 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -77,7 +77,9 @@ ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
 ram_postcopy_send_discard_bitmap(void) ""
 ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%" PRIx64 " host: %p"
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
+multifd_recv(char id, int seq, int num) "channel %d sequence %d num pages %d"
 multifd_send(char id, int seq, int num) "channel %d sequence %d num pages %d"
+multifd_recv_thread(char id, uint32_t packets) "channel %d packets %d"
 multifd_send_thread(char id, uint32_t packets) "channel %d packets %d"
 
 # migration/migration.c
-- 
2.14.3
