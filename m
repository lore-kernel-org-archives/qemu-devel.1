Received: from eggs.gnu.org ([2001:4830:134:3::10]:34355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaW-00032p-0J
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaT-0005GJ-5S
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51558 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fBIaT-0005Fw-1Y
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACF028D76C
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 11:27:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 25 Apr 2018 13:27:19 +0200
Message-Id: <20180425112723.1111-18-quintela@redhat.com>
In-Reply-To: <20180425112723.1111-1-quintela@redhat.com>
References: <20180425112723.1111-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v12 17/21] migration: Create ram_multifd_page
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
 migration/ram.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 398cb0af3b..862ec53d32 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -54,6 +54,7 @@
 #include "migration/block.h"
 #include "sysemu/sysemu.h"
 #include "qemu/uuid.h"
+#include "qemu/iov.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -692,8 +693,65 @@ struct {
     QemuSemaphore sem_sync;
     /* global number of generated multifd packets */
     uint32_t seq;
+    /* send channels ready */
+    QemuSemaphore channels_ready;
 } *multifd_send_state;
 
+static void multifd_send_pages(void)
+{
+    int i;
+    static int next_channel;
+    MultiFDSendParams *p = NULL; /* make happy gcc */
+    MultiFDPages_t *pages = multifd_send_state->pages;
+
+    qemu_sem_wait(&multifd_send_state->channels_ready);
+    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
+        p = &multifd_send_state->params[i];
+
+        qemu_mutex_lock(&p->mutex);
+        if (!p->pending_job) {
+            p->pending_job++;
+            next_channel = (i + 1) % migrate_multifd_channels();
+            break;
+        }
+        qemu_mutex_unlock(&p->mutex);
+    }
+    p->pages->used = 0;
+    multifd_send_state->seq++;
+    p->seq = multifd_send_state->seq;
+    p->pages->block = NULL;
+    multifd_send_state->pages = p->pages;
+    p->pages = pages;
+    qemu_mutex_unlock(&p->mutex);
+    qemu_sem_post(&p->sem);
+}
+
+static void multifd_queue_page(RAMBlock *block, ram_addr_t offset)
+{
+    MultiFDPages_t *pages = multifd_send_state->pages;
+
+    if (!pages->block) {
+        pages->block = block;
+    }
+
+    if (pages->block == block) {
+        pages->offset[pages->used] = offset;
+        pages->iov[pages->used].iov_base = block->host + offset;
+        pages->iov[pages->used].iov_len = TARGET_PAGE_SIZE;
+        pages->used++;
+
+        if (pages->used < pages->allocated) {
+            return;
+        }
+    }
+
+    multifd_send_pages();
+
+    if (pages->block != block) {
+        multifd_queue_page(block, offset);
+    }
+}
+
 static void multifd_send_terminate_threads(Error *err)
 {
     int i;
@@ -746,6 +804,7 @@ int multifd_save_cleanup(Error **errp)
         g_free(p->packet);
         p->packet = NULL;
     }
+    qemu_sem_destroy(&multifd_send_state->channels_ready);
     qemu_sem_destroy(&multifd_send_state->sem_sync);
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
@@ -763,12 +822,17 @@ static void multifd_send_sync_main(void)
     if (!migrate_use_multifd()) {
         return;
     }
+    if (multifd_send_state->pages->used) {
+        multifd_send_pages();
+    }
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
         trace_multifd_send_sync_main_signal(p->id);
 
         qemu_mutex_lock(&p->mutex);
+        multifd_send_state->seq++;
+        p->seq = multifd_send_state->seq;
         p->flags |= MULTIFD_FLAG_SYNC;
         p->pending_job++;
         qemu_mutex_unlock(&p->mutex);
@@ -824,6 +888,7 @@ static void *multifd_send_thread(void *opaque)
             if (flags & MULTIFD_FLAG_SYNC) {
                 qemu_sem_post(&multifd_send_state->sem_sync);
             }
+            qemu_sem_post(&multifd_send_state->channels_ready);
         } else if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
@@ -883,6 +948,7 @@ int multifd_save_setup(void)
     atomic_set(&multifd_send_state->count, 0);
     multifd_pages_init(&multifd_send_state->pages, page_count);
     qemu_sem_init(&multifd_send_state->sem_sync, 0);
+    qemu_sem_init(&multifd_send_state->channels_ready, 0);
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
@@ -1576,6 +1642,31 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
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
+        multifd_queue_page(block, offset);
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
@@ -2004,6 +2095,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         if (migrate_use_compression() &&
             (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
             res = ram_save_compressed_page(rs, pss, last_stage);
+        } else if (migrate_use_multifd()) {
+            res = ram_multifd_page(rs, pss, last_stage);
         } else {
             res = ram_save_page(rs, pss, last_stage);
         }
-- 
2.17.0
