Received: from eggs.gnu.org ([209.51.188.92]:44859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7J-0000rc-Hy
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7G-0006us-RO
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2M7F-0006nC-AC
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:14 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Mar 2019 15:28:48 -0500
Message-Id: <20190308202858.26636-8-jsnow@redhat.com>
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
References: <20190308202858.26636-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 07/17] block/dirty-bitmaps: unify qmp_locked and
 user_locked calls
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

These mean the same thing now. Unify them and rename the merged call
bdrv_dirty_bitmap_busy to indicate semantically what we are describing,
as well as help disambiguate from the various _locked and _unlocked
versions of bitmap helpers that refer to mutex locks.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190223000614.13894-8-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/block/dirty-bitmap.h   |  5 ++--
 block/dirty-bitmap.c           | 42 +++++++++++++++-------------------
 blockdev.c                     | 18 +++++++--------
 migration/block-dirty-bitmap.c |  6 ++---
 nbd/server.c                   |  6 ++---
 5 files changed, 35 insertions(+), 42 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index cdbb4dfefd..ba8477b73f 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -68,7 +68,7 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
 void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
                                        bool persistent);
-void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked);
+void bdrv_dirty_bitmap_set_busy(BdrvDirtyBitmap *bitmap, bool busy);
 void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
                              HBitmap **backup, Error **errp);
 void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, bool migration);
@@ -91,8 +91,7 @@ bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
-bool bdrv_dirty_bitmap_qmp_locked(BdrvDirtyBitmap *bitmap);
-bool bdrv_dirty_bitmap_user_locked(BdrvDirtyBitmap *bitmap);
+bool bdrv_dirty_bitmap_busy(BdrvDirtyBitmap *bitmap);
 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index abc219814c..d50e74d337 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -48,8 +48,7 @@ struct BdrvDirtyBitmap {
     QemuMutex *mutex;
     HBitmap *bitmap;            /* Dirty bitmap implementation */
     HBitmap *meta;              /* Meta dirty bitmap */
-    bool qmp_locked;            /* Bitmap is locked, it can't be modified
-                                   through QMP */
+    bool busy;                  /* Bitmap is busy, it can't be used via QMP */
     BdrvDirtyBitmap *successor; /* Anonymous child, if any. */
     char *name;                 /* Optional non-empty unique ID */
     int64_t size;               /* Size of the bitmap, in bytes */
@@ -188,22 +187,17 @@ bool bdrv_dirty_bitmap_has_successor(BdrvDirtyBitmap *bitmap)
     return bitmap->successor;
 }
 
-bool bdrv_dirty_bitmap_user_locked(BdrvDirtyBitmap *bitmap) {
-    return bdrv_dirty_bitmap_qmp_locked(bitmap);
+bool bdrv_dirty_bitmap_busy(BdrvDirtyBitmap *bitmap) {
+    return bitmap->busy;
 }
 
-void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked)
+void bdrv_dirty_bitmap_set_busy(BdrvDirtyBitmap *bitmap, bool busy)
 {
     qemu_mutex_lock(bitmap->mutex);
-    bitmap->qmp_locked = qmp_locked;
+    bitmap->busy = busy;
     qemu_mutex_unlock(bitmap->mutex);
 }
 
