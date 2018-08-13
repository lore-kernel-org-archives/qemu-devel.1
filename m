Received: from eggs.gnu.org ([2001:4830:134:3::10]:55653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpCtC-0001QJ-BQ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 09:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpCtB-0006hp-I5
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 09:28:06 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Aug 2018 15:27:54 +0200
Message-Id: <20180813132754.16744-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] block/qapi: Fix memory leak in
 qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

For BlockBackends that are skipped in query-blockstats, we would leak
info since commit 567dcb31. Allocate info only later to avoid the memory
leak.

Fixes: CID 1394727
Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qapi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/qapi.c b/block/qapi.c
index 339727f0f4..c66f949db8 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -594,7 +594,7 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
         }
     } else {
         for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
-            BlockStatsList *info = g_malloc0(sizeof(*info));
+            BlockStatsList *info;
             AioContext *ctx = blk_get_aio_context(blk);
             BlockStats *s;
             char *qdev;
@@ -619,6 +619,7 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
             bdrv_query_blk_stats(s->stats, blk);
             aio_context_release(ctx);
 
+            info = g_malloc0(sizeof(*info));
             info->value = s;
             *p_next = info;
             p_next = &info->next;
-- 
2.13.6
