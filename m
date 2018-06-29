Received: from eggs.gnu.org ([2001:4830:134:3::10]:49588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6S-0003wA-Og
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6N-0003qK-Qe
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:37 +0200
Message-Id: <20180629140959.6690-8-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/29] block: Convert .bdrv_truncate callback to
 coroutine_fn
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

bdrv_truncate() is an operation that can block (even for a quite long
time, depending on the PreallocMode) in I/O paths that shouldn't block.
Convert it to a coroutine_fn so that we have the infrastructure for
drivers to make their .bdrv_co_truncate implementation asynchronous.

This change could potentially introduce new race conditions because
bdrv_truncate() isn't necessarily executed atomically any more. Whether
this is a problem needs to be evaluated for each block driver that
supports truncate:

* file-posix/win32, gluster, iscsi, nfs, rbd, ssh, sheepdog: The
  protocol drivers are trivially safe because they don't actually yield
  yet, so there is no change in behaviour.

* copy-on-read, crypto, raw-format: Essentially just filter drivers that
  pass the request to a child node, no problem.

* qcow2: The implementation modifies metadata, so it needs to hold
  s->lock to be safe with concurrent I/O requests. In order to avoid
  double locking, this requires pulling the locking out into
  preallocate_co() and using qcow2_write_caches() instead of
  bdrv_flush().

* qed: Does a single header update, this is fine without locking.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block.h     |  4 +++
 include/block/block_int.h |  4 +--
 block.c                   | 63 +++++++++++++++++++++++++++++++++++-----
 block/copy-on-read.c      |  8 ++---
 block/crypto.c            |  9 +++---
 block/file-posix.c        | 12 ++++----
 block/file-win32.c        |  6 ++--
 block/gluster.c           | 14 +++++----
 block/iscsi.c             |  8 ++---
 block/nfs.c               |  7 +++--
 block/qcow2.c             | 74 ++++++++++++++++++++++++++++-------------------
 block/qed.c               |  8 +++--
 block/raw-format.c        |  8 ++---
 block/rbd.c               |  8 +++--
 block/sheepdog.c          | 12 ++++----
 block/ssh.c               |  6 ++--
 16 files changed, 162 insertions(+), 89 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index b1d6fdb97a..42e59ff585 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -300,8 +300,12 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
 BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     const char *backing_file);
 void bdrv_refresh_filename(BlockDriverState *bs);
+
+int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
+                                  PreallocMode prealloc, Error **errp);
 int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
                   Error **errp);
+
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
 int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 74646ed722..c653ee663a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -289,8 +289,8 @@ struct BlockDriver {
      * bdrv_parse_filename.
      */
     const char *protocol_name;
-    int (*bdrv_truncate)(BlockDriverState *bs, int64_t offset,
-                         PreallocMode prealloc, Error **errp);
+    int coroutine_fn (*bdrv_co_truncate)(BlockDriverState *bs, int64_t offset,
+                                         PreallocMode prealloc, Error **errp);
 
     int64_t (*bdrv_getlength)(BlockDriverState *bs);
     bool has_variable_length;
diff --git a/block.c b/block.c
index 1b8147c1b3..f761bc85d5 100644
--- a/block.c
+++ b/block.c
@@ -3788,8 +3788,8 @@ exit:
 /**
  * Truncate file to 'offset' bytes (needed only for file protocols)
  */
-int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
-                  Error **errp)
+int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
+                                  PreallocMode prealloc, Error **errp)
 {
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
@@ -3807,23 +3807,28 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
         return -EINVAL;
     }
 
