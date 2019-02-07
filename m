Received: from eggs.gnu.org ([209.51.188.92]:36656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgrb-0002iX-Le
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgra-0001jO-1E
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:24:59 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Feb 2019 13:24:36 +0300
Message-Id: <20190207102445.71998-9-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 08/17] block/qcow: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, vsementsov@virtuozzo.com

Use new qemu_iovec_init_buf() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 0a235bf393..409c700d33 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -628,7 +628,6 @@ static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, uint64_t offset,
     int offset_in_cluster;
     int ret = 0, n;
     uint64_t cluster_offset;
-    struct iovec hd_iov;
     QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
@@ -661,9 +660,7 @@ static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, uint64_t offset,
         if (!cluster_offset) {
             if (bs->backing) {
                 /* read from the base image */
-                hd_iov.iov_base = (void *)buf;
-                hd_iov.iov_len = n;
-                qemu_iovec_init_external(&hd_qiov, &hd_iov, 1);
+                qemu_iovec_init_buf(&hd_qiov, buf, n);
                 qemu_co_mutex_unlock(&s->lock);
                 /* qcow2 emits this on bs->file instead of bs->backing */
                 BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
@@ -688,9 +685,7 @@ static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, uint64_t offset,
                 ret = -EIO;
                 break;
             }
-            hd_iov.iov_base = (void *)buf;
-            hd_iov.iov_len = n;
-            qemu_iovec_init_external(&hd_qiov, &hd_iov, 1);
+            qemu_iovec_init_buf(&hd_qiov, buf, n);
             qemu_co_mutex_unlock(&s->lock);
             BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
             ret = bdrv_co_preadv(bs->file, cluster_offset + offset_in_cluster,
@@ -733,7 +728,6 @@ static coroutine_fn int qcow_co_pwritev(BlockDriverState *bs, uint64_t offset,
     int offset_in_cluster;
     uint64_t cluster_offset;
     int ret = 0, n;
-    struct iovec hd_iov;
     QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
@@ -779,9 +773,7 @@ static coroutine_fn int qcow_co_pwritev(BlockDriverState *bs, uint64_t offset,
             }
         }
 
-        hd_iov.iov_base = (void *)buf;
-        hd_iov.iov_len = n;
-        qemu_iovec_init_external(&hd_qiov, &hd_iov, 1);
+        qemu_iovec_init_buf(&hd_qiov, buf, n);
         qemu_co_mutex_unlock(&s->lock);
         BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
         ret = bdrv_co_pwritev(bs->file, cluster_offset + offset_in_cluster,
@@ -1062,7 +1054,6 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
 {
     BDRVQcowState *s = bs->opaque;
     QEMUIOVector hd_qiov;
-    struct iovec iov;
     z_stream strm;
     int ret, out_len;
     uint8_t *buf, *out_buf;
@@ -1128,11 +1119,7 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     }
     cluster_offset &= s->cluster_offset_mask;
 
-    iov = (struct iovec) {
-        .iov_base   = out_buf,
-        .iov_len    = out_len,
-    };
-    qemu_iovec_init_external(&hd_qiov, &iov, 1);
+    qemu_iovec_init_buf(&hd_qiov, out_buf, out_len);
     BLKDBG_EVENT(bs->file, BLKDBG_WRITE_COMPRESSED);
     ret = bdrv_co_pwritev(bs->file, cluster_offset, out_len, &hd_qiov, 0);
     if (ret < 0) {
-- 
2.18.0
