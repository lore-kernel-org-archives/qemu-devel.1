Received: from eggs.gnu.org ([2001:4830:134:3::10]:49416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cT9v8-0006cQ-V0
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cT9v6-0001RQ-6Y
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:14:10 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Jan 2017 17:13:52 +0100
Message-Id: <20170116161354.8011-1-mreitz@redhat.com>
In-Reply-To: <20170113205237.30386-1-mreitz@redhat.com>
References: <20170113205237.30386-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 7/9] block: Drop BlockDriverState.filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

That field is now only used during initialization of BlockDriverStates
(opening images) and for error or warning messages. Performance is not
that much of an issue here, so we can drop the field and replace its use
by a call to bdrv_filename(). By doing so we can ensure the result
always to be recent, whereas the contents of BlockDriverState.filename
may have been obsoleted by manipulations of single BlockDriverStates or
of the BDS graph.

The users of the BDS filename field were changed as follows:
- copying the filename into another buffer is trivially replaced by
  using bdrv_filename() instead of the copy function
- strdup() on the filename is replaced by a call to
  bdrv_filename(filename, NULL, 0)
- bdrv_filename(bs, bs->filename, sizeof(bs->filename)) is replaced by
  bdrv_refresh_filename(bs)
  (these were introduced by the patch before the previous patch)
- anywhere else bdrv_filename(..., NULL, 0) is used, any access to
  BlockDriverState.filename is then replaced by the buffer returned, and
  it is freed when it is no longer needed

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  1 -
 block.c                   | 31 ++++++++++++++++++++-----------
 block/commit.c            |  4 +++-
 block/mirror.c            | 16 ++++++++++++----
 block/nbd.c               |  5 ++++-
 block/nfs.c               |  4 +++-
 block/qapi.c              |  4 ++--
 block/raw-format.c        |  4 +++-
 block/replication.c       |  2 +-
 block/vhdx-log.c          |  7 +++++--
 block/vmdk.c              | 22 ++++++++++++++++------
 block/vpc.c               |  7 +++++--
 blockdev.c                | 35 +++++++++++++++++++++++++----------
 13 files changed, 99 insertions(+), 43 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index eba463b99b..83c7c4e5d9 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -466,7 +466,6 @@ struct BlockDriverState {
     QLIST_HEAD(, BdrvAioNotifier) aio_notifiers;
     bool walking_aio_notifiers; /* to make removal during iteration safe */
 
-    char filename[PATH_MAX];
     char backing_file[PATH_MAX]; /* if non zero, the image is a diff of
                                     this file image */
     char backing_format[16]; /* if non-zero and backing_file exists */
diff --git a/block.c b/block.c
index a631d94702..58f7575d4f 100644
--- a/block.c
+++ b/block.c
@@ -1006,6 +1006,7 @@ static int bdrv_open_common(BlockDriverState *bs, BdrvChild *file,
                             QDict *options, Error **errp)
 {
     int ret, open_flags;
+    char *filename_buffer = NULL;
     const char *filename;
     const char *driver_name = NULL;
     const char *node_name = NULL;
@@ -1033,7 +1034,8 @@ static int bdrv_open_common(BlockDriverState *bs, BdrvChild *file,
     assert(drv != NULL);
 
     if (file != NULL) {
-        filename = file->bs->filename;
+        filename_buffer = bdrv_filename(file->bs, NULL, 0);
+        filename = filename_buffer;
     } else {
         filename = qdict_get_try_str(options, "filename");
     }
@@ -1172,6 +1174,7 @@ static int bdrv_open_common(BlockDriverState *bs, BdrvChild *file,
     assert(is_power_of_2(bs->bl.request_alignment));
 
     qemu_opts_del(opts);
+    g_free(filename_buffer);
     return 0;
 
 free_and_fail:
@@ -1181,6 +1184,7 @@ free_and_fail:
     bs->drv = NULL;
 fail_opts:
     qemu_opts_del(opts);
+    g_free(filename_buffer);
     return ret;
 }
 
@@ -1453,7 +1457,7 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd)
     }
     bs->backing = bdrv_attach_child(bs, backing_hd, "backing", &child_backing);
     bs->open_flags &= ~BDRV_O_NO_BACKING;
-    pstrcpy(bs->backing_file, sizeof(bs->backing_file), backing_hd->filename);
+    bdrv_filename(backing_hd, bs->backing_file, sizeof(bs->backing_file));
     pstrcpy(bs->backing_format, sizeof(bs->backing_format),
             backing_hd->drv ? backing_hd->drv->format_name : "");
 
@@ -1731,8 +1735,7 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
     bdrv_append(bs_snapshot, bs);
 
     bs_snapshot->backing_overridden = true;
-    bdrv_filename(bs_snapshot, bs_snapshot->filename,
-                  sizeof(bs_snapshot->filename));
+    bdrv_refresh_filename(bs_snapshot);
 
     g_free(tmp_filename);
     return bs_snapshot;
@@ -1924,7 +1927,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         }
     }
 
