Received: from eggs.gnu.org ([2001:4830:134:3::10]:57718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d5tLu-0000ap-17
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d5tLq-00005W-40
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:25:53 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:46886 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1d5tLp-0008Sv-Mn
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:25:49 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  3 May 2017 15:25:28 +0300
Message-Id: <20170503122539.282182-15-vsementsov@virtuozzo.com>
In-Reply-To: <20170503122539.282182-1-vsementsov@virtuozzo.com>
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 14/25] block/dirty-bitmap: add
 bdrv_dirty_bitmap_next()
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 7 +++++++
 include/block/dirty-bitmap.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index bac4fe3008..df0d3cd954 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -597,3 +597,10 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
 
     return false;
 }
+
+BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
+                                        BdrvDirtyBitmap *bitmap)
+{
+    return bitmap == NULL ? QLIST_FIRST(&bs->dirty_bitmaps) :
+                            QLIST_NEXT(bitmap, list);
+}
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index a48e4df246..741573be97 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -86,4 +86,7 @@ void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
 bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 
+BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
+                                        BdrvDirtyBitmap *bitmap);
+
 #endif
-- 
2.11.1
