Received: from eggs.gnu.org ([2001:4830:134:3::10]:43072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cihIn-0003rY-8k
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cihIl-0003xx-BN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:54:49 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 13:53:49 +0100
Message-Id: <1488286469-9381-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v3 04/44] block: Involve block drivers in
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
depend on what its parents require from it. For example, the raw format
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
 block.c                   | 206 +++++++++++++++++++++++++++++++++++++++++++++-
 include/block/block_int.h |  61 ++++++++++++++
 2 files changed, 263 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 9628c7a..cf3534f 100644
--- a/block.c
+++ b/block.c
@@ -1326,11 +1326,146 @@ static int bdrv_fill_options(QDict **options, const char *filename,
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
+    /* Write permissions never work with read-only images */
+    if ((cumulative_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED)) &&
+        bdrv_is_read_only(bs))
+    {
+        error_setg(errp, "Block node is read-only");
+        return -EPERM;
+    }
+
+    /* Check this node */
+    if (!drv) {
+        return 0;
+    }
+
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
+        bdrv_child_abort_perm_update(c);
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
+static void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
+                                     uint64_t *shared_perm)
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
+    *perm = cumulative_perms;
+    *shared_perm = cumulative_shared_perms;
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
@@ -1353,20 +1488,73 @@ static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
             error_setg(errp, "Conflicts with %s", user ?: "another operation");
             return -EPERM;
         }
+
+        cumulative_perms |= c->perm;
+        cumulative_shared_perms &= c->shared_perm;
     }
 
+    return bdrv_check_perm(bs, cumulative_perms, cumulative_shared_perms, errp);
+}
+
+/* Needs to be followed by a call to either bdrv_child_set_perm() or
+ * bdrv_child_abort_perm_update(). */
+int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
+                          Error **errp)
+{
+    return bdrv_check_update_perm(c->bs, perm, shared, c, errp);
+}
+
+void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared)
+{
+    uint64_t cumulative_perms, cumulative_shared_perms;
+
+    c->perm = perm;
+    c->shared_perm = shared;
+
+    bdrv_get_cumulative_perm(c->bs, &cumulative_perms,
+                             &cumulative_shared_perms);
+    bdrv_set_perm(c->bs, cumulative_perms, cumulative_shared_perms);
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
+    }
+
+    bdrv_child_set_perm(c, perm, shared);
+
     return 0;
 }
 
-static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
+static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs,
+                               bool check_new_perm)
 {
     BlockDriverState *old_bs = child->bs;
+    uint64_t perm, shared_perm;
 
     if (old_bs) {
         if (old_bs->quiesce_counter && child->role->drained_end) {
             child->role->drained_end(child);
         }
         QLIST_REMOVE(child, next_parent);
+
+        /* Update permissions for old node. This is guaranteed to succeed
+         * because we're just taking a parent away, so we're loosening
+         * restrictions. */
+        bdrv_get_cumulative_perm(old_bs, &perm, &shared_perm);
+        bdrv_check_perm(old_bs, perm, shared_perm, &error_abort);
+        bdrv_set_perm(old_bs, perm, shared_perm);
     }
 
     child->bs = new_bs;
@@ -1376,6 +1564,12 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
         if (new_bs->quiesce_counter && child->role->drained_begin) {
             child->role->drained_begin(child);
         }
+
+        bdrv_get_cumulative_perm(new_bs, &perm, &shared_perm);
+        if (check_new_perm) {
+            bdrv_check_perm(new_bs, perm, shared_perm, &error_abort);
+        }
+        bdrv_set_perm(new_bs, perm, shared_perm);
     }
 }
 
@@ -1390,6 +1584,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
 
     ret = bdrv_check_update_perm(child_bs, perm, shared_perm, NULL, errp);
     if (ret < 0) {
+        bdrv_abort_perm_update(child_bs);
         return NULL;
     }
 
@@ -1403,7 +1598,8 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
         .opaque         = opaque,
     };
 
-    bdrv_replace_child(child, child_bs);
+    /* This performs the matching bdrv_set_perm() for the above check. */
+    bdrv_replace_child(child, child_bs, false);
 
     return child;
 }
@@ -1434,7 +1630,7 @@ static void bdrv_detach_child(BdrvChild *child)
         child->next.le_prev = NULL;
     }
 
-    bdrv_replace_child(child, NULL);
+    bdrv_replace_child(child, NULL, false);
 
     g_free(child->name);
     g_free(child);
@@ -2541,7 +2737,9 @@ static void change_parent_backing_link(BlockDriverState *from,
 
         assert(c->role != &child_backing);
         bdrv_ref(to);
-        bdrv_replace_child(c, to);
+        /* FIXME Are we sure that bdrv_replace_child() can't run into
+         * &error_abort because of permissions? */
+        bdrv_replace_child(c, to, true);
         bdrv_unref(from);
     }
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