-    if (!drv->bdrv_truncate) {
+    bdrv_inc_in_flight(bs);
+
+    if (!drv->bdrv_co_truncate) {
         if (bs->file && drv->is_filter) {
-            return bdrv_truncate(bs->file, offset, prealloc, errp);
+            ret = bdrv_co_truncate(bs->file, offset, prealloc, errp);
+            goto out;
         }
         error_setg(errp, "Image format driver does not support resize");
-        return -ENOTSUP;
+        ret = -ENOTSUP;
+        goto out;
     }
     if (bs->read_only) {
         error_setg(errp, "Image is read-only");
-        return -EACCES;
+        ret = -EACCES;
+        goto out;
     }
 
     assert(!(bs->open_flags & BDRV_O_INACTIVE));
 
-    ret = drv->bdrv_truncate(bs, offset, prealloc, errp);
+    ret = drv->bdrv_co_truncate(bs, offset, prealloc, errp);
     if (ret < 0) {
-        return ret;
+        goto out;
     }
     ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
     if (ret < 0) {
@@ -3834,9 +3839,51 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
     bdrv_dirty_bitmap_truncate(bs, offset);
     bdrv_parent_cb_resize(bs);
     atomic_inc(&bs->write_gen);
+
+out:
+    bdrv_dec_in_flight(bs);
     return ret;
 }
 
+typedef struct TruncateCo {
+    BdrvChild *child;
+    int64_t offset;
+    PreallocMode prealloc;
+    Error **errp;
+    int ret;
+} TruncateCo;
+
+static void coroutine_fn bdrv_truncate_co_entry(void *opaque)
+{
+    TruncateCo *tco = opaque;
+    tco->ret = bdrv_co_truncate(tco->child, tco->offset, tco->prealloc,
+                                tco->errp);
+}
+
+int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
+                  Error **errp)
+{
+    Coroutine *co;
+    TruncateCo tco = {
+        .child      = child,
+        .offset     = offset,
+        .prealloc   = prealloc,
+        .errp       = errp,
+        .ret        = NOT_DONE,
+    };
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        bdrv_truncate_co_entry(&tco);
+    } else {
+        co = qemu_coroutine_create(bdrv_truncate_co_entry, &tco);
+        qemu_coroutine_enter(co);
+        BDRV_POLL_WHILE(child->bs, tco.ret == NOT_DONE);
+    }
+
+    return tco.ret;
+}
+
 /**
  * Length of a allocated file in bytes. Sparse files are counted by actual
  * allocated space. Return < 0 if error or unknown.
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 6a97208888..1dcdaeed69 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -80,10 +80,10 @@ static int64_t cor_getlength(BlockDriverState *bs)
 }
 
 
-static int cor_truncate(BlockDriverState *bs, int64_t offset,
-                        PreallocMode prealloc, Error **errp)
+static int coroutine_fn cor_co_truncate(BlockDriverState *bs, int64_t offset,
+                                        PreallocMode prealloc, Error **errp)
 {
-    return bdrv_truncate(bs->file, offset, prealloc, errp);
+    return bdrv_co_truncate(bs->file, offset, prealloc, errp);
 }
 
 
@@ -147,7 +147,7 @@ BlockDriver bdrv_copy_on_read = {
     .bdrv_child_perm                    = cor_child_perm,
 
     .bdrv_getlength                     = cor_getlength,
-    .bdrv_truncate                      = cor_truncate,
+    .bdrv_co_truncate                   = cor_co_truncate,
 
     .bdrv_co_preadv                     = cor_co_preadv,
     .bdrv_co_pwritev                    = cor_co_pwritev,
diff --git a/block/crypto.c b/block/crypto.c
index aaa8fb7530..210c80d5c7 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -357,8 +357,9 @@ static int block_crypto_co_create_generic(BlockDriverState *bs,
     return ret;
 }
 
-static int block_crypto_truncate(BlockDriverState *bs, int64_t offset,
-                                 PreallocMode prealloc, Error **errp)
+static int coroutine_fn
+block_crypto_co_truncate(BlockDriverState *bs, int64_t offset,
+                         PreallocMode prealloc, Error **errp)
 {
     BlockCrypto *crypto = bs->opaque;
     uint64_t payload_offset =
@@ -371,7 +372,7 @@ static int block_crypto_truncate(BlockDriverState *bs, int64_t offset,
 
     offset += payload_offset;
 
-    return bdrv_truncate(bs->file, offset, prealloc, errp);
+    return bdrv_co_truncate(bs->file, offset, prealloc, errp);
 }
 
 static void block_crypto_close(BlockDriverState *bs)
@@ -700,7 +701,7 @@ BlockDriver bdrv_crypto_luks = {
     .bdrv_child_perm    = bdrv_format_default_perms,
     .bdrv_co_create     = block_crypto_co_create_luks,
     .bdrv_co_create_opts = block_crypto_co_create_opts_luks,
-    .bdrv_truncate      = block_crypto_truncate,
+    .bdrv_co_truncate   = block_crypto_co_truncate,
     .create_opts        = &block_crypto_create_opts_luks,
 
     .bdrv_reopen_prepare = block_crypto_reopen_prepare,
diff --git a/block/file-posix.c b/block/file-posix.c
index 43b963b13e..53c5833659 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1878,8 +1878,8 @@ out:
     return result;
 }
 
-static int raw_truncate(BlockDriverState *bs, int64_t offset,
-                        PreallocMode prealloc, Error **errp)
+static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
+                                        PreallocMode prealloc, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
     struct stat st;
@@ -2625,7 +2625,7 @@ BlockDriver bdrv_file = {
     .bdrv_io_unplug = raw_aio_unplug,
     .bdrv_attach_aio_context = raw_aio_attach_aio_context,
 
-    .bdrv_truncate = raw_truncate,
+    .bdrv_co_truncate = raw_co_truncate,
     .bdrv_getlength = raw_getlength,
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
@@ -3105,7 +3105,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
 
-    .bdrv_truncate      = raw_truncate,
+    .bdrv_co_truncate       = raw_co_truncate,
     .bdrv_getlength	= raw_getlength,
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
@@ -3227,7 +3227,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
 
-    .bdrv_truncate      = raw_truncate,
+    .bdrv_co_truncate    = raw_co_truncate,
     .bdrv_getlength      = raw_getlength,
     .has_variable_length = true,
     .bdrv_get_allocated_file_size
@@ -3357,7 +3357,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
 
-    .bdrv_truncate      = raw_truncate,
+    .bdrv_co_truncate    = raw_co_truncate,
     .bdrv_getlength      = raw_getlength,
     .has_variable_length = true,
     .bdrv_get_allocated_file_size
diff --git a/block/file-win32.c b/block/file-win32.c
index 3c67db4336..0411fe80fd 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -467,8 +467,8 @@ static void raw_close(BlockDriverState *bs)
     }
 }
 
-static int raw_truncate(BlockDriverState *bs, int64_t offset,
-                        PreallocMode prealloc, Error **errp)
+static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
+                                        PreallocMode prealloc, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
     LONG low, high;
@@ -640,7 +640,7 @@ BlockDriver bdrv_file = {
     .bdrv_aio_pwritev   = raw_aio_pwritev,
     .bdrv_aio_flush     = raw_aio_flush,
 
-    .bdrv_truncate	= raw_truncate,
+    .bdrv_co_truncate   = raw_co_truncate,
     .bdrv_getlength	= raw_getlength,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
diff --git a/block/gluster.c b/block/gluster.c
index b5fe7f3e87..a4e1c8ecd8 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1177,8 +1177,10 @@ static coroutine_fn int qemu_gluster_co_rw(BlockDriverState *bs,
     return acb.ret;
 }
 
-static int qemu_gluster_truncate(BlockDriverState *bs, int64_t offset,
-                                 PreallocMode prealloc, Error **errp)
+static coroutine_fn int qemu_gluster_co_truncate(BlockDriverState *bs,
+                                                 int64_t offset,
+                                                 PreallocMode prealloc,
+                                                 Error **errp)
 {
     BDRVGlusterState *s = bs->opaque;
     return qemu_gluster_do_truncate(s->fd, offset, prealloc, errp);
@@ -1499,7 +1501,7 @@ static BlockDriver bdrv_gluster = {
     .bdrv_co_create_opts          = qemu_gluster_co_create_opts,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
-    .bdrv_truncate                = qemu_gluster_truncate,
+    .bdrv_co_truncate             = qemu_gluster_co_truncate,
     .bdrv_co_readv                = qemu_gluster_co_readv,
     .bdrv_co_writev               = qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        = qemu_gluster_co_flush_to_disk,
@@ -1528,7 +1530,7 @@ static BlockDriver bdrv_gluster_tcp = {
     .bdrv_co_create_opts          = qemu_gluster_co_create_opts,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
-    .bdrv_truncate                = qemu_gluster_truncate,
+    .bdrv_co_truncate             = qemu_gluster_co_truncate,
     .bdrv_co_readv                = qemu_gluster_co_readv,
     .bdrv_co_writev               = qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        = qemu_gluster_co_flush_to_disk,
@@ -1557,7 +1559,7 @@ static BlockDriver bdrv_gluster_unix = {
     .bdrv_co_create_opts          = qemu_gluster_co_create_opts,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
-    .bdrv_truncate                = qemu_gluster_truncate,
+    .bdrv_co_truncate             = qemu_gluster_co_truncate,
     .bdrv_co_readv                = qemu_gluster_co_readv,
     .bdrv_co_writev               = qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        = qemu_gluster_co_flush_to_disk,
@@ -1592,7 +1594,7 @@ static BlockDriver bdrv_gluster_rdma = {
     .bdrv_co_create_opts          = qemu_gluster_co_create_opts,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
-    .bdrv_truncate                = qemu_gluster_truncate,
+    .bdrv_co_truncate             = qemu_gluster_co_truncate,
     .bdrv_co_readv                = qemu_gluster_co_readv,
     .bdrv_co_writev               = qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        = qemu_gluster_co_flush_to_disk,
diff --git a/block/iscsi.c b/block/iscsi.c
index 9f00fb47a5..bc84b14e20 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2085,8 +2085,8 @@ static void iscsi_reopen_commit(BDRVReopenState *reopen_state)
     }
 }
 
-static int iscsi_truncate(BlockDriverState *bs, int64_t offset,
-                          PreallocMode prealloc, Error **errp)
+static int coroutine_fn iscsi_co_truncate(BlockDriverState *bs, int64_t offset,
+                                          PreallocMode prealloc, Error **errp)
 {
     IscsiLun *iscsilun = bs->opaque;
     Error *local_err = NULL;
@@ -2431,7 +2431,7 @@ static BlockDriver bdrv_iscsi = {
 
     .bdrv_getlength  = iscsi_getlength,
     .bdrv_get_info   = iscsi_get_info,
-    .bdrv_truncate   = iscsi_truncate,
+    .bdrv_co_truncate    = iscsi_co_truncate,
     .bdrv_refresh_limits = iscsi_refresh_limits,
 
     .bdrv_co_block_status  = iscsi_co_block_status,
@@ -2468,7 +2468,7 @@ static BlockDriver bdrv_iser = {
 
     .bdrv_getlength  = iscsi_getlength,
     .bdrv_get_info   = iscsi_get_info,
-    .bdrv_truncate   = iscsi_truncate,
+    .bdrv_co_truncate    = iscsi_co_truncate,
     .bdrv_refresh_limits = iscsi_refresh_limits,
 
     .bdrv_co_block_status  = iscsi_co_block_status,
diff --git a/block/nfs.c b/block/nfs.c
index 743ca0450e..eab1a2c408 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -743,8 +743,9 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
 }
 
-static int nfs_file_truncate(BlockDriverState *bs, int64_t offset,
-                             PreallocMode prealloc, Error **errp)
+static int coroutine_fn
+nfs_file_co_truncate(BlockDriverState *bs, int64_t offset,
+                     PreallocMode prealloc, Error **errp)
 {
     NFSClient *client = bs->opaque;
     int ret;
@@ -873,7 +874,7 @@ static BlockDriver bdrv_nfs = {
 
     .bdrv_has_zero_init             = nfs_has_zero_init,
     .bdrv_get_allocated_file_size   = nfs_get_allocated_file_size,
-    .bdrv_truncate                  = nfs_file_truncate,
+    .bdrv_co_truncate               = nfs_file_co_truncate,
 
     .bdrv_file_open                 = nfs_file_open,
     .bdrv_close                     = nfs_file_close,
diff --git a/block/qcow2.c b/block/qcow2.c
index 6b2e1e1058..9e0ccbbfaf 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2543,15 +2543,12 @@ static void coroutine_fn preallocate_co(void *opaque)
     BlockDriverState *bs = params->bs;
     uint64_t offset = params->offset;
     uint64_t new_length = params->new_length;
-    BDRVQcow2State *s = bs->opaque;
     uint64_t bytes;
     uint64_t host_offset = 0;
     unsigned int cur_bytes;
     int ret;
     QCowL2Meta *meta;
 
-    qemu_co_mutex_lock(&s->lock);
-
     assert(offset <= new_length);
     bytes = new_length - offset;
 
@@ -2604,7 +2601,6 @@ static void coroutine_fn preallocate_co(void *opaque)
     ret = 0;
 
 done:
-    qemu_co_mutex_unlock(&s->lock);
     params->ret = ret;
 }
 
@@ -3041,7 +3037,11 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 
     /* And if we're supposed to preallocate metadata, do that now */
     if (qcow2_opts->preallocation != PREALLOC_MODE_OFF) {
+        BDRVQcow2State *s = blk_bs(blk)->opaque;
+        qemu_co_mutex_lock(&s->lock);
         ret = preallocate(blk_bs(blk), 0, qcow2_opts->size);
+        qemu_co_mutex_unlock(&s->lock);
+
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not preallocate metadata");
             goto out;
@@ -3437,8 +3437,8 @@ fail:
     return ret;
 }
 
