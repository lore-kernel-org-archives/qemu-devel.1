Received: from eggs.gnu.org ([2001:4830:134:3::10]:34055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv4YE-0000jz-IU
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv4YC-0008Nd-Ll
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:09:54 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 18:09:21 +0200
Message-Id: <20170403160936.28293-2-mreitz@redhat.com>
In-Reply-To: <20170403160936.28293-1-mreitz@redhat.com>
References: <20170403160936.28293-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 01/16] block: Add PreallocMode to
 BD.bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Add a PreallocMode parameter to the bdrv_truncate() function implemented
by each block driver. Currently, we always pass PREALLOC_MODE_OFF and no
driver accepts anything else.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  3 ++-
 block.c                   |  2 +-
 block/blkdebug.c          |  9 ++++++++-
 block/crypto.c            |  8 +++++++-
 block/file-posix.c        |  9 ++++++++-
 block/file-win32.c        |  9 ++++++++-
 block/gluster.c           |  8 +++++++-
 block/iscsi.c             |  9 ++++++++-
 block/nfs.c               |  9 ++++++++-
 block/qcow2.c             |  9 ++++++++-
 block/qed.c               |  9 ++++++++-
 block/raw-format.c        |  9 ++++++++-
 block/rbd.c               |  9 ++++++++-
 block/sheepdog.c          | 11 +++++++++--
 14 files changed, 98 insertions(+), 15 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 08063c10c8..10a2bef5b0 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -196,7 +196,8 @@ struct BlockDriver {
     int coroutine_fn (*bdrv_co_flush_to_os)(BlockDriverState *bs);
 
     const char *protocol_name;
-    int (*bdrv_truncate)(BlockDriverState *bs, int64_t offset, Error **errp);
+    int (*bdrv_truncate)(BlockDriverState *bs, int64_t offset,
+                         PreallocMode prealloc, Error **errp);
 
     int64_t (*bdrv_getlength)(BlockDriverState *bs);
     bool has_variable_length;
diff --git a/block.c b/block.c
index 6df9723da7..30aed5ffb5 100644
--- a/block.c
+++ b/block.c
@@ -3285,7 +3285,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
         return -EACCES;
     }
 
-    ret = drv->bdrv_truncate(bs, offset, errp);
+    ret = drv->bdrv_truncate(bs, offset, PREALLOC_MODE_OFF, errp);
     if (ret == 0) {
         ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
         bdrv_dirty_bitmap_truncate(bs);
diff --git a/block/blkdebug.c b/block/blkdebug.c
index c795ae9e72..31a71a34d3 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -661,8 +661,15 @@ static int64_t blkdebug_getlength(BlockDriverState *bs)
     return bdrv_getlength(bs->file->bs);
 }
 
-static int blkdebug_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
+static int blkdebug_truncate(BlockDriverState *bs, int64_t offset,
+                             PreallocMode prealloc, Error **errp)
 {
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode '%s'",
+                   PreallocMode_lookup[prealloc]);
+        return -ENOTSUP;
+    }
+
     return bdrv_truncate(bs->file, offset, errp);
 }
 
diff --git a/block/crypto.c b/block/crypto.c
index 17b3140998..fa61aef380 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -382,12 +382,18 @@ static int block_crypto_create_generic(QCryptoBlockFormat format,
 }
 
 static int block_crypto_truncate(BlockDriverState *bs, int64_t offset,
-                                 Error **errp)
+                                 PreallocMode prealloc, Error **errp)
 {
     BlockCrypto *crypto = bs->opaque;
     size_t payload_offset =
         qcrypto_block_get_payload_offset(crypto->block);
 
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode '%s'",
+                   PreallocMode_lookup[prealloc]);
+        return -ENOTSUP;
+    }
+
     offset += payload_offset;
 
     return bdrv_truncate(bs->file, offset, errp);
diff --git a/block/file-posix.c b/block/file-posix.c
index 1941fb6749..3e9c416668 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1407,12 +1407,19 @@ static void raw_close(BlockDriverState *bs)
     }
 }
 
-static int raw_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
+static int raw_truncate(BlockDriverState *bs, int64_t offset,
+                        PreallocMode prealloc, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
     struct stat st;
     int ret;
 
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode '%s'",
+                   PreallocMode_lookup[prealloc]);
+        return -ENOTSUP;
+    }
+
     if (fstat(s->fd, &st)) {
         ret = -errno;
         error_setg_errno(errp, -ret, "Failed to fstat() the file");
diff --git a/block/file-win32.c b/block/file-win32.c
index 7872e00a21..cd5033371c 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -460,12 +460,19 @@ static void raw_close(BlockDriverState *bs)
     }
 }
 
-static int raw_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
+static int raw_truncate(BlockDriverState *bs, int64_t offset,
+                        PreallocMode prealloc, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
     LONG low, high;
     DWORD dwPtrLow;
 
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode '%s'",
+                   PreallocMode_lookup[prealloc]);
+        return -ENOTSUP;
+    }
+
     low = offset;
     high = offset >> 32;
 
