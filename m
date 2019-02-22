Received: from eggs.gnu.org ([209.51.188.92]:38023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVF-0002OE-St
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVC-0001sq-1W
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:38 +0000
Message-Id: <20190222140756.29834-10-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/27] block/qcow2: use qemu_iovec_init_buf
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
Message-id: 20190218140926.333779-10-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-10-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qcow2.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 65a54c9ac6..b6d475229e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3894,7 +3894,6 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, u=
int64_t offset,
 {
     BDRVQcow2State *s =3D bs->opaque;
     QEMUIOVector hd_qiov;
-    struct iovec iov;
     int ret;
     size_t out_len;
     uint8_t *buf, *out_buf;
@@ -3960,11 +3959,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, =
uint64_t offset,
         goto fail;
     }
=20
-    iov =3D (struct iovec) {
-        .iov_base   =3D out_buf,
-        .iov_len    =3D out_len,
-    };
-    qemu_iovec_init_external(&hd_qiov, &iov, 1);
+    qemu_iovec_init_buf(&hd_qiov, out_buf, out_len);
=20
     BLKDBG_EVENT(bs->file, BLKDBG_WRITE_COMPRESSED);
     ret =3D bdrv_co_pwritev(bs->file, cluster_offset, out_len, &hd_qiov,=
 0);
@@ -3990,7 +3985,6 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
     int ret =3D 0, csize, nb_csectors;
     uint64_t coffset;
     uint8_t *buf, *out_buf;
-    struct iovec iov;
     QEMUIOVector local_qiov;
     int offset_in_cluster =3D offset_into_cluster(s, offset);
=20
@@ -4002,9 +3996,7 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
     if (!buf) {
         return -ENOMEM;
     }
-    iov.iov_base =3D buf;
-    iov.iov_len =3D csize;
-    qemu_iovec_init_external(&local_qiov, &iov, 1);
+    qemu_iovec_init_buf(&local_qiov, buf, csize);
=20
     out_buf =3D qemu_blockalign(bs, s->cluster_size);
=20
--=20
2.20.1
