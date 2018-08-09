Received: from eggs.gnu.org ([2001:4830:134:3::10]:42431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsaq-0002A4-4X
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsao-0007Xm-7W
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:35:40 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:34:58 +0200
Message-Id: <20180809213528.14738-2-mreitz@redhat.com>
In-Reply-To: <20180809213528.14738-1-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v10 01/31] block: Use
 bdrv_refresh_filename() to pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>

Before this patch, bdrv_refresh_filename() is used in a pushing manner:
Whenever the BDS graph is modified, the parents of the modified edges
are supposed to be updated (recursively upwards).  However, that is
nonviable, considering that we want child changes not to concern
parents.

Also, in the long run we want a pull model anyway: Here, we would have a
bdrv_filename() function which returns a BDS's filename, freshly
constructed.

This patch is an intermediate step.  It adds bdrv_refresh_filename()
calls before every place a BDS.filename value is used.  The only
exceptions are protocol drivers that use their own filename, which
clearly would not profit from refreshing that filename before.

Also, bdrv_get_encrypted_filename() is removed along the way (as a user
of BDS.filename), since it is completely unused.

In turn, all of the calls to bdrv_refresh_filename() before this patch
are removed, because we no longer have to call this function on graph
changes.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/block.h |  1 -
 block.c               | 31 +++++++++++++++----------------
 block/qapi.c          |  4 ++++
 block/raw-format.c    |  1 +
 block/replication.c   |  2 --
 block/vhdx-log.c      |  1 +
 block/vmdk.c          |  6 ++++++
 block/vpc.c           |  4 +++-
 blockdev.c            |  8 ++++++++
 9 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 4e0871aaf9..f9f947cb9c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -483,7 +483,6 @@ void bdrv_round_to_clusters(BlockDriverState *bs,
                             int64_t *cluster_offset,
                             int64_t *cluster_bytes);
 
