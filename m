Received: from eggs.gnu.org ([209.51.188.92]:41688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBa7-0006pA-Q6
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBZz-0001Mq-ID
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:13:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:31 +0000
Message-Id: <20190222140756.29834-3-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/27] block/io: use qemu_iovec_init_buf
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

While being here, use qemu_try_blockalign0 as well.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190218140926.333779-3-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-3-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 89 ++++++++++++------------------------------------------
 1 file changed, 20 insertions(+), 69 deletions(-)

diff --git a/block/io.c b/block/io.c
index 213ca03d8d..2ba603c7bc 100644
--- a/block/io.c
+++ b/block/io.c
@@ -843,17 +843,13 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t o=
ffset,
 static int bdrv_rw_co(BdrvChild *child, int64_t sector_num, uint8_t *buf=
,
                       int nb_sectors, bool is_write, BdrvRequestFlags fl=
ags)
 {
-    QEMUIOVector qiov;
-    struct iovec iov =3D {
-        .iov_base =3D (void *)buf,
-        .iov_len =3D nb_sectors * BDRV_SECTOR_SIZE,
-    };
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf,
+                                            nb_sectors * BDRV_SECTOR_SIZ=
E);
=20
     if (nb_sectors < 0 || nb_sectors > BDRV_REQUEST_MAX_SECTORS) {
         return -EINVAL;
     }
=20
-    qemu_iovec_init_external(&qiov, &iov, 1);
     return bdrv_prwv_co(child, sector_num << BDRV_SECTOR_BITS,
                         &qiov, is_write, flags);
 }
@@ -880,13 +876,8 @@ int bdrv_write(BdrvChild *child, int64_t sector_num,
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags)
 {
-    QEMUIOVector qiov;
-    struct iovec iov =3D {
-        .iov_base =3D NULL,
-        .iov_len =3D bytes,
-    };
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
=20
-    qemu_iovec_init_external(&qiov, &iov, 1);
     return bdrv_prwv_co(child, offset, &qiov, true,
                         BDRV_REQ_ZERO_WRITE | flags);
 }
@@ -950,17 +941,12 @@ int bdrv_preadv(BdrvChild *child, int64_t offset, Q=
EMUIOVector *qiov)
=20
 int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
 {
-    QEMUIOVector qiov;
-    struct iovec iov =3D {
-        .iov_base =3D (void *)buf,
-        .iov_len =3D bytes,
-    };
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
=20
     if (bytes < 0) {
         return -EINVAL;
     }
=20
-    qemu_iovec_init_external(&qiov, &iov, 1);
     return bdrv_preadv(child, offset, &qiov);
 }
=20
@@ -978,17 +964,12 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, =
QEMUIOVector *qiov)
=20
 int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int b=
ytes)
 {
-    QEMUIOVector qiov;
-    struct iovec iov =3D {
-        .iov_base   =3D (void *) buf,
-        .iov_len    =3D bytes,
-    };
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
=20
     if (bytes < 0) {
         return -EINVAL;
     }
=20
-    qemu_iovec_init_external(&qiov, &iov, 1);
     return bdrv_pwritev(child, offset, &qiov);
 }
