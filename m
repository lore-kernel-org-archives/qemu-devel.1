Received: from eggs.gnu.org ([2001:4830:134:3::10]:38644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4O-0006cP-Ci
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4J-0001Ld-Dr
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:56 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:04 +0200
Message-Id: <20180515154033.19899-9-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/37] block: Merge .bdrv_co_writev{,
 _flags} in drivers
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

From: Eric Blake <eblake@redhat.com>

We have too many driver callback interfaces; simplify the mess
somewhat by merging the flags parameter of .bdrv_co_writev_flags()
into .bdrv_co_writev().  Note that as long as a driver doesn't set
.supported_write_flags, the flags argument will be 0 and behavior is
identical.  Also note that the public function bdrv_co_writev() still
lacks a flags argument; so the driver signature is thus intentionally
slightly different.  But that's not the end of the world, nor the first
time that the driver interface differs slightly from the public
interface.

Ideally, we should be rewriting all of these drivers to use modern
byte-based interfaces.  But that's a more invasive patch to write
and audit, compared to the simplification done here.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |  2 --
 block/gluster.c           |  4 +++-
 block/io.c                | 13 ++++---------
 block/iscsi.c             |  8 ++++----
 block/parallels.c         |  4 +++-
 block/qcow.c              |  6 ++++--
 block/qed.c               |  3 ++-
 block/replication.c       |  4 +++-
 block/sheepdog.c          |  4 +++-
 block/ssh.c               |  4 +++-
 block/vhdx.c              |  4 +++-
 11 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0bba7ed024..e3d6219f4e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -174,8 +174,6 @@ struct BlockDriver {
     int coroutine_fn (*bdrv_co_preadv)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
     int coroutine_fn (*bdrv_co_writev)(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, QEMUIOVector *qiov);
-    int coroutine_fn (*bdrv_co_writev_flags)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, QEMUIOVector *qiov, int flag=
s);
     /**
      * @offset: position in bytes to write at
diff --git a/block/gluster.c b/block/gluster.c
index 55be566f6d..9900b6420c 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1194,8 +1194,10 @@ static coroutine_fn int qemu_gluster_co_readv(Bloc=
kDriverState *bs,
 static coroutine_fn int qemu_gluster_co_writev(BlockDriverState *bs,
                                                int64_t sector_num,
                                                int nb_sectors,
-                                               QEMUIOVector *qiov)
+                                               QEMUIOVector *qiov,
+                                               int flags)
 {
+    assert(!flags);
     return qemu_gluster_co_rw(bs, sector_num, nb_sectors, qiov, 1);
 }
=20
diff --git a/block/io.c b/block/io.c
index 6b110b207a..4fad5ac2fe 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1000,15 +1000,10 @@ static int coroutine_fn bdrv_driver_pwritev(Block=
DriverState *bs,
     assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
     assert((bytes >> BDRV_SECTOR_BITS) <=3D BDRV_REQUEST_MAX_SECTORS);
=20
-    if (drv->bdrv_co_writev_flags) {
-        ret =3D drv->bdrv_co_writev_flags(bs, sector_num, nb_sectors, qi=
ov,
-                                        flags & bs->supported_write_flag=
s);
-        flags &=3D ~bs->supported_write_flags;
-    } else {
-        assert(drv->bdrv_co_writev);
-        assert(!bs->supported_write_flags);
-        ret =3D drv->bdrv_co_writev(bs, sector_num, nb_sectors, qiov);
-    }
+    assert(drv->bdrv_co_writev);
+    ret =3D drv->bdrv_co_writev(bs, sector_num, nb_sectors, qiov,
+                              flags & bs->supported_write_flags);
+    flags &=3D ~bs->supported_write_flags;
=20
 emulate_flags:
     if (ret =3D=3D 0 && (flags & BDRV_REQ_FUA)) {
diff --git a/block/iscsi.c b/block/iscsi.c
index d19ae0e398..3fd7203916 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -556,8 +556,8 @@ static inline bool iscsi_allocmap_is_valid(IscsiLun *=
iscsilun,
 }
=20
 static int coroutine_fn
-iscsi_co_writev_flags(BlockDriverState *bs, int64_t sector_num, int nb_s=
ectors,
-                      QEMUIOVector *iov, int flags)
+iscsi_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors=
,
+                QEMUIOVector *iov, int flags)
 {
     IscsiLun *iscsilun =3D bs->opaque;
     struct IscsiTask iTask;
@@ -2220,7 +2220,7 @@ static BlockDriver bdrv_iscsi =3D {
     .bdrv_co_pdiscard      =3D iscsi_co_pdiscard,
     .bdrv_co_pwrite_zeroes =3D iscsi_co_pwrite_zeroes,
     .bdrv_co_readv         =3D iscsi_co_readv,
-    .bdrv_co_writev_flags  =3D iscsi_co_writev_flags,
+    .bdrv_co_writev        =3D iscsi_co_writev,
     .bdrv_co_flush_to_disk =3D iscsi_co_flush,
=20
 #ifdef __linux__
@@ -2255,7 +2255,7 @@ static BlockDriver bdrv_iser =3D {
     .bdrv_co_pdiscard      =3D iscsi_co_pdiscard,
     .bdrv_co_pwrite_zeroes =3D iscsi_co_pwrite_zeroes,
     .bdrv_co_readv         =3D iscsi_co_readv,
-    .bdrv_co_writev_flags  =3D iscsi_co_writev_flags,
+    .bdrv_co_writev        =3D iscsi_co_writev,
     .bdrv_co_flush_to_disk =3D iscsi_co_flush,
=20
 #ifdef __linux__
diff --git a/block/parallels.c b/block/parallels.c
index 045810d00f..6e9c37f44e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -311,13 +311,15 @@ static int coroutine_fn parallels_co_block_status(B=
lockDriverState *bs,
 }
=20
 static coroutine_fn int parallels_co_writev(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, QEMUIOVector *qiov)
+                                            int64_t sector_num, int nb_s=
ectors,
+                                            QEMUIOVector *qiov, int flag=
s)
 {
     BDRVParallelsState *s =3D bs->opaque;
     uint64_t bytes_done =3D 0;
     QEMUIOVector hd_qiov;
     int ret =3D 0;
=20
+    assert(!flags);
     qemu_iovec_init(&hd_qiov, qiov->niov);
=20
     while (nb_sectors > 0) {
diff --git a/block/qcow.c b/block/qcow.c
index 4b2f7db74c..3ba2ca25ea 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -720,7 +720,8 @@ static coroutine_fn int qcow_co_readv(BlockDriverStat=
e *bs, int64_t sector_num,
 }
=20
 static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sec=
tor_num,
-                          int nb_sectors, QEMUIOVector *qiov)
+                                       int nb_sectors, QEMUIOVector *qio=
v,
+                                       int flags)
 {
     BDRVQcowState *s =3D bs->opaque;
     int index_in_cluster;
@@ -731,6 +732,7 @@ static coroutine_fn int qcow_co_writev(BlockDriverSta=
te *bs, int64_t sector_num,
     uint8_t *buf;
     void *orig_buf;
=20
+    assert(!flags);
     s->cluster_cache_offset =3D -1; /* disable compressed cache */
