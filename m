Received: from eggs.gnu.org ([209.51.188.92]:59688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b2A-0004g3-67
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b1t-00069D-Q6
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:38 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  6 Mar 2019 20:11:01 +0200
Message-Id: <624533945b182710437b6ed04595bf560c1d9f5f.1551895814.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 01/13] block: Allow freezing BdrvChild links
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

After this change a few functions can fail, so they need additional
checks.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c                   | 76 +++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h     |  5 ++++
 include/block/block_int.h |  6 ++++
 3 files changed, 87 insertions(+)

diff --git a/block.c b/block.c
index 35e78e2172..6e9c72f0cd 100644
--- a/block.c
+++ b/block.c
@@ -2127,6 +2127,8 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
     BlockDriverState *old_bs = child->bs;
     int i;
 
+    assert(!child->frozen);
+
     if (old_bs && new_bs) {
         assert(bdrv_get_aio_context(old_bs) == bdrv_get_aio_context(new_bs));
     }
@@ -2343,6 +2345,10 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
     bool update_inherits_from = bdrv_chain_contains(bs, backing_hd) &&
         bdrv_inherits_from_recursive(backing_hd, bs);
 
+    if (bdrv_is_backing_chain_frozen(bs, backing_bs(bs), errp)) {
+        return;
+    }
+
     if (backing_hd) {
         bdrv_ref(backing_hd);
     }
@@ -3712,6 +3718,11 @@ void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
         if (!should_update_child(c, to)) {
             continue;
         }
+        if (c->frozen) {
+            error_setg(errp, "Cannot change '%s' link to '%s'",
+                       c->name, from->node_name);
+            goto out;
+        }
         list = g_slist_prepend(list, c);
         perm |= c->perm;
         shared &= c->shared_perm;
@@ -3924,6 +3935,63 @@ BlockDriverState *bdrv_find_base(BlockDriverState *bs)
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
+            error_setg(errp, "Cannot change '%s' link from '%s' to '%s'",
+                       i->backing->name, i->node_name,
+                       backing_bs(i)->node_name);
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
@@ -3972,6 +4040,14 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
         goto exit;
     }
 
+    /* This function changes all links that point to top and makes
+     * them point to base. Check that none of them is frozen. */
+    QLIST_FOREACH(c, &top->parents, next_parent) {
+        if (c->frozen) {
+            goto exit;
+        }
+    }
+
     /* If 'base' recursively inherits from 'top' then we should set
      * base->inherits_from to top->inherits_from after 'top' and all
      * other intermediate nodes have been dropped.
diff --git a/include/block/block.h b/include/block/block.h
index 5b5cf868df..e4a25674b1 100644
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
index 836d67c1ae..c8a83c3eea 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -709,6 +709,12 @@ struct BdrvChild {
     uint64_t backup_perm;
     uint64_t backup_shared_perm;
 
+    /*
+     * This link is frozen: the child can neither be replaced nor
+     * detached from the parent.
+     */
+    bool frozen;
+
     QLIST_ENTRY(BdrvChild) next;
     QLIST_ENTRY(BdrvChild) next_parent;
 };
-- 
2.11.0
