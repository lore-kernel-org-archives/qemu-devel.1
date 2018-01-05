Received: from eggs.gnu.org ([2001:4830:134:3::10]:47624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawa-00038Y-Jr
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawZ-0000HU-HU
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:32 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 Jan 2018 16:57:43 -0600
Message-Id: <20180105225753.30509-11-eblake@redhat.com>
In-Reply-To: <20180105225753.30509-1-eblake@redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 10/20] qcow: Switch to
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
byte-based.  Update the qcow driver accordingly.  There is no
intent to optimize based on the want_zero flag for this format.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v5-v7: no change
v4: rebase to interface tweak
v3: rebase to master
v2: rebase to mapping flag
---
 block/qcow.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 9569deeaf0..f09661dc0c 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -513,23 +513,28 @@ static int get_cluster_offset(BlockDriverState *bs,
     return 1;
 }

-static int64_t coroutine_fn qcow_co_get_block_status(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
+static int coroutine_fn qcow_co_block_status(BlockDriverState *bs,
+                                             bool want_zero,
+                                             int64_t offset, int64_t bytes,
+                                             int64_t *pnum, int64_t *map,
+                                             BlockDriverState **file)
 {
     BDRVQcowState *s = bs->opaque;
-    int index_in_cluster, n, ret;
+    int index_in_cluster, ret;
+    int64_t n;
     uint64_t cluster_offset;

     qemu_co_mutex_lock(&s->lock);
-    ret = get_cluster_offset(bs, sector_num << 9, 0, 0, 0, 0, &cluster_offset);
+    ret = get_cluster_offset(bs, offset, 0, 0, 0, 0, &cluster_offset);
     qemu_co_mutex_unlock(&s->lock);
     if (ret < 0) {
         return ret;
     }
-    index_in_cluster = sector_num & (s->cluster_sectors - 1);
-    n = s->cluster_sectors - index_in_cluster;
-    if (n > nb_sectors)
-        n = nb_sectors;
+    index_in_cluster = offset & (s->cluster_size - 1);
+    n = s->cluster_size - index_in_cluster;
+    if (n > bytes) {
+        n = bytes;
+    }
     *pnum = n;
     if (!cluster_offset) {
         return 0;
@@ -537,9 +542,9 @@ static int64_t coroutine_fn qcow_co_get_block_status(BlockDriverState *bs,
     if ((cluster_offset & QCOW_OFLAG_COMPRESSED) || s->crypto) {
         return BDRV_BLOCK_DATA;
     }
-    cluster_offset |= (index_in_cluster << BDRV_SECTOR_BITS);
+    *map = cluster_offset | index_in_cluster;
     *file = bs->file->bs;
-    return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | cluster_offset;
+    return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
 }

 static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
@@ -1111,7 +1116,7 @@ static BlockDriver bdrv_qcow = {

     .bdrv_co_readv          = qcow_co_readv,
     .bdrv_co_writev         = qcow_co_writev,
-    .bdrv_co_get_block_status   = qcow_co_get_block_status,
+    .bdrv_co_block_status   = qcow_co_block_status,

     .bdrv_make_empty        = qcow_make_empty,
     .bdrv_co_pwritev_compressed = qcow_co_pwritev_compressed,
-- 
2.14.3