=20
@@ -1165,7 +1146,6 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(Bd=
rvChild *child,
     void *bounce_buffer;
=20
     BlockDriver *drv =3D bs->drv;
-    struct iovec iov;
     QEMUIOVector local_qiov;
     int64_t cluster_offset;
     int64_t cluster_bytes;
@@ -1230,9 +1210,8 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(Bd=
rvChild *child,
=20
         if (ret <=3D 0) {
             /* Must copy-on-read; use the bounce buffer */
-            iov.iov_base =3D bounce_buffer;
-            iov.iov_len =3D pnum =3D MIN(pnum, MAX_BOUNCE_BUFFER);
-            qemu_iovec_init_external(&local_qiov, &iov, 1);
+            pnum =3D MIN(pnum, MAX_BOUNCE_BUFFER);
+            qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
=20
             ret =3D bdrv_driver_preadv(bs, cluster_offset, pnum,
                                      &local_qiov, 0);
@@ -1477,7 +1456,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bl=
ockDriverState *bs,
 {
     BlockDriver *drv =3D bs->drv;
     QEMUIOVector qiov;
-    struct iovec iov =3D {0};
+    void *buf =3D NULL;
     int ret =3D 0;
     bool need_flush =3D false;
     int head =3D 0;
@@ -1547,16 +1526,14 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(=
BlockDriverState *bs,
                 need_flush =3D true;
             }
             num =3D MIN(num, max_transfer);
-            iov.iov_len =3D num;
-            if (iov.iov_base =3D=3D NULL) {
-                iov.iov_base =3D qemu_try_blockalign(bs, num);
-                if (iov.iov_base =3D=3D NULL) {
+            if (buf =3D=3D NULL) {
+                buf =3D qemu_try_blockalign0(bs, num);
+                if (buf =3D=3D NULL) {
                     ret =3D -ENOMEM;
                     goto fail;
                 }
-                memset(iov.iov_base, 0, num);
             }
-            qemu_iovec_init_external(&qiov, &iov, 1);
+            qemu_iovec_init_buf(&qiov, buf, num);
=20
             ret =3D bdrv_driver_pwritev(bs, offset, num, &qiov, write_fl=
ags);
=20
@@ -1564,8 +1541,8 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bl=
ockDriverState *bs,
              * all future requests.
              */
             if (num < max_transfer) {
-                qemu_vfree(iov.iov_base);
-                iov.iov_base =3D NULL;
+                qemu_vfree(buf);
+                buf =3D NULL;
             }
         }
=20
@@ -1577,7 +1554,7 @@ fail:
     if (ret =3D=3D 0 && need_flush) {
         ret =3D bdrv_co_flush(bs);
     }
-    qemu_vfree(iov.iov_base);
+    qemu_vfree(buf);
     return ret;
 }
=20
@@ -1763,7 +1740,6 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(Bdr=
vChild *child,
     BlockDriverState *bs =3D child->bs;
     uint8_t *buf =3D NULL;
     QEMUIOVector local_qiov;
-    struct iovec iov;
     uint64_t align =3D bs->bl.request_alignment;
     unsigned int head_padding_bytes, tail_padding_bytes;
     int ret =3D 0;
@@ -1775,11 +1751,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(Bd=
rvChild *child,
     assert(flags & BDRV_REQ_ZERO_WRITE);
     if (head_padding_bytes || tail_padding_bytes) {
         buf =3D qemu_blockalign(bs, align);
-        iov =3D (struct iovec) {
-            .iov_base   =3D buf,
-            .iov_len    =3D align,
-        };
-        qemu_iovec_init_external(&local_qiov, &iov, 1);
+        qemu_iovec_init_buf(&local_qiov, buf, align);
     }
     if (head_padding_bytes) {
         uint64_t zero_bytes =3D MIN(bytes, align - head_padding_bytes);
@@ -1885,17 +1857,12 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child=
,
=20
     if (offset & (align - 1)) {
         QEMUIOVector head_qiov;
-        struct iovec head_iov;
=20
         mark_request_serialising(&req, align);
         wait_serialising_requests(&req);
=20
         head_buf =3D qemu_blockalign(bs, align);
-        head_iov =3D (struct iovec) {
-            .iov_base   =3D head_buf,
-            .iov_len    =3D align,
-        };
-        qemu_iovec_init_external(&head_qiov, &head_iov, 1);
+        qemu_iovec_init_buf(&head_qiov, head_buf, align);
=20
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
         ret =3D bdrv_aligned_preadv(child, &req, offset & ~(align - 1), =
align,
@@ -1924,7 +1891,6 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
=20
     if ((offset + bytes) & (align - 1)) {
         QEMUIOVector tail_qiov;
-        struct iovec tail_iov;
         size_t tail_bytes;
         bool waited;
=20
@@ -1933,11 +1899,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
         assert(!waited || !use_local_qiov);
=20
         tail_buf =3D qemu_blockalign(bs, align);
-        tail_iov =3D (struct iovec) {
-            .iov_base   =3D tail_buf,
-            .iov_len    =3D align,
-        };
-        qemu_iovec_init_external(&tail_qiov, &tail_iov, 1);
+        qemu_iovec_init_buf(&tail_qiov, tail_buf, align);
=20
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
         ret =3D bdrv_aligned_preadv(child, &req, (offset + bytes) & ~(al=
ign - 1),
@@ -2468,15 +2430,9 @@ bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector=
 *qiov, int64_t pos,
 int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
                       int64_t pos, int size)
 {
-    QEMUIOVector qiov;
-    struct iovec iov =3D {
-        .iov_base   =3D (void *) buf,
-        .iov_len    =3D size,
-    };
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, size);
     int ret;
=20
-    qemu_iovec_init_external(&qiov, &iov, 1);
-
     ret =3D bdrv_writev_vmstate(bs, &qiov, pos);
     if (ret < 0) {
         return ret;
@@ -2493,14 +2449,9 @@ int bdrv_writev_vmstate(BlockDriverState *bs, QEMU=
IOVector *qiov, int64_t pos)
 int bdrv_load_vmstate(BlockDriverState *bs, uint8_t *buf,
                       int64_t pos, int size)
 {
-    QEMUIOVector qiov;
-    struct iovec iov =3D {
-        .iov_base   =3D buf,
-        .iov_len    =3D size,
-    };
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, size);
     int ret;
=20
-    qemu_iovec_init_external(&qiov, &iov, 1);
     ret =3D bdrv_readv_vmstate(bs, &qiov, pos);
     if (ret < 0) {
         return ret;
--=20
2.20.1
