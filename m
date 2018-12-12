Received: from eggs.gnu.org ([2001:4830:134:3::10]:46110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yb-0002R7-I3
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Ya-00014M-Fr
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:09 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:05 +0100
Message-Id: <20181212132735.16080-12-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/41] qcow2: use byte-based read in
 qcow2_decompress_cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Get rid of it here too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ac9bb3a225..d4b25d88b5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3957,17 +3957,19 @@ fail:
     return ret;
 }
=20
-int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offs=
et)
+int coroutine_fn
+qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
 {
     BDRVQcow2State *s =3D bs->opaque;
-    int ret, csize, nb_csectors, sector_offset;
+    int ret, csize, nb_csectors;
     uint64_t coffset;
+    struct iovec iov;
+    QEMUIOVector local_qiov;
=20
     coffset =3D cluster_offset & s->cluster_offset_mask;
     if (s->cluster_cache_offset !=3D coffset) {
         nb_csectors =3D ((cluster_offset >> s->csize_shift) & s->csize_m=
ask) + 1;
-        sector_offset =3D coffset & 511;
-        csize =3D nb_csectors * 512 - sector_offset;
+        csize =3D nb_csectors * 512 - (coffset & 511);
=20
         /* Allocate buffers on first decompress operation, most images a=
re
          * uncompressed and the memory overhead can be avoided.  The buf=
fers
@@ -3985,14 +3987,17 @@ int qcow2_decompress_cluster(BlockDriverState *bs=
, uint64_t cluster_offset)
             s->cluster_cache =3D g_malloc(s->cluster_size);
         }
=20
+        iov.iov_base =3D s->cluster_data;
+        iov.iov_len =3D csize;
+        qemu_iovec_init_external(&local_qiov, &iov, 1);
+
         BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
-        ret =3D bdrv_read(bs->file, coffset >> 9, s->cluster_data,
-                        nb_csectors);
+        ret =3D bdrv_co_preadv(bs->file, coffset, csize, &local_qiov, 0)=
;
         if (ret < 0) {
             return ret;
         }
         if (qcow2_decompress(s->cluster_cache, s->cluster_size,
-                             s->cluster_data + sector_offset, csize) < 0=
) {
+                             s->cluster_data, csize) < 0) {
             return -EIO;
         }
         s->cluster_cache_offset =3D coffset;
--=20
2.19.2
