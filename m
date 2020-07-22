Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3821BC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC1320657
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC1320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy9tm-0003Rk-8l
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jy9qw-0007kl-FS
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:11:50 -0400
Received: from relay.sw.ru ([185.231.240.75]:54954 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jy9qq-0004p4-MO
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:11:48 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jy9ql-0002yK-S4; Wed, 22 Jul 2020 11:11:39 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v0 3/4] migration: add background snapshot
Date: Wed, 22 Jul 2020 11:11:32 +0300
Message-Id: <20200722081133.29926-4-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=dplotnikov@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 04:11:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_BL_SPAMCOP_NET=1.347,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com,
 armbru@redhat.com, den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By the moment, making a vm snapshot may cause a significant vm downtime,
depending on the vm RAM size and the performance of disk storing
the vm snapshot. This happens because the VM has to be paused until all
vmstate including RAM is written.

To reduce the downtime, the background snapshot capability is used.
With the capability enabled, the vm is paused for a small amount of time while
the smallest vmstate part (all, except RAM) is writen. RAM, the biggest part
of vmstate, is written with running VM.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 include/exec/ramblock.h |   8 +
 include/exec/ramlist.h  |   2 +
 migration/ram.h         |  19 +-
 migration/savevm.h      |   3 +
 migration/migration.c   | 107 +++++++-
 migration/ram.c         | 578 ++++++++++++++++++++++++++++++++++++++--
 migration/savevm.c      |   1 -
 7 files changed, 698 insertions(+), 20 deletions(-)

diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 07d50864d8..421e128ef6 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -59,6 +59,14 @@ struct RAMBlock {
      */
     unsigned long *clear_bmap;
     uint8_t clear_bmap_shift;
+
+    /* The following 3 elements are for background snapshot */
+    /* List of blocks used for background snapshot */
+    QLIST_ENTRY(RAMBlock) bgs_next;
+    /* Pages currently being copied */
+    unsigned long *touched_map;
+    /* Pages has been copied already */
+    unsigned long *copied_map;
 };
 #endif
 #endif
diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
index bc4faa1b00..74e2a1162c 100644
--- a/include/exec/ramlist.h
+++ b/include/exec/ramlist.h
@@ -44,6 +44,8 @@ typedef struct {
     unsigned long *blocks[];
 } DirtyMemoryBlocks;
 
+typedef QLIST_HEAD(, RAMBlock) RamBlockList;
+
 typedef struct RAMList {
     QemuMutex mutex;
     RAMBlock *mru_block;
diff --git a/migration/ram.h b/migration/ram.h
index 2eeaacfa13..769b8087ae 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -42,7 +42,8 @@ uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
 
 uint64_t ram_pagesize_summary(void);
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
+int ram_save_queue_pages(RAMBlock *block, const char *rbname,
+                         ram_addr_t start, ram_addr_t len, void *page_copy);
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
 void ram_debug_dump_bitmap(unsigned long *todump, bool expected,
                            unsigned long pages);
@@ -69,4 +70,20 @@ void colo_flush_ram_cache(void);
 void colo_release_ram_cache(void);
 void colo_incoming_start_dirty_log(void);
 
+/* for background snapshot */
+void ram_block_list_create(void);
+void ram_block_list_destroy(void);
+RAMBlock *ram_bgs_block_find(uint64_t address, ram_addr_t *page_offset);
+
+void *ram_page_buffer_get(void);
+int ram_page_buffer_free(void *buffer);
+
+int ram_block_list_set_readonly(void);
+int ram_block_list_set_writable(void);
+
+int ram_copy_page(RAMBlock *block, unsigned long page_nr, void **page_copy);
+int ram_process_page_fault(uint64_t address);
+
+int ram_write_tracking_start(void);
+void ram_write_tracking_stop(void);
 #endif
diff --git a/migration/savevm.h b/migration/savevm.h
index ba64a7e271..4f4edffa85 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,5 +64,8 @@ int qemu_loadvm_state(QEMUFile *f);
 void qemu_loadvm_state_cleanup(void);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
+int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
+                                                    bool in_postcopy,
+                                                    bool inactivate_disks);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 2ec0451abe..dc56e4974f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -55,6 +55,7 @@
 #include "net/announce.h"
 #include "qemu/queue.h"
 #include "multifd.h"
