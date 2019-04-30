Received: from eggs.gnu.org ([209.51.188.92]:49091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUv1-0008Cw-98
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUv0-0002F1-AQ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:43 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:41 +0200
Message-Id: <20190430154244.30083-25-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/27] qemu-img: use buffer-based io
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
 qemu-img.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ddd55ab291..e6ad5978e0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1680,7 +1680,6 @@ static int coroutine_fn convert_co_read(ImgConvertS=
tate *s, int64_t sector_num,
                                         int nb_sectors, uint8_t *buf)
 {
     int n, ret;
-    QEMUIOVector qiov;
=20
     assert(nb_sectors <=3D s->buf_sectors);
     while (nb_sectors > 0) {
@@ -1696,11 +1695,10 @@ static int coroutine_fn convert_co_read(ImgConver=
tState *s, int64_t sector_num,
         bs_sectors =3D s->src_sectors[src_cur];
=20
         n =3D MIN(nb_sectors, bs_sectors - (sector_num - src_cur_offset)=
);
-        qemu_iovec_init_buf(&qiov, buf, n << BDRV_SECTOR_BITS);
=20
-        ret =3D blk_co_preadv(
+        ret =3D blk_co_pread(
                 blk, (sector_num - src_cur_offset) << BDRV_SECTOR_BITS,
-                n << BDRV_SECTOR_BITS, &qiov, 0);
+                n << BDRV_SECTOR_BITS, buf, 0);
         if (ret < 0) {
             return ret;
         }
@@ -1719,7 +1717,6 @@ static int coroutine_fn convert_co_write(ImgConvert=
State *s, int64_t sector_num,
                                          enum ImgConvertBlockStatus stat=
us)
 {
     int ret;
-    QEMUIOVector qiov;
=20
     while (nb_sectors > 0) {
         int n =3D nb_sectors;
@@ -1747,10 +1744,8 @@ static int coroutine_fn convert_co_write(ImgConver=
tState *s, int64_t sector_num,
                 (s->compressed &&
                  !buffer_is_zero(buf, n * BDRV_SECTOR_SIZE)))
             {
-                qemu_iovec_init_buf(&qiov, buf, n << BDRV_SECTOR_BITS);
-
-                ret =3D blk_co_pwritev(s->target, sector_num << BDRV_SEC=
TOR_BITS,
-                                     n << BDRV_SECTOR_BITS, &qiov, flags=
);
+                ret =3D blk_co_pwrite(s->target, sector_num << BDRV_SECT=
OR_BITS,
+                                    n << BDRV_SECTOR_BITS, buf, flags);
                 if (ret < 0) {
                     return ret;
                 }
--=20
2.20.1
