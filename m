Received: from eggs.gnu.org ([2001:4830:134:3::10]:50282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7Ah-0005rz-Su
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7Af-0008Dl-9O
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7Af-0008DJ-0a
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 288E065D14
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:09:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:08:44 +0200
Message-Id: <20170406130913.2232-26-quintela@redhat.com>
In-Reply-To: <20170406130913.2232-1-quintela@redhat.com>
References: <20170406130913.2232-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 25/54] ram: Move migration_dirty_pages to
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
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 88392e4..71f8ef3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -183,6 +183,8 @@ struct RAMState {
     double xbzrle_cache_miss_rate;
     /* xbzrle number of overflows */
     uint64_t xbzrle_overflows;
+    /* number of dirty bits in the bitmap */
+    uint64_t migration_dirty_pages;
 };
 typedef struct RAMState RAMState;
 
@@ -223,8 +225,12 @@ uint64_t xbzrle_mig_pages_overflow(void)
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
@@ -582,7 +588,7 @@ ram_addr_t migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
     return (next - base) << TARGET_PAGE_BITS;
 }
 
-static inline bool migration_bitmap_clear_dirty(ram_addr_t addr)
+static inline bool migration_bitmap_clear_dirty(RAMState *rs, ram_addr_t addr)
 {
     bool ret;
     int nr = addr >> TARGET_PAGE_BITS;
@@ -591,7 +597,7 @@ static inline bool migration_bitmap_clear_dirty(ram_addr_t addr)
     ret = test_and_clear_bit(nr, bitmap);
 
     if (ret) {
-        migration_dirty_pages--;
+        rs->migration_dirty_pages--;
     }
     return ret;
 }
@@ -601,8 +607,9 @@ static void migration_bitmap_sync_range(RAMState *rs, ram_addr_t start,
 {
     unsigned long *bitmap;
     bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
-    migration_dirty_pages += cpu_physical_memory_sync_dirty_bitmap(bitmap,
-                             start, length, &rs->num_dirty_pages_period);
+    rs->migration_dirty_pages +=
+        cpu_physical_memory_sync_dirty_bitmap(bitmap, start, length,
+                                              &rs->num_dirty_pages_period);
 }
 
 static void migration_bitmap_sync_init(RAMState *rs)
@@ -1304,7 +1311,7 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
     int res = 0;
 
     /* Check the pages is dirty and if it is send it */
-    if (migration_bitmap_clear_dirty(dirty_ram_abs)) {
+    if (migration_bitmap_clear_dirty(rs, dirty_ram_abs)) {
         unsigned long *unsentmap;
         if (compression_switch && migrate_use_compression()) {
             res = ram_save_compressed_page(rs, ms, f, pss,
@@ -1454,11 +1461,6 @@ void acct_update_position(QEMUFile *f, size_t size, bool zero)
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
@@ -1532,6 +1534,7 @@ static void ram_state_reset(RAMState *rs)
 
 void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
 {
+    RAMState *rs = &ram_state;
     /* called in qemu main thread, so there is
      * no writing race against this migration_bitmap
      */
@@ -1557,7 +1560,7 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
 
         atomic_rcu_set(&migration_bitmap_rcu, bitmap);
         qemu_mutex_unlock(&migration_bitmap_mutex);
-        migration_dirty_pages += new - old;
+        rs->migration_dirty_pages += new - old;
         call_rcu(old_bitmap, migration_bitmap_free, rcu);
     }
 }
@@ -1730,6 +1733,7 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
                                           RAMBlock *block,
                                           PostcopyDiscardState *pds)
 {
+    RAMState *rs = &ram_state;
     unsigned long *bitmap;
     unsigned long *unsentmap;
     unsigned int host_ratio = block->page_size / TARGET_PAGE_SIZE;
@@ -1827,7 +1831,7 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
                  * Remark them as dirty, updating the count for any pages
                  * that weren't previously dirty.
                  */
-                migration_dirty_pages += !test_and_set_bit(page, bitmap);
+                rs->migration_dirty_pages += !test_and_set_bit(page, bitmap);
             }
         }
 
@@ -2053,7 +2057,7 @@ static int ram_save_init_globals(RAMState *rs)
      * Count the total number of pages used by ram blocks not including any
      * gaps due to alignment or unplugs.
      */
-    migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
+    rs->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
 
     memory_global_dirty_log_start();
     migration_bitmap_sync(rs);
-- 
2.9.3
