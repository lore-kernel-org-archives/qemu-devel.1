Received: from eggs.gnu.org ([209.51.188.92]:44860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7J-0000rd-IA
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7G-0006v8-V7
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2M7G-0006qU-3O
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:14 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Mar 2019 15:28:54 -0500
Message-Id: <20190308202858.26636-14-jsnow@redhat.com>
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
References: <20190308202858.26636-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 13/17] block/dirty-bitmaps: add
 block_dirty_bitmap_check function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

Instead of checking against busy, inconsistent, or read only directly,
use a check function with permissions bits that let us streamline the
checks without reproducing them in many places.

Included in this patch are permissions changes that simply add the
inconsistent check to existing permissions call spots, without
addressing existing bugs.

In general, this means that busy+readonly checks become BDRV_BITMAP_DEFAULT,
which checks against all three conditions. busy-only checks become
BDRV_BITMAP_ALLOW_RO.

Notably, remove allows inconsistent bitmaps, so it doesn't follow the pattern.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190301191545.8728-4-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/block/dirty-bitmap.h   | 13 ++++++++-
 block/dirty-bitmap.c           | 42 ++++++++++++++++++++---------
 blockdev.c                     | 49 +++++++---------------------------
 migration/block-dirty-bitmap.c | 12 +++------
 nbd/server.c                   |  3 +--
 5 files changed, 55 insertions(+), 64 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index bd1b6479df..2a78243954 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -5,6 +5,16 @@
 #include "qapi/qapi-types-block-core.h"
 #include "qemu/hbitmap.h"
 
+typedef enum BitmapCheckFlags {
+    BDRV_BITMAP_BUSY = 1,
+    BDRV_BITMAP_RO = 2,
+    BDRV_BITMAP_INCONSISTENT = 4,
+} BitmapCheckFlags;
+
+#define BDRV_BITMAP_DEFAULT (BDRV_BITMAP_BUSY | BDRV_BITMAP_RO |        \
+                             BDRV_BITMAP_INCONSISTENT)
+#define BDRV_BITMAP_ALLOW_RO (BDRV_BITMAP_BUSY | BDRV_BITMAP_INCONSISTENT)
+
 BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
                                           uint32_t granularity,
                                           const char *name,
@@ -24,6 +34,8 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
 void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
                                         const char *name);
+int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitmap, uint32_t flags,
+                            Error **errp);
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap);
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
 void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
@@ -93,7 +105,6 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_inconsistent(const BdrvDirtyBitmap *bitmap);
-bool bdrv_dirty_bitmap_busy(BdrvDirtyBitmap *bitmap);
 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 987ea7ca29..6b6fed1363 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -174,7 +174,7 @@ bool bdrv_dirty_bitmap_has_successor(BdrvDirtyBitmap *bitmap)
     return bitmap->successor;
 }
 
-bool bdrv_dirty_bitmap_busy(BdrvDirtyBitmap *bitmap) {
+static bool bdrv_dirty_bitmap_busy(const BdrvDirtyBitmap *bitmap) {
     return bitmap->busy;
 }
 
@@ -235,6 +235,33 @@ static bool bdrv_dirty_bitmap_recording(BdrvDirtyBitmap *bitmap)
                                  !bitmap->successor->disabled);
 }
 
