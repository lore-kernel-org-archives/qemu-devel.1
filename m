Received: from eggs.gnu.org ([2001:4830:134:3::10]:35744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cSfl2-0000S1-Qr
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 03:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cSfl0-0004Z8-Qd
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 03:01:44 -0500
Received: from [59.151.112.132] (port=60606 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cSfl0-0004XJ-G0
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 03:01:42 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Sun, 15 Jan 2017 16:01:15 +0800
Message-ID: <1484467275-27919-3-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1484467275-27919-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1484467275-27919-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 2/2] block/qapi: reduce the execution time
 of qmp_query_blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, famz@redhat.com, danpb@redhat.com
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

In order to reduce the execution time, this patch optimize
the qmp_query_blockstats():
Remove the next_query_bds function.
Remove the bdrv_query_stats function.
Remove some judgement sentence.

The original qmp_query_blockstats calls next_query_bds to get
the next objects in each loops. In the next_query_bds, it checks
the query_nodes and blk. It also call bdrv_query_stats to get
the stats, In the bdrv_query_stats, it checks blk and bs each
times. This waste more times, which may stall the main loop a
bit. And if the disk is too many and donot use the dataplane
feature, this may affect the performance in main loop thread.

This patch removes that two functions, and makes the structure
clearly.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 block/qapi.c | 73 ++++++++++++++++++++++++------------------------------------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index bc622cd..45e9d47 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -456,23 +456,6 @@ static BlockStats *bdrv_query_bds_stats(const BlockDriverState *bs,
     return s;
 }
 
-static BlockStats *bdrv_query_stats(BlockBackend *blk,
-                                    const BlockDriverState *bs,
-                                    bool query_backing)
-{
-    BlockStats *s;
-
-    s = bdrv_query_bds_stats(bs, query_backing);
-
-    if (blk) {
-        s->has_device = true;
-        s->device = g_strdup(blk_name(blk));
-        bdrv_query_blk_stats(s->stats, blk);
-    }
-
-    return s;
-}
-
 BlockInfoList *qmp_query_block(Error **errp)
 {
     BlockInfoList *head = NULL, **p_next = &head;
@@ -496,42 +479,44 @@ BlockInfoList *qmp_query_block(Error **errp)
     return head;
 }
 
-static bool next_query_bds(BlockBackend **blk, BlockDriverState **bs,
-                           bool query_nodes)
-{
-    if (query_nodes) {
-        *bs = bdrv_next_node(*bs);
-        return !!*bs;
-    }
-
-    *blk = blk_next(*blk);
-    *bs = *blk ? blk_bs(*blk) : NULL;
-
-    return !!*blk;
-}
-
 BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
                                      bool query_nodes,
                                      Error **errp)
 {
     BlockStatsList *head = NULL, **p_next = &head;
-    BlockBackend *blk = NULL;
-    BlockDriverState *bs = NULL;
+    BlockBackend *blk;
+    BlockDriverState *bs;
 
     /* Just to be safe if query_nodes is not always initialized */
-    query_nodes = has_query_nodes && query_nodes;
-
-    while (next_query_bds(&blk, &bs, query_nodes)) {
-        BlockStatsList *info = g_malloc0(sizeof(*info));
-        AioContext *ctx = blk ? blk_get_aio_context(blk)
-                              : bdrv_get_aio_context(bs);
+    if (has_query_nodes && query_nodes) {
+        for (bs = bdrv_next_node(NULL); bs; bs = bdrv_next_node(bs)) {
+            BlockStatsList *info = g_malloc0(sizeof(*info));
+            AioContext *ctx = bdrv_get_aio_context(bs);
 
-        aio_context_acquire(ctx);
-        info->value = bdrv_query_stats(blk, bs, !query_nodes);
-        aio_context_release(ctx);
+            aio_context_acquire(ctx);
+            info->value = bdrv_query_bds_stats(bs, false);
+            aio_context_release(ctx);
 
-        *p_next = info;
-        p_next = &info->next;
+            *p_next = info;
+            p_next = &info->next;
+        }
+    } else {
+        for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
+            BlockStatsList *info = g_malloc0(sizeof(*info));
+            AioContext *ctx = blk_get_aio_context(blk);
+            BlockStats *s;
+
+            aio_context_acquire(ctx);
+            info->value = s = bdrv_query_bds_stats(blk_bs(blk), true);
+            s->has_device = true;
+            s->device = g_strdup(blk_name(blk));
+            bdrv_query_blk_stats(s->stats, blk);
+            aio_context_release(ctx);
+
+            info->value = s;
+            *p_next = info;
+            p_next = &info->next;
+        }
     }
 
     return head;
-- 
2.5.5
