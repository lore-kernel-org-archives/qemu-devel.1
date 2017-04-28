Received: from eggs.gnu.org ([2001:4830:134:3::10]:56011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbO-00028M-4z
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbM-0001Uq-Dc
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:54 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:33 +0200
Message-Id: <1493411622-5343-26-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 25/34] block: Add errp to BD.bdrv_truncate()
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

From: Max Reitz <mreitz@redhat.com>

Add an Error parameter to the block drivers' bdrv_truncate() interface.
If a block driver does not set this in case of an error, the generic
bdrv_truncate() implementation will do so.

Where it is obvious, this patch also makes some block drivers set this
value.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170328205129.15138-4-mreitz@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                   |  4 ++--
 block/blkdebug.c          |  4 ++--
 block/crypto.c            |  5 +++--
 block/file-posix.c        |  2 +-
 block/file-win32.c        |  6 +++---
 block/gluster.c           |  3 ++-
 block/iscsi.c             |  4 ++--
 block/nfs.c               |  2 +-
 block/qcow2.c             |  8 ++++----
 block/qed.c               |  2 +-
 block/raw-format.c        |  4 ++--
 block/rbd.c               |  2 +-
 block/sheepdog.c          | 14 ++++++--------
 include/block/block_int.h |  2 +-
 14 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/block.c b/block.c
index 6a1937e..ff232a2 100644
--- a/block.c
+++ b/block.c
@@ -3328,13 +3328,13 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
         return -EACCES;
     }
 
-    ret = drv->bdrv_truncate(bs, offset);
+    ret = drv->bdrv_truncate(bs, offset, errp);
     if (ret == 0) {
         ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
         bdrv_dirty_bitmap_truncate(bs);
         bdrv_parent_cb_resize(bs);
         ++bs->write_gen;
-    } else {
+    } else if (errp && !*errp) {
         error_setg_errno(errp, -ret, "Failed to resize image");
     }
     return ret;
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 9bd066e..d2a7561 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -659,9 +659,9 @@ static int64_t blkdebug_getlength(BlockDriverState *bs)
     return bdrv_getlength(bs->file->bs);
 }
 
-static int blkdebug_truncate(BlockDriverState *bs, int64_t offset)
+static int blkdebug_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
-    return bdrv_truncate(bs->file, offset, NULL);
+    return bdrv_truncate(bs->file, offset, errp);
 }
 
 static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
diff --git a/block/crypto.c b/block/crypto.c
index 7ad64b5..6828180 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -381,7 +381,8 @@ static int block_crypto_create_generic(QCryptoBlockFormat format,
     return ret;
 }
 
-static int block_crypto_truncate(BlockDriverState *bs, int64_t offset)
+static int block_crypto_truncate(BlockDriverState *bs, int64_t offset,
+                                 Error **errp)
 {
     BlockCrypto *crypto = bs->opaque;
     size_t payload_offset =
@@ -389,7 +390,7 @@ static int block_crypto_truncate(BlockDriverState *bs, int64_t offset)
 
     offset += payload_offset;
 
-    return bdrv_truncate(bs->file, offset, NULL);
+    return bdrv_truncate(bs->file, offset, errp);
 }
 
 static void block_crypto_close(BlockDriverState *bs)
diff --git a/block/file-posix.c b/block/file-posix.c
index ade71db..9c0d701 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1407,7 +1407,7 @@ static void raw_close(BlockDriverState *bs)
     }
 }
 
-static int raw_truncate(BlockDriverState *bs, int64_t offset)
+static int raw_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
     struct stat st;
diff --git a/block/file-win32.c b/block/file-win32.c
index e132ba1..7872e00 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -460,7 +460,7 @@ static void raw_close(BlockDriverState *bs)
     }
 }
 
-static int raw_truncate(BlockDriverState *bs, int64_t offset)
+static int raw_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
     LONG low, high;
@@ -475,11 +475,11 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset)
      */
     dwPtrLow = SetFilePointer(s->hfile, low, &high, FILE_BEGIN);
     if (dwPtrLow == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR) {
-        fprintf(stderr, "SetFilePointer error: %lu\n", GetLastError());
+        error_setg_win32(errp, GetLastError(), "SetFilePointer error");
         return -EIO;
     }
     if (SetEndOfFile(s->hfile) == 0) {
-        fprintf(stderr, "SetEndOfFile error: %lu\n", GetLastError());
+        error_setg_win32(errp, GetLastError(), "SetEndOfFile error");
         return -EIO;
     }
     return 0;
diff --git a/block/gluster.c b/block/gluster.c
index cf29b5f..be45c08 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1092,7 +1092,8 @@ static coroutine_fn int qemu_gluster_co_rw(BlockDriverState *bs,
     return acb.ret;
 }
 
-static int qemu_gluster_truncate(BlockDriverState *bs, int64_t offset)
+static int qemu_gluster_truncate(BlockDriverState *bs, int64_t offset,
+                                 Error **errp)
 {
     int ret;
     BDRVGlusterState *s = bs->opaque;
diff --git a/block/iscsi.c b/block/iscsi.c
index 42fb0b0..1ef38cf 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2059,7 +2059,7 @@ static void iscsi_reopen_commit(BDRVReopenState *reopen_state)
     }
 }
 
-static int iscsi_truncate(BlockDriverState *bs, int64_t offset)
+static int iscsi_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     IscsiLun *iscsilun = bs->opaque;
     Error *local_err = NULL;
