Received: from eggs.gnu.org ([2001:4830:134:3::10]:60384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpYse-0007fC-QQ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpYsd-00089O-FK
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dpYsd-00088w-6O
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:52:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F165461FA
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 11:52:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  6 Sep 2017 13:51:36 +0200
Message-Id: <20170906115143.27451-16-quintela@redhat.com>
In-Reply-To: <20170906115143.27451-1-quintela@redhat.com>
References: <20170906115143.27451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v7 15/22] migration: Create ram_multifd_page
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
---
 hmp.c                 |  2 ++
 migration/migration.c |  1 +
 migration/ram.c       | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 qapi/migration.json   |  5 ++-
 4 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index d9562103ee..7e865f5955 100644
--- a/hmp.c
+++ b/hmp.c
@@ -233,6 +233,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
             monitor_printf(mon, "postcopy request count: %" PRIu64 "\n",
                            info->ram->postcopy_requests);
         }
+        monitor_printf(mon, "multifd: %" PRIu64 " pages\n",
+                       info->ram->multifd);
     }
 
     if (info->has_disk) {
diff --git a/migration/migration.c b/migration/migration.c
index b06de8b189..b5875c0b15 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -556,6 +556,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->dirty_sync_count = ram_counters.dirty_sync_count;
     info->ram->postcopy_requests = ram_counters.postcopy_requests;
     info->ram->page_size = qemu_target_page_size();
+    info->ram->multifd = ram_counters.multifd;
 
     if (migrate_use_xbzrle()) {
         info->has_xbzrle_cache = true;
diff --git a/migration/ram.c b/migration/ram.c
index 9d45f4c7ca..2ee2699bb2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -68,6 +68,7 @@
 #define RAM_SAVE_FLAG_XBZRLE   0x40
 /* 0x80 is reserved in migration.h start with 0x100 next */
 #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
+#define RAM_SAVE_FLAG_MULTIFD_PAGE     0x200
 
 static inline bool is_zero_range(uint8_t *p, uint64_t size)
 {
@@ -362,13 +363,23 @@ static void compress_threads_save_setup(void)
 /* Multiple fd's */
 
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
+    /* This is a temp field.  We are using it now to transmit
+       something the address of the page.  Later in the series, we
+       change it for the real page.
+    */
+    uint8_t *address;
+    /* protected by multifd mutex */
+    /* has the thread finish the last submitted job */
+    bool done;
 };
 typedef struct MultiFDSendParams MultiFDSendParams;
 
@@ -376,6 +387,8 @@ struct {
     MultiFDSendParams *params;
     /* number of created threads */
     int count;
+    QemuMutex mutex;
+    QemuSemaphore sem;
 } *multifd_send_state;
 
 static void terminate_multifd_send_threads(Error *errp)
@@ -450,6 +463,7 @@ static void *multifd_send_thread(void *opaque)
         terminate_multifd_send_threads(local_err);
         return NULL;
     }
+    qemu_sem_post(&multifd_send_state->sem);
 
     while (true) {
         qemu_mutex_lock(&p->mutex);
@@ -457,6 +471,15 @@ static void *multifd_send_thread(void *opaque)
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
@@ -477,6 +500,8 @@ int multifd_save_setup(void)
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
     multifd_send_state->count = 0;
+    qemu_mutex_init(&multifd_send_state->mutex);
+    qemu_sem_init(&multifd_send_state->sem, 0);
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -484,6 +509,8 @@ int multifd_save_setup(void)
         qemu_sem_init(&p->sem, 0);
         p->quit = false;
         p->id = i;
+        p->done = true;
+        p->address = 0;
         p->c = socket_send_channel_create(&local_err);
         if (!p->c) {
             if (multifd_save_cleanup(&local_err) != 0) {
@@ -500,6 +527,30 @@ int multifd_save_setup(void)
     return 0;
 }
 
+static uint16_t multifd_send_page(uint8_t *address, bool last_page)
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
     uint8_t id;
     char *name;
@@ -1082,6 +1133,32 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
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
+        ram_counters.multifd++;
+    }
+
+    return pages;
+}
+
 static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
                                 ram_addr_t offset)
 {
@@ -1510,6 +1587,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         if (migrate_use_compression() &&
             (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
             res = ram_save_compressed_page(rs, pss, last_stage);
+        } else if (migrate_use_multifd()) {
+            res = ram_multifd_page(rs, pss, last_stage);
         } else {
             res = ram_save_page(rs, pss, last_stage);
         }
@@ -2802,6 +2881,10 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
@@ -2826,13 +2909,17 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
@@ -2920,6 +3007,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
diff --git a/qapi/migration.json b/qapi/migration.json
index 6a838369ef..f7efa703de 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -39,6 +39,8 @@
 # @page-size: The number of bytes per page for the various page-based
 #        statistics (since 2.10)
 #
+# @multifd: number of pages sent with multifd (since 2.10)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'MigrationStats',
@@ -46,7 +48,8 @@
            'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
            'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
            'mbps' : 'number', 'dirty-sync-count' : 'int',
-           'postcopy-requests' : 'int', 'page-size' : 'int' } }
+           'postcopy-requests' : 'int', 'page-size' : 'int',
+           'multifd': 'int' } }
 
 ##
 # @XBZRLECacheStats:
-- 
2.13.5
