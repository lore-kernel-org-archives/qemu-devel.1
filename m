Received: from eggs.gnu.org ([2001:4830:134:3::10]:36524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evoGs-0000pc-CC
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evoGr-00087S-Fd
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:03:34 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 13 Mar 2018 21:03:08 +0300
Message-Id: <20180313180320.339796-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180313180320.339796-1-vsementsov@virtuozzo.com>
References: <20180313180320.339796-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v11 01/13] block/dirty-bitmap: add
 bdrv_dirty_bitmap_enable_successor()
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

Enabling bitmap successor is necessary to enable successors of bitmaps
being migrated before target vm start.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20180207155837.92351-2-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/block/dirty-bitmap.h | 1 +
 block/dirty-bitmap.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

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
-- 
2.11.1
