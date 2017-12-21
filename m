Received: from eggs.gnu.org ([2001:4830:134:3::10]:43366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1lf-0003aZ-Vf
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1le-0002aa-PA
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:24:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 21 Dec 2017 15:22:51 +0100
Message-Id: <20171221142251.18366-20-kwolf@redhat.com>
In-Reply-To: <20171221142251.18366-1-kwolf@redhat.com>
References: <20171221142251.18366-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 19/19] block: Keep nodes drained between
 reopen_queue/multiple
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

The bdrv_reopen*() implementation doesn't like it if the graph is
changed between queuing nodes for reopen and actually reopening them
(one of the reasons is that queuing can be recursive).

So instead of draining the device only in bdrv_reopen_multiple(),
require that callers already drained all affected nodes, and assert this
in bdrv_reopen_queue().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block.c             | 23 ++++++++++++++++-------
 block/replication.c |  6 ++++++
 qemu-io-cmds.c      |  3 +++
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 56e446cf9d..6b4401760f 100644
--- a/block.c
+++ b/block.c
@@ -2766,6 +2766,7 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
  * returns a pointer to bs_queue, which is either the newly allocated
  * bs_queue, or the existing bs_queue being used.
  *
+ * bs must be drained between bdrv_reopen_queue() and bdrv_reopen_multiple().
  */
 static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
                                                  BlockDriverState *bs,
@@ -2781,6 +2782,11 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     BdrvChild *child;
     QDict *old_options, *explicit_options;
 
+    /* Make sure that the caller remembered to use a drained section. This is
+     * important to avoid graph changes between the recursive queuing here and
+     * bdrv_reopen_multiple(). */
+    assert(bs->quiesce_counter > 0);
+
     if (bs_queue == NULL) {
         bs_queue = g_new0(BlockReopenQueue, 1);
         QSIMPLEQ_INIT(bs_queue);
@@ -2905,6 +2911,8 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
  * If all devices prepare successfully, then the changes are committed
  * to all devices.
  *
+ * All affected nodes must be drained between bdrv_reopen_queue() and
+ * bdrv_reopen_multiple().
  */
 int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **errp)
 {
@@ -2914,11 +2922,8 @@ int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **er
 
     assert(bs_queue != NULL);
 
-    aio_context_release(ctx);
-    bdrv_drain_all_begin();
-    aio_context_acquire(ctx);
-
     QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+        assert(bs_entry->state.bs->quiesce_counter > 0);
         if (bdrv_reopen_prepare(&bs_entry->state, bs_queue, &local_err)) {
             error_propagate(errp, local_err);
             goto cleanup;
@@ -2947,8 +2952,6 @@ cleanup:
     }
     g_free(bs_queue);
 
-    bdrv_drain_all_end();
-
     return ret;
 }
 
@@ -2958,12 +2961,18 @@ int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp)
 {
     int ret = -1;
     Error *local_err = NULL;
-    BlockReopenQueue *queue = bdrv_reopen_queue(NULL, bs, NULL, bdrv_flags);
+    BlockReopenQueue *queue;
 
+    bdrv_subtree_drained_begin(bs);
+
+    queue = bdrv_reopen_queue(NULL, bs, NULL, bdrv_flags);
     ret = bdrv_reopen_multiple(bdrv_get_aio_context(bs), queue, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
     }
+
+    bdrv_subtree_drained_end(bs);
+
     return ret;
 }
 
diff --git a/block/replication.c b/block/replication.c
index e41e293d2b..b1ea3caa4b 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -394,6 +394,9 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
         new_secondary_flags = s->orig_secondary_flags;
     }
 
+    bdrv_subtree_drained_begin(s->hidden_disk->bs);
+    bdrv_subtree_drained_begin(s->secondary_disk->bs);
+
     if (orig_hidden_flags != new_hidden_flags) {
         reopen_queue = bdrv_reopen_queue(reopen_queue, s->hidden_disk->bs, NULL,
                                          new_hidden_flags);
@@ -409,6 +412,9 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
                              reopen_queue, &local_err);
         error_propagate(errp, local_err);
     }
+
+    bdrv_subtree_drained_end(s->hidden_disk->bs);
+    bdrv_subtree_drained_end(s->secondary_disk->bs);
 }
 
 static void backup_job_cleanup(BlockDriverState *bs)
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index de8e3de726..a6a70fc3dc 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2013,8 +2013,11 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
     opts = qopts ? qemu_opts_to_qdict(qopts, NULL) : NULL;
     qemu_opts_reset(&reopen_opts);
 
+    bdrv_subtree_drained_begin(bs);
     brq = bdrv_reopen_queue(NULL, bs, opts, flags);
     bdrv_reopen_multiple(bdrv_get_aio_context(bs), brq, &local_err);
+    bdrv_subtree_drained_end(bs);
+
     if (local_err) {
         error_report_err(local_err);
     } else {
-- 
2.13.6
