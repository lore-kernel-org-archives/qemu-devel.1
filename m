Received: from eggs.gnu.org ([209.51.188.92]:46642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeVr-0005ld-6C
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeVm-0002Oy-U2
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:06 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:05 +0100
Message-Id: <20190201192935.18394-2-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 01/31] block: Use bdrv_refresh_filename()
 to pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

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
---
 include/block/block.h |  1 -
 block.c               | 31 +++++++++++++++----------------
 block/qapi.c          |  4 ++++
 block/raw-format.c    |  1 +
 block/replication.c   |  2 --
 block/vhdx-log.c      |  1 +
 block/vmdk.c          |  6 ++++++
 blockdev.c            |  8 ++++++++
 qemu-img.c            | 11 +++++++++--
 9 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 57233cf2c0..2eecff73fe 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -484,7 +484,6 @@ void bdrv_round_to_clusters(BlockDriverState *bs,
                             int64_t *cluster_offset,
                             int64_t *cluster_bytes);
=20
-const char *bdrv_get_encrypted_filename(BlockDriverState *bs);
 void bdrv_get_backing_filename(BlockDriverState *bs,
                                char *filename, int filename_size);
 void bdrv_get_full_backing_filename(BlockDriverState *bs,
diff --git a/block.c b/block.c
index b67d9b7b65..e93334d9fc 100644
--- a/block.c
+++ b/block.c
@@ -323,8 +323,11 @@ void bdrv_get_full_backing_filename_from_filename(co=
nst char *backed,
 void bdrv_get_full_backing_filename(BlockDriverState *bs, char *dest, si=
ze_t sz,
                                     Error **errp)
 {
-    char *backed =3D bs->exact_filename[0] ? bs->exact_filename : bs->fi=
lename;
+    char *backed;
=20
+    bdrv_refresh_filename(bs);
+
+    backed =3D bs->exact_filename[0] ? bs->exact_filename : bs->filename=
;
     bdrv_get_full_backing_filename_from_filename(backed, bs->backing_fil=
e,
                                                  dest, sz, errp);
 }
@@ -1004,6 +1007,8 @@ static void bdrv_backing_attach(BdrvChild *c)
                "node is used as backing hd of '%s'",
                bdrv_get_device_or_node_name(parent));
=20
+    bdrv_refresh_filename(backing_hd);
+
     parent->open_flags &=3D ~BDRV_O_NO_BACKING;
     pstrcpy(parent->backing_file, sizeof(parent->backing_file),
             backing_hd->filename);
@@ -1413,6 +1418,7 @@ static int bdrv_open_common(BlockDriverState *bs, B=
lockBackend *file,
     }
=20
     if (file !=3D NULL) {
+        bdrv_refresh_filename(blk_bs(file));
         filename =3D blk_bs(file)->filename;
     } else {
         /*
@@ -2309,8 +2315,6 @@ void bdrv_set_backing_hd(BlockDriverState *bs, Bloc=
kDriverState *backing_hd,
         bdrv_unref(backing_hd);
     }
=20
-    bdrv_refresh_filename(bs);
-
 out:
     bdrv_refresh_limits(bs, NULL);
 }
@@ -2839,8 +2843,6 @@ static BlockDriverState *bdrv_open_inherit(const ch=
ar *filename,
         g_free(child_key_dot);
     }
=20
-    bdrv_refresh_filename(bs);
-
     /* Check if any unknown options were used */
     if (qdict_size(options) !=3D 0) {
         const QDictEntry *entry =3D qdict_first(options);
@@ -3285,6 +3287,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_sta=
te, BlockReopenQueue *queue,
             if (local_err !=3D NULL) {
                 error_propagate(errp, local_err);
             } else {
+                bdrv_refresh_filename(reopen_state->bs);
                 error_setg(errp, "failed while preparing to reopen image=
 '%s'",
                            reopen_state->bs->filename);
             }
@@ -3881,7 +3884,10 @@ int bdrv_drop_intermediate(BlockDriverState *top, =
BlockDriverState *base,
     /* success - we can delete the intermediate states, and link top->ba=
se */
     /* TODO Check graph modification op blockers (BLK_PERM_GRAPH_MOD) on=
ce
      * we've figured out how they should work. */
-    backing_file_str =3D backing_file_str ? backing_file_str : base->fil=
ename;
+    if (!backing_file_str) {
+        bdrv_refresh_filename(base);
+        backing_file_str =3D base->filename;
+    }
=20
     QLIST_FOREACH_SAFE(c, &top->parents, next_parent, next) {
         /* Check whether we are allowed to switch c from top to base */
@@ -4429,16 +4435,6 @@ bool bdrv_can_write_zeroes_with_unmap(BlockDriverS=
tate *bs)
     return bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP;
 }
=20
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
@@ -4558,6 +4554,9 @@ BlockDriverState *bdrv_find_backing_image(BlockDriv=
erState *bs,
=20
     is_protocol =3D path_has_protocol(backing_file);
=20
+    /* This will recursively refresh everything in the backing chain */
+    bdrv_refresh_filename(bs);
+
     for (curr_bs =3D bs; curr_bs->backing; curr_bs =3D curr_bs->backing-=
>bs) {
=20
         /* If either of the filename paths is actually a protocol, then
diff --git a/block/qapi.c b/block/qapi.c
index c66f949db8..743136b84e 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -51,6 +51,8 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *b=
lk,
         return NULL;
     }
=20
+    bdrv_refresh_filename(bs);
+
     info =3D g_malloc0(sizeof(*info));
     info->file                   =3D g_strdup(bs->filename);
     info->ro                     =3D bs->read_only;
@@ -264,6 +266,8 @@ void bdrv_query_image_info(BlockDriverState *bs,
         goto out;
     }
=20
+    bdrv_refresh_filename(bs);
+
     info =3D g_new0(ImageInfo, 1);
     info->filename        =3D g_strdup(bs->filename);
     info->format          =3D g_strdup(bdrv_get_format_name(bs));
diff --git a/block/raw-format.c b/block/raw-format.c
index 6f6dc99b2c..d07bcdae62 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -436,6 +436,7 @@ static int raw_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
             bs->file->bs->supported_zero_flags);
=20
     if (bs->probed && !bdrv_is_read_only(bs)) {
+        bdrv_refresh_filename(bs->file->bs);
         fprintf(stderr,
                 "WARNING: Image format was not specified for '%s' and pr=
obing "
                 "guessed raw.\n"
diff --git a/block/replication.c b/block/replication.c
index e70dd95001..9b332002ee 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -616,8 +616,6 @@ static void replication_done(void *opaque, int ret)
     if (ret =3D=3D 0) {
         s->stage =3D BLOCK_REPLICATION_DONE;
=20
-        /* refresh top bs's filename */
-        bdrv_refresh_filename(bs);
         s->active_disk =3D NULL;
         s->secondary_disk =3D NULL;
         s->hidden_disk =3D NULL;
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index ecd64266c5..3149ff08d8 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -803,6 +803,7 @@ int vhdx_parse_log(BlockDriverState *bs, BDRVVHDXStat=
e *s, bool *flushed,
=20
     if (logs.valid) {
         if (bs->read_only) {
+            bdrv_refresh_filename(bs);
             ret =3D -EPERM;
             error_setg(errp,
                        "VHDX image file '%s' opened read-only, but "
diff --git a/block/vmdk.c b/block/vmdk.c
index 682ad93aa1..db8bf996c4 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -479,6 +479,7 @@ static int vmdk_init_tables(BlockDriverState *bs, Vmd=
kExtent *extent,
                      extent->l1_table,
                      l1_size);
     if (ret < 0) {
+        bdrv_refresh_filename(extent->file->bs);
         error_setg_errno(errp, -ret,
                          "Could not read l1 table from extent '%s'",
                          extent->file->bs->filename);
@@ -499,6 +500,7 @@ static int vmdk_init_tables(BlockDriverState *bs, Vmd=
kExtent *extent,
                          extent->l1_backup_table,
                          l1_size);
         if (ret < 0) {
+            bdrv_refresh_filename(extent->file->bs);
             error_setg_errno(errp, -ret,
                              "Could not read l1 backup table from extent=
 '%s'",
                              extent->file->bs->filename);
@@ -530,6 +532,7 @@ static int vmdk_open_vmfs_sparse(BlockDriverState *bs=
,
=20
     ret =3D bdrv_pread(file, sizeof(magic), &header, sizeof(header));
     if (ret < 0) {
+        bdrv_refresh_filename(file->bs);
         error_setg_errno(errp, -ret,
                          "Could not read header from file '%s'",
                          file->bs->filename);
@@ -607,6 +610,7 @@ static int vmdk_open_vmdk4(BlockDriverState *bs,
=20
     ret =3D bdrv_pread(file, sizeof(magic), &header, sizeof(header));
     if (ret < 0) {
+        bdrv_refresh_filename(file->bs);
         error_setg_errno(errp, -ret,
                          "Could not read header from file '%s'",
                          file->bs->filename);
@@ -861,6 +865,7 @@ static int vmdk_parse_extents(const char *desc, Block=
DriverState *bs,
         if (!path_is_absolute(fname) && !path_has_protocol(fname) &&
             !desc_file_path[0])
         {
+            bdrv_refresh_filename(bs->file->bs);
             error_setg(errp, "Cannot use relative extent paths with VMDK=
 "
                        "descriptor file '%s'", bs->file->bs->filename);
             return -EINVAL;
@@ -2470,6 +2475,7 @@ static ImageInfo *vmdk_get_extent_info(VmdkExtent *=
extent)
 {
     ImageInfo *info =3D g_new0(ImageInfo, 1);
=20
+    bdrv_refresh_filename(extent->file->bs);
     *info =3D (ImageInfo){
         .filename         =3D g_strdup(extent->file->bs->filename),
         .format           =3D g_strdup(extent->type),
diff --git a/blockdev.c b/blockdev.c
index fb18e9c975..3bab7e4f5a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1627,6 +1627,7 @@ static void external_snapshot_prepare(BlkActionStat=
e *common,
                 error_setg_errno(errp, -size, "bdrv_getlength failed");
                 goto out;
             }
+            bdrv_refresh_filename(state->old_bs);
             bdrv_img_create(new_image_file, format,
                             state->old_bs->filename,
                             state->old_bs->drv->format_name,
@@ -3216,6 +3217,7 @@ void qmp_block_stream(bool has_job_id, const char *=
job_id, const char *device,
             goto out;
         }
         assert(bdrv_get_aio_context(base_bs) =3D=3D aio_context);
+        bdrv_refresh_filename(base_bs);
         base_name =3D base_bs->filename;
     }
=20
@@ -3335,6 +3337,10 @@ void qmp_block_commit(bool has_job_id, const char =
*job_id, const char *device,
             goto out;
         }
     } else if (has_top && top) {
+        /* This strcmp() is just a shortcut, there is no need to
+         * refresh @bs's filename.  If it mismatches,
+         * bdrv_find_backing_image() will do the refresh and may still
+         * return @bs. */
         if (strcmp(bs->filename, top) !=3D 0) {
             top_bs =3D bdrv_find_backing_image(bs, top);
         }
@@ -3495,6 +3501,7 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
p, JobTxn *txn,
     if (backup->mode !=3D NEW_IMAGE_MODE_EXISTING) {
         assert(backup->format);
         if (source) {
+            bdrv_refresh_filename(source);
             bdrv_img_create(backup->target, backup->format, source->file=
name,
                             source->drv->format_name, NULL,
                             size, flags, false, &local_err);
@@ -3875,6 +3882,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
             break;
         case NEW_IMAGE_MODE_ABSOLUTE_PATHS:
             /* create new image with backing file */
+            bdrv_refresh_filename(source);
             bdrv_img_create(arg->target, format,
                             source->filename,
                             source->drv->format_name,
diff --git a/qemu-img.c b/qemu-img.c
index 25288c4d18..c077ea1c92 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2790,6 +2790,7 @@ static int get_block_status(BlockDriverState *bs, i=
nt64_t offset,
     BlockDriverState *file;
     bool has_offset;
     int64_t map;
+    char *filename =3D NULL;
=20
     /* As an optimization, we could cache the current range of unallocat=
ed
      * clusters in each file of the chain, and avoid querying the same
@@ -2817,6 +2818,11 @@ static int get_block_status(BlockDriverState *bs, =
int64_t offset,
=20
     has_offset =3D !!(ret & BDRV_BLOCK_OFFSET_VALID);
=20
+    if (file && has_offset) {
+        bdrv_refresh_filename(file);
+        filename =3D file->filename;
+    }
+
     *e =3D (MapEntry) {
         .start =3D offset,
         .length =3D bytes,
@@ -2825,8 +2831,8 @@ static int get_block_status(BlockDriverState *bs, i=
nt64_t offset,
         .offset =3D map,
         .has_offset =3D has_offset,
         .depth =3D depth,
-        .has_filename =3D file && has_offset,
-        .filename =3D file && has_offset ? file->filename : NULL,
+        .has_filename =3D filename,
+        .filename =3D filename,
     };
=20
     return 0;
@@ -3327,6 +3333,7 @@ static int img_rebase(int argc, char **argv)
                 qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
             }
=20
+            bdrv_refresh_filename(bs);
             overlay_filename =3D bs->exact_filename[0] ? bs->exact_filen=
ame
                                                      : bs->filename;
             out_real_path =3D g_malloc(PATH_MAX);
--=20
2.20.1
