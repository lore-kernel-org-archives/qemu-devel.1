Received: from eggs.gnu.org ([2001:4830:134:3::10]:45601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cp-000838-Gp
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cn-0000SL-QR
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9cn-0000S0-HW
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88DA1C009A13
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:17 +0100
Message-Id: <20170323204544.12015-25-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 24/51] ram: Move migration_bitmap_mutex into
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
Cc: dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index a890179..ae2b89f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -184,6 +184,8 @@ struct RAMState {
     uint64_t xbzrle_overflows;
     /* number of dirty bits in the bitmap */
     uint64_t migration_dirty_pages;
+    /* protects modification of the bitmap */
+    QemuMutex bitmap_mutex;
 };
 typedef struct RAMState RAMState;
 
@@ -229,8 +231,6 @@ static ram_addr_t ram_save_remaining(void)
     return ram_state.migration_dirty_pages;
 }
 
-static QemuMutex migration_bitmap_mutex;
-
 /* used by the search for pages to send */
 struct PageSearchStatus {
     /* Current block being searched */
@@ -652,13 +652,13 @@ static void migration_bitmap_sync(RAMState *rs)
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
 
     trace_migration_bitmap_sync_end(rs->num_dirty_pages_period);
 
@@ -1524,6 +1524,7 @@ static void ram_state_reset(RAMState *rs)
 void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
 {
     RAMState *rs = &ram_state;
+
     /* called in qemu main thread, so there is
      * no writing race against this migration_bitmap
      */
@@ -1537,7 +1538,7 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
          * it is safe to migration if migration_bitmap is cleared bit
          * at the same time.
          */
-        qemu_mutex_lock(&migration_bitmap_mutex);
+        qemu_mutex_lock(&rs->bitmap_mutex);
         bitmap_copy(bitmap->bmap, old_bitmap->bmap, old);
         bitmap_set(bitmap->bmap, old, new - old);
 
@@ -1548,7 +1549,7 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
         bitmap->unsentmap = NULL;
 
         atomic_rcu_set(&migration_bitmap_rcu, bitmap);
-        qemu_mutex_unlock(&migration_bitmap_mutex);
+        qemu_mutex_unlock(&rs->bitmap_mutex);
         rs->migration_dirty_pages += new - old;
         call_rcu(old_bitmap, migration_bitmap_free, rcu);
     }
@@ -1980,7 +1981,7 @@ static int ram_state_init(RAMState *rs)
     int64_t ram_bitmap_pages; /* Size of bitmap in pages, including gaps */
 
     memset(rs, 0, sizeof(*rs));
-    qemu_mutex_init(&migration_bitmap_mutex);
+    qemu_mutex_init(&rs->bitmap_mutex);
 
     if (migrate_use_xbzrle()) {
         XBZRLE_cache_lock();
-- 
2.9.3
