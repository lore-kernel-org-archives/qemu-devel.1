Received: from eggs.gnu.org ([2001:4830:134:3::10]:47579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekE2G-0006m9-Nh
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekE2F-00007M-1q
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:08:36 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  9 Feb 2018 13:08:24 -0600
Message-Id: <20180209190824.32221-3-eblake@redhat.com>
In-Reply-To: <20180209190824.32221-1-eblake@redhat.com>
References: <20180209190824.32221-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] block: Simplify
 bdrv_can_write_zeroes_with_unmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Stefan Hajnoczi <stefanha@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

We don't need the can_write_zeroes_with_unmap field in
BlockDriverInfo, because it is redundant information with
supported_zero_flags & BDRV_REQ_MAY_UNMAP.  Note that
BlockDriverInfo and supported_zero_flags are both per-device
settings, rather than global state about the driver as a
whole, which means one or both of these bits of information
can already be conditional.  Let's audit how they were set:

crypto: always setting can_write_ to false is pointless (the
struct starts life zero-initialized), no use of supported_

nbd: just recently fixed to set can_write_ if supported_
includes MAY_UNMAP (thus this commit effectively reverts
bca80059e and solves the problem mentioned there in a more
global way)

file-posix, iscsi, qcow2: can_write_ is conditional, while
supported_ was unconditional; but passing MAY_UNMAP would
fail with ENOTSUP if the condition wasn't met

qed: can_write_ is unconditional, but pwrite_zeroes lacks
support for MAY_UNMAP and supported_ is not set. Perhaps
support can be added later (since it would be similar to
qcow2), but for now claiming false is no real loss

all other drivers: can_write_ is not set, and supported_ is
either unset or a passthrough

Simplify the code by moving the conditional into
supported_zero_flags for all drivers, then dropping the
now-unused BDI field.  For callers that relied on
bdrv_can_write_zeroes_with_unmap(), we return the same
per-device settings for drivers that had conditions (no
observable change in behavior there); and can now return
true (instead of false) for drivers that support passthrough
(for example, the commit driver) which gives those drivers
the same fix as nbd just got in bca80059e.  For callers that
relied on supported_zero_flags, we now have a few more places
that can avoid a wasted call to pwrite_zeroes() that will
just fail with ENOTSUP.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180126193439.20219-1-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block.h | 11 -----------
 block.c               |  8 +-------
 block/crypto.c        |  1 -
 block/file-posix.c    |  3 +--
 block/iscsi.c         |  6 ++++--
 block/nbd.c           | 11 -----------
 block/qcow2.c         |  3 +--
 block/qed.c           |  1 -
 8 files changed, 7 insertions(+), 37 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 24ef816960e..19b3ab9cb5e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -26,17 +26,6 @@ typedef struct BlockDriverInfo {
      * to the LBPRZ flag in the SCSI logical block provisioning page.
      */
     bool unallocated_blocks_are_zero;
-    /*
-     * True if the driver can optimize writing zeroes by unmapping
-     * sectors. This is equivalent to the BLKDISCARDZEROES ioctl in Linux
-     * with the difference that in qemu a discard is allowed to silently
-     * fail. Therefore we have to use bdrv_pwrite_zeroes with the
-     * BDRV_REQ_MAY_UNMAP flag for an optimized zero write with unmapping.
-     * After this call the driver has to guarantee that the contents read
-     * back as zero. It is additionally required that the block device is
-     * opened with BDRV_O_UNMAP flag for this to work.
-     */
-    bool can_write_zeroes_with_unmap;
     /*
      * True if this block driver only supports compressed writes
      */
diff --git a/block.c b/block.c
index f94585b2304..814e5a02da6 100644
--- a/block.c
+++ b/block.c
@@ -4010,17 +4010,11 @@ bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs)

 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs)
 {
-    BlockDriverInfo bdi;
-
     if (!(bs->open_flags & BDRV_O_UNMAP)) {
         return false;
     }

-    if (bdrv_get_info(bs, &bdi) == 0) {
-        return bdi.can_write_zeroes_with_unmap;
-    }
-
-    return false;
+    return bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP;
 }

 const char *bdrv_get_encrypted_filename(BlockDriverState *bs)
diff --git a/block/crypto.c b/block/crypto.c
index 70e3691cd84..3df66947c5a 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -576,7 +576,6 @@ static int block_crypto_get_info_luks(BlockDriverState *bs,
     }

     bdi->unallocated_blocks_are_zero = false;
