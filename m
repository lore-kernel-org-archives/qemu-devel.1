Received: from eggs.gnu.org ([2001:4830:134:3::10]:57802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb7L9-0000W8-M8
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb7L3-00078V-VX
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:05:55 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Feb 2017 18:05:29 +0300
Message-Id: <1486479940-163258-7-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1486479940-163258-1-git-send-email-vsementsov@virtuozzo.com>
References: <1486479940-163258-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 06/17] block: add
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/dirty-bitmap.c         | 5 +++++
 include/block/dirty-bitmap.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 7547c78..ab2c7f5 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -217,6 +217,11 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
     return 0;
 }
 
+void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
+{
+    bdrv_enable_dirty_bitmap(bitmap->successor);
+}
+
 /**
  * For a bitmap with a successor, yield our name to the successor,
  * delete the old bitmap, and return a handle to the new bitmap.
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 1a457d5..57b476c 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -20,6 +20,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
                                            BdrvDirtyBitmap *bitmap,
                                            Error **errp);
+void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
                                         const char *name);
 void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap);
-- 
1.8.3.1
