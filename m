Received: from eggs.gnu.org ([2001:4830:134:3::10]:42331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duOzZ-0005KY-3T
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duOzT-0004fr-Q0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:37 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 19 Sep 2017 15:18:55 -0500
Message-Id: <20170919201910.25656-6-eblake@redhat.com>
In-Reply-To: <20170919201910.25656-1-eblake@redhat.com>
References: <20170919201910.25656-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v9 05/20] dirty-bitmap: Avoid size query
 failure during truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

We've previously fixed several places where we failed to account
for possible errors from bdrv_nb_sectors().  Fix another one by
making bdrv_dirty_bitmap_truncate() take the new size from the
caller instead of querying itself; then adjust the sole caller
bdrv_truncate() to pass the size just determined by a successful
resize, or to skip the bitmap resize on failure, thus avoiding
sizing the bitmaps to -1.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v9: skip only bdrv_dirty_bitmap_truncate on error [Fam]
v8: retitle and rework to avoid possibility of secondary failure [John]
v7: new patch [Kevin]
---
 include/block/dirty-bitmap.h |  2 +-
 block.c                      | 15 ++++++++++-----
 block/dirty-bitmap.c         |  6 +++---
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 8fd842eac9..7a27590047 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -83,7 +83,7 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
 void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t sector_num);
 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
 int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
-void bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
+void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes);
 bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
diff --git a/block.c b/block.c
index ee6a48976e..89261a7a53 100644
--- a/block.c
+++ b/block.c
@@ -3450,12 +3450,17 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
     assert(!(bs->open_flags & BDRV_O_INACTIVE));

     ret = drv->bdrv_truncate(bs, offset, prealloc, errp);
-    if (ret == 0) {
-        ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
-        bdrv_dirty_bitmap_truncate(bs);
-        bdrv_parent_cb_resize(bs);
-        atomic_inc(&bs->write_gen);
+    if (ret < 0) {
+        return ret;
     }
+    ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not refresh total sector count");
+    } else {
+        bdrv_dirty_bitmap_truncate(bs, bs->total_sectors * BDRV_SECTOR_SIZE);
+    }
+    bdrv_parent_cb_resize(bs);
+    atomic_inc(&bs->write_gen);
     return ret;
 }

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 42a55e4a4b..ee164fb518 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -1,7 +1,7 @@
 /*
  * Block Dirty Bitmap
  *
- * Copyright (c) 2016 Red Hat. Inc
+ * Copyright (c) 2016-2017 Red Hat. Inc
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -302,10 +302,10 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
  * Truncates _all_ bitmaps attached to a BDS.
  * Called with BQL taken.
  */
-void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
+void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes)
 {
     BdrvDirtyBitmap *bitmap;
-    uint64_t size = bdrv_nb_sectors(bs);
+    int64_t size = DIV_ROUND_UP(bytes, BDRV_SECTOR_SIZE);

     bdrv_dirty_bitmaps_lock(bs);
     QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
-- 
2.13.5
