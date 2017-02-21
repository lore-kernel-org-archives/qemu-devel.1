Received: from eggs.gnu.org ([2001:4830:134:3::10]:42583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuK-00086J-Lo
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuJ-0007lz-GT
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:12 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:03 +0100
Message-Id: <1487689130-30373-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 07/54] block: Use BlockBackend for image probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This fixes the use of a parent-less BdrvChild in bdrv_open_inherit() by
converting it into a BlockBackend. Which is exactly what it should be,
image probing is an external, standalone user of a node. The requests
can't be considered to originate from the format driver node because
that one isn't even opened yet.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/block.c b/block.c
index e9d90aa..0f17576 100644
--- a/block.c
+++ b/block.c
@@ -588,21 +588,20 @@ BlockDriver *bdrv_probe_all(const uint8_t *buf, int buf_size,
     return drv;
 }
 
-static int find_image_format(BdrvChild *file, const char *filename,
+static int find_image_format(BlockBackend *file, const char *filename,
                              BlockDriver **pdrv, Error **errp)
 {
-    BlockDriverState *bs = file->bs;
     BlockDriver *drv;
     uint8_t buf[BLOCK_PROBE_BUF_SIZE];
     int ret = 0;
 
     /* Return the raw BlockDriver * to scsi-generic devices or empty drives */
-    if (bdrv_is_sg(bs) || !bdrv_is_inserted(bs) || bdrv_getlength(bs) == 0) {
+    if (blk_is_sg(file) || !blk_is_inserted(file) || blk_getlength(file) == 0) {
         *pdrv = &bdrv_raw;
         return ret;
     }
 
-    ret = bdrv_pread(file, 0, buf, sizeof(buf));
+    ret = blk_pread(file, 0, buf, sizeof(buf));
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not read image for determining its "
                          "format");
@@ -974,7 +973,7 @@ QemuOptsList bdrv_runtime_opts = {
  *
  * Removes all processed options from *options.
  */
-static int bdrv_open_common(BlockDriverState *bs, BdrvChild *file,
+static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
                             QDict *options, Error **errp)
 {
     int ret, open_flags;
@@ -1005,7 +1004,7 @@ static int bdrv_open_common(BlockDriverState *bs, BdrvChild *file,
     assert(drv != NULL);
 
     if (file != NULL) {
-        filename = file->bs->filename;
+        filename = blk_bs(file)->filename;
     } else {
         filename = qdict_get_try_str(options, "filename");
     }
@@ -1707,7 +1706,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
                                            Error **errp)
 {
     int ret;
-    BdrvChild *file = NULL;
+    BlockBackend *file = NULL;
     BlockDriverState *bs;
     BlockDriver *drv = NULL;
     const char *drvname;
@@ -1805,19 +1804,24 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         qdict_del(options, "backing");
     }
 
-    /* Open image file without format layer. This BdrvChild is only used for
+    /* Open image file without format layer. This BlockBackend is only used for
      * probing, the block drivers will do their own bdrv_open_child() for the
      * same BDS, which is why we put the node name back into options. */
     if ((flags & BDRV_O_PROTOCOL) == 0) {
-        /* FIXME Shouldn't attach a child to a node that isn't opened yet. */
-        file = bdrv_open_child(filename, options, "file", bs,
-                               &child_file, true, &local_err);
+        BlockDriverState *file_bs;
+
+        file_bs = bdrv_open_child_bs(filename, options, "file", bs,
+                                     &child_file, true, &local_err);
         if (local_err) {
             goto fail;
         }
-        if (file != NULL) {
+        if (file_bs != NULL) {
+            file = blk_new();
+            blk_insert_bs(file, file_bs);
+            bdrv_unref(file_bs);
+
             qdict_put(options, "file",
-                      qstring_from_str(bdrv_get_node_name(file->bs)));
+                      qstring_from_str(bdrv_get_node_name(file_bs)));
         }
     }
 
@@ -1859,7 +1863,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
     }
 
     if (file) {
-        bdrv_unref_child(bs, file);
+        blk_unref(file);
         file = NULL;
     }
 
@@ -1922,7 +1926,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
 
 fail:
     if (file != NULL) {
-        bdrv_unref_child(bs, file);
+        blk_unref(file);
     }
     if (bs->file != NULL) {
         bdrv_unref_child(bs, bs->file);
-- 
1.8.3.1
