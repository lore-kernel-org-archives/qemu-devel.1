Received: from eggs.gnu.org ([2001:4830:134:3::10]:43781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsdS-0004at-U7
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsdR-0004Rb-J6
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:38:22 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:37:55 +0200
Message-Id: <20180809213801.15098-6-mreitz@redhat.com>
In-Reply-To: <20180809213801.15098-1-mreitz@redhat.com>
References: <20180809213801.15098-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 05/11] block: Fix check_to_replace_node()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Currently, check_to_replace_node() only allows mirror to replace a node
in the chain of the source node, and only if it is the first non-filter
node below the source.  Well, technically, the idea is that you can
exactly replace a quorum child by mirroring from quorum.

This has (probably) two reasons:
(1) We do not want to create loops.
(2) @replaces and @device should have exactly the same content so
    replacing them does not cause visible data to change.

This has two issues:
(1) It is overly restrictive.  It is completely fine for @replaces to be
    a filter.
(2) It is not restrictive enough.  You can create loops with this as
    follows:

$ qemu-img create -f qcow2 /tmp/source.qcow2 64M
$ qemu-system-x86_64 -qmp stdio
{"execute": "qmp_capabilities"}
{"execute": "object-add",
 "arguments": {"qom-type": "throttle-group", "id": "tg0"}}
{"execute": "blockdev-add",
 "arguments": {
     "node-name": "source",
     "driver": "throttle",
     "throttle-group": "tg0",
     "file": {
         "node-name": "filtered",
         "driver": "qcow2",
         "file": {
             "driver": "file",
             "filename": "/tmp/source.qcow2"
         } } } }
{"execute": "drive-mirror",
 "arguments": {
     "job-id": "mirror",
     "device": "source",
     "target": "/tmp/target.qcow2",
     "format": "qcow2",
     "node-name": "target",
     "sync" :"none",
     "replaces": "filtered"
 } }
{"execute": "block-job-complete", "arguments": {"device": "mirror"}}

And qemu crashes because of a stack overflow due to the loop being
created (target's backing file is source, so when it replaces filtered,
it points to itself through source).

(blockdev-mirror can be broken similarly.)

So let us make the checks for the two conditions above explicit, which
makes the whole function exactly as restrictive as it needs to be.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  1 +
 block.c               | 77 +++++++++++++++++++++++++++++++++++++++----
 blockdev.c            | 32 ++++++++++++++++--
 3 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index a01986495d..a738fef601 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -385,6 +385,7 @@ bool bdrv_is_first_non_filter(BlockDriverState *candidate);
 
 /* check if a named node can be replaced when doing drive-mirror */
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
+                                        BlockDriverState *backing_bs,
                                         const char *node_name, Error **errp);
 
 /* async block I/O */
diff --git a/block.c b/block.c
index 307c583dfd..9784ccb385 100644
--- a/block.c
+++ b/block.c
@@ -5161,7 +5161,55 @@ bool bdrv_is_first_non_filter(BlockDriverState *candidate)
     return false;
 }
 
+static bool is_child_of(BlockDriverState *child, BlockDriverState *parent)
+{
+    BdrvChild *c;
+
+    if (!parent) {
+        return false;
+    }
+
+    QLIST_FOREACH(c, &parent->children, next) {
+        if (c->bs == child || is_child_of(child, c->bs)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+/* Return true if there are only filters in [@top, @base).  Note that
+ * this may include quorum (which bdrv_chain_contains() cannot
+ * handle). */
+static bool is_filtered_child(BlockDriverState *top, BlockDriverState *base)
+{
+    BdrvChild *c;
+
+    if (!top) {
+        return false;
+    }
+
+    if (top == base) {
+        return true;
+    }
+
+    if (!top->drv->is_filter) {
+        return false;
+    }
+
+    QLIST_FOREACH(c, &top->children, next) {
+        if (is_filtered_child(c->bs, base)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+/* @parent_bs is mirror's source BDS, @backing_bs is the BDS which
+ * will be attached to the target when mirror completes */
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
+                                        BlockDriverState *backing_bs,
                                         const char *node_name, Error **errp)
 {
     BlockDriverState *to_replace_bs = bdrv_find_node(node_name);
@@ -5180,13 +5228,28 @@ BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
         goto out;
     }
 
-    /* We don't want arbitrary node of the BDS chain to be replaced only the top
-     * most non filter in order to prevent data corruption.
-     * Another benefit is that this tests exclude backing files which are
-     * blocked by the backing blockers.
-     */
-    if (!bdrv_recurse_is_first_non_filter(parent_bs, to_replace_bs)) {
-        error_setg(errp, "Only top most non filter can be replaced");
+    /* If to_replace_bs is (recursively) a child of backing_bs,
+     * replacing it may create a loop.  We cannot allow that. */
+    if (to_replace_bs == backing_bs || is_child_of(to_replace_bs, backing_bs)) {
+        error_setg(errp, "Replacing this node would result in a loop");
+        to_replace_bs = NULL;
+        goto out;
+    }
+
+    /* Mirror is designed in such a way that when it completes, the
+     * source BDS is seamlessly replaced.  It is therefore not allowed
+     * to replace a BDS where this condition would be violated, as that
+     * would defeat the purpose of mirror and could lead to data
+     * corruption.
+     * Therefore, between parent_bs and to_replace_bs there may be
+     * only filters (and the one on top must be a filter, too), so
+     * their data always stays in sync and mirror can complete and
+     * replace to_replace_bs without any possible corruptions. */
+    if (!is_filtered_child(parent_bs, to_replace_bs) &&
+        !is_filtered_child(to_replace_bs, parent_bs))
+    {
+        error_setg(errp, "The node to be replaced must be connected to the "
+                   "source through filter nodes only");
         to_replace_bs = NULL;
         goto out;
     }
diff --git a/blockdev.c b/blockdev.c
index 33dd6408c0..9ba9dc3043 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3667,7 +3667,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
     }
 
     if (has_replaces) {
-        BlockDriverState *to_replace_bs;
+        BlockDriverState *to_replace_bs, *backing_bs;
         AioContext *replace_aio_context;
         int64_t bs_size, replace_size;
 
@@ -3677,7 +3677,35 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
             return;
         }
 
-        to_replace_bs = check_to_replace_node(bs, replaces, errp);
+        if (backing_mode == MIRROR_SOURCE_BACKING_CHAIN ||
+            backing_mode == MIRROR_OPEN_BACKING_CHAIN)
+        {
+            /* While we do not quite know what OPEN_BACKING_CHAIN
+             * (used for mode=existing) will yield, it is probably
+             * best to restrict it exactly like SOURCE_BACKING_CHAIN,
+             * because that is our best guess */
+            switch (sync) {
+            case MIRROR_SYNC_MODE_FULL:
+                backing_bs = NULL;
+                break;
+
+            case MIRROR_SYNC_MODE_TOP:
+                backing_bs = bdrv_filtered_cow_bs(bdrv_skip_rw_filters(bs));
+                break;
+
+            case MIRROR_SYNC_MODE_NONE:
+                backing_bs = bs;
+                break;
+
+            default:
+                abort();
+            }
+        } else {
+            assert(backing_mode == MIRROR_LEAVE_BACKING_CHAIN);
+            backing_bs = bdrv_filtered_cow_bs(bdrv_skip_rw_filters(target));
+        }
+
+        to_replace_bs = check_to_replace_node(bs, backing_bs, replaces, errp);
         if (!to_replace_bs) {
             return;
         }
-- 
2.17.1