@@ -2070,7 +2070,7 @@ static int iscsi_truncate(BlockDriverState *bs, int64_t offset)
 
     iscsi_readcapacity_sync(iscsilun, &local_err);
     if (local_err != NULL) {
-        error_free(local_err);
+        error_propagate(errp, local_err);
         return -EIO;
     }
 
diff --git a/block/nfs.c b/block/nfs.c
index 6541dec..5ae665a 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -764,7 +764,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
 }
 
-static int nfs_file_truncate(BlockDriverState *bs, int64_t offset)
+static int nfs_file_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     NFSClient *client = bs->opaque;
     return nfs_ftruncate(client->context, client->fh, offset);
diff --git a/block/qcow2.c b/block/qcow2.c
index 845eee4..6c34798 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2525,26 +2525,26 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
     return ret;
 }
 
-static int qcow2_truncate(BlockDriverState *bs, int64_t offset)
+static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     int64_t new_l1_size;
     int ret;
 
     if (offset & 511) {
-        error_report("The new size must be a multiple of 512");
+        error_setg(errp, "The new size must be a multiple of 512");
         return -EINVAL;
     }
 
     /* cannot proceed if image has snapshots */
     if (s->nb_snapshots) {
-        error_report("Can't resize an image which has snapshots");
+        error_setg(errp, "Can't resize an image which has snapshots");
         return -ENOTSUP;
     }
 
     /* shrinking is currently not supported */
     if (offset < bs->total_sectors * 512) {
-        error_report("qcow2 doesn't support shrinking images yet");
+        error_setg(errp, "qcow2 doesn't support shrinking images yet");
         return -ENOTSUP;
     }
 
diff --git a/block/qed.c b/block/qed.c
index 53199ac..fa2aeee 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1518,7 +1518,7 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
     return cb.ret;
 }
 
-static int bdrv_qed_truncate(BlockDriverState *bs, int64_t offset)
+static int bdrv_qed_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     BDRVQEDState *s = bs->opaque;
     uint64_t old_image_size;
diff --git a/block/raw-format.c b/block/raw-format.c
index a800733..9761bda 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -327,7 +327,7 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
     }
 }
 
-static int raw_truncate(BlockDriverState *bs, int64_t offset)
+static int raw_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
 
@@ -341,7 +341,7 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset)
 
     s->size = offset;
     offset += s->offset;
-    return bdrv_truncate(bs->file, offset, NULL);
+    return bdrv_truncate(bs->file, offset, errp);
 }
 
 static int raw_media_changed(BlockDriverState *bs)
diff --git a/block/rbd.c b/block/rbd.c
index 6471f4f..3e6e73e 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -916,7 +916,7 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
     return info.size;
 }
 
-static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset)
+static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     BDRVRBDState *s = bs->opaque;
     int r;
diff --git a/block/sheepdog.c b/block/sheepdog.c
index b2a5998..fe8fd92 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2159,9 +2159,8 @@ static int64_t sd_getlength(BlockDriverState *bs)
     return s->inode.vdi_size;
 }
 
-static int sd_truncate(BlockDriverState *bs, int64_t offset)
+static int sd_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
-    Error *local_err = NULL;
     BDRVSheepdogState *s = bs->opaque;
     int ret, fd;
     unsigned int datalen;
@@ -2169,16 +2168,15 @@ static int sd_truncate(BlockDriverState *bs, int64_t offset)
 
     max_vdi_size = (UINT64_C(1) << s->inode.block_size_shift) * MAX_DATA_OBJS;
     if (offset < s->inode.vdi_size) {
-        error_report("shrinking is not supported");
+        error_setg(errp, "shrinking is not supported");
         return -EINVAL;
     } else if (offset > max_vdi_size) {
-        error_report("too big image size");
+        error_setg(errp, "too big image size");
         return -EINVAL;
     }
 
-    fd = connect_to_sdog(s, &local_err);
+    fd = connect_to_sdog(s, errp);
     if (fd < 0) {
-        error_report_err(local_err);
         return fd;
     }
 
@@ -2191,7 +2189,7 @@ static int sd_truncate(BlockDriverState *bs, int64_t offset)
     close(fd);
 
     if (ret < 0) {
-        error_report("failed to update an inode.");
+        error_setg_errno(errp, -ret, "failed to update an inode");
     }
 
     return ret;
@@ -2456,7 +2454,7 @@ static coroutine_fn int sd_co_writev(BlockDriverState *bs, int64_t sector_num,
     BDRVSheepdogState *s = bs->opaque;
 
     if (offset > s->inode.vdi_size) {
-        ret = sd_truncate(bs, offset);
+        ret = sd_truncate(bs, offset, NULL);
         if (ret < 0) {
             return ret;
         }
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4f8cd29..dcde90a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -196,7 +196,7 @@ struct BlockDriver {
     int coroutine_fn (*bdrv_co_flush_to_os)(BlockDriverState *bs);
 
     const char *protocol_name;
-    int (*bdrv_truncate)(BlockDriverState *bs, int64_t offset);
+    int (*bdrv_truncate)(BlockDriverState *bs, int64_t offset, Error **errp);
 
     int64_t (*bdrv_getlength)(BlockDriverState *bs);
     bool has_variable_length;
-- 
1.8.3.1