-    bdrv_filename(bs, bs->filename, sizeof(bs->filename));
+    bdrv_refresh_filename(bs);
 
     /* Check if any unknown options were used */
     if (options && (qdict_size(options) != 0)) {
@@ -2297,8 +2300,10 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
             if (local_err != NULL) {
                 error_propagate(errp, local_err);
             } else {
+                char *filename = bdrv_filename(reopen_state->bs, NULL, 0);
                 error_setg(errp, "failed while preparing to reopen image '%s'",
-                           reopen_state->bs->filename);
+                           filename);
+                g_free(filename);
             }
             goto error;
         }
@@ -2662,6 +2667,7 @@ int bdrv_drop_intermediate(BlockDriverState *active, BlockDriverState *top,
                            BlockDriverState *base, const char *backing_file_str)
 {
     BlockDriverState *new_top_bs = NULL;
+    char *base_filename = NULL;
     int ret = -EIO;
 
     if (!top->drv || !base->drv) {
@@ -2688,7 +2694,10 @@ int bdrv_drop_intermediate(BlockDriverState *active, BlockDriverState *top,
     }
 
     /* success - we can delete the intermediate states, and link top->base */
-    backing_file_str = backing_file_str ? backing_file_str : base->filename;
+    if (!backing_file_str) {
+        base_filename = bdrv_filename(base, NULL, 0);
+        backing_file_str = base_filename;
+    }
     ret = bdrv_change_backing_file(new_top_bs, backing_file_str,
                                    base->drv ? base->drv->format_name : "");
     if (ret) {
@@ -2698,6 +2707,7 @@ int bdrv_drop_intermediate(BlockDriverState *active, BlockDriverState *top,
 
     ret = 0;
 exit:
+    g_free(base_filename);
     return ret;
 }
 
@@ -3119,7 +3129,7 @@ char *bdrv_get_encrypted_filename(BlockDriverState *bs)
     if (bs->backing && bs->backing->bs->encrypted) {
         return g_strdup(bs->backing_file);
     } else if (bs->encrypted) {
-        return g_strdup(bs->filename);
+        return bdrv_filename(bs, NULL, 0);
     } else {
         return NULL;
     }
@@ -3214,7 +3224,7 @@ bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag)
 }
 
 /* backing_file can either be relative, or absolute, or a protocol.  If it is
- * relative, it must be relative to the chain.  So, passing in bs->filename
+ * relative, it must be relative to the chain.  So, passing in the filename
  * from a BDS as backing_file should not be done, as that may be relative to
  * the CWD rather than the chain. */
 BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
@@ -4118,8 +4128,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     /* This BDS's file name may depend on any of its children's file names, so
      * refresh those first */
     QLIST_FOREACH(child, &bs->children, next) {
-        bdrv_filename(child->bs, child->bs->filename,
-                      sizeof(child->bs->filename));
+        bdrv_refresh_filename(child->bs);
 
         if (child->role == &child_backing && child->bs->backing_overridden) {
             bs->backing_overridden = true;
diff --git a/block/commit.c b/block/commit.c
index c284e8535d..ec31ee82e7 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -230,7 +230,9 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     overlay_bs = bdrv_find_overlay(bs, top);
 
     if (overlay_bs == NULL) {
-        error_setg(errp, "Could not find overlay image for %s:", top->filename);
+        char *top_filename = bdrv_filename(top, NULL, 0);
+        error_setg(errp, "Could not find overlay image for %s:", top_filename);
+        g_free(top_filename);
         return;
     }
 
diff --git a/block/mirror.c b/block/mirror.c
index 6cb6cbd127..fb6720add9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1069,25 +1069,33 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
 
     length = bdrv_getlength(bs);
     if (length < 0) {
-        error_setg_errno(errp, -length,
-                         "Unable to determine length of %s", bs->filename);
+        char *filename = bdrv_filename(bs, NULL, 0);
+        error_setg_errno(errp, -length, "Unable to determine length of %s",
+                         filename);
+        g_free(filename);
         goto error_restore_flags;
     }
 
     base_length = bdrv_getlength(base);
     if (base_length < 0) {
+        char *base_filename = bdrv_filename(base, NULL, 0);
         error_setg_errno(errp, -base_length,
-                         "Unable to determine length of %s", base->filename);
+                         "Unable to determine length of %s", base_filename);
+        g_free(base_filename);
         goto error_restore_flags;
     }
 
     if (length > base_length) {
         ret = bdrv_truncate(base, length);
         if (ret < 0) {
+            char *filename = bdrv_filename(bs, NULL, 0);
+            char *base_filename = bdrv_filename(base, NULL, 0);
             error_setg_errno(errp, -ret,
                             "Top image %s is larger than base image %s, and "
                              "resize of base image failed",
-                             bs->filename, base->filename);
+                             filename, base_filename);
+            g_free(filename);
+            g_free(base_filename);
             goto error_restore_flags;
         }
     }
diff --git a/block/nbd.c b/block/nbd.c
index ea5d7a819e..bd58979511 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -533,6 +533,7 @@ static char *nbd_dirname(BlockDriverState *bs, Error **errp)
 {
     BDRVNBDState *s = bs->opaque;
     const char *host = NULL, *port = NULL, *path = NULL;
+    char *filename;
 
     if (s->saddr->type == SOCKET_ADDRESS_KIND_INET) {
         const InetSocketAddress *inet = s->saddr->u.inet.data;
@@ -552,8 +553,10 @@ static char *nbd_dirname(BlockDriverState *bs, Error **errp)
                                s->export ?: "", s->export ? "/" : "");
     }
 
+    filename = bdrv_filename(bs, NULL, 0);
     error_setg(errp, "Cannot generate a base directory for NBD node '%s'",
-               bs->filename);
+               filename);
+    g_free(filename);
     return NULL;
 }
 
