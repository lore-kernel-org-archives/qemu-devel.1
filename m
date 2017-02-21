Received: from eggs.gnu.org ([2001:4830:134:3::10]:42901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBub-0000Ds-R9
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBua-0007vL-2L
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:29 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:11 +0100
Message-Id: <1487689130-30373-16-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 15/54] block: Involve block drivers in
 permission granting
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

In many cases, the required permissions of one node on its children
depends on what its parents require from it. For example, the raw format
or most filter drivers only need to request consistent reads if that's
something that one of their parents wants.

In order to achieve this, this patch introduces two new BlockDriver
callbacks. The first one lets drivers first check (recursively) whether
the requested permissions can be set; the second one actually sets the
new permission bitmask.

Also add helper functions that drivers can use in their implementation
of the callbacks to update their permissions on a specific child.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                   | 176 ++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block_int.h |  61 ++++++++++++++++
 2 files changed, 237 insertions(+)

diff --git a/block.c b/block.c
index d9f2267..2a86781 100644
--- a/block.c
+++ b/block.c
@@ -1326,11 +1326,145 @@ static int bdrv_fill_options(QDict **options, const char *filename,
     return 0;
 }
 
+/*
+ * Check whether permissions on this node can be changed in a way that
+ * @cumulative_perms and @cumulative_shared_perms are the new cumulative
+ * permissions of all its parents. This involves checking whether all necessary
+ * permission changes to child nodes can be performed.
+ *
+ * A call to this function must always be followed by a call to bdrv_set_perm()
+ * or bdrv_abort_perm_update().
+ */
+static int bdrv_check_perm(BlockDriverState *bs, uint64_t cumulative_perms,
+                           uint64_t cumulative_shared_perms, Error **errp)
+{
+    BlockDriver *drv = bs->drv;
+    BdrvChild *c;
+    int ret;
+
+    if (!drv) {
+        error_setg(errp, "Block node is not opened");
+        return -EINVAL;
+    }
+
+    /* Write permissions never work with read-only images */
+    if ((cumulative_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED)) &&
+        bdrv_is_read_only(bs))
+    {
+        error_setg(errp, "Block node is read-only");
+        return -EPERM;
+    }
+
+    /* Check this node */
+    if (drv->bdrv_check_perm) {
+        return drv->bdrv_check_perm(bs, cumulative_perms,
+                                    cumulative_shared_perms, errp);
+    }
+
+    /* Drivers may not have .bdrv_child_perm() */
+    if (!drv->bdrv_child_perm) {
+        return 0;
+    }
+
+    /* Check all children */
+    QLIST_FOREACH(c, &bs->children, next) {
+        uint64_t cur_perm, cur_shared;
+        drv->bdrv_child_perm(bs, c, c->role,
+                             cumulative_perms, cumulative_shared_perms,
+                             &cur_perm, &cur_shared);
+        ret = bdrv_child_check_perm(c, cur_perm, cur_shared, errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+/*
+ * Notifies drivers that after a previous bdrv_check_perm() call, the
+ * permission update is not performed and any preparations made for it (e.g.
+ * taken file locks) need to be undone.
+ *
+ * This function recursively notifies all child nodes.
+ */
+static void bdrv_abort_perm_update(BlockDriverState *bs)
+{
+    BlockDriver *drv = bs->drv;
+    BdrvChild *c;
+
+    if (!drv) {
+        return;
+    }
+
+    if (drv->bdrv_abort_perm_update) {
+        drv->bdrv_abort_perm_update(bs);
+    }
+
+    QLIST_FOREACH(c, &bs->children, next) {
+        bdrv_abort_perm_update(c->bs);
+    }
+}
+
+static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
+                          uint64_t cumulative_shared_perms)
+{
+    BlockDriver *drv = bs->drv;
+    BdrvChild *c;
+
+    if (!drv) {
+        return;
+    }
+
+    /* Update this node */
+    if (drv->bdrv_set_perm) {
+        drv->bdrv_set_perm(bs, cumulative_perms, cumulative_shared_perms);
+    }
+
+    /* Drivers may not have .bdrv_child_perm() */
+    if (!drv->bdrv_child_perm) {
+        return;
+    }
+
+    /* Update all children */
+    QLIST_FOREACH(c, &bs->children, next) {
+        uint64_t cur_perm, cur_shared;
+        drv->bdrv_child_perm(bs, c, c->role,
+                             cumulative_perms, cumulative_shared_perms,
+                             &cur_perm, &cur_shared);
+        bdrv_child_set_perm(c, cur_perm, cur_shared);
+    }
+}
+
+static void bdrv_update_perm(BlockDriverState *bs)
+{
+    BdrvChild *c;
+    uint64_t cumulative_perms = 0;
+    uint64_t cumulative_shared_perms = BLK_PERM_ALL;
+
+    QLIST_FOREACH(c, &bs->parents, next_parent) {
+        cumulative_perms |= c->perm;
+        cumulative_shared_perms &= c->shared_perm;
+    }
+
+    bdrv_set_perm(bs, cumulative_perms, cumulative_shared_perms);
+}
+
+/*
+ * Checks whether a new reference to @bs can be added if the new user requires
+ * @new_used_perm/@new_shared_perm as its permissions. If @ignore_child is set,
+ * this old reference is ignored in the calculations; this allows checking
+ * permission updates for an existing reference.
+ *
+ * Needs to be followed by a call to either bdrv_set_perm() or
+ * bdrv_abort_perm_update(). */
 static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
                                   uint64_t new_shared_perm,
                                   BdrvChild *ignore_child, Error **errp)
 {
     BdrvChild *c;
+    uint64_t cumulative_perms = new_used_perm;
+    uint64_t cumulative_shared_perms = new_shared_perm;
 
     /* There is no reason why anyone couldn't tolerate write_unchanged */
     assert(new_shared_perm & BLK_PERM_WRITE_UNCHANGED);
@@ -1353,8 +1487,47 @@ static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
             error_setg(errp, "Conflicts with %s", user ?: "another operation");
             return -EPERM;
         }
