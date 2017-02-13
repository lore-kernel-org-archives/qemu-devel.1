Received: from eggs.gnu.org ([2001:4830:134:3::10]:58938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLZ-0002mb-H0
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLY-0005nh-2k
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:29 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:26 +0100
Message-Id: <1487006583-24350-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 04/41] block: Let callers request
 permissions when attaching a child node
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

When attaching a node as a child to a new parent, the required and
shared permissions for this parent are checked against all other parents
of the node now, and an error is returned if there is a conflict.

This allows error returns to a function that previously always
succeeded, and the same is true for quite a few callers and their
callers. Converting all of them within the same patch would be too much,
so for now everyone tells that they don't need any permissions and allow
everyone else to do anything. This way we can use &error_abort initially
and convert caller by caller to pass actual permission requirements and
implement error handling.

All these places are marked with FIXME comments and it will be the job
of the next patches to clean them up again.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                   | 66 +++++++++++++++++++++++++++++++++++++++++------
 block/block-backend.c     |  8 ++++--
 include/block/block_int.h | 15 ++++++++++-
 3 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/block.c b/block.c
index 9895aaf..5977492 100644
--- a/block.c
+++ b/block.c
@@ -1281,6 +1281,38 @@ static int bdrv_fill_options(QDict **options, const char *filename,
     return 0;
 }
 
+static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
+                                  uint64_t new_shared_perm,
+                                  BdrvChild *ignore_child, Error **errp)
+{
+    BdrvChild *c;
+
+    /* There is no reason why anyone couldn't tolerate write_unchanged */
+    assert(new_shared_perm & BLK_PERM_WRITE_UNCHANGED);
+
+    QLIST_FOREACH(c, &bs->parents, next_parent) {
+        if (c == ignore_child) {
+            continue;
+        }
+
+        if ((new_used_perm & c->shared_perm) != new_used_perm ||
+            (c->perm & new_shared_perm) != c->perm)
+        {
+            const char *user = NULL;
+            if (c->role->get_name) {
+                user = c->role->get_name(c);
+                if (user && !*user) {
+                    user = NULL;
+                }
+            }
+            error_setg(errp, "Conflicts with %s", user ?: "another operation");
+            return -EPERM;
+        }
+    }
+
+    return 0;
+}
+
 static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
 {
     BlockDriverState *old_bs = child->bs;
@@ -1305,14 +1337,25 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
                                   const BdrvChildRole *child_role,
-                                  void *opaque)
+                                  uint64_t perm, uint64_t shared_perm,
+                                  void *opaque, Error **errp)
 {
-    BdrvChild *child = g_new(BdrvChild, 1);
+    BdrvChild *child;
+    int ret;
+
+    ret = bdrv_check_update_perm(child_bs, perm, shared_perm, NULL, errp);
+    if (ret < 0) {
+        return NULL;
+    }
+
+    child = g_new(BdrvChild, 1);
     *child = (BdrvChild) {
-        .bs     = NULL,
-        .name   = g_strdup(child_name),
-        .role   = child_role,
-        .opaque = opaque,
+        .bs             = NULL,
+        .name           = g_strdup(child_name),
+        .role           = child_role,
+        .perm           = perm,
+        .shared_perm    = shared_perm,
+        .opaque         = opaque,
     };
 
     bdrv_replace_child(child, child_bs);
@@ -1326,8 +1369,15 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              const BdrvChildRole *child_role,
                              Error **errp)
 {
-    BdrvChild *child = bdrv_root_attach_child(child_bs, child_name, child_role,
-                                              parent_bs);
+    BdrvChild *child;
+
+    /* FIXME Use real permissions */
+    child = bdrv_root_attach_child(child_bs, child_name, child_role,
+                                   0, BLK_PERM_ALL, parent_bs, errp);
+    if (child == NULL) {
+        return NULL;
+    }
+
     QLIST_INSERT_HEAD(&parent_bs->children, child, next);
     return child;
 }
diff --git a/block/block-backend.c b/block/block-backend.c
index efbf398..d080f01 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -163,7 +163,9 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
         return NULL;
     }
 
-    blk->root = bdrv_root_attach_child(bs, "root", &child_root, blk);
+    /* FIXME Use real permissions */
+    blk->root = bdrv_root_attach_child(bs, "root", &child_root,
+                                       0, BLK_PERM_ALL, blk, &error_abort);
 
     return blk;
 }
@@ -498,7 +500,9 @@ void blk_remove_bs(BlockBackend *blk)
 void blk_insert_bs(BlockBackend *blk, BlockDriverState *bs)
 {
     bdrv_ref(bs);
-    blk->root = bdrv_root_attach_child(bs, "root", &child_root, blk);
+    /* FIXME Use real permissions */
+    blk->root = bdrv_root_attach_child(bs, "root", &child_root,
+                                       0, BLK_PERM_ALL, blk, &error_abort);
 
     notifier_list_notify(&blk->insert_bs_notifiers, blk);
     if (blk->public.throttle_state) {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 6a37b06..f36b064 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -453,6 +453,18 @@ struct BdrvChild {
     char *name;
     const BdrvChildRole *role;
     void *opaque;
+
+    /**
+     * Granted permissions for operating on this BdrvChild (BLK_PERM_* bitmask)
+     */
+    uint64_t perm;
+
+    /**
+     * Permissions that can still be granted to other users of @bs while this
+     * BdrvChild is still attached to it. (BLK_PERM_* bitmask)
+     */
+    uint64_t shared_perm;
+
     QLIST_ENTRY(BdrvChild) next;
     QLIST_ENTRY(BdrvChild) next_parent;
 };
@@ -816,7 +828,8 @@ void hmp_drive_add_node(Monitor *mon, const char *optstr);
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
                                   const BdrvChildRole *child_role,
-                                  void *opaque);
+                                  uint64_t perm, uint64_t shared_perm,
+                                  void *opaque, Error **errp);
 void bdrv_root_unref_child(BdrvChild *child);
 
 const char *bdrv_get_parent_name(const BlockDriverState *bs);
-- 
1.8.3.1