diff --git a/block/nfs.c b/block/nfs.c
index 6e68c27437..16fbc5fba7 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -795,8 +795,10 @@ static char *nfs_dirname(BlockDriverState *bs, Error **errp)
     NFSClient *client = bs->opaque;
 
     if (client->uid || client->gid) {
+        char *filename = bdrv_filename(bs, NULL, 0);
         error_setg(errp, "Cannot generate a base directory for NBD node '%s'",
-                   bs->filename);
+                   filename);
+        g_free(filename);
         return NULL;
     }
 
diff --git a/block/qapi.c b/block/qapi.c
index 1543dd691a..d76bf95dce 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -41,7 +41,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
     BlockDriverState *bs0;
     BlockDeviceInfo *info = g_malloc0(sizeof(*info));
 
-    info->file                   = g_strdup(bs->filename);
+    info->file                   = bdrv_filename(bs, NULL, 0);
     info->ro                     = bs->read_only;
     info->drv                    = g_strdup(bs->drv->format_name);
     info->encrypted              = bs->encrypted;
@@ -243,7 +243,7 @@ void bdrv_query_image_info(BlockDriverState *bs,
     }
 
     info = g_new0(ImageInfo, 1);
-    info->filename        = g_strdup(bs->filename);
+    info->filename        = bdrv_filename(bs, NULL, 0);
     info->format          = g_strdup(bdrv_get_format_name(bs));
     info->virtual_size    = size;
     info->actual_size     = bdrv_get_allocated_file_size(bs);
