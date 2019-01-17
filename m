Received: from eggs.gnu.org ([209.51.188.92]:38967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gl-0001q1-4u
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gh-0007bn-Ki
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:37 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 17 Jan 2019 17:34:02 +0200
Message-Id: <c8ddd623dcc47f8eac361561c088a11983b7cbee.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 11/13] block: Remove the AioContext parameter
 from bdrv_reopen_multiple()
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

This parameter has been unused since 1a63a907507fbbcfaee3f622907ec244b

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c               | 4 ++--
 block/replication.c   | 3 +--
 include/block/block.h | 2 +-
 qemu-io-cmds.c        | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index eea7aefa99..1eaca35dfc 100644
--- a/block.c
+++ b/block.c
@@ -3168,7 +3168,7 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
  * All affected nodes must be drained between bdrv_reopen_queue() and
  * bdrv_reopen_multiple().
  */
-int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **errp)
+int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
 {
     int ret = -1;
     BlockReopenQueueEntry *bs_entry, *next;
@@ -3221,7 +3221,7 @@ int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
 
     bdrv_subtree_drained_begin(bs);
     queue = bdrv_reopen_queue(NULL, bs, opts, true);
-    ret = bdrv_reopen_multiple(bdrv_get_aio_context(bs), queue, errp);
+    ret = bdrv_reopen_multiple(queue, errp);
     bdrv_subtree_drained_end(bs);
 
     return ret;
diff --git a/block/replication.c b/block/replication.c
index d35214370e..1c167e0d90 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -385,8 +385,7 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
     }
 
     if (reopen_queue) {
-        bdrv_reopen_multiple(bdrv_get_aio_context(bs),
-                             reopen_queue, &local_err);
+        bdrv_reopen_multiple(reopen_queue, &local_err);
         error_propagate(errp, local_err);
     }
 
diff --git a/include/block/block.h b/include/block/block.h
index e21616a038..0fa01c3139 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -302,7 +302,7 @@ BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     BlockDriverState *bs, QDict *options,
                                     bool keep_old_opts);
-int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **errp);
+int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp);
 int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
                               Error **errp);
 int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index db8887205e..416e74b53d 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2076,7 +2076,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
 
     bdrv_subtree_drained_begin(bs);
     brq = bdrv_reopen_queue(NULL, bs, opts, true);
-    bdrv_reopen_multiple(bdrv_get_aio_context(bs), brq, &local_err);
+    bdrv_reopen_multiple(brq, &local_err);
     bdrv_subtree_drained_end(bs);
 
     if (local_err) {
-- 
2.11.0
