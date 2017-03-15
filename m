Received: from eggs.gnu.org ([2001:4830:134:3::10]:53802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KL-0007U5-DH
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KK-0003f3-2S
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9KJ-0003dj-Ou
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:55 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B949A4DD60
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:50:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:50:10 +0100
Message-Id: <20170315135021.6978-21-quintela@redhat.com>
In-Reply-To: <20170315135021.6978-1-quintela@redhat.com>
References: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 20/31] ram: move migration_dirty_pages to
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
 migration/ram.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 75ad17f..606e836 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -176,6 +176,8 @@ struct RAMState {
     double xbzrle_cache_miss_rate;
     /* xbzrle number of overflows */
     uint64_t xbzrle_overflows;
+    /* number of dirty bits in the bitmap */
+    uint64_t migration_dirty_pages;
 };
 typedef struct RAMState RAMState;
 
@@ -216,8 +218,12 @@ uint64_t xbzrle_mig_pages_overflow(void)
     return ram_state.xbzrle_overflows;
 }
 
+static ram_addr_t ram_save_remaining(void)
+{
+    return ram_state.migration_dirty_pages;
+}
+
 static QemuMutex migration_bitmap_mutex;
-static uint64_t migration_dirty_pages;
 
 /* used by the search for pages to send */
 struct PageSearchStatus {
@@ -559,7 +565,7 @@ ram_addr_t migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
     return (next - base) << TARGET_PAGE_BITS;
 }
 
-static inline bool migration_bitmap_clear_dirty(ram_addr_t addr)
+static inline bool migration_bitmap_clear_dirty(RAMState *rs, ram_addr_t addr)
 {
     bool ret;
     int nr = addr >> TARGET_PAGE_BITS;
@@ -568,16 +574,17 @@ static inline bool migration_bitmap_clear_dirty(ram_addr_t addr)
     ret = test_and_clear_bit(nr, bitmap);
 
     if (ret) {
-        migration_dirty_pages--;
+        rs->migration_dirty_pages--;
     }
     return ret;
 }
 
-static void migration_bitmap_sync_range(ram_addr_t start, ram_addr_t length)
+static void migration_bitmap_sync_range(RAMState *rs, ram_addr_t start,
+                                        ram_addr_t length)
 {
     unsigned long *bitmap;
     bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
-    migration_dirty_pages +=
+    rs-> migration_dirty_pages +=
         cpu_physical_memory_sync_dirty_bitmap(bitmap, start, length);
 }
 
@@ -610,7 +617,7 @@ uint64_t ram_pagesize_summary(void)
 static void migration_bitmap_sync(RAMState *rs)
 {
     RAMBlock *block;
-    uint64_t num_dirty_pages_init = migration_dirty_pages;
+    uint64_t num_dirty_pages_init = rs->migration_dirty_pages;
     MigrationState *s = migrate_get_current();
     int64_t end_time;
     int64_t bytes_xfer_now;
@@ -631,14 +638,14 @@ static void migration_bitmap_sync(RAMState *rs)
     qemu_mutex_lock(&migration_bitmap_mutex);
     rcu_read_lock();
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
-        migration_bitmap_sync_range(block->offset, block->used_length);
+        migration_bitmap_sync_range(rs, block->offset, block->used_length);
     }
     rcu_read_unlock();
     qemu_mutex_unlock(&migration_bitmap_mutex);
 
-    trace_migration_bitmap_sync_end(migration_dirty_pages
+    trace_migration_bitmap_sync_end(rs->migration_dirty_pages
                                     - num_dirty_pages_init);
-    rs->num_dirty_pages_period += migration_dirty_pages - num_dirty_pages_init;
+    rs->num_dirty_pages_period += rs->migration_dirty_pages - num_dirty_pages_init;
     end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
 
     /* more than 1 second = 1000 millisecons */
@@ -1264,7 +1271,7 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
     int res = 0;
 
     /* Check the pages is dirty and if it is send it */
-    if (migration_bitmap_clear_dirty(dirty_ram_abs)) {
+    if (migration_bitmap_clear_dirty(rs, dirty_ram_abs)) {
         unsigned long *unsentmap;
         if (compression_switch && migrate_use_compression()) {
             res = ram_save_compressed_page(rs, ms, f, pss,
@@ -1414,11 +1421,6 @@ void acct_update_position(QEMUFile *f, size_t size, bool zero)
     }
 }
 
-static ram_addr_t ram_save_remaining(void)
-{
-    return migration_dirty_pages;
-}
-
 uint64_t ram_bytes_remaining(void)
 {
     return ram_save_remaining() * TARGET_PAGE_SIZE;
@@ -1517,7 +1519,7 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
 
         atomic_rcu_set(&migration_bitmap_rcu, bitmap);
         qemu_mutex_unlock(&migration_bitmap_mutex);
-        migration_dirty_pages += new - old;
+        ram_state.migration_dirty_pages += new - old;
         call_rcu(old_bitmap, migration_bitmap_free, rcu);
     }
 }
@@ -1771,7 +1773,7 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
                  * Remark them as dirty, updating the count for any pages
                  * that weren't previously dirty.
                  */
-                migration_dirty_pages += !test_and_set_bit(page, bitmap);
+                ram_state.migration_dirty_pages += !test_and_set_bit(page, bitmap);
             }
         }
 
@@ -1984,7 +1986,7 @@ static int ram_save_init_globals(RAMState *rs)
      * Count the total number of pages used by ram blocks not including any
      * gaps due to alignment or unplugs.
      */
-    migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
+    rs->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
 
     memory_global_dirty_log_start();
     migration_bitmap_sync(rs);
-- 
2.9.3