+#include "sysemu/cpus.h"
 
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
 
@@ -2473,7 +2474,7 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
         return;
     }
 
-    if (ram_save_queue_pages(rbname, start, len)) {
+    if (ram_save_queue_pages(NULL, rbname, start, len, NULL)) {
         mark_source_rp_bad(ms);
     }
 }
@@ -3536,6 +3537,100 @@ static void *migration_thread(void *opaque)
     return NULL;
 }
 
+static void *background_snapshot_thread(void *opaque)
+{
+    MigrationState *m = opaque;
+    QIOChannelBuffer *bioc;
+    QEMUFile *fb;
+    int res = 0;
+
+    rcu_register_thread();
+
+    qemu_file_set_rate_limit(m->to_dst_file, INT64_MAX);
+
+    qemu_mutex_lock_iothread();
+    vm_stop(RUN_STATE_PAUSED);
+
+    qemu_savevm_state_header(m->to_dst_file);
+    qemu_mutex_unlock_iothread();
+    qemu_savevm_state_setup(m->to_dst_file);
+    qemu_mutex_lock_iothread();
+
+    migrate_set_state(&m->state, MIGRATION_STATUS_SETUP,
+                      MIGRATION_STATUS_ACTIVE);
+
+    /*
+     * We want to save the vm state for the moment when the snapshot saving was
+     * called but also we want to write RAM content with vm running. The RAM
+     * content should appear first in the vmstate.
+     * So, we first, save non-ram part of the vmstate to the temporary, buffer,
+     * then write ram part of the vmstate to the migration stream with vCPUs
+     * running and, finally, write the non-ram part of the vmstate from the
+     * buffer to the migration stream.
+     */
+    bioc = qio_channel_buffer_new(4096);
+    qio_channel_set_name(QIO_CHANNEL(bioc), "vmstate-buffer");
+    fb = qemu_fopen_channel_output(QIO_CHANNEL(bioc));
+    object_unref(OBJECT(bioc));
+
+    if (ram_write_tracking_start()) {
+        goto failed_resume;
+    }
+
+    if (global_state_store()) {
+        goto failed_resume;
+    }
+
+    cpu_synchronize_all_states();
+
+    if (qemu_savevm_state_complete_precopy_non_iterable(fb, false, false)) {
+        goto failed_resume;
+    }
+
+    vm_start();
+    qemu_mutex_unlock_iothread();
+
+    while (!res) {
+        res = qemu_savevm_state_iterate(m->to_dst_file, false);
+
+        if (res < 0 || qemu_file_get_error(m->to_dst_file)) {
+            goto failed;
+        }
+    }
+
+    /*
+     * By this moment we have RAM content saved into the migration stream.
+     * The next step is to flush the non-ram content (vm devices state)
+     * right after the ram content. The device state was stored in
+     * the temporary buffer prior to the ram saving.
+     */
+    qemu_put_buffer(m->to_dst_file, bioc->data, bioc->usage);
+    qemu_fflush(m->to_dst_file);
+
+    if (qemu_file_get_error(m->to_dst_file)) {
+        goto failed;
+    }
+
+    migrate_set_state(&m->state, MIGRATION_STATUS_ACTIVE,
+                                 MIGRATION_STATUS_COMPLETED);
+    goto exit;
+
+failed_resume:
+    vm_start();
+    qemu_mutex_unlock_iothread();
+failed:
+    migrate_set_state(&m->state, MIGRATION_STATUS_ACTIVE,
+                      MIGRATION_STATUS_FAILED);
+exit:
+    ram_write_tracking_stop();
+    qemu_fclose(fb);
+    qemu_mutex_lock_iothread();
+    qemu_savevm_state_cleanup();
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
+    return NULL;
+}
+
 void migrate_fd_connect(MigrationState *s, Error *error_in)
 {
     Error *local_err = NULL;
@@ -3599,8 +3694,14 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         migrate_fd_cleanup(s);
         return;
     }
-    qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
-                       QEMU_THREAD_JOINABLE);
+    if (migrate_background_snapshot()) {
+        qemu_thread_create(&s->thread, "bg_snapshot",
+                           background_snapshot_thread, s,
+                           QEMU_THREAD_JOINABLE);
+    } else {
+        qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
+                           QEMU_THREAD_JOINABLE);
+    }
     s->migration_thread_running = true;
 }
 
