Received: from eggs.gnu.org ([209.51.188.92]:39001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gn-0001s2-9Z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gl-0007lR-DM
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:41 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 17 Jan 2019 17:33:57 +0200
Message-Id: <f112a3019e4e1dfc2de6c275edadb5fc3a58ade0.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 06/13] block: Handle child references in
 bdrv_reopen_queue()
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

Children in QMP are specified with BlockdevRef / BlockdevRefOrNull,
which can contain a set of child options, a child reference, or
NULL. In optional attributes like "backing" it can also be missing.

Only the first case (set of child options) is being handled properly
by bdrv_reopen_queue(). This patch deals with all the others.

Here's how these cases should be handled when bdrv_reopen_queue() is
deciding what to do with each child of a BlockDriverState:

   1) Set of child options: the options are removed from the parent's
      options QDict and are passed to the child with a recursive
      bdrv_reopen_queue() call. This case was already working fine.

   2) Child reference: there's two possibilites here.

      2a) Reference to the current child: the child is put in the
          reopen queue, keeping its current set of options (since this
          was a child reference there was no way to specify a
          different set of options).

      2b) Reference to a different BDS: the current child is not put
          in the reopen queue at all. Passing a reference to a
          different BDS can be used to replace a child, although at
          the moment no driver implements this, so it results in an
          error. In any case, the current child is not going to be
          reopened (and might in fact disappear if it's replaced)

   3) NULL: This is similar to (2b). Although no driver allows this
      yet it can be used to detach the current child so it should not
      be put in the reopen queue.

   4) Missing option: at the moment "backing" is the only case where
      this can happen. With "blockdev-add", leaving "backing" out
      means that the default backing file is opened. We don't want to
      open a new image during reopen, so we require that "backing" is
      always present. We'll relax this requirement a bit in the next
      patch.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c               | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
 include/block/block.h |  1 +
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 056a620eb2..fd51f1cd35 100644
--- a/block.c
+++ b/block.c
@@ -3032,9 +3032,21 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     bs_entry->state.perm = UINT64_MAX;
     bs_entry->state.shared_perm = 0;
 
+    /*
+     * If keep_old_opts is false then it means that unspecified
+     * options must be reset to its original value. We don't allow
+     * resetting 'backing' but we need to know if the option is
+     * missing in order to decide if we have to return an error.
+     */
+    if (!keep_old_opts) {
+        bs_entry->state.backing_missing =
+            !qdict_haskey(options, "backing") &&
+            !qdict_haskey(options, "backing.driver");
+    }
+
     QLIST_FOREACH(child, &bs->children, next) {
-        QDict *new_child_options;
-        char *child_key_dot;
+        QDict *new_child_options = NULL;
+        bool child_keep_old = keep_old_opts;
 
         /* reopen can only change the options of block devices that were
          * implicitly created and inherited options. For other (referenced)
@@ -3043,13 +3055,31 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
             continue;
         }
 
-        child_key_dot = g_strdup_printf("%s.", child->name);
-        qdict_extract_subqdict(explicit_options, NULL, child_key_dot);
-        qdict_extract_subqdict(options, &new_child_options, child_key_dot);
-        g_free(child_key_dot);
+        /* Check if the options contain a child reference */
+        if (qdict_haskey(options, child->name)) {
+            const char *childref = qdict_get_try_str(options, child->name);
+            /*
+             * The current child must not be reopened if the child
+             * reference does not point to it.
+             */
+            if (g_strcmp0(childref, child->bs->node_name)) {
+                continue;
+            }
+            /*
+             * If the child reference points to the current child then
+             * reopen it with its existing set of options.
+             */
+            child_keep_old = true;
+        } else {
+            /* Extract child options ("child-name.*") */
+            char *child_key_dot = g_strdup_printf("%s.", child->name);
+            qdict_extract_subqdict(explicit_options, NULL, child_key_dot);
+            qdict_extract_subqdict(options, &new_child_options, child_key_dot);
+            g_free(child_key_dot);
+        }
 
         bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options,
-                                child->role, options, flags, keep_old_opts);
+                                child->role, options, flags, child_keep_old);
     }
 
     return bs_queue;
@@ -3306,6 +3336,13 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 
     drv_prepared = true;
 
+    if (reopen_state->backing_missing) {
+        error_setg(errp, "backing is missing for '%s'",
+                   reopen_state->bs->node_name);
+        ret = -EINVAL;
+        goto error;
+    }
+
     /* Options that are not handled are only okay if they are unchanged
      * compared to the old state. It is expected that some options are only
      * used for the initial open, but not reopen (e.g. filename) */
diff --git a/include/block/block.h b/include/block/block.h
index a061ef3944..e21616a038 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -187,6 +187,7 @@ typedef struct BDRVReopenState {
     BlockDriverState *bs;
     int flags;
     BlockdevDetectZeroesOptions detect_zeroes;
+    bool backing_missing;
     uint64_t perm, shared_perm;
     QDict *options;
     QDict *explicit_options;
-- 
2.11.0
