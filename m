Received: from eggs.gnu.org ([2001:4830:134:3::10]:40644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d3L9l-00041D-NC
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d3L9i-0002HN-7v
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:30:49 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:10501 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1d3L9h-0002Dq-Sz
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:30:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 26 Apr 2017 14:30:26 +0300
Message-Id: <20170426113038.60044-13-vsementsov@virtuozzo.com>
In-Reply-To: <20170426113038.60044-1-vsementsov@virtuozzo.com>
References: <20170426113038.60044-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 12/24] block: introduce persistent dirty bitmaps
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
 block/dirty-bitmap.c         | 26 ++++++++++++++++++++++++++
 block/qcow2-bitmap.c         |  1 +
 include/block/dirty-bitmap.h |  6 ++++++
 3 files changed, 33 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index a9dfce8d00..d2fbf55964 100644
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
@@ -72,6 +73,7 @@ void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
     assert(!bdrv_dirty_bitmap_frozen(bitmap));
     g_free(bitmap->name);
     bitmap->name = NULL;
+    bitmap->persistent = false;
     bitmap->autoload = false;
 }
 
@@ -241,6 +243,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
     bitmap->name = NULL;
     successor->name = name;
     bitmap->successor = NULL;
+    successor->persistent = bitmap->persistent;
+    bitmap->persistent = false;
     successor->autoload = bitmap->autoload;
     bitmap->autoload = false;
     bdrv_release_dirty_bitmap(bs, bitmap);
@@ -555,3 +559,25 @@ bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap)
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
index 5718567b21..928a1b2e67 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -787,6 +787,7 @@ bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
                 goto fail;
             }
 
+            bdrv_dirty_bitmap_set_persistance(bitmap, true);
             bdrv_dirty_bitmap_set_autoload(bitmap, true);
             bm->flags |= BME_FLAG_IN_USE;
             created_dirty_bitmaps =
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
2.11.1
