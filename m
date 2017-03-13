Received: from eggs.gnu.org ([2001:4830:134:3::10]:56608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLU-0004ZR-Ac
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLT-00060k-8g
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:45:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnPLT-00060Y-07
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:45:03 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DA566AAC7
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 12:45:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Mar 2017 13:44:34 +0100
Message-Id: <20170313124434.1043-17-quintela@redhat.com>
In-Reply-To: <20170313124434.1043-1-quintela@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 16/16] migration: Flush receive queue
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
---
 include/migration/migration.h |  1 +
 migration/ram.c               | 57 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index bd152c5..86023ff 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -278,6 +278,7 @@ int migrate_multifd_send_threads_create(void);
 void migrate_multifd_send_threads_join(void);
 int migrate_multifd_recv_threads_create(void);
 void migrate_multifd_recv_threads_join(void);
+void qemu_savevm_send_multifd_flush(QEMUFile *f);
 
 void migrate_compress_threads_create(void);
 void migrate_compress_threads_join(void);
diff --git a/migration/ram.c b/migration/ram.c
index e213a49..a93c4ae 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -64,6 +64,13 @@ static uint64_t bitmap_sync_count;
 #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
 #define RAM_SAVE_FLAG_MULTIFD_PAGE     0x200
 
+/* We are getting low on pages flags, so we start using combinations
+   When we need to flush a page, we sent it as
+   RAM_SAVE_FLAG_MULTIFD_PAGE | RAM_SAVE_FLAG_COMPRESS_PAGE
+   We don't allow that combination
+*/
+
+
 static uint8_t *ZERO_TARGET_PAGE;
 
 static inline bool is_zero_range(uint8_t *p, uint64_t size)
@@ -392,6 +399,9 @@ void migrate_compress_threads_create(void)
 
 /* Multiple fd's */
 
+/* Indicates if we have synced the bitmap and we need to assure that
+   target has processeed all previous pages */
+bool multifd_needs_flush;
 
 typedef struct {
     int num;
@@ -605,9 +615,11 @@ struct MultiFDRecvParams {
     QemuSemaphore init;
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
@@ -648,6 +660,7 @@ void migrate_multifd_recv_threads_join(void)
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         qemu_sem_destroy(&p->init);
+        qemu_cond_destroy(&p->cond_sync);
         socket_send_channel_destroy(multifd_recv_state->params[i].c);
     }
     g_free(multifd_recv_state->params);
@@ -688,6 +701,10 @@ static void *multifd_recv_thread(void *opaque)
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
@@ -717,9 +734,11 @@ int migrate_multifd_recv_threads_create(void)
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->init, 0);
         qemu_sem_init(&p->ready, 0);
+        qemu_cond_init(&p->cond_sync);
         p->quit = false;
         p->id = i;
         p->done = false;
+        p->sync = false;
         multifd_init_group(&p->pages);
         p->c = socket_recv_channel_create();
 
@@ -773,6 +792,27 @@ static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
     qemu_sem_post(&p->sem);
 }
 
+static int multifd_flush(void)
+{
+    int i, thread_count;
+
+    if (!migrate_use_multifd()) {
+        return 0;
+    }
+    thread_count = migrate_multifd_threads();
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
  * save_page_header: Write page header to wire
  *
@@ -789,6 +829,12 @@ static size_t save_page_header(QEMUFile *f, RAMBlock *block, ram_addr_t offset)
 {
     size_t size, len;
 
+    if (multifd_needs_flush &&
+        (offset & RAM_SAVE_FLAG_MULTIFD_PAGE)) {
+        offset |= RAM_SAVE_FLAG_COMPRESS;
+        multifd_needs_flush = false;
+    }
+
     qemu_put_be64(f, offset);
     size = 8;
 
@@ -2526,6 +2572,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
     if (!migration_in_postcopy(migrate_get_current())) {
         migration_bitmap_sync();
+        if (migrate_use_multifd()) {
+            multifd_needs_flush = true;
+        }
     }
 
     ram_control_before_iterate(f, RAM_CONTROL_FINISH);
@@ -2567,6 +2616,9 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
         qemu_mutex_lock_iothread();
         rcu_read_lock();
         migration_bitmap_sync();
+        if (migrate_use_multifd()) {
+            multifd_needs_flush = true;
+        }
         rcu_read_unlock();
         qemu_mutex_unlock_iothread();
         remaining_size = ram_save_remaining() * TARGET_PAGE_SIZE;
@@ -3005,6 +3057,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             break;
         }
 
+        if ((flags & (RAM_SAVE_FLAG_MULTIFD_PAGE | RAM_SAVE_FLAG_COMPRESS))
+                  == (RAM_SAVE_FLAG_MULTIFD_PAGE | RAM_SAVE_FLAG_COMPRESS)) {
+            multifd_flush();
+            flags = flags & ~RAM_SAVE_FLAG_COMPRESS;
+        }
         if (flags & (RAM_SAVE_FLAG_COMPRESS | RAM_SAVE_FLAG_PAGE |
                      RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE |
                      RAM_SAVE_FLAG_MULTIFD_PAGE)) {
-- 
2.9.3
