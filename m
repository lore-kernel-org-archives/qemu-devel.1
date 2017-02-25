Received: from eggs.gnu.org ([2001:4830:134:3::10]:44053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chfpJ-0006ZD-Lb
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 12:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chfpF-0001T7-1V
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 12:08:09 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:20381 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1chfpE-0001RA-Mh
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 12:08:04 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 25 Feb 2017 20:07:56 +0300
Message-Id: <20170225170758.427066-21-vsementsov@virtuozzo.com>
In-Reply-To: <20170225170758.427066-1-vsementsov@virtuozzo.com>
References: <20170225170758.427066-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v16 20/22] block/dirty-bitmap: add
 bdrv_remove_persistent_dirty_bitmap
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

Interface for removing persistent bitmap from its storage.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 18 ++++++++++++++++++
 include/block/block_int.h    |  3 +++
 include/block/dirty-bitmap.h |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index b684d8b00e..05e0aaef90 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -327,12 +327,30 @@ void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
 /**
  * Release all named dirty bitmaps attached to a BDS (for use in bdrv_close()).
  * There must not be any frozen bitmaps attached.
+ * This function does not remove persistent bitmaps from the storage.
  */
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
 {
     bdrv_do_release_matching_dirty_bitmap(bs, NULL, true);
 }
 
+/**
+ * Remove persistent dirty bitmap from the storage if it exists.
+ * Absence of bitmap is not an error, because we have the following scenario:
+ * BdrvDirtyBitmap can have .persistent = true but not yet saved and have no
+ * stored version. For such bitmap bdrv_remove_persistent_dirty_bitmap() should
+ * not fail.
+ * This function doesn't release corresponding BdrvDirtyBitmap.
+ */
+void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
+                                         const char *name,
+                                         Error **errp)
+{
+    if (bs->drv && bs->drv->bdrv_remove_persistent_dirty_bitmap) {
+        bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
+    }
+}
+
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
     assert(!bdrv_dirty_bitmap_frozen(bitmap));
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f943a7c24e..f7f7dd7717 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -324,6 +324,9 @@ struct BlockDriver {
                                             const char *name,
                                             uint32_t granularity,
                                             Error **errp);
+    void (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
+                                                const char *name,
+                                                Error **errp);
 
     QLIST_ENTRY(BlockDriver) list;
 };
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index b022b34964..ce126109e0 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -25,6 +25,9 @@ BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
 void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap);
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap);
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
+void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
+                                         const char *name,
+                                         Error **errp);
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs);
-- 
2.11.1
