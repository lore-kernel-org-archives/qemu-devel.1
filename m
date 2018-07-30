Received: from eggs.gnu.org ([2001:4830:134:3::10]:44153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oW-0003OY-7x
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oV-0008Nm-Eq
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 30 Jul 2018 17:09:57 +0200
Message-Id: <20180730150958.14607-13-kwolf@redhat.com>
In-Reply-To: <20180730150958.14607-1-kwolf@redhat.com>
References: <20180730150958.14607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/13] block/qapi: Include anonymous BBs in
 query-blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Consistent with query-block, query-blockstats should not only include
named BlockBackends, but also those that are anonymous, but belong to a
device model.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qapi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/qapi.c b/block/qapi.c
index 50f867d634..339727f0f4 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -593,12 +593,16 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
             p_next = &info->next;
         }
     } else {
-        for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
+        for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
             BlockStatsList *info = g_malloc0(sizeof(*info));
             AioContext *ctx = blk_get_aio_context(blk);
             BlockStats *s;
             char *qdev;
 
+            if (!*blk_name(blk) && !blk_get_attached_dev(blk)) {
+                continue;
+            }
+
             aio_context_acquire(ctx);
             s = bdrv_query_bds_stats(blk_bs(blk), true);
             s->has_device = true;
-- 
2.13.6