-    bdi->can_write_zeroes_with_unmap = false;
     bdi->cluster_size = subbdi.cluster_size;

     return 0;
diff --git a/block/file-posix.c b/block/file-posix.c
index dd8d7cbbd21..ca49c1a98ae 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -549,7 +549,6 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,

     s->has_discard = true;
     s->has_write_zeroes = true;
-    bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP;
     if ((bs->open_flags & BDRV_O_NOCACHE) != 0) {
         s->needs_alignment = true;
     }
@@ -599,6 +598,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
 #endif

+    bs->supported_zero_flags = s->discard_zeroes ? BDRV_REQ_MAY_UNMAP : 0;
     ret = 0;
 fail:
     if (filename && (bdrv_flags & BDRV_O_TEMPORARY)) {
@@ -2223,7 +2223,6 @@ static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     BDRVRawState *s = bs->opaque;

     bdi->unallocated_blocks_are_zero = s->discard_zeroes;
-    bdi->can_write_zeroes_with_unmap = s->discard_zeroes;
     return 0;
 }

diff --git a/block/iscsi.c b/block/iscsi.c
index 9f99ae5e07b..421983dd6ff 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1877,7 +1877,6 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     if (iscsilun->dpofua) {
         bs->supported_write_flags = BDRV_REQ_FUA;
     }
-    bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP;

     /* Check the write protect flag of the LUN if we want to write */
     if (iscsilun->type == TYPE_DISK && (flags & BDRV_O_RDWR) &&
@@ -1961,6 +1960,10 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }

+    if (iscsilun->lbprz && iscsilun->lbp.lbpws) {
+        bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP;
+    }
+
 out:
     qemu_opts_del(opts);
     g_free(initiator_name);
@@ -2160,7 +2163,6 @@ static int iscsi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     IscsiLun *iscsilun = bs->opaque;
     bdi->unallocated_blocks_are_zero = iscsilun->lbprz;
-    bdi->can_write_zeroes_with_unmap = iscsilun->lbprz && iscsilun->lbp.lbpws;
     bdi->cluster_size = iscsilun->cluster_sectors * BDRV_SECTOR_SIZE;
     return 0;
 }
diff --git a/block/nbd.c b/block/nbd.c
index 411eeb42a7d..ef81a9f53ba 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -566,14 +566,6 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     bs->full_open_options = opts;
 }

-static int nbd_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
-{
-    if (bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP) {
-        bdi->can_write_zeroes_with_unmap = true;
-    }
-    return 0;
-}
-
 static BlockDriver bdrv_nbd = {
     .format_name                = "nbd",
     .protocol_name              = "nbd",
@@ -591,7 +583,6 @@ static BlockDriver bdrv_nbd = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
-    .bdrv_get_info              = nbd_get_info,
 };

 static BlockDriver bdrv_nbd_tcp = {
@@ -611,7 +602,6 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
-    .bdrv_get_info              = nbd_get_info,
 };

 static BlockDriver bdrv_nbd_unix = {
@@ -631,7 +621,6 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
-    .bdrv_get_info              = nbd_get_info,
 };

 static void bdrv_nbd_init(void)
diff --git a/block/qcow2.c b/block/qcow2.c
index a64a572785d..801e29fc56e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1479,7 +1479,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,

     /* Initialise locks */
     qemu_co_mutex_init(&s->lock);
-    bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP;
+    bs->supported_zero_flags = header.version >= 3 ? BDRV_REQ_MAY_UNMAP : 0;

     /* Repair image if dirty */
     if (!(flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) && !bs->read_only &&
@@ -3771,7 +3771,6 @@ static int qcow2_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVQcow2State *s = bs->opaque;
     bdi->unallocated_blocks_are_zero = true;
-    bdi->can_write_zeroes_with_unmap = (s->qcow_version >= 3);
     bdi->cluster_size = s->cluster_size;
     bdi->vm_state_offset = qcow2_vm_state_offset(s);
     return 0;
diff --git a/block/qed.c b/block/qed.c
index 205dbf16e35..c6ff3ab015d 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1438,7 +1438,6 @@ static int bdrv_qed_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     bdi->cluster_size = s->header.cluster_size;
     bdi->is_dirty = s->header.features & QED_F_NEED_CHECK;
     bdi->unallocated_blocks_are_zero = true;
-    bdi->can_write_zeroes_with_unmap = true;
     return 0;
 }

-- 
2.14.3
