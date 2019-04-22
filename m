Received: from eggs.gnu.org ([209.51.188.92]:51086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP5-0000nn-ND
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP4-00037u-KX
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:43 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 22 Apr 2019 17:58:31 +0300
Message-Id: <20190422145838.70903-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/9] block/qcow2: use buffer-based io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3ace3b2209..c3b2ea294d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4088,7 +4088,6 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
                             uint64_t bytes, QEMUIOVector *qiov)
 {
     BDRVQcow2State *s = bs->opaque;
-    QEMUIOVector hd_qiov;
     int ret;
     size_t out_len;
     uint8_t *buf, *out_buf;
@@ -4155,10 +4154,8 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         goto fail;
     }
 
-    qemu_iovec_init_buf(&hd_qiov, out_buf, out_len);
-
     BLKDBG_EVENT(s->data_file, BLKDBG_WRITE_COMPRESSED);
-    ret = bdrv_co_pwritev(s->data_file, cluster_offset, out_len, &hd_qiov, 0);
+    ret = bdrv_co_pwrite(s->data_file, cluster_offset, out_len, out_buf, 0);
     if (ret < 0) {
         goto fail;
     }
@@ -4181,7 +4178,6 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
     int ret = 0, csize, nb_csectors;
     uint64_t coffset;
     uint8_t *buf, *out_buf;
-    QEMUIOVector local_qiov;
     int offset_in_cluster = offset_into_cluster(s, offset);
 
     coffset = file_cluster_offset & s->cluster_offset_mask;
@@ -4192,12 +4188,11 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
     if (!buf) {
         return -ENOMEM;
     }
-    qemu_iovec_init_buf(&local_qiov, buf, csize);
 
     out_buf = qemu_blockalign(bs, s->cluster_size);
 
     BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
-    ret = bdrv_co_preadv(bs->file, coffset, csize, &local_qiov, 0);
+    ret = bdrv_co_pread(bs->file, coffset, csize, buf, 0);
     if (ret < 0) {
         goto fail;
     }
-- 
2.18.0
