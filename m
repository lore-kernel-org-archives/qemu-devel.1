Received: from eggs.gnu.org ([209.51.188.92]:39183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gr-0001vY-PL
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gp-0007v8-AI
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:45 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 17 Jan 2019 17:33:59 +0200
Message-Id: <dc004f69efb6631e17d4934635be21e3bf2cc9a3.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 08/13] block: Allow changing the backing file
 on reopen
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

This patch allows the user to change the backing file of an image that
is being reopened. Here's what it does:

 - In bdrv_reopen_prepare(): check that the value of 'backing' points
   to an existing node or is null. If it points to an existing node it
   also needs to make sure that replacing the backing file will not
   create a cycle in the node graph (i.e. you cannot reach the parent
   from the new backing file).

 - In bdrv_reopen_commit(): perform the actual node replacement by
   calling bdrv_set_backing_hd(). It may happen that there are
   temporary implicit nodes between the BDS that we are reopening and
   the backing file that we want to replace (e.g. a commit fiter node),
   so we must skip them.

Although x-blockdev-reopen is meant to be used like blockdev-add,
there's an important thing that must be taken into account: the only
way to set a new backing file is by using a reference to an existing
node (previously added with e.g. blockdev-add).  If 'backing' contains
a dictionary with a new set of options ({"driver": "qcow2", "file": {
... }}) then it is interpreted that the _existing_ backing file must
be reopened with those options.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 897c8b85cd..10847416b2 100644
--- a/block.c
+++ b/block.c
@@ -2909,6 +2909,27 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
 }
 
 /*
+ * Returns true if @child can be reached recursively from @bs
+ */
+static bool bdrv_recurse_has_child(BlockDriverState *bs,
+                                   BlockDriverState *child)
+{
+    BdrvChild *c;
+
+    if (bs == child) {
+        return true;
+    }
+
+    QLIST_FOREACH(c, &bs->children, next) {
+        if (bdrv_recurse_has_child(c->bs, child)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+/*
  * Adds a BlockDriverState to a simple queue for an atomic, transactional
  * reopen of multiple devices.
  *
@@ -3217,6 +3238,63 @@ static void bdrv_reopen_perm(BlockReopenQueue *q, BlockDriverState *bs,
 }
 
 /*
+ * Return 0 if the 'backing' option of @bs can be replaced with
+ * @value, otherwise return < 0 and set @errp.
+ */
+static int bdrv_reopen_parse_backing(BlockDriverState *bs, QObject *value,
+                                     Error **errp)
+{
+    BlockDriverState *overlay_bs, *new_backing_bs;
+    const char *str;
+
+    switch (qobject_type(value)) {
+    case QTYPE_QNULL:
+        new_backing_bs = NULL;
+        break;
+    case QTYPE_QSTRING:
+        str = qobject_get_try_str(value);
+        new_backing_bs = bdrv_lookup_bs(NULL, str, errp);
+        if (new_backing_bs == NULL) {
+            return -EINVAL;
+        } else if (bdrv_recurse_has_child(new_backing_bs, bs)) {
+            error_setg(errp, "Making '%s' a backing file of '%s' "
+                       "would create a cycle", str, bs->node_name);
+            return -EINVAL;
+        }
+        break;
+    default:
+        /* 'backing' does not allow any other data type */
+        g_assert_not_reached();
+    }
+
+    if (new_backing_bs) {
+        if (bdrv_get_aio_context(new_backing_bs) != bdrv_get_aio_context(bs)) {
+            error_setg(errp, "Cannot use a new backing file "
+                       "with a different AioContext");
+            return -EINVAL;
+        }
+    }
+
+    /*
+     * Skip all links that point to an implicit node, if any
+     * (e.g. a commit filter node). We don't want to change those.
+     */
+    overlay_bs = bs;
+    while (backing_bs(overlay_bs) && backing_bs(overlay_bs)->implicit) {
+        overlay_bs = backing_bs(overlay_bs);
+    }
+
+    if (new_backing_bs != backing_bs(overlay_bs)) {
+        if (bdrv_is_backing_chain_frozen(overlay_bs, backing_bs(overlay_bs),
+                                         errp)) {
+            return -EPERM;
+        }
+    }
+
+    return 0;
+}
+
+/*
  * Prepares a BlockDriverState for reopen. All changes are staged in the
  * 'opaque' field of the BDRVReopenState, which is used and allocated by
  * the block driver layer .bdrv_reopen_prepare()
@@ -3359,6 +3437,19 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
             QObject *new = entry->value;
             QObject *old = qdict_get(reopen_state->bs->options, entry->key);
 
+            /*
+             * Allow changing the 'backing' option. The new value can be
+             * either a reference to an existing node (using its node name)
+             * or NULL to simply detach the current backing file.
+             */
+            if (!strcmp(entry->key, "backing")) {
+                ret = bdrv_reopen_parse_backing(reopen_state->bs, new, errp);
+                if (ret < 0) {
+                    goto error;
+                }
+                continue; /* 'backing' option processed, go to the next one */
+            }
+
             /* Allow child references (child_name=node_name) as long as they
              * point to the current child (i.e. everything stays the same). */
             if (qobject_type(new) == QTYPE_QSTRING) {
@@ -3437,9 +3528,10 @@ error:
 void bdrv_reopen_commit(BDRVReopenState *reopen_state)
 {
     BlockDriver *drv;
-    BlockDriverState *bs;
+    BlockDriverState *bs, *new_backing_bs;
     BdrvChild *child;
-    bool old_can_write, new_can_write;
+    bool old_can_write, new_can_write, change_backing_bs;
+    QObject *qobj;
 
     assert(reopen_state != NULL);
     bs = reopen_state->bs;
@@ -3464,6 +3556,15 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
     bs->detect_zeroes      = reopen_state->detect_zeroes;
 
+    qobj = qdict_get(bs->options, "backing");
+    change_backing_bs = (qobj != NULL);
+    if (change_backing_bs) {
+        const char *str = qobject_get_try_str(qobj);
+        new_backing_bs = str ? bdrv_find_node(str) : NULL;
+        qdict_del(bs->explicit_options, "backing");
+        qdict_del(bs->options, "backing");
+    }
+
     /* Remove child references from bs->options and bs->explicit_options.
      * Child options were already removed in bdrv_reopen_queue_child() */
     QLIST_FOREACH(child, &bs->children, next) {
@@ -3471,6 +3572,25 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
         qdict_del(bs->options, child->name);
     }
 
+    /*
+     * Change the backing file if a new one was specified. We do this
+     * after updating bs->options, so bdrv_refresh_filename() (called
+     * from bdrv_set_backing_hd()) has the new values.
+     */
+    if (change_backing_bs) {
+        BlockDriverState *overlay = bs;
+        /*
+         * Skip all links that point to an implicit node, if any
+         * (e.g. a commit filter node). We don't want to change those.
+         */
+        while (backing_bs(overlay) && backing_bs(overlay)->implicit) {
+            overlay = backing_bs(overlay);
+        }
+        if (new_backing_bs != backing_bs(overlay)) {
+            bdrv_set_backing_hd(overlay, new_backing_bs, &error_abort);
+        }
+    }
+
     bdrv_refresh_limits(bs, NULL);
 
     bdrv_set_perm(reopen_state->bs, reopen_state->perm,
-- 
2.11.0
