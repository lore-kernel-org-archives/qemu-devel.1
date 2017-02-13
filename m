Received: from eggs.gnu.org ([2001:4830:134:3::10]:57922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIV-0008CM-BE
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIT-00052r-I6
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdKIT-00052Z-9h
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:17 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80D8F3B708
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 17:20:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Feb 2017 18:19:48 +0100
Message-Id: <1487006388-7966-13-git-send-email-quintela@redhat.com>
In-Reply-To: <1487006388-7966-1-git-send-email-quintela@redhat.com>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 12/12] migration: Test new fd infrastructure
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

We just send the address through the alternate channels and test that it
is ok.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  1 +
 migration/migration.c         | 15 +++++--
 migration/ram.c               | 91 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index cad03ab..5ec5c62 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -267,6 +267,7 @@ void migrate_multifd_send_threads_create(void);
 void migrate_multifd_send_threads_join(void);
 void migrate_multifd_recv_threads_create(void);
 void migrate_multifd_recv_threads_join(void);
+void qemu_savevm_send_multifd_flush(QEMUFile *f);

 void migrate_compress_threads_create(void);
 void migrate_compress_threads_join(void);
diff --git a/migration/migration.c b/migration/migration.c
index 2e3b357..10ed934 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1919,7 +1919,8 @@ static void *migration_thread(void *opaque)
     /* Used by the bandwidth calcs, updated later */
     int64_t initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
-    int64_t initial_bytes = 0;
+    int64_t qemu_file_bytes = 0;
+    int64_t multifd_pages = 0;
     int64_t max_size = 0;
     int64_t start_time = initial_time;
     int64_t end_time;
@@ -2003,9 +2004,14 @@ static void *migration_thread(void *opaque)
         }
         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         if (current_time >= initial_time + BUFFER_DELAY) {
-            uint64_t transferred_bytes = qemu_ftell(s->to_dst_file) -
-                                         initial_bytes;
             uint64_t time_spent = current_time - initial_time;
+            uint64_t qemu_file_bytes_now = qemu_ftell(s->to_dst_file);
+            uint64_t multifd_pages_now = multifd_mig_pages_transferred();
+            /* Hack ahead.  Why the hell we don't have a function to now the
+               target_page_size.  Hard coding it to 4096 */
+            uint64_t transferred_bytes =
+                (qemu_file_bytes_now - qemu_file_bytes) +
+                (multifd_pages_now - multifd_pages) * 4096;
             double bandwidth = (double)transferred_bytes / time_spent;
             max_size = bandwidth * s->parameters.downtime_limit;

@@ -2022,7 +2028,8 @@ static void *migration_thread(void *opaque)

             qemu_file_reset_rate_limit(s->to_dst_file);
             initial_time = current_time;
-            initial_bytes = qemu_ftell(s->to_dst_file);
+            qemu_file_bytes = qemu_file_bytes_now;
+            multifd_pages = multifd_pages_now;
         }
         if (qemu_file_rate_limit(s->to_dst_file)) {
             /* usleep expects microseconds */
diff --git a/migration/ram.c b/migration/ram.c
index 38789c8..6167a27 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -63,6 +63,13 @@ static uint64_t bitmap_sync_count;
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
@@ -391,6 +398,9 @@ void migrate_compress_threads_create(void)

 /* Multiple fd's */

+/* Indicates if we have synced the bitmap and we need to assure that
+   target has processeed all previous pages */
+bool multifd_needs_flush;

 typedef struct {
     int num;
@@ -434,8 +444,22 @@ static void *multifd_send_thread(void *opaque)
             break;
         }
         if (params->pages.num) {
+            int i;
+            int num;
+
+            num = params->pages.num;
             params->pages.num = 0;
             qemu_mutex_unlock(&params->mutex);
+
+            for (i = 0; i < num; i++) {
+                if (qio_channel_write(params->c,
+                                      (const char *)params->pages.address[i],
+                                      TARGET_PAGE_SIZE, &error_abort)
+                    != TARGET_PAGE_SIZE) {
+                    /* Shuoudn't ever happen */
+                    exit(-1);
+                }
+            }
             qemu_mutex_lock(&multifd_send_mutex);
             params->done = true;
             qemu_mutex_unlock(&multifd_send_mutex);
@@ -577,9 +601,11 @@ struct MultiFDRecvParams {
     QemuSemaphore init;
     QemuSemaphore ready;
     QemuSemaphore sem;
+    QemuCond cond_sync;
     QemuMutex mutex;
     /* proteced by param mutex */
     bool quit;
+    bool sync;
     MultiFDPages pages;
     bool done;
 };
@@ -603,8 +629,26 @@ static void *multifd_recv_thread(void *opaque)
             break;
         }
         if (params->pages.num) {
+            int i;
+            int num;
+
+            num = params->pages.num;
             params->pages.num = 0;
+
+            for (i = 0; i < num; i++) {
+                if (qio_channel_read(params->c,
+                                     (char *)params->pages.address[i],
+                                     TARGET_PAGE_SIZE, &error_abort)
+                    != TARGET_PAGE_SIZE) {
+                    /* shouldn't ever happen */
+                    exit(-1);
+                }
+            }
             params->done = true;
+            if (params->sync) {
+                qemu_cond_signal(&params->cond_sync);
+                params->sync = false;
+            }
             qemu_mutex_unlock(&params->mutex);
             qemu_sem_post(&params->ready);
             continue;
@@ -647,6 +691,7 @@ void migrate_multifd_recv_threads_join(void)
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         qemu_sem_destroy(&p->init);
+        qemu_cond_destroy(&p->cond_sync);
         socket_send_channel_destroy(multifd_recv[i].c);
     }
     g_free(multifd_recv);
@@ -669,8 +714,10 @@ void migrate_multifd_recv_threads_create(void)
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->init, 0);
         qemu_sem_init(&p->ready, 0);
