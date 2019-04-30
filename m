Received: from eggs.gnu.org ([209.51.188.92]:48961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuw-000899-6c
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuu-0002AY-Do
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:35 +0200
Message-Id: <20190430154244.30083-19-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/27] block/qcow: use buffer-based io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 10d2cf14b3..1bb8fd05e2 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -631,7 +631,6 @@ static coroutine_fn int qcow_co_preadv(BlockDriverSta=
te *bs, uint64_t offset,
     int offset_in_cluster;
     int ret =3D 0, n;
     uint64_t cluster_offset;
-    QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
=20
@@ -663,11 +662,10 @@ static coroutine_fn int qcow_co_preadv(BlockDriverS=
tate *bs, uint64_t offset,
         if (!cluster_offset) {
             if (bs->backing) {
                 /* read from the base image */
-                qemu_iovec_init_buf(&hd_qiov, buf, n);
                 qemu_co_mutex_unlock(&s->lock);
                 /* qcow2 emits this on bs->file instead of bs->backing *=
/
                 BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
-                ret =3D bdrv_co_preadv(bs->backing, offset, n, &hd_qiov,=
 0);
+                ret =3D bdrv_co_pread(bs->backing, offset, n, buf, 0);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
                     break;
@@ -688,11 +686,10 @@ static coroutine_fn int qcow_co_preadv(BlockDriverS=
tate *bs, uint64_t offset,
                 ret =3D -EIO;
                 break;
             }
-            qemu_iovec_init_buf(&hd_qiov, buf, n);
             qemu_co_mutex_unlock(&s->lock);
             BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-            ret =3D bdrv_co_preadv(bs->file, cluster_offset + offset_in_=
cluster,
-                                 n, &hd_qiov, 0);
+            ret =3D bdrv_co_pread(bs->file, cluster_offset + offset_in_c=
luster,
+                                n, buf, 0);
             qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
                 break;
@@ -731,7 +728,6 @@ static coroutine_fn int qcow_co_pwritev(BlockDriverSt=
ate *bs, uint64_t offset,
     int offset_in_cluster;
     uint64_t cluster_offset;
     int ret =3D 0, n;
-    QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
=20
@@ -776,11 +772,10 @@ static coroutine_fn int qcow_co_pwritev(BlockDriver=
State *bs, uint64_t offset,
             }
         }
=20
-        qemu_iovec_init_buf(&hd_qiov, buf, n);
         qemu_co_mutex_unlock(&s->lock);
         BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
-        ret =3D bdrv_co_pwritev(bs->file, cluster_offset + offset_in_clu=
ster,
-                              n, &hd_qiov, 0);
+        ret =3D bdrv_co_pwrite(bs->file, cluster_offset + offset_in_clus=
ter,
+                             n, buf, 0);
         qemu_co_mutex_lock(&s->lock);
         if (ret < 0) {
             break;
@@ -1056,7 +1051,6 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, ui=
nt64_t offset,
                            uint64_t bytes, QEMUIOVector *qiov)
 {
     BDRVQcowState *s =3D bs->opaque;
-    QEMUIOVector hd_qiov;
     z_stream strm;
     int ret, out_len;
     uint8_t *buf, *out_buf;
@@ -1122,9 +1116,8 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, ui=
nt64_t offset,
     }
     cluster_offset &=3D s->cluster_offset_mask;
=20
-    qemu_iovec_init_buf(&hd_qiov, out_buf, out_len);
     BLKDBG_EVENT(bs->file, BLKDBG_WRITE_COMPRESSED);
-    ret =3D bdrv_co_pwritev(bs->file, cluster_offset, out_len, &hd_qiov,=
 0);
+    ret =3D bdrv_co_pwrite(bs->file, cluster_offset, out_len, out_buf, 0=
);
     if (ret < 0) {
         goto fail;
     }
--=20
2.20.1