diff --git a/block/gluster.c b/block/gluster.c
index 1d4e2f7c52..8634ca3eff 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1093,11 +1093,17 @@ static coroutine_fn int qemu_gluster_co_rw(BlockDriverState *bs,
 }
 
 static int qemu_gluster_truncate(BlockDriverState *bs, int64_t offset,
-                                 Error **errp)
+                                 PreallocMode prealloc, Error **errp)
 {
     int ret;
     BDRVGlusterState *s = bs->opaque;
 
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode '%s'",
+                   PreallocMode_lookup[prealloc]);
+        return -ENOTSUP;
+    }
+
     ret = glfs_ftruncate(s->fd, offset);
     if (ret < 0) {
         ret = -errno;
diff --git a/block/iscsi.c b/block/iscsi.c
index 036f5b6930..ca619fc337 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2060,11 +2060,18 @@ static void iscsi_reopen_commit(BDRVReopenState *reopen_state)
     }
 }
 
-static int iscsi_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
+static int iscsi_truncate(BlockDriverState *bs, int64_t offset,
+                          PreallocMode prealloc, Error **errp)
 {
     IscsiLun *iscsilun = bs->opaque;
     Error *local_err = NULL;
 
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode '%s'",
+                   PreallocMode_lookup[prealloc]);
+        return -ENOTSUP;
+    }
+
     if (iscsilun->type != TYPE_DISK) {
         error_setg(errp, "Cannot resize non-disk iSCSI devices");
         return -ENOTSUP;
diff --git a/block/nfs.c b/block/nfs.c
index 8d5a4ac14b..268a860bcc 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -764,11 +764,18 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
 }
 
-static int nfs_file_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
+static int nfs_file_truncate(BlockDriverState *bs, int64_t offset,
+                             PreallocMode prealloc, Error **errp)
 {
     NFSClient *client = bs->opaque;
     int ret;
 
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode '%s'",
+                   PreallocMode_lookup[prealloc]);
+        return -ENOTSUP;
+    }
+
     ret = nfs_ftruncate(client->context, client->fh, offset);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to truncate file");
diff --git a/block/qcow2.c b/block/qcow2.c
index 4ca4cf04b0..25d98e23dc 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2525,12 +2525,19 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
     return ret;
 }
 
-static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
+static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
+                          PreallocMode prealloc, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     int64_t new_l1_size;
     int ret;
 
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode '%s'",
+                   PreallocMode_lookup[prealloc]);
+        return -ENOTSUP;
+    }
+
     if (offset & 511) {
         error_setg(errp, "The new size must be a multiple of 512");
         return -EINVAL;
diff --git a/block/qed.c b/block/qed.c
index fd76817cbb..6d460ce0fd 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1518,12 +1518,19 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
     return cb.ret;
 }
 
-static int bdrv_qed_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
+static int bdrv_qed_truncate(BlockDriverState *bs, int64_t offset,
+                             PreallocMode prealloc, Error **errp)
 {
     BDRVQEDState *s = bs->opaque;
     uint64_t old_image_size;
     int ret;
 
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode '%s'",
+                   PreallocMode_lookup[prealloc]);
+        return -ENOTSUP;
+    }
+
     if (!qed_is_image_size_valid(offset, s->header.cluster_size,
                                  s->header.table_size)) {
         error_setg(errp, "Invalid image size specified");
diff --git a/block/raw-format.c b/block/raw-format.c
index 36e65036f0..aeaa13e3f5 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -327,10 +327,17 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
     }
 }
 
-static int raw_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
+static int raw_truncate(BlockDriverState *bs, int64_t offset,
+                        PreallocMode prealloc, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
 
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode '%s'",
+                   PreallocMode_lookup[prealloc]);
+        return -ENOTSUP;
+    }
+
     if (s->has_size) {
         error_setg(errp, "Cannot resize fixed-size raw disks");
         return -ENOTSUP;
diff --git a/block/rbd.c b/block/rbd.c
index 397917c096..aaf4a686a4 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -886,11 +886,18 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
     return info.size;
 }
 
-static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
+static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset,
+                             PreallocMode prealloc, Error **errp)
 {
     BDRVRBDState *s = bs->opaque;
     int r;
 
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode '%s'",
+                   PreallocMode_lookup[prealloc]);
+        return -ENOTSUP;
+    }
+
     r = rbd_resize(s->image, offset);
     if (r < 0) {
         error_setg_errno(errp, -r, "Failed to resize file");
diff --git a/block/sheepdog.c b/block/sheepdog.c
index d81a1f063b..eefae5332b 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2159,13 +2159,20 @@ static int64_t sd_getlength(BlockDriverState *bs)
     return s->inode.vdi_size;
 }
 
-static int sd_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
+static int sd_truncate(BlockDriverState *bs, int64_t offset,
+                       PreallocMode prealloc, Error **errp)
 {
     BDRVSheepdogState *s = bs->opaque;
     int ret, fd;
     unsigned int datalen;
     uint64_t max_vdi_size;
 
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode '%s'",
+                   PreallocMode_lookup[prealloc]);
+        return -ENOTSUP;
+    }
+
     max_vdi_size = (UINT64_C(1) << s->inode.block_size_shift) * MAX_DATA_OBJS;
     if (offset < s->inode.vdi_size) {
         error_setg(errp, "shrinking is not supported");
@@ -2454,7 +2461,7 @@ static coroutine_fn int sd_co_writev(BlockDriverState *bs, int64_t sector_num,
     BDRVSheepdogState *s = bs->opaque;
 
     if (offset > s->inode.vdi_size) {
-        ret = sd_truncate(bs, offset, NULL);
+        ret = sd_truncate(bs, offset, PREALLOC_MODE_OFF, NULL);
         if (ret < 0) {
             return ret;
         }
-- 
2.12.1
