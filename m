Received: from eggs.gnu.org ([209.51.188.92]:47743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu494-0005by-BW
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu45I-0005gy-In
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:36:57 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Feb 2019 18:36:18 -0500
Message-Id: <20190213233618.22484-3-jsnow@redhat.com>
In-Reply-To: <20190213233618.22484-1-jsnow@redhat.com>
References: <20190213233618.22484-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 2/2] block/dirty-bitmap: implement
 inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, eblake@redhat.com, John Snow <jsnow@redhat.com>, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 15 +++++++++++++
 block/qcow2-bitmap.c         | 42 ++++++++++++++++++-----------------
 blockdev.c                   | 43 ++++++++++++++++++++++++++++++++++++
 include/block/dirty-bitmap.h |  1 +
 4 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index b1879d7fbd..06d8ee0d79 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -589,6 +589,7 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
         *out = backup;
     }
     bdrv_dirty_bitmap_unlock(bitmap);
+    bdrv_dirty_bitmap_set_inconsistent(bitmap, false);
 }
 
 void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *backup)
@@ -776,6 +777,13 @@ bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
     return hbitmap_next_dirty_area(bitmap->bitmap, offset, bytes);
 }
 
+void bdrv_dirty_bitmap_add_inconsistent_hint(Error **errp)
+{
+    error_append_hint(errp, "Try block-dirty-bitmap-clear to mark this "
+                      "bitmap consistent again, or block-dirty-bitmap-remove "
+                      "to delete it.");
+}
+
 void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
                              HBitmap **backup, Error **errp)
 {
@@ -798,6 +806,13 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
         goto out;
     }
 
+    if (bdrv_dirty_bitmap_inconsistent(dest)) {
+        error_setg(errp, "Bitmap '%s' is inconsistent and cannot be used as"
+                   " a merge target", dest->name);
+        bdrv_dirty_bitmap_add_inconsistent_hint(errp);
+        goto out;
+    }
+
     if (!hbitmap_can_merge(dest->bitmap, src->bitmap)) {
         error_setg(errp, "Bitmaps are incompatible and can't be merged");
         goto out;
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 3ee524da4b..9bd8bc417f 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -343,9 +343,15 @@ static BdrvDirtyBitmap *load_bitmap(BlockDriverState *bs,
     uint32_t granularity;
     BdrvDirtyBitmap *bitmap = NULL;
 
+    granularity = 1U << bm->granularity_bits;
+    bitmap = bdrv_create_dirty_bitmap(bs, granularity, bm->name, errp);
+    if (bitmap == NULL) {
+        goto fail;
+    }
+
     if (bm->flags & BME_FLAG_IN_USE) {
-        error_setg(errp, "Bitmap '%s' is in use", bm->name);
-        goto fail;
+        /* Data is unusable, skip loading it */
+        return bitmap;
     }
 
     ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
@@ -356,12 +362,6 @@ static BdrvDirtyBitmap *load_bitmap(BlockDriverState *bs,
         goto fail;
     }
 
-    granularity = 1U << bm->granularity_bits;
-    bitmap = bdrv_create_dirty_bitmap(bs, granularity, bm->name, errp);
-    if (bitmap == NULL) {
-        goto fail;
-    }
-
     ret = load_bitmap_data(bs, bitmap_table, bm->table.size, bitmap);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not read bitmap '%s' from image",
@@ -962,20 +962,22 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     }
 
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        if (!(bm->flags & BME_FLAG_IN_USE)) {
-            BdrvDirtyBitmap *bitmap = load_bitmap(bs, bm, errp);
-            if (bitmap == NULL) {
-                goto fail;
-            }
+        BdrvDirtyBitmap *bitmap = load_bitmap(bs, bm, errp);
+        if (bitmap == NULL) {
+            goto fail;
+        }
+
+        if (bm->flags & BME_FLAG_IN_USE) {
+            bdrv_dirty_bitmap_set_inconsistent(bitmap, true);
+        }
 
-            if (!(bm->flags & BME_FLAG_AUTO)) {
-                bdrv_disable_dirty_bitmap(bitmap);
-            }
-            bdrv_dirty_bitmap_set_persistance(bitmap, true);
-            bm->flags |= BME_FLAG_IN_USE;
-            created_dirty_bitmaps =
-                    g_slist_append(created_dirty_bitmaps, bitmap);
+        if (!(bm->flags & BME_FLAG_AUTO)) {
+            bdrv_disable_dirty_bitmap(bitmap);
         }
+        bdrv_dirty_bitmap_set_persistance(bitmap, true);
+        bm->flags |= BME_FLAG_IN_USE;
+        created_dirty_bitmaps =
+            g_slist_append(created_dirty_bitmaps, bitmap);
     }
 
     if (created_dirty_bitmaps != NULL) {
diff --git a/blockdev.c b/blockdev.c
index 23a4bf136e..12c6f706dd 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1943,6 +1943,7 @@ typedef struct BlockDirtyBitmapState {
     HBitmap *backup;
     bool prepared;
     bool was_enabled;
+    bool was_inconsistent;
 } BlockDirtyBitmapState;
 
 static void block_dirty_bitmap_add_prepare(BlkActionState *common,
@@ -2016,6 +2017,7 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
         return;
     }
 
+    state->was_inconsistent = bdrv_dirty_bitmap_inconsistent(state->bitmap);
     bdrv_clear_dirty_bitmap(state->bitmap, &state->backup);
 }
 
@@ -2027,6 +2029,9 @@ static void block_dirty_bitmap_restore(BlkActionState *common)
     if (state->backup) {
         bdrv_restore_dirty_bitmap(state->bitmap, state->backup);
     }
+    if (state->was_inconsistent) {
+        bdrv_dirty_bitmap_set_inconsistent(state->bitmap, true);
+    }
 }
 
 static void block_dirty_bitmap_free_backup(BlkActionState *common)
