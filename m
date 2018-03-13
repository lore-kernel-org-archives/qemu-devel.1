Received: from eggs.gnu.org ([2001:4830:134:3::10]:59732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdP-0001fW-Oe
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdO-0004m5-KH
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:43 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:52 +0100
Message-Id: <20180313161803.1814-31-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 30/41] vdi: Implement .bdrv_co_create
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

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  2 +-
 block/vdi.c          | 24 +++++++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index c69d70d7a8..6211b8222c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3837,7 +3837,7 @@
       'sheepdog':       'BlockdevCreateOptionsSheepdog',
       'ssh':            'BlockdevCreateOptionsSsh',
       'throttle':       'BlockdevCreateNotSupported',
-      'vdi':            'BlockdevCreateNotSupported',
+      'vdi':            'BlockdevCreateOptionsVdi',
       'vhdx':           'BlockdevCreateNotSupported',
       'vmdk':           'BlockdevCreateNotSupported',
       'vpc':            'BlockdevCreateNotSupported',
diff --git a/block/vdi.c b/block/vdi.c
index 2a39b0ac98..8132e3adfe 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -721,9 +721,10 @@ nonallocating_write:
     return ret;
 }
 
-static int coroutine_fn vdi_co_do_create(BlockdevCreateOptionsVdi *vdi_opts,
+static int coroutine_fn vdi_co_do_create(BlockdevCreateOptions *create_options,
                                          size_t block_size, Error **errp)
 {
+    BlockdevCreateOptionsVdi *vdi_opts;
     int ret = 0;
     uint64_t bytes = 0;
     uint32_t blocks;
@@ -736,6 +737,9 @@ static int coroutine_fn vdi_co_do_create(BlockdevCreateOptionsVdi *vdi_opts,
     BlockBackend *blk = NULL;
     uint32_t *bmap = NULL;
 
+    assert(create_options->driver == BLOCKDEV_DRIVER_VDI);
+    vdi_opts = &create_options->u.vdi;
+
     logout("\n");
 
     /* Read out options. */
@@ -856,11 +860,17 @@ exit:
     return ret;
 }
 
+static int coroutine_fn vdi_co_create(BlockdevCreateOptions *create_options,
+                                      Error **errp)
+{
+    return vdi_co_do_create(create_options, DEFAULT_CLUSTER_SIZE, errp);
+}
+
 static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
                                            Error **errp)
 {
     QDict *qdict = NULL;
-    BlockdevCreateOptionsVdi *create_options = NULL;
+    BlockdevCreateOptions *create_options = NULL;
     BlockDriverState *bs_file = NULL;
     uint64_t block_size = DEFAULT_CLUSTER_SIZE;
     Visitor *v;
@@ -897,11 +907,12 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
         goto done;
     }
 
+    qdict_put_str(qdict, "driver", "vdi");
     qdict_put_str(qdict, "file", bs_file->node_name);
 
     /* Get the QAPI object */
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    visit_type_BlockdevCreateOptionsVdi(v, NULL, &create_options, &local_err);
+    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
     visit_free(v);
 
     if (local_err) {
@@ -910,12 +921,14 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
         goto done;
     }
 
-    create_options->size = ROUND_UP(create_options->size, BDRV_SECTOR_SIZE);
+    assert(create_options->driver == BLOCKDEV_DRIVER_VDI);
+    create_options->u.vdi.size = ROUND_UP(create_options->u.vdi.size,
+                                          BDRV_SECTOR_SIZE);
 
     ret = vdi_co_do_create(create_options, block_size, errp);
 done:
     QDECREF(qdict);
-    qapi_free_BlockdevCreateOptionsVdi(create_options);
+    qapi_free_BlockdevCreateOptions(create_options);
     bdrv_unref(bs_file);
     return ret;
 }
@@ -969,6 +982,7 @@ static BlockDriver bdrv_vdi = {
     .bdrv_reopen_prepare = vdi_reopen_prepare,
     .bdrv_child_perm          = bdrv_format_default_perms,
     .bdrv_co_create_opts = vdi_co_create_opts,
+    .bdrv_co_create      = vdi_co_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_block_status = vdi_co_block_status,
     .bdrv_make_empty = vdi_make_empty,
-- 
2.13.6
