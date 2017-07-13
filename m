Received: from eggs.gnu.org ([2001:4830:134:3::10]:37355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSaX-0005Lq-Eq
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSaW-0001wj-7w
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:06:41 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 12 Jul 2017 20:05:53 -0500
Message-Id: <20170713010555.6769-17-eblake@redhat.com>
In-Reply-To: <20170713010555.6769-1-eblake@redhat.com>
References: <20170713010555.6769-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 16/18] qcow2: Switch store_bitmap_data() to
 byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

Now that we have adjusted the majority of the calls this function
makes to be byte-based, it is easier to read the code if it makes
passes over the image using bytes rather than sectors.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v5: no change
v4: new patch
---
 block/qcow2-bitmap.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index c44cf78..d1537a8 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1068,10 +1068,9 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
-    int64_t sector;
-    uint64_t limit, sbc;
+    int64_t offset;
+    uint64_t limit;
     uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
-    uint64_t bm_sectors = DIV_ROUND_UP(bm_size, BDRV_SECTOR_SIZE);
     const char *bm_name = bdrv_dirty_bitmap_name(bitmap);
     uint8_t *buf = NULL;
     BdrvDirtyBitmapIter *dbi;
@@ -1096,18 +1095,17 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
     dbi = bdrv_dirty_iter_new(bitmap);
     buf = g_malloc(s->cluster_size);
     limit = bytes_covered_by_bitmap_cluster(s, bitmap);
-    sbc = limit >> BDRV_SECTOR_BITS;
     assert(DIV_ROUND_UP(bm_size, limit) == tb_size);

-    while ((sector = bdrv_dirty_iter_next(dbi) >> BDRV_SECTOR_BITS) != -1) {
-        uint64_t cluster = sector / sbc;
+    while ((offset = bdrv_dirty_iter_next(dbi)) != -1) {
+        uint64_t cluster = offset / limit;
         uint64_t end, write_size;
         int64_t off;

-        sector = cluster * sbc;
-        end = MIN(bm_sectors, sector + sbc);
-        write_size = bdrv_dirty_bitmap_serialization_size(bitmap,
-            sector * BDRV_SECTOR_SIZE, (end - sector) * BDRV_SECTOR_SIZE);
+        offset = cluster * limit;
+        end = MIN(bm_size, offset + limit);
+        write_size = bdrv_dirty_bitmap_serialization_size(bitmap, offset,
+                                                          end - offset);
         assert(write_size <= s->cluster_size);

         off = qcow2_alloc_clusters(bs, s->cluster_size);
@@ -1119,9 +1117,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
         }
         tb[cluster] = off;

-        bdrv_dirty_bitmap_serialize_part(bitmap, buf,
-                                         sector * BDRV_SECTOR_SIZE,
-                                         (end - sector) * BDRV_SECTOR_SIZE);
+        bdrv_dirty_bitmap_serialize_part(bitmap, buf, offset, end - offset);
         if (write_size < s->cluster_size) {
             memset(buf + write_size, 0, s->cluster_size - write_size);
         }
@@ -1139,11 +1135,11 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
             goto fail;
         }

-        if (end >= bm_sectors) {
+        if (end >= bm_size) {
             break;
         }

-        bdrv_set_dirty_iter(dbi, end * BDRV_SECTOR_SIZE);
+        bdrv_set_dirty_iter(dbi, end);
     }

     *bitmap_table_size = tb_size;
-- 
2.9.4
