Received: from eggs.gnu.org ([209.51.188.92]:59508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b1e-0004D9-Bh
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b1b-0005u3-DS
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:18 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  6 Mar 2019 20:11:08 +0200
Message-Id: <b4f679e6f73b13729e93aa24f2904993cf0d0c75.1551895814.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 08/13] block: Allow changing the backing
 file on reopen
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
   calling bdrv_set_backing_hd().

There may be temporary implicit nodes between a BDS and its backing
file (e.g. a commit filter node). In these cases bdrv_reopen_prepare()
looks for the real (non-implicit) backing file and requires that the
'backing' option points to it. Replacing or detaching a backing file
is forbidden if there are implicit nodes in the middle.

Although x-blockdev-reopen is meant to be used like blockdev-add,
there's an important thing that must be taken into account: the only
way to set a new backing file is by using a reference to an existing
node (previously added with e.g. blockdev-add).  If 'backing' contains
a dictionary with a new set of options ({"driver": "qcow2", "file": {
... }}) then it is interpreted that the _existing_ backing file must
be reopened with those options.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c               | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h |   2 +
 2 files changed, 164 insertions(+)

diff --git a/block.c b/block.c
index 6db8a65e61..9c83adab7a 100644
--- a/block.c
+++ b/block.c
@@ -2985,6 +2985,27 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
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
@@ -3294,6 +3315,98 @@ static void bdrv_reopen_perm(BlockReopenQueue *q, BlockDriverState *bs,
 }
 
 /*
+ * Take a BDRVReopenState and check if the value of 'backing' in the
+ * reopen_state->options QDict is valid or not.
+ *
+ * If 'backing' is missing from the QDict then return 0.
+ *
+ * If 'backing' contains the node name of the backing file of
+ * reopen_state->bs then return 0.
+ *
+ * If 'backing' contains a different node name (or is null) then check
+ * whether the current backing file can be replaced with the new one.
+ * If that's the case then reopen_state->replace_backing_bs is set to
+ * true and reopen_state->new_backing_bs contains a pointer to the new
+ * backing BlockDriverState (or NULL).
+ *
+ * Return 0 on success, otherwise return < 0 and set @errp.
+ */
+static int bdrv_reopen_parse_backing(BDRVReopenState *reopen_state,
+                                     Error **errp)
+{
+    BlockDriverState *bs = reopen_state->bs;
+    BlockDriverState *overlay_bs, *new_backing_bs;
+    QObject *value;
+    const char *str;
+
+    value = qdict_get(reopen_state->options, "backing");
+    if (value == NULL) {
+        return 0;
+    }
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
+    /*
+     * TODO: before removing the x- prefix from x-blockdev-reopen we
+     * should move the new backing file into the right AioContext
+     * instead of returning an error.
+     */
+    if (new_backing_bs) {
+        if (bdrv_get_aio_context(new_backing_bs) != bdrv_get_aio_context(bs)) {
+            error_setg(errp, "Cannot use a new backing file "
+                       "with a different AioContext");
+            return -EINVAL;
+        }
+    }
+
+    /*
+     * Find the "actual" backing file by skipping all links that point
+     * to an implicit node, if any (e.g. a commit filter node).
+     */
+    overlay_bs = bs;
+    while (backing_bs(overlay_bs) && backing_bs(overlay_bs)->implicit) {
+        overlay_bs = backing_bs(overlay_bs);
+    }
+
+    /* If we want to replace the backing file we need some extra checks */
+    if (new_backing_bs != backing_bs(overlay_bs)) {
+        /* Check for implicit nodes between bs and its backing file */
+        if (bs != overlay_bs) {
+            error_setg(errp, "Cannot change backing link if '%s' has "
+                       "an implicit backing file", bs->node_name);
+            return -EPERM;
+        }
+        /* Check if the backing link that we want to replace is frozen */
+        if (bdrv_is_backing_chain_frozen(overlay_bs, backing_bs(overlay_bs),
+                                         errp)) {
+            return -EPERM;
+        }
+        reopen_state->replace_backing_bs = true;
+        reopen_state->new_backing_bs = new_backing_bs;
+    }
+
+    return 0;
+}
+
+/*
  * Prepares a BlockDriverState for reopen. All changes are staged in the
  * 'opaque' field of the BDRVReopenState, which is used and allocated by
  * the block driver layer .bdrv_reopen_prepare()
@@ -3427,6 +3540,17 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
         goto error;
     }
 
+    /*
+     * Allow changing the 'backing' option. The new value can be
+     * either a reference to an existing node (using its node name)
+     * or NULL to simply detach the current backing file.
+     */
+    ret = bdrv_reopen_parse_backing(reopen_state, errp);
+    if (ret < 0) {
+        goto error;
+    }
+    qdict_del(reopen_state->options, "backing");
+
     /* Options that are not handled are only okay if they are unchanged
      * compared to the old state. It is expected that some options are only
      * used for the initial open, but not reopen (e.g. filename) */