diff --git a/block/raw-format.c b/block/raw-format.c
index 8404a82e0c..67539b0630 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -391,6 +391,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
         bs->file->bs->supported_zero_flags;
 
     if (bs->probed && !bdrv_is_read_only(bs)) {
+        char *filename = bdrv_filename(bs->file->bs, NULL, 0);
         fprintf(stderr,
                 "WARNING: Image format was not specified for '%s' and probing "
                 "guessed raw.\n"
@@ -398,7 +399,8 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
                 "raw images, write operations on block 0 will be restricted.\n"
                 "         Specify the 'raw' format explicitly to remove the "
                 "restrictions.\n",
-                bs->file->bs->filename);
+                filename);
+        g_free(filename);
     }
 
     ret = raw_read_options(options, bs, s, errp);
diff --git a/block/replication.c b/block/replication.c
index 4deff13645..729dd12499 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -586,7 +586,7 @@ static void replication_done(void *opaque, int ret)
         s->replication_state = BLOCK_REPLICATION_DONE;
 
         /* refresh top bs's filename */
-        bdrv_filename(bs, bs->filename, sizeof(bs->filename));
+        bdrv_refresh_filename(bs);
         s->active_disk = NULL;
         s->secondary_disk = NULL;
         s->hidden_disk = NULL;
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 02eb104310..e7f4cff7c8 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -786,14 +786,17 @@ int vhdx_parse_log(BlockDriverState *bs, BDRVVHDXState *s, bool *flushed,
 
     if (logs.valid) {
         if (bs->read_only) {
+            char *filename = bdrv_filename(bs, NULL, 0);
+
             ret = -EPERM;
             error_setg(errp,
                        "VHDX image file '%s' opened read-only, but "
                        "contains a log that needs to be replayed",
-                       bs->filename);
+                       filename);
             error_append_hint(errp,  "To replay the log, run:\n"
                               "qemu-img check -r all '%s'\n",
-                              bs->filename);
+                              filename);
+            g_free(filename);
             goto exit;
         }
         /* now flush the log */
