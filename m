Received: from eggs.gnu.org ([2001:4830:134:3::10]:40380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFnF-00068s-PP
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFnE-0004ao-OD
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eZFnE-0004Zn-Fs
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95C9D7854B
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 12:47:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 10 Jan 2018 13:47:17 +0100
Message-Id: <20180110124723.11879-9-quintela@redhat.com>
In-Reply-To: <20180110124723.11879-1-quintela@redhat.com>
References: <20180110124723.11879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 08/14] migration: Transfer pages over new
 channels
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

We switch for sending the page number to send real pages.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

Remove the HACK bit, now we have the function that calculates the size
of a page exported.
Rename multifd_pages{_now}, to sent pages
Remove multifd pages field, it is the same than normal pages
Merge test channels here
Make sent_pages also work for non multifd case
---
 migration/migration.c | 10 +++++++++-
 migration/ram.c       | 41 +++++++++++++++++++++++++++++------------
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1545f3a0b0..6ebcfa36cc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2230,6 +2230,8 @@ static void *migration_thread(void *opaque)
      */
     int64_t threshold_size = 0;
     int64_t qemu_file_bytes = 0;
+    /* Stores how many pages we have sent */
+    int64_t sent_pages = 0;
     int64_t start_time = initial_time;
     int64_t end_time;
     bool old_vm_running = false;
@@ -2318,8 +2320,13 @@ static void *migration_thread(void *opaque)
         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         if (current_time >= initial_time + BUFFER_DELAY) {
             uint64_t qemu_file_bytes_now = qemu_ftell(s->to_dst_file);
+            uint64_t sent_pages_now = ram_counters.normal;
+            /* multifd sends data out of the qemu_file */
+            uint64_t multifd_transferred = migrate_use_multifd() ?
+                (sent_pages_now - sent_pages) * qemu_target_page_size() : 0;
             uint64_t transferred_bytes =
-                qemu_file_bytes_now - qemu_file_bytes;
+                (qemu_file_bytes_now - qemu_file_bytes) +
+                multifd_transferred;
             uint64_t time_spent = current_time - initial_time;
             double bandwidth = (double)transferred_bytes / time_spent;
             threshold_size = bandwidth * s->parameters.downtime_limit;
@@ -2339,6 +2346,7 @@ static void *migration_thread(void *opaque)
             qemu_file_reset_rate_limit(s->to_dst_file);
             initial_time = current_time;
             qemu_file_bytes = qemu_file_bytes_now;
+            sent_pages = sent_pages_now;
         }
         if (qemu_file_rate_limit(s->to_dst_file)) {
             /* usleep expects microseconds */
diff --git a/migration/ram.c b/migration/ram.c
index 8443806f12..20f3726909 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -542,12 +542,20 @@ static void *multifd_send_thread(void *opaque)
             break;
         }
         if (p->pages->used) {
+            Error *local_err = NULL;
+            size_t ret;
+            uint32_t used;
+
+            used = p->pages->used;
             p->pages->used = 0;
             qemu_mutex_unlock(&p->mutex);
 
-            trace_multifd_send(p->id, p->pages->seq, p->pages->used);
-            /* ToDo: send page here */
-
+            trace_multifd_send(p->id, p->pages->seq, used);
+            ret = qio_channel_writev_all(p->c, p->pages->iov, used, &local_err);
+            if (ret != 0) {
+                terminate_multifd_send_threads(local_err);
+                return NULL;
+            }
             qemu_mutex_lock(&multifd_send_state->mutex);
             p->done = true;
             p->packets_sent++;
@@ -754,12 +762,21 @@ static void *multifd_recv_thread(void *opaque)
             break;
         }
         if (p->pages->used) {
+            Error *local_err = NULL;
+            size_t ret;
+            uint32_t used;
+
+            used = p->pages->used;
             p->pages->used = 0;
+            qemu_mutex_unlock(&p->mutex);
 
-            trace_multifd_recv(p->id, p->pages->seq, p->pages->used);
-
-            /* ToDo: receive pages here */
-
+            trace_multifd_recv(p->id, p->pages->seq, used);
+            ret = qio_channel_readv_all(p->c, p->pages->iov, used, &local_err);
+            if (ret != 0) {
+                terminate_multifd_recv_threads(local_err);
+                return NULL;
+            }
+            qemu_mutex_lock(&p->mutex);
             p->done = true;
             p->packets_recv++;
             qemu_mutex_unlock(&p->mutex);
@@ -1311,12 +1328,9 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
 {
     int pages;
     uint16_t fd_num;
-    uint8_t *p;
     RAMBlock *block = pss->block;
     ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
 
-    p = block->host + offset;
-
     pages = save_zero_page(rs, block, offset);
     if (pages == -1) {
         ram_counters.transferred +=
@@ -1325,8 +1339,12 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
         fd_num = multifd_send_page(block, offset,
                                    rs->migration_dirty_pages == 1);
         qemu_put_be16(rs->f, fd_num);
+        if (fd_num != MULTIFD_CONTINUE) {
+            /* We start with a different channel.
+               Flush pending work */
+            qemu_fflush(rs->f);
+        }
         ram_counters.transferred += 2; /* size of fd_num */
-        qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
         ram_counters.transferred += TARGET_PAGE_SIZE;
         pages = 1;
         ram_counters.normal++;
@@ -3278,7 +3296,6 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         case RAM_SAVE_FLAG_MULTIFD_PAGE:
             fd_num = qemu_get_be16(f);
             multifd_recv_page(block, addr, host, fd_num);
-            qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
             break;
 
         case RAM_SAVE_FLAG_EOS:
-- 
2.14.3
