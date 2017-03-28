Received: from eggs.gnu.org ([2001:4830:134:3::10]:44000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csy5q-0004rm-5R
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csy5o-0003d5-JM
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:51:54 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 28 Mar 2017 22:51:28 +0200
Message-Id: <20170328205129.15138-4-mreitz@redhat.com>
In-Reply-To: <20170328205129.15138-1-mreitz@redhat.com>
References: <20170328205129.15138-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.10 3/4] block: Add errp to
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

Add an Error parameter to the block drivers' bdrv_truncate() interface.
If a block driver does not set this in case of an error, the generic
bdrv_truncate() implementation will do so.

Where it is obvious, this patch also makes some block drivers set this
value.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  2 +-
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
 14 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 59400bd848..08063c10c8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -196,7 +196,7 @@ struct BlockDriver {
     int coroutine_fn (*bdrv_co_flush_to_os)(BlockDriverState *bs);
 
     const char *protocol_name;
-    int (*bdrv_truncate)(BlockDriverState *bs, int64_t offset);
+    int (*bdrv_truncate)(BlockDriverState *bs, int64_t offset, Error **errp);
 
     int64_t (*bdrv_getlength)(BlockDriverState *bs);
     bool has_variable_length;
diff --git a/block.c b/block.c
index 9ed526e01d..7b9841f99a 100644
--- a/block.c
+++ b/block.c
@@ -3243,13 +3243,13 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
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
index 15a9966096..c795ae9e72 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -661,9 +661,9 @@ static int64_t blkdebug_getlength(BlockDriverState *bs)
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
index 52e4f2b20f..17b3140998 100644
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
index 0841a08785..d23464013f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1409,7 +1409,7 @@ static void raw_close(BlockDriverState *bs)
     }
 }
 
-static int raw_truncate(BlockDriverState *bs, int64_t offset)
+static int raw_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
     struct stat st;
diff --git a/block/file-win32.c b/block/file-win32.c
index 800fabdd72..3f3925623f 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -461,7 +461,7 @@ static void raw_close(BlockDriverState *bs)
     }
 }
 
-static int raw_truncate(BlockDriverState *bs, int64_t offset)
+static int raw_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
     LONG low, high;
@@ -476,11 +476,11 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset)
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
index a577daef10..00b8240562 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1084,7 +1084,8 @@ static coroutine_fn int qemu_gluster_co_rw(BlockDriverState *bs,
     return acb.ret;
 }
 
-static int qemu_gluster_truncate(BlockDriverState *bs, int64_t offset)
+static int qemu_gluster_truncate(BlockDriverState *bs, int64_t offset,
+                                 Error **errp)
 {
     int ret;
     BDRVGlusterState *s = bs->opaque;
diff --git a/block/iscsi.c b/block/iscsi.c
index 75d890538e..ab559a6f71 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2060,7 +2060,7 @@ static void iscsi_reopen_commit(BDRVReopenState *reopen_state)
     }
 }
 
-static int iscsi_truncate(BlockDriverState *bs, int64_t offset)
+static int iscsi_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     IscsiLun *iscsilun = bs->opaque;
     Error *local_err = NULL;
@@ -2071,7 +2071,7 @@ static int iscsi_truncate(BlockDriverState *bs, int64_t offset)
 
     iscsi_readcapacity_sync(iscsilun, &local_err);
     if (local_err != NULL) {
-        error_free(local_err);
+        error_propagate(errp, local_err);
         return -EIO;
     }
 
diff --git a/block/nfs.c b/block/nfs.c
index 3f43f6e26a..57d12efc51 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -757,7 +757,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
 }
 
-static int nfs_file_truncate(BlockDriverState *bs, int64_t offset)
+static int nfs_file_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     NFSClient *client = bs->opaque;
     return nfs_ftruncate(client->context, client->fh, offset);
diff --git a/block/qcow2.c b/block/qcow2.c
index 845eee4bd9..6c347989e3 100644
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
index 53199ac8d7..fa2aeee471 100644
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
index a80073369a..9761bdaff8 100644
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
index 498322b30b..30bb0b7798 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -879,7 +879,7 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
     return info.size;
 }
 
-static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset)
+static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     BDRVRBDState *s = bs->opaque;
     int r;
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 89e98edab6..27126ea474 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2133,9 +2133,8 @@ static int64_t sd_getlength(BlockDriverState *bs)
     return s->inode.vdi_size;
 }
 
-static int sd_truncate(BlockDriverState *bs, int64_t offset)
+static int sd_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
-    Error *local_err = NULL;
     BDRVSheepdogState *s = bs->opaque;
     int ret, fd;
     unsigned int datalen;
@@ -2143,16 +2142,15 @@ static int sd_truncate(BlockDriverState *bs, int64_t offset)
 
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
 
@@ -2165,7 +2163,7 @@ static int sd_truncate(BlockDriverState *bs, int64_t offset)
     close(fd);
 
     if (ret < 0) {
-        error_report("failed to update an inode.");
+        error_setg_errno(errp, -ret, "failed to update an inode");
     }
 
     return ret;
@@ -2430,7 +2428,7 @@ static coroutine_fn int sd_co_writev(BlockDriverState *bs, int64_t sector_num,
     BDRVSheepdogState *s = bs->opaque;
 
     if (offset > s->inode.vdi_size) {
-        ret = sd_truncate(bs, offset);
+        ret = sd_truncate(bs, offset, NULL);
         if (ret < 0) {
             return ret;
         }
-- 
2.12.1
