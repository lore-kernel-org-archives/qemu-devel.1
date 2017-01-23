Received: from eggs.gnu.org ([2001:4830:134:3::10]:36353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdST-0002HL-T1
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSN-0005CC-T5
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:49 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:34964 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVdSN-00058o-Bv
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:43 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 23 Jan 2017 15:10:23 +0300
Message-Id: <20170123121036.4823-12-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-1-vsementsov@virtuozzo.com>
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 11/24] block: introduce persistent dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

New field BdrvDirtyBitmap.persistent means, that bitmap should be saved
on bdrv_close, using format driver. Format driver should maintain bitmap
storing.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block.c                      | 32 ++++++++++++++++++++++++++++++++
 block/dirty-bitmap.c         | 26 ++++++++++++++++++++++++++
 block/qcow2-bitmap.c         |  1 +
 include/block/block.h        |  1 +
 include/block/block_int.h    |  2 ++
 include/block/dirty-bitmap.h |  6 ++++++
 6 files changed, 68 insertions(+)

diff --git a/block.c b/block.c
index 10951767f3..646ea50316 100644
--- a/block.c
+++ b/block.c
@@ -2321,6 +2321,7 @@ void bdrv_reopen_abort(BDRVReopenState *reopen_state)
 static void bdrv_close(BlockDriverState *bs)
 {
     BdrvAioNotifier *ban, *ban_next;
+    Error *local_err = NULL;
 
     assert(!bs->job);
     assert(!bs->refcnt);
@@ -2329,6 +2330,12 @@ static void bdrv_close(BlockDriverState *bs)
     bdrv_flush(bs);
     bdrv_drain(bs); /* in case flush left pending I/O */
 
+    bdrv_store_persistent_dirty_bitmaps(bs, &local_err);
+    if (local_err != NULL) {
+        error_report_err(local_err);
+        error_report("Persistent bitmaps are lost for node '%s'",
+                     bdrv_get_device_or_node_name(bs));
+    }
     bdrv_release_named_dirty_bitmaps(bs);
     assert(QLIST_EMPTY(&bs->dirty_bitmaps));
 
@@ -4107,3 +4114,28 @@ void bdrv_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         bs->drv->bdrv_load_autoloading_dirty_bitmaps(bs, errp);
     }
 }
+
+void bdrv_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+{
+    BlockDriver *drv = bs->drv;
+
+    if (!bdrv_has_persistent_bitmaps(bs)) {
+        return;
+    }
+
+    if (!drv) {
+        error_setg_errno(errp, ENOMEDIUM,
+                         "Can't store persistent bitmaps to %s",
+                         bdrv_get_device_or_node_name(bs));
+        return;
+    }
+
+    if (!drv->bdrv_store_persistent_dirty_bitmaps) {
+        error_setg_errno(errp, ENOTSUP,
+                         "Can't store persistent bitmaps to %s",
+                         bdrv_get_device_or_node_name(bs));
+        return;
+    }
+
+    drv->bdrv_store_persistent_dirty_bitmaps(bs, errp);
+}
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 2d27494dc7..4d026df1bd 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -44,6 +44,7 @@ struct BdrvDirtyBitmap {
     int64_t size;               /* Size of the bitmap (Number of sectors) */
     bool disabled;              /* Bitmap is read-only */
     int active_iterators;       /* How many iterators are active */
+    bool persistent;            /* bitmap must be saved to owner disk image */
     bool autoload;              /* For persistent bitmaps: bitmap must be
                                    autoloaded on image opening */
     QLIST_ENTRY(BdrvDirtyBitmap) list;
@@ -73,6 +74,7 @@ void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
     g_free(bitmap->name);
     bitmap->name = NULL;
 
+    bitmap->persistent = false;
     bitmap->autoload = false;
 }
 
@@ -242,6 +244,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
     bitmap->name = NULL;
     successor->name = name;
     bitmap->successor = NULL;
+    successor->persistent = bitmap->persistent;
+    bitmap->persistent = false;
     successor->autoload = bitmap->autoload;
     bitmap->autoload = false;
     bdrv_release_dirty_bitmap(bs, bitmap);
@@ -556,3 +560,25 @@ bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap)
 {
     return bitmap->autoload;
 }
+
+void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap, bool persistent)
+{
+    bitmap->persistent = persistent;
+}
+
+bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap)
+{
+    return bitmap->persistent;
+}
+
+bool bdrv_has_persistent_bitmaps(BlockDriverState *bs)
+{
+    BdrvDirtyBitmap *bm;
+    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
+        if (bm->persistent) {
+            return true;
+        }
+    }
+
+    return false;
+}
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 277e678e44..3e8fd030d9 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -686,6 +686,7 @@ void qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
                 goto fail;
             }
 
+            bdrv_dirty_bitmap_set_persistance(bitmap, true);
             bdrv_dirty_bitmap_set_autoload(bitmap, true);
             bm->flags |= BME_FLAG_IN_USE;
             created_dirty_bitmaps =
diff --git a/include/block/block.h b/include/block/block.h
index f701da2c5d..e3175b5e4c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -553,5 +553,6 @@ void bdrv_add_child(BlockDriverState *parent, BlockDriverState *child,
 void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
 
 void bdrv_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+void bdrv_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index ca955f08b9..e8d9210075 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -322,6 +322,8 @@ struct BlockDriver {
 
     void (*bdrv_load_autoloading_dirty_bitmaps)(BlockDriverState *bs,
                                                 Error **errp);
+    void (*bdrv_store_persistent_dirty_bitmaps)(BlockDriverState *bs,
+                                                Error **errp);
 
     QLIST_ENTRY(BlockDriver) list;
 };
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 45a389a20a..8dbd16b040 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -77,4 +77,10 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 
 void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
+void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
+                                                bool persistent);
+bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
+
+bool bdrv_has_persistent_bitmaps(BlockDriverState *bs);
+
 #endif
-- 
2.11.0
