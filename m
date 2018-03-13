Received: from eggs.gnu.org ([2001:4830:134:3::10]:34639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFx-0000lN-AF
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFt-0005k8-OP
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1evrFt-0005jy-KK
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:45 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 13 Mar 2018 17:14:29 -0400
Message-Id: <20180313211441.5179-2-jsnow@redhat.com>
In-Reply-To: <20180313211441.5179-1-jsnow@redhat.com>
References: <20180313211441.5179-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 01/13] block/dirty-bitmap: add
 bdrv_dirty_bitmap_enable_successor()
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

Enabling bitmap successor is necessary to enable successors of bitmaps
being migrated before target vm start.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20180207155837.92351-2-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 8 ++++++++
 include/block/dirty-bitmap.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 909f0517f8..0d0e807216 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -234,6 +234,14 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
     return 0;
 }
 
+/* Called with BQL taken. */
+void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
+{
+    qemu_mutex_lock(bitmap->mutex);
+    bdrv_enable_dirty_bitmap(bitmap->successor);
+    qemu_mutex_unlock(bitmap->mutex);
+}
+
 /**
  * For a bitmap with a successor, yield our name to the successor,
  * delete the old bitmap, and return a handle to the new bitmap.
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 09efec609f..e0ebc96b01 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -21,6 +21,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
                                            BdrvDirtyBitmap *bitmap,
                                            Error **errp);
+void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
                                         const char *name);
 void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap);
-- 
2.14.3
