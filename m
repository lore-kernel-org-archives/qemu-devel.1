Received: from eggs.gnu.org ([2001:4830:134:3::10]:45746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fhjDg-00027M-Eg
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fhjDf-0007vz-3s
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:22:20 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 23 Jul 2018 18:22:08 -0400
Message-Id: <20180723222210.11077-6-jsnow@redhat.com>
In-Reply-To: <20180723222210.11077-1-jsnow@redhat.com>
References: <20180723222210.11077-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 5/7] dirty-bitmaps: clean-up bitmaps
 loading and migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This patch aims to bring the following behavior:

1. Bitmaps are not loaded on open if BDRV_O_INACTIVE is set, which occurs
   for incoming migration cases. We will load these persistent bitmaps
   on invalidate instead.

2. Regardless of the migration circumstances, persistent bitmaps are
   always flushed to disk on inactivate or close.

3. Bitmaps are read from disk and loaded into memory on any invalidation:
   A) Normal, RW open
   B) Migration target invalidation: With or without dirty-bitmaps
      capability, any bitmaps found on-disk will be loaded.
   C) Migration source invalidation: If the migration fails and the
      source QEMU is resumed, it will re-load bitmaps from disk.

4. When using the dirty-bitmaps migration capability, persistent bitmaps
   are skipped if we are performing a shared storage migration. The
   destination QEMU will load them from disk on invalidate.
   (Transient, non-persistent bitmaps still get migrated.)

   For block migrations, persistent bitmaps are both flushed to disk
   on the source and migrated live across the migration channel.

5. Persistent bitmaps are not unloaded from memory in the inactivate
   handler. Instead, they are removed on-store which occurs during
   inactivate. The effect is functionally the same, but keeps bitmap
   management more inside the module.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block.c                        |  4 ----
 block/dirty-bitmap.c           | 20 --------------------
 block/qcow2-bitmap.c           | 16 ++++++++++++++++
 block/qcow2.c                  |  5 +++--
 include/block/dirty-bitmap.h   |  2 +-
 migration/block-dirty-bitmap.c | 11 ++++++-----
 6 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/block.c b/block.c
index a2fe05ea96..f16bf106d1 100644
--- a/block.c
+++ b/block.c
@@ -4497,10 +4497,6 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
         }
     }
 
-    /* At this point persistent bitmaps should be already stored by the format
-     * driver */
-    bdrv_release_persistent_dirty_bitmaps(bs);
-
     return 0;
 }
 
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index c9b8a6fd52..e44061fe2e 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -383,26 +383,6 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
     bdrv_dirty_bitmaps_unlock(bs);
 }
 
-/**
- * Release all persistent dirty bitmaps attached to a BDS (for use in
- * bdrv_inactivate_recurse()).
- * There must not be any frozen bitmaps attached.
- * This function does not remove persistent bitmaps from the storage.
- * Called with BQL taken.
- */
-void bdrv_release_persistent_dirty_bitmaps(BlockDriverState *bs)
-{
-    BdrvDirtyBitmap *bm, *next;
-
-    bdrv_dirty_bitmaps_lock(bs);
-    QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
-        if (bdrv_dirty_bitmap_get_persistance(bm)) {
-            bdrv_release_dirty_bitmap_locked(bm);
-        }
-    }
-    bdrv_dirty_bitmaps_unlock(bs);
-}
-
 /**
  * Remove persistent dirty bitmap from the storage if it exists.
  * Absence of bitmap is not an error, because we have the following scenario:
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index ba978ad2aa..b5f1b3563d 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1418,6 +1418,22 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         g_free(tb);
     }
 
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        /* For safety, we remove bitmap after storing.
+         * We may be here in two cases:
+         * 1. bdrv_close. It's ok to drop bitmap.
+         * 2. inactivation. It means migration without 'dirty-bitmaps'
+         *    capability, so bitmaps are not marked with
+         *    BdrvDirtyBitmap.migration flags. It's not bad to drop them too,
+         *    and reload on invalidation.
+         */
+        if (bm->dirty_bitmap == NULL) {
+            continue;
+        }
+
+        bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
+    }
+
     bitmap_list_free(bm_list);
     return;
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 72d4e67b99..b958cec83d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1495,8 +1495,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
     }
 
-    if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
-        update_header = false;
+    if (!(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
+        bool header_updated = qcow2_load_dirty_bitmaps(bs, &local_err);
+        update_header = update_header && !header_updated;
     }
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 259bd27c40..95c7847ec6 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -26,7 +26,6 @@ BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
                                         const char *name);
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap);
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
-void bdrv_release_persistent_dirty_bitmaps(BlockDriverState *bs);
 void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                          const char *name,
                                          Error **errp);
@@ -72,6 +71,7 @@ void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
 void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked);
 void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
                              Error **errp);
+void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, bool migration);
 
 /* Functions that require manual locking.  */
 void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 477826330c..dac8270d1f 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -295,6 +295,12 @@ static int init_dirty_bitmap_migration(void)
                 continue;
             }
 
+            /* Skip persistant bitmaps, unless it's a block migration: */
+            if (bdrv_dirty_bitmap_get_persistance(bitmap) &&
+                !migrate_use_block()) {
+                continue;
+            }
+
             if (drive_name == NULL) {
                 error_report("Found bitmap '%s' in unnamed node %p. It can't "
                              "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);
@@ -335,11 +341,6 @@ static int init_dirty_bitmap_migration(void)
         }
     }
 
-    /* unset persistance here, to not roll back it */
-    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
-        bdrv_dirty_bitmap_set_persistance(dbms->bitmap, false);
-    }
-
     if (QSIMPLEQ_EMPTY(&dirty_bitmap_mig_state.dbms_list)) {
         dirty_bitmap_mig_state.no_bitmaps = true;
     }
-- 
2.14.4
