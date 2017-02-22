Received: from eggs.gnu.org ([2001:4830:134:3::10]:42569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpN-0004i2-If
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpJ-0002tT-EW
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:53 -0500
Received: from [45.249.212.189] (port=2400 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpI-0002pi-Qj
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:49 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 22 Feb 2017 11:42:10 +0800
Message-ID: <1487734936-43472-10-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 09/15] COLO: Flush PVM's cached RAM into SVM's
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>

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
 migration/ram.c               | 41 +++++++++++++++++++++++++++++++++++++++++
 migration/trace-events        |  2 ++
 3 files changed, 44 insertions(+)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 93c6148..ba5b97b 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -383,4 +383,5 @@ PostcopyState postcopy_state_set(PostcopyState new_state);
 /* ram cache */
 int colo_init_ram_cache(void);
 void colo_release_ram_cache(void);
+void colo_flush_ram_cache(void);
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index ed3b606..3f57fe0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2540,6 +2540,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
      * be atomic
      */
     bool postcopy_running = postcopy_state_get() >= POSTCOPY_INCOMING_LISTENING;
+    bool need_flush = false;
 
     seq_iter++;
 
@@ -2574,6 +2575,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             /* After going into COLO, we should load the Page into colo_cache */
             if (ram_cache_enable) {
                 host = colo_cache_from_block_offset(block, addr);
+                need_flush = true;
             } else {
                 host = host_from_ram_block_offset(block, addr);
             }
@@ -2668,6 +2670,10 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     wait_for_decompress_done();
     rcu_read_unlock();
     trace_ram_load_complete(ret, seq_iter);
+
+    if (!ret  && ram_cache_enable && need_flush) {
+        colo_flush_ram_cache();
+    }
     return ret;
 }
 
@@ -2738,6 +2744,41 @@ void colo_release_ram_cache(void)
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
+    ram_addr_t offset = 0;
+
+    trace_colo_flush_ram_cache_begin(migration_dirty_pages);
+    rcu_read_lock();
+    block = QLIST_FIRST_RCU(&ram_list.blocks);
+
+    while (block) {
+        ram_addr_t ram_addr_abs;
+        offset = migration_bitmap_find_dirty(block, offset, &ram_addr_abs);
+        migration_bitmap_clear_dirty(ram_addr_abs);
+
+        if (offset >= block->used_length) {
+            offset = 0;
+            block = QLIST_NEXT_RCU(block, next);
+        } else {
+            dst_host = block->host + offset;
+            src_host = block->colo_cache + offset;
+            memcpy(dst_host, src_host, TARGET_PAGE_SIZE);
+        }
+    }
+
+    rcu_read_unlock();
+    trace_colo_flush_ram_cache_end();
+    assert(migration_dirty_pages == 0);
+}
+
 static SaveVMHandlers savevm_ram_handlers = {
     .save_live_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
diff --git a/migration/trace-events b/migration/trace-events
index fa660e3..5d4cf80 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -71,6 +71,8 @@ migration_throttle(void) ""
 ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
 ram_postcopy_send_discard_bitmap(void) ""
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: %zx len: %zx"
+colo_flush_ram_cache_begin(uint64_t dirty_pages) "dirty_pages %" PRIu64
+colo_flush_ram_cache_end(void) ""
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
1.8.3.1
