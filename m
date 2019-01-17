Received: from eggs.gnu.org ([209.51.188.92]:39113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gp-0001uM-K5
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gn-0007pY-OA
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:43 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 17 Jan 2019 17:33:52 +0200
Message-Id: <ae441a8c27cae1a80e57fb6d291fe95667da0c76.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 01/13] block: Allow freezing BdrvChild links
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Our permission system is useful to define what operations are allowed
on a certain block node and includes things like BLK_PERM_WRITE or
BLK_PERM_RESIZE among others.

One of the permissions is BLK_PERM_GRAPH_MOD which allows "changing
the node that this BdrvChild points to". The exact meaning of this has
never been very clear, but it can be understood as "change any of the
links connected to the node". This can be used to prevent changing a
backing link, but it's too coarse.

This patch adds a new 'frozen' attribute to BdrvChild, which forbids
detaching the link from the node it points to, and new API to freeze
and unfreeze a backing chain.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c                   | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h     |  5 ++++
 include/block/block_int.h |  5 ++++
 3 files changed, 76 insertions(+)

diff --git a/block.c b/block.c
index 4f5ff2cc12..51fac086c7 100644
--- a/block.c
+++ b/block.c
@@ -2062,6 +2062,8 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
     BlockDriverState *old_bs = child->bs;
     int i;
 
+    assert(!child->frozen);
+
     if (old_bs && new_bs) {
         assert(bdrv_get_aio_context(old_bs) == bdrv_get_aio_context(new_bs));
     }
@@ -2278,6 +2280,10 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
     bool update_inherits_from = bdrv_chain_contains(bs, backing_hd) &&
         bdrv_inherits_from_recursive(backing_hd, bs);
 
+    if (bdrv_is_backing_chain_frozen(bs, backing_bs(bs), errp)) {
+        return;
+    }
+
     if (backing_hd) {
         bdrv_ref(backing_hd);
     }
@@ -3813,6 +3819,62 @@ BlockDriverState *bdrv_find_base(BlockDriverState *bs)
 }
 
 /*
+ * Return true if at least one of the backing links between @bs and
+ * @base is frozen. @errp is set if that's the case.
+ */
+bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
+                                  Error **errp)
+{
+    BlockDriverState *i;
+
+    for (i = bs; i != base && i->backing; i = backing_bs(i)) {
+        if (i->backing->frozen) {
+            error_setg(errp, "Cannot remove link from '%s' to '%s'",
+                       i->node_name, backing_bs(i)->node_name);
+            return true;
+        }
+    }
+
+    return false;
+}
+
+/*
+ * Freeze all backing links between @bs and @base.
+ * If any of the links is already frozen the operation is aborted and
+ * none of the links are modified.
+ * Returns 0 on success. On failure returns < 0 and sets @errp.
+ */
+int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
+                              Error **errp)
+{
+    BlockDriverState *i;
+
+    if (bdrv_is_backing_chain_frozen(bs, base, errp)) {
+        return -EPERM;
+    }
+
+    for (i = bs; i != base && i->backing; i = backing_bs(i)) {
+        i->backing->frozen = true;
+    }
+
+    return 0;
+}
+
+/*
+ * Unfreeze all backing links between @bs and @base. The caller must
+ * ensure that all links are frozen before using this function.
+ */
+void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base)
+{
+    BlockDriverState *i;
+
+    for (i = bs; i != base && i->backing; i = backing_bs(i)) {
+        assert(i->backing->frozen);
+        i->backing->frozen = false;
+    }
+}
+
+/*
  * Drops images above 'base' up to and including 'top', and sets the image
  * above 'top' to have base as its backing file.
  *
@@ -3861,6 +3923,10 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
         goto exit;
     }
 
+    if (bdrv_is_backing_chain_frozen(top, base, NULL)) {
+        goto exit;
+    }
+
     /* If 'base' recursively inherits from 'top' then we should set
      * base->inherits_from to top->inherits_from after 'top' and all
      * other intermediate nodes have been dropped.
diff --git a/include/block/block.h b/include/block/block.h
index f70a843b72..6f10a8fcfc 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -353,6 +353,11 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
 BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
                                     BlockDriverState *bs);
 BlockDriverState *bdrv_find_base(BlockDriverState *bs);
+bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
+                                  Error **errp);
+int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
+                              Error **errp);
+void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base);
 
 
 typedef struct BdrvCheckResult {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f605622216..fd0e88d17a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -661,6 +661,11 @@ struct BdrvChild {
      */
     uint64_t shared_perm;
 
+    /*
+     * This link is frozen: the child cannot be detached from the parent.
+     */
+    bool frozen;
+
     QLIST_ENTRY(BdrvChild) next;
     QLIST_ENTRY(BdrvChild) next_parent;
 };
-- 
2.11.0