-static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
-                          PreallocMode prealloc, Error **errp)
+static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
+                                          PreallocMode prealloc, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t old_length;
@@ -3458,17 +3458,21 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         return -EINVAL;
     }
 
+    qemu_co_mutex_lock(&s->lock);
+
     /* cannot proceed if image has snapshots */
     if (s->nb_snapshots) {
         error_setg(errp, "Can't resize an image which has snapshots");
-        return -ENOTSUP;
+        ret = -ENOTSUP;
+        goto fail;
     }
 
     /* cannot proceed if image has bitmaps */
     if (s->nb_bitmaps) {
         /* TODO: resize bitmaps in the image */
         error_setg(errp, "Can't resize an image which has bitmaps");
-        return -ENOTSUP;
+        ret = -ENOTSUP;
+        goto fail;
     }
 
     old_length = bs->total_sectors * 512;
@@ -3479,7 +3483,8 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         if (prealloc != PREALLOC_MODE_OFF) {
             error_setg(errp,
                        "Preallocation can't be used for shrinking an image");
-            return -EINVAL;
+            ret = -EINVAL;
+            goto fail;
         }
 
         ret = qcow2_cluster_discard(bs, ROUND_UP(offset, s->cluster_size),
@@ -3488,40 +3493,42 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
                                     QCOW2_DISCARD_ALWAYS, true);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Failed to discard cropped clusters");
