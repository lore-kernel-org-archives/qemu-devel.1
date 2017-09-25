Received: from eggs.gnu.org ([2001:4830:134:3::10]:47221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwSUn-0003VJ-OH
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwSUm-00065G-L5
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:28:21 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Sep 2017 14:28:05 +0200
Message-Id: <20170925122808.14561-3-kwolf@redhat.com>
In-Reply-To: <20170925122808.14561-1-kwolf@redhat.com>
References: <20170925122808.14561-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] commit: Support multiple roots above top
 node
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

This changes the commit block job to support operation in a graph where
there is more than a single active layer that references the top node.

This involves inserting the commit filter node not only on the path
between the given active node and the top node, but between the top node
and all of its parents.

On completion, bdrv_drop_intermediate() must consider all parents for
updating the backing file link. These parents may be backing files
themselves and such read-only; reopen them temporarily if necessary.
Previously this was achieved by the bdrv_reopen() calls in the commit
block job that made overlay_bs read-write for the whole duration of the
block job, even though write access is only needed on completion.

Now that we consider all parents, overlay_bs is meaningless. It is left
in place in this commit, but we'll remove it soon.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c        | 68 ++++++++++++++++++++++++++++++++++------------------------
 block/commit.c |  2 +-
 2 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/block.c b/block.c
index 7ac8cd521b..e57fab501d 100644
--- a/block.c
+++ b/block.c
@@ -985,14 +985,26 @@ static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
                                         const char *filename, Error **errp)
 {
     BlockDriverState *parent = c->opaque;
+    int orig_flags = bdrv_get_flags(parent);
     int ret;
 
+    if (!(orig_flags & BDRV_O_RDWR)) {
+        ret = bdrv_reopen(parent, orig_flags | BDRV_O_RDWR, errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     ret = bdrv_change_backing_file(parent, filename,
                                    base->drv ? base->drv->format_name : "");
     if (ret < 0) {
         error_setg_errno(errp, ret, "Could not update backing file link");
     }
 
+    if (!(orig_flags & BDRV_O_RDWR)) {
+        bdrv_reopen(parent, orig_flags, NULL);
+    }
+
     return ret;
 }
 
@@ -3482,7 +3494,7 @@ BlockDriverState *bdrv_find_base(BlockDriverState *bs)
 int bdrv_drop_intermediate(BlockDriverState *active, BlockDriverState *top,
                            BlockDriverState *base, const char *backing_file_str)
 {
-    BlockDriverState *new_top_bs = NULL;
+    BdrvChild *c, *next;
     Error *local_err = NULL;
     int ret = -EIO;
 
@@ -3492,42 +3504,42 @@ int bdrv_drop_intermediate(BlockDriverState *active, BlockDriverState *top,
         goto exit;
     }
 
-    new_top_bs = bdrv_find_overlay(active, top);
-
-    if (new_top_bs == NULL) {
-        /* we could not find the image above 'top', this is an error */
-        goto exit;
-    }
-
-    /* special case of new_top_bs->backing->bs already pointing to base - nothing
-     * to do, no intermediate images */
-    if (backing_bs(new_top_bs) == base) {
-        ret = 0;
-        goto exit;
-    }
-
     /* Make sure that base is in the backing chain of top */
     if (!bdrv_chain_contains(top, base)) {
         goto exit;
     }
 
     /* success - we can delete the intermediate states, and link top->base */
-    if (new_top_bs->backing->role->update_filename) {
-        backing_file_str = backing_file_str ? backing_file_str : base->filename;
-        ret = new_top_bs->backing->role->update_filename(new_top_bs->backing,
-                                                         base, backing_file_str,
-                                                         &local_err);
-        if (ret < 0) {
-            bdrv_set_backing_hd(new_top_bs, top, &error_abort);
+    backing_file_str = backing_file_str ? backing_file_str : base->filename;
+
+    QLIST_FOREACH_SAFE(c, &top->parents, next_parent, next) {
+        /* Check whether we are allowed to switch c from top to base */
+        GSList *ignore_children = g_slist_prepend(NULL, c);
+        bdrv_check_update_perm(base, NULL, c->perm, c->shared_perm,
+                               ignore_children, &local_err);
+        if (local_err) {
+            ret = -EPERM;
+            error_report_err(local_err);
             goto exit;
         }
-    }
+        g_slist_free(ignore_children);
 
-    bdrv_set_backing_hd(new_top_bs, base, &local_err);
-    if (local_err) {
-        ret = -EPERM;
-        error_report_err(local_err);
-        goto exit;
+        /* If so, update the backing file path in the image file */
+        if (c->role->update_filename) {
+            ret = c->role->update_filename(c, base, backing_file_str,
+                                           &local_err);
+            if (ret < 0) {
+                bdrv_abort_perm_update(base);
+                error_report_err(local_err);
+                goto exit;
+            }
+        }
+
+        /* Do the actual switch in the in-memory graph.
+         * Completes bdrv_check_update_perm() transaction internally. */
+        bdrv_ref(base);
+        bdrv_replace_child(c, base);
+        bdrv_unref(top);
     }
 
     ret = 0;
diff --git a/block/commit.c b/block/commit.c
index 8f0e83578a..610e1cd8f5 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -350,7 +350,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         error_propagate(errp, local_err);
         goto fail;
     }
-    bdrv_set_backing_hd(overlay_bs, commit_top_bs, &local_err);
+    bdrv_replace_node(top, commit_top_bs, &local_err);
     if (local_err) {
         bdrv_unref(commit_top_bs);
         commit_top_bs = NULL;
-- 
2.13.5