diff --git a/migration/ram.c b/migration/ram.c
index 76d4fee5d5..f187b5b494 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -56,6 +56,12 @@
 #include "savevm.h"
 #include "qemu/iov.h"
 #include "multifd.h"
+#include <sys/syscall.h>
+#include <sys/ioctl.h>
+#include <linux/userfaultfd.h>
+#include <sys/eventfd.h>
+#include <inttypes.h>
+#include <poll.h>
 
 /***********************************************************/
 /* ram save/restore */
@@ -297,10 +303,27 @@ struct RAMSrcPageRequest {
     RAMBlock *rb;
     hwaddr    offset;
     hwaddr    len;
+    void     *page_copy;
 
     QSIMPLEQ_ENTRY(RAMSrcPageRequest) next_req;
 };
 
+/* Page buffer used for background snapshot */
+typedef struct RAMPageBuffer {
+    /* Page buffer capacity in host pages */
+    int capacity;
+    /* Current number of pages in the buffer */
+    int used;
+    /* Mutex to protect the page buffer */
+    QemuMutex lock;
+    /* To notify the requestor when the page buffer can be accessed again */
+    /* Page buffer allows access when used < capacity */
+    QemuCond used_decreased_cond;
+} RAMPageBuffer;
+
+/* RAMPageBuffer capacity */
+#define PAGE_BUFFER_CAPACITY 1000
+
 /* State of RAM for migration */
 struct RAMState {
     /* QEMUFile used for this migration */
@@ -354,6 +377,12 @@ struct RAMState {
     /* Queue of outstanding page requests from the destination */
     QemuMutex src_page_req_mutex;
     QSIMPLEQ_HEAD(, RAMSrcPageRequest) src_page_requests;
+    /* For background snapshot */
+    /* Data buffer to store copies of ram pages on backgound snapshot */
+    RAMPageBuffer page_buffer;
+    QemuEvent page_copying_done;
+    /* The number of threads trying to make a page copy */
+    uint64_t page_copier_cnt;
 };
 typedef struct RAMState RAMState;
 
@@ -410,6 +439,8 @@ struct PageSearchStatus {
     unsigned long page;
     /* Set once we wrap around */
     bool         complete_round;
+    /* Pointer to the cached page */
+    void *page_copy;
 };
 typedef struct PageSearchStatus PageSearchStatus;
 
@@ -1051,11 +1082,14 @@ static void migration_bitmap_sync_precopy(RAMState *rs)
  * @file: the file where the data is saved
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
+ * @page_copy: pointer to the page, if null the page pointer
+ *             is calculated based on block and offset
  */
 static int save_zero_page_to_file(RAMState *rs, QEMUFile *file,
-                                  RAMBlock *block, ram_addr_t offset)
+                                  RAMBlock *block, ram_addr_t offset,
+                                  uint8_t *page_copy)
 {
-    uint8_t *p = block->host + offset;
+    uint8_t *p = page_copy ? page_copy : block->host + offset;
     int len = 0;
 
     if (is_zero_range(p, TARGET_PAGE_SIZE)) {
@@ -1074,10 +1108,13 @@ static int save_zero_page_to_file(RAMState *rs, QEMUFile *file,
  * @rs: current RAM state
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
+ * @page_copy: pointer to the page, if null the page pointer
+ *             is calculated based on block and offset
  */
-static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset)
+static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
+                          uint8_t *page_copy)
 {
-    int len = save_zero_page_to_file(rs, rs->f, block, offset);
+    int len = save_zero_page_to_file(rs, rs->f, block, offset, page_copy);
 
     if (len) {
         ram_counters.duplicate++;
@@ -1151,9 +1188,11 @@ static int save_normal_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
     ram_counters.transferred += save_page_header(rs, rs->f, block,
                                                  offset | RAM_SAVE_FLAG_PAGE);
     if (async) {
-        qemu_put_buffer_async(rs->f, buf, TARGET_PAGE_SIZE,
-                              migrate_release_ram() &
-                              migration_in_postcopy());
+        bool may_free = migrate_background_snapshot() ||
+                        (migrate_release_ram() &&
+                         migration_in_postcopy());
+
+        qemu_put_buffer_async(rs->f, buf, TARGET_PAGE_SIZE, may_free);
     } else {
         qemu_put_buffer(rs->f, buf, TARGET_PAGE_SIZE);
     }
@@ -1184,7 +1223,12 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
     ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     ram_addr_t current_addr = block->offset + offset;
 
-    p = block->host + offset;
+    if (pss->page_copy) {
+        p = pss->page_copy;
+    } else {
+        p = block->host + offset;
+    }
+
     trace_ram_save_page(block->idstr, (uint64_t)offset, p);
 
     XBZRLE_cache_lock();
@@ -1229,7 +1273,7 @@ static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
     bool zero_page = false;
     int ret;
 
-    if (save_zero_page_to_file(rs, f, block, offset)) {
+    if (save_zero_page_to_file(rs, f, block, offset, NULL)) {
         zero_page = true;
         goto exit;
     }
@@ -1412,7 +1456,8 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss, bool *again)
  * @rs: current RAM state
  * @offset: used to return the offset within the RAMBlock
  */
-static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
+static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
+                              void **page_copy)
 {
     RAMBlock *block = NULL;
 
@@ -1426,10 +1471,14 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
                                 QSIMPLEQ_FIRST(&rs->src_page_requests);
         block = entry->rb;
         *offset = entry->offset;
+        *page_copy = entry->page_copy;
 
         if (entry->len > TARGET_PAGE_SIZE) {
             entry->len -= TARGET_PAGE_SIZE;
             entry->offset += TARGET_PAGE_SIZE;
+            if (entry->page_copy) {
+                entry->page_copy += TARGET_PAGE_SIZE / sizeof(void *);
+            }
         } else {
             memory_region_unref(block->mr);
             QSIMPLEQ_REMOVE_HEAD(&rs->src_page_requests, next_req);
@@ -1456,9 +1505,10 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
     RAMBlock  *block;
     ram_addr_t offset;
     bool dirty;
+    void *page_copy;
 
     do {
-        block = unqueue_page(rs, &offset);
+        block = unqueue_page(rs, &offset, &page_copy);
         /*
          * We're sending this page, and since it's postcopy nothing else
          * will dirty it, and we must make sure it doesn't get sent again
@@ -1502,6 +1552,7 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
          * really rare.
          */
         pss->complete_round = false;
+        pss->page_copy = page_copy;
     }
 
     return !!block;
@@ -1536,12 +1587,17 @@ static void migration_page_queue_free(RAMState *rs)
  *
  * Returns zero on success or negative on error
  *
+ * @block: RAMBlock to use.
+ *         When @block is provided, then @rbname is ignored.
  * @rbname: Name of the RAMBLock of the request. NULL means the
  *          same that last one.
  * @start: starting address from the start of the RAMBlock
  * @len: length (in bytes) to send
+ * @page_copy: the page to copy to destination. If not specified,
+ *             will use the page data specified by @start and @len.
  */
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
+int ram_save_queue_pages(RAMBlock *block, const char *rbname,
+                         ram_addr_t start, ram_addr_t len, void *page_copy)
 {
     RAMBlock *ramblock;
     RAMState *rs = ram_state;
@@ -1549,7 +1605,9 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
     ram_counters.postcopy_requests++;
     RCU_READ_LOCK_GUARD();
 
-    if (!rbname) {
+    if (block) {
+        ramblock = block;
+    } else if (!rbname) {
         /* Reuse last RAMBlock */
         ramblock = rs->last_req_rb;
 
@@ -1584,6 +1642,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
     new_entry->rb = ramblock;
     new_entry->offset = start;
     new_entry->len = len;
+    new_entry->page_copy = page_copy;
 
     memory_region_ref(ramblock->mr);
     qemu_mutex_lock(&rs->src_page_req_mutex);
@@ -1670,7 +1729,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         return 1;
     }
 
-    res = save_zero_page(rs, block, offset);
+    res = save_zero_page(rs, block, offset, pss->page_copy);
     if (res > 0) {
         /* Must let xbzrle know, otherwise a previous (now 0'd) cached
          * page would be stale
@@ -1680,7 +1739,12 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
             xbzrle_cache_zero_page(rs, block->offset + offset);
             XBZRLE_cache_unlock();
         }
-        ram_release_pages(block->idstr, offset, res);
+
+        if (pss->page_copy) {
+            qemu_madvise(pss->page_copy, TARGET_PAGE_SIZE, MADV_DONTNEED);
+        } else {
+            ram_release_pages(block->idstr, offset, res);
+        }
         return res;
     }
 
@@ -1753,6 +1817,434 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
     return pages;
 }
 
+/* BackGround Snapshot Blocks */
+static RamBlockList bgs_blocks;
+
+static RamBlockList *ram_bgs_block_list_get(void)
+{
+    return &bgs_blocks;
+}
+
+void ram_block_list_create(void)
+{
+    RAMBlock *block = NULL;
+    RamBlockList *block_list = ram_bgs_block_list_get();
+
+    qemu_mutex_lock_ramlist();
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        memory_region_ref(block->mr);
+        QLIST_INSERT_HEAD(block_list, block, bgs_next);
+    }
+    qemu_mutex_unlock_ramlist();
+}
+
+static int page_fault_fd;
+static int thread_quit_fd;
+static QemuThread page_fault_thread;
+
+static int mem_change_wp(void *addr, uint64_t length, bool protect)
+{
+    struct uffdio_writeprotect wp = { 0 };
+
+    assert(page_fault_fd);
+
+    if (protect) {
+        struct uffdio_register reg = { 0 };
+
+        reg.mode = UFFDIO_REGISTER_MODE_WP;
+        reg.range.start = (uint64_t) addr;
+        reg.range.len = length;
+
+        if (ioctl(page_fault_fd, UFFDIO_REGISTER, &reg)) {
+            error_report("Can't register memeory at %p len: %"PRIu64
+                         " for page fault interception", addr, length);
+            return -1;
+        }
+
+        wp.mode = UFFDIO_WRITEPROTECT_MODE_WP;
+    }
+
+    wp.range.start = (uint64_t) addr;
+    wp.range.len = length;
+
+    if (ioctl(page_fault_fd, UFFDIO_WRITEPROTECT, &wp)) {
+        error_report("Can't change protection at %p len: %"PRIu64,
+                     addr, length);
+        return -1;
+    }
+
+    return 0;
+}
+
+static int ram_set_ro(void *addr, uint64_t length)
+{
+    return mem_change_wp(addr, length, true);
+}
+
+static int ram_set_rw(void *addr, uint64_t length)
+{
+    return mem_change_wp(addr, length, false);
+}
+
+int ram_block_list_set_readonly(void)
+{
+    RAMBlock *block = NULL;
+    RamBlockList *block_list = ram_bgs_block_list_get();
+    int ret = 0;
+
+    QLIST_FOREACH(block, block_list, bgs_next) {
+        ret = ram_set_ro(block->host, block->used_length);
+        if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
+int ram_block_list_set_writable(void)
+{
+    RAMBlock *block = NULL;
+    RamBlockList *block_list = ram_bgs_block_list_get();
+    int ret = 0;
+
+    QLIST_FOREACH(block, block_list, bgs_next) {
+        ret = ram_set_rw(block->host, block->used_length);
+        if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
+void ram_block_list_destroy(void)
+{
+    RAMBlock *next, *block;
+    RamBlockList *block_list = ram_bgs_block_list_get();
+
+    QLIST_FOREACH_SAFE(block, block_list, bgs_next, next) {
+        QLIST_REMOVE(block, bgs_next);
+        memory_region_unref(block->mr);
+    }
+}
+
+static void ram_page_buffer_decrease_used(void)
+{
+    qemu_mutex_lock(&ram_state->page_buffer.lock);
+    ram_state->page_buffer.used--;
+    qemu_cond_signal(&ram_state->page_buffer.used_decreased_cond);
+    qemu_mutex_unlock(&ram_state->page_buffer.lock);
+}
+
+static void ram_page_buffer_increase_used_wait(void)
+{
+    RAMState *rs = ram_state;
+
+    qemu_mutex_lock(&rs->page_buffer.lock);
+
+    if (rs->page_buffer.used == rs->page_buffer.capacity) {
+        qemu_cond_wait(&rs->page_buffer.used_decreased_cond,
+                       &rs->page_buffer.lock);
+    }
+
+    rs->page_buffer.used++;
+
+    qemu_mutex_unlock(&rs->page_buffer.lock);
+}
+
+void *ram_page_buffer_get(void)
+{
+    void *page;
+    ram_page_buffer_increase_used_wait();
+    page = mmap(0, TARGET_PAGE_SIZE, PROT_READ | PROT_WRITE,
+                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+    if (page == MAP_FAILED) {
+        ram_page_buffer_decrease_used();
+        page = NULL;
+    }
+    return page;
+}
+
+int ram_page_buffer_free(void *buffer)
+{
+    ram_page_buffer_decrease_used();
+    return qemu_madvise(buffer, TARGET_PAGE_SIZE, MADV_DONTNEED);
+}
+
+RAMBlock *ram_bgs_block_find(uint64_t address, ram_addr_t *page_offset)
+{
+    RAMBlock *block = NULL;
+    RamBlockList *block_list = ram_bgs_block_list_get();
+
+    QLIST_FOREACH(block, block_list, bgs_next) {
+        uint64_t host = (uint64_t) block->host;
+        if (address - host < block->max_length) {
+            *page_offset = (address - host) & TARGET_PAGE_MASK;
+            return block;
+        }
+    }
+
+    return NULL;
+}
+
+/**
+ * ram_copy_page: make a page copy
+ *
+ * Used in the background snapshot to make a copy of a memeory page.
+ * Ensures that the memeory page is copied only once.
+ * When a page copy is done, restores read/write access to the memory
+ * page.
+ * If a page is being copied by another thread, wait until the copying
+ * ends and exit.
+ *
+ * Returns:
+ *   -1 - on error
+ *    0 - the page wasn't copied by the function call
+ *    1 - the page has been copied
+ *
+ * @block:     RAM block to use
+ * @page_nr:   the page number to copy
+ * @page_copy: the pointer to return a page copy
+ *
+ */
+int ram_copy_page(RAMBlock *block, unsigned long page_nr,
+                          void **page_copy)
+{
+    void *host_page;
+    int res = 0;
+
+    atomic_inc(&ram_state->page_copier_cnt);
+
+    if (test_and_set_bit_atomic(page_nr, block->touched_map)) {
+        while (!test_bit_atomic(page_nr, block->copied_map)) {
+            /* the page is being copied -- wait for the end of the copying */
+            qemu_event_wait(&ram_state->page_copying_done);
+        }
+        goto out;
+    }
+
+    *page_copy = ram_page_buffer_get();
+    if (!*page_copy) {
+        res = -1;
+        goto out;
+    }
+
+    host_page = block->host + (page_nr << TARGET_PAGE_BITS);
+    memcpy(*page_copy, host_page, TARGET_PAGE_SIZE);
+
+    if (ram_set_rw(host_page, TARGET_PAGE_SIZE)) {
+        ram_page_buffer_free(*page_copy);
+        *page_copy = NULL;
+        res = -1;
+        goto out;
+    }
+
+    set_bit_atomic(page_nr, block->copied_map);
+    qemu_event_set(&ram_state->page_copying_done);
+    qemu_event_reset(&ram_state->page_copying_done);
+
+    res = 1;
+out:
+    atomic_dec(&ram_state->page_copier_cnt);
+    return res;
+}
+
+/**
+ * ram_process_page_fault
+ *
+ * Used in the background snapshot to queue the copy of the memory
+ * page for writing.
+ *
+ * Returns:
+ *    0 > - on error
+ *    0   - success
+ *
+ * @address:  address of the faulted page
+ *
+ */
+int ram_process_page_fault(uint64_t address)
+{
+    int ret;
+    void *page_copy = NULL;
+    unsigned long page_nr;
+    ram_addr_t offset;
+
+    RAMBlock *block = ram_bgs_block_find(address, &offset);
+
+    if (!block) {
+        return -1;
+    }
+
+    page_nr = offset >> TARGET_PAGE_BITS;
+
+    ret = ram_copy_page(block, page_nr, &page_copy);
+
+    if (ret < 0) {
+        return ret;
+    } else if (ret > 0) {
+        if (ram_save_queue_pages(block, NULL, offset,
+                                 TARGET_PAGE_SIZE, page_copy)) {
+            ram_page_buffer_free(page_copy);
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+static int get_page_fault_fd(void)
+{
+    struct uffdio_api api_struct = { 0 };
+    uint64_t ioctl_mask = BIT(_UFFDIO_REGISTER) | BIT(_UFFDIO_UNREGISTER);
+    int ufd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+
+    if (ufd == -1) {
+        error_report("UFFD: not supported");
+        return -1;
+    }
+
+    api_struct.api = UFFD_API;
+    api_struct.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+
+    if (ioctl(ufd, UFFDIO_API, &api_struct)) {
+        error_report("UFFD: API failed");
+        return -1;
+    }
+
+    if ((api_struct.ioctls & ioctl_mask) != ioctl_mask) {
+        error_report("UFFD: missing write-protected feature");
+        return -1;
+    }
+
+    return ufd;
+}
+
+static void *page_fault_thread_fn(void *unused)
+{
+    GPollFD fds[2] = {
+        {.fd = page_fault_fd, .events = POLLIN | POLLERR | POLLHUP },
+        {.fd = thread_quit_fd, .events = POLLIN | POLLERR | POLLHUP },
+    };
+
+    while (true) {
+        struct uffd_msg msg;
+        ssize_t len;
+        int ret;
+
+        ret = qemu_poll_ns(fds, 2, -1);
+
+        if (ret < 0) {
+            error_report("page fault: error on fd polling: %d", ret);
+            break;
+        }
+
+        if (fds[1].revents) {
+            break;
+        }
+again:
+        len = read(fds[0].fd, &msg, sizeof(msg));
+
+        if (len == 0) {
+            break;
+        }
+
+        if (len < 0) {
+            error_report("page fault: error on uffd reading: %d", -errno);
+            if (errno == EAGAIN) {
+                goto again;
+            } else {
+                break;
+            }
+        }
+
+        if (msg.event != UFFD_EVENT_PAGEFAULT) {
+            error_report("page fault: unknown event from uffd: %d",
+                         msg.event);
+            break;
+        }
+
+        if (!(msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP)) {
+            error_report("page fault: error. got address "
+                         "without write protection flag [0x%llx]",
+                         msg.arg.pagefault.address);
+            break;
+        }
+
+        if (ram_process_page_fault(msg.arg.pagefault.address) < 0) {
+            error_report("page fault: error on write protected page "
+                         "processing [0x%llx]",
+                         msg.arg.pagefault.address);
+            break;
+        }
+    }
+
+    return NULL;
+}
+
+static int page_fault_thread_start(void)
+{
+    page_fault_fd = get_page_fault_fd();
+    if (page_fault_fd == -1) {
+        page_fault_fd = 0;
+        error_report("page fault thread: can't initiate uffd");
+        return -1;
+    }
+
+    thread_quit_fd = eventfd(0, 0);
+    if (thread_quit_fd == -1) {
+        thread_quit_fd = 0;
+        error_report("page fault thread: can't initiate thread control fd");
+        return -1;
+    }
+
+    qemu_thread_create(&page_fault_thread, "pagefault_thrd",
+                       page_fault_thread_fn, (void *) 0,
+                       QEMU_THREAD_JOINABLE);
+
+    return 0;
+}
+
+static void page_fault_thread_stop(void)
+{
+    if (page_fault_fd) {
+        close(page_fault_fd);
+        page_fault_fd = 0;
+    }
+
+    if (thread_quit_fd) {
+        uint64_t val = 1;
+        int ret;
+
+        ret = write(thread_quit_fd, &val, sizeof(val));
+        assert(ret == sizeof(val));
+
+        qemu_thread_join(&page_fault_thread);
+        close(thread_quit_fd);
+        thread_quit_fd = 0;
+    }
+}
+
+int ram_write_tracking_start(void)
+{
+    if (page_fault_thread_start()) {
+        return -1;
+    }
+
+    ram_block_list_create();
+    ram_block_list_set_readonly();
+
+    return 0;
+}
+
+void ram_write_tracking_stop(void)
+{
+    ram_block_list_set_writable();
+    page_fault_thread_stop();
+    ram_block_list_destroy();
+}
+
 /**
  * ram_find_and_save_block: finds a dirty page and sends it to f
  *
@@ -1782,6 +2274,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
     pss.block = rs->last_seen_block;
     pss.page = rs->last_page;
     pss.complete_round = false;
+    pss.page_copy = NULL;
 
     if (!pss.block) {
         pss.block = QLIST_FIRST_RCU(&ram_list.blocks);
@@ -1794,11 +2287,30 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
         if (!found) {
             /* priority queue empty, so just search for something dirty */
             found = find_dirty_block(rs, &pss, &again);
+
+            if (found && migrate_background_snapshot()) {
+                /*
+                 * make a copy of the page and
+                 * pass it to the page search status
+                 */
+                int ret;
+                ret = ram_copy_page(pss.block, pss.page, &pss.page_copy);
+                if (ret == 0) {
+                    found = false;
+                    pages = 0;
+                } else if (ret < 0) {
+                    return ret;
+                }
+            }
         }
 
         if (found) {
             pages = ram_save_host_page(rs, &pss, last_stage);
         }
+
+        if (pss.page_copy) {
+            ram_page_buffer_decrease_used();
+        }
     } while (!pages && again);
 
     rs->last_seen_block = pss.block;
@@ -1858,6 +2370,18 @@ static void xbzrle_load_cleanup(void)
 static void ram_state_cleanup(RAMState **rsp)
 {
     if (*rsp) {
+        if (migrate_background_snapshot()) {
+            qemu_mutex_destroy(&(*rsp)->page_buffer.lock);
+            qemu_cond_destroy(&(*rsp)->page_buffer.used_decreased_cond);
+            /* In case somebody is still waiting for the event */
+            /* make sure they have done with their copying routine */
+            while (atomic_read(&(*rsp)->page_copier_cnt)) {
+                qemu_event_set(&(*rsp)->page_copying_done);
+                qemu_event_reset(&(*rsp)->page_copying_done);
+            }
+            qemu_event_destroy(&(*rsp)->page_copying_done);
+        }
+
         migration_page_queue_free(*rsp);
         qemu_mutex_destroy(&(*rsp)->bitmap_mutex);
         qemu_mutex_destroy(&(*rsp)->src_page_req_mutex);
@@ -1897,6 +2421,13 @@ static void ram_save_cleanup(void *opaque)
         block->clear_bmap = NULL;
         g_free(block->bmap);
         block->bmap = NULL;
+
+        if (migrate_background_snapshot()) {
+            g_free(block->touched_map);
+            block->touched_map = NULL;
+            g_free(block->copied_map);
+            block->copied_map = NULL;
+        }
     }
 
     xbzrle_cleanup();
@@ -1912,6 +2443,10 @@ static void ram_state_reset(RAMState *rs)
     rs->last_version = ram_list.version;
     rs->ram_bulk_stage = true;
     rs->fpo_enabled = false;
+
+    /* page buffer capacity in number of pages */
+    rs->page_buffer.capacity = PAGE_BUFFER_CAPACITY;
+    rs->page_buffer.used = 0;
 }
 
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
@@ -2298,6 +2833,14 @@ static int ram_state_init(RAMState **rsp)
      * This must match with the initial values of dirty bitmap.
      */
     (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
+
+    if (migrate_background_snapshot()) {
+        qemu_mutex_init(&(*rsp)->page_buffer.lock);
+        qemu_cond_init(&(*rsp)->page_buffer.used_decreased_cond);
+        qemu_event_init(&(*rsp)->page_copying_done, false);
+        (*rsp)->page_copier_cnt = 0;
+    }
+
     ram_state_reset(*rsp);
 
     return 0;
@@ -2338,6 +2881,11 @@ static void ram_list_init_bitmaps(void)
             bitmap_set(block->bmap, 0, pages);
             block->clear_bmap_shift = shift;
             block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
+
+            if (migrate_background_snapshot()) {
+                block->touched_map = bitmap_new(pages);
+                block->copied_map = bitmap_new(pages);
+            }
         }
     }
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index 45c9dd9d8a..490414aff4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1353,7 +1353,6 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
     return 0;
 }
 
-static
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
                                                     bool in_postcopy,
                                                     bool inactivate_disks)
-- 
2.17.0