-            return ret;
+            goto fail;
         }
 
         ret = qcow2_shrink_l1_table(bs, new_l1_size);
         if (ret < 0) {
             error_setg_errno(errp, -ret,
                              "Failed to reduce the number of L2 tables");
-            return ret;
+            goto fail;
         }
 
         ret = qcow2_shrink_reftable(bs);
         if (ret < 0) {
             error_setg_errno(errp, -ret,
                              "Failed to discard unused refblocks");
-            return ret;
+            goto fail;
         }
 
         old_file_size = bdrv_getlength(bs->file->bs);
         if (old_file_size < 0) {
             error_setg_errno(errp, -old_file_size,
                              "Failed to inquire current file length");
-            return old_file_size;
+            ret = old_file_size;
+            goto fail;
         }
         last_cluster = qcow2_get_last_cluster(bs, old_file_size);
         if (last_cluster < 0) {
             error_setg_errno(errp, -last_cluster,
                              "Failed to find the last cluster");
-            return last_cluster;
+            ret = last_cluster;
+            goto fail;
         }
         if ((last_cluster + 1) * s->cluster_size < old_file_size) {
             Error *local_err = NULL;
 
-            bdrv_truncate(bs->file, (last_cluster + 1) * s->cluster_size,
-                          PREALLOC_MODE_OFF, &local_err);
+            bdrv_co_truncate(bs->file, (last_cluster + 1) * s->cluster_size,
+                             PREALLOC_MODE_OFF, &local_err);
             if (local_err) {
                 warn_reportf_err(local_err,
                                  "Failed to truncate the tail of the image: ");
@@ -3531,7 +3538,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         ret = qcow2_grow_l1_table(bs, new_l1_size, true);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Failed to grow the L1 table");
-            return ret;
+            goto fail;
         }
     }
 
