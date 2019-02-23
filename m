Received: from eggs.gnu.org ([209.51.188.92]:34740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gxL5B-0000CG-3m
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gxL5A-0004Ps-11
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:22:21 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 22 Feb 2019 19:22:06 -0500
Message-Id: <20190223002209.23084-2-jsnow@redhat.com>
In-Reply-To: <20190223002209.23084-1-jsnow@redhat.com>
References: <20190223002209.23084-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/4] block/dirty-bitmaps: add inconsistent
 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>

Add an inconsistent bit to dirty-bitmaps that allows us to report a bitmap as
persistent but potentially inconsistent, i.e. if we find bitmaps on a qcow2
that have been marked as "in use".

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 19 +++++++++++++++++++
 include/block/dirty-bitmap.h |  2 ++
 qapi/block-core.json         |  8 ++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 86c3b87ab9..9042c04788 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -46,6 +46,9 @@ struct BdrvDirtyBitmap {
                                    and this bitmap must remain unchanged while
                                    this flag is set. */
     bool persistent;            /* bitmap must be saved to owner disk image */
+    bool inconsistent;          /* bitmap is persistent, but not owned by QEMU.
+                                 * It cannot be used at all in any way, except
+                                 * a QMP user can remove it. */
     bool migration;             /* Bitmap is selected for migration, it should
                                    not be stored on the next inactivation
                                    (persistent flag doesn't matter until next
@@ -462,6 +465,8 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
         info->recording = bdrv_dirty_bitmap_recording(bm);
         info->busy = bdrv_dirty_bitmap_busy(bm);
         info->persistent = bm->persistent;
+        info->has_inconsistent = bm->inconsistent;
+        info->inconsistent = bm->inconsistent;
         entry->value = info;
         *plist = entry;
         plist = &entry->next;
@@ -709,6 +714,15 @@ void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap, bool persistent)
     qemu_mutex_unlock(bitmap->mutex);
 }
 
+/* Called with BQL taken. */
+void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap *bitmap)
+{
+    qemu_mutex_lock(bitmap->mutex);
+    bitmap->inconsistent = true;
+    bitmap->disabled = true;
+    qemu_mutex_unlock(bitmap->mutex);
+}
+
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, bool migration)
 {
@@ -722,6 +736,11 @@ bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap)
     return bitmap->persistent && !bitmap->migration;
 }
 
+bool bdrv_dirty_bitmap_inconsistent(BdrvDirtyBitmap *bitmap)
+{
+    return bitmap->inconsistent;
+}
+
 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
 {
     BdrvDirtyBitmap *bm;
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index ba8477b73f..b270773f7e 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -68,6 +68,7 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
 void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
                                        bool persistent);
+void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_set_busy(BdrvDirtyBitmap *bitmap, bool busy);
 void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
                              HBitmap **backup, Error **errp);
@@ -91,6 +92,7 @@ bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
+bool bdrv_dirty_bitmap_inconsistent(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_busy(BdrvDirtyBitmap *bitmap);
 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6e543594b3..a7209fce22 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -470,12 +470,16 @@
 # @persistent: true if the bitmap will eventually be flushed to persistent
 #              storage (since 4.0)
 #
+# @inconsistent: true if this is a persistent bitmap that QEMU does not own.
+#                Implies @recording and @busy to be false. To reclaim
+#                ownership, use @block-dirty-bitmap-remove. (since 4.0)
+#
 # Since: 1.3
 ##
 { 'struct': 'BlockDirtyInfo',
   'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
-           'recording': 'bool', 'busy': 'bool',
-           'status': 'DirtyBitmapStatus', 'persistent': 'bool' } }
+           'recording': 'bool', 'busy': 'bool', 'status': 'DirtyBitmapStatus',
+           'persistent': 'bool', '*inconsistent': 'bool' } }
 
 ##
 # @Qcow2BitmapInfoFlags:
-- 
2.17.2
