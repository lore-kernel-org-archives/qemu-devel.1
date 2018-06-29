Received: from eggs.gnu.org ([2001:4830:134:3::10]:53412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fYoNR-0007Ic-CO
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fYoNO-0006ny-CI
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:03:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:58252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1fYoNO-0006kj-0O
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:03:30 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Fri, 29 Jun 2018 11:03:17 +0300
Message-Id: <20180629080320.320144-5-dplotnikov@virtuozzo.com>
In-Reply-To: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
References: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v0 4/7] migration: add background snapshot
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

It allows to intercept VM's RAM access and write them into the
snapshot.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 include/exec/ram_addr.h |   7 +
 include/exec/ramlist.h  |   4 +-
 migration/migration.c   |   2 +-
 migration/ram.c         | 333 ++++++++++++++++++++++++++++++++++++++--
 migration/ram.h         |  11 +-
 5 files changed, 338 insertions(+), 19 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 6cbc02aa0f..5b403d537d 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -36,6 +36,8 @@ struct RAMBlock {
     char idstr[256];
     /* RCU-enabled, writes protected by the ramlist lock */
     QLIST_ENTRY(RAMBlock) next;
+    /* blocks used for background snapshot */
+    QLIST_ENTRY(RAMBlock) bgs_next;
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
     int fd;
     size_t page_size;
@@ -49,6 +51,11 @@ struct RAMBlock {
     unsigned long *unsentmap;
     /* bitmap of already received pages in postcopy */
     unsigned long *receivedmap;
+    /* The following 2 are for background snapshot */
+    /* Pages currently being copied */
+    unsigned long *touched_map;
+    /* Pages has been copied already */
+    unsigned long *copied_map;
 };
 
 static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
index 2e2ac6cb99..e0231d3bec 100644
--- a/include/exec/ramlist.h
+++ b/include/exec/ramlist.h
@@ -44,11 +44,13 @@ typedef struct {
     unsigned long *blocks[];
 } DirtyMemoryBlocks;
 
+typedef QLIST_HEAD(, RAMBlock) RamBlockList;
+
 typedef struct RAMList {
     QemuMutex mutex;
     RAMBlock *mru_block;
     /* RCU-enabled, writes protected by the ramlist lock. */
-    QLIST_HEAD(, RAMBlock) blocks;
+    RamBlockList blocks;
     DirtyMemoryBlocks *dirty_memory[DIRTY_MEMORY_NUM];
     uint32_t version;
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
diff --git a/migration/migration.c b/migration/migration.c
index 87096d23ef..131d0904e4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1716,7 +1716,7 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
         return;
     }
 
-    if (ram_save_queue_pages(rbname, start, len)) {
+    if (ram_save_queue_pages(NULL, rbname, start, len, NULL)) {
         mark_source_rp_bad(ms);
     }
 }
diff --git a/migration/ram.c b/migration/ram.c
index 021d583b9b..286b79ad51 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -188,10 +188,21 @@ struct RAMSrcPageRequest {
     RAMBlock *rb;
     hwaddr    offset;
     hwaddr    len;
+    void*     page_copy;
 
     QSIMPLEQ_ENTRY(RAMSrcPageRequest) next_req;
 };
 
+/* Page buffer used for background snapshot */
+typedef struct RAMPageBuffer {
+    /* Page buffer capacity in host pages */
+    int capacity;
+    /* Current number of pages in the buffer */
+    int used;
+    /* Event to notify that buffer usage is under capacity */
+    QemuEvent used_decreased;
+} RAMPageBuffer;
+
 /* State of RAM for migration */
 struct RAMState {
     /* QEMUFile used for this migration */
@@ -230,6 +241,11 @@ struct RAMState {
     /* Queue of outstanding page requests from the destination */
     QemuMutex src_page_req_mutex;
     QSIMPLEQ_HEAD(src_page_requests, RAMSrcPageRequest) src_page_requests;
+    /* The following 2 are for background snapshot */
+    /* Buffer data to store copies of ram pages while async vm saving */
+    RAMPageBuffer page_buffer;
+    /* Event to notify that a page coping just has finished*/
+    QemuEvent page_coping_done;
 };
 typedef struct RAMState RAMState;
 
@@ -250,6 +266,8 @@ struct PageSearchStatus {
     unsigned long page;
     /* Set once we wrap around */
     bool         complete_round;
+    /* Pointer to the cached page */
+    void* page_copy;
 };
 typedef struct PageSearchStatus PageSearchStatus;
 
@@ -958,7 +976,11 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
     RAMBlock *block = pss->block;
     ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
 
-    p = block->host + offset;
+    if (pss->page_copy) {
+        p = pss->page_copy;
+    } else {
+        p = block->host + offset;
+    }
     trace_ram_save_page(block->idstr, (uint64_t)offset, p);
 
     /* In doubt sent page as normal */
@@ -989,9 +1011,12 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
              * page would be stale
              */
             xbzrle_cache_zero_page(rs, current_addr);
-            ram_release_pages(block->idstr, offset, pages);
+            if (pss->page_copy) {
+                qemu_madvise(p, TARGET_PAGE_SIZE, MADV_DONTNEED);
+            }
         } else if (!rs->ram_bulk_stage &&
-                   !migration_in_postcopy() && migrate_use_xbzrle()) {
+                   !migration_in_postcopy() && migrate_use_xbzrle() &&
+                   !migrate_background_snapshot()) {
             pages = save_xbzrle_page(rs, &p, current_addr, block,
                                      offset, last_stage);
             if (!last_stage) {
@@ -1008,9 +1033,10 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
         ram_counters.transferred +=
             save_page_header(rs, rs->f, block, offset | RAM_SAVE_FLAG_PAGE);
         if (send_async) {
-            qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
-                                  migrate_release_ram() &
-                                  migration_in_postcopy());
+            bool may_free = migrate_background_snapshot() ||
+                            (migrate_release_ram() &&
+                             migration_in_postcopy());
+            qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE, may_free);
         } else {
             qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
         }
@@ -1251,7 +1277,7 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss, bool *again)
  * @rs: current RAM state
  * @offset: used to return the offset within the RAMBlock
  */
