Received: from eggs.gnu.org ([2001:4830:134:3::10]:60539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBjB-0006SW-Rk
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj3-000336-6V
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:49 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:42162 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQBj2-0002wQ-Px
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Jun 2017 15:05:17 +0300
Message-Id: <20170628120530.31251-18-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-1-vsementsov@virtuozzo.com>
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v22 17/30] block: introduce persistent dirty
 bitmaps
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
by format driver in .bdrv_close and .bdrv_inactivate. No format driver
supports it for now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c         | 29 +++++++++++++++++++++++++++++
 block/qcow2-bitmap.c         |  1 +
 include/block/dirty-bitmap.h |  4 ++++
 3 files changed, 34 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 06dc7a3ac9..3c17c452ae 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -54,6 +54,7 @@ struct BdrvDirtyBitmap {
                                    this flag is set. */
     bool autoload;              /* For persistent bitmaps: bitmap must be
                                    autoloaded on image opening */
+    bool persistent;            /* bitmap must be saved to owner disk image */
     QLIST_ENTRY(BdrvDirtyBitmap) list;
 };
 
@@ -102,6 +103,7 @@ void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
     assert(!bdrv_dirty_bitmap_frozen(bitmap));
     g_free(bitmap->name);
     bitmap->name = NULL;
+    bitmap->persistent = false;
     bitmap->autoload = false;
 }
 
@@ -299,6 +301,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
     bitmap->name = NULL;
     successor->name = name;
     bitmap->successor = NULL;
+    successor->persistent = bitmap->persistent;
+    bitmap->persistent = false;
     successor->autoload = bitmap->autoload;
     bitmap->autoload = false;
     bdrv_release_dirty_bitmap(bs, bitmap);
@@ -689,3 +693,28 @@ bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap)
 {
     return bitmap->autoload;
 }
+
+/* Called with BQL taken. */
+void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap, bool persistent)
+{
+    qemu_mutex_lock(bitmap->mutex);
+    bitmap->persistent = persistent;
+    qemu_mutex_unlock(bitmap->mutex);
+}
+
+bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap)
+{
+    return bitmap->persistent;
+}
+
+bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
+{
+    BdrvDirtyBitmap *bm;
+    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
+        if (bm->persistent && !bm->readonly) {
+            return true;
+        }
+    }
+
+    return false;
+}
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index ee6d8f75a9..52e4616b8c 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -794,6 +794,7 @@ bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
                 goto fail;
             }
 
+            bdrv_dirty_bitmap_set_persistance(bitmap, true);
             bdrv_dirty_bitmap_set_autoload(bitmap, true);
             bm->flags |= BME_FLAG_IN_USE;
             created_dirty_bitmaps =
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index e2fea12b94..3995789218 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -73,6 +73,8 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 
 void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
 void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload);
+void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
+                                                bool persistent);
 
 /* Functions that require manual locking.  */
 void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
@@ -91,5 +93,7 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
+bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
+bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 
 #endif
-- 
2.11.1