@@ -3543,7 +3550,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         ret = preallocate(bs, old_length, offset);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Preallocation failed");
-            return ret;
+            goto fail;
         }
         break;
 
@@ -3559,7 +3566,8 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         if (old_file_size < 0) {
             error_setg_errno(errp, -old_file_size,
                              "Failed to inquire current file length");
-            return old_file_size;
+            ret = old_file_size;
+            goto fail;
         }
         old_file_size = ROUND_UP(old_file_size, s->cluster_size);
 
@@ -3589,7 +3597,8 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         if (allocation_start < 0) {
             error_setg_errno(errp, -allocation_start,
                              "Failed to resize refcount structures");
-            return allocation_start;
+            ret = allocation_start;
+            goto fail;
         }
 
         clusters_allocated = qcow2_alloc_clusters_at(bs, allocation_start,
@@ -3597,7 +3606,8 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         if (clusters_allocated < 0) {
             error_setg_errno(errp, -clusters_allocated,
                              "Failed to allocate data clusters");
-            return clusters_allocated;
+            ret = clusters_allocated;
+            goto fail;
         }
 
         assert(clusters_allocated == nb_new_data_clusters);
@@ -3605,13 +3615,13 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         /* Allocate the data area */
         new_file_size = allocation_start +
                         nb_new_data_clusters * s->cluster_size;
-        ret = bdrv_truncate(bs->file, new_file_size, prealloc, errp);
+        ret = bdrv_co_truncate(bs->file, new_file_size, prealloc, errp);
         if (ret < 0) {
             error_prepend(errp, "Failed to resize underlying file: ");
             qcow2_free_clusters(bs, allocation_start,
                                 nb_new_data_clusters * s->cluster_size,
                                 QCOW2_DISCARD_OTHER);
-            return ret;
+            goto fail;
         }
 
         /* Create the necessary L2 entries */
@@ -3634,7 +3644,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
                 qcow2_free_clusters(bs, host_offset,
                                     nb_new_data_clusters * s->cluster_size,
                                     QCOW2_DISCARD_OTHER);
-                return ret;
+                goto fail;
             }
 
             guest_offset += nb_clusters * s->cluster_size;
