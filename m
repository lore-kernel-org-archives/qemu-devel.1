Received: from eggs.gnu.org ([2001:4830:134:3::10]:47935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawq-0003P7-QL
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawp-0000Vs-Kw
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:48 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 Jan 2018 16:57:50 -0600
Message-Id: <20180105225753.30509-18-eblake@redhat.com>
In-Reply-To: <20180105225753.30509-1-eblake@redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 17/20] vmdk: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the vmdk driver accordingly.  Drop the
now-unused vmdk_find_index_in_cluster().

Also, fix a pre-existing bug: if find_extent() fails (unlikely,
since the block layer did a bounds check), then we must return a
failure, rather than 0.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v6-v7: no change
v5: drop dead code [Vladimir], return error on find_extent() failure
v4: rebase to interface tweak
v3: no change
v2: rebase to mapping flag
---
 block/vmdk.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index c665bcc977..8ae36e7a45 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1295,33 +1295,27 @@ static inline uint64_t vmdk_find_offset_in_cluster(VmdkExtent *extent,
     return extent_relative_offset % cluster_size;
 }

-static inline uint64_t vmdk_find_index_in_cluster(VmdkExtent *extent,
-                                                  int64_t sector_num)
-{
-    uint64_t offset;
-    offset = vmdk_find_offset_in_cluster(extent, sector_num * BDRV_SECTOR_SIZE);
-    return offset / BDRV_SECTOR_SIZE;
-}
-
-static int64_t coroutine_fn vmdk_co_get_block_status(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
+static int coroutine_fn vmdk_co_block_status(BlockDriverState *bs,
+                                             bool want_zero,
+                                             int64_t offset, int64_t bytes,
+                                             int64_t *pnum, int64_t *map,
+                                             BlockDriverState **file)
 {
     BDRVVmdkState *s = bs->opaque;
     int64_t index_in_cluster, n, ret;
-    uint64_t offset;
+    uint64_t cluster_offset;
     VmdkExtent *extent;

-    extent = find_extent(s, sector_num, NULL);
+    extent = find_extent(s, offset >> BDRV_SECTOR_BITS, NULL);
     if (!extent) {
-        return 0;
+        return -EIO;
     }
     qemu_co_mutex_lock(&s->lock);
-    ret = get_cluster_offset(bs, extent, NULL,
-                             sector_num * 512, false, &offset,
+    ret = get_cluster_offset(bs, extent, NULL, offset, false, &cluster_offset,
                              0, 0);
     qemu_co_mutex_unlock(&s->lock);

-    index_in_cluster = vmdk_find_index_in_cluster(extent, sector_num);
+    index_in_cluster = vmdk_find_offset_in_cluster(extent, offset);
     switch (ret) {
     case VMDK_ERROR:
         ret = -EIO;
@@ -1336,18 +1330,14 @@ static int64_t coroutine_fn vmdk_co_get_block_status(BlockDriverState *bs,
         ret = BDRV_BLOCK_DATA;
         if (!extent->compressed) {
             ret |= BDRV_BLOCK_OFFSET_VALID;
-            ret |= (offset + (index_in_cluster << BDRV_SECTOR_BITS))
-                    & BDRV_BLOCK_OFFSET_MASK;
+            *map = cluster_offset + index_in_cluster;
         }
         *file = extent->file->bs;
         break;
     }

-    n = extent->cluster_sectors - index_in_cluster;
-    if (n > nb_sectors) {
-        n = nb_sectors;
-    }
-    *pnum = n;
+    n = extent->cluster_sectors * BDRV_SECTOR_SIZE - index_in_cluster;
+    *pnum = MIN(n, bytes);
     return ret;
 }

@@ -2393,7 +2383,7 @@ static BlockDriver bdrv_vmdk = {
     .bdrv_close                   = vmdk_close,
     .bdrv_create                  = vmdk_create,
     .bdrv_co_flush_to_disk        = vmdk_co_flush,
-    .bdrv_co_get_block_status     = vmdk_co_get_block_status,
+    .bdrv_co_block_status         = vmdk_co_block_status,
     .bdrv_get_allocated_file_size = vmdk_get_allocated_file_size,
     .bdrv_has_zero_init           = vmdk_has_zero_init,
     .bdrv_get_specific_info       = vmdk_get_specific_info,
-- 
2.14.3