-const char *bdrv_get_encrypted_filename(BlockDriverState *bs);
 void bdrv_get_backing_filename(BlockDriverState *bs,
                                char *filename, int filename_size);
 void bdrv_get_full_backing_filename(BlockDriverState *bs,
diff --git a/block.c b/block.c
index 39f373e035..8124d47360 100644
--- a/block.c
+++ b/block.c
@@ -304,8 +304,11 @@ void bdrv_get_full_backing_filename_from_filename(const char *backed,
 void bdrv_get_full_backing_filename(BlockDriverState *bs, char *dest, size_t sz,
                                     Error **errp)
 {
-    char *backed = bs->exact_filename[0] ? bs->exact_filename : bs->filename;
+    char *backed;
 
+    bdrv_refresh_filename(bs);
+
+    backed = bs->exact_filename[0] ? bs->exact_filename : bs->filename;
     bdrv_get_full_backing_filename_from_filename(backed, bs->backing_file,
                                                  dest, sz, errp);
 }
@@ -959,6 +962,8 @@ static void bdrv_backing_attach(BdrvChild *c)
                "node is used as backing hd of '%s'",
                bdrv_get_device_or_node_name(parent));
 
+    bdrv_refresh_filename(backing_hd);
+
     parent->open_flags &= ~BDRV_O_NO_BACKING;
     pstrcpy(parent->backing_file, sizeof(parent->backing_file),
             backing_hd->filename);
@@ -1361,6 +1366,7 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     }
 
     if (file != NULL) {
+        bdrv_refresh_filename(blk_bs(file));
         filename = blk_bs(file)->filename;
     } else {
         /*
@@ -2252,8 +2258,6 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
         bdrv_unref(backing_hd);
     }
 
-    bdrv_refresh_filename(bs);
-
 out:
     bdrv_refresh_limits(bs, NULL);
 }
@@ -2767,8 +2771,6 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         }
     }
 
-    bdrv_refresh_filename(bs);
-
     /* Check if any unknown options were used */
     if (qdict_size(options) != 0) {
         const QDictEntry *entry = qdict_first(options);
@@ -3200,6 +3202,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
             if (local_err != NULL) {
                 error_propagate(errp, local_err);
             } else {
+                bdrv_refresh_filename(reopen_state->bs);
                 error_setg(errp, "failed while preparing to reopen image '%s'",
                            reopen_state->bs->filename);
             }
@@ -3737,7 +3740,10 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
     /* success - we can delete the intermediate states, and link top->base */
     /* TODO Check graph modification op blockers (BLK_PERM_GRAPH_MOD) once
      * we've figured out how they should work. */
-    backing_file_str = backing_file_str ? backing_file_str : base->filename;
+    if (!backing_file_str) {
+        bdrv_refresh_filename(base);
+        backing_file_str = base->filename;
+    }
 
     QLIST_FOREACH_SAFE(c, &top->parents, next_parent, next) {
         /* Check whether we are allowed to switch c from top to base */
@@ -4133,16 +4139,6 @@ bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs)
     return bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP;
 }
 
-const char *bdrv_get_encrypted_filename(BlockDriverState *bs)
-{
-    if (bs->backing && bs->backing->bs->encrypted)
-        return bs->backing_file;
-    else if (bs->encrypted)
-        return bs->filename;
-    else
-        return NULL;
-}
-
 void bdrv_get_backing_filename(BlockDriverState *bs,
                                char *filename, int filename_size)
 {
@@ -4262,6 +4258,9 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
 
     is_protocol = path_has_protocol(backing_file);
 
+    /* This will recursively refresh everything in the backing chain */
+    bdrv_refresh_filename(bs);
+
     for (curr_bs = bs; curr_bs->backing; curr_bs = curr_bs->backing->bs) {
 
         /* If either of the filename paths is actually a protocol, then
diff --git a/block/qapi.c b/block/qapi.c
index 339727f0f4..fc575e5919 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -51,6 +51,8 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
         return NULL;
     }
 
+    bdrv_refresh_filename(bs);
+
     info = g_malloc0(sizeof(*info));
     info->file                   = g_strdup(bs->filename);
     info->ro                     = bs->read_only;
@@ -264,6 +266,8 @@ void bdrv_query_image_info(BlockDriverState *bs,
         goto out;
     }
 
+    bdrv_refresh_filename(bs);
+
     info = g_new0(ImageInfo, 1);
     info->filename        = g_strdup(bs->filename);
     info->format          = g_strdup(bdrv_get_format_name(bs));
diff --git a/block/raw-format.c b/block/raw-format.c
index 2fd69cdb08..a9ddb362a0 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -436,6 +436,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
             bs->file->bs->supported_zero_flags);
 
     if (bs->probed && !bdrv_is_read_only(bs)) {
+        bdrv_refresh_filename(bs->file->bs);
         fprintf(stderr,
                 "WARNING: Image format was not specified for '%s' and probing "
                 "guessed raw.\n"
diff --git a/block/replication.c b/block/replication.c
index 6349d6958e..d5e39be5eb 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -643,8 +643,6 @@ static void replication_done(void *opaque, int ret)
     if (ret == 0) {
         s->stage = BLOCK_REPLICATION_DONE;
 
-        /* refresh top bs's filename */
-        bdrv_refresh_filename(bs);
         s->active_disk = NULL;
         s->secondary_disk = NULL;
         s->hidden_disk = NULL;
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index d2f1b98199..3f4c11c932 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -803,6 +803,7 @@ int vhdx_parse_log(BlockDriverState *bs, BDRVVHDXState *s, bool *flushed,
 
     if (logs.valid) {
         if (bs->read_only) {
+            bdrv_refresh_filename(bs);
             ret = -EPERM;
             error_setg(errp,
                        "VHDX image file '%s' opened read-only, but "
diff --git a/block/vmdk.c b/block/vmdk.c
index a9d0084e36..87fdd647df 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -479,6 +479,7 @@ static int vmdk_init_tables(BlockDriverState *bs, VmdkExtent *extent,
                      extent->l1_table,
                      l1_size);
     if (ret < 0) {
+        bdrv_refresh_filename(extent->file->bs);
         error_setg_errno(errp, -ret,
                          "Could not read l1 table from extent '%s'",
                          extent->file->bs->filename);
@@ -499,6 +500,7 @@ static int vmdk_init_tables(BlockDriverState *bs, VmdkExtent *extent,
                          extent->l1_backup_table,
                          l1_size);
         if (ret < 0) {
+            bdrv_refresh_filename(extent->file->bs);
             error_setg_errno(errp, -ret,
                              "Could not read l1 backup table from extent '%s'",
                              extent->file->bs->filename);
@@ -530,6 +532,7 @@ static int vmdk_open_vmfs_sparse(BlockDriverState *bs,
 
     ret = bdrv_pread(file, sizeof(magic), &header, sizeof(header));
     if (ret < 0) {
+        bdrv_refresh_filename(file->bs);
         error_setg_errno(errp, -ret,
                          "Could not read header from file '%s'",
                          file->bs->filename);
@@ -607,6 +610,7 @@ static int vmdk_open_vmdk4(BlockDriverState *bs,
 
     ret = bdrv_pread(file, sizeof(magic), &header, sizeof(header));
     if (ret < 0) {
+        bdrv_refresh_filename(file->bs);
         error_setg_errno(errp, -ret,
                          "Could not read header from file '%s'",
                          file->bs->filename);
@@ -861,6 +865,7 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
         if (!path_is_absolute(fname) && !path_has_protocol(fname) &&
             !desc_file_path[0])
         {
+            bdrv_refresh_filename(bs->file->bs);
             error_setg(errp, "Cannot use relative extent paths with VMDK "
                        "descriptor file '%s'", bs->file->bs->filename);
             return -EINVAL;
@@ -2220,6 +2225,7 @@ static ImageInfo *vmdk_get_extent_info(VmdkExtent *extent)
 {
     ImageInfo *info = g_new0(ImageInfo, 1);
 
+    bdrv_refresh_filename(extent->file->bs);
     *info = (ImageInfo){
         .filename         = g_strdup(extent->file->bs->filename),
         .format           = g_strdup(extent->type),
diff --git a/block/vpc.c b/block/vpc.c
index bf294abfa7..717809cc24 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -284,9 +284,11 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
 
     checksum = be32_to_cpu(footer->checksum);
     footer->checksum = 0;
-    if (vpc_checksum(s->footer_buf, HEADER_SIZE) != checksum)
+    if (vpc_checksum(s->footer_buf, HEADER_SIZE) != checksum) {
+        bdrv_refresh_filename(bs);
         fprintf(stderr, "block-vpc: The header checksum of '%s' is "
             "incorrect.\n", bs->filename);
+    }
 
     /* Write 'checksum' back to footer, or else will leave it with zero. */
     footer->checksum = cpu_to_be32(checksum);
diff --git a/blockdev.c b/blockdev.c
index 72f5347df5..9b143d9e72 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1627,6 +1627,7 @@ static void external_snapshot_prepare(BlkActionState *common,
                 error_setg_errno(errp, -size, "bdrv_getlength failed");
                 goto out;
             }
+            bdrv_refresh_filename(state->old_bs);
             bdrv_img_create(new_image_file, format,
                             state->old_bs->filename,
                             state->old_bs->drv->format_name,
@@ -3163,6 +3164,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
             goto out;
         }
         assert(bdrv_get_aio_context(base_bs) == aio_context);
+        bdrv_refresh_filename(base_bs);
         base_name = base_bs->filename;
     }
 
@@ -3251,6 +3253,10 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
     top_bs = bs;
 
     if (has_top && top) {
+        /* This strcmp() is just a shortcut, there is no need to
+         * refresh @bs's filename.  If it mismatches,
+         * bdrv_find_backing_image() will do the refresh and may still
+         * return @bs. */
         if (strcmp(bs->filename, top) != 0) {
             top_bs = bdrv_find_backing_image(bs, top);
         }
@@ -3398,6 +3404,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
     if (backup->mode != NEW_IMAGE_MODE_EXISTING) {
         assert(backup->format);
         if (source) {
+            bdrv_refresh_filename(source);
             bdrv_img_create(backup->target, backup->format, source->filename,
                             source->drv->format_name, NULL,
                             size, flags, false, &local_err);
@@ -3748,6 +3755,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
             break;
         case NEW_IMAGE_MODE_ABSOLUTE_PATHS:
             /* create new image with backing file */
+            bdrv_refresh_filename(source);
             bdrv_img_create(arg->target, format,
                             source->filename,
                             source->drv->format_name,
-- 
2.17.1
