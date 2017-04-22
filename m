Received: from eggs.gnu.org ([2001:4830:134:3::10]:59779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNR-0001jG-1c
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNO-0000hS-Hb
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:45 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3398
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNN-0000g5-UV
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:42 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:25:48 +0800
Message-ID: <1492849558-17540-9-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 08/18] ram/COLO: Record the dirty pages that
 SVM received
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

We record the address of the dirty pages that received,
it will help flushing pages that cached into SVM.

Here, it is a trick, we record dirty pages by re-using migration
dirty bitmap. In the later patch, we will start the dirty log
for SVM, just like migration, in this way, we can record both
the dirty pages caused by PVM and SVM, we only flush those dirty
pages from RAM cache while do checkpoint.

Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 05d1b06..0653a24 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2268,6 +2268,9 @@ static inline void *host_from_ram_block_offset(RAMBlock *block,
 static inline void *colo_cache_from_block_offset(RAMBlock *block,
                                                  ram_addr_t offset)
 {
+    unsigned long *bitmap;
+    long k;
+
     if (!offset_in_ramblock(block, offset)) {
         return NULL;
     }
@@ -2276,6 +2279,17 @@ static inline void *colo_cache_from_block_offset(RAMBlock *block,
                      __func__, block->idstr);
         return NULL;
     }
+
+    k = (memory_region_get_ram_addr(block->mr) + offset) >> TARGET_PAGE_BITS;
+    bitmap = atomic_rcu_read(&ram_state.ram_bitmap)->bmap;
+    /*
+    * During colo checkpoint, we need bitmap of these migrated pages.
+    * It help us to decide which pages in ram cache should be flushed
+    * into VM's RAM later.
+    */
+    if (!test_and_set_bit(k, bitmap)) {
+        ram_state.migration_dirty_pages++;
+    }
     return block->colo_cache + offset;
 }
 
@@ -2752,6 +2766,15 @@ int colo_init_ram_cache(void)
         memcpy(block->colo_cache, block->host, block->used_length);
     }
     rcu_read_unlock();
+    /*
+    * Record the dirty pages that sent by PVM, we use this dirty bitmap together
+    * with to decide which page in cache should be flushed into SVM's RAM. Here
+    * we use the same name 'ram_bitmap' as for migration.
+    */
+    ram_state.ram_bitmap = g_new0(RAMBitmap, 1);
+    ram_state.ram_bitmap->bmap = bitmap_new(last_ram_page());
+    ram_state.migration_dirty_pages = 0;
+
     return 0;
 
 out_locked:
@@ -2770,6 +2793,12 @@ out_locked:
 void colo_release_ram_cache(void)
 {
     RAMBlock *block;
+    RAMBitmap *bitmap = ram_state.ram_bitmap;
+
+    atomic_rcu_set(&ram_state.ram_bitmap, NULL);
+    if (bitmap) {
+        call_rcu(bitmap, migration_bitmap_free, rcu);
+    }
 
     rcu_read_lock();
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
-- 
1.8.3.1
