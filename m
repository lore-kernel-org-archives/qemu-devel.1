Received: from eggs.gnu.org ([2001:4830:134:3::10]:45630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cq-00084A-Jm
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cp-0000Se-4O
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9co-0000SS-Se
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D414B7F3E1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:18 +0100
Message-Id: <20170323204544.12015-26-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 25/51] ram: Move migration_bitmap_rcu into
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

Once there, rename the type to be shorter.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 86 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ae2b89f..090084b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -138,6 +138,19 @@ out:
     return ret;
 }
 
+struct RAMBitmap {
+    struct rcu_head rcu;
+    /* Main migration bitmap */
+    unsigned long *bmap;
+    /* bitmap of pages that haven't been sent even once
+     * only maintained and used in postcopy at the moment
+     * where it's used to send the dirtymap at the start
+     * of the postcopy phase
+     */
+    unsigned long *unsentmap;
+};
+typedef struct RAMBitmap RAMBitmap;
+
 /* State of RAM for migration */
 struct RAMState {
     /* Last block that we have visited searching for dirty pages */
@@ -186,6 +199,8 @@ struct RAMState {
     uint64_t migration_dirty_pages;
     /* protects modification of the bitmap */
     QemuMutex bitmap_mutex;
+    /* Ram Bitmap protected by RCU */
+    RAMBitmap *ram_bitmap;
 };
 typedef struct RAMState RAMState;
 
@@ -242,18 +257,6 @@ struct PageSearchStatus {
 };
 typedef struct PageSearchStatus PageSearchStatus;
 
-static struct BitmapRcu {
-    struct rcu_head rcu;
-    /* Main migration bitmap */
-    unsigned long *bmap;
-    /* bitmap of pages that haven't been sent even once
-     * only maintained and used in postcopy at the moment
-     * where it's used to send the dirtymap at the start
-     * of the postcopy phase
-     */
-    unsigned long *unsentmap;
-} *migration_bitmap_rcu;
-
 struct CompressParam {
     bool done;
     bool quit;
@@ -576,7 +579,7 @@ ram_addr_t migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
 
     unsigned long next;
 
-    bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
+    bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
     if (rs->ram_bulk_stage && nr > base) {
         next = nr + 1;
     } else {
@@ -591,7 +594,7 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs, ram_addr_t addr)
 {
     bool ret;
     int nr = addr >> TARGET_PAGE_BITS;
-    unsigned long *bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
+    unsigned long *bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
 
     ret = test_and_clear_bit(nr, bitmap);
 
@@ -605,7 +608,7 @@ static void migration_bitmap_sync_range(RAMState *rs, ram_addr_t start,
                                         ram_addr_t length)
 {
     unsigned long *bitmap;
-    bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
+    bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
     rs->migration_dirty_pages +=
         cpu_physical_memory_sync_dirty_bitmap(bitmap, start, length,
                                               &rs->num_dirty_pages_period);
@@ -1148,14 +1151,14 @@ static bool get_queued_page(RAMState *rs, MigrationState *ms,
          */
         if (block) {
             unsigned long *bitmap;
-            bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
+            bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
             dirty = test_bit(*ram_addr_abs >> TARGET_PAGE_BITS, bitmap);
             if (!dirty) {
                 trace_get_queued_page_not_dirty(
                     block->idstr, (uint64_t)offset,
                     (uint64_t)*ram_addr_abs,
                     test_bit(*ram_addr_abs >> TARGET_PAGE_BITS,
-                         atomic_rcu_read(&migration_bitmap_rcu)->unsentmap));
+                         atomic_rcu_read(&rs->ram_bitmap)->unsentmap));
             } else {
                 trace_get_queued_page(block->idstr,
                                       (uint64_t)offset,
@@ -1314,7 +1317,7 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
         if (res < 0) {
             return res;
         }
-        unsentmap = atomic_rcu_read(&migration_bitmap_rcu)->unsentmap;
+        unsentmap = atomic_rcu_read(&rs->ram_bitmap)->unsentmap;
         if (unsentmap) {
             clear_bit(dirty_ram_abs >> TARGET_PAGE_BITS, unsentmap);
         }
@@ -1478,7 +1481,7 @@ void free_xbzrle_decoded_buf(void)
     xbzrle_decoded_buf = NULL;
 }
 
-static void migration_bitmap_free(struct BitmapRcu *bmap)
+static void migration_bitmap_free(struct RAMBitmap *bmap)
 {
     g_free(bmap->bmap);
     g_free(bmap->unsentmap);
@@ -1487,11 +1490,13 @@ static void migration_bitmap_free(struct BitmapRcu *bmap)
 
 static void ram_migration_cleanup(void *opaque)
 {
+    RAMState *rs = opaque;
+
     /* caller have hold iothread lock or is in a bh, so there is
      * no writing race against this migration_bitmap
      */
-    struct BitmapRcu *bitmap = migration_bitmap_rcu;
-    atomic_rcu_set(&migration_bitmap_rcu, NULL);
+    struct RAMBitmap *bitmap = rs->ram_bitmap;
+    atomic_rcu_set(&rs->ram_bitmap, NULL);
     if (bitmap) {
         memory_global_dirty_log_stop();
         call_rcu(bitmap, migration_bitmap_free, rcu);
@@ -1528,9 +1533,9 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
     /* called in qemu main thread, so there is
      * no writing race against this migration_bitmap
      */
-    if (migration_bitmap_rcu) {
-        struct BitmapRcu *old_bitmap = migration_bitmap_rcu, *bitmap;
-        bitmap = g_new(struct BitmapRcu, 1);
+    if (rs->ram_bitmap) {
+        struct RAMBitmap *old_bitmap = rs->ram_bitmap, *bitmap;
+        bitmap = g_new(struct RAMBitmap, 1);
         bitmap->bmap = bitmap_new(new);
 
         /* prevent migration_bitmap content from being set bit
@@ -1548,7 +1553,7 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
          */
         bitmap->unsentmap = NULL;
 
-        atomic_rcu_set(&migration_bitmap_rcu, bitmap);
+        atomic_rcu_set(&rs->ram_bitmap, bitmap);
         qemu_mutex_unlock(&rs->bitmap_mutex);
         rs->migration_dirty_pages += new - old;
         call_rcu(old_bitmap, migration_bitmap_free, rcu);
@@ -1563,13 +1568,13 @@ void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
 void ram_debug_dump_bitmap(unsigned long *todump, bool expected)
 {
     int64_t ram_pages = last_ram_offset() >> TARGET_PAGE_BITS;
-
+    RAMState *rs = &ram_state;
     int64_t cur;
     int64_t linelen = 128;
     char linebuf[129];
 
     if (!todump) {
-        todump = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
+        todump = atomic_rcu_read(&rs->ram_bitmap)->bmap;
     }
 
     for (cur = 0; cur < ram_pages; cur += linelen) {
@@ -1598,8 +1603,9 @@ void ram_debug_dump_bitmap(unsigned long *todump, bool expected)
 
 void ram_postcopy_migrated_memory_release(MigrationState *ms)
 {
+    RAMState *rs = &ram_state;
     struct RAMBlock *block;
-    unsigned long *bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
+    unsigned long *bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
 
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
         unsigned long first = block->offset >> TARGET_PAGE_BITS;
@@ -1634,11 +1640,12 @@ static int postcopy_send_discard_bm_ram(MigrationState *ms,
                                         unsigned long start,
                                         unsigned long length)
 {
+    RAMState *rs = &ram_state;
     unsigned long end = start + length; /* one after the end */
     unsigned long current;
     unsigned long *unsentmap;
 
-    unsentmap = atomic_rcu_read(&migration_bitmap_rcu)->unsentmap;
+    unsentmap = atomic_rcu_read(&rs->ram_bitmap)->unsentmap;
     for (current = start; current < end; ) {
         unsigned long one = find_next_bit(unsentmap, end, current);
 
@@ -1737,8 +1744,8 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
         return;
     }
 
-    bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
-    unsentmap = atomic_rcu_read(&migration_bitmap_rcu)->unsentmap;
+    bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
+    unsentmap = atomic_rcu_read(&rs->ram_bitmap)->unsentmap;
 
     if (unsent_pass) {
         /* Find a sent page */
@@ -1896,15 +1903,16 @@ static int postcopy_chunk_hostpages(MigrationState *ms)
  */
 int ram_postcopy_send_discard_bitmap(MigrationState *ms)
 {
+    RAMState *rs = &ram_state;
     int ret;
     unsigned long *bitmap, *unsentmap;
 
     rcu_read_lock();
 
     /* This should be our last sync, the src is now paused */
-    migration_bitmap_sync(&ram_state);
+    migration_bitmap_sync(rs);
 
-    unsentmap = atomic_rcu_read(&migration_bitmap_rcu)->unsentmap;
+    unsentmap = atomic_rcu_read(&rs->ram_bitmap)->unsentmap;
     if (!unsentmap) {
         /* We don't have a safe way to resize the sentmap, so
          * if the bitmap was resized it will be NULL at this
@@ -1925,7 +1933,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
     /*
      * Update the unsentmap to be unsentmap = unsentmap | dirty
      */
-    bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
+    bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
     bitmap_or(unsentmap, unsentmap, bitmap,
                last_ram_offset() >> TARGET_PAGE_BITS);
 
@@ -2020,16 +2028,16 @@ static int ram_state_init(RAMState *rs)
     bytes_transferred = 0;
     ram_state_reset(rs);
 
-    migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
+    rs->ram_bitmap = g_new0(struct RAMBitmap, 1);
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
         ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
-        migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
-        bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
+        rs->ram_bitmap->bmap = bitmap_new(ram_bitmap_pages);
+        bitmap_set(rs->ram_bitmap->bmap, 0, ram_bitmap_pages);
 
         if (migrate_postcopy_ram()) {
-            migration_bitmap_rcu->unsentmap = bitmap_new(ram_bitmap_pages);
-            bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages);
+            rs->ram_bitmap->unsentmap = bitmap_new(ram_bitmap_pages);
+            bitmap_set(rs->ram_bitmap->unsentmap, 0, ram_bitmap_pages);
         }
     }
 
-- 
2.9.3
