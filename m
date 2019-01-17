Received: from eggs.gnu.org ([209.51.188.92]:39392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9h4-0002FV-Gt
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9h1-0000FN-Pl
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:57 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 17 Jan 2019 17:33:56 +0200
Message-Id: <1ae9a829ee19b1f83d035c4d406f35213550a044.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 05/13] block: Add 'keep_old_opts' parameter to
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

The bdrv_reopen_queue() function is used to create a queue with
the BDSs that are going to be reopened and their new options. Once
the queue is ready bdrv_reopen_multiple() is called to perform the
operation.

The original options from each one of the BDSs are kept, with the new
options passed to bdrv_reopen_queue() applied on top of them.

For "x-blockdev-reopen" we want a function that behaves much like
"blockdev-add". We want to ignore the previous set of options so that
only the ones actually specified by the user are applied, with the
rest having their default values.

One of the things that we need is a way to tell bdrv_reopen_queue()
whether we want to keep the old set of options or not, and that's what
this patch does. All current callers are setting this new parameter to
true and x-blockdev-reopen will set it to false.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c               | 34 +++++++++++++++++++---------------
 block/replication.c   |  4 ++--
 include/block/block.h |  3 ++-
 qemu-io-cmds.c        |  2 +-
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/block.c b/block.c
index 51fac086c7..056a620eb2 100644
--- a/block.c
+++ b/block.c
@@ -2935,7 +2935,8 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
                                                  QDict *options,
                                                  const BdrvChildRole *role,
                                                  QDict *parent_options,
-                                                 int parent_flags)
+                                                 int parent_flags,
+                                                 bool keep_old_opts)
 {
     assert(bs != NULL);
 
@@ -2975,13 +2976,13 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
      */
 
     /* Old explicitly set values (don't overwrite by inherited value) */
-    if (bs_entry) {
-        old_options = qdict_clone_shallow(bs_entry->state.explicit_options);
-    } else {
-        old_options = qdict_clone_shallow(bs->explicit_options);
+    if (bs_entry || keep_old_opts) {
+        old_options = qdict_clone_shallow(bs_entry ?
+                                          bs_entry->state.explicit_options :
+                                          bs->explicit_options);
+        bdrv_join_options(bs, options, old_options);
+        qobject_unref(old_options);
     }
-    bdrv_join_options(bs, options, old_options);
-    qobject_unref(old_options);
 
     explicit_options = qdict_clone_shallow(options);
 
@@ -2993,10 +2994,12 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
         flags = bdrv_get_flags(bs);
     }
 
-    /* Old values are used for options that aren't set yet */
-    old_options = qdict_clone_shallow(bs->options);
-    bdrv_join_options(bs, options, old_options);
-    qobject_unref(old_options);
+    if (keep_old_opts) {
+        /* Old values are used for options that aren't set yet */
+        old_options = qdict_clone_shallow(bs->options);
+        bdrv_join_options(bs, options, old_options);
+        qobject_unref(old_options);
+    }
 
     /* We have the final set of options so let's update the flags */
     options_copy = qdict_clone_shallow(options);
@@ -3046,7 +3049,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
         g_free(child_key_dot);
 
         bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options,
-                                child->role, options, flags);
+                                child->role, options, flags, keep_old_opts);
     }
 
     return bs_queue;
@@ -3054,9 +3057,10 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
 
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     BlockDriverState *bs,
-                                    QDict *options)
+                                    QDict *options, bool keep_old_opts)
 {
-    return bdrv_reopen_queue_child(bs_queue, bs, options, NULL, NULL, 0);
+    return bdrv_reopen_queue_child(bs_queue, bs, options, NULL, NULL, 0,
+                                   keep_old_opts);
 }
 
 /*
@@ -3128,7 +3132,7 @@ int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
     qdict_put_bool(opts, BDRV_OPT_READ_ONLY, read_only);
 
     bdrv_subtree_drained_begin(bs);
-    queue = bdrv_reopen_queue(NULL, bs, opts);
+    queue = bdrv_reopen_queue(NULL, bs, opts, true);
     ret = bdrv_reopen_multiple(bdrv_get_aio_context(bs), queue, errp);
     bdrv_subtree_drained_end(bs);
 
diff --git a/block/replication.c b/block/replication.c
index e70dd95001..d35214370e 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -374,14 +374,14 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
         QDict *opts = qdict_new();
         qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !writable);
         reopen_queue = bdrv_reopen_queue(reopen_queue, s->hidden_disk->bs,
-                                         opts);
+                                         opts, true);
     }
 
     if (s->orig_secondary_read_only) {
         QDict *opts = qdict_new();
         qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !writable);
         reopen_queue = bdrv_reopen_queue(reopen_queue, s->secondary_disk->bs,
-                                         opts);
+                                         opts, true);
     }
 
     if (reopen_queue) {
diff --git a/include/block/block.h b/include/block/block.h
index 6f10a8fcfc..a061ef3944 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -299,7 +299,8 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
 BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
                                        int flags, Error **errp);
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
-                                    BlockDriverState *bs, QDict *options);
+                                    BlockDriverState *bs, QDict *options,
+                                    bool keep_old_opts);
 int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **errp);
 int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
                               Error **errp);
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 2c39124036..db8887205e 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2075,7 +2075,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
     }
 
     bdrv_subtree_drained_begin(bs);
-    brq = bdrv_reopen_queue(NULL, bs, opts);
+    brq = bdrv_reopen_queue(NULL, bs, opts, true);
     bdrv_reopen_multiple(bdrv_get_aio_context(bs), brq, &local_err);
     bdrv_subtree_drained_end(bs);
 
-- 
2.11.0
