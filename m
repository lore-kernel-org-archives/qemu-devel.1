Received: from eggs.gnu.org ([2001:4830:134:3::10]:59214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwP-0006mt-PA
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwO-0002im-1I
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ewnwN-0002iI-Rw
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 572B18151D47
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:54:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 16 Mar 2018 12:54:01 +0100
Message-Id: <20180316115403.4148-14-quintela@redhat.com>
In-Reply-To: <20180316115403.4148-1-quintela@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v11 13/15] migration: Create ram_multifd_page
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

The function still don't use multifd, but we have simplified
ram_save_page, xbzrle and RDMA stuff is gone.  We have added a new
counter.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--
Add last_page parameter
Add commets for done and address
Remove multifd field, it is the same than normal pages
Merge next patch, now we send multiple pages at a time
Remove counter for multifd pages, it is identical to normal pages
Use iovec's instead of creating the equivalent.
Clear memory used by pages (dave)
Use g_new0(danp)
define MULTIFD_CONTINUE
now pages member is a pointer
Fix off-by-one in number of pages in one packet
Remove RAM_SAVE_FLAG_MULTIFD_PAGE
s/multifd_pages_t/MultiFDPages_t/
---
 migration/ram.c        | 148 ++++++++++++++++++++++++++++++++++++++++++++++++-
 migration/trace-events |   3 +-
 2 files changed, 149 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index dd77c78016..9919777a21 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -54,6 +54,7 @@
 #include "migration/block.h"
 #include "sysemu/sysemu.h"
 #include "qemu/uuid.h"
+#include "qemu/iov.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -407,7 +408,22 @@ typedef struct {
     uint8_t id;
 } __attribute__((packed)) MultiFDInit_t;
 
+typedef struct {
+    /* number of used pages */
+    uint32_t used;
+    /* number of allocated pages */
+    uint32_t allocated;
+    /* global number of generated multifd packets */
+    uint32_t seq;
+    /* offset of each page */
+    ram_addr_t *offset;
+    /* pointer to each page */
+    struct iovec *iov;
+    RAMBlock *block;
+} MultiFDPages_t;
+
 struct MultiFDSendParams {
+    /* not changed */
     uint8_t id;
     char *name;
     QemuThread thread;
@@ -415,8 +431,15 @@ struct MultiFDSendParams {
     QemuSemaphore sem;
     QemuMutex mutex;
     bool running;
+    /* protected by param mutex */
     bool quit;
     bool sync;
+    MultiFDPages_t *pages;
+    /* how many patches has sent this channel */
+    uint32_t packets_sent;
+    /* protected by multifd mutex */
+    /* has the thread finish the last submitted job */
+    bool done;
 };
 typedef struct MultiFDSendParams MultiFDSendParams;
 
@@ -485,8 +508,34 @@ struct {
     int count;
     /* syncs main thread and channels */
     QemuSemaphore sem_main;
+    QemuMutex mutex;
+    QemuSemaphore sem;
+    MultiFDPages_t *pages;
 } *multifd_send_state;
 
+static void multifd_pages_init(MultiFDPages_t **ppages, size_t size)
+{
+    MultiFDPages_t *pages = g_new0(MultiFDPages_t, 1);
+
+    pages->allocated = size;
+    pages->iov = g_new0(struct iovec, size);
+    pages->offset = g_new0(ram_addr_t, size);
+    *ppages = pages;
+}
+
+static void multifd_pages_clear(MultiFDPages_t *pages)
+{
+    pages->used = 0;
+    pages->allocated = 0;
+    pages->seq = 0;
+    pages->block = NULL;
+    g_free(pages->iov);
+    pages->iov = NULL;
+    g_free(pages->offset);
+    pages->offset = NULL;
+    g_free(pages);
+}
+
 static void multifd_send_terminate_threads(Error *errp)
 {
     int i;
@@ -532,10 +581,14 @@ int multifd_save_cleanup(Error **errp)
         qemu_sem_destroy(&p->sem);
         g_free(p->name);
         p->name = NULL;
+        multifd_pages_clear(p->pages);
+        p->pages = NULL;
     }
     qemu_sem_destroy(&multifd_send_state->sem_main);
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
+    multifd_pages_clear(multifd_send_state->pages);
+    multifd_send_state->pages = NULL;
     g_free(multifd_send_state);
     multifd_send_state = NULL;
     return ret;
@@ -586,6 +639,7 @@ static void *multifd_send_thread(void *opaque)
         multifd_send_terminate_threads(local_err);
         return NULL;
     }
+    qemu_sem_post(&multifd_send_state->sem);
 
     while (true) {
         qemu_sem_wait(&p->sem);
@@ -601,9 +655,23 @@ static void *multifd_send_thread(void *opaque)
             qemu_mutex_unlock(&p->mutex);
             break;
         }
