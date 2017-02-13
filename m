Received: from eggs.gnu.org ([2001:4830:134:3::10]:59795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMR-0003qW-2n
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMP-0006OE-Dd
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:23 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:54 +0100
Message-Id: <1487006583-24350-33-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 32/41] block: BdrvChildRole.attach/detach()
 callbacks
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

Backing files are somewhat special compared to other kinds of children
because they are attached and detached using bdrv_set_backing_hd()
rather than the normal set of functions, which does a few more things
like setting backing blockers, toggling the BDRV_O_NO_BACKING flag,
setting parent_bs->backing_file, etc.

These special features are a reason why change_parent_backing_link()
can't handle backing files yet. With abstracting the additional features
into .attach/.detach callbacks, we get a step closer to a function that
can actually deal with this.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                   | 94 +++++++++++++++++++++++++++++------------------
 include/block/block_int.h |  3 ++
 2 files changed, 62 insertions(+), 35 deletions(-)

diff --git a/block.c b/block.c
index 1e01647..ff328f1 100644
--- a/block.c
+++ b/block.c
@@ -800,6 +800,57 @@ const BdrvChildRole child_format = {
     .drained_end     = bdrv_child_cb_drained_end,
 };
 
+static void bdrv_backing_attach(BdrvChild *c)
+{
+    BlockDriverState *parent = c->opaque;
+    BlockDriverState *backing_hd = c->bs;
+
+    assert(!parent->backing_blocker);
+    error_setg(&parent->backing_blocker,
+               "node is used as backing hd of '%s'",
+               bdrv_get_device_or_node_name(parent));
+
+    parent->open_flags &= ~BDRV_O_NO_BACKING;
+    pstrcpy(parent->backing_file, sizeof(parent->backing_file),
+            backing_hd->filename);
+    pstrcpy(parent->backing_format, sizeof(parent->backing_format),
+            backing_hd->drv ? backing_hd->drv->format_name : "");
+
+    bdrv_op_block_all(backing_hd, parent->backing_blocker);
+    /* Otherwise we won't be able to commit or stream */
+    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_COMMIT_TARGET,
+                    parent->backing_blocker);
+    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_STREAM,
+                    parent->backing_blocker);
+    /*
+     * We do backup in 3 ways:
+     * 1. drive backup
+     *    The target bs is new opened, and the source is top BDS
+     * 2. blockdev backup
+     *    Both the source and the target are top BDSes.
+     * 3. internal backup(used for block replication)
+     *    Both the source and the target are backing file
+     *
+     * In case 1 and 2, neither the source nor the target is the backing file.
+     * In case 3, we will block the top BDS, so there is only one block job
+     * for the top BDS and its backing chain.
+     */
+    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_BACKUP_SOURCE,
+                    parent->backing_blocker);
+    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_BACKUP_TARGET,
+                    parent->backing_blocker);
+}
+
+static void bdrv_backing_detach(BdrvChild *c)
+{
+    BlockDriverState *parent = c->opaque;
+
+    assert(parent->backing_blocker);
+    bdrv_op_unblock_all(c->bs, parent->backing_blocker);
+    error_free(parent->backing_blocker);
+    parent->backing_blocker = NULL;
+}
+
 static char *bdrv_backing_link_name(BdrvChild *c)
 {
     BlockDriverState *parent = c->opaque;
@@ -832,6 +883,8 @@ static void bdrv_backing_options(int *child_flags, QDict *child_options,
 }
 
 static const BdrvChildRole child_backing = {
+    .attach          = bdrv_backing_attach,
+    .detach          = bdrv_backing_detach,
     .get_link_name   = bdrv_backing_link_name,
     .inherit_options = bdrv_backing_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
@@ -1606,6 +1659,9 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
         if (old_bs->quiesce_counter && child->role->drained_end) {
             child->role->drained_end(child);
         }
+        if (child->role->detach) {
+            child->role->detach(child);
+        }
         QLIST_REMOVE(child, next_parent);
         bdrv_update_perm(old_bs);
     }
@@ -1618,6 +1674,9 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
             child->role->drained_begin(child);
         }
         bdrv_update_perm(new_bs);
+        if (child->role->attach) {
+            child->role->attach(child);
+        }
     }
 }
 
@@ -1758,52 +1817,17 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd)
     }
 
     if (bs->backing) {
-        assert(bs->backing_blocker);
-        bdrv_op_unblock_all(bs->backing->bs, bs->backing_blocker);
         bdrv_unref_child(bs, bs->backing);
-    } else if (backing_hd) {
-        error_setg(&bs->backing_blocker,
-                   "node is used as backing hd of '%s'",
-                   bdrv_get_device_or_node_name(bs));
     }
 
     if (!backing_hd) {
-        error_free(bs->backing_blocker);
-        bs->backing_blocker = NULL;
         bs->backing = NULL;
         goto out;
     }
     /* FIXME Error handling */
     bs->backing = bdrv_attach_child(bs, backing_hd, "backing", &child_backing,
                                     &error_abort);
-    bs->open_flags &= ~BDRV_O_NO_BACKING;
-    pstrcpy(bs->backing_file, sizeof(bs->backing_file), backing_hd->filename);
-    pstrcpy(bs->backing_format, sizeof(bs->backing_format),
-            backing_hd->drv ? backing_hd->drv->format_name : "");
 
-    bdrv_op_block_all(backing_hd, bs->backing_blocker);
-    /* Otherwise we won't be able to commit or stream */
-    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_COMMIT_TARGET,
-                    bs->backing_blocker);
-    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_STREAM,
-                    bs->backing_blocker);
-    /*
-     * We do backup in 3 ways:
-     * 1. drive backup
-     *    The target bs is new opened, and the source is top BDS
-     * 2. blockdev backup
-     *    Both the source and the target are top BDSes.
-     * 3. internal backup(used for block replication)
-     *    Both the source and the target are backing file
-     *
-     * In case 1 and 2, neither the source nor the target is the backing file.
-     * In case 3, we will block the top BDS, so there is only one block job
-     * for the top BDS and its backing chain.
-     */
-    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_BACKUP_SOURCE,
-                    bs->backing_blocker);
-    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_BACKUP_TARGET,
-                    bs->backing_blocker);
 out:
     bdrv_refresh_limits(bs, NULL);
 }
diff --git a/include/block/block_int.h b/include/block/block_int.h
index b24fc49..d37fcc2 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -456,6 +456,9 @@ struct BdrvChildRole {
      */
     void (*drained_begin)(BdrvChild *child);
     void (*drained_end)(BdrvChild *child);
+
+    void (*attach)(BdrvChild *child);
+    void (*detach)(BdrvChild *child);
 };
 
 extern const BdrvChildRole child_file;
-- 
1.8.3.1
