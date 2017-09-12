Received: from eggs.gnu.org ([2001:4830:134:3::10]:39359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drrqP-0001eM-VJ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drrqO-0005b4-Pj
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:31:41 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 12 Sep 2017 15:31:04 -0500
Message-Id: <20170912203119.24166-6-eblake@redhat.com>
In-Reply-To: <20170912203119.24166-1-eblake@redhat.com>
References: <20170912203119.24166-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 05/20] dirty-bitmap: Check for size query
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
Cc: kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

We've previously fixed several places where we failed to account
for possible errors from bdrv_nb_sectors().  Fix another one by
making bdrv_dirty_bitmap_truncate() report the error rather then
silently resizing bitmaps to -1.  Then adjust the sole caller
bdrv_truncate() to both reduce the likelihood of failure (blindly
calling bdrv_dirty_bitmap_truncate() after refresh_total_sectors()
fails was not nice) as well as propagate any actual failures.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v7: new patch [Kevin]
---
 include/block/dirty-bitmap.h |  2 +-
 block.c                      | 19 ++++++++++++++-----
 block/dirty-bitmap.c         | 12 ++++++++----
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 8fd842eac9..15101b59d5 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -83,7 +83,7 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
 void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t sector_num);
 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
 int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
-void bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
+int bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
diff --git a/block.c b/block.c
index ee6a48976e..790dcce360 100644
--- a/block.c
+++ b/block.c
@@ -3450,12 +3450,21 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
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
+        return ret;
+    }
+    ret = bdrv_dirty_bitmap_truncate(bs);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not refresh total sector count");
+        return ret;
+    }
+    bdrv_parent_cb_resize(bs);
+    atomic_inc(&bs->write_gen);
     return ret;
 }

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 42a55e4a4b..52f7a399b2 100644
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
@@ -300,13 +300,16 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,

 /**
  * Truncates _all_ bitmaps attached to a BDS.
- * Called with BQL taken.
+ * Called with BQL taken, returns -errno on failure.
  */
-void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
+int bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
 {
     BdrvDirtyBitmap *bitmap;
-    uint64_t size = bdrv_nb_sectors(bs);
+    int64_t size = bdrv_nb_sectors(bs);

+    if (size < 0) {
+        return size;
+    }
     bdrv_dirty_bitmaps_lock(bs);
     QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
         assert(!bdrv_dirty_bitmap_frozen(bitmap));
@@ -315,6 +318,7 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
         bitmap->size = size;
     }
     bdrv_dirty_bitmaps_unlock(bs);
+    return 0;
 }

 static bool bdrv_dirty_bitmap_has_name(BdrvDirtyBitmap *bitmap)
-- 
2.13.5
