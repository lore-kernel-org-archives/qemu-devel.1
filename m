Received: from eggs.gnu.org ([2001:4830:134:3::10]:56501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLL-0004Q4-9a
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLJ-0005wU-S1
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnPLJ-0005w7-JU
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:53 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8D5E3B731
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 12:44:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Mar 2017 13:44:28 +0100
Message-Id: <20170313124434.1043-11-quintela@redhat.com>
In-Reply-To: <20170313124434.1043-1-quintela@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 10/16] migration: Create ram_multifd_page
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

The function still don't use multifd, but we have simplified
ram_save_page, xbzrle and RDMA stuff is gone.  We have added a new
counter and a new flag for this type of pages.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                         |  2 +
 include/migration/migration.h |  1 +
 migration/migration.c         |  1 +
 migration/ram.c               | 98 ++++++++++++++++++++++++++++++++++++++++++-
 qapi-schema.json              |  4 +-
 5 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index ab02773..1238d0f 100644
--- a/hmp.c
+++ b/hmp.c
@@ -223,6 +223,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
             monitor_printf(mon, "postcopy request count: %" PRIu64 "\n",
                            info->ram->postcopy_requests);
         }
+        monitor_printf(mon, "multifd: %" PRIu64 " pages\n",
+                       info->ram->multifd);
     }
 
     if (info->has_disk) {
diff --git a/include/migration/migration.h b/include/migration/migration.h
index cbb049d..bd152c5 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -301,6 +301,7 @@ uint64_t xbzrle_mig_pages_transferred(void);
 uint64_t xbzrle_mig_pages_overflow(void);
 uint64_t xbzrle_mig_pages_cache_miss(void);
 double xbzrle_mig_cache_miss_rate(void);
+uint64_t multifd_mig_pages_transferred(void);
 
 void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
 void ram_debug_dump_bitmap(unsigned long *todump, bool expected);
diff --git a/migration/migration.c b/migration/migration.c
index 5bbd688..a32e4ad 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -661,6 +661,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->mbps = s->mbps;
     info->ram->dirty_sync_count = s->dirty_sync_count;
     info->ram->postcopy_requests = s->postcopy_requests;
+    info->ram->multifd = multifd_mig_pages_transferred();
 
     if (s->state != MIGRATION_STATUS_COMPLETED) {
         info->ram->remaining = ram_bytes_remaining();
diff --git a/migration/ram.c b/migration/ram.c
index 7833e6f..ccd7fe9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -61,6 +61,7 @@ static uint64_t bitmap_sync_count;
 #define RAM_SAVE_FLAG_XBZRLE   0x40
 /* 0x80 is reserved in migration.h start with 0x100 next */
 #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
+#define RAM_SAVE_FLAG_MULTIFD_PAGE     0x200
 
 static uint8_t *ZERO_TARGET_PAGE;
 
@@ -141,6 +142,7 @@ typedef struct AccountingInfo {
     uint64_t dup_pages;
     uint64_t skipped_pages;
     uint64_t norm_pages;
+    uint64_t multifd_pages;
     uint64_t iterations;
     uint64_t xbzrle_bytes;
     uint64_t xbzrle_pages;
@@ -211,6 +213,11 @@ uint64_t xbzrle_mig_pages_overflow(void)
     return acct_info.xbzrle_overflows;
 }
 
+uint64_t multifd_mig_pages_transferred(void)
+{
+    return acct_info.multifd_pages;
+}
+
 /* This is the last block that we have visited serching for dirty pages
  */
 static RAMBlock *last_seen_block;
@@ -385,13 +392,18 @@ void migrate_compress_threads_create(void)
 /* Multiple fd's */
 
 struct MultiFDSendParams {
+    /* not changed */
     int id;
     QemuThread thread;
     QIOChannel *c;
     QemuSemaphore sem;
     QemuSemaphore init;
     QemuMutex mutex;
+    /* protected by param mutex */
     bool quit;
+    uint8_t *address;
+    /* protected by multifd mutex */
+    bool done;
 };
 typedef struct MultiFDSendParams MultiFDSendParams;
 
@@ -399,6 +411,8 @@ struct {
     MultiFDSendParams *params;
     /* number o6 created threads */
     int count;
+    QemuMutex mutex;
+    QemuSemaphore sem;
 } *multifd_send_state;
 
 static void terminate_multifd_send_threads(void)
@@ -441,11 +455,11 @@ void migrate_multifd_send_threads_join(void)
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
-
     char start = 's';
 
     qio_channel_write(p->c, &start, 1, &error_abort);
     qemu_sem_post(&p->init);
+    qemu_sem_post(&multifd_send_state->sem);
 
     while (true) {
         qemu_mutex_lock(&p->mutex);
@@ -453,6 +467,15 @@ static void *multifd_send_thread(void *opaque)
             qemu_mutex_unlock(&p->mutex);
             break;
         }
+        if (p->address) {
+            p->address = 0;
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
@@ -471,6 +494,8 @@ int migrate_multifd_send_threads_create(void)
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
     multifd_send_state->count = 0;
+    qemu_mutex_init(&multifd_send_state->mutex);
+    qemu_sem_init(&multifd_send_state->sem, 0);
     for (i = 0; i < thread_count; i++) {
         char thread_name[15];
         MultiFDSendParams *p = &multifd_send_state->params[i];
@@ -480,6 +505,8 @@ int migrate_multifd_send_threads_create(void)
         qemu_sem_init(&p->init, 0);
         p->quit = false;
         p->id = i;
+        p->done = true;
+        p->address = 0;
         p->c = socket_send_channel_create();
         if (!p->c) {
             error_report("Error creating a send channel");
@@ -495,6 +522,30 @@ int migrate_multifd_send_threads_create(void)
     return 0;
 }
 
+static int multifd_send_page(uint8_t *address)
+{
+    int i;
+    MultiFDSendParams *p = NULL; /* make happy gcc */
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
+    p->address = address;
+    qemu_mutex_unlock(&p->mutex);
+    qemu_sem_post(&p->sem);
+
+    return 0;
+}
+
 struct MultiFDRecvParams {
     int id;
     QemuThread thread;
@@ -1050,6 +1101,34 @@ static int ram_save_page(MigrationState *ms, QEMUFile *f, PageSearchStatus *pss,
     return pages;
 }
 
+static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
+                            bool last_stage, uint64_t *bytes_transferred)
+{
+    int pages;
+    uint8_t *p;
+    RAMBlock *block = pss->block;
+    ram_addr_t offset = pss->offset;
+
+    p = block->host + offset;
+
+    if (block == last_sent_block) {
+        offset |= RAM_SAVE_FLAG_CONTINUE;
+    }
+    pages = save_zero_page(f, block, offset, p, bytes_transferred);
+    if (pages == -1) {
+        *bytes_transferred +=
+            save_page_header(f, block, offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
+        qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
+        multifd_send_page(p);
+        *bytes_transferred += TARGET_PAGE_SIZE;
+        pages = 1;
+        acct_info.norm_pages++;
+        acct_info.multifd_pages++;
+    }
+
+    return pages;
+}
+
 static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
                                 ram_addr_t offset)
 {
@@ -1495,6 +1574,8 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
             res = ram_save_compressed_page(ms, f, pss,
                                            last_stage,
                                            bytes_transferred);
+        } else if (migrate_use_multifd()) {
+            res = ram_multifd_page(f, pss, last_stage, bytes_transferred);
         } else {
             res = ram_save_page(ms, f, pss, last_stage,
                                 bytes_transferred);
@@ -2765,6 +2846,10 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
@@ -2789,13 +2874,17 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             if (flags & invalid_flags  & RAM_SAVE_FLAG_COMPRESS_PAGE) {
                 error_report("Received an unexpected compressed page");
             }
+            if (flags & invalid_flags  & RAM_SAVE_FLAG_MULTIFD_PAGE) {
+                error_report("Received an unexpected multifd page");
+            }
 
             ret = -EINVAL;
             break;
         }
 
         if (flags & (RAM_SAVE_FLAG_COMPRESS | RAM_SAVE_FLAG_PAGE |
-                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
+                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE |
+                     RAM_SAVE_FLAG_MULTIFD_PAGE)) {
             RAMBlock *block = ram_block_from_stream(f, flags);
 
             host = host_from_ram_block_offset(block, addr);
@@ -2882,6 +2971,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
diff --git a/qapi-schema.json b/qapi-schema.json
index 33a6267..0286b75 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -574,6 +574,7 @@
 #
 # @postcopy-requests: The number of page requests received from the destination
 #        (since 2.7)
+# @multifd: number of pages sent with multifd (since 2.9)
 #
 # Since: 0.14.0
 ##
@@ -582,7 +583,8 @@
            'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
            'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
            'mbps' : 'number', 'dirty-sync-count' : 'int',
-           'postcopy-requests' : 'int' } }
+           'postcopy-requests' : 'int',
+           'multifd' : 'int'} }
 
 ##
 # @XBZRLECacheStats:
-- 
2.9.3
