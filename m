Received: from eggs.gnu.org ([2001:4830:134:3::10]:53140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVN-0000jF-1r
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVI-0003nU-79
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:44 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 14 Jun 2018 18:49:02 +0300
Message-Id: <4a1c8fb9816de2115d08284c36d7a718b5e48de6.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH 05/10] block: Add 'keep_old_opts' parameter
 to bdrv_reopen_queue()
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

The bdrv_reopen_queue() function is used to create a queue with the
BDSs that are going to be reopened and their new options. Once the
queue is ready bdrv_reopen_multiple() is called to perform the
operation.

The original options from each one of the BDSs are kept, with the new
options passed to bdrv_reopen_queue() applied on top of them.

For "x-blockdev-reopen" we want a function that behaves much like
"blockdev-add". We want to ignore the previous set of options so that
only the ones actually specified by the user are applied, with the
rest having their default values.

We can achieve this by adding a new parameter to bdrv_reopen_queue()
that specifies whether the old set of options is kept or discarded
when building the reopen queue. All current callers will set that
parameter to true, but x-blockdev-reopen will set it to false.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c               | 34 +++++++++++++++++++---------------
 block/replication.c   |  4 ++--
 include/block/block.h |  3 ++-
 qemu-io-cmds.c        |  2 +-
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/block.c b/block.c
index a741300fae..0b9268a48d 100644
--- a/block.c
+++ b/block.c
@@ -2850,7 +2850,8 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
                                                  int flags,
                                                  const BdrvChildRole *role,
                                                  QDict *parent_options,
-                                                 int parent_flags)
+                                                 int parent_flags,
+                                                 bool keep_old_opts)
 {
     assert(bs != NULL);
 
@@ -2899,13 +2900,13 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     }
 
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
 
@@ -2923,10 +2924,12 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
         qobject_unref(options_copy);
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
 
     /* bdrv_open_inherit() sets and clears some additional flags internally */
     flags &= ~BDRV_O_PROTOCOL;
@@ -2967,7 +2970,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
         g_free(child_key_dot);
 
         bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options, 0,
-                                child->role, options, flags);
+                                child->role, options, flags, keep_old_opts);
     }
 
     return bs_queue;
@@ -2975,10 +2978,11 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
 
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     BlockDriverState *bs,
-                                    QDict *options, int flags)
+                                    QDict *options, int flags,
+                                    bool keep_old_opts)
 {
     return bdrv_reopen_queue_child(bs_queue, bs, options, flags,
-                                   NULL, NULL, 0);
+                                   NULL, NULL, 0, keep_old_opts);
 }
 
 /*
@@ -3049,7 +3053,7 @@ int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp)
 
     bdrv_subtree_drained_begin(bs);
 
-    queue = bdrv_reopen_queue(NULL, bs, NULL, bdrv_flags);
+    queue = bdrv_reopen_queue(NULL, bs, NULL, bdrv_flags, true);
     ret = bdrv_reopen_multiple(bdrv_get_aio_context(bs), queue, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/block/replication.c b/block/replication.c
index 826db7b304..af984c29dd 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -401,12 +401,12 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
 
     if (orig_hidden_flags != new_hidden_flags) {
         reopen_queue = bdrv_reopen_queue(reopen_queue, s->hidden_disk->bs, NULL,
-                                         new_hidden_flags);
+                                         new_hidden_flags, true);
     }
 
     if (!(orig_secondary_flags & BDRV_O_RDWR)) {
         reopen_queue = bdrv_reopen_queue(reopen_queue, s->secondary_disk->bs,
-                                         NULL, new_secondary_flags);
+                                         NULL, new_secondary_flags, true);
     }
 
     if (reopen_queue) {
diff --git a/include/block/block.h b/include/block/block.h
index 9306c986ef..c8654dde65 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -267,7 +267,8 @@ BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
                                        int flags, Error **errp);
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     BlockDriverState *bs,
-                                    QDict *options, int flags);
+                                    QDict *options, int flags,
+                                    bool keep_old_opts);
 int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **errp);
 int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp);
 int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 5bf5f28178..4742358b1a 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2050,7 +2050,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
     qemu_opts_reset(&reopen_opts);
 
     bdrv_subtree_drained_begin(bs);
-    brq = bdrv_reopen_queue(NULL, bs, opts, flags);
+    brq = bdrv_reopen_queue(NULL, bs, opts, flags, true);
     bdrv_reopen_multiple(bdrv_get_aio_context(bs), brq, &local_err);
     bdrv_subtree_drained_end(bs);
 
-- 
2.11.0
