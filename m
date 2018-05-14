Received: from eggs.gnu.org ([2001:4830:134:3::10]:33482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fIGku-00083s-Us
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fIGku-0005iW-2v
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:55:25 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fIGkt-0005hl-GU
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:55:23 -0400
Received: by mail-pf0-x241.google.com with SMTP id a14-v6so6308984pfi.1
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 09:55:23 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 15 May 2018 00:54:16 +0800
Message-Id: <20180514165424.12884-10-zhangckid@gmail.com>
In-Reply-To: <20180514165424.12884-1-zhangckid@gmail.com>
References: <20180514165424.12884-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V7 RESEND 09/17] COLO: Flush memory data from
 ram cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

During the time of VM's running, PVM may dirty some pages, we will transfer
PVM's dirty pages to SVM and store them into SVM's RAM cache at next checkpoint
time. So, the content of SVM's RAM cache will always be same with PVM's memory
after checkpoint.

Instead of flushing all content of PVM's RAM cache into SVM's MEMORY,
we do this in a more efficient way:
Only flush any page that dirtied by PVM since last checkpoint.
In this way, we can ensure SVM's memory same with PVM's.

Besides, we must ensure flush RAM cache before load device state.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c        | 39 +++++++++++++++++++++++++++++++++++++++
 migration/trace-events |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index e35dfee06e..4235a8f24d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3031,6 +3031,40 @@ static bool postcopy_is_running(void)
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
@@ -3043,6 +3077,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     bool postcopy_running = postcopy_is_running();
     /* ADVISE is earlier, it shows the source has the postcopy capability on */
     bool postcopy_advised = postcopy_is_advised();
+    bool need_flush = false;
 
     seq_iter++;
 
@@ -3218,6 +3253,10 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     ret |= wait_for_decompress_done();
     rcu_read_unlock();
     trace_ram_load_complete(ret, seq_iter);
+
+    if (!ret  && migration_incoming_in_colo_state() && need_flush) {
+        colo_flush_ram_cache();
+    }
     return ret;
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index 9295b4cf40..8e2f9749e0 100644
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
2.17.0
