Received: from eggs.gnu.org ([2001:4830:134:3::10]:59777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNR-0001jE-0g
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNN-0000gx-KS
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:45 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3397
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNM-0000g4-OT
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:41 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:25:49 +0800
Message-ID: <1492849558-17540-10-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 09/18] COLO: Flush memory data from ram cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, gilbert@redhat.com
Cc: quintela@redhat.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

During the time of VM's running, PVM may dirty some pages, we will transfer
PVM's dirty pages to SVM and store them into SVM's RAM cache at next checkpoint
time. So, the content of SVM's RAM cache will always be same with PVM's memory
after checkpoint.

Instead of flushing all content of PVM's RAM cache into SVM's MEMORY,
we do this in a more efficient way:
Only flush any page that dirtied by PVM since last checkpoint.
In this way, we can ensure SVM's memory same with PVM's.

Besides, we must ensure flush RAM cache before load device state.

Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h |  1 +
 migration/ram.c               | 40 ++++++++++++++++++++++++++++++++++++++++
 migration/trace-events        |  2 ++
 3 files changed, 43 insertions(+)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index ba765eb..2aa7654 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -364,4 +364,5 @@ PostcopyState postcopy_state_set(PostcopyState new_state);
 /* ram cache */
 int colo_init_ram_cache(void);
 void colo_release_ram_cache(void);
+void colo_flush_ram_cache(void);
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index 0653a24..df10d4b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2602,6 +2602,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     bool postcopy_running = postcopy_state_get() >= POSTCOPY_INCOMING_LISTENING;
     /* ADVISE is earlier, it shows the source has the postcopy capability on */
     bool postcopy_advised = postcopy_state_get() >= POSTCOPY_INCOMING_ADVISE;
+    bool need_flush = false;
 
     seq_iter++;
 
@@ -2636,6 +2637,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             /* After going into COLO, we should load the Page into colo_cache */
             if (migration_incoming_in_colo_state()) {
                 host = colo_cache_from_block_offset(block, addr);
+                need_flush = true;
             } else {
                 host = host_from_ram_block_offset(block, addr);
             }
@@ -2742,6 +2744,10 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     wait_for_decompress_done();
     rcu_read_unlock();
     trace_ram_load_complete(ret, seq_iter);
+
+    if (!ret  && ram_cache_enable && need_flush) {
+        colo_flush_ram_cache();
+    }
     return ret;
 }
 
@@ -2810,6 +2816,40 @@ void colo_release_ram_cache(void)
     rcu_read_unlock();
 }
 
+/*
+ * Flush content of RAM cache into SVM's memory.
+ * Only flush the pages that be dirtied by PVM or SVM or both.
+ */
+void colo_flush_ram_cache(void)
+{
+    RAMBlock *block = NULL;
+    void *dst_host;
+    void *src_host;
+    unsigned long offset = 0;
+
+    trace_colo_flush_ram_cache_begin(ram_state.migration_dirty_pages);
+    rcu_read_lock();
+    block = QLIST_FIRST_RCU(&ram_list.blocks);
+
+    while (block) {
+        offset = migration_bitmap_find_dirty(&ram_state, block, offset);
+        migration_bitmap_clear_dirty(&ram_state, block, offset);
+
+        if (offset << TARGET_PAGE_BITS >= block->used_length) {
+            offset = 0;
+            block = QLIST_NEXT_RCU(block, next);
+        } else {
+            dst_host = block->host + (offset << TARGET_PAGE_BITS);
+            src_host = block->colo_cache + (offset << TARGET_PAGE_BITS);
+            memcpy(dst_host, src_host, TARGET_PAGE_SIZE);
+        }
+    }
+
+    rcu_read_unlock();
+    trace_colo_flush_ram_cache_end();
+    assert(ram_state.migration_dirty_pages == 0);
+}
+
 static SaveVMHandlers savevm_ram_handlers = {
     .save_live_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
diff --git a/migration/trace-events b/migration/trace-events
index b8f01a2..93f4337 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -72,6 +72,8 @@ ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %"
 ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
 ram_postcopy_send_discard_bitmap(void) ""
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: %zx len: %zx"
+colo_flush_ram_cache_begin(uint64_t dirty_pages) "dirty_pages %" PRIu64
+colo_flush_ram_cache_end(void) ""
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
1.8.3.1
