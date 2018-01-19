Received: from eggs.gnu.org ([2001:4830:134:3::10]:46700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1ecX09-0003pg-4E
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1ecX07-0003Hx-NN
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:46:37 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:38930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1ecX07-0003Hb-I7
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:46:35 -0500
Received: by mail-pf0-x241.google.com with SMTP id e11so1392661pff.6
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 05:46:35 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 19 Jan 2018 21:44:37 +0800
Message-Id: <1516369485-5374-9-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1516369485-5374-1-git-send-email-zhangckid@gmail.com>
References: <1516369485-5374-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V4 08/16] ram/COLO: Record the dirty pages that
 SVM received
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>

We record the address of the dirty pages that received,
it will help flushing pages that cached into SVM.

Here, it is a trick, we record dirty pages by re-using migration
dirty bitmap. In the later patch, we will start the dirty log
for SVM, just like migration, in this way, we can record both
the dirty pages caused by PVM and SVM, we only flush those dirty
pages from RAM cache while do checkpoint.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 6460777..d916da0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2478,6 +2478,15 @@ static inline void *colo_cache_from_block_offset(RAMBlock *block,
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
 
@@ -2654,6 +2663,24 @@ int colo_init_ram_cache(void)
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
@@ -2673,6 +2700,10 @@ void colo_release_ram_cache(void)
 {
     RAMBlock *block;
 
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        g_free(block->bmap);
+        block->bmap = NULL;
+    }
     rcu_read_lock();
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
         if (block->colo_cache) {
@@ -2681,6 +2712,8 @@ void colo_release_ram_cache(void)
         }
     }
     rcu_read_unlock();
+    g_free(ram_state);
+    ram_state = NULL;
 }
 
 /**
-- 
2.7.4
