Received: from eggs.gnu.org ([2001:4830:134:3::10]:45415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2k-0004bt-UB
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2g-0002Vw-OH
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF2e-0002K3-Ob
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:45 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:59 -0400
Message-Id: <20181029212501.5897-18-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 17/19] dirty-bitmaps: clean-up bitmaps loading
 and migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This patch aims to bring the following behavior:

1. We don't load bitmaps, when started in inactive mode. It's the case
of incoming migration. In this case we wait for bitmaps migration
through migration channel (if 'dirty-bitmaps' capability is enabled) or
for invalidation (to load bitmaps from the image).

2. We don't remove persistent bitmaps on inactivation. Instead, we only
remove bitmaps after storing. This is the only way to restore bitmaps,
if we decided to resume source after [failed] migration with
'dirty-bitmaps' capability enabled (which means, that bitmaps were not
stored).

3. We load bitmaps on open and any invalidation, it's ok for all cases:
  - normal open
  - migration target invalidation with dirty-bitmaps capability
    (bitmaps are migrating through migration channel, the are not
     stored, so they should have IN_USE flag set and will be skipped
     when loading. However, it would fail if bitmaps are read-only[1])
  - migration target invalidation without dirty-bitmaps capability
    (normal load of the bitmaps, if migrated with shared storage)
  - source invalidation with dirty-bitmaps capability
    (skip because IN_USE)
  - source invalidation without dirty-bitmaps capability
    (bitmaps were dropped, reload them)

[1]: to accurately handle this, migration of read-only bitmaps is
     explicitly forbidden in this patch.

New mechanism for not storing bitmaps when migrate with dirty-bitmaps
capability is introduced: migration filed in BdrvDirtyBitmap.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block.c                        | 11 ++++---
 block/dirty-bitmap.c           | 36 +++++++++--------------
 block/qcow2-bitmap.c           | 16 +++++++++++
 block/qcow2.c                  | 65 ++++++++++++++++++++++++++++++++++++++++--
 include/block/dirty-bitmap.h   |  2 +-
 migration/block-dirty-bitmap.c | 10 +++++--
 6 files changed, 109 insertions(+), 31 deletions(-)

diff --git a/block.c b/block.c
index 08d64cdc61..95d8635aa1 100644
--- a/block.c
+++ b/block.c
@@ -4403,6 +4403,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
     uint64_t perm, shared_perm;
     Error *local_err = NULL;
     int ret;
+    BdrvDirtyBitmap *bm;
 
     if (!bs->drv)  {
         return;
@@ -4452,6 +4453,12 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
         }
     }
 
+    for (bm = bdrv_dirty_bitmap_next(bs, NULL); bm;
+         bm = bdrv_dirty_bitmap_next(bs, bm))
+    {
+        bdrv_dirty_bitmap_set_migration(bm, false);
+    }
+
     ret = refresh_total_sectors(bs, bs->total_sectors);
     if (ret < 0) {
         bs->open_flags |= BDRV_O_INACTIVE;
@@ -4566,10 +4573,6 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
         }
     }
 
-    /* At this point persistent bitmaps should be already stored by the format
-     * driver */
-    bdrv_release_persistent_dirty_bitmaps(bs);
-
     return 0;
 }
 
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 9b9ebd7142..89fd1d7f8b 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -55,6 +55,10 @@ struct BdrvDirtyBitmap {
                                    and this bitmap must remain unchanged while
                                    this flag is set. */
     bool persistent;            /* bitmap must be saved to owner disk image */
+    bool migration;             /* Bitmap is selected for migration, it should
+                                   not be stored on the next inactivation
+                                   (persistent flag doesn't matter until next
+                                   invalidation).*/
     QLIST_ENTRY(BdrvDirtyBitmap) list;
 };
 
@@ -389,26 +393,6 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
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
@@ -761,16 +745,24 @@ void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap, bool persistent)
     qemu_mutex_unlock(bitmap->mutex);
 }
 
+/* Called with BQL taken. */
+void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, bool migration)
+{
+    qemu_mutex_lock(bitmap->mutex);
+    bitmap->migration = migration;
+    qemu_mutex_unlock(bitmap->mutex);
+}
+
 bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap)
 {
-    return bitmap->persistent;
+    return bitmap->persistent && !bitmap->migration;
 }
 
 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
 {
     BdrvDirtyBitmap *bm;
     QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
-        if (bm->persistent && !bm->readonly) {
+        if (bm->persistent && !bm->readonly && !bm->migration) {
             return true;
         }
     }
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
index 3110bb0e20..30689b7688 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1491,8 +1491,69 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
     }
 