@@ -2063,6 +2068,12 @@ static void block_dirty_bitmap_enable_prepare(BlkActionState *common,
                    " and cannot be enabled", action->name);
         return;
     }
+    if (bdrv_dirty_bitmap_inconsistent(state->bitmap)) {
+        error_setg(errp, "Bitmap '%s' is inconsistent and cannot be enabled",
+                   action->name);
+        bdrv_dirty_bitmap_add_inconsistent_hint(errp);
+        return;
+    }
 
     state->was_enabled = bdrv_dirty_bitmap_enabled(state->bitmap);
     bdrv_enable_dirty_bitmap(state->bitmap);
@@ -2104,6 +2115,12 @@ static void block_dirty_bitmap_disable_prepare(BlkActionState *common,
                    " and cannot be disabled", action->name);
         return;
     }
+    if (bdrv_dirty_bitmap_inconsistent(state->bitmap)) {
+        error_setg(errp, "Bitmap '%s' is inconsistent and cannot be disabled",
+                   action->name);
+        bdrv_dirty_bitmap_add_inconsistent_hint(errp);
+        return;
+    }
 
     state->was_enabled = bdrv_dirty_bitmap_enabled(state->bitmap);
     bdrv_disable_dirty_bitmap(state->bitmap);
@@ -2948,6 +2965,13 @@ void qmp_block_dirty_bitmap_enable(const char *node, const char *name,
         return;
     }
 
+    if (bdrv_dirty_bitmap_inconsistent(bitmap)) {
+        error_setg(errp, "Bitmap '%s' is inconsistent and cannot be enabled",
+                   name);
+        bdrv_dirty_bitmap_add_inconsistent_hint(errp);
+        return;
+    }
+
     bdrv_enable_dirty_bitmap(bitmap);
 }
 
@@ -2969,6 +2993,13 @@ void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
         return;
     }
 
+    if (bdrv_dirty_bitmap_inconsistent(bitmap)) {
+        error_setg(errp, "Bitmap '%s' is inconsistent and cannot be disabled",
+                   name);
+        bdrv_dirty_bitmap_add_inconsistent_hint(errp);
+        return;
+    }
+
     bdrv_disable_dirty_bitmap(bitmap);
 }
 
@@ -3544,6 +3575,12 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
                        " and cannot be used for backup", backup->bitmap);
             goto out;
         }
+        if (bdrv_dirty_bitmap_inconsistent(bmap)) {
+            error_setg(errp, "Bitmap '%s' is inconsistent and cannot be used for"
+                       " a backup operation", backup->bitmap);
+            bdrv_dirty_bitmap_add_inconsistent_hint(errp);
+            goto out;
+        }
     }
     if (!backup->auto_finalize) {
         job_flags |= JOB_MANUAL_FINALIZE;
@@ -3657,6 +3694,12 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
                        " and cannot be used for backup", backup->bitmap);
             goto out;
         }
+        if (bdrv_dirty_bitmap_inconsistent(bmap)) {
+            error_setg(errp, "Bitmap '%s' is inconsistent and cannot be used for"
+                       " a backup operation", backup->bitmap);
+            bdrv_dirty_bitmap_add_inconsistent_hint(errp);
+            goto out;
+        }
     }
 
     if (!backup->auto_finalize) {
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index c0d37702fd..b8485d2c94 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -105,5 +105,6 @@ bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
                                                   BdrvDirtyBitmap *bitmap,
                                                   Error **errp);
+void bdrv_dirty_bitmap_add_inconsistent_hint(Error **errp);
 
 #endif
-- 
2.17.2
