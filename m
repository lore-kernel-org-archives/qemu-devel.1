Received: from eggs.gnu.org ([2001:4830:134:3::10]:53857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KO-0007Wn-5o
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KN-0003k6-2e
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9KM-0003io-QY
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:59 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C044680F8E
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:50:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:50:12 +0100
Message-Id: <20170315135021.6978-23-quintela@redhat.com>
In-Reply-To: <20170315135021.6978-1-quintela@redhat.com>
References: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 22/31] ram: move migration_bitmap_mutex into
 RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7f56b5f..c14293c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -178,6 +178,8 @@ struct RAMState {
     uint64_t xbzrle_overflows;
     /* number of dirty bits in the bitmap */
     uint64_t migration_dirty_pages;
+    /* protects modification of the bitmap */
+    QemuMutex bitmap_mutex;
 };
 typedef struct RAMState RAMState;
 
@@ -223,8 +225,6 @@ static ram_addr_t ram_save_remaining(void)
     return ram_state.migration_dirty_pages;
 }
 
-static QemuMutex migration_bitmap_mutex;
-
 /* used by the search for pages to send */
 struct PageSearchStatus {
     /* Current block being searched */
@@ -626,13 +626,13 @@ static void migration_bitmap_sync(RAMState *rs)
     trace_migration_bitmap_sync_start();
     memory_global_dirty_log_sync();
 
-    qemu_mutex_lock(&migration_bitmap_mutex);
+    qemu_mutex_lock(&rs->bitmap_mutex);
     rcu_read_lock();
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
         migration_bitmap_sync_range(rs, block->offset, block->used_length);
     }
     rcu_read_unlock();
-    qemu_mutex_unlock(&migration_bitmap_mutex);
+    qemu_mutex_unlock(&rs->bitmap_mutex);
 
     trace_migration_bitmap_sync_end(rs->migration_dirty_pages
                                     - num_dirty_pages_init);
@@ -1498,7 +1498,7 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
          * it is safe to migration if migration_bitmap is cleared bit
          * at the same time.
          */
-        qemu_mutex_lock(&migration_bitmap_mutex);
+        qemu_mutex_lock(&ram_state.bitmap_mutex);
         bitmap_copy(bitmap->bmap, old_bitmap->bmap, old);
         bitmap_set(bitmap->bmap, old, new - old);
 
@@ -1509,7 +1509,7 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
         bitmap->unsentmap = NULL;
 
         atomic_rcu_set(&migration_bitmap_rcu, bitmap);
-        qemu_mutex_unlock(&migration_bitmap_mutex);
+        qemu_mutex_unlock(&ram_state.bitmap_mutex);
         ram_state.migration_dirty_pages += new - old;
         call_rcu(old_bitmap, migration_bitmap_free, rcu);
     }
@@ -1911,7 +1911,7 @@ static int ram_state_init(RAMState *rs)
     int64_t ram_bitmap_pages; /* Size of bitmap in pages, including gaps */
 
     memset(rs, 0, sizeof(*rs));
-    qemu_mutex_init(&migration_bitmap_mutex);
+    qemu_mutex_init(&rs->bitmap_mutex);
 
     if (migrate_use_xbzrle()) {
         XBZRLE_cache_lock();
-- 
2.9.3
