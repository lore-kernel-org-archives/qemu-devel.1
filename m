Received: from eggs.gnu.org ([2001:4830:134:3::10]:57848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evlDQ-0005uA-T9
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evlDP-00071l-UO
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:47:48 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 15:47:27 +0100
Message-Id: <20180313144730.2184-6-kwolf@redhat.com>
In-Reply-To: <20180313144730.2184-1-kwolf@redhat.com>
References: <20180313144730.2184-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/8] vdi: Make comments consistent with
 other drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This makes the .bdrv_co_create(_opts) implementation of vdi look more
like the other recently converted block drivers.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vdi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 8132e3adfe..d939b034c4 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -742,7 +742,7 @@ static int coroutine_fn vdi_co_do_create(BlockdevCreateOptions *create_options,
 
     logout("\n");
 
-    /* Read out options. */
+    /* Validate options and set default values */
     bytes = vdi_opts->size;
     if (vdi_opts->q_static) {
         image_type = VDI_TYPE_STATIC;
@@ -772,6 +772,7 @@ static int coroutine_fn vdi_co_do_create(BlockdevCreateOptions *create_options,
         goto exit;
     }
 
+    /* Create BlockBackend to write to the image */
     bs_file = bdrv_open_blockdev_ref(vdi_opts->file, errp);
     if (!bs_file) {
         ret = -EIO;
@@ -877,7 +878,9 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
     Error *local_err = NULL;
     int ret;
 
-    /* Since CONFIG_VDI_BLOCK_SIZE is disabled by default,
+    /* Parse options and convert legacy syntax.
+     *
+     * Since CONFIG_VDI_BLOCK_SIZE is disabled by default,
      * cluster-size is not part of the QAPI schema; therefore we have
      * to parse it before creating the QAPI object. */
 #if defined(CONFIG_VDI_BLOCK_SIZE)
@@ -895,6 +898,7 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
 
     qdict = qemu_opts_to_qdict_filtered(opts, NULL, &vdi_create_opts, true);
 
+    /* Create and open the file (protocol layer) */
     ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
         goto done;
@@ -921,10 +925,12 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
         goto done;
     }
 
+    /* Silently round up size */
     assert(create_options->driver == BLOCKDEV_DRIVER_VDI);
     create_options->u.vdi.size = ROUND_UP(create_options->u.vdi.size,
                                           BDRV_SECTOR_SIZE);
 
+    /* Create the vdi image (format layer) */
     ret = vdi_co_do_create(create_options, block_size, errp);
 done:
     QDECREF(qdict);
@@ -981,8 +987,8 @@ static BlockDriver bdrv_vdi = {
     .bdrv_close = vdi_close,
     .bdrv_reopen_prepare = vdi_reopen_prepare,
     .bdrv_child_perm          = bdrv_format_default_perms,
-    .bdrv_co_create_opts = vdi_co_create_opts,
     .bdrv_co_create      = vdi_co_create,
+    .bdrv_co_create_opts = vdi_co_create_opts,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_block_status = vdi_co_block_status,
     .bdrv_make_empty = vdi_make_empty,
-- 
2.13.6
