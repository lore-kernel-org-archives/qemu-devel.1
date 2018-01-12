Received: from eggs.gnu.org ([2001:4830:134:3::10]:43257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eZvDf-0003Eg-RT
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eZvDb-0000Lz-Bv
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:01:47 -0500
From: Klim Kireev <klim.kireev@virtuozzo.com>
Date: Fri, 12 Jan 2018 12:01:22 +0300
Message-Id: <20180112090122.1702-6-klim.kireev@virtuozzo.com>
In-Reply-To: <20180112090122.1702-1-klim.kireev@virtuozzo.com>
References: <20180112090122.1702-1-klim.kireev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 5/5] block/parallels: add backing support to
 readv/writev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, qemu-block@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>

Since parallels format supports backing files, refine
readv/writev (allocate_clusters) to redirect read/write requests
to a backing file (if cluster is not available in the current bs).

Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c | 50 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 7a8e8b05a9..d3802085e3 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -142,6 +142,7 @@ static int64_t block_status(BDRVParallelsState *s, int64_t sector_num,
 static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
                                  int nb_sectors, int *pnum)
 {
+    int ret;
     BDRVParallelsState *s = bs->opaque;
     int64_t pos, space, idx, to_allocate, i, len;
 
@@ -170,7 +171,6 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         return len;
     }
     if (s->data_end + space > (len >> BDRV_SECTOR_BITS)) {
-        int ret;
         space += s->prealloc_size;
         if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
             ret = bdrv_pwrite_zeroes(bs->file,
@@ -186,6 +186,37 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         }
     }
 
+    /* Try to read from backing to fill empty clusters
+     * FIXME: 1. previous write_zeroes may be redundant
+     *        2. most of data we read from backing will be rewritten by
+     *           parallels_co_writev. On aligned-to-cluster write we do not need
+     *           this read at all.
+     *        3. it would be good to combine write of data from backing and new
+     *           data into one write call */
+    if (bs->backing) {
+        int64_t nb_cow_sectors = to_allocate * s->tracks;
+        int64_t nb_cow_bytes = nb_cow_sectors << BDRV_SECTOR_BITS;
+        QEMUIOVector qiov;
+        struct iovec iov = {
+            .iov_len = nb_cow_bytes,
+            .iov_base = qemu_blockalign(bs, nb_cow_bytes)
+        };
+        qemu_iovec_init_external(&qiov, &iov, 1);
+
+        ret = bdrv_co_readv(bs->backing, idx * s->tracks, nb_cow_sectors,
+                            &qiov);
+        if (ret < 0) {
+            qemu_vfree(iov.iov_base);
+            return ret;
+        }
+
+        ret = bdrv_co_writev(bs->file, s->data_end, nb_cow_sectors, &qiov);
+        qemu_vfree(iov.iov_base);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     for (i = 0; i < to_allocate; i++) {
         s->bat_bitmap[idx + i] = cpu_to_le32(s->data_end / s->off_multiplier);
         s->data_end += s->tracks;
@@ -309,12 +340,19 @@ static coroutine_fn int parallels_co_readv(BlockDriverState *bs,
 
         nbytes = n << BDRV_SECTOR_BITS;
 
+        qemu_iovec_reset(&hd_qiov);
+        qemu_iovec_concat(&hd_qiov, qiov, bytes_done, nbytes);
+
         if (position < 0) {
-            qemu_iovec_memset(qiov, bytes_done, 0, nbytes);
+            if (bs->backing) {
+                ret = bdrv_co_readv(bs->backing, sector_num, n, &hd_qiov);
+                if (ret < 0) {
+                    break;
+                }
+            } else {
+                qemu_iovec_memset(&hd_qiov, 0, 0, nbytes);
+            }
         } else {
-            qemu_iovec_reset(&hd_qiov);
-            qemu_iovec_concat(&hd_qiov, qiov, bytes_done, nbytes);
-
             ret = bdrv_co_readv(bs->file, position, n, &hd_qiov);
             if (ret < 0) {
                 break;
@@ -748,7 +786,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_flush_to_os      = parallels_co_flush_to_os,
     .bdrv_co_readv  = parallels_co_readv,
     .bdrv_co_writev = parallels_co_writev,
-
+    .supports_backing = true,
     .bdrv_create    = parallels_create,
     .bdrv_check     = parallels_check,
     .create_opts    = &parallels_create_opts,
-- 
2.14.3
