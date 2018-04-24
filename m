Received: from eggs.gnu.org ([2001:4830:134:3::10]:36804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB60x-0003Ur-3Z
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB60v-0005bI-Kl
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:02:19 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 24 Apr 2018 17:01:57 -0500
Message-Id: <20180424220157.177385-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Merge .bdrv_co_writev{,
 _flags} in drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, "Denis V. Lunev" <den@openvz.org>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>, "open list:GLUSTER" <qemu-block@nongnu.org>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>

We have too many driver callback interfaces; simplify the mess
somewhat by merging the flags parameter of .bdrv_co_writev_flags()
into .bdrv_co_writev_flags().  Note that as long as a driver doesn't
set .supported_write_flags, the flags argument will be 0 and behavior
is identical.  Also note that the public function bdrv_co_writev()
still lacks a flags argument; so the driver signature is thus
intentionally slightly different.  But that's not the end of the
world, nor the first time that the driver interface differs slightly
from the public interface.

Ideally, we should be rewriting all of these drivers to use modern
byte-based interfaces.  But that's a more invasive patch to write
and audit, compared to the simplification done here.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

Based-on: <20180424192506.149089-1-eblake@redhat.com>
([PATCH v2 0/6] block: byte-based AIO read/write)

 include/block/block_int.h |  2 --
 block/io.c                | 13 ++++---------
 block/gluster.c           |  4 +++-
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
index 0bba7ed024a..e3d6219f4e3 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -174,8 +174,6 @@ struct BlockDriver {
     int coroutine_fn (*bdrv_co_preadv)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
     int coroutine_fn (*bdrv_co_writev)(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, QEMUIOVector *qiov);
-    int coroutine_fn (*bdrv_co_writev_flags)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, QEMUIOVector *qiov, int flags);
     /**
      * @offset: position in bytes to write at
diff --git a/block/io.c b/block/io.c
index 6b110b207a0..4fad5ac2fef 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1000,15 +1000,10 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
     assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
     assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);

-    if (drv->bdrv_co_writev_flags) {
-        ret = drv->bdrv_co_writev_flags(bs, sector_num, nb_sectors, qiov,
-                                        flags & bs->supported_write_flags);
-        flags &= ~bs->supported_write_flags;
-    } else {
-        assert(drv->bdrv_co_writev);
-        assert(!bs->supported_write_flags);
-        ret = drv->bdrv_co_writev(bs, sector_num, nb_sectors, qiov);
-    }
+    assert(drv->bdrv_co_writev);
+    ret = drv->bdrv_co_writev(bs, sector_num, nb_sectors, qiov,
+                              flags & bs->supported_write_flags);
+    flags &= ~bs->supported_write_flags;

 emulate_flags:
     if (ret == 0 && (flags & BDRV_REQ_FUA)) {
diff --git a/block/gluster.c b/block/gluster.c
index 4adc1a875b1..15e7d7fc351 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1194,8 +1194,10 @@ static coroutine_fn int qemu_gluster_co_readv(BlockDriverState *bs,
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

diff --git a/block/iscsi.c b/block/iscsi.c
index f5aecfc8834..35423ded03b 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -556,8 +556,8 @@ static inline bool iscsi_allocmap_is_valid(IscsiLun *iscsilun,
 }

 static int coroutine_fn
-iscsi_co_writev_flags(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
-                      QEMUIOVector *iov, int flags)
+iscsi_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
+                QEMUIOVector *iov, int flags)
 {
     IscsiLun *iscsilun = bs->opaque;
     struct IscsiTask iTask;
@@ -2220,7 +2220,7 @@ static BlockDriver bdrv_iscsi = {
     .bdrv_co_pdiscard      = iscsi_co_pdiscard,
     .bdrv_co_pwrite_zeroes = iscsi_co_pwrite_zeroes,
     .bdrv_co_readv         = iscsi_co_readv,
-    .bdrv_co_writev_flags  = iscsi_co_writev_flags,
+    .bdrv_co_writev        = iscsi_co_writev,
     .bdrv_co_flush_to_disk = iscsi_co_flush,

 #ifdef __linux__
@@ -2255,7 +2255,7 @@ static BlockDriver bdrv_iser = {
     .bdrv_co_pdiscard      = iscsi_co_pdiscard,
     .bdrv_co_pwrite_zeroes = iscsi_co_pwrite_zeroes,
     .bdrv_co_readv         = iscsi_co_readv,
-    .bdrv_co_writev_flags  = iscsi_co_writev_flags,
+    .bdrv_co_writev        = iscsi_co_writev,
     .bdrv_co_flush_to_disk = iscsi_co_flush,

 #ifdef __linux__
diff --git a/block/parallels.c b/block/parallels.c
index 799215e079f..3f74fcb877a 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -311,13 +311,15 @@ static int coroutine_fn parallels_co_block_status(BlockDriverState *bs,
 }

 static coroutine_fn int parallels_co_writev(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, QEMUIOVector *qiov)
+                                            int64_t sector_num, int nb_sectors,
+                                            QEMUIOVector *qiov, int flags)
 {
     BDRVParallelsState *s = bs->opaque;
     uint64_t bytes_done = 0;
     QEMUIOVector hd_qiov;
     int ret = 0;

+    assert(!flags);
     qemu_iovec_init(&hd_qiov, qiov->niov);

     while (nb_sectors > 0) {
diff --git a/block/qcow.c b/block/qcow.c
index f92891676c9..dd042b8ddbe 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -720,7 +720,8 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
 }

 static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
-                          int nb_sectors, QEMUIOVector *qiov)
+                                       int nb_sectors, QEMUIOVector *qiov,
+                                       int flags)
 {
     BDRVQcowState *s = bs->opaque;
     int index_in_cluster;
@@ -731,6 +732,7 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
     uint8_t *buf;
     void *orig_buf;

+    assert(!flags);
     s->cluster_cache_offset = -1; /* disable compressed cache */

     /* We must always copy the iov when encrypting, so we
@@ -1110,7 +1112,7 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     if (ret != Z_STREAM_END || out_len >= s->cluster_size) {
         /* could not compress: write normal cluster */
         ret = qcow_co_writev(bs, offset >> BDRV_SECTOR_BITS,
-                             bytes >> BDRV_SECTOR_BITS, qiov);
+                             bytes >> BDRV_SECTOR_BITS, qiov, 0);
         if (ret < 0) {
             goto fail;
         }