=20
     /* We must always copy the iov when encrypting, so we
@@ -1110,7 +1112,7 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, ui=
nt64_t offset,
     if (ret !=3D Z_STREAM_END || out_len >=3D s->cluster_size) {
         /* could not compress: write normal cluster */
         ret =3D qcow_co_writev(bs, offset >> BDRV_SECTOR_BITS,
-                             bytes >> BDRV_SECTOR_BITS, qiov);
+                             bytes >> BDRV_SECTOR_BITS, qiov, 0);
         if (ret < 0) {
             goto fail;
         }
diff --git a/block/qed.c b/block/qed.c
index 1db8eaf241..65cfe92393 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1437,8 +1437,9 @@ static int coroutine_fn bdrv_qed_co_readv(BlockDriv=
erState *bs,
=20
 static int coroutine_fn bdrv_qed_co_writev(BlockDriverState *bs,
                                            int64_t sector_num, int nb_se=
ctors,
-                                           QEMUIOVector *qiov)
+                                           QEMUIOVector *qiov, int flags=
)
 {
+    assert(!flags);
     return qed_co_request(bs, sector_num, qiov, nb_sectors, QED_AIOCB_WR=
ITE);
 }
=20
diff --git a/block/replication.c b/block/replication.c
index 6c0c7186d9..48148b884a 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -260,7 +260,8 @@ out:
 static coroutine_fn int replication_co_writev(BlockDriverState *bs,
                                               int64_t sector_num,
                                               int remaining_sectors,
-                                              QEMUIOVector *qiov)
+                                              QEMUIOVector *qiov,
+                                              int flags)
 {
     BDRVReplicationState *s =3D bs->opaque;
     QEMUIOVector hd_qiov;
@@ -271,6 +272,7 @@ static coroutine_fn int replication_co_writev(BlockDr=
iverState *bs,
     int ret;
     int64_t n;
=20
+    assert(!flags);
     ret =3D replication_get_io_status(s);
     if (ret < 0) {
         goto out;
diff --git a/block/sheepdog.c b/block/sheepdog.c
index fed2a04797..4237132419 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2614,13 +2614,15 @@ static void sd_aio_complete(SheepdogAIOCB *acb)
 }
=20
 static coroutine_fn int sd_co_writev(BlockDriverState *bs, int64_t secto=
r_num,
-                        int nb_sectors, QEMUIOVector *qiov)
+                                     int nb_sectors, QEMUIOVector *qiov,
+                                     int flags)
 {
     SheepdogAIOCB acb;
     int ret;
     int64_t offset =3D (sector_num + nb_sectors) * BDRV_SECTOR_SIZE;
     BDRVSheepdogState *s =3D bs->opaque;
=20
+    assert(!flags);
     if (offset > s->inode.vdi_size) {
         ret =3D sd_truncate(bs, offset, PREALLOC_MODE_OFF, NULL);
         if (ret < 0) {
diff --git a/block/ssh.c b/block/ssh.c
index 412a1bfc17..4c4fa3ccfc 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1164,11 +1164,13 @@ static int ssh_write(BDRVSSHState *s, BlockDriver=
State *bs,
=20
 static coroutine_fn int ssh_co_writev(BlockDriverState *bs,
                                       int64_t sector_num,
-                                      int nb_sectors, QEMUIOVector *qiov=
)
+                                      int nb_sectors, QEMUIOVector *qiov=
,
+                                      int flags)
 {
     BDRVSSHState *s =3D bs->opaque;
     int ret;
=20
+    assert(!flags);
     qemu_co_mutex_lock(&s->lock);
     ret =3D ssh_write(s, bs, sector_num * BDRV_SECTOR_SIZE,
                     nb_sectors * BDRV_SECTOR_SIZE, qiov);
diff --git a/block/vhdx.c b/block/vhdx.c
index c3a4220a35..0b1e21c750 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1226,7 +1226,8 @@ int vhdx_user_visible_write(BlockDriverState *bs, B=
DRVVHDXState *s)
 }
=20
 static coroutine_fn int vhdx_co_writev(BlockDriverState *bs, int64_t sec=
tor_num,
-                                      int nb_sectors, QEMUIOVector *qiov=
)
+                                       int nb_sectors, QEMUIOVector *qio=
v,
+                                       int flags)
 {
     int ret =3D -ENOTSUP;
     BDRVVHDXState *s =3D bs->opaque;
@@ -1242,6 +1243,7 @@ static coroutine_fn int vhdx_co_writev(BlockDriverS=
tate *bs, int64_t sector_num,
     uint64_t bat_prior_offset =3D 0;
     bool bat_update =3D false;
=20
+    assert(!flags);
     qemu_iovec_init(&hd_qiov, qiov->niov);
=20
     qemu_co_mutex_lock(&s->lock);
--=20
2.13.6
