Received: from eggs.gnu.org ([209.51.188.92]:60908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvjc3-0004bi-5V
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:09:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvjc2-00075g-0N
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:09:39 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Feb 2019 17:09:16 +0300
Message-Id: <20190218140926.333779-8-vsementsov@virtuozzo.com>
In-Reply-To: <20190218140926.333779-1-vsementsov@virtuozzo.com>
References: <20190218140926.333779-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 07/17] block/parallels: use
 QEMU_IOVEC_INIT_BUF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com

Use new QEMU_IOVEC_INIT_BUF() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index cc9445879d..15bc97b759 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -220,23 +220,20 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
     if (bs->backing) {
         int64_t nb_cow_sectors = to_allocate * s->tracks;
         int64_t nb_cow_bytes = nb_cow_sectors << BDRV_SECTOR_BITS;
-        QEMUIOVector qiov;
-        struct iovec iov = {
-            .iov_len = nb_cow_bytes,
-            .iov_base = qemu_blockalign(bs, nb_cow_bytes)
-        };
-        qemu_iovec_init_external(&qiov, &iov, 1);
+        QEMUIOVector qiov =
+            QEMU_IOVEC_INIT_BUF(qiov, qemu_blockalign(bs, nb_cow_bytes),
+                                nb_cow_bytes);
 
         ret = bdrv_co_preadv(bs->backing, idx * s->tracks * BDRV_SECTOR_SIZE,
                              nb_cow_bytes, &qiov, 0);
         if (ret < 0) {
-            qemu_vfree(iov.iov_base);
+            qemu_vfree(qemu_iovec_buf(&qiov));
             return ret;
         }
 
         ret = bdrv_co_pwritev(bs->file, s->data_end * BDRV_SECTOR_SIZE,
                               nb_cow_bytes, &qiov, 0);
-        qemu_vfree(iov.iov_base);
+        qemu_vfree(qemu_iovec_buf(&qiov));
         if (ret < 0) {
             return ret;
         }
-- 
2.18.0
