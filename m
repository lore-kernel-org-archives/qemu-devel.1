Received: from eggs.gnu.org ([2001:4830:134:3::10]:43811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsdU-0004cN-Ft
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsdS-0004Sx-Pg
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:38:24 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:37:57 +0200
Message-Id: <20180809213801.15098-8-mreitz@redhat.com>
In-Reply-To: <20180809213801.15098-1-mreitz@redhat.com>
References: <20180809213801.15098-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 07/11] block: Leave BDS.backing_file constant
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

Parts of the block layer treat BDS.backing_file as if it were whatever
the image header says (i.e., if it is a relative path, it is relative to
the overlay), other parts treat it like a cache for
bs->backing->bs->filename (relative paths are relative to the CWD).
Considering bs->backing->bs->filename exists, let us make it mean the
former.

Among other things, this now allows the user to specify a base when
using qemu-img to commit an image file in a directory that is not the
CWD (assuming, everything uses relative filenames).

Before this patch:

$ ./qemu-img create -f qcow2 foo/bot.qcow2 1M
$ ./qemu-img create -f qcow2 -b bot.qcow2 foo/mid.qcow2
$ ./qemu-img create -f qcow2 -b mid.qcow2 foo/top.qcow2
$ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
qemu-img: Did not find 'mid.qcow2' in the backing chain of 'foo/top.qcow2'
$ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'
$ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
qemu-img: Did not find '[...]/foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'

After this patch:

$ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
Image committed.
$ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'
$ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
Image committed.

With this change, bdrv_find_backing_image() must look at whether the
user has overridden a BDS's backing file.  If so, it can no longer use
bs->backing_file, but must instead compare the given filename against
the backing node's filename directly.

Along with this, stop updating BDS.backing_format in
bdrv_backing_attach() as well.  This necessitates a change to the
reference output of iotest 191.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h  | 14 +++++++++-----
 block.c                    | 29 ++++++++++++++++++++++-------
 block/qapi.c               |  7 ++++---
 qemu-img.c                 | 12 ++++++++++--
 tests/qemu-iotests/191.out |  1 -
 5 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index d3d8b22155..8f2c515ec1 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -737,11 +737,15 @@ struct BlockDriverState {
     bool walking_aio_notifiers; /* to make removal during iteration safe */
 
     char filename[PATH_MAX];
-    char backing_file[PATH_MAX]; /* if non zero, the image is a diff of
-                                    this file image */
-    /* The backing filename indicated by the image header; if we ever
-     * open this file, then this is replaced by the resulting BDS's
-     * filename (i.e. after a bdrv_refresh_filename() run). */
+    /* If non-zero, the image is a diff of this image file.  Note that
+     * this the name given in the image header and may therefore not
+     * be equal to .backing->bs->filename, and relative paths are
+     * resolved relatively to their overlay. */
+    char backing_file[PATH_MAX];
+    /* The backing filename indicated by the image header.  Contrary
+     * to backing_file, if we ever open this file, auto_backing_file
+     * is replaced by the resulting BDS's filename (i.e. after a
+     * bdrv_refresh_filename() run). */
     char auto_backing_file[PATH_MAX];
     char backing_format[16]; /* if non-zero and backing_file exists */
 
diff --git a/block.c b/block.c
index 9784ccb385..7fc7dbf364 100644
--- a/block.c
+++ b/block.c
@@ -78,6 +78,8 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
                                            const BdrvChildRole *child_role,
                                            Error **errp);
 
+static bool bdrv_backing_overridden(BlockDriverState *bs);
+
 /* If non-zero, use only whitelisted block drivers */
 static int use_bdrv_whitelist;
 
@@ -995,10 +997,6 @@ static void bdrv_backing_attach(BdrvChild *c)
     bdrv_refresh_filename(backing_hd);
 
     parent->open_flags &= ~BDRV_O_NO_BACKING;
-    pstrcpy(parent->backing_file, sizeof(parent->backing_file),
-            backing_hd->filename);
-    pstrcpy(parent->backing_format, sizeof(parent->backing_format),
-            backing_hd->drv ? backing_hd->drv->format_name : "");
 
     bdrv_op_block_all(backing_hd, parent->backing_blocker);
     /* Otherwise we won't be able to commit or stream */
