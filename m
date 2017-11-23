Received: from eggs.gnu.org ([2001:4830:134:3::10]:33519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgwu-0004m7-42
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgwq-0001L4-Uu
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:09:08 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 23 Nov 2017 03:08:18 +0100
Message-Id: <20171123020832.8165-4-mreitz@redhat.com>
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
References: <20171123020832.8165-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 03/17] block/qcow: Add blkdebug events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>

This is not necessarily complete, but it should include the most
important places.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/qcow.c b/block/qcow.c
index 9569deeaf0..d552a6eba8 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -379,6 +379,7 @@ static int get_cluster_offset(BlockDriverState *bs,
         /* update the L1 entry */
         s->l1_table[l1_index] = l2_offset;
         tmp = cpu_to_be64(l2_offset);
+        BLKDBG_EVENT(bs->file, BLKDBG_L1_UPDATE);
         ret = bdrv_pwrite_sync(bs->file,
                                s->l1_table_offset + l1_index * sizeof(tmp),
                                &tmp, sizeof(tmp));
@@ -409,6 +410,7 @@ static int get_cluster_offset(BlockDriverState *bs,
         }
     }
     l2_table = s->l2_cache + (min_index << s->l2_bits);
+    BLKDBG_EVENT(bs->file, BLKDBG_L2_LOAD);
     if (new_l2_table) {
         memset(l2_table, 0, s->l2_size * sizeof(uint64_t));
         ret = bdrv_pwrite_sync(bs->file, l2_offset, l2_table,
@@ -432,6 +434,7 @@ static int get_cluster_offset(BlockDriverState *bs,
         ((cluster_offset & QCOW_OFLAG_COMPRESSED) && allocate == 1)) {
         if (!allocate)
             return 0;
+        BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC);
         /* allocate a new cluster */
         if ((cluster_offset & QCOW_OFLAG_COMPRESSED) &&
             (n_end - n_start) < s->cluster_sectors) {
@@ -447,6 +450,7 @@ static int get_cluster_offset(BlockDriverState *bs,
             }
             cluster_offset = QEMU_ALIGN_UP(cluster_offset, s->cluster_size);
             /* write the cluster content */
+            BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
             ret = bdrv_pwrite(bs->file, cluster_offset, s->cluster_cache,
                               s->cluster_size);
             if (ret < 0) {
@@ -486,6 +490,7 @@ static int get_cluster_offset(BlockDriverState *bs,
                                                       NULL) < 0) {
                                 return -EIO;
                             }
+                            BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
                             ret = bdrv_pwrite(bs->file,
                                               cluster_offset + i * 512,
                                               s->cluster_data, 512);
@@ -503,6 +508,11 @@ static int get_cluster_offset(BlockDriverState *bs,
         /* update L2 table */
         tmp = cpu_to_be64(cluster_offset);
         l2_table[l2_index] = tmp;
+        if (allocate == 2) {
+            BLKDBG_EVENT(bs->file, BLKDBG_L2_UPDATE_COMPRESSED);
+        } else {
+            BLKDBG_EVENT(bs->file, BLKDBG_L2_UPDATE);
+        }
         ret = bdrv_pwrite_sync(bs->file, l2_offset + l2_index * sizeof(tmp),
                                &tmp, sizeof(tmp));
         if (ret < 0) {
@@ -579,6 +589,7 @@ static int decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
     if (s->cluster_cache_offset != coffset) {
         csize = cluster_offset >> (63 - s->cluster_bits);
         csize &= (s->cluster_size - 1);
+        BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
         ret = bdrv_pread(bs->file, coffset, s->cluster_data, csize);
         if (ret != csize)
             return -1;
@@ -635,6 +646,8 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
                 hd_iov.iov_len = n * 512;
                 qemu_iovec_init_external(&hd_qiov, &hd_iov, 1);
                 qemu_co_mutex_unlock(&s->lock);
+                /* qcow2 emits this on bs->file instead of bs->backing */
+                BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
                 ret = bdrv_co_readv(bs->backing, sector_num, n, &hd_qiov);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
@@ -661,6 +674,7 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
             hd_iov.iov_len = n * 512;
             qemu_iovec_init_external(&hd_qiov, &hd_iov, 1);
             qemu_co_mutex_unlock(&s->lock);
+            BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
             ret = bdrv_co_readv(bs->file,
                                 (cluster_offset >> 9) + index_in_cluster,
                                 n, &hd_qiov);
@@ -754,6 +768,7 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
         hd_iov.iov_len = n * 512;
         qemu_iovec_init_external(&hd_qiov, &hd_iov, 1);
         qemu_co_mutex_unlock(&s->lock);
+        BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
         ret = bdrv_co_writev(bs->file,
                              (cluster_offset >> 9) + index_in_cluster,
                              n, &hd_qiov);
@@ -1048,6 +1063,7 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         .iov_len    = out_len,
     };
     qemu_iovec_init_external(&hd_qiov, &iov, 1);
+    BLKDBG_EVENT(bs->file, BLKDBG_WRITE_COMPRESSED);
     ret = bdrv_co_pwritev(bs->file, cluster_offset, out_len, &hd_qiov, 0);
     if (ret < 0) {
         goto fail;
-- 
2.13.6
