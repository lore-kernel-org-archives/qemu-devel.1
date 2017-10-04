Received: from eggs.gnu.org ([2001:4830:134:3::10]:55154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCk-000568-T7
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCj-00037C-Gy
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:47:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dzhCj-00036i-7P
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:47:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 446D2C2D0D47
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 10:47:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  4 Oct 2017 12:46:35 +0200
Message-Id: <20171004104636.7963-12-quintela@redhat.com>
In-Reply-To: <20171004104636.7963-1-quintela@redhat.com>
References: <20171004104636.7963-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v9 11/12] migration: Flush receive queue
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

Each time that we sync the bitmap, it is a possiblity that we receive
a page that is being processed by a different thread.  We fix this
problem just making sure that we wait for all receiving threads to
finish its work before we procedeed with the next stage.

We are low on page flags, so we use a combination that is not valid to
emit that message:  MULTIFD_PAGE and COMPRESSED.

I tried to make a migration command for it, but it don't work because
we sync the bitmap sometimes when we have already sent the beggining
of the section, so I just added a new page flag.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--
Create RAM_SAVE_FLAG_MULTIFD_SYNC (dave suggestion)
Move the set of need_flush to inside the bitmap_sync code (peter suggestion)
---
 migration/ram.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 981f345294..d717776f32 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -72,6 +72,14 @@
 #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
 #define RAM_SAVE_FLAG_MULTIFD_PAGE     0x200
 
+/* We are getting low on pages flags, so we start using combinations
+   When we need to flush a page, we sent it as
+   RAM_SAVE_FLAG_MULTIFD_PAGE | RAM_SAVE_FLAG_COMPRESS_PAGE
+   We don't allow that combination
+*/
+#define RAM_SAVE_FLAG_MULTIFD_SYNC \
+    (RAM_SAVE_FLAG_MULTIFD_PAGE | RAM_SAVE_FLAG_ZERO)
+
 static inline bool is_zero_range(uint8_t *p, uint64_t size)
 {
     return buffer_is_zero(p, size);
@@ -194,6 +202,9 @@ struct RAMState {
     uint64_t iterations_prev;
     /* Iterations since start */
     uint64_t iterations;
+    /* Indicates if we have synced the bitmap and we need to assure that
+       target has processeed all previous pages */
+    bool multifd_needs_flush;
     /* number of dirty bits in the bitmap */
     uint64_t migration_dirty_pages;
     /* protects modification of the bitmap */
@@ -614,9 +625,11 @@ struct MultiFDRecvParams {
     QIOChannel *c;
     QemuSemaphore ready;
     QemuSemaphore sem;
+    QemuCond cond_sync;
     QemuMutex mutex;
     /* proteced by param mutex */
     bool quit;
+    bool sync;
     multifd_pages_t pages;
     bool done;
 };
@@ -669,6 +682,7 @@ int multifd_load_cleanup(Error **errp)
         qemu_thread_join(&p->thread);
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
+        qemu_cond_destroy(&p->cond_sync);
         socket_recv_channel_destroy(p->c);
         g_free(p->name);
         p->name = NULL;
@@ -707,6 +721,10 @@ static void *multifd_recv_thread(void *opaque)
                 return NULL;
             }
             p->done = true;
+            if (p->sync) {
+                qemu_cond_signal(&p->cond_sync);
+                p->sync = false;
+            }
             qemu_mutex_unlock(&p->mutex);
             qemu_sem_post(&p->ready);
             continue;
@@ -752,9 +770,11 @@ void multifd_new_channel(QIOChannel *ioc)
     qemu_mutex_init(&p->mutex);
     qemu_sem_init(&p->sem, 0);
     qemu_sem_init(&p->ready, 0);
+    qemu_cond_init(&p->cond_sync);
     p->quit = false;
     p->id = msg.id;
     p->done = false;
+    p->sync = false;
     multifd_init_pages(&p->pages);
     p->c = ioc;
     multifd_recv_state->count++;
@@ -819,6 +839,27 @@ static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
     qemu_sem_post(&p->sem);
 }
 
+static int multifd_flush(void)
+{
+    int i, thread_count;
+
+    if (!migrate_use_multifd()) {
+        return 0;
+    }
+    thread_count = migrate_multifd_channels();
+    for (i = 0; i < thread_count; i++) {
+        MultiFDRecvParams *p = &multifd_recv_state->params[i];
+
+        qemu_mutex_lock(&p->mutex);
+        while (!p->done) {
+            p->sync = true;
+            qemu_cond_wait(&p->cond_sync, &p->mutex);
+        }
+        qemu_mutex_unlock(&p->mutex);
+    }
+    return 0;
+}
+
 /**
  * save_page_header: write page header to wire
  *
@@ -836,6 +877,12 @@ static size_t save_page_header(RAMState *rs, QEMUFile *f,  RAMBlock *block,
 {
     size_t size, len;
 
+    if (rs->multifd_needs_flush &&
+        (offset & RAM_SAVE_FLAG_MULTIFD_PAGE)) {
+        offset |= RAM_SAVE_FLAG_ZERO;
+        rs->multifd_needs_flush = false;
+    }
+
     if (block == rs->last_sent_block) {
         offset |= RAM_SAVE_FLAG_CONTINUE;
     }
@@ -1124,6 +1171,9 @@ static void migration_bitmap_sync(RAMState *rs)
     if (migrate_use_events()) {
         qapi_event_send_migration_pass(ram_counters.dirty_sync_count, NULL);
     }
+    if (!rs->ram_bulk_stage && migrate_use_multifd()) {
+        rs->multifd_needs_flush = true;
+    }
 }
 
 /**
@@ -3045,6 +3095,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             break;
         }
 
+        if ((flags & RAM_SAVE_FLAG_MULTIFD_SYNC)
+            == RAM_SAVE_FLAG_MULTIFD_SYNC) {
+            multifd_flush();
+            flags = flags & ~RAM_SAVE_FLAG_ZERO;
+        }
         if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
                      RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE |
                      RAM_SAVE_FLAG_MULTIFD_PAGE)) {
-- 
2.13.5
