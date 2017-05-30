Received: from eggs.gnu.org ([2001:4830:134:3::10]:48792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFcLT-0001JN-0F
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFcLO-0007Pv-6L
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:17:39 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:1050 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFcLN-0007N4-R5
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:17:34 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 11:17:09 +0300
Message-Id: <20170530081723.29205-12-vsementsov@virtuozzo.com>
In-Reply-To: <20170530081723.29205-1-vsementsov@virtuozzo.com>
References: <20170530081723.29205-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 11/25] block/dirty-bitmap: add autoload field
 to BdrvDirtyBitmap
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

Mirror AUTO flag from Qcow2 bitmap in BdrvDirtyBitmap. This will be
needed in future, to save this flag back to Qcow2 for persistent
bitmaps.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 15 +++++++++++++++
 block/qcow2-bitmap.c         |  2 ++
 include/block/dirty-bitmap.h |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 733f19ca5e..7da9f72725 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -46,6 +46,8 @@ struct BdrvDirtyBitmap {
     int active_iterators;       /* How many iterators are active */
     bool readonly;              /* Bitmap is read-only and may be changed only
                                    by deserialize* functions */
+    bool autoload;              /* For persistent bitmaps: bitmap must be
+                                   autoloaded on image opening */
     QLIST_ENTRY(BdrvDirtyBitmap) list;
 };
 
@@ -72,6 +74,7 @@ void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
     assert(!bdrv_dirty_bitmap_frozen(bitmap));
     g_free(bitmap->name);
     bitmap->name = NULL;
+    bitmap->autoload = false;
 }
 
 BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
@@ -240,6 +243,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
     bitmap->name = NULL;
     successor->name = name;
     bitmap->successor = NULL;
+    successor->autoload = bitmap->autoload;
+    bitmap->autoload = false;
     bdrv_release_dirty_bitmap(bs, bitmap);
 
     return successor;
@@ -568,3 +573,13 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
 
     return false;
 }
+
+void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload)
+{
+    bitmap->autoload = autoload;
+}
+
+bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap)
+{
+    return bitmap->autoload;
+}
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index cb596c2a85..9d2ea15e56 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -793,6 +793,8 @@ bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
             if (bitmap == NULL) {
                 goto fail;
             }
+
+            bdrv_dirty_bitmap_set_autoload(bitmap, true);
             bm->flags |= BME_FLAG_IN_USE;
             created_dirty_bitmaps =
                     g_slist_append(created_dirty_bitmaps, bitmap);
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index c0c3ce9f85..0ad12e952e 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -79,4 +79,7 @@ bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
 
+void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload);
+bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
+
 #endif
-- 
2.11.1
