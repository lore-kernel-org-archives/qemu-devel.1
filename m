Received: from eggs.gnu.org ([2001:4830:134:3::10]:33554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgww-0004nc-NP
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgwv-0001Nm-J5
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:09:10 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 23 Nov 2017 03:08:19 +0100
Message-Id: <20171123020832.8165-5-mreitz@redhat.com>
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
References: <20171123020832.8165-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 04/17] block/vmdk: Add blkdebug events
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

This is certainly not complete, but it includes at least write_aio and
read_aio.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/vmdk.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index 1ae47b1c2e..d71cec4f31 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1075,6 +1075,8 @@ static int get_whole_cluster(BlockDriverState *bs,
     /* Read backing data before skip range */
     if (skip_start_bytes > 0) {
         if (bs->backing) {
+            /* qcow2 emits this on bs->file instead of bs->backing */
+            BLKDBG_EVENT(extent->file, BLKDBG_COW_READ);
             ret = bdrv_pread(bs->backing, offset, whole_grain,
                              skip_start_bytes);
             if (ret < 0) {
@@ -1082,6 +1084,7 @@ static int get_whole_cluster(BlockDriverState *bs,
                 goto exit;
             }
         }
+        BLKDBG_EVENT(extent->file, BLKDBG_COW_WRITE);
         ret = bdrv_pwrite(extent->file, cluster_offset, whole_grain,
                           skip_start_bytes);
         if (ret < 0) {
@@ -1092,6 +1095,8 @@ static int get_whole_cluster(BlockDriverState *bs,
     /* Read backing data after skip range */
     if (skip_end_bytes < cluster_bytes) {
         if (bs->backing) {
+            /* qcow2 emits this on bs->file instead of bs->backing */
+            BLKDBG_EVENT(extent->file, BLKDBG_COW_READ);
             ret = bdrv_pread(bs->backing, offset + skip_end_bytes,
                              whole_grain + skip_end_bytes,
                              cluster_bytes - skip_end_bytes);
@@ -1100,6 +1105,7 @@ static int get_whole_cluster(BlockDriverState *bs,
                 goto exit;
             }
         }
+        BLKDBG_EVENT(extent->file, BLKDBG_COW_WRITE);
         ret = bdrv_pwrite(extent->file, cluster_offset + skip_end_bytes,
                           whole_grain + skip_end_bytes,
                           cluster_bytes - skip_end_bytes);
@@ -1120,6 +1126,7 @@ static int vmdk_L2update(VmdkExtent *extent, VmdkMetaData *m_data,
 {
     offset = cpu_to_le32(offset);
     /* update L2 table */
+    BLKDBG_EVENT(extent->file, BLKDBG_L2_UPDATE);
     if (bdrv_pwrite_sync(extent->file,
                 ((int64_t)m_data->l2_offset * 512)
                     + (m_data->l2_index * sizeof(offset)),
@@ -1218,6 +1225,7 @@ static int get_cluster_offset(BlockDriverState *bs,
         }
     }
     l2_table = extent->l2_cache + (min_index * extent->l2_size);
+    BLKDBG_EVENT(extent->file, BLKDBG_L2_LOAD);
     if (bdrv_pread(extent->file,
                 (int64_t)l2_offset * 512,
                 l2_table,
@@ -1393,9 +1401,13 @@ static int vmdk_write_extent(VmdkExtent *extent, int64_t cluster_offset,
             .iov_len    = n_bytes,
         };
         qemu_iovec_init_external(&local_qiov, &iov, 1);
+
+        BLKDBG_EVENT(extent->file, BLKDBG_WRITE_COMPRESSED);
     } else {
         qemu_iovec_init(&local_qiov, qiov->niov);
         qemu_iovec_concat(&local_qiov, qiov, qiov_offset, n_bytes);
+
+        BLKDBG_EVENT(extent->file, BLKDBG_WRITE_AIO);
     }
 
     write_offset = cluster_offset + offset_in_cluster;
@@ -1437,6 +1449,7 @@ static int vmdk_read_extent(VmdkExtent *extent, int64_t cluster_offset,
 
 
     if (!extent->compressed) {
+        BLKDBG_EVENT(extent->file, BLKDBG_READ_AIO);
         ret = bdrv_co_preadv(extent->file,
                              cluster_offset + offset_in_cluster, bytes,
                              qiov, 0);
@@ -1450,6 +1463,7 @@ static int vmdk_read_extent(VmdkExtent *extent, int64_t cluster_offset,
     buf_bytes = cluster_bytes * 2;
     cluster_buf = g_malloc(buf_bytes);
     uncomp_buf = g_malloc(cluster_bytes);
+    BLKDBG_EVENT(extent->file, BLKDBG_READ_COMPRESSED);
     ret = bdrv_pread(extent->file,
                 cluster_offset,
                 cluster_buf, buf_bytes);
@@ -1527,6 +1541,8 @@ vmdk_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
                 qemu_iovec_reset(&local_qiov);
                 qemu_iovec_concat(&local_qiov, qiov, bytes_done, n_bytes);
 
+                /* qcow2 emits this on bs->file instead of bs->backing */
+                BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
                 ret = bdrv_co_preadv(bs->backing, offset, n_bytes,
                                      &local_qiov, 0);
                 if (ret < 0) {
-- 
2.13.6
