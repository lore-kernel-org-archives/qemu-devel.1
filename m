Received: from eggs.gnu.org ([209.51.188.92]:51133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP6-0000nr-Kq
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP4-00038Q-NA
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 22 Apr 2019 17:58:38 +0300
Message-Id: <20190422145838.70903-10-vsementsov@virtuozzo.com>
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 9/9] qemu-img: use buffer-based io
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
 qemu-img.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index aa6f81f1ea..c40a4e8b83 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1671,7 +1671,6 @@ static int coroutine_fn convert_co_read(ImgConvertState *s, int64_t sector_num,
                                         int nb_sectors, uint8_t *buf)
 {
     int n, ret;
-    QEMUIOVector qiov;
 
     assert(nb_sectors <= s->buf_sectors);
     while (nb_sectors > 0) {
@@ -1687,11 +1686,10 @@ static int coroutine_fn convert_co_read(ImgConvertState *s, int64_t sector_num,
         bs_sectors = s->src_sectors[src_cur];
 
         n = MIN(nb_sectors, bs_sectors - (sector_num - src_cur_offset));
-        qemu_iovec_init_buf(&qiov, buf, n << BDRV_SECTOR_BITS);
 
-        ret = blk_co_preadv(
+        ret = blk_co_pread(
                 blk, (sector_num - src_cur_offset) << BDRV_SECTOR_BITS,
-                n << BDRV_SECTOR_BITS, &qiov, 0);
+                n << BDRV_SECTOR_BITS, buf, 0);
         if (ret < 0) {
             return ret;
         }
@@ -1710,7 +1708,6 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
                                          enum ImgConvertBlockStatus status)
 {
     int ret;
-    QEMUIOVector qiov;
 
     while (nb_sectors > 0) {
         int n = nb_sectors;
@@ -1738,10 +1735,8 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
                 (s->compressed &&
                  !buffer_is_zero(buf, n * BDRV_SECTOR_SIZE)))
             {
-                qemu_iovec_init_buf(&qiov, buf, n << BDRV_SECTOR_BITS);
-
-                ret = blk_co_pwritev(s->target, sector_num << BDRV_SECTOR_BITS,
-                                     n << BDRV_SECTOR_BITS, &qiov, flags);
+                ret = blk_co_pwrite(s->target, sector_num << BDRV_SECTOR_BITS,
+                                    n << BDRV_SECTOR_BITS, buf, flags);
                 if (ret < 0) {
                     return ret;
                 }
-- 
2.18.0