@@ -4318,6 +4316,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     char *backing_file_full = NULL;
     char *filename_tmp = NULL;
     int is_protocol = 0;
+    bool filenames_refreshed = false;
     BlockDriverState *curr_bs = NULL;
     BlockDriverState *retval = NULL;
 
@@ -4340,9 +4339,25 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     {
         BlockDriverState *bs_below = bdrv_backing_chain_next(curr_bs);
 
-        /* If either of the filename paths is actually a protocol, then
-         * compare unmodified paths; otherwise make paths relative */
-        if (is_protocol || path_has_protocol(curr_bs->backing_file)) {
+        if (bdrv_backing_overridden(curr_bs)) {
+            /* If the backing file was overridden, we can only compare
+             * directly against the backing node's filename */
+
+            if (!filenames_refreshed) {
+                /* This will automatically refresh all of the
+                 * filenames in the rest of the backing chain, so we
+                 * only need to do this once */
+                bdrv_refresh_filename(bs_below);
+                filenames_refreshed = true;
+            }
+
+            if (strcmp(backing_file, bs_below->filename) == 0) {
+                retval = bs_below;
+                break;
+            }
+        } else if (is_protocol || path_has_protocol(curr_bs->backing_file)) {
+            /* If either of the filename paths is actually a protocol, then
+             * compare unmodified paths; otherwise make paths relative */
             char *backing_file_full_ret;
 
             if (strcmp(backing_file, curr_bs->backing_file) == 0) {
diff --git a/block/qapi.c b/block/qapi.c
index cbee819c13..f5288012f5 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -43,7 +43,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
                                         BlockDriverState *bs, Error **errp)
 {
     ImageInfo **p_image_info;
-    BlockDriverState *bs0;
+    BlockDriverState *bs0, *backing;
     BlockDeviceInfo *info;
 
     if (!bs->drv) {
@@ -72,9 +72,10 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
         info->node_name = g_strdup(bs->node_name);
     }
 
-    if (bs->backing_file[0]) {
+    backing = bdrv_filtered_cow_bs(bs);
+    if (backing) {
         info->has_backing_file = true;
-        info->backing_file = g_strdup(bs->backing_file);
+        info->backing_file = g_strdup(backing->filename);
     }
 
     info->detect_zeroes = bs->detect_zeroes;
diff --git a/qemu-img.c b/qemu-img.c
index 307e72c9fd..6d405fb6d4 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3292,7 +3292,7 @@ static int img_rebase(int argc, char **argv)
 
     /* For safe rebasing we need to compare old and new backing file */
     if (!unsafe) {
-        char backing_name[PATH_MAX];
+        char *backing_name;
         QDict *options = NULL;
 
         if (bs->backing_format[0] != '\0') {
@@ -3306,16 +3306,24 @@ static int img_rebase(int argc, char **argv)
             }
             qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
         }
-        bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
+        backing_name = bdrv_get_full_backing_filename(bs, &local_err);
+        if (local_err) {
+            error_reportf_err(local_err,
+                              "Could not resolve old backing file name: ");
+            ret = -1;
+            goto out;
+        }
         blk_old_backing = blk_new_open(backing_name, NULL,
                                        options, src_flags, &local_err);
         if (!blk_old_backing) {
             error_reportf_err(local_err,
                               "Could not open old backing file '%s': ",
                               backing_name);
+            g_free(backing_name);
             ret = -1;
             goto out;
         }
+        g_free(backing_name);
 
         if (out_baseimg[0]) {
             const char *overlay_filename;
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 31a0c7d4c4..b87cddc56f 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -604,7 +604,6 @@ wrote 65536/65536 bytes at offset 1048576
                     "backing-filename": "TEST_DIR/t.IMGFMT.base",
                     "dirty-flag": false
                 },
-                "backing-filename-format": "IMGFMT",
                 "virtual-size": 67108864,
                 "filename": "TEST_DIR/t.IMGFMT.ovl3",
                 "cluster-size": 65536,
-- 
2.17.1
