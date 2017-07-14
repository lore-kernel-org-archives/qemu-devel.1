Received: from eggs.gnu.org ([2001:4830:134:3::10]:47003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVs-0004P3-TE
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVr-0004QY-Ky
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:16:04 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 07:14:54 -0500
Message-Id: <20170714121457.10322-18-eblake@redhat.com>
In-Reply-To: <20170714121457.10322-1-eblake@redhat.com>
References: <20170714121457.10322-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/20] vmdk: Switch to
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
Cc: qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the vmdk driver accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to mapping flag
---
 block/vmdk.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 24d71b5..f134d21 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1286,25 +1286,27 @@ static inline uint64_t vmdk_find_index_in_cluster(VmdkExtent *extent,
     return offset / BDRV_SECTOR_SIZE;
 }

-static int64_t coroutine_fn vmdk_co_get_block_status(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
+static int64_t coroutine_fn vmdk_co_block_status(BlockDriverState *bs,
+                                                 bool mapping,
+                                                 int64_t offset, int64_t bytes,
+                                                 int64_t *pnum,
+                                                 BlockDriverState **file)
 {
     BDRVVmdkState *s = bs->opaque;
     int64_t index_in_cluster, n, ret;
-    uint64_t offset;
+    uint64_t cluster_offset;
     VmdkExtent *extent;

-    extent = find_extent(s, sector_num, NULL);
+    extent = find_extent(s, offset >> BDRV_SECTOR_BITS, NULL);
     if (!extent) {
         return 0;
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
@@ -1319,18 +1321,15 @@ static int64_t coroutine_fn vmdk_co_get_block_status(BlockDriverState *bs,
         ret = BDRV_BLOCK_DATA;
         if (!extent->compressed) {
             ret |= BDRV_BLOCK_OFFSET_VALID;
-            ret |= (offset + (index_in_cluster << BDRV_SECTOR_BITS))
+            ret |= (cluster_offset + index_in_cluster)
                     & BDRV_BLOCK_OFFSET_MASK;
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

@@ -2363,7 +2362,7 @@ static BlockDriver bdrv_vmdk = {
     .bdrv_close                   = vmdk_close,
     .bdrv_create                  = vmdk_create,
     .bdrv_co_flush_to_disk        = vmdk_co_flush,
-    .bdrv_co_get_block_status     = vmdk_co_get_block_status,
+    .bdrv_co_block_status         = vmdk_co_block_status,
     .bdrv_get_allocated_file_size = vmdk_get_allocated_file_size,
     .bdrv_has_zero_init           = vmdk_has_zero_init,
     .bdrv_get_specific_info       = vmdk_get_specific_info,
-- 
2.9.4
