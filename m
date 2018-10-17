Received: from eggs.gnu.org ([2001:4830:134:3::10]:52599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPe-0005cb-GJ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPd-0007pW-1e
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:58 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 15:57:30 +0300
Message-Id: <8bbea9f80f6bc15005f18a4065e86eda1b17dd5d.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 14/14] block: Stop passing flags to
 bdrv_reopen_queue_child()
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

Now that all callers are passing the new options using the QDict we no
longer need the 'flags' parameter.

This patch makes the following changes:

   1) The update_options_from_flags() call is no longer necessary
      so it can be removed.

   2) The update_flags_from_options() call is now used in all cases,
      and is moved down a few lines so it happens after the options
      QDict contains the final set of values.

   3) The flags parameter is removed. Now the flags are initialized
      using the current value (for the top-level node) or the parent
      flags (after inherit_options()). In both cases the initial
      values are updated to reflect the new options in the QDict. This
      happens in bdrv_reopen_queue_child() (as explained above) and in
      bdrv_reopen_prepare().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 62 ++++++++++++++++++++++++++------------------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/block.c b/block.c
index 194200908d..810b4083fe 100644
--- a/block.c
+++ b/block.c
@@ -2876,7 +2876,6 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
 static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
                                                  BlockDriverState *bs,
                                                  QDict *options,
-                                                 int flags,
                                                  const BdrvChildRole *role,
                                                  QDict *parent_options,
                                                  int parent_flags)
@@ -2885,7 +2884,10 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
 
     BlockReopenQueueEntry *bs_entry;
     BdrvChild *child;
-    QDict *old_options, *explicit_options;
+    QDict *old_options, *explicit_options, *options_copy;
+    int flags;
+    QemuOpts *opts;
+    Error *local_err = NULL;
 
     /* Make sure that the caller remembered to use a drained section. This is
      * important to avoid graph changes between the recursive queuing here and
@@ -2911,22 +2913,11 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     /*
      * Precedence of options:
      * 1. Explicitly passed in options (highest)
-     * 2. Set in flags (only for top level)
-     * 3. Retained from explicitly set options of bs
-     * 4. Inherited from parent node
-     * 5. Retained from effective options of bs
+     * 2. Retained from explicitly set options of bs
+     * 3. Inherited from parent node
+     * 4. Retained from effective options of bs
      */
 
-    if (!parent_options) {
-        /*
-         * Any setting represented by flags is always updated. If the
-         * corresponding QDict option is set, it takes precedence. Otherwise
-         * the flag is translated into a QDict option. The old setting of bs is
-         * not considered.
-         */
-        update_options_from_flags(options, flags);
-    }
-
     /* Old explicitly set values (don't overwrite by inherited value) */
     if (bs_entry) {
         old_options = qdict_clone_shallow(bs_entry->state.explicit_options);
@@ -2940,23 +2931,10 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
 
     /* Inherit from parent node */
     if (parent_options) {
-        QemuOpts *opts;
-        QDict *options_copy;
-        Error *local_err = NULL;
-        assert(!flags);
+        flags = 0;
         role->inherit_options(&flags, options, parent_flags, parent_options);
-        options_copy = qdict_clone_shallow(options);
-        opts = qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_abort);
-        qemu_opts_absorb_qdict(opts, options_copy, &local_err);
-        /* Don't call update_flags_from_options() if the options are wrong.
-         * bdrv_reopen_prepare() will later return an error. */
-        if (!local_err) {
-            update_flags_from_options(&flags, opts);
-        } else {
-            error_free(local_err);
-        }
-        qemu_opts_del(opts);
-        qobject_unref(options_copy);
+    } else {
+        flags = bdrv_get_flags(bs);
     }
 
     /* Old values are used for options that aren't set yet */
@@ -2964,6 +2942,20 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     bdrv_join_options(bs, options, old_options);
     qobject_unref(old_options);
 
+    /* We have the final set of options so let's update the flags */
+    options_copy = qdict_clone_shallow(options);
+    opts = qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_abort);
+    qemu_opts_absorb_qdict(opts, options_copy, &local_err);
+    /* Don't call update_flags_from_options() if the options are wrong.
+     * bdrv_reopen_prepare() will later return an error. */
+    if (!local_err) {
+        update_flags_from_options(&flags, opts);
+    } else {
+        error_free(local_err);
+    }
+    qemu_opts_del(opts);
+    qobject_unref(options_copy);
+
     /* bdrv_open_inherit() sets and clears some additional flags internally */
     flags &= ~BDRV_O_PROTOCOL;
     if (flags & BDRV_O_RDWR) {
@@ -3003,7 +2995,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
         qdict_extract_subqdict(options, &new_child_options, child_key_dot);
         g_free(child_key_dot);
 
-        bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options, 0,
+        bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options,
                                 child->role, options, flags);
     }
 
@@ -3014,9 +3006,7 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     BlockDriverState *bs,
                                     QDict *options)
 {
-    int flags = bdrv_get_flags(bs);
-    return bdrv_reopen_queue_child(bs_queue, bs, options, flags,
-                                   NULL, NULL, 0);
+    return bdrv_reopen_queue_child(bs_queue, bs, options, NULL, NULL, 0);
 }
 
 /*
-- 
2.11.0