-static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
+static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset, void **page_copy)
 {
     RAMBlock *block = NULL;
 
@@ -1261,10 +1287,14 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
                                 QSIMPLEQ_FIRST(&rs->src_page_requests);
         block = entry->rb;
         *offset = entry->offset;
+        *page_copy = entry->page_copy;
 
         if (entry->len > TARGET_PAGE_SIZE) {
             entry->len -= TARGET_PAGE_SIZE;
             entry->offset += TARGET_PAGE_SIZE;
+            if (entry->page_copy) {
+                entry->page_copy += TARGET_PAGE_SIZE/sizeof(void*);
+            }
         } else {
             memory_region_unref(block->mr);
             QSIMPLEQ_REMOVE_HEAD(&rs->src_page_requests, next_req);
@@ -1291,9 +1321,10 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
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
@@ -1331,6 +1362,7 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
          */
         pss->block = block;
         pss->page = offset >> TARGET_PAGE_BITS;
+        pss->page_copy = page_copy;
     }
 
     return !!block;
@@ -1368,17 +1400,25 @@ static void migration_page_queue_free(RAMState *rs)
  *
  * @rbname: Name of the RAMBLock of the request. NULL means the
  *          same that last one.
+ * @block: RAMBlock to use. block and rbname have mutualy exclusive
+ *         semantic with higher priority of the block.
  * @start: starting address from the start of the RAMBlock
  * @len: length (in bytes) to send
+ * @page_copy: the address the page should be written from
  */
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
+int ram_save_queue_pages(RAMBlock *block, const char *rbname,
+                         ram_addr_t start, ram_addr_t len, void* page_copy)
 {
     RAMBlock *ramblock;
     RAMState *rs = ram_state;
 
     ram_counters.postcopy_requests++;
+
     rcu_read_lock();
-    if (!rbname) {
+
+    if (block) {
+        ramblock = block;
+    } else if (!rbname) {
         /* Reuse last RAMBlock */
         ramblock = rs->last_req_rb;
 
@@ -1413,6 +1453,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
     new_entry->rb = ramblock;
     new_entry->offset = start;
     new_entry->len = len;
+    new_entry->page_copy = page_copy;
 
     memory_region_ref(ramblock->mr);
     qemu_mutex_lock(&rs->src_page_req_mutex);
@@ -1450,7 +1491,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
          * xbzrle can do better than compression.
          */
         if (migrate_use_compression() &&
-            (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
+            (rs->ram_bulk_stage || !migrate_use_xbzrle()) &&
+            !migrate_background_snapshot()) {
             res = ram_save_compressed_page(rs, pss, last_stage);
         } else {
             res = ram_save_page(rs, pss, last_stage);
@@ -1508,6 +1550,226 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
     return pages;
 }
 
+static bool ram_has_postcopy(void *opaque)
+{
+    return migrate_postcopy_ram();
+}
+
+static int mem_protect(void *addr, uint64_t length, int prot)
+{
+    int ret = mprotect(addr, length, prot);
+
+    if (ret < 0) {
+        error_report("%s: Can't change protection on ram block at %p (len: %lu)",
+                     __func__, addr, length);
+    }
+
+    // 0 on success
+    return ret;
+}
+
+static int ram_set_ro(void* addr, uint64_t length)
+{
+    return mem_protect(addr, length, PROT_READ);
+}
+
+static int ram_set_rw(void* addr, uint64_t length)
+{
+    return mem_protect(addr, length, PROT_READ | PROT_WRITE);
+}
+
+static RamBlockList ram_blocks;
+
+RamBlockList *ram_blocks_get(void)
+{
+    return &ram_blocks;
+}
+
+void ram_blocks_fill(RamBlockList *blocks)
+{
+    RAMBlock *block = NULL;
+
+    qemu_mutex_lock_ramlist();
+    QLIST_FOREACH(block, &ram_list.blocks, next) {
+        memory_region_ref(block->mr);
+        QLIST_INSERT_HEAD(blocks, block, bgs_next);
+    }
+    qemu_mutex_unlock_ramlist();
+}
+
+void ram_blocks_clear(RamBlockList *blocks)
+{
+    RAMBlock *block = NULL;
+
+    QLIST_FOREACH(block, blocks, bgs_next) {
+        QLIST_REMOVE(block, bgs_next);
+        memory_region_unref(block->mr);
+    }
+}
+
+int ram_blocks_set_ro(RamBlockList *blocks)
+{
+    RAMBlock *block = NULL;
+    int ret = 0;
+
+    QLIST_FOREACH(block, blocks, bgs_next) {
+        ret = ram_set_ro(block->host, block->used_length);
+        if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
+int ram_blocks_set_rw(RamBlockList *blocks)
+{
+    RAMBlock *block = NULL;
+    int ret = 0;
+
+    QLIST_FOREACH(block, blocks, bgs_next) {
+        ret = ram_set_rw(block->host, block->used_length);
+        if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
+static void ram_page_buffer_decrease_used(void)
+{
+    qemu_event_reset(&ram_state->page_buffer.used_decreased);
+    atomic_dec(&ram_state->page_buffer.used);
+    qemu_event_set(&ram_state->page_buffer.used_decreased);
+}
+
+static void ram_page_buffer_increase_used_wait(void)
+{
+    int ret, used, *used_ptr;
+    RAMState *rs = ram_state;
+    used_ptr = &rs->page_buffer.used;
+    do {
+        used = atomic_read(used_ptr);
+        if (rs->page_buffer.capacity > used) {
+            if ((ret = atomic_cmpxchg(used_ptr, used, used + 1)) == used) {
+                return;
+            } else {
+                continue;
+            }
+        } else {
+            qemu_event_wait(&rs->page_buffer.used_decreased);
+        }
+    } while(true);
+}
+
+static void *ram_page_buffer_get(void)
+{
+    void *page;
+    ram_page_buffer_increase_used_wait();
+    page = mmap(0, TARGET_PAGE_SIZE, PROT_READ|PROT_WRITE,
+                    MAP_PRIVATE|MAP_ANONYMOUS,
+                    -1, 0);
+   if (page == MAP_FAILED) {
+       ram_page_buffer_decrease_used();
+       page = NULL;
+   }
+   return page;
+}
+
+static int ram_page_buffer_free(void *buffer)
+{
+    ram_page_buffer_decrease_used();
+    return qemu_madvise(buffer, TARGET_PAGE_SIZE, MADV_DONTNEED);
+}
+
+static int ram_try_copy_page(RAMBlock *block, unsigned long page_nr,
+                             void** page_copy)
+{
+    void *host_page;
+
+    if (test_and_set_bit_atomic(page_nr, block->touched_map)) {
+        while (!test_bit_atomic(page_nr, block->copied_map)) {
+            // the page is being copied -- wait for the end of the coping
+            // and check once again
+            qemu_event_reset(&ram_state->page_coping_done);
+            qemu_event_wait(&ram_state->page_coping_done);
+        }
+        return 0;
+    }
+
+    *page_copy = ram_page_buffer_get();
+    if (!*page_copy) {
+        return -1;
+    }
+
+    host_page = block->host + (page_nr << TARGET_PAGE_BITS);
+    memcpy(*page_copy, host_page, TARGET_PAGE_SIZE);
+
+    if (ram_set_rw(host_page, TARGET_PAGE_SIZE)) {
+        ram_page_buffer_free(*page_copy);
+        *page_copy = NULL;
+        return -1;
+    }
+
+    smp_mb();
+    set_bit_atomic(page_nr, block->copied_map);
+    qemu_event_set(&ram_state->page_coping_done);
+
+    return 1;
+}
+
+static RAMBlock *find_ram_block(uint8_t *address, ram_addr_t *page_offset)
+{
+    RAMBlock *block = NULL;
+
+
+    QLIST_FOREACH(block, ram_blocks_get(), bgs_next) {
+        /* This case append when the block is not mapped. */
+        if (block->host == NULL) {
+            continue;
+        }
+
+        if (address - block->host < block->max_length) {
+            *page_offset = (address - block->host) & TARGET_PAGE_MASK;
+            return block;
+        }
+    }
+
+    return NULL;
+}
+
+// 0 - on success, 0 < - on error
+int ram_process_page_fault(void *address)
+{
+    int ret;
+    void *page_copy = NULL;
+    unsigned long page_nr;
+    ram_addr_t offset;
+
+    RAMBlock *block = find_ram_block(address, &offset);
+
+    if (!block) {
+        return -1;
+    }
+
+    page_nr = offset >> TARGET_PAGE_BITS;
+
+    ret = ram_try_copy_page(block, page_nr, &page_copy);
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
 /**
  * ram_find_and_save_block: finds a dirty page and sends it to f
  *
@@ -1536,6 +1798,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
     pss.block = rs->last_seen_block;
     pss.page = rs->last_page;
     pss.complete_round = false;
+    pss.page_copy = NULL;
 
     if (!pss.block) {
         pss.block = QLIST_FIRST_RCU(&ram_list.blocks);
@@ -1548,11 +1811,27 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
         if (!found) {
             /* priority queue empty, so just search for something dirty */
             found = find_dirty_block(rs, &pss, &again);
+
+            if (found && migrate_background_snapshot()) {
+                // make a copy of the page and pass it to the page search status
+                int ret;
+                ret = ram_try_copy_page(pss.block, pss.page, &pss.page_copy);
+                if (ret == 0) {
+                    found = false;
+                    pages = 0;
+                } else if(ret < 0) {
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
@@ -1600,9 +1879,15 @@ static void xbzrle_load_cleanup(void)
 
 static void ram_state_cleanup(RAMState **rsp)
 {
+    if (migrate_background_snapshot()) {
+        qemu_event_destroy(&(*rsp)->page_buffer.used_decreased);
+        qemu_event_destroy(&(*rsp)->page_coping_done);
+    }
+
     migration_page_queue_free(*rsp);
     qemu_mutex_destroy(&(*rsp)->bitmap_mutex);
     qemu_mutex_destroy(&(*rsp)->src_page_req_mutex);
+
     g_free(*rsp);
     *rsp = NULL;
 }
@@ -1638,6 +1923,13 @@ static void ram_save_cleanup(void *opaque)
         block->bmap = NULL;
         g_free(block->unsentmap);
         block->unsentmap = NULL;
+
+        if (migrate_background_snapshot()) {
+            g_free(block->touched_map);
+            block->touched_map = NULL;
+            g_free(block->copied_map);
+            block->copied_map = NULL;
+        }
     }
 
     xbzrle_cleanup();
@@ -1652,6 +1944,9 @@ static void ram_state_reset(RAMState *rs)
     rs->last_page = 0;
     rs->last_version = ram_list.version;
     rs->ram_bulk_stage = true;
+
+    rs->page_buffer.capacity = 1000; // in number of pages
+    rs->page_buffer.used = 0;
 }
 
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
@@ -2129,6 +2424,11 @@ static int ram_state_init(RAMState **rsp)
      */
     (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
 
+    if (migrate_background_snapshot()) {
+        qemu_event_init(&ram_state->page_buffer.used_decreased, false);
+        qemu_event_init(&ram_state->page_coping_done, false);
+    }
+
     ram_state_reset(*rsp);
 
     return 0;
@@ -2145,10 +2445,16 @@ static void ram_list_init_bitmaps(void)
             pages = block->max_length >> TARGET_PAGE_BITS;
             block->bmap = bitmap_new(pages);
             bitmap_set(block->bmap, 0, pages);
+
             if (migrate_postcopy_ram()) {
                 block->unsentmap = bitmap_new(pages);
                 bitmap_set(block->unsentmap, 0, pages);
             }
+
+            if (migrate_background_snapshot()) {
+                block->touched_map = bitmap_new(pages);
+                block->copied_map = bitmap_new(pages);
+            }
         }
     }
 }
@@ -2974,11 +3280,6 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
-static bool ram_has_postcopy(void *opaque)
-{
-    return migrate_postcopy_ram();
-}
-
 static SaveVMHandlers savevm_ram_handlers = {
     .save_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
diff --git a/migration/ram.h b/migration/ram.h
index 64d81e9f1d..627c2efb51 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -31,6 +31,7 @@
 
 #include "qemu-common.h"
 #include "exec/cpu-common.h"
+#include "exec/ramlist.h"
 
 extern MigrationStats ram_counters;
 extern XBZRLECacheStats xbzrle_counters;
@@ -45,7 +46,9 @@ int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
 
 uint64_t ram_pagesize_summary(void);
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
+int ram_save_queue_pages(RAMBlock *block, const char *rbname,
+                         ram_addr_t start, ram_addr_t len,
+                         void* cached_page);
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
 void ram_debug_dump_bitmap(unsigned long *todump, bool expected,
                            unsigned long pages);
@@ -61,5 +64,11 @@ void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
 int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
+int ram_process_page_fault(void *address);
+RamBlockList *ram_blocks_get(void);
+void ram_blocks_fill(RamBlockList *blocks);
+void ram_blocks_clear(RamBlockList *blocks);
+int ram_blocks_set_ro(RamBlockList *blocks);
+int ram_blocks_set_rw(RamBlockList *blocks);
 
 #endif
-- 
2.17.0