diff --git a/block/vmdk.c b/block/vmdk.c
index 87ac4f0e68..c1100b9cb9 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -459,9 +459,11 @@ static int vmdk_init_tables(BlockDriverState *bs, VmdkExtent *extent,
                      extent->l1_table,
                      l1_size);
     if (ret < 0) {
+        char *extent_filename = bdrv_filename(extent->file->bs, NULL, 0);
         error_setg_errno(errp, -ret,
                          "Could not read l1 table from extent '%s'",
-                         extent->file->bs->filename);
+                         extent_filename);
+        g_free(extent_filename);
         goto fail_l1;
     }
     for (i = 0; i < extent->l1_size; i++) {
@@ -479,9 +481,11 @@ static int vmdk_init_tables(BlockDriverState *bs, VmdkExtent *extent,
                          extent->l1_backup_table,
                          l1_size);
         if (ret < 0) {
+            char *extent_filename = bdrv_filename(extent->file->bs, NULL, 0);
             error_setg_errno(errp, -ret,
                              "Could not read l1 backup table from extent '%s'",
-                             extent->file->bs->filename);
+                             extent_filename);
+            g_free(extent_filename);
             goto fail_l1b;
         }
         for (i = 0; i < extent->l1_size; i++) {
@@ -510,9 +514,11 @@ static int vmdk_open_vmfs_sparse(BlockDriverState *bs,
 
     ret = bdrv_pread(file, sizeof(magic), &header, sizeof(header));
     if (ret < 0) {
+        char *filename = bdrv_filename(file->bs, NULL, 0);
         error_setg_errno(errp, -ret,
                          "Could not read header from file '%s'",
-                         file->bs->filename);
+                         filename);
+        g_free(filename);
         return ret;
     }
     ret = vmdk_add_extent(bs, file, false,
@@ -587,9 +593,11 @@ static int vmdk_open_vmdk4(BlockDriverState *bs,
 
     ret = bdrv_pread(file, sizeof(magic), &header, sizeof(header));
     if (ret < 0) {
+        char *filename = bdrv_filename(file->bs, NULL, 0);
         error_setg_errno(errp, -ret,
                          "Could not read header from file '%s'",
-                         file->bs->filename);
+                         filename);
+        g_free(filename);
         return -EINVAL;
     }
     if (header.capacity == 0) {
@@ -841,8 +849,10 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
         if (!path_is_absolute(fname) && !path_has_protocol(fname) &&
             !desc_file_path[0])
         {
+            char *filename = bdrv_filename(bs->file->bs, NULL, 0);
             error_setg(errp, "Cannot use relative extent paths with VMDK "
-                       "descriptor file '%s'", bs->file->bs->filename);
+                       "descriptor file '%s'", filename);
+            g_free(filename);
             return -EINVAL;
         }
 
@@ -2169,7 +2179,7 @@ static ImageInfo *vmdk_get_extent_info(VmdkExtent *extent)
     ImageInfo *info = g_new0(ImageInfo, 1);
 
     *info = (ImageInfo){
-        .filename         = g_strdup(extent->file->bs->filename),
+        .filename         = bdrv_filename(extent->file->bs, NULL, 0),
         .format           = g_strdup(extent->type),
         .virtual_size     = extent->sectors * BDRV_SECTOR_SIZE,
         .compressed       = extent->compressed,
diff --git a/block/vpc.c b/block/vpc.c
index 8d5886f003..2d63e20f7f 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -270,9 +270,12 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
 
     checksum = be32_to_cpu(footer->checksum);
     footer->checksum = 0;
-    if (vpc_checksum(s->footer_buf, HEADER_SIZE) != checksum)
+    if (vpc_checksum(s->footer_buf, HEADER_SIZE) != checksum) {
+        char *filename = bdrv_filename(bs, NULL, 0);
         fprintf(stderr, "block-vpc: The header checksum of '%s' is "
-            "incorrect.\n", bs->filename);
+                "incorrect.\n", filename);
+        g_free(filename);
+    }
 
     /* Write 'checksum' back to footer, or else will leave it with zero. */
     footer->checksum = cpu_to_be32(checksum);
diff --git a/blockdev.c b/blockdev.c
index 4128fee78f..6f0d3957bb 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -239,10 +239,13 @@ bool drive_check_orphaned(void)
         /* Unless this is a default drive, this may be an oversight. */
         if (!blk_get_attached_dev(blk) && !dinfo->is_default &&
             dinfo->type != IF_NONE) {
+            char *filename = blk_bs(blk) ? bdrv_filename(blk_bs(blk), NULL, 0)
+                                         : NULL;
             fprintf(stderr, "Warning: Orphaned drive without device: "
                     "id=%s,file=%s,if=%s,bus=%d,unit=%d\n",
-                    blk_name(blk), blk_bs(blk) ? blk_bs(blk)->filename : "",
-                    if_name[dinfo->type], dinfo->bus, dinfo->unit);
+                    blk_name(blk), filename ?: "", if_name[dinfo->type],
+                    dinfo->bus, dinfo->unit);
+            g_free(filename);
             rs = true;
         }
     }
