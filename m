Received: from eggs.gnu.org ([2001:4830:134:3::10]:40505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFnU-0006Ko-13
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFnT-0004oW-21
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:48:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eZFnS-0004nt-Q3
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E63F063E03
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 12:47:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 10 Jan 2018 13:47:23 +0100
Message-Id: <20180110124723.11879-15-quintela@redhat.com>
In-Reply-To: <20180110124723.11879-1-quintela@redhat.com>
References: <20180110124723.11879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 14/14] all works
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 69 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6e45f668d1..a689d4a218 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -671,22 +671,25 @@ static uint16_t multifd_send_page(RAMBlock *block, ram_addr_t offset,
     int i;
     MultiFDSendParams *p = NULL; /* make happy gcc */
     multifd_pages_t *pages = multifd_send_state->pages;
+    bool same_block;
 
     if (!pages->block) {
         pages->block = block;
     }
 
-    pages->packet->offset[pages->used] = offset;
-    pages->iov[pages->used].iov_base = block->host + offset;
-    pages->iov[pages->used].iov_len = TARGET_PAGE_SIZE;
-    pages->used++;
+    same_block = pages->block == block;
+    if (same_block) {
+        pages->packet->offset[pages->used] = offset;
+        pages->iov[pages->used].iov_base = block->host + offset;
+        pages->iov[pages->used].iov_len = TARGET_PAGE_SIZE;
+        pages->used++;
 
-    if (!last_page) {
-        if (pages->used < pages->allocated) {
-            return MULTIFD_CONTINUE;
+        if (!last_page) {
+            if (pages->used < pages->allocated) {
+                return MULTIFD_CONTINUE;
+            }
         }
     }
-
     qemu_sem_wait(&multifd_send_state->sem);
     qemu_mutex_lock(&multifd_send_state->mutex);
     for (i = 0; i < multifd_send_state->count; i++) {
@@ -709,7 +712,10 @@ static uint16_t multifd_send_page(RAMBlock *block, ram_addr_t offset,
                               p->pages->used, last_page);
     qemu_sem_post(&p->sem);
 
-    return i;
+    if (!same_block) {
+        multifd_send_page(block, offset, last_page);
+    }
+    return 0;
 }
 
 struct MultiFDRecvParams {
@@ -809,14 +815,13 @@ static void *multifd_recv_thread(void *opaque)
             qemu_mutex_unlock(&p->mutex);
             break;
         }
-        if (p->pages->used) {
+        if (true) {
             MultiFDPacket_t *packet = p->pages->packet;
             RAMBlock *block;
             Error *local_err = NULL;
             size_t ret;
             int i;
 
-            p->pages->used = 0;
             qemu_mutex_unlock(&p->mutex);
 
             ret = qio_channel_read_all(p->c, (void *)packet,
@@ -828,13 +833,8 @@ static void *multifd_recv_thread(void *opaque)
             block = qemu_ram_block_by_name(packet->ramblock);
             p->pages->seq = packet->seq;
             for (i = 0; i < packet->used; i++) {
-                if (block->host + packet->offset[i]
-                    != p->pages->iov[i].iov_base) {
-                    printf("page offset %d packet %p pages %p\n", i,
-                           block->host + packet->offset[i],
-                           p->pages->iov[i].iov_base);
-                    break;
-                }
+                p->pages->iov[i].iov_base = block->host + packet->offset[i];
+                p->pages->iov[i].iov_len = TARGET_PAGE_SIZE;
             }
             trace_multifd_recv(p->id, p->pages->seq, packet->used);
             ret = qio_channel_readv_all(p->c, p->pages->iov,
@@ -851,11 +851,11 @@ static void *multifd_recv_thread(void *opaque)
                 p->sync = false;
             }
             qemu_mutex_unlock(&p->mutex);
-            qemu_sem_post(&p->ready);
+//            qemu_sem_post(&p->ready);
             continue;
         }
         qemu_mutex_unlock(&p->mutex);
-        qemu_sem_wait(&p->sem);
+//        qemu_sem_wait(&p->sem);
     }
     trace_multifd_recv_thread(p->id, p->packets_recv);
 
@@ -953,7 +953,7 @@ static void multifd_recv_page(RAMBlock *block, ram_addr_t offset,
     assert(fd_num < thread_count);
     p = &multifd_recv_state->params[fd_num];
 
-    qemu_sem_wait(&p->ready);
+//    qemu_sem_wait(&p->ready);
 
     qemu_mutex_lock(&p->mutex);
     p->done = false;
@@ -961,7 +961,7 @@ static void multifd_recv_page(RAMBlock *block, ram_addr_t offset,
     multifd_recv_state->pages = p->pages;
     p->pages = pages;
     qemu_mutex_unlock(&p->mutex);
-    qemu_sem_post(&p->sem);
+//    qemu_sem_post(&p->sem);
 }
 
 static int multifd_flush(void)
@@ -1430,24 +1430,23 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
                             bool last_stage)
 {
     int pages;
-    uint16_t fd_num;
+//    uint16_t fd_num;
     RAMBlock *block = pss->block;
     ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
 
     pages = save_zero_page(rs, block, offset);
     if (pages == -1) {
-        ram_counters.transferred +=
-            save_page_header(rs, rs->f, block,
-                             offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
-        fd_num = multifd_send_page(block, offset,
-                                   rs->migration_dirty_pages == 1);
-        qemu_put_be16(rs->f, fd_num);
-        if (fd_num != MULTIFD_CONTINUE) {
-            /* We start with a different channel.
-               Flush pending work */
-            qemu_fflush(rs->f);
-        }
-        ram_counters.transferred += 2; /* size of fd_num */
+//        ram_counters.transferred +=
+//            save_page_header(rs, rs->f, block,
+//                             offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
+        multifd_send_page(block, offset, rs->migration_dirty_pages == 1);
+//        qemu_put_be16(rs->f, fd_num);
+//        if (fd_num != MULTIFD_CONTINUE) {
+//            /* We start with a different channel.
+//               Flush pending work */
+//            qemu_fflush(rs->f);
+//        }
+//        ram_counters.transferred += 2; /* size of fd_num */
         ram_counters.transferred += TARGET_PAGE_SIZE;
         pages = 1;
         ram_counters.normal++;
-- 
2.14.3
