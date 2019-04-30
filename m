Received: from eggs.gnu.org ([209.51.188.92]:48947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuv-00088Y-LT
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuu-0002Ai-Ez
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:37 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:37 +0200
Message-Id: <20190430154244.30083-21-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/27] block/parallels: use buffer-based io
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
 block/parallels.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 15bc97b759..2747400577 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -220,20 +220,18 @@ static int64_t allocate_clusters(BlockDriverState *=
bs, int64_t sector_num,
     if (bs->backing) {
         int64_t nb_cow_sectors =3D to_allocate * s->tracks;
         int64_t nb_cow_bytes =3D nb_cow_sectors << BDRV_SECTOR_BITS;
-        QEMUIOVector qiov =3D
-            QEMU_IOVEC_INIT_BUF(qiov, qemu_blockalign(bs, nb_cow_bytes),
-                                nb_cow_bytes);
+        void *buf =3D qemu_blockalign(bs, nb_cow_bytes);
=20
-        ret =3D bdrv_co_preadv(bs->backing, idx * s->tracks * BDRV_SECTO=
R_SIZE,
-                             nb_cow_bytes, &qiov, 0);
+        ret =3D bdrv_co_pread(bs->backing, idx * s->tracks * BDRV_SECTOR=
_SIZE,
+                            nb_cow_bytes, buf, 0);
         if (ret < 0) {
-            qemu_vfree(qemu_iovec_buf(&qiov));
+            qemu_vfree(buf);
             return ret;
         }
=20
         ret =3D bdrv_co_pwritev(bs->file, s->data_end * BDRV_SECTOR_SIZE=
,
-                              nb_cow_bytes, &qiov, 0);
-        qemu_vfree(qemu_iovec_buf(&qiov));
+                              nb_cow_bytes, buf, 0);
+        qemu_vfree(buf);
         if (ret < 0) {
             return ret;
         }
--=20
2.20.1
