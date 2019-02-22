Received: from eggs.gnu.org ([209.51.188.92]:37933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBV8-0002EJ-Rg
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBV6-0001kQ-3o
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:29 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:36 +0000
Message-Id: <20190222140756.29834-8-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/27] block/parallels: use QEMU_IOVEC_INIT_BUF
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

Use new QEMU_IOVEC_INIT_BUF() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190218140926.333779-8-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-8-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index cc9445879d..15bc97b759 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -220,23 +220,20 @@ static int64_t allocate_clusters(BlockDriverState *=
bs, int64_t sector_num,
     if (bs->backing) {
         int64_t nb_cow_sectors =3D to_allocate * s->tracks;
         int64_t nb_cow_bytes =3D nb_cow_sectors << BDRV_SECTOR_BITS;
-        QEMUIOVector qiov;
-        struct iovec iov =3D {
-            .iov_len =3D nb_cow_bytes,
-            .iov_base =3D qemu_blockalign(bs, nb_cow_bytes)
-        };
-        qemu_iovec_init_external(&qiov, &iov, 1);
+        QEMUIOVector qiov =3D
+            QEMU_IOVEC_INIT_BUF(qiov, qemu_blockalign(bs, nb_cow_bytes),
+                                nb_cow_bytes);
=20
         ret =3D bdrv_co_preadv(bs->backing, idx * s->tracks * BDRV_SECTO=
R_SIZE,
                              nb_cow_bytes, &qiov, 0);
         if (ret < 0) {
-            qemu_vfree(iov.iov_base);
+            qemu_vfree(qemu_iovec_buf(&qiov));
             return ret;
         }
=20
         ret =3D bdrv_co_pwritev(bs->file, s->data_end * BDRV_SECTOR_SIZE=
,
                               nb_cow_bytes, &qiov, 0);
-        qemu_vfree(iov.iov_base);
+        qemu_vfree(qemu_iovec_buf(&qiov));
         if (ret < 0) {
             return ret;
         }
--=20
2.20.1
