Received: from eggs.gnu.org ([2001:4830:134:3::10]:44024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0whw-00045E-Cn
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0whv-00077F-GP
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0whv-00076l-7t
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 176B47AEAB
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:00:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 19 Apr 2017 22:58:51 +0200
Message-Id: <20170419205923.8808-28-quintela@redhat.com>
In-Reply-To: <20170419205923.8808-1-quintela@redhat.com>
References: <20170419205923.8808-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 27/59] ram: Move migration_bitmap_mutex into
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 42bb82f..23819cd 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -185,6 +185,8 @@ struct RAMState {
     uint64_t xbzrle_overflows;
     /* number of dirty bits in the bitmap */
     uint64_t migration_dirty_pages;
+    /* protects modification of the bitmap */
+    QemuMutex bitmap_mutex;
 };
 typedef struct RAMState RAMState;
 
@@ -230,8 +232,6 @@ static ram_addr_t ram_save_remaining(void)
     return ram_state.migration_dirty_pages;
 }
 
-static QemuMutex migration_bitmap_mutex;
-
 /* used by the search for pages to send */
 struct PageSearchStatus {
     /* Current block being searched */
@@ -653,13 +653,13 @@ static void migration_bitmap_sync(RAMState *rs)
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
 
@@ -1526,6 +1526,7 @@ static void ram_state_reset(RAMState *rs)
 void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
 {
     RAMState *rs = &ram_state;
+
     /* called in qemu main thread, so there is
      * no writing race against this migration_bitmap
      */
@@ -1539,7 +1540,7 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
          * it is safe to migration if migration_bitmap is cleared bit
          * at the same time.
          */
-        qemu_mutex_lock(&migration_bitmap_mutex);
+        qemu_mutex_lock(&rs->bitmap_mutex);
         bitmap_copy(bitmap->bmap, old_bitmap->bmap, old);
         bitmap_set(bitmap->bmap, old, new - old);
 
@@ -1550,7 +1551,7 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
         bitmap->unsentmap = NULL;
 
         atomic_rcu_set(&migration_bitmap_rcu, bitmap);
-        qemu_mutex_unlock(&migration_bitmap_mutex);
+        qemu_mutex_unlock(&rs->bitmap_mutex);
         rs->migration_dirty_pages += new - old;
         call_rcu(old_bitmap, migration_bitmap_free, rcu);
     }
@@ -1982,7 +1983,7 @@ static int ram_state_init(RAMState *rs)
     int64_t ram_bitmap_pages; /* Size of bitmap in pages, including gaps */
 
     memset(rs, 0, sizeof(*rs));
-    qemu_mutex_init(&migration_bitmap_mutex);
+    qemu_mutex_init(&rs->bitmap_mutex);
 
     if (migrate_use_xbzrle()) {
         XBZRLE_cache_lock();
-- 
2.9.3
