Received: from eggs.gnu.org ([2001:4830:134:3::10]:58791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cJiIW-0003nW-Au
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cJiIR-0006kX-Cr
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:55:16 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:15580 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cJiIR-0006ds-0u
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:55:11 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 21 Dec 2016 17:55:00 +0300
Message-Id: <1482332102-131788-23-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482332102-131788-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482332102-131788-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 22/24] block/dirty-bitmap: deep release dirty
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

Remove persistent bitmap from its storage on bdrv_release_dirty_bitmap.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c      | 21 ++++++++++++++++++---
 include/block/block_int.h |  3 +++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 775181c..0977df6 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -297,7 +297,8 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
 
 static void bdrv_do_release_matching_dirty_bitmap(BlockDriverState *bs,
                                                   BdrvDirtyBitmap *bitmap,
-                                                  bool only_named)
+                                                  bool only_named,
+                                                  bool deep)
 {
     BdrvDirtyBitmap *bm, *next;
     QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
@@ -305,6 +306,19 @@ static void bdrv_do_release_matching_dirty_bitmap(BlockDriverState *bs,
             assert(!bm->active_iterators);
             assert(!bdrv_dirty_bitmap_frozen(bm));
             assert(!bm->meta);
+
+            if (deep && bm->persistent && bs->drv &&
+                bs->drv->bdrv_remove_persistent_dirty_bitmap)
+            {
+                Error *local_err = NULL;
+                bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, bm->name,
+                                                             &local_err);
+                if (local_err != NULL) {
+                    error_report_err(local_err);
+                }
+            }
+
+
             QLIST_REMOVE(bm, list);
             hbitmap_free(bm->bitmap);
             g_free(bm->name);
@@ -322,16 +336,17 @@ static void bdrv_do_release_matching_dirty_bitmap(BlockDriverState *bs,
 
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
 {
-    bdrv_do_release_matching_dirty_bitmap(bs, bitmap, false);
+    bdrv_do_release_matching_dirty_bitmap(bs, bitmap, false, true);
 }
 
 /**
  * Release all named dirty bitmaps attached to a BDS (for use in bdrv_close()).
  * There must not be any frozen bitmaps attached.
+ * This function do not remove persistent bitmaps from the storage.
  */
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
 {
-    bdrv_do_release_matching_dirty_bitmap(bs, NULL, true);
+    bdrv_do_release_matching_dirty_bitmap(bs, NULL, true, false);
 }
 
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
diff --git a/include/block/block_int.h b/include/block/block_int.h
index b38b3aa..3e080d6 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -326,6 +326,9 @@ struct BlockDriver {
                                                 Error **errp);
     bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs, const char *name,
                                             uint32_t granularity, Error **errp);
+    void (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
+                                                const char *name,
+                                                Error **errp);
 
     QLIST_ENTRY(BlockDriver) list;
 };
-- 
1.8.3.1
