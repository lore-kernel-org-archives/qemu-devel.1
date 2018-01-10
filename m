Received: from eggs.gnu.org ([2001:4830:134:3::10]:40269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFn9-000666-Vj
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFn8-0004Rj-Bb
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eZFn8-0004Qm-2a
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D28F20262
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 12:47:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 10 Jan 2018 13:47:14 +0100
Message-Id: <20180110124723.11879-6-quintela@redhat.com>
In-Reply-To: <20180110124723.11879-1-quintela@redhat.com>
References: <20180110124723.11879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 05/14] migration: Create ram_multifd_page
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
counter and a new flag for this type of pages.

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
---
 migration/ram.c        | 159 ++++++++++++++++++++++++++++++++++++++++++++++++-
 migration/trace-events |   2 +
 2 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index aef5a323f3..5d6b46ac23 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -52,6 +52,7 @@
 #include "migration/block.h"
 #include "sysemu/sysemu.h"
 #include "qemu/uuid.h"
+#include "qemu/iov.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -71,6 +72,7 @@
 #define RAM_SAVE_FLAG_XBZRLE   0x40
 /* 0x80 is reserved in migration.h start with 0x100 next */
 #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
+#define RAM_SAVE_FLAG_MULTIFD_PAGE     0x200
 
 static inline bool is_zero_range(uint8_t *p, uint64_t size)
 {
@@ -395,14 +397,36 @@ static void compress_threads_save_setup(void)
 
 /* Multiple fd's */
 
+/* used to continue on the same multifd group */
+#define MULTIFD_CONTINUE UINT16_MAX
+
+typedef struct {
+    /* number of used pages */
+    uint32_t used;
+    /* number of allocated pages */
+    uint32_t allocated;
+    /* global number of generated multifd packets */
+    uint32_t seq;
+    struct iovec *iov;
+    RAMBlock *block;
+} multifd_pages_t;
+
 struct MultiFDSendParams {
+    /* not changed */
     uint8_t id;
     char *name;
     QemuThread thread;
     QIOChannel *c;
     QemuSemaphore sem;
     QemuMutex mutex;
+    /* protected by param mutex */
     bool quit;
+    multifd_pages_t *pages;
+    /* how many patches has sent this channel */
+    uint32_t packets_sent;
+    /* protected by multifd mutex */
+    /* has the thread finish the last submitted job */
+    bool done;
 };
 typedef struct MultiFDSendParams MultiFDSendParams;
 
@@ -410,8 +434,31 @@ struct {
     MultiFDSendParams *params;
     /* number of created threads */
     int count;
+    QemuMutex mutex;
+    QemuSemaphore sem;
+    multifd_pages_t *pages;
 } *multifd_send_state;
 
+static void multifd_pages_init(multifd_pages_t **ppages, size_t size)
+{
+    multifd_pages_t *pages = g_new0(multifd_pages_t, 1);
+
+    pages->allocated = size;
+    pages->iov = g_new0(struct iovec, size);
+    *ppages = pages;
+}
+
+static void multifd_pages_clear(multifd_pages_t *pages)
+{
+    pages->used = 0;
+    pages->allocated = 0;
+    pages->seq = 0;
+    pages->block = NULL;
+    g_free(pages->iov);
+    pages->iov = NULL;
+    g_free(pages);
+}
+
 static void terminate_multifd_send_threads(Error *errp)
 {
     int i;
@@ -453,9 +500,13 @@ int multifd_save_cleanup(Error **errp)
         socket_send_channel_destroy(p->c);
         g_free(p->name);
         p->name = NULL;
+        multifd_pages_clear(p->pages);
+        p->pages = NULL;
     }
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
+    multifd_pages_clear(multifd_send_state->pages);
+    multifd_send_state->pages = NULL;
     g_free(multifd_send_state);
     multifd_send_state = NULL;
     return ret;
@@ -482,6 +533,7 @@ static void *multifd_send_thread(void *opaque)
         terminate_multifd_send_threads(local_err);
         return NULL;
     }
+    qemu_sem_post(&multifd_send_state->sem);
 
     while (true) {
         qemu_mutex_lock(&p->mutex);
@@ -489,9 +541,24 @@ static void *multifd_send_thread(void *opaque)
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
         qemu_sem_wait(&p->sem);
     }