+        if (p->pages->used) {
+            p->pages->used = 0;
+            qemu_mutex_unlock(&p->mutex);
+
+            trace_multifd_send(p->id, p->pages->seq, p->pages->used);
+            /* ToDo: send page here */
+
+            qemu_mutex_lock(&multifd_send_state->mutex);
+            p->done = true;
+            p->packets_sent++;
+            qemu_mutex_unlock(&multifd_send_state->mutex);
+            qemu_sem_post(&multifd_send_state->sem);
+            continue;
+        }
         qemu_mutex_unlock(&p->mutex);
     }
-    trace_multifd_send_thread_end(p->id);
+    trace_multifd_send_thread_end(p->id, p->packets_sent);
 
     return NULL;
 }
@@ -630,6 +698,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 int multifd_save_setup(void)
 {
     int thread_count;
+    uint32_t page_count = migrate_multifd_page_count();
     uint8_t i;
 
     if (!migrate_use_multifd()) {
@@ -640,6 +709,9 @@ int multifd_save_setup(void)
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
     atomic_set(&multifd_send_state->count, 0);
     qemu_sem_init(&multifd_send_state->sem_main, 0);
+    qemu_mutex_init(&multifd_send_state->mutex);
+    qemu_sem_init(&multifd_send_state->sem, 0);
+    multifd_pages_init(&multifd_send_state->pages, page_count);
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
@@ -648,6 +720,8 @@ int multifd_save_setup(void)
         qemu_sem_init(&p->sem, 0);
         p->quit = false;
         p->id = i;
+        p->done = true;
+        multifd_pages_init(&p->pages, page_count);
         p->name = g_strdup_printf("multifdsend_%d", i);
         socket_send_channel_create(multifd_new_send_channel_async, p);
     }
@@ -655,6 +729,51 @@ int multifd_save_setup(void)
     return 0;
 }
 
+static void multifd_send_page(RAMBlock *block, ram_addr_t offset,
+                              bool last_page)
+{
+    int i;
+    static int next_channel;
+    MultiFDSendParams *p = NULL; /* make happy gcc */
+    MultiFDPages_t *pages = multifd_send_state->pages;
+
+    if (!pages->block) {
+        pages->block = block;
+    }
+
+    pages->offset[pages->used] = offset;
+    pages->iov[pages->used].iov_base = block->host + offset;
+    pages->iov[pages->used].iov_len = TARGET_PAGE_SIZE;
+    pages->used++;
+
+    if (!last_page) {
+        if (pages->used < pages->allocated) {
+            return;
+        }
+    }
+
+    qemu_sem_wait(&multifd_send_state->sem);
+    qemu_mutex_lock(&multifd_send_state->mutex);
+    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
+        p = &multifd_send_state->params[i];
+
+        if (p->done) {
+            p->done = false;
+            next_channel = (i + 1) % migrate_multifd_channels();
+            break;
+        }
+    }
+    qemu_mutex_unlock(&multifd_send_state->mutex);
+    qemu_mutex_lock(&p->mutex);
+    p->pages->used = 0;
+    p->pages->seq = pages->seq + 1;
+    p->pages->block = NULL;
+    multifd_send_state->pages = p->pages;
+    p->pages = pages;
+    qemu_mutex_unlock(&p->mutex);
+    qemu_sem_post(&p->sem);
+}
+
 struct MultiFDRecvParams {
     uint8_t id;
     char *name;
@@ -1291,6 +1410,31 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
     return pages;
 }
 
+static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
+                            bool last_stage)
+{
+    int pages;
+    uint8_t *p;
+    RAMBlock *block = pss->block;
+    ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
+
+    p = block->host + offset;
+
+    pages = save_zero_page(rs, block, offset);
+    if (pages == -1) {
+        ram_counters.transferred +=
+            save_page_header(rs, rs->f, block,
+                             offset | RAM_SAVE_FLAG_PAGE);
+        multifd_send_page(block, offset, rs->migration_dirty_pages == 1);
+        qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
+        ram_counters.transferred += TARGET_PAGE_SIZE;
+        pages = 1;
+        ram_counters.normal++;
+    }
+
+    return pages;
+}
+
 static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
                                 ram_addr_t offset)
 {
@@ -1719,6 +1863,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         if (migrate_use_compression() &&
             (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
             res = ram_save_compressed_page(rs, pss, last_stage);
+        } else if (migrate_use_multifd()) {
+            res = ram_multifd_page(rs, pss, last_stage);
         } else {
             res = ram_save_page(rs, pss, last_stage);
         }
diff --git a/migration/trace-events b/migration/trace-events
index 9c92d3ec14..06a9ead811 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -84,9 +84,10 @@ multifd_recv_sync_main(void) ""
 multifd_recv_sync_signal(uint8_t id, bool quit, bool running) "channel %d quit %d running %d"
 multifd_recv_sync_wait(uint8_t id, bool quit, bool running) "channel %d quit %d running %d"
 multifd_send_thread_start(uint8_t id) "%d"
-multifd_send_thread_end(uint8_t id) "%d"
+multifd_send_thread_end(uint8_t id, uint32_t packets) "channel %d packets %d"
 multifd_recv_thread_start(uint8_t id) "%d"
 multifd_recv_thread_end(uint8_t id) "%d"
+multifd_send(uint8_t id, int seq, int num) "channel %d sequence %d num pages %d"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.14.3