+        qemu_cond_init(&p->cond_sync);
         p->quit = false;
         p->done = false;
+        p->sync = false;
         multifd_init_group(&p->pages);
         p->c = socket_recv_channel_create();

@@ -721,6 +768,28 @@ static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
     qemu_sem_post(&params->sem);
 }

+
+static int multifd_flush(void)
+{
+    int i, thread_count;
+
+    if (!migrate_use_multifd()) {
+        return 0;
+    }
+    thread_count = migrate_multifd_threads();
+    for (i = 0; i < thread_count; i++) {
+        MultiFDRecvParams *p = &multifd_recv[i];
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
@@ -737,6 +806,12 @@ static size_t save_page_header(QEMUFile *f, RAMBlock *block, ram_addr_t offset)
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

@@ -1156,8 +1231,10 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
             save_page_header(f, block, offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
         fd_num = multifd_send_page(p, migration_dirty_pages == 1);
         qemu_put_be16(f, fd_num);
+        if (fd_num != UINT16_MAX) {
+            qemu_fflush(f);
+        }
         *bytes_transferred += 2; /* size of fd_num */
-        qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
         *bytes_transferred += TARGET_PAGE_SIZE;
         pages = 1;
         acct_info.norm_pages++;
@@ -2417,6 +2494,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)

     if (!migration_in_postcopy(migrate_get_current())) {
         migration_bitmap_sync();
+        if (migrate_use_multifd()) {
+            multifd_needs_flush = true;
+        }
     }

     ram_control_before_iterate(f, RAM_CONTROL_FINISH);
@@ -2458,6 +2538,9 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
         qemu_mutex_lock_iothread();
         rcu_read_lock();
         migration_bitmap_sync();
+        if (migrate_use_multifd()) {
+            multifd_needs_flush = true;
+        }
         rcu_read_unlock();
         qemu_mutex_unlock_iothread();
         remaining_size = ram_save_remaining() * TARGET_PAGE_SIZE;
@@ -2890,6 +2973,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
@@ -2971,7 +3059,6 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         case RAM_SAVE_FLAG_MULTIFD_PAGE:
             fd_num = qemu_get_be16(f);
             multifd_recv_page(host, fd_num);
-            qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
             break;

         case RAM_SAVE_FLAG_EOS:
-- 
2.7.4
