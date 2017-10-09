Received: from eggs.gnu.org ([2001:4830:134:3::10]:33612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e1ZNF-0001GX-UA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e1ZNC-0006QM-S7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:49:41 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  9 Oct 2017 16:48:40 +0200
Message-Id: <20171009144840.973-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] qcow2: Use BDRV_SECTOR_BITS instead of its
 literal value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

BDRV_SECTOR_BITS is defined to be 9 in block.h (and BDRV_SECTOR_SIZE
is calculated from that), but there are still a few placed where we
are using the literal value instead of the macro.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 6 +++---
 block/qcow2.c         | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 0e5aec81cb..0a63604af6 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -748,8 +748,8 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
         return 0;
     }
 
-    nb_csectors = ((cluster_offset + compressed_size - 1) >> 9) -
-                  (cluster_offset >> 9);
+    nb_csectors = ((cluster_offset + compressed_size - 1) >> BDRV_SECTOR_BITS) -
+                  (cluster_offset >> BDRV_SECTOR_BITS);
 
     cluster_offset |= QCOW_OFLAG_COMPRESSED |
                       ((uint64_t)nb_csectors << s->csize_shift);
@@ -1582,7 +1582,7 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
         }
 
         BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
-        ret = bdrv_read(bs->file, coffset >> 9, s->cluster_data,
+        ret = bdrv_read(bs->file, coffset >> BDRV_SECTOR_BITS, s->cluster_data,
                         nb_csectors);
         if (ret < 0) {
             return ret;
diff --git a/block/qcow2.c b/block/qcow2.c
index f63d1831f8..dff903e05c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1139,7 +1139,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->cluster_bits = header.cluster_bits;
     s->cluster_size = 1 << s->cluster_bits;
-    s->cluster_sectors = 1 << (s->cluster_bits - 9);
+    s->cluster_sectors = 1 << (s->cluster_bits - BDRV_SECTOR_BITS);
 
     /* Initialise version 3 header fields */
     if (header.version == 2) {
@@ -1636,7 +1636,7 @@ static int64_t coroutine_fn qcow2_co_get_block_status(BlockDriverState *bs,
 
     bytes = MIN(INT_MAX, nb_sectors * BDRV_SECTOR_SIZE);
     qemu_co_mutex_lock(&s->lock);
-    ret = qcow2_get_cluster_offset(bs, sector_num << 9, &bytes,
+    ret = qcow2_get_cluster_offset(bs, sector_num << BDRV_SECTOR_BITS, &bytes,
                                    &cluster_offset);
     qemu_co_mutex_unlock(&s->lock);
     if (ret < 0) {
-- 
2.11.0
