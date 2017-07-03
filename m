Received: from eggs.gnu.org ([2001:4830:134:3::10]:55175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS30M-00072l-VV
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS30L-00089b-K1
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:11:14 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 10:10:40 -0500
Message-Id: <20170703151051.31327-7-eblake@redhat.com>
In-Reply-To: <20170703151051.31327-1-eblake@redhat.com>
References: <20170703151051.31327-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 06/17] dirty-bitmap: Change
 bdrv_dirty_bitmap_*serialize*() to take bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Right now, the dirty-bitmap code exposes the fact that we use
a scale of sector granularity in the underlying hbitmap to anything
that wants to serialize a dirty bitmap.  It's nicer to uniformly
expose bytes as our dirty-bitmap interface, matching the previous
change to bitmap size.  The only caller to serialization is currently
qcow2-cluster.c, which becomes a bit more verbose because it is still
tracking sectors for other reasons, but a later patch will fix that
to more uniformly use byte offsets everywhere.  Likewise, within
dirty-bitmap, we have to add more assertions that we are not
truncating incorrectly, which can go away once the internal hbitmap
is byte-based rather than sector-based.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: new patch
---
 include/block/dirty-bitmap.h | 14 +++++++-------
 block/dirty-bitmap.c         | 37 ++++++++++++++++++++++++-------------
 block/qcow2-bitmap.c         | 22 ++++++++++++++--------
 3 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 8fd842e..f4ccd3f 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -49,19 +49,19 @@ BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap,
 void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter);

 uint64_t bdrv_dirty_bitmap_serialization_size(const BdrvDirtyBitmap *bitmap,
-                                              uint64_t start, uint64_t count);
+                                              uint64_t offset, uint64_t bytes);
 uint64_t bdrv_dirty_bitmap_serialization_align(const BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_serialize_part(const BdrvDirtyBitmap *bitmap,
-                                      uint8_t *buf, uint64_t start,
-                                      uint64_t count);
+                                      uint8_t *buf, uint64_t offset,
+                                      uint64_t bytes);
 void bdrv_dirty_bitmap_deserialize_part(BdrvDirtyBitmap *bitmap,
-                                        uint8_t *buf, uint64_t start,
-                                        uint64_t count, bool finish);
+                                        uint8_t *buf, uint64_t offset,
+                                        uint64_t bytes, bool finish);
 void bdrv_dirty_bitmap_deserialize_zeroes(BdrvDirtyBitmap *bitmap,
-                                          uint64_t start, uint64_t count,
+                                          uint64_t offset, uint64_t bytes,
                                           bool finish);
 void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
-                                        uint64_t start, uint64_t count,
+                                        uint64_t offset, uint64_t bytes,
                                         bool finish);
 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 3d8cfe6..dc5c205 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -571,42 +571,53 @@ void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in)
 }

 uint64_t bdrv_dirty_bitmap_serialization_size(const BdrvDirtyBitmap *bitmap,
-                                              uint64_t start, uint64_t count)
+                                              uint64_t offset, uint64_t bytes)
 {
-    return hbitmap_serialization_size(bitmap->bitmap, start, count);
+    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
+    return hbitmap_serialization_size(bitmap->bitmap,
+                                      offset >> BDRV_SECTOR_BITS,
+                                      bytes >> BDRV_SECTOR_BITS);
 }

 uint64_t bdrv_dirty_bitmap_serialization_align(const BdrvDirtyBitmap *bitmap)
 {
-    return hbitmap_serialization_align(bitmap->bitmap);
+    return hbitmap_serialization_align(bitmap->bitmap) * BDRV_SECTOR_SIZE;
 }

 void bdrv_dirty_bitmap_serialize_part(const BdrvDirtyBitmap *bitmap,
-                                      uint8_t *buf, uint64_t start,
-                                      uint64_t count)
+                                      uint8_t *buf, uint64_t offset,
+                                      uint64_t bytes)
 {
-    hbitmap_serialize_part(bitmap->bitmap, buf, start, count);
+    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
+    hbitmap_serialize_part(bitmap->bitmap, buf, offset >> BDRV_SECTOR_BITS,
+                           bytes >> BDRV_SECTOR_BITS);
 }

 void bdrv_dirty_bitmap_deserialize_part(BdrvDirtyBitmap *bitmap,
-                                        uint8_t *buf, uint64_t start,
-                                        uint64_t count, bool finish)
+                                        uint8_t *buf, uint64_t offset,
+                                        uint64_t bytes, bool finish)
 {
-    hbitmap_deserialize_part(bitmap->bitmap, buf, start, count, finish);
+    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
+    hbitmap_deserialize_part(bitmap->bitmap, buf, offset >> BDRV_SECTOR_BITS,
+                             bytes >> BDRV_SECTOR_BITS, finish);
 }

 void bdrv_dirty_bitmap_deserialize_zeroes(BdrvDirtyBitmap *bitmap,
-                                          uint64_t start, uint64_t count,
+                                          uint64_t offset, uint64_t bytes,
                                           bool finish)
 {
-    hbitmap_deserialize_zeroes(bitmap->bitmap, start, count, finish);
+    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
+    hbitmap_deserialize_zeroes(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
+                               bytes >> BDRV_SECTOR_BITS, finish);
 }

 void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