+int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitmap, uint32_t flags,
+                            Error **errp)
+{
+    if ((flags & BDRV_BITMAP_BUSY) && bdrv_dirty_bitmap_busy(bitmap)) {
+        error_setg(errp, "Bitmap '%s' is currently in use by another"
+                   " operation and cannot be used", bitmap->name);
+        return -1;
+    }
+
+    if ((flags & BDRV_BITMAP_RO) && bdrv_dirty_bitmap_readonly(bitmap)) {
+        error_setg(errp, "Bitmap '%s' is readonly and cannot be modified",
+                   bitmap->name);
+        return -1;
+    }
+
+    if ((flags & BDRV_BITMAP_INCONSISTENT) &&
+        bdrv_dirty_bitmap_inconsistent(bitmap)) {
+        error_setg(errp, "Bitmap '%s' is inconsistent and cannot be used",
+                   bitmap->name);
+        error_append_hint(errp, "Try block-dirty-bitmap-remove to delete"
+                          " this bitmap from disk");
+        return -1;
+    }
+
+    return 0;
+}
+
 /**
  * Create a successor bitmap destined to replace this bitmap after an operation.
  * Requires that the bitmap is not marked busy and has no successor.
@@ -247,9 +274,7 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
     uint64_t granularity;
     BdrvDirtyBitmap *child;
 
-    if (bdrv_dirty_bitmap_busy(bitmap)) {
-        error_setg(errp, "Cannot create a successor for a bitmap that is in-use "
-                   "by an operation");
+    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY, errp)) {
         return -1;
     }
     if (bdrv_dirty_bitmap_has_successor(bitmap)) {
@@ -795,17 +820,10 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
 
     qemu_mutex_lock(dest->mutex);
 
-    if (bdrv_dirty_bitmap_busy(dest)) {
-        error_setg(errp, "Bitmap '%s' is currently in use by another"
-        " operation and cannot be modified", dest->name);
+    if (bdrv_dirty_bitmap_check(dest, BDRV_BITMAP_DEFAULT, errp)) {
         goto out;
     }
 
-    if (bdrv_dirty_bitmap_readonly(dest)) {
-        error_setg(errp, "Bitmap '%s' is readonly and cannot be modified",
-                   dest->name);
-        goto out;
-    }
 
     if (!hbitmap_can_merge(dest->bitmap, src->bitmap)) {
         error_setg(errp, "Bitmaps are incompatible and can't be merged");
diff --git a/blockdev.c b/blockdev.c
index 8e002cf681..455ab806b2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2008,11 +2008,7 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
         return;
     }
 
-    if (bdrv_dirty_bitmap_busy(state->bitmap)) {
-        error_setg(errp, "Cannot modify a bitmap in use by another operation");
-        return;
-    } else if (bdrv_dirty_bitmap_readonly(state->bitmap)) {
-        error_setg(errp, "Cannot clear a readonly bitmap");
+    if (bdrv_dirty_bitmap_check(state->bitmap, BDRV_BITMAP_DEFAULT, errp)) {
         return;
     }
 
@@ -2057,10 +2053,7 @@ static void block_dirty_bitmap_enable_prepare(BlkActionState *common,
         return;
     }
 
-    if (bdrv_dirty_bitmap_busy(state->bitmap)) {
-        error_setg(errp,
-                   "Bitmap '%s' is currently in use by another operation"
-                   " and cannot be enabled", action->name);
+    if (bdrv_dirty_bitmap_check(state->bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
         return;
     }
 
@@ -2098,10 +2091,7 @@ static void block_dirty_bitmap_disable_prepare(BlkActionState *common,
         return;
     }
 
-    if (bdrv_dirty_bitmap_busy(state->bitmap)) {
-        error_setg(errp,
-                   "Bitmap '%s' is currently in use by another operation"
-                   " and cannot be disabled", action->name);
+    if (bdrv_dirty_bitmap_check(state->bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
         return;
     }
 
@@ -2892,10 +2882,7 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
         return;
     }
 
-    if (bdrv_dirty_bitmap_busy(bitmap)) {
-        error_setg(errp,
-                   "Bitmap '%s' is currently in use by another operation and"
-                   " cannot be removed", name);
+    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY, errp)) {
         return;
     }
 
@@ -2931,13 +2918,7 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
         return;
     }
 
-    if (bdrv_dirty_bitmap_busy(bitmap)) {
-        error_setg(errp,
-                   "Bitmap '%s' is currently in use by another operation"
-                   " and cannot be cleared", name);
-        return;
-    } else if (bdrv_dirty_bitmap_readonly(bitmap)) {
-        error_setg(errp, "Bitmap '%s' is readonly and cannot be cleared", name);
+    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, errp)) {
         return;
     }
 
@@ -2955,10 +2936,7 @@ void qmp_block_dirty_bitmap_enable(const char *node, const char *name,
         return;
     }
 
-    if (bdrv_dirty_bitmap_busy(bitmap)) {
-        error_setg(errp,
-                   "Bitmap '%s' is currently in use by another operation"
-                   " and cannot be enabled", name);
+    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
         return;
     }
 
@@ -2976,10 +2954,7 @@ void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
         return;
     }
 
-    if (bdrv_dirty_bitmap_busy(bitmap)) {
-        error_setg(errp,
-                   "Bitmap '%s' is currently in use by another operation"
-                   " and cannot be disabled", name);
+    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
         return;
     }
 
@@ -3558,10 +3533,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
             bdrv_unref(target_bs);
             goto out;
         }
-        if (bdrv_dirty_bitmap_busy(bmap)) {
-            error_setg(errp,
-                       "Bitmap '%s' is currently in use by another operation"
-                       " and cannot be used for backup", backup->bitmap);
+        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_ALLOW_RO, errp)) {
             goto out;
         }
     }
@@ -3671,10 +3643,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
             error_setg(errp, "Bitmap '%s' could not be found", backup->bitmap);
             goto out;
         }
-        if (bdrv_dirty_bitmap_busy(bmap)) {
-            error_setg(errp,
-                       "Bitmap '%s' is currently in use by another operation"
-                       " and cannot be used for backup", backup->bitmap);
+        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_ALLOW_RO, errp)) {
             goto out;
         }
     }
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 7057fff242..0fcf897f32 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -274,6 +274,7 @@ static int init_dirty_bitmap_migration(void)
     BdrvDirtyBitmap *bitmap;
     DirtyBitmapMigBitmapState *dbms;
     BdrvNextIterator it;
+    Error *local_err = NULL;
 
     dirty_bitmap_mig_state.bulk_completed = false;
     dirty_bitmap_mig_state.prev_bs = NULL;
@@ -301,15 +302,8 @@ static int init_dirty_bitmap_migration(void)
                 goto fail;
             }
 
-            if (bdrv_dirty_bitmap_busy(bitmap)) {
-                error_report("Can't migrate a bitmap that is in use by another operation: '%s'",
-                             bdrv_dirty_bitmap_name(bitmap));
-                goto fail;
-            }
-
-            if (bdrv_dirty_bitmap_readonly(bitmap)) {
-                error_report("Can't migrate read-only dirty bitmap: '%s",
-                             bdrv_dirty_bitmap_name(bitmap));
+            if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, &local_err)) {
+                error_report_err(local_err);
                 goto fail;
             }
 
diff --git a/nbd/server.c b/nbd/server.c
index 02773e2836..9b87c7f243 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1510,8 +1510,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
             goto fail;
         }
 
-        if (bdrv_dirty_bitmap_busy(bm)) {
-            error_setg(errp, "Bitmap '%s' is in use", bitmap);
+        if (bdrv_dirty_bitmap_check(bm, BDRV_BITMAP_ALLOW_RO, errp)) {
             goto fail;
         }
 
-- 
2.17.2
