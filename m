Received: from eggs.gnu.org ([209.51.188.92]:38017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVF-0002O8-Qa
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVA-0001qW-09
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:33 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:37 +0000
Message-Id: <20190222140756.29834-9-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/27] block/qcow: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Use new qemu_iovec_init_buf() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190218140926.333779-9-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-9-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qcow.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 0a235bf393..409c700d33 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -628,7 +628,6 @@ static coroutine_fn int qcow_co_preadv(BlockDriverSta=
te *bs, uint64_t offset,
     int offset_in_cluster;
     int ret =3D 0, n;
     uint64_t cluster_offset;
-    struct iovec hd_iov;
     QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
@@ -661,9 +660,7 @@ static coroutine_fn int qcow_co_preadv(BlockDriverSta=
te *bs, uint64_t offset,
         if (!cluster_offset) {
             if (bs->backing) {
                 /* read from the base image */
-                hd_iov.iov_base =3D (void *)buf;
-                hd_iov.iov_len =3D n;
-                qemu_iovec_init_external(&hd_qiov, &hd_iov, 1);
+                qemu_iovec_init_buf(&hd_qiov, buf, n);
                 qemu_co_mutex_unlock(&s->lock);
                 /* qcow2 emits this on bs->file instead of bs->backing *=
/
                 BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
@@ -688,9 +685,7 @@ static coroutine_fn int qcow_co_preadv(BlockDriverSta=
te *bs, uint64_t offset,
                 ret =3D -EIO;
                 break;
             }
-            hd_iov.iov_base =3D (void *)buf;
-            hd_iov.iov_len =3D n;
-            qemu_iovec_init_external(&hd_qiov, &hd_iov, 1);
+            qemu_iovec_init_buf(&hd_qiov, buf, n);
             qemu_co_mutex_unlock(&s->lock);
             BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
             ret =3D bdrv_co_preadv(bs->file, cluster_offset + offset_in_=
cluster,
@@ -733,7 +728,6 @@ static coroutine_fn int qcow_co_pwritev(BlockDriverSt=
ate *bs, uint64_t offset,
     int offset_in_cluster;
     uint64_t cluster_offset;
     int ret =3D 0, n;
-    struct iovec hd_iov;
     QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
@@ -779,9 +773,7 @@ static coroutine_fn int qcow_co_pwritev(BlockDriverSt=
ate *bs, uint64_t offset,
             }
         }
=20
-        hd_iov.iov_base =3D (void *)buf;
-        hd_iov.iov_len =3D n;
-        qemu_iovec_init_external(&hd_qiov, &hd_iov, 1);
+        qemu_iovec_init_buf(&hd_qiov, buf, n);
         qemu_co_mutex_unlock(&s->lock);
         BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
         ret =3D bdrv_co_pwritev(bs->file, cluster_offset + offset_in_clu=
ster,
@@ -1062,7 +1054,6 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, ui=
nt64_t offset,
 {
     BDRVQcowState *s =3D bs->opaque;
     QEMUIOVector hd_qiov;
-    struct iovec iov;
     z_stream strm;
     int ret, out_len;
     uint8_t *buf, *out_buf;
@@ -1128,11 +1119,7 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, u=
int64_t offset,
     }
     cluster_offset &=3D s->cluster_offset_mask;
=20
-    iov =3D (struct iovec) {
-        .iov_base   =3D out_buf,
-        .iov_len    =3D out_len,
-    };
-    qemu_iovec_init_external(&hd_qiov, &iov, 1);
+    qemu_iovec_init_buf(&hd_qiov, out_buf, out_len);
     BLKDBG_EVENT(bs->file, BLKDBG_WRITE_COMPRESSED);
     ret =3D bdrv_co_pwritev(bs->file, cluster_offset, out_len, &hd_qiov,=
 0);
     if (ret < 0) {
--=20
2.20.1