-                                        uint64_t start, uint64_t count,
+                                        uint64_t offset, uint64_t bytes,
                                         bool finish)
 {
-    hbitmap_deserialize_ones(bitmap->bitmap, start, count, finish);
+    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
+    hbitmap_deserialize_ones(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
+                             bytes >> BDRV_SECTOR_BITS, finish);
 }

 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap)
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index f6f7770..8fd2598 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -278,7 +278,7 @@ static uint64_t sectors_covered_by_bitmap_cluster(const BDRVQcow2State *s,
             bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
     uint64_t sbc = sector_granularity * (s->cluster_size << 3);

-    assert(QEMU_IS_ALIGNED(sbc,
+    assert(QEMU_IS_ALIGNED(sbc << BDRV_SECTOR_BITS,
                            bdrv_dirty_bitmap_serialization_align(bitmap)));
     return sbc;
 }
@@ -299,7 +299,7 @@ static int load_bitmap_data(BlockDriverState *bs,
     uint8_t *buf = NULL;
     uint64_t i, tab_size =
             size_to_clusters(s,
-                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_sectors));
+                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size));

     if (tab_size != bitmap_table_size || tab_size > BME_MAX_TABLE_SIZE) {
         return -EINVAL;
@@ -316,7 +316,9 @@ static int load_bitmap_data(BlockDriverState *bs,

         if (offset == 0) {
             if (entry & BME_TABLE_ENTRY_FLAG_ALL_ONES) {
-                bdrv_dirty_bitmap_deserialize_ones(bitmap, sector, count,
+                bdrv_dirty_bitmap_deserialize_ones(bitmap,
+                                                   sector * BDRV_SECTOR_SIZE,
+                                                   count * BDRV_SECTOR_SIZE,
                                                    false);
             } else {
                 /* No need to deserialize zeros because the dirty bitmap is
@@ -327,7 +329,9 @@ static int load_bitmap_data(BlockDriverState *bs,
             if (ret < 0) {
                 goto finish;
             }
-            bdrv_dirty_bitmap_deserialize_part(bitmap, buf, sector, count,
+            bdrv_dirty_bitmap_deserialize_part(bitmap, buf,
+                                               sector * BDRV_SECTOR_SIZE,
+                                               count * BDRV_SECTOR_SIZE,
                                                false);
         }
     }
@@ -1081,7 +1085,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
     uint64_t *tb;
     uint64_t tb_size =
             size_to_clusters(s,
-                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_sectors));
+                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size));

     if (tb_size > BME_MAX_TABLE_SIZE ||
         tb_size * s->cluster_size > BME_MAX_PHYS_SIZE)
@@ -1108,8 +1112,8 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,

         sector = cluster * sbc;
         end = MIN(bm_sectors, sector + sbc);
-        write_size =
-            bdrv_dirty_bitmap_serialization_size(bitmap, sector, end - sector);
+        write_size = bdrv_dirty_bitmap_serialization_size(bitmap,
+            sector * BDRV_SECTOR_SIZE, (end - sector) * BDRV_SECTOR_SIZE);
         assert(write_size <= s->cluster_size);

         off = qcow2_alloc_clusters(bs, s->cluster_size);
@@ -1121,7 +1125,9 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
         }
         tb[cluster] = off;

-        bdrv_dirty_bitmap_serialize_part(bitmap, buf, sector, end - sector);
+        bdrv_dirty_bitmap_serialize_part(bitmap, buf,
+                                         sector * BDRV_SECTOR_SIZE,
+                                         (end - sector) * BDRV_SECTOR_SIZE);
         if (write_size < s->cluster_size) {
             memset(buf + write_size, 0, s->cluster_size - write_size);
         }
-- 
2.9.4
