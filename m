Received: from eggs.gnu.org ([209.51.188.92]:48905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuu-00086l-E8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUus-00029A-HP
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:34 +0200
Message-Id: <20190430154244.30083-18-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/27] block/qcow2: use buffer-based io
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
 block/qcow2.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c5c17734d7..a520d116ef 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4094,7 +4094,6 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, u=
int64_t offset,
                             uint64_t bytes, QEMUIOVector *qiov)
 {
     BDRVQcow2State *s =3D bs->opaque;
-    QEMUIOVector hd_qiov;
     int ret;
     ssize_t out_len;
     uint8_t *buf, *out_buf;
@@ -4161,10 +4160,8 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, =
uint64_t offset,
         goto fail;
     }
=20
-    qemu_iovec_init_buf(&hd_qiov, out_buf, out_len);
-
     BLKDBG_EVENT(s->data_file, BLKDBG_WRITE_COMPRESSED);
-    ret =3D bdrv_co_pwritev(s->data_file, cluster_offset, out_len, &hd_q=
iov, 0);
+    ret =3D bdrv_co_pwrite(s->data_file, cluster_offset, out_len, out_bu=
f, 0);
     if (ret < 0) {
         goto fail;
     }
@@ -4187,7 +4184,6 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
     int ret =3D 0, csize, nb_csectors;
     uint64_t coffset;
     uint8_t *buf, *out_buf;
-    QEMUIOVector local_qiov;
     int offset_in_cluster =3D offset_into_cluster(s, offset);
=20
     coffset =3D file_cluster_offset & s->cluster_offset_mask;
@@ -4198,12 +4194,11 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
     if (!buf) {
         return -ENOMEM;
     }
-    qemu_iovec_init_buf(&local_qiov, buf, csize);
=20
     out_buf =3D qemu_blockalign(bs, s->cluster_size);
=20
     BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
-    ret =3D bdrv_co_preadv(bs->file, coffset, csize, &local_qiov, 0);
+    ret =3D bdrv_co_pread(bs->file, coffset, csize, buf, 0);
     if (ret < 0) {
         goto fail;
     }
--=20
2.20.1
