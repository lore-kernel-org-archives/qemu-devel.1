Received: from eggs.gnu.org ([2001:4830:134:3::10]:37834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKsJX-00062x-FK
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKsJV-0001Sl-Pp
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:21:23 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Jun 2017 22:20:52 +0200
Message-Id: <20170613202107.10125-2-mreitz@redhat.com>
In-Reply-To: <20170613202107.10125-1-mreitz@redhat.com>
References: <20170613202107.10125-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 01/16] block: Add PreallocMode to
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Add a PreallocMode parameter to the bdrv_truncate() function implemented
by each block driver. Currently, we always pass PREALLOC_MODE_OFF and no
driver accepts anything else.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
index 614cec9..31ae4c1 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -203,7 +203,8 @@ struct BlockDriver {
     int coroutine_fn (*bdrv_co_flush_to_os)(BlockDriverState *bs);
 
     const char *protocol_name;
-    int (*bdrv_truncate)(BlockDriverState *bs, int64_t offset, Error **errp);
+    int (*bdrv_truncate)(BlockDriverState *bs, int64_t offset,
+                         PreallocMode prealloc, Error **errp);
 
     int64_t (*bdrv_getlength)(BlockDriverState *bs);
     bool has_variable_length;
diff --git a/block.c b/block.c
index 056400a..2fdb8a5 100644
--- a/block.c
+++ b/block.c
@@ -3417,7 +3417,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
 
     assert(!(bs->open_flags & BDRV_O_INACTIVE));
 
-    ret = drv->bdrv_truncate(bs, offset, errp);
+    ret = drv->bdrv_truncate(bs, offset, PREALLOC_MODE_OFF, errp);
     if (ret == 0) {
         ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
         bdrv_dirty_bitmap_truncate(bs);
diff --git a/block/blkdebug.c b/block/blkdebug.c
index a5196e8..00090aa 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -812,8 +812,15 @@ static int64_t blkdebug_getlength(BlockDriverState *bs)
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
index 10e5ddc..7047cb2 100644
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
index de2d3a2..30d2245 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1624,12 +1624,19 @@ static void raw_close(BlockDriverState *bs)
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
index ef2910b..4706335 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -461,12 +461,19 @@ static void raw_close(BlockDriverState *bs)
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
index 031596a..4cb5e63 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1097,11 +1097,17 @@ static coroutine_fn int qemu_gluster_co_rw(BlockDriverState *bs,
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
index 5daa201..61d5792 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2059,11 +2059,18 @@ static void iscsi_reopen_commit(BDRVReopenState *reopen_state)
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
index 848b2c0..be6073a 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -758,11 +758,18 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
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
index ff7f568..942befe 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2597,12 +2597,19 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
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
index 8d899fd..794b9af 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1517,12 +1517,19 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
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
index ac7453e..20134cb 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -352,10 +352,17 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
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
index e551639..4b3fadb 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -916,11 +916,18 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
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
index a18315a..e3e4ad5 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2153,13 +2153,20 @@ static int64_t sd_getlength(BlockDriverState *bs)
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
@@ -2448,7 +2455,7 @@ static coroutine_fn int sd_co_writev(BlockDriverState *bs, int64_t sector_num,
     BDRVSheepdogState *s = bs->opaque;
 
     if (offset > s->inode.vdi_size) {
-        ret = sd_truncate(bs, offset, NULL);
+        ret = sd_truncate(bs, offset, PREALLOC_MODE_OFF, NULL);
         if (ret < 0) {
             return ret;
         }
-- 
2.9.4