@@ -3485,6 +3609,20 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
         goto error;
     }
 
+    /* Check if new_backing_bs would accept the new permissions */
+    if (reopen_state->replace_backing_bs && reopen_state->new_backing_bs) {
+        uint64_t cur_perm, cur_shared;
+        bdrv_child_perm(reopen_state->bs, reopen_state->new_backing_bs,
+                        NULL, &child_backing, NULL,
+                        reopen_state->perm, reopen_state->shared_perm,
+                        &cur_perm, &cur_shared);
+        ret = bdrv_check_update_perm(reopen_state->new_backing_bs, NULL,
+                                     cur_perm, cur_shared, NULL, errp);
+        if (ret < 0) {
+            goto error;
+        }
+    }
+
     ret = 0;
 
     /* Restore the original reopen_state->options QDict */
@@ -3542,6 +3680,11 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
     bs->detect_zeroes      = reopen_state->detect_zeroes;
 
+    if (reopen_state->replace_backing_bs) {
+        qdict_del(bs->explicit_options, "backing");
+        qdict_del(bs->options, "backing");
+    }
+
     /* Remove child references from bs->options and bs->explicit_options.
      * Child options were already removed in bdrv_reopen_queue_child() */
     QLIST_FOREACH(child, &bs->children, next) {
@@ -3549,6 +3692,21 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
         qdict_del(bs->options, child->name);
     }
 
+    /*
+     * Change the backing file if a new one was specified. We do this
+     * after updating bs->options, so bdrv_refresh_filename() (called
+     * from bdrv_set_backing_hd()) has the new values.
+     */
+    if (reopen_state->replace_backing_bs) {
+        BlockDriverState *old_backing_bs = backing_bs(bs);
+        assert(!old_backing_bs || !old_backing_bs->implicit);
+        /* Abort the permission update on the backing bs we're detaching */
+        if (old_backing_bs) {
+            bdrv_abort_perm_update(old_backing_bs);
+        }
+        bdrv_set_backing_hd(bs, reopen_state->new_backing_bs, &error_abort);
+    }
+
     bdrv_refresh_limits(bs, NULL);
 
     bdrv_set_perm(reopen_state->bs, reopen_state->perm,
@@ -3587,6 +3745,10 @@ void bdrv_reopen_abort(BDRVReopenState *reopen_state)
     }
 
     bdrv_abort_perm_update(reopen_state->bs);
+
+    if (reopen_state->replace_backing_bs && reopen_state->new_backing_bs) {
+        bdrv_abort_perm_update(reopen_state->new_backing_bs);
+    }
 }
 
 
diff --git a/include/block/block.h b/include/block/block.h
index ee02b69a81..3bf83d458a 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -188,6 +188,8 @@ typedef struct BDRVReopenState {
     int flags;
     BlockdevDetectZeroesOptions detect_zeroes;
     bool backing_missing;
+    bool replace_backing_bs;  /* new_backing_bs is ignored if this is false */
+    BlockDriverState *new_backing_bs; /* If NULL then detach the current bs */
     uint64_t perm, shared_perm;
     QDict *options;
     QDict *explicit_options;
-- 
2.11.0
