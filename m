Received: from eggs.gnu.org ([209.51.188.92]:37046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgru-0002z9-QG
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgru-000260-3w
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:18 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Feb 2019 13:24:37 +0300
Message-Id: <20190207102445.71998-10-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 09/17] block/qcow2: use qemu_iovec_init_buf
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
 block/qcow2.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 8c91b92865..1f413a75bf 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3894,7 +3894,6 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
 {
     BDRVQcow2State *s = bs->opaque;
     QEMUIOVector hd_qiov;
-    struct iovec iov;
     int ret;
     size_t out_len;
     uint8_t *buf, *out_buf;
@@ -3960,11 +3959,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         goto fail;
     }
 
-    iov = (struct iovec) {
-        .iov_base   = out_buf,
-        .iov_len    = out_len,
-    };
-    qemu_iovec_init_external(&hd_qiov, &iov, 1);
+    qemu_iovec_init_buf(&hd_qiov, out_buf, out_len);
 
     BLKDBG_EVENT(bs->file, BLKDBG_WRITE_COMPRESSED);
     ret = bdrv_co_pwritev(bs->file, cluster_offset, out_len, &hd_qiov, 0);
@@ -3990,7 +3985,6 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
     int ret = 0, csize, nb_csectors;
     uint64_t coffset;
     uint8_t *buf, *out_buf;
-    struct iovec iov;
     QEMUIOVector local_qiov;
     int offset_in_cluster = offset_into_cluster(s, offset);
 
@@ -4002,9 +3996,7 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
     if (!buf) {
         return -ENOMEM;
     }
-    iov.iov_base = buf;
-    iov.iov_len = csize;
-    qemu_iovec_init_external(&local_qiov, &iov, 1);
+    qemu_iovec_init_buf(&local_qiov, buf, csize);
 
     out_buf = qemu_blockalign(bs, s->cluster_size);
 
-- 
2.18.0
