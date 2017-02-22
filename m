Received: from eggs.gnu.org ([2001:4830:134:3::10]:42583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpO-0004i7-5c
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpJ-0002tb-F0
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:54 -0500
Received: from [45.249.212.189] (port=2396 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpI-0002pc-R7
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:49 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 22 Feb 2017 11:42:09 +0800
Message-ID: <1487734936-43472-9-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 08/15] ram/COLO: Record the dirty pages that
 SVM received
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

We record the address of the dirty pages that received,
it will help flushing pages that cached into SVM.
We record them by re-using migration dirty bitmap.

Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index b588990..ed3b606 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2231,6 +2231,9 @@ static inline void *host_from_ram_block_offset(RAMBlock *block,
 static inline void *colo_cache_from_block_offset(RAMBlock *block,
                                                  ram_addr_t offset)
 {
+    unsigned long *bitmap;
+    long k;
+
     if (!offset_in_ramblock(block, offset)) {
         return NULL;
     }
@@ -2239,6 +2242,17 @@ static inline void *colo_cache_from_block_offset(RAMBlock *block,
                      __func__, block->idstr);
         return NULL;
     }
+
+    k = (memory_region_get_ram_addr(block->mr) + offset) >> TARGET_PAGE_BITS;
+    bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
+    /*
+    * During colo checkpoint, we need bitmap of these migrated pages.
+    * It help us to decide which pages in ram cache should be flushed
+    * into VM's RAM later.
+    */
+    if (!test_and_set_bit(k, bitmap)) {
+        migration_dirty_pages++;
+    }
     return block->colo_cache + offset;
 }
 
@@ -2664,6 +2678,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 int colo_init_ram_cache(void)
 {
     RAMBlock *block;
+    int64_t ram_cache_pages = last_ram_offset() >> TARGET_PAGE_BITS;
 
     rcu_read_lock();
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
@@ -2678,6 +2693,15 @@ int colo_init_ram_cache(void)
     }
     rcu_read_unlock();
     ram_cache_enable = true;
+    /*
+    * Record the dirty pages that sent by PVM, we use this dirty bitmap together
+    * with to decide which page in cache should be flushed into SVM's RAM. Here
+    * we use the same name 'migration_bitmap_rcu' as for migration.
+    */
+    migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
+    migration_bitmap_rcu->bmap = bitmap_new(ram_cache_pages);
+    migration_dirty_pages = 0;
+
     return 0;
 
 out_locked:
@@ -2695,9 +2719,15 @@ out_locked:
 void colo_release_ram_cache(void)
 {
     RAMBlock *block;
+    struct BitmapRcu *bitmap = migration_bitmap_rcu;
 
     ram_cache_enable = false;
 
+    atomic_rcu_set(&migration_bitmap_rcu, NULL);
+    if (bitmap) {
+        call_rcu(bitmap, migration_bitmap_free, rcu);
+    }
+
     rcu_read_lock();
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
         if (block->colo_cache) {
-- 
1.8.3.1
