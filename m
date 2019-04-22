Received: from eggs.gnu.org ([209.51.188.92]:51083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP5-0000nk-Mo
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP4-000389-Le
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:43 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 22 Apr 2019 17:58:34 +0300
Message-Id: <20190422145838.70903-6-vsementsov@virtuozzo.com>
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 5/9] block/parallels: use buffer-based io
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
 block/parallels.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 15bc97b759..2747400577 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -220,20 +220,18 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
     if (bs->backing) {
         int64_t nb_cow_sectors = to_allocate * s->tracks;
         int64_t nb_cow_bytes = nb_cow_sectors << BDRV_SECTOR_BITS;
-        QEMUIOVector qiov =
-            QEMU_IOVEC_INIT_BUF(qiov, qemu_blockalign(bs, nb_cow_bytes),
-                                nb_cow_bytes);
+        void *buf = qemu_blockalign(bs, nb_cow_bytes);
 
-        ret = bdrv_co_preadv(bs->backing, idx * s->tracks * BDRV_SECTOR_SIZE,
-                             nb_cow_bytes, &qiov, 0);
+        ret = bdrv_co_pread(bs->backing, idx * s->tracks * BDRV_SECTOR_SIZE,
+                            nb_cow_bytes, buf, 0);
         if (ret < 0) {
-            qemu_vfree(qemu_iovec_buf(&qiov));
+            qemu_vfree(buf);
             return ret;
         }
 
         ret = bdrv_co_pwritev(bs->file, s->data_end * BDRV_SECTOR_SIZE,
-                              nb_cow_bytes, &qiov, 0);
-        qemu_vfree(qemu_iovec_buf(&qiov));
+                              nb_cow_bytes, buf, 0);
+        qemu_vfree(buf);
         if (ret < 0) {
             return ret;
         }
-- 
2.18.0