-bool bdrv_dirty_bitmap_qmp_locked(BdrvDirtyBitmap *bitmap)
-{
-    return bitmap->qmp_locked;
-}
-
 /* Called with BQL taken.  */
 bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap)
 {
@@ -215,7 +209,7 @@ DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap)
 {
     if (bdrv_dirty_bitmap_has_successor(bitmap)) {
         return DIRTY_BITMAP_STATUS_FROZEN;
-    } else if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
+    } else if (bdrv_dirty_bitmap_busy(bitmap)) {
         return DIRTY_BITMAP_STATUS_LOCKED;
     } else if (!bdrv_dirty_bitmap_enabled(bitmap)) {
         return DIRTY_BITMAP_STATUS_DISABLED;
@@ -233,7 +227,7 @@ static bool bdrv_dirty_bitmap_recording(BdrvDirtyBitmap *bitmap)
 
 /**
  * Create a successor bitmap destined to replace this bitmap after an operation.
- * Requires that the bitmap is not user_locked and has no successor.
+ * Requires that the bitmap is not marked busy and has no successor.
  * The successor will be enabled if the parent bitmap was.
  * Called with BQL taken.
  */
@@ -243,7 +237,7 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
     uint64_t granularity;
     BdrvDirtyBitmap *child;
 
-    if (bdrv_dirty_bitmap_user_locked(bitmap)) {
+    if (bdrv_dirty_bitmap_busy(bitmap)) {
         error_setg(errp, "Cannot create a successor for a bitmap that is in-use "
                    "by an operation");
         return -1;
@@ -265,9 +259,9 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
     child->disabled = bitmap->disabled;
     bitmap->disabled = true;
 
-    /* Install the successor and lock the parent */
+    /* Install the successor and mark the parent as busy */
     bitmap->successor = child;
-    bitmap->qmp_locked = true;
+    bitmap->busy = true;
     return 0;
 }
 
@@ -289,7 +283,7 @@ void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
 static void bdrv_release_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap)
 {
     assert(!bitmap->active_iterators);
-    assert(!bdrv_dirty_bitmap_user_locked(bitmap));
+    assert(!bdrv_dirty_bitmap_busy(bitmap));
     assert(!bdrv_dirty_bitmap_has_successor(bitmap));
     assert(!bitmap->meta);
     QLIST_REMOVE(bitmap, list);
@@ -322,7 +316,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
     bitmap->successor = NULL;
     successor->persistent = bitmap->persistent;
     bitmap->persistent = false;
-    bitmap->qmp_locked = false;
+    bitmap->busy = false;
     bdrv_release_dirty_bitmap(bs, bitmap);
 
     return successor;
@@ -331,7 +325,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
 /**
  * In cases of failure where we can no longer safely delete the parent,
  * we may wish to re-join the parent and child/successor.
- * The merged parent will not be user_locked.
+ * The merged parent will be marked as not busy.
  * The marged parent will be enabled if and only if the successor was enabled.
  * Called within bdrv_dirty_bitmap_lock..unlock and with BQL taken.
  */
@@ -352,7 +346,7 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
     }
 
     parent->disabled = successor->disabled;
-    parent->qmp_locked = false;
+    parent->busy = false;
     bdrv_release_dirty_bitmap_locked(successor);
     parent->successor = NULL;
 
@@ -383,7 +377,7 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes)
 
     bdrv_dirty_bitmaps_lock(bs);
     QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
-        assert(!bdrv_dirty_bitmap_user_locked(bitmap));
+        assert(!bdrv_dirty_bitmap_busy(bitmap));
         assert(!bdrv_dirty_bitmap_has_successor(bitmap));
         assert(!bitmap->active_iterators);
         hbitmap_truncate(bitmap->bitmap, bytes);
@@ -402,7 +396,7 @@ void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
 
 /**
  * Release all named dirty bitmaps attached to a BDS (for use in bdrv_close()).
- * There must not be any user_locked bitmaps attached.
+ * There must not be any busy bitmaps attached.
  * This function does not remove persistent bitmaps from the storage.
  * Called with BQL taken.
  */
@@ -466,7 +460,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
         info->name = g_strdup(bm->name);
         info->status = bdrv_dirty_bitmap_status(bm);
         info->recording = bdrv_dirty_bitmap_recording(bm);
-        info->busy = bdrv_dirty_bitmap_user_locked(bm);
+        info->busy = bdrv_dirty_bitmap_busy(bm);
         info->persistent = bm->persistent;
         entry->value = info;
         *plist = entry;
@@ -774,7 +768,7 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
 
     qemu_mutex_lock(dest->mutex);
 