@@ -3650,11 +3660,11 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
 
     if (prealloc != PREALLOC_MODE_OFF) {
         /* Flush metadata before actually changing the image size */
-        ret = bdrv_flush(bs);
+        ret = qcow2_write_caches(bs);
         if (ret < 0) {
             error_setg_errno(errp, -ret,
                              "Failed to flush the preallocated area to disk");
-            return ret;
+            goto fail;
         }
     }
 
@@ -3664,11 +3674,14 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
                            &offset, sizeof(uint64_t));
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to update the image size");
-        return ret;
+        goto fail;
     }
 
     s->l1_vm_state_index = new_l1_size;
-    return 0;
+    ret = 0;
+fail:
+    qemu_co_mutex_unlock(&s->lock);
+    return ret;
 }
 
 /* XXX: put compressed sectors first, then all the cluster aligned
@@ -3692,7 +3705,8 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         if (cluster_offset < 0) {
             return cluster_offset;
         }
-        return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_OFF, NULL);
+        return bdrv_co_truncate(bs->file, cluster_offset, PREALLOC_MODE_OFF,
+                                NULL);
     }
 
     if (offset_into_cluster(s, offset)) {
@@ -4696,7 +4710,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_co_pdiscard       = qcow2_co_pdiscard,
     .bdrv_co_copy_range_from = qcow2_co_copy_range_from,
     .bdrv_co_copy_range_to  = qcow2_co_copy_range_to,
-    .bdrv_truncate          = qcow2_truncate,
+    .bdrv_co_truncate       = qcow2_co_truncate,
     .bdrv_co_pwritev_compressed = qcow2_co_pwritev_compressed,
     .bdrv_make_empty        = qcow2_make_empty,
 
diff --git a/block/qed.c b/block/qed.c
index 2363814538..689ea9d4d5 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1467,8 +1467,10 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
                           QED_AIOCB_WRITE | QED_AIOCB_ZERO);
 }
 
-static int bdrv_qed_truncate(BlockDriverState *bs, int64_t offset,
-                             PreallocMode prealloc, Error **errp)
+static int coroutine_fn bdrv_qed_co_truncate(BlockDriverState *bs,
+                                             int64_t offset,
+                                             PreallocMode prealloc,
+                                             Error **errp)
 {
     BDRVQEDState *s = bs->opaque;
     uint64_t old_image_size;
@@ -1678,7 +1680,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_co_readv            = bdrv_qed_co_readv,
     .bdrv_co_writev           = bdrv_qed_co_writev,
     .bdrv_co_pwrite_zeroes    = bdrv_qed_co_pwrite_zeroes,
-    .bdrv_truncate            = bdrv_qed_truncate,
+    .bdrv_co_truncate         = bdrv_qed_co_truncate,
     .bdrv_getlength           = bdrv_qed_getlength,
     .bdrv_get_info            = bdrv_qed_get_info,
     .bdrv_refresh_limits      = bdrv_qed_refresh_limits,
diff --git a/block/raw-format.c b/block/raw-format.c
index f2e468df6f..b78da564d4 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -366,8 +366,8 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
     }
 }
 
-static int raw_truncate(BlockDriverState *bs, int64_t offset,
-                        PreallocMode prealloc, Error **errp)
+static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
+                                        PreallocMode prealloc, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
 
@@ -383,7 +383,7 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset,
 
     s->size = offset;
     offset += s->offset;
-    return bdrv_truncate(bs->file, offset, prealloc, errp);
+    return bdrv_co_truncate(bs->file, offset, prealloc, errp);
 }
 
 static void raw_eject(BlockDriverState *bs, bool eject_flag)
@@ -545,7 +545,7 @@ BlockDriver bdrv_raw = {
     .bdrv_co_block_status = &raw_co_block_status,
     .bdrv_co_copy_range_from = &raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = &raw_co_copy_range_to,
-    .bdrv_truncate        = &raw_truncate,
+    .bdrv_co_truncate     = &raw_co_truncate,
     .bdrv_getlength       = &raw_getlength,
     .has_variable_length  = true,
     .bdrv_measure         = &raw_measure,
diff --git a/block/rbd.c b/block/rbd.c
index f2c6965418..ca8e5bbace 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -990,8 +990,10 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
     return info.size;
 }
 
-static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset,
-                             PreallocMode prealloc, Error **errp)
+static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
+                                             int64_t offset,
+                                             PreallocMode prealloc,
+                                             Error **errp)
 {
     BDRVRBDState *s = bs->opaque;
     int r;
@@ -1184,7 +1186,7 @@ static BlockDriver bdrv_rbd = {
     .bdrv_get_info          = qemu_rbd_getinfo,
     .create_opts            = &qemu_rbd_create_opts,
     .bdrv_getlength         = qemu_rbd_getlength,
-    .bdrv_truncate          = qemu_rbd_truncate,
+    .bdrv_co_truncate       = qemu_rbd_co_truncate,
     .protocol_name          = "rbd",
 
     .bdrv_aio_preadv        = qemu_rbd_aio_preadv,
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 665b1763eb..b229a664d9 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2292,8 +2292,8 @@ static int64_t sd_getlength(BlockDriverState *bs)
     return s->inode.vdi_size;
 }
 
-static int sd_truncate(BlockDriverState *bs, int64_t offset,
-                       PreallocMode prealloc, Error **errp)
+static int coroutine_fn sd_co_truncate(BlockDriverState *bs, int64_t offset,
+                                       PreallocMode prealloc, Error **errp)
 {
     BDRVSheepdogState *s = bs->opaque;
     int ret, fd;
@@ -2609,7 +2609,7 @@ static coroutine_fn int sd_co_writev(BlockDriverState *bs, int64_t sector_num,
 
     assert(!flags);
     if (offset > s->inode.vdi_size) {
-        ret = sd_truncate(bs, offset, PREALLOC_MODE_OFF, NULL);
+        ret = sd_co_truncate(bs, offset, PREALLOC_MODE_OFF, NULL);
         if (ret < 0) {
             return ret;
         }
@@ -3231,7 +3231,7 @@ static BlockDriver bdrv_sheepdog = {
     .bdrv_has_zero_init           = bdrv_has_zero_init_1,
     .bdrv_getlength               = sd_getlength,
     .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
-    .bdrv_truncate                = sd_truncate,
+    .bdrv_co_truncate             = sd_co_truncate,
 
     .bdrv_co_readv                = sd_co_readv,
     .bdrv_co_writev               = sd_co_writev,
@@ -3268,7 +3268,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
     .bdrv_has_zero_init           = bdrv_has_zero_init_1,
     .bdrv_getlength               = sd_getlength,
     .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
-    .bdrv_truncate                = sd_truncate,
+    .bdrv_co_truncate             = sd_co_truncate,
 
     .bdrv_co_readv                = sd_co_readv,
     .bdrv_co_writev               = sd_co_writev,
@@ -3305,7 +3305,7 @@ static BlockDriver bdrv_sheepdog_unix = {
     .bdrv_has_zero_init           = bdrv_has_zero_init_1,
     .bdrv_getlength               = sd_getlength,
     .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
-    .bdrv_truncate                = sd_truncate,
+    .bdrv_co_truncate             = sd_co_truncate,
 
     .bdrv_co_readv                = sd_co_readv,
     .bdrv_co_writev               = sd_co_writev,
diff --git a/block/ssh.c b/block/ssh.c
index da7bbf73e2..7fbc27abdf 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1243,8 +1243,8 @@ static int64_t ssh_getlength(BlockDriverState *bs)
     return length;
 }
 
-static int ssh_truncate(BlockDriverState *bs, int64_t offset,
-                        PreallocMode prealloc, Error **errp)
+static int coroutine_fn ssh_co_truncate(BlockDriverState *bs, int64_t offset,
+                                        PreallocMode prealloc, Error **errp)
 {
     BDRVSSHState *s = bs->opaque;
 
@@ -1279,7 +1279,7 @@ static BlockDriver bdrv_ssh = {
     .bdrv_co_readv                = ssh_co_readv,
     .bdrv_co_writev               = ssh_co_writev,
     .bdrv_getlength               = ssh_getlength,
-    .bdrv_truncate                = ssh_truncate,
+    .bdrv_co_truncate             = ssh_co_truncate,
     .bdrv_co_flush_to_disk        = ssh_co_flush,
     .create_opts                  = &ssh_create_opts,
 };
-- 
2.13.6
