Received: from eggs.gnu.org ([2001:4830:134:3::10]:48655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFcLP-0001HP-KS
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFcLM-0007OU-V4
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:17:35 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:32135 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFcLM-0007MW-Jp
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:17:32 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 11:17:07 +0300
Message-Id: <20170530081723.29205-10-vsementsov@virtuozzo.com>
In-Reply-To: <20170530081723.29205-1-vsementsov@virtuozzo.com>
References: <20170530081723.29205-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 09/25] block/dirty-bitmap: add readonly field
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

It will be needed in following commits for persistent bitmaps.
If bitmap is loaded from read-only storage (and we can't mark it
"in use" in this storage) corresponding BdrvDirtyBitmap should be
read-only.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c         | 28 ++++++++++++++++++++++++++++
 block/io.c                   |  8 ++++++++
 blockdev.c                   |  6 ++++++
 include/block/dirty-bitmap.h |  4 ++++
 4 files changed, 46 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 90af37287f..733f19ca5e 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -44,6 +44,8 @@ struct BdrvDirtyBitmap {
     int64_t size;               /* Size of the bitmap (Number of sectors) */
     bool disabled;              /* Bitmap is read-only */
     int active_iterators;       /* How many iterators are active */
+    bool readonly;              /* Bitmap is read-only and may be changed only
+                                   by deserialize* functions */
     QLIST_ENTRY(BdrvDirtyBitmap) list;
 };
 
@@ -436,6 +438,7 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                            int64_t cur_sector, int64_t nr_sectors)
 {
     assert(bdrv_dirty_bitmap_enabled(bitmap));
+    assert(!bdrv_dirty_bitmap_readonly(bitmap));
     hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
 }
 
@@ -443,12 +446,14 @@ void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                              int64_t cur_sector, int64_t nr_sectors)
 {
     assert(bdrv_dirty_bitmap_enabled(bitmap));
+    assert(!bdrv_dirty_bitmap_readonly(bitmap));
     hbitmap_reset(bitmap->bitmap, cur_sector, nr_sectors);
 }
 
 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
 {
     assert(bdrv_dirty_bitmap_enabled(bitmap));
+    assert(!bdrv_dirty_bitmap_readonly(bitmap));
     if (!out) {
         hbitmap_reset_all(bitmap->bitmap);
     } else {
@@ -519,6 +524,7 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
         if (!bdrv_dirty_bitmap_enabled(bitmap)) {
             continue;
         }
+        assert(!bdrv_dirty_bitmap_readonly(bitmap));
         hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
     }
 }
@@ -540,3 +546,25 @@ int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
 {
     return hbitmap_count(bitmap->meta);
 }
+
+bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap)
+{
+    return bitmap->readonly;
+}
+
+void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap)
+{
+    bitmap->readonly = true;
+}
+
+bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
+{
+    BdrvDirtyBitmap *bm;
+    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
+        if (bm->readonly) {
+            return true;
+        }
+    }
+
+    return false;
+}
diff --git a/block/io.c b/block/io.c
index fdd7485c22..0e28a1f595 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1349,6 +1349,10 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     uint64_t bytes_remaining = bytes;
     int max_transfer;
 
+    if (bdrv_has_readonly_bitmaps(bs)) {
+        return -EPERM;
+    }
+
     assert(is_power_of_2(align));
     assert((offset & (align - 1)) == 0);
     assert((bytes & (align - 1)) == 0);
@@ -2437,6 +2441,10 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
         return -ENOMEDIUM;
     }
 
+    if (bdrv_has_readonly_bitmaps(bs)) {
+        return -EPERM;
+    }
+
     ret = bdrv_check_byte_request(bs, offset, count);
     if (ret < 0) {
         return ret;
diff --git a/blockdev.c b/blockdev.c
index c63f4e82c7..2b397abf66 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2033,6 +2033,9 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
     } else if (!bdrv_dirty_bitmap_enabled(state->bitmap)) {
         error_setg(errp, "Cannot clear a disabled bitmap");
         return;
+    } else if (bdrv_dirty_bitmap_readonly(state->bitmap)) {
+        error_setg(errp, "Cannot clear a readonly bitmap");
+        return;
     }
 
     bdrv_clear_dirty_bitmap(state->bitmap, &state->backup);
@@ -2813,6 +2816,9 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
                    "Bitmap '%s' is currently disabled and cannot be cleared",
                    name);
         goto out;
+    } else if (bdrv_dirty_bitmap_readonly(bitmap)) {
+        error_setg(errp, "Bitmap '%s' is readonly and cannot be cleared", name);
+        goto out;
     }
 
     bdrv_clear_dirty_bitmap(bitmap, NULL);
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 1e17729ac2..c0c3ce9f85 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -75,4 +75,8 @@ void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
                                         bool finish);
 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 
+bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
+void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap);
+bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
+
 #endif
-- 
2.11.1
