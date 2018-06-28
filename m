Received: from eggs.gnu.org ([2001:4830:134:3::10]:41037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYdKN-0007yz-7s
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYdKK-0007eL-6w
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:15:39 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 28 Jun 2018 15:15:22 -0500
Message-Id: <20180628201525.281787-6-eblake@redhat.com>
In-Reply-To: <20180628201525.281787-1-eblake@redhat.com>
References: <20180628201525.281787-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/8] qcow: Switch to a byte-based driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

We are gradually moving away from sector-based interfaces, towards
byte-based.  The qcow driver is now ready to fully utilize the
byte-based callback interface, as long as we override the default
alignment to still be 512 (needed at least for asserts present
because of encryption, but easier to do everywhere than to audit
which sub-sector requests are handled correctly, especially since
we no longer recommend qcow for new disk images).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>

---
v2: minor rebase to changes earlier in series
---
 block/qcow.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index d2af7b8e025..fd3fafb9903 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -70,7 +70,6 @@ typedef struct QCowHeader {
 typedef struct BDRVQcowState {
     int cluster_bits;
     int cluster_size;
-    int cluster_sectors;
     int l2_bits;
     int l2_size;
     unsigned int l1_size;
@@ -236,7 +235,6 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     }
     s->cluster_bits = header.cluster_bits;
     s->cluster_size = 1 << s->cluster_bits;
-    s->cluster_sectors = 1 << (s->cluster_bits - 9);
     s->l2_bits = header.l2_bits;
     s->l2_size = 1 << s->l2_bits;
     bs->total_sectors = header.size / 512;
@@ -614,8 +612,18 @@ static int decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
     return 0;
 }

-static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
-                         int nb_sectors, QEMUIOVector *qiov)
+static void qcow_refresh_limits(BlockDriverState *bs, Error **errp)
+{
+    /* At least encrypted images require 512-byte alignment. Apply the
+     * limit universally, rather than just on encrypted images, as
+     * it's easier to let the block layer handle rounding than to
+     * audit this code further. */
+    bs->bl.request_alignment = BDRV_SECTOR_SIZE;
+}
+
+static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, uint64_t offset,
+                                       uint64_t bytes, QEMUIOVector *qiov,
+                                       int flags)
 {
     BDRVQcowState *s = bs->opaque;
     int offset_in_cluster;
@@ -625,9 +633,8 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
     QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
-    int64_t offset = sector_num * BDRV_SECTOR_SIZE;
-    int64_t bytes = nb_sectors * BDRV_SECTOR_SIZE;

+    assert(!flags);
     if (qiov->niov > 1) {
         buf = orig_buf = qemu_try_blockalign(bs, qiov->size);
         if (buf == NULL) {
@@ -719,9 +726,9 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
     return ret;
 }

-static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
-                                       int nb_sectors, QEMUIOVector *qiov,
-                                       int flags)
+static coroutine_fn int qcow_co_pwritev(BlockDriverState *bs, uint64_t offset,
+                                        uint64_t bytes, QEMUIOVector *qiov,
+                                        int flags)
 {
     BDRVQcowState *s = bs->opaque;
     int offset_in_cluster;
@@ -731,8 +738,6 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
     QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
-    int64_t offset = sector_num * BDRV_SECTOR_SIZE;
-    int64_t bytes = nb_sectors * BDRV_SECTOR_SIZE;

     assert(!flags);
     s->cluster_cache_offset = -1; /* disable compressed cache */
@@ -1105,8 +1110,7 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,

     if (ret != Z_STREAM_END || out_len >= s->cluster_size) {
         /* could not compress: write normal cluster */
-        ret = qcow_co_writev(bs, offset >> BDRV_SECTOR_BITS,
-                             bytes >> BDRV_SECTOR_BITS, qiov, 0);
+        ret = qcow_co_pwritev(bs, offset, bytes, qiov, 0);
         if (ret < 0) {
             goto fail;
         }
@@ -1191,9 +1195,10 @@ static BlockDriver bdrv_qcow = {
     .bdrv_co_create_opts    = qcow_co_create_opts,
     .bdrv_has_zero_init     = bdrv_has_zero_init_1,
     .supports_backing       = true,
+    .bdrv_refresh_limits    = qcow_refresh_limits,

-    .bdrv_co_readv          = qcow_co_readv,
-    .bdrv_co_writev         = qcow_co_writev,
+    .bdrv_co_preadv         = qcow_co_preadv,
+    .bdrv_co_pwritev        = qcow_co_pwritev,
     .bdrv_co_block_status   = qcow_co_block_status,

     .bdrv_make_empty        = qcow_make_empty,
-- 
2.14.4