+
+        cumulative_perms |= c->perm;
+        cumulative_shared_perms &= c->shared_perm;
+    }
+
+    return bdrv_check_perm(bs, cumulative_perms, cumulative_shared_perms, errp);
+}
+
+/* Needs to be followed by a call to either bdrv_set_perm() or
+ * bdrv_abort_perm_update(). */
+int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
+                          Error **errp)
+{
+    return bdrv_check_update_perm(c->bs, perm, shared, c, errp);
+}
+
+void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared)
+{
+    c->perm = perm;
+    c->shared_perm = shared;
+    bdrv_update_perm(c->bs);
+}
+
+void bdrv_child_abort_perm_update(BdrvChild *c)
+{
+    bdrv_abort_perm_update(c->bs);
+}
+
+int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
+                            Error **errp)
+{
+    int ret;
+
+    ret = bdrv_child_check_perm(c, perm, shared, errp);
+    if (ret < 0) {
+        bdrv_child_abort_perm_update(c);
+        return ret;
     }
 
+    bdrv_child_set_perm(c, perm, shared);
+
     return 0;
 }
 
@@ -1367,6 +1540,7 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
             child->role->drained_end(child);
         }
         QLIST_REMOVE(child, next_parent);
+        bdrv_update_perm(old_bs);
     }
 
     child->bs = new_bs;
@@ -1376,6 +1550,7 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
         if (new_bs->quiesce_counter && child->role->drained_begin) {
             child->role->drained_begin(child);
         }
+        bdrv_update_perm(new_bs);
     }
 }
 
@@ -1390,6 +1565,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
 
     ret = bdrv_check_update_perm(child_bs, perm, shared_perm, NULL, errp);
     if (ret < 0) {
+        bdrv_abort_perm_update(child_bs);
         return NULL;
     }
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index ed63bad..cef2b6e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -320,6 +320,59 @@ struct BlockDriver {
     void (*bdrv_del_child)(BlockDriverState *parent, BdrvChild *child,
                            Error **errp);
 
+    /**
+     * Informs the block driver that a permission change is intended. The
+     * driver checks whether the change is permissible and may take other
+     * preparations for the change (e.g. get file system locks). This operation
+     * is always followed either by a call to either .bdrv_set_perm or
+     * .bdrv_abort_perm_update.
+     *
+     * Checks whether the requested set of cumulative permissions in @perm
+     * can be granted for accessing @bs and whether no other users are using
+     * permissions other than those given in @shared (both arguments take
+     * BLK_PERM_* bitmasks).
+     *
+     * If both conditions are met, 0 is returned. Otherwise, -errno is returned
+     * and errp is set to an error describing the conflict.
+     */
+    int (*bdrv_check_perm)(BlockDriverState *bs, uint64_t perm,
+                           uint64_t shared, Error **errp);
+
+    /**
+     * Called to inform the driver that the set of cumulative set of used
+     * permissions for @bs has changed to @perm, and the set of sharable
+     * permission to @shared. The driver can use this to propagate changes to
+     * its children (i.e. request permissions only if a parent actually needs
+     * them).
+     *
+     * This function is only invoked after bdrv_check_perm(), so block drivers
+     * may rely on preparations made in their .bdrv_check_perm implementation.
+     */
+    void (*bdrv_set_perm)(BlockDriverState *bs, uint64_t perm, uint64_t shared);
+
+    /*
+     * Called to inform the driver that after a previous bdrv_check_perm()
+     * call, the permission update is not performed and any preparations made
+     * for it (e.g. taken file locks) need to be undone.
+     *
+     * This function can be called even for nodes that never saw a
+     * bdrv_check_perm() call. It is a no-op then.
+     */
+    void (*bdrv_abort_perm_update)(BlockDriverState *bs);
+
+    /**
+     * Returns in @nperm and @nshared the permissions that the driver for @bs
+     * needs on its child @c, based on the cumulative permissions requested by
+     * the parents in @parent_perm and @parent_shared.
+     *
+     * If @c is NULL, return the permissions for attaching a new child for the
+     * given @role.
+     */
+     void (*bdrv_child_perm)(BlockDriverState *bs, BdrvChild *c,
+                             const BdrvChildRole *role,
+                             uint64_t parent_perm, uint64_t parent_shared,
+                             uint64_t *nperm, uint64_t *nshared);
+
     QLIST_ENTRY(BlockDriver) list;
 };
 
@@ -812,6 +865,14 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   void *opaque, Error **errp);
 void bdrv_root_unref_child(BdrvChild *child);
 
+int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
+                          Error **errp);
+void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared);
+void bdrv_child_abort_perm_update(BdrvChild *c);
+int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
+                            Error **errp);
+
+
 const char *bdrv_get_parent_name(const BlockDriverState *bs);
 void blk_dev_change_media_cb(BlockBackend *blk, bool load);
 bool blk_dev_has_removable_media(BlockBackend *blk);
-- 
1.8.3.1
