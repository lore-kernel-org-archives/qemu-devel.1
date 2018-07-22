Received: from eggs.gnu.org ([2001:4830:134:3::10]:37754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fhK8E-0002kp-K2
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fhK8D-0000h0-Ck
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:35:02 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:41393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fhK8D-0000gl-6n
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:35:01 -0400
Received: by mail-pg1-x52d.google.com with SMTP id z8-v6so10655531pgu.8
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 12:35:01 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 23 Jul 2018 03:33:39 +0800
Message-Id: <20180722193350.6028-10-zhangckid@gmail.com>
In-Reply-To: <20180722193350.6028-1-zhangckid@gmail.com>
References: <20180722193350.6028-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V10 09/20] COLO: Flush memory data from ram
 cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

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
 migration/ram.c        | 37 +++++++++++++++++++++++++++++++++++++
 migration/trace-events |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index d1060f1337..4df85d69c1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3830,6 +3830,39 @@ static bool postcopy_is_running(void)
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
+
+        if (offset << TARGET_PAGE_BITS >= block->used_length) {
+            offset = 0;
+            block = QLIST_NEXT_RCU(block, next);
+        } else {
+            migration_bitmap_clear_dirty(ram_state, block, offset);
+            dst_host = block->host + (offset << TARGET_PAGE_BITS);
+            src_host = block->colo_cache + (offset << TARGET_PAGE_BITS);
+            memcpy(dst_host, src_host, TARGET_PAGE_SIZE);
+        }
+    }
+
+    rcu_read_unlock();
+    trace_colo_flush_ram_cache_end();
+}
+
 static int ram_load(QEMUFile *f, void *opaque, int version_id)
 {
     int flags = 0, ret = 0, invalid_flags = 0;
@@ -4006,6 +4039,10 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     ret |= wait_for_decompress_done();
     rcu_read_unlock();
     trace_ram_load_complete(ret, seq_iter);
+
+    if (!ret  && migration_incoming_in_colo_state()) {
+        colo_flush_ram_cache();
+    }
     return ret;
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index fa0ff3f3bf..bd2d0cd25a 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -102,6 +102,8 @@ ram_dirty_bitmap_sync_start(void) ""
 ram_dirty_bitmap_sync_wait(void) ""
 ram_dirty_bitmap_sync_complete(void) ""
 ram_state_resume_prepare(uint64_t v) "%" PRId64
+colo_flush_ram_cache_begin(uint64_t dirty_pages) "dirty_pages %" PRIu64
+colo_flush_ram_cache_end(void) ""
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.17.1
