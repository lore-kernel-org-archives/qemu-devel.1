Received: from eggs.gnu.org ([2001:4830:134:3::10]:53131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVN-0000jC-03
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVI-0003ne-7x
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:44 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 14 Jun 2018 18:49:03 +0300
Message-Id: <6782db91216488e4fc1509a267a362a3f15a1aaa.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH 06/10] block: Allow changing the backing
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>

This patch allows the user to change the backing file of an image that
is being reopened. Here's what it does:

 - In bdrv_reopen_queue_child(): if the 'backing' option points to an
   image different from the current backing file then it means that
   the latter is going be detached so it must not be put in the reopen
   queue.

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
there's two important things that must be taken into account:

1) The only way to set a new backing file is by using a reference to
   an existing node (previously added with e.g. blockdev-add).
   If 'backing' contains a dictionary with a new set of options
   ({"driver": "qcow2", "file": { ... }}) then it is interpreted that
   the _existing_ backing file must be reopened with those options.

2) If the 'backing' option is omitted altogether then the existing
   backing file (if any) is kept. Unlike blockdev-add this will _not_
   open the default backing file specified in the image header.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 0b9268a48d..91fff6361f 100644
--- a/block.c
+++ b/block.c
@@ -2823,6 +2823,27 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
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
@@ -2957,6 +2978,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     QLIST_FOREACH(child, &bs->children, next) {
         QDict *new_child_options;
         char *child_key_dot;
+        bool child_keep_old = keep_old_opts;
 
         /* reopen can only change the options of block devices that were
          * implicitly created and inherited options. For other (referenced)
@@ -2965,12 +2987,28 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
             continue;
         }
 
+        /* If the 'backing' option is set and it points to a different
+         * node then it means that we want to replace the current one,
+         * so we shouldn't put it in the reopen queue */
+        if (child->role == &child_backing && qdict_haskey(options, "backing")) {
+            const char *backing = qdict_get_try_str(options, "backing");
+            if (g_strcmp0(backing, child->bs->node_name)) {
+                continue;
+            }
+        }
+
         child_key_dot = g_strdup_printf("%s.", child->name);
         qdict_extract_subqdict(options, &new_child_options, child_key_dot);
         g_free(child_key_dot);
 
+        /* If the 'backing' option was omitted then we keep the old
+         * set of options */
+        if (child->role == &child_backing && !qdict_size(new_child_options)) {
+            child_keep_old = true;
+        }
+
         bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options, 0,
-                                child->role, options, flags, keep_old_opts);
+                                child->role, options, flags, child_keep_old);
     }
 
     return bs_queue;
@@ -3262,7 +3300,34 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
              * the user can simply omit options which cannot be changed anyway,
              * so they will stay unchanged.
              */
-            if (!qobject_is_equal(new, old)) {
+            /*
+             * Allow changing the 'backing' option. The new value can be
+             * either a reference to an existing node (using its node name)
+             * or NULL to simply detach the current backing file.
+             */
+            if (!strcmp(entry->key, "backing")) {
+                switch (qobject_type(new)) {
+                case QTYPE_QNULL:
+                    break;
+                case QTYPE_QSTRING: {
+                    const char *str = qobject_get_try_str(new);
+                    BlockDriverState *bs = bdrv_lookup_bs(NULL, str, errp);
+                    if (bs == NULL) {
+                        ret = -EINVAL;
+                        goto error;
+                    } else if (bdrv_recurse_has_child(bs, reopen_state->bs)) {
+                        error_setg(errp, "Making '%s' a backing file of '%s' "
+                                   "would create a cycle", str,
+                                   reopen_state->bs->node_name);
+                        ret = -EINVAL;
+                        goto error;
+                    }
+                    break;
+                }
+                default:
+                    g_assert_not_reached();
+                }
+            } else if (!qobject_is_equal(new, old)) {
                 error_setg(errp, "Cannot change the option '%s'", entry->key);
                 ret = -EINVAL;
                 goto error;
@@ -3293,6 +3358,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     BlockDriver *drv;
     BlockDriverState *bs;
     bool old_can_write, new_can_write;
+    QObject *qobj;
 
     assert(reopen_state != NULL);
     bs = reopen_state->bs;
@@ -3307,6 +3373,22 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
         drv->bdrv_reopen_commit(reopen_state);
     }
 
+    /* Change the backing file if a new one was specified */
+    qobj = qdict_get(reopen_state->options, "backing");
+    if (qobj) {
+        const char *str = qobject_get_try_str(qobj);
+        BlockDriverState *new_backing = str ? bdrv_find_node(str) : NULL;
+        BlockDriverState *overlay = bs;
+        /* If there are implicit nodes between the current BDS and its
+         * "actual" backing file, skip them */
+        while (backing_bs(overlay) && backing_bs(overlay)->implicit) {
+            overlay = backing_bs(overlay);
+        }
+        if (new_backing != backing_bs(overlay)) {
+            bdrv_set_backing_hd(overlay, new_backing, NULL);
+        }
+    }
+
     /* set BDS specific flags now */
     qobject_unref(bs->explicit_options);
 
-- 
2.11.0
