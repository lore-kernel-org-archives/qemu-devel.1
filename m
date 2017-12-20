Received: from eggs.gnu.org ([208.118.235.92]:35042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRgd5-0003um-P9
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRgd1-0005eC-Hj
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:49:59 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 20 Dec 2017 18:49:36 +0300
Message-Id: <20171220154945.88410-5-vsementsov@virtuozzo.com>
In-Reply-To: <20171220154945.88410-1-vsementsov@virtuozzo.com>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v9 04/13] dirty-bitmap: add locked state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

Add special state, when qmp operations on the bitmap are disabled.
It is needed during bitmap migration. "Frozen" state is not
appropriate here, because it looks like bitmap is unchanged.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json         |  5 ++++-
 include/block/dirty-bitmap.h |  3 +++
 block/dirty-bitmap.c         | 16 ++++++++++++++++
 blockdev.c                   | 19 +++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index dd763dcf87..48c30da6cb 100644
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
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index caf1f3d861..517b04176f 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -69,6 +69,8 @@ void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
 void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload);
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
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index fe27ddfb83..6218740c95 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -40,6 +40,8 @@ struct BdrvDirtyBitmap {
     QemuMutex *mutex;
     HBitmap *bitmap;            /* Dirty bitmap implementation */
     HBitmap *meta;              /* Meta dirty bitmap */
+    bool qmp_locked;                /* Bitmap is frozen, it can't be modified
+                                   through QMP */
     BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen status */
     char *name;                 /* Optional non-empty unique ID */
     int64_t size;               /* Size of the bitmap, in bytes */
@@ -186,6 +188,18 @@ bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap)
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
@@ -197,6 +211,8 @@ DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap)
 {
     if (bdrv_dirty_bitmap_frozen(bitmap)) {
         return DIRTY_BITMAP_STATUS_FROZEN;
+    } else if (!bdrv_dirty_bitmap_qmp_locked(bitmap)) {
+        return DIRTY_BITMAP_STATUS_LOCKED;
     } else if (!bdrv_dirty_bitmap_enabled(bitmap)) {
         return DIRTY_BITMAP_STATUS_DISABLED;
     } else {
diff --git a/blockdev.c b/blockdev.c
index 56a6b24a0b..82b2956c5c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2029,6 +2029,9 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
     if (bdrv_dirty_bitmap_frozen(state->bitmap)) {
         error_setg(errp, "Cannot modify a frozen bitmap");
         return;
+    } else if (bdrv_dirty_bitmap_qmp_locked(state->bitmap)) {
+        error_setg(errp, "Cannot modify a locked bitmap");
+        return;
     } else if (!bdrv_dirty_bitmap_enabled(state->bitmap)) {
         error_setg(errp, "Cannot clear a disabled bitmap");
         return;
@@ -2780,6 +2783,11 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
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
@@ -2814,6 +2822,11 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
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
@@ -3288,6 +3301,12 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
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
-- 
2.11.1