-    if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
-        update_header = false;
+    /* == Handle persistent dirty bitmaps ==
+     *
+     * We want load dirty bitmaps in three cases:
+     *
+     * 1. Normal open of the disk in active mode, not related to invalidation
+     *    after migration.
+     *
+     * 2. Invalidation of the target vm after pre-copy phase of migration, if
+     *    bitmaps are _not_ migrating through migration channel, i.e.
+     *    'dirty-bitmaps' capability is disabled.
+     *
+     * 3. Invalidation of source vm after failed or canceled migration.
+     *    This is a very interesting case. There are two possible types of
+     *    bitmaps:
+     *
+     *    A. Stored on inactivation and removed. They should be loaded from the
+     *       image.
+     *
+     *    B. Not stored: not-persistent bitmaps and bitmaps, migrated through
+     *       the migration channel (with dirty-bitmaps capability).
+     *
+     *    On the other hand, there are two possible sub-cases:
+     *
+     *    3.1 disk was changed by somebody else while were inactive. In this
+     *        case all in-RAM dirty bitmaps (both persistent and not) are
+     *        definitely invalid. And we don't have any method to determine
+     *        this.
+     *
+     *        Simple and safe thing is to just drop all the bitmaps of type B on
+     *        inactivation. But in this case we lose bitmaps in valid 4.2 case.
+     *
+     *        On the other hand, resuming source vm, if disk was already changed
+     *        is a bad thing anyway: not only bitmaps, the whole vm state is
+     *        out of sync with disk.
+     *
+     *        This means, that user or management tool, who for some reason
+     *        decided to resume source vm, after disk was already changed by
+     *        target vm, should at least drop all dirty bitmaps by hand.
+     *
+     *        So, we can ignore this case for now, but TODO: "generation"
+     *        extension for qcow2, to determine, that image was changed after
+     *        last inactivation. And if it is changed, we will drop (or at least
+     *        mark as 'invalid' all the bitmaps of type B, both persistent
+     *        and not).
+     *
+     *    3.2 disk was _not_ changed while were inactive. Bitmaps may be saved
+     *        to disk ('dirty-bitmaps' capability disabled), or not saved
+     *        ('dirty-bitmaps' capability enabled), but we don't need to care
+     *        of: let's load bitmaps as always: stored bitmaps will be loaded,
+     *        and not stored has flag IN_USE=1 in the image and will be skipped
+     *        on loading.
+     *
+     * One remaining possible case when we don't want load bitmaps:
+     *
+     * 4. Open disk in inactive mode in target vm (bitmaps are migrating or
+     *    will be loaded on invalidation, no needs try loading them before)
+     */
+
+    if (!(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
+        /* It's case 1, 2 or 3.2. Or 3.1 which is BUG in management layer. */
+        bool header_updated = qcow2_load_dirty_bitmaps(bs, &local_err);
+
+        update_header = update_header && !header_updated;
     }
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 14639439a2..8f38a3dec1 100644
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
                              HBitmap **backup, Error **errp);
+void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, bool migration);
 
 /* Functions that require manual locking.  */
 void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index dfbfb853b7..5e90f44c2f 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -307,6 +307,12 @@ static int init_dirty_bitmap_migration(void)
                 goto fail;
             }
 
+            if (bdrv_dirty_bitmap_readonly(bitmap)) {
+                error_report("Can't migrate read-only dirty bitmap: '%s",
+                             bdrv_dirty_bitmap_name(bitmap));
+                goto fail;
+            }
+
             bdrv_ref(bs);
             bdrv_dirty_bitmap_set_qmp_locked(bitmap, true);
 
@@ -329,9 +335,9 @@ static int init_dirty_bitmap_migration(void)
         }
     }
 
-    /* unset persistance here, to not roll back it */
+    /* unset migration flags here, to not roll back it */
     QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
-        bdrv_dirty_bitmap_set_persistance(dbms->bitmap, false);
+        bdrv_dirty_bitmap_set_migration(dbms->bitmap, true);
     }
 
     if (QSIMPLEQ_EMPTY(&dirty_bitmap_mig_state.dbms_list)) {
-- 
2.14.5
