Received: from eggs.gnu.org ([2001:4830:134:3::10]:37740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fhK8B-0002iW-11
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fhK87-0000fP-TO
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:34:59 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:36471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fhK87-0000f6-N1
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:34:55 -0400
Received: by mail-pl0-x244.google.com with SMTP id e11-v6so7297669plb.3
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 12:34:55 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 23 Jul 2018 03:33:38 +0800
Message-Id: <20180722193350.6028-9-zhangckid@gmail.com>
In-Reply-To: <20180722193350.6028-1-zhangckid@gmail.com>
References: <20180722193350.6028-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V10 08/20] ram/COLO: Record the dirty pages
 that SVM received
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
index 33ebd09d70..d1060f1337 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3325,6 +3325,15 @@ static inline void *colo_cache_from_block_offset(RAMBlock *block,
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
 
@@ -3555,6 +3564,24 @@ int colo_init_ram_cache(void)
         memcpy(block->colo_cache, block->host, block->used_length);
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
@@ -3574,6 +3601,10 @@ void colo_release_ram_cache(void)
 {
     RAMBlock *block;
 
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        g_free(block->bmap);
+        block->bmap = NULL;
+    }
     rcu_read_lock();
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
         if (block->colo_cache) {
@@ -3582,6 +3613,8 @@ void colo_release_ram_cache(void)
         }
     }
     rcu_read_unlock();
+    g_free(ram_state);
+    ram_state = NULL;
 }
 
 /**
-- 
2.17.1
