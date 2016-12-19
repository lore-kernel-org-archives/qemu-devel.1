Received: from eggs.gnu.org ([2001:4830:134:3::10]:58410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cItgD-0004B8-AV
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cItgB-00081S-Ry
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:52:21 -0500
Received: from [59.151.112.132] (port=17864 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cItgB-0007mf-DZ
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:52:19 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Mon, 19 Dec 2016 16:51:25 +0800
Message-ID: <1482137486-9843-4-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC v2 3/4] block/qapi: acquire a reference
 instead of a lock during querying blockstats
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

This patch works to improve the performance of the query requests.

>From the commit 13344f3a, it adds a lock to make query-blockstats
safe by the aio_context_acquire(). the qmp_query_blockstats func
requires/releases the AioContext lock, which takes some time and
blocks the I/O processing. It affects the performance, especially
in the multi-disks guests.

As the low-level details of block statistics inside QEMU, we can
acquire a reference instead of the lock.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 block/qapi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index bc622cd..2262918 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -457,17 +457,21 @@ static BlockStats *bdrv_query_bds_stats(const BlockDriverState *bs,
 }
 
 static BlockStats *bdrv_query_stats(BlockBackend *blk,
-                                    const BlockDriverState *bs,
+                                    BlockDriverState *bs,
                                     bool query_backing)
 {
     BlockStats *s;
 
+    bdrv_ref(bs);
     s = bdrv_query_bds_stats(bs, query_backing);
+    bdrv_unref(bs);
 
     if (blk) {
+        blk_ref(blk);
         s->has_device = true;
         s->device = g_strdup(blk_name(blk));
         bdrv_query_blk_stats(s->stats, blk);
+        blk_unref(blk);
     }
 
     return s;
@@ -523,13 +527,8 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
 
     while (next_query_bds(&blk, &bs, query_nodes)) {
         BlockStatsList *info = g_malloc0(sizeof(*info));
-        AioContext *ctx = blk ? blk_get_aio_context(blk)
-                              : bdrv_get_aio_context(bs);
 
-        aio_context_acquire(ctx);
         info->value = bdrv_query_stats(blk, bs, !query_nodes);
-        aio_context_release(ctx);
-
         *p_next = info;
         p_next = &info->next;
     }
-- 
2.5.5