diff --git a/block/qed.c b/block/qed.c
index 35ff505066f..a3600bd2d07 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1437,8 +1437,9 @@ static int coroutine_fn bdrv_qed_co_readv(BlockDriverState *bs,

 static int coroutine_fn bdrv_qed_co_writev(BlockDriverState *bs,
                                            int64_t sector_num, int nb_sectors,
-                                           QEMUIOVector *qiov)
+                                           QEMUIOVector *qiov, int flags)
 {
+    assert(!flags);
     return qed_co_request(bs, sector_num, qiov, nb_sectors, QED_AIOCB_WRITE);
 }

diff --git a/block/replication.c b/block/replication.c
index 6c0c7186d9a..48148b884a5 100644
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
     BDRVReplicationState *s = bs->opaque;
     QEMUIOVector hd_qiov;
@@ -271,6 +272,7 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,
     int ret;
     int64_t n;

+    assert(!flags);
     ret = replication_get_io_status(s);
     if (ret < 0) {
         goto out;
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 387f59c8aa5..a2f26efc0e2 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2612,13 +2612,15 @@ static void sd_aio_complete(SheepdogAIOCB *acb)
 }

 static coroutine_fn int sd_co_writev(BlockDriverState *bs, int64_t sector_num,
-                        int nb_sectors, QEMUIOVector *qiov)
+                                     int nb_sectors, QEMUIOVector *qiov,
+                                     int flags)
 {
     SheepdogAIOCB acb;
     int ret;
     int64_t offset = (sector_num + nb_sectors) * BDRV_SECTOR_SIZE;
     BDRVSheepdogState *s = bs->opaque;

+    assert(!flags);
     if (offset > s->inode.vdi_size) {
         ret = sd_truncate(bs, offset, PREALLOC_MODE_OFF, NULL);
         if (ret < 0) {
diff --git a/block/ssh.c b/block/ssh.c
index ab3acf0c228..e8ad3d4c46a 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1164,11 +1164,13 @@ static int ssh_write(BDRVSSHState *s, BlockDriverState *bs,

 static coroutine_fn int ssh_co_writev(BlockDriverState *bs,
                                       int64_t sector_num,
-                                      int nb_sectors, QEMUIOVector *qiov)
+                                      int nb_sectors, QEMUIOVector *qiov,
+                                      int flags)
 {
     BDRVSSHState *s = bs->opaque;
     int ret;

+    assert(!flags);
     qemu_co_mutex_lock(&s->lock);
     ret = ssh_write(s, bs, sector_num * BDRV_SECTOR_SIZE,
                     nb_sectors * BDRV_SECTOR_SIZE, qiov);
diff --git a/block/vhdx.c b/block/vhdx.c
index 6ac0424f61a..0b72d895db4 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1226,7 +1226,8 @@ int vhdx_user_visible_write(BlockDriverState *bs, BDRVVHDXState *s)
 }

 static coroutine_fn int vhdx_co_writev(BlockDriverState *bs, int64_t sector_num,
-                                      int nb_sectors, QEMUIOVector *qiov)
+                                       int nb_sectors, QEMUIOVector *qiov,
+                                       int flags)
 {
     int ret = -ENOTSUP;
     BDRVVHDXState *s = bs->opaque;
@@ -1242,6 +1243,7 @@ static coroutine_fn int vhdx_co_writev(BlockDriverState *bs, int64_t sector_num,
     uint64_t bat_prior_offset = 0;
     bool bat_update = false;

+    assert(!flags);
     qemu_iovec_init(&hd_qiov, qiov->niov);

     qemu_co_mutex_lock(&s->lock);
-- 
2.14.3
