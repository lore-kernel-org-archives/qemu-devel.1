Received: from eggs.gnu.org ([2001:4830:134:3::10]:59024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLe-0002s4-4e
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLa-0005qQ-UY
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:34 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:28 +0100
Message-Id: <1487006583-24350-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 06/41] block: Involve block drivers in
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
 block.c                   | 125 ++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block_int.h |  46 +++++++++++++++++
 2 files changed, 171 insertions(+)

diff --git a/block.c b/block.c
index 5977492..c27cdce 100644
--- a/block.c
+++ b/block.c
@@ -1281,11 +1281,103 @@ static int bdrv_fill_options(QDict **options, const char *filename,
     return 0;
 }
 
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
 static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
                                   uint64_t new_shared_perm,
                                   BdrvChild *ignore_child, Error **errp)
 {
     BdrvChild *c;
+    uint64_t cumulative_perms = new_used_perm;
+    uint64_t cumulative_shared_perms = new_shared_perm;
 
     /* There is no reason why anyone couldn't tolerate write_unchanged */
     assert(new_shared_perm & BLK_PERM_WRITE_UNCHANGED);
@@ -1308,8 +1400,39 @@ static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
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
+int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
+                            Error **errp)
+{
+    int ret;
+
+    ret = bdrv_child_check_perm(c, perm, shared, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    bdrv_child_set_perm(c, perm, shared);
+
     return 0;
 }
 
@@ -1322,6 +1445,7 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
             child->role->drained_end(child);
         }
         QLIST_REMOVE(child, next_parent);
+        bdrv_update_perm(old_bs);
     }
 
     child->bs = new_bs;
@@ -1331,6 +1455,7 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
         if (new_bs->quiesce_counter && child->role->drained_begin) {
             child->role->drained_begin(child);
         }
+        bdrv_update_perm(new_bs);
     }
 }
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f36b064..8578e17 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -320,6 +320,45 @@ struct BlockDriver {
     void (*bdrv_del_child)(BlockDriverState *parent, BdrvChild *child,
                            Error **errp);
 
+    /**
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
+     * If permissions are added to @perm or dropped from @shared, callers must
+     * use bdrv_check_perm() first to ensure that this operation is valid.
+     * Dropping from @perm or adding to @shared is always allowed without a
+     * previous check.
+     */
+    void (*bdrv_set_perm)(BlockDriverState *bs, uint64_t perm, uint64_t shared);
+
+    /**
+     * Returns in @nperm and @nshared the permissions that the driver for @bs
+     * needs on its child @c, based on the cumulative permissions requested by
+     * the parents in @parent_perm and @parent_shared.
+     *
+     * If @c is NULL, return the permissions for attaching a new child for the
+     * given @role.
+     */
+     void (*bdrv_child_perm)(BlockDriverState* bs, BdrvChild *c,
+                             const BdrvChildRole *role,
+                             uint64_t parent_perm, uint64_t parent_shared,
+                             uint64_t *nperm, uint64_t *nshared);
+
     QLIST_ENTRY(BlockDriver) list;
 };
 
@@ -832,6 +871,13 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   void *opaque, Error **errp);
 void bdrv_root_unref_child(BdrvChild *child);
 
+int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
+                          Error **errp);
+void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared);
+int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
+                            Error **errp);
+
+
 const char *bdrv_get_parent_name(const BlockDriverState *bs);
 void blk_dev_change_media_cb(BlockBackend *blk, bool load);
 bool blk_dev_has_removable_media(BlockBackend *blk);
-- 
1.8.3.1
