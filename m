Received: from eggs.gnu.org ([2001:4830:134:3::10]:34637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFx-0000lM-AE
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFv-0005lI-A3
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48290 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1evrFv-0005l1-4m
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:47 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 13 Mar 2018 17:14:32 -0400
Message-Id: <20180313211441.5179-5-jsnow@redhat.com>
In-Reply-To: <20180313211441.5179-1-jsnow@redhat.com>
References: <20180313211441.5179-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 04/13] dirty-bitmap: add locked state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add special state, when qmp operations on the bitmap are disabled.
It is needed during bitmap migration. "Frozen" state is not
appropriate here, because it looks like bitmap is unchanged.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20180207155837.92351-5-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 16 ++++++++++++++++
 blockdev.c                   | 19 +++++++++++++++++++
 include/block/dirty-bitmap.h |  3 +++
 qapi/block-core.json         |  5 ++++-
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index ce00ff3474..967159479d 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -40,6 +40,8 @@ struct BdrvDirtyBitmap {
     QemuMutex *mutex;
     HBitmap *bitmap;            /* Dirty bitmap implementation */
     HBitmap *meta;              /* Meta dirty bitmap */
+    bool qmp_locked;            /* Bitmap is locked, it can't be modified
+                                   through QMP */
     BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen status */
     char *name;                 /* Optional non-empty unique ID */
     int64_t size;               /* Size of the bitmap, in bytes */
@@ -183,6 +185,18 @@ bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap)
     return bitmap->successor;
 }
 
+void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked)
+{
+    qemu_mutex_lock(bitmap->mutex);
+    bitmap->qmp_locked = qmp_locked;
+    qemu_mutex_unlock(bitmap->mutex);
+}
+
+bool bdrv_dirty_bitmap_qmp_locked(BdrvDirtyBitmap *bitmap)
+{
+    return bitmap->qmp_locked;
+}
+
 /* Called with BQL taken.  */
 bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap)
 {
@@ -194,6 +208,8 @@ DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap)
 {
     if (bdrv_dirty_bitmap_frozen(bitmap)) {
         return DIRTY_BITMAP_STATUS_FROZEN;
+    } else if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
+        return DIRTY_BITMAP_STATUS_LOCKED;
     } else if (!bdrv_dirty_bitmap_enabled(bitmap)) {
         return DIRTY_BITMAP_STATUS_DISABLED;
     } else {
diff --git a/blockdev.c b/blockdev.c
index 1fbfd3a2c4..b9de18f3b2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2118,6 +2118,9 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
     if (bdrv_dirty_bitmap_frozen(state->bitmap)) {
         error_setg(errp, "Cannot modify a frozen bitmap");
         return;
+    } else if (bdrv_dirty_bitmap_qmp_locked(state->bitmap)) {
+        error_setg(errp, "Cannot modify a locked bitmap");
+        return;
     } else if (!bdrv_dirty_bitmap_enabled(state->bitmap)) {
         error_setg(errp, "Cannot clear a disabled bitmap");
         return;
@@ -2862,6 +2865,11 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
                    "Bitmap '%s' is currently frozen and cannot be removed",
                    name);
         return;
+    } else if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
+        error_setg(errp,
+                   "Bitmap '%s' is currently locked and cannot be removed",
+                   name);
+        return;
     }
 
     if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
@@ -2896,6 +2904,11 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
                    "Bitmap '%s' is currently frozen and cannot be modified",
                    name);
         return;
+    } else if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
+        error_setg(errp,
+                   "Bitmap '%s' is currently locked and cannot be modified",
+                   name);
+        return;
     } else if (!bdrv_dirty_bitmap_enabled(bitmap)) {
         error_setg(errp,
                    "Bitmap '%s' is currently disabled and cannot be cleared",
@@ -3370,6 +3383,12 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
             bdrv_unref(target_bs);
             goto out;
         }
+        if (bdrv_dirty_bitmap_qmp_locked(bmap)) {
+            error_setg(errp,
+                       "Bitmap '%s' is currently locked and cannot be used for "
+                       "backup", backup->bitmap);
+            goto out;
+        }
     }
 
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 5c239be74d..1ff8949b1b 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -69,6 +69,8 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
 void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
                                        bool persistent);
+void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked);
+
 
 /* Functions that require manual locking.  */
 void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
@@ -88,6 +90,7 @@ bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
+bool bdrv_dirty_bitmap_qmp_locked(BdrvDirtyBitmap *bitmap);
 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 524d51567a..2b378f510a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -426,10 +426,13 @@
 # @active: The bitmap is actively monitoring for new writes, and can be cleared,
 #          deleted, or used for backup operations.
 #
+# @locked: The bitmap is currently in-use by some operation and can not be
+#          cleared, deleted, or used for backup operations. (Since 2.12)
+#
 # Since: 2.4
 ##
 { 'enum': 'DirtyBitmapStatus',
-  'data': ['active', 'disabled', 'frozen'] }
+  'data': ['active', 'disabled', 'frozen', 'locked'] }
 
 ##
 # @BlockDirtyInfo:
-- 
2.14.3
