Received: from eggs.gnu.org ([2001:4830:134:3::10]:47218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwSUn-0003VG-KQ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwSUm-000655-Iv
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:28:21 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Sep 2017 14:28:04 +0200
Message-Id: <20170925122808.14561-2-kwolf@redhat.com>
In-Reply-To: <20170925122808.14561-1-kwolf@redhat.com>
References: <20170925122808.14561-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] block: Introduce
 BdrvChildRole.update_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

There is no good reason for bdrv_drop_intermediate() to know the active
layer above the subchain it is operating on - even more so, because
the assumption that there is a single active layer above it is not
generally true.

In order to prepare removal of the active parameter, use a BdrvChildRole
callback to update the backing file string in the overlay image instead
of directly calling bdrv_change_backing_file().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |  6 ++++++
 block.c                   | 33 ++++++++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 99abe2ce74..e6d53cc15e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -544,6 +544,12 @@ struct BdrvChildRole {
 
     void (*attach)(BdrvChild *child);
     void (*detach)(BdrvChild *child);
+
+    /* Notifies the parent that the filename of its child has changed (e.g.
+     * because the direct child was removed from the backing chain), so that it
+     * can update its reference. */
+    int (*update_filename)(BdrvChild *child, BlockDriverState *new_base,
+                           const char *filename, Error **errp);
 };
 
 extern const BdrvChildRole child_file;
diff --git a/block.c b/block.c
index 5c65fac672..7ac8cd521b 100644
--- a/block.c
+++ b/block.c
@@ -981,6 +981,21 @@ static void bdrv_backing_options(int *child_flags, QDict *child_options,
     *child_flags = flags;
 }
 
+static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
+                                        const char *filename, Error **errp)
+{
+    BlockDriverState *parent = c->opaque;
+    int ret;
+
+    ret = bdrv_change_backing_file(parent, filename,
+                                   base->drv ? base->drv->format_name : "");
+    if (ret < 0) {
+        error_setg_errno(errp, ret, "Could not update backing file link");
+    }
+
+    return ret;
+}
+
 const BdrvChildRole child_backing = {
     .get_parent_desc = bdrv_child_get_parent_desc,
     .attach          = bdrv_backing_attach,
@@ -989,6 +1004,7 @@ const BdrvChildRole child_backing = {
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_end     = bdrv_child_cb_drained_end,
     .inactivate      = bdrv_child_cb_inactivate,
+    .update_filename = bdrv_backing_update_filename,
 };
 
 static int bdrv_open_flags(BlockDriverState *bs, int flags)
@@ -3470,6 +3486,8 @@ int bdrv_drop_intermediate(BlockDriverState *active, BlockDriverState *top,
     Error *local_err = NULL;
     int ret = -EIO;
 
+    bdrv_ref(top);
+
     if (!top->drv || !base->drv) {
         goto exit;
     }
@@ -3494,11 +3512,15 @@ int bdrv_drop_intermediate(BlockDriverState *active, BlockDriverState *top,
     }
 
     /* success - we can delete the intermediate states, and link top->base */
-    backing_file_str = backing_file_str ? backing_file_str : base->filename;
-    ret = bdrv_change_backing_file(new_top_bs, backing_file_str,
-                                   base->drv ? base->drv->format_name : "");
-    if (ret) {
-        goto exit;
+    if (new_top_bs->backing->role->update_filename) {
+        backing_file_str = backing_file_str ? backing_file_str : base->filename;
+        ret = new_top_bs->backing->role->update_filename(new_top_bs->backing,
+                                                         base, backing_file_str,
+                                                         &local_err);
+        if (ret < 0) {
+            bdrv_set_backing_hd(new_top_bs, top, &error_abort);
+            goto exit;
+        }
     }
 
     bdrv_set_backing_hd(new_top_bs, base, &local_err);
@@ -3510,6 +3532,7 @@ int bdrv_drop_intermediate(BlockDriverState *active, BlockDriverState *top,
 
     ret = 0;
 exit:
+    bdrv_unref(top);
     return ret;
 }
 
-- 
2.13.5
