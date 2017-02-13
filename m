Received: from eggs.gnu.org ([2001:4830:134:3::10]:59607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKME-0003a5-5M
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMC-0006Fa-FZ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:10 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:48 +0100
Message-Id: <1487006583-24350-27-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 26/41] block: Factor out bdrv_open_driver()
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

This is a function that doesn't do any option parsing, but just does
some basic BlockDriverState setup and calls the .bdrv_open() function of
the block driver.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 112 +++++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 65 insertions(+), 47 deletions(-)

diff --git a/block.c b/block.c
index 842ac78..9c80cba 100644
--- a/block.c
+++ b/block.c
@@ -934,6 +934,67 @@ out:
     g_free(gen_node_name);
 }
 
+static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
+                            const char *node_name, QDict *options,
+                            int open_flags, Error **errp)
+{
+    Error *local_err = NULL;
+    int ret;
+
+    bdrv_assign_node_name(bs, node_name, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -EINVAL;
+    }
+
+    bs->drv = drv;
+    bs->opaque = g_malloc0(drv->instance_size);
+
+    if (drv->bdrv_file_open) {
+        assert(!drv->bdrv_needs_filename || bs->filename[0]);
+        ret = drv->bdrv_file_open(bs, options, open_flags, &local_err);
+    } else {
+        ret = drv->bdrv_open(bs, options, open_flags, &local_err);
+    }
+
+    if (ret < 0) {
+        if (local_err) {
+            error_propagate(errp, local_err);
+        } else if (bs->filename[0]) {
+            error_setg_errno(errp, -ret, "Could not open '%s'", bs->filename);
+        } else {
+            error_setg_errno(errp, -ret, "Could not open image");
+        }
+        goto free_and_fail;
+    }
+
+    ret = refresh_total_sectors(bs, bs->total_sectors);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not refresh total sector count");
+        goto free_and_fail;
+    }
+
+    bdrv_refresh_limits(bs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto free_and_fail;
+    }
+
+    assert(bdrv_opt_mem_align(bs) != 0);
+    assert(bdrv_min_mem_align(bs) != 0);
+    assert(is_power_of_2(bs->bl.request_alignment));
+
+    return 0;
+
+free_and_fail:
+    /* FIXME Close bs first if already opened*/
+    g_free(bs->opaque);
+    bs->opaque = NULL;
+    bs->drv = NULL;
+    return ret;
+}
+
 QemuOptsList bdrv_runtime_opts = {
     .name = "bdrv_common",
     .head = QTAILQ_HEAD_INITIALIZER(bdrv_runtime_opts.head),
@@ -1028,14 +1089,6 @@ static int bdrv_open_common(BlockDriverState *bs, BdrvChild *file,
     trace_bdrv_open_common(bs, filename ?: "", bs->open_flags,
                            drv->format_name);
 
-    node_name = qemu_opt_get(opts, "node-name");
-    bdrv_assign_node_name(bs, node_name, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EINVAL;
-        goto fail_opts;
-    }
-
     bs->read_only = !(bs->open_flags & BDRV_O_RDWR);
 
     if (use_bdrv_whitelist && !bdrv_is_whitelisted(drv, bs->read_only)) {
@@ -1101,54 +1154,19 @@ static int bdrv_open_common(BlockDriverState *bs, BdrvChild *file,
     }
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename), bs->filename);
 
-    bs->drv = drv;
-    bs->opaque = g_malloc0(drv->instance_size);
-
     /* Open the image, either directly or using a protocol */
     open_flags = bdrv_open_flags(bs, bs->open_flags);
-    if (drv->bdrv_file_open) {
-        assert(file == NULL);
-        assert(!drv->bdrv_needs_filename || filename != NULL);
-        ret = drv->bdrv_file_open(bs, options, open_flags, &local_err);
-    } else {
-        ret = drv->bdrv_open(bs, options, open_flags, &local_err);
-    }
-
-    if (ret < 0) {
-        if (local_err) {
-            error_propagate(errp, local_err);
-        } else if (bs->filename[0]) {
-            error_setg_errno(errp, -ret, "Could not open '%s'", bs->filename);
-        } else {
-            error_setg_errno(errp, -ret, "Could not open image");
-        }
-        goto free_and_fail;
-    }
+    node_name = qemu_opt_get(opts, "node-name");
 
-    ret = refresh_total_sectors(bs, bs->total_sectors);
+    assert(!drv->bdrv_file_open || file == NULL);
+    ret = bdrv_open_driver(bs, drv, node_name, options, open_flags, errp);
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "Could not refresh total sector count");
-        goto free_and_fail;
-    }
-
-    bdrv_refresh_limits(bs, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EINVAL;
-        goto free_and_fail;
+        goto fail_opts;
     }
 
-    assert(bdrv_opt_mem_align(bs) != 0);
-    assert(bdrv_min_mem_align(bs) != 0);
-    assert(is_power_of_2(bs->bl.request_alignment));
-
     qemu_opts_del(opts);
     return 0;
 
-free_and_fail:
-    g_free(bs->opaque);
-    bs->opaque = NULL;
-    bs->drv = NULL;
 fail_opts:
     qemu_opts_del(opts);
     return ret;
-- 
1.8.3.1