@@ -1715,15 +1718,18 @@ static void external_snapshot_prepare(BlkActionState *common,
         /* create new image w/backing file */
         mode = s->has_mode ? s->mode : NEW_IMAGE_MODE_ABSOLUTE_PATHS;
         if (mode != NEW_IMAGE_MODE_EXISTING) {
+            char *backing_file;
             int64_t size = bdrv_getlength(state->old_bs);
             if (size < 0) {
                 error_setg_errno(errp, -size, "bdrv_getlength failed");
                 return;
             }
-            bdrv_img_create(new_image_file, format,
-                            state->old_bs->filename,
+
+            backing_file = bdrv_filename(state->old_bs, NULL, 0);
+            bdrv_img_create(new_image_file, format, backing_file,
                             state->old_bs->drv->format_name,
                             NULL, size, flags, &local_err, false);
+            g_free(backing_file);
             if (local_err) {
                 error_propagate(errp, local_err);
                 return;
@@ -1797,8 +1803,7 @@ static void external_snapshot_commit(BlkActionState *common)
 
     if (image_was_existing) {
         state->new_bs->backing_overridden = true;
-        bdrv_filename(state->new_bs, state->new_bs->filename,
-                      sizeof(state->new_bs->filename));
+        bdrv_refresh_filename(state->new_bs);
     }
 }
 
@@ -2943,6 +2948,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     AioContext *aio_context;
     Error *local_err = NULL;
     const char *base_name = NULL;
+    char *base_bs_filename = NULL;
 
     if (!has_on_error) {
         on_error = BLOCKDEV_ON_ERROR_REPORT;
@@ -2983,7 +2989,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
             goto out;
         }
         assert(bdrv_get_aio_context(base_bs) == aio_context);
-        base_name = base_bs->filename;
+        base_name = base_bs_filename = bdrv_filename(base_bs, NULL, 0);
     }
 
     /* Check for op blockers in the whole chain between bs and base */
@@ -3015,6 +3021,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
 
 out:
     aio_context_release(aio_context);
+    g_free(base_bs_filename);
 }
 
 void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
@@ -3067,9 +3074,11 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
     top_bs = bs;
 
     if (has_top && top) {
-        if (strcmp(bs->filename, top) != 0) {
+        char *filename = bdrv_filename(bs, NULL, 0);
+        if (strcmp(filename, top) != 0) {
             top_bs = bdrv_find_backing_image(bs, top);
         }
+        g_free(filename);
     }
 
     if (top_bs == NULL) {
@@ -3205,9 +3214,11 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     if (backup->mode != NEW_IMAGE_MODE_EXISTING) {
         assert(backup->format);
         if (source) {
-            bdrv_img_create(backup->target, backup->format, source->filename,
+            char *source_filename = bdrv_filename(source, NULL, 0);
+            bdrv_img_create(backup->target, backup->format, source_filename,
                             source->drv->format_name, NULL,
                             size, flags, &local_err, false);
+            g_free(source_filename);
         } else {
             bdrv_img_create(backup->target, backup->format, NULL, NULL, NULL,
                             size, flags, &local_err, false);
@@ -3497,15 +3508,19 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         bdrv_img_create(arg->target, format,
                         NULL, NULL, NULL, size, flags, &local_err, false);
     } else {
+        char *source_filename;
+
         switch (arg->mode) {
         case NEW_IMAGE_MODE_EXISTING:
             break;
         case NEW_IMAGE_MODE_ABSOLUTE_PATHS:
             /* create new image with backing file */
+            source_filename = bdrv_filename(source, NULL, 0);
             bdrv_img_create(arg->target, format,
-                            source->filename,
+                            source_filename,
                             source->drv->format_name,
                             NULL, size, flags, &local_err, false);
+            g_free(source_filename);
             break;
         default:
             abort();
-- 
2.11.0
