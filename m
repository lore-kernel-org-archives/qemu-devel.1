Received: from eggs.gnu.org ([2001:4830:134:3::10]:58424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cItgD-0004B9-R0
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cItgC-000829-Io
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:52:21 -0500
Received: from [59.151.112.132] (port=14691 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cItgC-0007zG-3w
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:52:20 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Mon, 19 Dec 2016 16:51:26 +0800
Message-ID: <1482137486-9843-5-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC v2 4/4] block/qapi: optimize the query
 function of the blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, famz@redhat.com, danpb@redhat.com
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com

this patch works to optimize the qmp_query_blockstats() by removing
additional performance overhead from the next_query_bds and
bdrv_query_stats.

It removes that two functions, and also makes the structure of the
code clearly.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 block/qapi.c | 69 +++++++++++++++++++++++-------------------------------------
 1 file changed, 26 insertions(+), 43 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 2262918..d561945 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -456,27 +456,6 @@ static BlockStats *bdrv_query_bds_stats(const BlockDriverState *bs,
     return s;
 }
 
-static BlockStats *bdrv_query_stats(BlockBackend *blk,
-                                    BlockDriverState *bs,
-                                    bool query_backing)
-{
-    BlockStats *s;
-
-    bdrv_ref(bs);
-    s = bdrv_query_bds_stats(bs, query_backing);
-    bdrv_unref(bs);
-
-    if (blk) {
-        blk_ref(blk);
-        s->has_device = true;
-        s->device = g_strdup(blk_name(blk));
-        bdrv_query_blk_stats(s->stats, blk);
-        blk_unref(blk);
-    }
-
-    return s;
-}
-
 BlockInfoList *qmp_query_block(Error **errp)
 {
     BlockInfoList *head = NULL, **p_next = &head;
@@ -500,37 +479,41 @@ BlockInfoList *qmp_query_block(Error **errp)
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
+    if (has_query_nodes && query_nodes) {
+        for (bs = bdrv_next_node(NULL); bs; bs = bdrv_next_node(bs)) {
+            BlockStatsList *info = g_malloc0(sizeof(*info));
 
-    while (next_query_bds(&blk, &bs, query_nodes)) {
-        BlockStatsList *info = g_malloc0(sizeof(*info));
+            bdrv_ref(bs);
+            info->value = bdrv_query_bds_stats(bs, false);
+            bdrv_unref(bs);
 
-        info->value = bdrv_query_stats(blk, bs, !query_nodes);
-        *p_next = info;
-        p_next = &info->next;
+            *p_next = info;
+            p_next = &info->next;
+        }
+    } else {
+        for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
+            BlockStatsList *info = g_malloc0(sizeof(*info));
+
+            blk_ref(blk);
+            BlockStats *s = bdrv_query_bds_stats(blk_bs(blk), true);
+            s->has_device = true;
+            s->device = g_strdup(blk_name(blk));
+            bdrv_query_blk_stats(s->stats, blk);
+            blk_unref(blk);
+
+            info->value = s;
+            *p_next = info;
+            p_next = &info->next;
+        }
     }
 
     return head;
-- 
2.5.5
