Received: from eggs.gnu.org ([209.51.188.92]:36640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgrb-0002iS-8l
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgra-0001jN-13
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:24:59 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Feb 2019 13:24:40 +0300
Message-Id: <20190207102445.71998-13-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 12/17] qemu-img: use qemu_iovec_init_buf
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
 qemu-img.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 25288c4d18..7853935049 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1670,7 +1670,6 @@ static int coroutine_fn convert_co_read(ImgConvertState *s, int64_t sector_num,
 {
     int n, ret;
     QEMUIOVector qiov;
-    struct iovec iov;
 
     assert(nb_sectors <= s->buf_sectors);
     while (nb_sectors > 0) {
@@ -1686,9 +1685,7 @@ static int coroutine_fn convert_co_read(ImgConvertState *s, int64_t sector_num,
         bs_sectors = s->src_sectors[src_cur];
 
         n = MIN(nb_sectors, bs_sectors - (sector_num - src_cur_offset));
-        iov.iov_base = buf;
-        iov.iov_len = n << BDRV_SECTOR_BITS;
-        qemu_iovec_init_external(&qiov, &iov, 1);
+        qemu_iovec_init_buf(&qiov, buf, n << BDRV_SECTOR_BITS);
 
         ret = blk_co_preadv(
                 blk, (sector_num - src_cur_offset) << BDRV_SECTOR_BITS,
@@ -1712,7 +1709,6 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
 {
     int ret;
     QEMUIOVector qiov;
-    struct iovec iov;
 
     while (nb_sectors > 0) {
         int n = nb_sectors;
@@ -1740,9 +1736,7 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
                 (s->compressed &&
                  !buffer_is_zero(buf, n * BDRV_SECTOR_SIZE)))
             {
-                iov.iov_base = buf;
-                iov.iov_len = n << BDRV_SECTOR_BITS;
-                qemu_iovec_init_external(&qiov, &iov, 1);
+                qemu_iovec_init_buf(&qiov, buf, n << BDRV_SECTOR_BITS);
 
                 ret = blk_co_pwritev(s->target, sector_num << BDRV_SECTOR_BITS,
                                      n << BDRV_SECTOR_BITS, &qiov, flags);
-- 
2.18.0
