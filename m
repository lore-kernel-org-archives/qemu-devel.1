Received: from eggs.gnu.org ([2001:4830:134:3::10]:52595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPe-0005cS-8w
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPd-0007pN-14
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:58 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 15:57:29 +0300
Message-Id: <ce3bdb5761047de7cb44a3d82497b89d44c6de46.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 13/14] block: Remove flags parameter from
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

Now that all callers are passing all flag changes as QDict options,
the flags parameter is no longer necessary, so we can get rid of it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block.c               | 5 +++--
 block/replication.c   | 6 ++----
 include/block/block.h | 3 +--
 qemu-io-cmds.c        | 2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/block.c b/block.c
index 406c2d1da7..194200908d 100644
--- a/block.c
+++ b/block.c
@@ -3012,8 +3012,9 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
 
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     BlockDriverState *bs,
-                                    QDict *options, int flags)
+                                    QDict *options)
 {
+    int flags = bdrv_get_flags(bs);
     return bdrv_reopen_queue_child(bs_queue, bs, options, flags,
                                    NULL, NULL, 0);
 }
@@ -3087,7 +3088,7 @@ int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
     qdict_put_bool(opts, BDRV_OPT_READ_ONLY, read_only);
 
     bdrv_subtree_drained_begin(bs);
-    queue = bdrv_reopen_queue(NULL, bs, opts, bdrv_get_flags(bs));
+    queue = bdrv_reopen_queue(NULL, bs, opts);
     ret = bdrv_reopen_multiple(bdrv_get_aio_context(bs), queue, errp);
     bdrv_subtree_drained_end(bs);
 
diff --git a/block/replication.c b/block/replication.c
index 481a225924..fdbfe47fa4 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -393,19 +393,17 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
     bdrv_subtree_drained_begin(s->secondary_disk->bs);
 
     if (s->orig_hidden_read_only) {
-        int flags = bdrv_get_flags(s->hidden_disk->bs);
         QDict *opts = qdict_new();
         qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !writable);
         reopen_queue = bdrv_reopen_queue(reopen_queue, s->hidden_disk->bs,
-                                         opts, flags);
+                                         opts);
     }
 
     if (s->orig_secondary_read_only) {
-        int flags = bdrv_get_flags(s->secondary_disk->bs);
         QDict *opts = qdict_new();
         qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !writable);
         reopen_queue = bdrv_reopen_queue(reopen_queue, s->secondary_disk->bs,
-                                         opts, flags);
+                                         opts);
     }
 
     if (reopen_queue) {
diff --git a/include/block/block.h b/include/block/block.h
index 3649136689..38d5c1adf4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -297,8 +297,7 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
 BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
                                        int flags, Error **errp);
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
-                                    BlockDriverState *bs,
-                                    QDict *options, int flags);
+                                    BlockDriverState *bs, QDict *options);
 int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **errp);
 int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
                               Error **errp);
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index b49a816cc8..e272e5c80b 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2075,7 +2075,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
     }
 
     bdrv_subtree_drained_begin(bs);
-    brq = bdrv_reopen_queue(NULL, bs, opts, flags);
+    brq = bdrv_reopen_queue(NULL, bs, opts);
     bdrv_reopen_multiple(bdrv_get_aio_context(bs), brq, &local_err);
     bdrv_subtree_drained_end(bs);
 
-- 
2.11.0