+    trace_multifd_send_thread(p->id, p->packets_sent);
 
     return NULL;
 }
@@ -529,6 +596,10 @@ int multifd_save_setup(void)
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
     multifd_send_state->count = 0;
+    qemu_mutex_init(&multifd_send_state->mutex);
+    qemu_sem_init(&multifd_send_state->sem, 0);
+    multifd_pages_init(&multifd_send_state->pages,
+                       migrate_multifd_page_count());
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -536,12 +607,58 @@ int multifd_save_setup(void)
         qemu_sem_init(&p->sem, 0);
         p->quit = false;
         p->id = i;
+        p->done = true;
+        multifd_pages_init(&p->pages, migrate_multifd_page_count());
         p->name = g_strdup_printf("multifdsend_%d", i);
         socket_send_channel_create(multifd_new_send_channel_async, p);
     }
     return 0;
 }
 
+static uint16_t multifd_send_page(RAMBlock *block, ram_addr_t offset,
+                                  bool last_page)
+{
+    int i;
+    MultiFDSendParams *p = NULL; /* make happy gcc */
+    multifd_pages_t *pages = multifd_send_state->pages;
+
+    if (!pages->block) {
+        pages->block = block;
+    }
+
+    pages->iov[pages->used].iov_base = block->host + offset;
+    pages->iov[pages->used].iov_len = TARGET_PAGE_SIZE;
+    pages->used++;
+
+    if (!last_page) {
+        if (pages->used < pages->allocated) {
+            return MULTIFD_CONTINUE;
+        }
+    }
+
+    qemu_sem_wait(&multifd_send_state->sem);
+    qemu_mutex_lock(&multifd_send_state->mutex);
+    for (i = 0; i < multifd_send_state->count; i++) {
+        p = &multifd_send_state->params[i];
+
+        if (p->done) {
+            p->done = false;
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
+
+    return i;
+}
+
 struct MultiFDRecvParams {
     uint8_t id;
     char *name;
@@ -1070,6 +1187,31 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
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
+                             offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
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
@@ -1498,6 +1640,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         if (migrate_use_compression() &&
             (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
             res = ram_save_compressed_page(rs, pss, last_stage);
+        } else if (migrate_use_multifd()) {
+            res = ram_multifd_page(rs, pss, last_stage);
         } else {
             res = ram_save_page(rs, pss, last_stage);
         }
@@ -2878,6 +3022,10 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     if (!migrate_use_compression()) {
         invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
     }
+
+    if (!migrate_use_multifd()) {
+        invalid_flags |= RAM_SAVE_FLAG_MULTIFD_PAGE;
+    }
     /* This RCU critical section can be very long running.
      * When RCU reclaims in the code start to become numerous,
      * it will be necessary to reduce the granularity of this
@@ -2902,13 +3050,17 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             if (flags & invalid_flags & RAM_SAVE_FLAG_COMPRESS_PAGE) {
                 error_report("Received an unexpected compressed page");
             }
+            if (flags & invalid_flags  & RAM_SAVE_FLAG_MULTIFD_PAGE) {
+                error_report("Received an unexpected multifd page");
+            }
 
             ret = -EINVAL;
             break;
         }
 
         if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
-                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
+                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE |
+                     RAM_SAVE_FLAG_MULTIFD_PAGE)) {
             RAMBlock *block = ram_block_from_stream(f, flags);
 
             host = host_from_ram_block_offset(block, addr);
@@ -2997,6 +3149,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
                 break;
             }
             break;
+
+        case RAM_SAVE_FLAG_MULTIFD_PAGE:
+            qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
+            break;
+
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
             break;
diff --git a/migration/trace-events b/migration/trace-events
index 141e773305..61ee21a13e 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -77,6 +77,8 @@ ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
 ram_postcopy_send_discard_bitmap(void) ""
 ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%" PRIx64 " host: %p"
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
+multifd_send(char id, int seq, int num) "channel %d sequence %d num pages %d"
+multifd_send_thread(char id, uint32_t packets) "channel %d packets %d"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.14.3
