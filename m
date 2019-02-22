Received: from eggs.gnu.org ([209.51.188.92]:38205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVg-0002lP-IO
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVf-0002Md-Ir
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:09:04 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:41 +0000
Message-Id: <20190222140756.29834-13-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/27] qemu-img: use qemu_iovec_init_buf
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
Message-id: 20190218140926.333779-13-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-13-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-img.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 25288c4d18..7853935049 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1670,7 +1670,6 @@ static int coroutine_fn convert_co_read(ImgConvertS=
tate *s, int64_t sector_num,
 {
     int n, ret;
     QEMUIOVector qiov;
-    struct iovec iov;
=20
     assert(nb_sectors <=3D s->buf_sectors);
     while (nb_sectors > 0) {
@@ -1686,9 +1685,7 @@ static int coroutine_fn convert_co_read(ImgConvertS=
tate *s, int64_t sector_num,
         bs_sectors =3D s->src_sectors[src_cur];
=20
         n =3D MIN(nb_sectors, bs_sectors - (sector_num - src_cur_offset)=
);
-        iov.iov_base =3D buf;
-        iov.iov_len =3D n << BDRV_SECTOR_BITS;
-        qemu_iovec_init_external(&qiov, &iov, 1);
+        qemu_iovec_init_buf(&qiov, buf, n << BDRV_SECTOR_BITS);
=20
         ret =3D blk_co_preadv(
                 blk, (sector_num - src_cur_offset) << BDRV_SECTOR_BITS,
@@ -1712,7 +1709,6 @@ static int coroutine_fn convert_co_write(ImgConvert=
State *s, int64_t sector_num,
 {
     int ret;
     QEMUIOVector qiov;
-    struct iovec iov;
=20
     while (nb_sectors > 0) {
         int n =3D nb_sectors;
@@ -1740,9 +1736,7 @@ static int coroutine_fn convert_co_write(ImgConvert=
State *s, int64_t sector_num,
                 (s->compressed &&
                  !buffer_is_zero(buf, n * BDRV_SECTOR_SIZE)))
             {
-                iov.iov_base =3D buf;
-                iov.iov_len =3D n << BDRV_SECTOR_BITS;
-                qemu_iovec_init_external(&qiov, &iov, 1);
+                qemu_iovec_init_buf(&qiov, buf, n << BDRV_SECTOR_BITS);
=20
                 ret =3D blk_co_pwritev(s->target, sector_num << BDRV_SEC=
TOR_BITS,
                                      n << BDRV_SECTOR_BITS, &qiov, flags=
);
--=20
2.20.1
