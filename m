Received: from eggs.gnu.org ([2001:4830:134:3::10]:33317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9nz-00058U-H0
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9nu-0006At-Im
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:39:03 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  6 Jul 2017 18:38:27 +0200
Message-Id: <20170706163828.24082-11-pbonzini@redhat.com>
In-Reply-To: <20170706163828.24082-1-pbonzini@redhat.com>
References: <20170706163828.24082-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 10/11] block: do not take AioContext around
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

Reopen needs to handle AioContext carefully due to calling
bdrv_drain_all_begin/end.  By not taking AioContext around calls to
bdrv_reopen_multiple, we can drop the function's release/acquire
pair and the AioContext argument too.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c               |  6 ++----
 block/block-backend.c |  5 -----
 block/commit.c        |  2 +-
 block/mirror.c        |  9 ---------
 block/replication.c   |  3 +--
 blockdev.c            | 19 ++++++-------------
 include/block/block.h |  2 +-
 qemu-io-cmds.c        |  2 +-
 8 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/block.c b/block.c
index af0a9a1c22..4bf6ab11f7 100644
--- a/block.c
+++ b/block.c
@@ -2793,7 +2793,7 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
  * to all devices.
  *
  */
-int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **errp)
+int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
 {
     int ret = -1;
     BlockReopenQueueEntry *bs_entry, *next;
@@ -2801,9 +2801,7 @@ int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **er
 
     assert(bs_queue != NULL);
 
-    aio_context_release(ctx);
     bdrv_drain_all_begin();
-    aio_context_acquire(ctx);
 
     QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
         if (bdrv_reopen_prepare(&bs_entry->state, bs_queue, &local_err)) {
@@ -2847,7 +2845,7 @@ int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp)
     Error *local_err = NULL;
     BlockReopenQueue *queue = bdrv_reopen_queue(NULL, bs, NULL, bdrv_flags);
 
-    ret = bdrv_reopen_multiple(bdrv_get_aio_context(bs), queue, &local_err);
+    ret = bdrv_reopen_multiple(queue, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
     }
diff --git a/block/block-backend.c b/block/block-backend.c
index 0df3457a09..0ce1fb1c26 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1888,17 +1888,12 @@ int blk_commit_all(void)
     BlockBackend *blk = NULL;
 
     while ((blk = blk_all_next(blk)) != NULL) {
-        AioContext *aio_context = blk_get_aio_context(blk);
-
-        aio_context_acquire(aio_context);
         if (blk_is_inserted(blk) && blk->root->bs->backing) {
             int ret = bdrv_commit(blk->root->bs);
             if (ret < 0) {
-                aio_context_release(aio_context);
                 return ret;
             }
         }
-        aio_context_release(aio_context);
     }
     return 0;
 }
diff --git a/block/commit.c b/block/commit.c
index 8c09c3dbcd..1fe67fa8db 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -335,7 +335,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
                                          orig_overlay_flags | BDRV_O_RDWR);
     }
     if (reopen_queue) {
-        bdrv_reopen_multiple(bdrv_get_aio_context(bs), reopen_queue, &local_err);
+        bdrv_reopen_multiple(reopen_queue, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
             goto fail;
diff --git a/block/mirror.c b/block/mirror.c
index 68744a17e8..804edbad21 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -505,7 +505,6 @@ static void mirror_exit(BlockJob *job, void *opaque)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
     MirrorExitData *data = opaque;
-    AioContext *replace_aio_context = NULL;
     BlockDriverState *src = s->source;
     BlockDriverState *target_bs = blk_bs(s->target);
     BlockDriverState *mirror_top_bs = s->mirror_top_bs;
@@ -545,11 +544,6 @@ static void mirror_exit(BlockJob *job, void *opaque)
         }
     }
 
-    if (s->to_replace) {
-        replace_aio_context = bdrv_get_aio_context(s->to_replace);
-        aio_context_acquire(replace_aio_context);
-    }
-
     if (s->should_complete && data->ret == 0) {
         BlockDriverState *to_replace = src;
         if (s->to_replace) {
@@ -575,9 +569,6 @@ static void mirror_exit(BlockJob *job, void *opaque)
         error_free(s->replace_blocker);
         bdrv_unref(s->to_replace);
     }
-    if (replace_aio_context) {
-        aio_context_release(replace_aio_context);
-    }
     g_free(s->replaces);
     bdrv_unref(target_bs);
 
diff --git a/block/replication.c b/block/replication.c
index 7a3b94b90f..9350ef100b 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -381,8 +381,7 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
     }
 
     if (reopen_queue) {
-        bdrv_reopen_multiple(bdrv_get_aio_context(bs),
-                             reopen_queue, &local_err);
+        bdrv_reopen_multiple(reopen_queue, &local_err);
         error_propagate(errp, local_err);
     }
 }
diff --git a/blockdev.c b/blockdev.c
index b2c305402d..88ab606949 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3710,7 +3710,6 @@ void qmp_change_backing_file(const char *device,
                              Error **errp)
 {
     BlockDriverState *bs = NULL;
-    AioContext *aio_context;
     BlockDriverState *image_bs = NULL;
     Error *local_err = NULL;
     bool ro;
@@ -3722,37 +3721,34 @@ void qmp_change_backing_file(const char *device,
         return;
     }
 
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
     image_bs = bdrv_lookup_bs(NULL, image_node_name, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out;
+        return;
     }
 
     if (!image_bs) {
         error_setg(errp, "image file not found");
-        goto out;
+        return;
     }
 
     if (bdrv_find_base(image_bs) == image_bs) {
         error_setg(errp, "not allowing backing file change on an image "
                          "without a backing file");
-        goto out;
+        return;
     }
 
     /* even though we are not necessarily operating on bs, we need it to
      * determine if block ops are currently prohibited on the chain */
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_CHANGE, errp)) {
-        goto out;
+        return;
     }
 
     /* final sanity check */
     if (!bdrv_chain_contains(bs, image_bs)) {
         error_setg(errp, "'%s' and image file are not in the same chain",
                    device);
-        goto out;
+        return;
     }
 
     /* if not r/w, reopen to make r/w */
@@ -3763,7 +3759,7 @@ void qmp_change_backing_file(const char *device,
         bdrv_reopen(image_bs, open_flags | BDRV_O_RDWR, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            goto out;
+            return;
         }
     }
 
@@ -3781,9 +3777,6 @@ void qmp_change_backing_file(const char *device,
         bdrv_reopen(image_bs, open_flags, &local_err);
         error_propagate(errp, local_err);
     }
-
-out:
-    aio_context_release(aio_context);
 }
 
 void hmp_drive_add_node(Monitor *mon, const char *optstr)
diff --git a/include/block/block.h b/include/block/block.h
index 85e4be7462..f533f80f1f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -265,7 +265,7 @@ BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     BlockDriverState *bs,
                                     QDict *options, int flags);
-int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **errp);
+int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp);
 int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp);
 int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
                         BlockReopenQueue *queue, Error **errp);
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index b0ea327024..19d3114542 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2006,7 +2006,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
     qemu_opts_reset(&reopen_opts);
 
     brq = bdrv_reopen_queue(NULL, bs, opts, flags);
-    bdrv_reopen_multiple(bdrv_get_aio_context(bs), brq, &local_err);
+    bdrv_reopen_multiple(brq, &local_err);
     if (local_err) {
         error_report_err(local_err);
     } else {
-- 
2.13.0
