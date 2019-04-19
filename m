Received: from eggs.gnu.org ([209.51.188.92]:40682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHXcs-00067o-5G
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 13:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHXcq-0003xp-Gb
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 13:48:38 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 19 Apr 2019 20:48:31 +0300
Message-Id: <20190419174832.146377-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190419174832.146377-1-vsementsov@virtuozzo.com>
References: <20190419174832.146377-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] block: introduce pinned blk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com

Add stay_at_node fields to BlockBackend and BdrvChild, for the same
behavior as stay_at_node field of BdrvChildRole. It will be used for
block-job blk.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h      |  6 ++++++
 include/sysemu/block-backend.h |  1 +
 block.c                        |  2 +-
 block/block-backend.c          | 23 ++++++++++++++++++++++-
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 01e855a066..ae8fc3a580 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -725,6 +725,12 @@ struct BdrvChild {
      */
     bool frozen;
 
+    /*
+     * This link should not be modified in bdrv_replace_node process. Used by
+     * should_update_child()
+     */
+    bool stay_at_node;
+
     QLIST_ENTRY(BdrvChild) next;
     QLIST_ENTRY(BdrvChild) next_parent;
 };
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 3be05c2d68..d9c7b9f86a 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -77,6 +77,7 @@ typedef struct BlockBackendPublic {
 } BlockBackendPublic;
 
 BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm);
+BlockBackend *blk_new_pinned(uint64_t perm, uint64_t shared_perm);
 BlockBackend *blk_new_open(const char *filename, const char *reference,
                            QDict *options, int flags, Error **errp);
 int blk_get_refcnt(BlockBackend *blk);
diff --git a/block.c b/block.c
index 16615bc876..5069515976 100644
--- a/block.c
+++ b/block.c
@@ -3905,7 +3905,7 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
     GHashTable *found;
     bool ret;
 
-    if (c->role->stay_at_node) {
+    if (c->stay_at_node || c->role->stay_at_node) {
         return false;
     }
 
diff --git a/block/block-backend.c b/block/block-backend.c
index f78e82a707..b2de911383 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -86,6 +86,11 @@ struct BlockBackend {
      * Accessed with atomic ops.
      */
     unsigned int in_flight;
+
+    /*
+     * On blk_insert_bs() new child will inherit  @stay_at_node.
+     */
+    bool stay_at_node;
 };
 
 typedef struct BlockBackendAIOCB {
@@ -311,9 +316,13 @@ static const BdrvChildRole child_root = {
  * to other users of the attached node.
  * Both sets of permissions can be changed later using blk_set_perm().
  *
+ * @stay_at_node is used to set stay_at_node field of child, attached in
+ * blk_insert_bs(). If true, child bs will not be updated on bdrv_replace_node.
+ *
  * Return the new BlockBackend on success, null on failure.
  */
-BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
+static BlockBackend *blk_new_common(uint64_t perm, uint64_t shared_perm,
+                                    bool stay_at_node)
 {
     BlockBackend *blk;
 
@@ -321,6 +330,7 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
     blk->refcnt = 1;
     blk->perm = perm;
     blk->shared_perm = shared_perm;
+    blk->stay_at_node = stay_at_node;
     blk_set_enable_write_cache(blk, true);
 
     blk->on_read_error = BLOCKDEV_ON_ERROR_REPORT;
@@ -336,6 +346,16 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
     return blk;
 }
 
+BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
+{
+    return blk_new_common(perm, shared_perm, false);
+}
+
+BlockBackend *blk_new_pinned(uint64_t perm, uint64_t shared_perm)
+{
+    return blk_new_common(perm, shared_perm, true);
+}
+
 /*
  * Creates a new BlockBackend, opens a new BlockDriverState, and connects both.
  *
@@ -796,6 +816,7 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
     if (blk->root == NULL) {
         return -EPERM;
     }
+    blk->root->stay_at_node = blk->stay_at_node;
     bdrv_ref(bs);
 
     notifier_list_notify(&blk->insert_bs_notifiers, blk);
-- 
2.18.0