-    if (bdrv_dirty_bitmap_user_locked(dest)) {
+    if (bdrv_dirty_bitmap_busy(dest)) {
         error_setg(errp, "Bitmap '%s' is currently in use by another"
         " operation and cannot be modified", dest->name);
         goto out;
diff --git a/blockdev.c b/blockdev.c
index 7e6bf9955c..b4d790131e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2009,7 +2009,7 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
         return;
     }
 
-    if (bdrv_dirty_bitmap_user_locked(state->bitmap)) {
+    if (bdrv_dirty_bitmap_busy(state->bitmap)) {
         error_setg(errp, "Cannot modify a bitmap in use by another operation");
         return;
     } else if (bdrv_dirty_bitmap_readonly(state->bitmap)) {
@@ -2058,7 +2058,7 @@ static void block_dirty_bitmap_enable_prepare(BlkActionState *common,
         return;
     }
 
-    if (bdrv_dirty_bitmap_user_locked(state->bitmap)) {
+    if (bdrv_dirty_bitmap_busy(state->bitmap)) {
         error_setg(errp,
                    "Bitmap '%s' is currently in use by another operation"
                    " and cannot be enabled", action->name);
@@ -2099,7 +2099,7 @@ static void block_dirty_bitmap_disable_prepare(BlkActionState *common,
         return;
     }
 
-    if (bdrv_dirty_bitmap_user_locked(state->bitmap)) {
+    if (bdrv_dirty_bitmap_busy(state->bitmap)) {
         error_setg(errp,
                    "Bitmap '%s' is currently in use by another operation"
                    " and cannot be disabled", action->name);
@@ -2893,7 +2893,7 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
         return;
     }
 
-    if (bdrv_dirty_bitmap_user_locked(bitmap)) {
+    if (bdrv_dirty_bitmap_busy(bitmap)) {
         error_setg(errp,
                    "Bitmap '%s' is currently in use by another operation and"
                    " cannot be removed", name);
@@ -2932,7 +2932,7 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
         return;
     }
 
-    if (bdrv_dirty_bitmap_user_locked(bitmap)) {
+    if (bdrv_dirty_bitmap_busy(bitmap)) {
         error_setg(errp,
                    "Bitmap '%s' is currently in use by another operation"
                    " and cannot be cleared", name);
@@ -2956,7 +2956,7 @@ void qmp_block_dirty_bitmap_enable(const char *node, const char *name,
         return;
     }
 
-    if (bdrv_dirty_bitmap_user_locked(bitmap)) {
+    if (bdrv_dirty_bitmap_busy(bitmap)) {
         error_setg(errp,
                    "Bitmap '%s' is currently in use by another operation"
                    " and cannot be enabled", name);
@@ -2977,7 +2977,7 @@ void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
         return;
     }
 
-    if (bdrv_dirty_bitmap_user_locked(bitmap)) {
+    if (bdrv_dirty_bitmap_busy(bitmap)) {
         error_setg(errp,
                    "Bitmap '%s' is currently in use by another operation"
                    " and cannot be disabled", name);
@@ -3559,7 +3559,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
             bdrv_unref(target_bs);
             goto out;
         }
-        if (bdrv_dirty_bitmap_user_locked(bmap)) {
+        if (bdrv_dirty_bitmap_busy(bmap)) {
             error_setg(errp,
                        "Bitmap '%s' is currently in use by another operation"
                        " and cannot be used for backup", backup->bitmap);
@@ -3672,7 +3672,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
             error_setg(errp, "Bitmap '%s' could not be found", backup->bitmap);
             goto out;
         }
-        if (bdrv_dirty_bitmap_user_locked(bmap)) {
+        if (bdrv_dirty_bitmap_busy(bmap)) {
             error_setg(errp,
                        "Bitmap '%s' is currently in use by another operation"
                        " and cannot be used for backup", backup->bitmap);
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index ac6954142f..7057fff242 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -261,7 +261,7 @@ static void dirty_bitmap_mig_cleanup(void)
 
     while ((dbms = QSIMPLEQ_FIRST(&dirty_bitmap_mig_state.dbms_list)) != NULL) {
         QSIMPLEQ_REMOVE_HEAD(&dirty_bitmap_mig_state.dbms_list, entry);
-        bdrv_dirty_bitmap_set_qmp_locked(dbms->bitmap, false);
+        bdrv_dirty_bitmap_set_busy(dbms->bitmap, false);
         bdrv_unref(dbms->bs);
         g_free(dbms);
     }
@@ -301,7 +301,7 @@ static int init_dirty_bitmap_migration(void)
                 goto fail;
             }
 
-            if (bdrv_dirty_bitmap_user_locked(bitmap)) {
+            if (bdrv_dirty_bitmap_busy(bitmap)) {
                 error_report("Can't migrate a bitmap that is in use by another operation: '%s'",
                              bdrv_dirty_bitmap_name(bitmap));
                 goto fail;
@@ -314,7 +314,7 @@ static int init_dirty_bitmap_migration(void)
             }
 
             bdrv_ref(bs);
-            bdrv_dirty_bitmap_set_qmp_locked(bitmap, true);
+            bdrv_dirty_bitmap_set_busy(bitmap, true);
 
             dbms = g_new0(DirtyBitmapMigBitmapState, 1);
             dbms->bs = bs;
diff --git a/nbd/server.c b/nbd/server.c
index de21c64ce3..02773e2836 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1510,7 +1510,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
             goto fail;
         }
 
-        if (bdrv_dirty_bitmap_user_locked(bm)) {
+        if (bdrv_dirty_bitmap_busy(bm)) {
             error_setg(errp, "Bitmap '%s' is in use", bitmap);
             goto fail;
         }
@@ -1523,7 +1523,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
             goto fail;
         }
 
-        bdrv_dirty_bitmap_set_qmp_locked(bm, true);
+        bdrv_dirty_bitmap_set_busy(bm, true);
         exp->export_bitmap = bm;
         exp->export_bitmap_context = g_strdup_printf("qemu:dirty-bitmap:%s",
                                                      bitmap);
@@ -1641,7 +1641,7 @@ void nbd_export_put(NBDExport *exp)
         }
 
         if (exp->export_bitmap) {
-            bdrv_dirty_bitmap_set_qmp_locked(exp->export_bitmap, false);
+            bdrv_dirty_bitmap_set_busy(exp->export_bitmap, false);
             g_free(exp->export_bitmap_context);
         }
 
-- 
2.17.2
