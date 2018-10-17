Received: from eggs.gnu.org ([2001:4830:134:3::10]:52342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPL-0005IH-82
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPH-0006Y5-3N
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:39 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 15:57:18 +0300
Message-Id: <38f4b775e2acf6e97b152fceed6993756c7c94a9.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 02/14] block: Add bdrv_reopen_set_read_only()
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

Most callers of bdrv_reopen() only use it to switch a BlockDriverState
between read-only and read-write, so this patch adds a new function
that does just that.

We also want to get rid of the flags parameter in the bdrv_reopen()
API, so this function sets the "read-only" option and passes the
original flags (which will then be updated in bdrv_reopen_prepare()).

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block.c               | 17 +++++++++++++++++
 include/block/block.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/block.c b/block.c
index 47d5fe2f91..40c3a3d30b 100644
--- a/block.c
+++ b/block.c
@@ -3098,6 +3098,23 @@ int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp)
     return ret;
 }
 
+int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
+                              Error **errp)
+{
+    int ret;
+    BlockReopenQueue *queue;
+    QDict *opts = qdict_new();
+
+    qdict_put_bool(opts, BDRV_OPT_READ_ONLY, read_only);
+
+    bdrv_subtree_drained_begin(bs);
+    queue = bdrv_reopen_queue(NULL, bs, opts, bdrv_get_flags(bs));
+    ret = bdrv_reopen_multiple(bdrv_get_aio_context(bs), queue, errp);
+    bdrv_subtree_drained_end(bs);
+
+    return ret;
+}
+
 static BlockReopenQueueEntry *find_parent_in_reopen_queue(BlockReopenQueue *q,
                                                           BdrvChild *c)
 {
diff --git a/include/block/block.h b/include/block/block.h
index b189cf422e..97317fdfb6 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -301,6 +301,8 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     QDict *options, int flags);
 int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **errp);
 int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp);
+int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
+                              Error **errp);
 int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
                         BlockReopenQueue *queue, Error **errp);
 void bdrv_reopen_commit(BDRVReopenState *reopen_state);
-- 
2.11.0
