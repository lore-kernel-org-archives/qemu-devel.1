Received: from eggs.gnu.org ([2001:4830:134:3::10]:36949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybW-0003nC-Kz
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybV-0004GV-E7
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:14 -0500
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:45414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eWybV-0004G1-8x
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:13 -0500
Received: by mail-pf0-x230.google.com with SMTP id u19so365592pfa.12
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 22:02:13 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu,  4 Jan 2018 14:01:08 +0800
Message-Id: <1515045675-6993-10-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
References: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH RESEND V3 09/16] COLO: Flush memory data from
 ram cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

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
 migration/ram.c        | 39 +++++++++++++++++++++++++++++++++++++++
 migration/trace-events |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 388333d..23c67e0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2908,6 +2908,40 @@ static bool postcopy_is_running(void)
     return ps >= POSTCOPY_INCOMING_LISTENING && ps < POSTCOPY_INCOMING_END;
 }
 
+/*
+ * Flush content of RAM cache into SVM's memory.
+ * Only flush the pages that be dirtied by PVM or SVM or both.
+ */
+static void colo_flush_ram_cache(void)
+{
+    RAMBlock *block = NULL;
+    void *dst_host;
+    void *src_host;
+    unsigned long offset = 0;
+
+    trace_colo_flush_ram_cache_begin(ram_state->migration_dirty_pages);
+    rcu_read_lock();
+    block = QLIST_FIRST_RCU(&ram_list.blocks);
+
+    while (block) {
+        offset = migration_bitmap_find_dirty(ram_state, block, offset);
+        migration_bitmap_clear_dirty(ram_state, block, offset);
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
+    assert(ram_state->migration_dirty_pages == 0);
+}
+
 static int ram_load(QEMUFile *f, void *opaque, int version_id)
 {
     int flags = 0, ret = 0, invalid_flags = 0;
@@ -2920,6 +2954,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     bool postcopy_running = postcopy_is_running();
     /* ADVISE is earlier, it shows the source has the postcopy capability on */
     bool postcopy_advised = postcopy_is_advised();
+    bool need_flush = false;
 
     seq_iter++;
 
@@ -3095,6 +3130,10 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     wait_for_decompress_done();
     rcu_read_unlock();
     trace_ram_load_complete(ret, seq_iter);
+
+    if (!ret  && migration_incoming_in_colo_state() && need_flush) {
+        colo_flush_ram_cache();
+    }
     return ret;
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index d4738c8..69261a0 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -78,6 +78,8 @@ ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
 ram_postcopy_send_discard_bitmap(void) ""
 ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%" PRIx64 " host: %p"
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
+colo_flush_ram_cache_begin(uint64_t dirty_pages) "dirty_pages %" PRIu64
+colo_flush_ram_cache_end(void) ""
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.7.4
