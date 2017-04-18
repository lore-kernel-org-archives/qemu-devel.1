Received: from eggs.gnu.org ([2001:4830:134:3::10]:34341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2g-0005fz-PP
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2g-0003tO-1J
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:54 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Apr 2017 20:33:46 -0500
Message-Id: <20170418013356.3578-22-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 21/31] qcow: Switch to .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@nongnu.org, jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the qcow driver accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 5d147b9..d7dfa08 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -515,20 +515,22 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
     return cluster_offset;
 }

-static int64_t coroutine_fn qcow_co_get_block_status(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
+static int64_t coroutine_fn qcow_co_block_status(BlockDriverState *bs,
+        int64_t offset, int64_t bytes, int64_t *pnum, BlockDriverState **file)
 {
     BDRVQcowState *s = bs->opaque;
-    int index_in_cluster, n;
+    int index_in_cluster;
+    int64_t n;
     uint64_t cluster_offset;

     qemu_co_mutex_lock(&s->lock);
-    cluster_offset = get_cluster_offset(bs, sector_num << 9, 0, 0, 0, 0);
+    cluster_offset = get_cluster_offset(bs, offset, 0, 0, 0, 0);
     qemu_co_mutex_unlock(&s->lock);
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
@@ -536,7 +538,7 @@ static int64_t coroutine_fn qcow_co_get_block_status(BlockDriverState *bs,
     if ((cluster_offset & QCOW_OFLAG_COMPRESSED) || s->cipher) {
         return BDRV_BLOCK_DATA;
     }
-    cluster_offset |= (index_in_cluster << BDRV_SECTOR_BITS);
+    cluster_offset |= (index_in_cluster & BDRV_BLOCK_OFFSET_MASK);
     *file = bs->file->bs;
     return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | cluster_offset;
 }
@@ -1061,7 +1063,7 @@ static BlockDriver bdrv_qcow = {

     .bdrv_co_readv          = qcow_co_readv,
     .bdrv_co_writev         = qcow_co_writev,
-    .bdrv_co_get_block_status   = qcow_co_get_block_status,
+    .bdrv_co_block_status   = qcow_co_block_status,

     .bdrv_set_key           = qcow_set_key,
     .bdrv_make_empty        = qcow_make_empty,
-- 
2.9.3
