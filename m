Received: from eggs.gnu.org ([2001:4830:134:3::10]:55057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCZ-0004vs-4d
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCW-0002rc-0L
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dzhCV-0002rH-OI
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:46:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7CBE780C9
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 10:46:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  4 Oct 2017 12:46:29 +0200
Message-Id: <20171004104636.7963-6-quintela@redhat.com>
In-Reply-To: <20171004104636.7963-1-quintela@redhat.com>
References: <20171004104636.7963-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v9 05/12] migration: Create ram_multifd_page
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
---
 migration/ram.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index b57006594b..c0af538f5f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -50,6 +50,7 @@
 #include "migration/block.h"
 #include "sysemu/sysemu.h"
 #include "qemu/uuid.h"
+#include "qemu/iov.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -69,6 +70,7 @@
 #define RAM_SAVE_FLAG_XBZRLE   0x40
 /* 0x80 is reserved in migration.h start with 0x100 next */
 #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
+#define RAM_SAVE_FLAG_MULTIFD_PAGE     0x200
 
 static inline bool is_zero_range(uint8_t *p, uint64_t size)
 {
@@ -362,14 +364,29 @@ static void compress_threads_save_setup(void)
 
 /* Multiple fd's */
 
+/* used to continue on the same multifd group */
+#define MULTIFD_CONTINUE UINT16_MAX
+
+typedef struct {
+    int num;
+    size_t size;
+    struct iovec *iov;
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
+    multifd_pages_t pages;
+    /* protected by multifd mutex */
+    /* has the thread finish the last submitted job */
+    bool done;
 };
 typedef struct MultiFDSendParams MultiFDSendParams;
 
@@ -377,8 +394,26 @@ struct {
     MultiFDSendParams *params;
     /* number of created threads */
     int count;
+    QemuMutex mutex;
+    QemuSemaphore sem;
+    multifd_pages_t pages;
 } *multifd_send_state;
 
+static void multifd_init_pages(multifd_pages_t *pages)
+{
+    pages->num = 0;
+    pages->size = migrate_multifd_page_count();
+    pages->iov = g_new0(struct iovec, pages->size);
+}
+
+static void multifd_clear_pages(multifd_pages_t *pages)
+{
+    pages->num = 0;
+    pages->size = 0;
+    g_free(pages->iov);
+    pages->iov = NULL;
+}
+
 static void terminate_multifd_send_threads(Error *errp)
 {
     int i;
@@ -417,9 +452,11 @@ int multifd_save_cleanup(Error **errp)
         socket_send_channel_destroy(p->c);
         g_free(p->name);
         p->name = NULL;
+        multifd_clear_pages(&p->pages);
     }
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
+    multifd_clear_pages(&multifd_send_state->pages);
     g_free(multifd_send_state);
     multifd_send_state = NULL;
     return ret;
@@ -446,6 +483,7 @@ static void *multifd_send_thread(void *opaque)
         terminate_multifd_send_threads(local_err);
         return NULL;
     }
+    qemu_sem_post(&multifd_send_state->sem);
 
     while (true) {
         qemu_mutex_lock(&p->mutex);
@@ -453,6 +491,15 @@ static void *multifd_send_thread(void *opaque)
             qemu_mutex_unlock(&p->mutex);
             break;
         }
+        if (p->pages.num) {
+            p->pages.num = 0;
+            qemu_mutex_unlock(&p->mutex);
+            qemu_mutex_lock(&multifd_send_state->mutex);
+            p->done = true;
+            qemu_mutex_unlock(&multifd_send_state->mutex);
+            qemu_sem_post(&multifd_send_state->sem);
+            continue;
+        }
         qemu_mutex_unlock(&p->mutex);
         qemu_sem_wait(&p->sem);
     }
@@ -493,6 +540,9 @@ int multifd_save_setup(void)
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
     multifd_send_state->count = 0;
+    qemu_mutex_init(&multifd_send_state->mutex);
+    qemu_sem_init(&multifd_send_state->sem, 0);
+    multifd_init_pages(&multifd_send_state->pages);
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -500,12 +550,52 @@ int multifd_save_setup(void)
         qemu_sem_init(&p->sem, 0);
         p->quit = false;
         p->id = i;
+        p->done = true;
+        multifd_init_pages(&p->pages);
         p->name = g_strdup_printf("multifdsend_%d", i);
         socket_send_channel_create(multifd_new_channel_async, p);
     }
     return 0;
 }
 
+static uint16_t multifd_send_page(uint8_t *address, bool last_page)
+{
+    int i;
+    MultiFDSendParams *p = NULL; /* make happy gcc */
+    multifd_pages_t *pages = &multifd_send_state->pages;
+
+    pages->iov[pages->num].iov_base = address;
+    pages->iov[pages->num].iov_len = TARGET_PAGE_SIZE;
+    pages->num++;
+
+    if (!last_page) {
+        if (pages->num < (pages->size - 1)) {
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
+    p->pages.num = pages->num;
+    iov_copy(p->pages.iov, pages->num, pages->iov, pages->num, 0,
+             iov_size(pages->iov, pages->num));
+    pages->num = 0;
+    qemu_mutex_unlock(&p->mutex);
+    qemu_sem_post(&p->sem);
+
+    return 0;
+}
+
 struct MultiFDRecvParams {
     uint8_t id;
     char *name;
@@ -1086,6 +1176,31 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
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
+    pages = save_zero_page(rs, block, offset, p);
+    if (pages == -1) {
+        ram_counters.transferred +=
+            save_page_header(rs, rs->f, block,
+                             offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
+        qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
+        multifd_send_page(p, rs->migration_dirty_pages == 1);
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
@@ -1514,6 +1629,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         if (migrate_use_compression() &&
             (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
             res = ram_save_compressed_page(rs, pss, last_stage);
+        } else if (migrate_use_multifd()) {
+            res = ram_multifd_page(rs, pss, last_stage);
         } else {
             res = ram_save_page(rs, pss, last_stage);
         }
@@ -2810,6 +2927,10 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
@@ -2834,13 +2955,17 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
@@ -2928,6 +3053,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
-- 
2.13.5
