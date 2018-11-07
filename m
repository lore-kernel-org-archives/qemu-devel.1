Received: from eggs.gnu.org ([2001:4830:134:3::10]:46738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gKNSU-0003xe-4N
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:01:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gKNSA-0002GC-W8
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:01:13 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  7 Nov 2018 14:59:36 +0200
Message-Id: <ad2cd135ee885b8a942e1f049c2260cb0073b497.1541595424.git.berto@igalia.com>
In-Reply-To: <cover.1541595424.git.berto@igalia.com>
References: <cover.1541595424.git.berto@igalia.com>
In-Reply-To: <cover.1541595424.git.berto@igalia.com>
References: <cover.1541595424.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 01/15] block: Add bdrv_reopen_set_read_only()
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
index fd67e14dfa..4e82c71ba4 100644
--- a/block.c
+++ b/block.c
@@ -3127,6 +3127,23 @@ int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp)
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
index 7f5453b45b..382e6643fc 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -303,6 +303,8 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
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
