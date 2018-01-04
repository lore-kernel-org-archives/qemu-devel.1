Received: from eggs.gnu.org ([2001:4830:134:3::10]:36920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybS-0003ji-OG
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybR-0004EI-Uf
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:10 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:41971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eWybR-0004Da-PP
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:09 -0500
Received: by mail-pg0-x242.google.com with SMTP id 77so337610pgd.8
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 22:02:09 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu,  4 Jan 2018 14:01:07 +0800
Message-Id: <1515045675-6993-9-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
References: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH RESEND V3 08/16] ram/COLO: Record the dirty
 pages that SVM received
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

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
 migration/ram.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 0fc0aee..388333d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2477,6 +2477,15 @@ static inline void *colo_cache_from_block_offset(RAMBlock *block,
                      __func__, block->idstr);
         return NULL;
     }
+
+    /*
+    * During colo checkpoint, we need bitmap of these migrated pages.
+    * It help us to decide which pages in ram cache should be flushed
+    * into VM's RAM later.
+    */
+    if (!test_and_set_bit(offset >> TARGET_PAGE_BITS, block->bmap)) {
+        ram_state->migration_dirty_pages++;
+    }
     return block->colo_cache + offset;
 }
 
@@ -2653,6 +2662,24 @@ int colo_init_ram_cache(void)
         }
     }
     rcu_read_unlock();
+    /*
+    * Record the dirty pages that sent by PVM, we use this dirty bitmap together
+    * with to decide which page in cache should be flushed into SVM's RAM. Here
+    * we use the same name 'ram_bitmap' as for migration.
+    */
+    if (ram_bytes_total()) {
+        RAMBlock *block;
+
+        QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+            unsigned long pages = block->max_length >> TARGET_PAGE_BITS;
+
+            block->bmap = bitmap_new(pages);
+            bitmap_set(block->bmap, 0, pages);
+         }
+    }
+    ram_state = g_new0(RAMState, 1);
+    ram_state->migration_dirty_pages = 0;
+
     return 0;
 
 out_locked:
@@ -2672,6 +2699,10 @@ void colo_release_ram_cache(void)
 {
     RAMBlock *block;
 
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        g_free(block->bmap);
+        block->bmap = NULL;
+    }
     rcu_read_lock();
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
         if (block->colo_cache) {
@@ -2680,6 +2711,8 @@ void colo_release_ram_cache(void)
         }
     }
     rcu_read_unlock();
+    g_free(ram_state);
+    ram_state = NULL;
 }
 
 /**
-- 
2.7.4
