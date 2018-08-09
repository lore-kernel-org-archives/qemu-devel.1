Received: from eggs.gnu.org ([2001:4830:134:3::10]:60423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntT4-00084W-Aw
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntT1-0002iP-OT
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:42 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Aug 2018 00:31:13 +0200
Message-Id: <20180809223117.7846-8-mreitz@redhat.com>
In-Reply-To: <20180809223117.7846-1-mreitz@redhat.com>
References: <20180809223117.7846-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/11] block: Leave BDS.backing_file constant
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

Note that this changes the QAPI output for a node's backing_file.  We
had very inconsistent output there (sometimes what the image header
said, sometimes the actual filename of the backing image).  This
inconsistent output was effectively useless, so we have to decide one
way or the other.  Considering that bs->backing_file usually at runtime
contained the path to the image relative to qemu's CWD (or absolute),
this patch changes QAPI's backing_file to always report the
bs->backing->bs->filename from now on.  If you want to receive the image
header information, you have to refer to full-backing-filename.

This necessitates a change to iotest 228.  The interesting information
it really wanted is the image header, and it can get that now, but it
has to use full-backing-filename instead of backing_file.  Because of
this patch's changes to bs->backing_file's behavior, we also need some
reference output changes.

Along with the changes to bs->backing_file, stop updating
BDS.backing_format in bdrv_backing_attach() as well.  This necessitates
a change to the reference output of iotest 191.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h  | 14 +++++++++-----
 block.c                    | 29 ++++++++++++++++++++++-------
 block/qapi.c               |  7 ++++---
 qemu-img.c                 | 12 ++++++++++--
 tests/qemu-iotests/191.out |  1 -
 tests/qemu-iotests/228     |  6 +++---
 tests/qemu-iotests/228.out |  6 +++---
 7 files changed, 51 insertions(+), 24 deletions(-)

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
index 69b56771f7..434074b7dd 100644
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
diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
index a2200efba5..5f46a1c2c8 100755
--- a/tests/qemu-iotests/228
+++ b/tests/qemu-iotests/228
@@ -33,7 +33,7 @@ def log_node_info(node):
 
     log('bs->filename: ' + node['image']['filename'],
         filters=[filter_testfiles, filter_imgfmt])
-    log('bs->backing_file: ' + node['backing_file'],
+    log('bs->backing_file: ' + node['image']['full-backing-filename'],
         filters=[filter_testfiles, filter_imgfmt])
 
     if 'backing-image' in node['image']:
@@ -69,8 +69,8 @@ with iotests.FilePath('base.img') as base_img_path, \
                 },
                 filters=[filter_testfiles, filter_imgfmt])
 
-    # Filename should be plain, and the backing filename should not
-    # contain the "file:" prefix
+    # Filename should be plain, and the backing node filename should
+    # not contain the "file:" prefix
     log_node_info(vm.node_info('node0'))
 
     vm.qmp_log('blockdev-del', node_name='node0')
diff --git a/tests/qemu-iotests/228.out b/tests/qemu-iotests/228.out
index b01de766bc..e9a91c7af0 100644
--- a/tests/qemu-iotests/228.out
+++ b/tests/qemu-iotests/228.out
@@ -4,7 +4,7 @@
 {u'return': {}}
 
 bs->filename: TEST_DIR/PID-top.img
-bs->backing_file: TEST_DIR/PID-base.img
+bs->backing_file: file:TEST_DIR/PID-base.img
 bs->backing->bs->filename: TEST_DIR/PID-base.img
 
 {'execute': 'blockdev-del', 'arguments': {'node_name': 'node0'}}
@@ -41,7 +41,7 @@ bs->backing->bs->filename: TEST_DIR/PID-base.img
 {u'return': {}}
 
 bs->filename: TEST_DIR/PID-top.img
-bs->backing_file: TEST_DIR/PID-base.img
+bs->backing_file: file:TEST_DIR/PID-base.img
 bs->backing->bs->filename: TEST_DIR/PID-base.img
 
 {'execute': 'blockdev-del', 'arguments': {'node_name': 'node0'}}
@@ -55,7 +55,7 @@ bs->backing->bs->filename: TEST_DIR/PID-base.img
 {u'return': {}}
 
 bs->filename: json:{"backing": {"driver": "null-co"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-top.img"}}
-bs->backing_file: null-co://
+bs->backing_file: TEST_DIR/PID-base.img
 bs->backing->bs->filename: null-co://
 
 {'execute': 'blockdev-del', 'arguments': {'node_name': 'node0'}}
-- 
2.17.1
