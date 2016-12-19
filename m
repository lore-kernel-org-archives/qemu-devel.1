Received: from eggs.gnu.org ([2001:4830:134:3::10]:58405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cItgD-0004B6-82
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cItgA-00080L-Br
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:52:21 -0500
Received: from [59.151.112.132] (port=17864 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cItg9-0007mf-FQ
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 03:52:18 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Mon, 19 Dec 2016 16:51:23 +0800
Message-ID: <1482137486-9843-2-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC v2 1/4] block: refactor bdrv_next_node for
 readability
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

make the bdrv_next_node() clearly and add some comments.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 block.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 39ddea3..01c9e51 100644
--- a/block.c
+++ b/block.c
@@ -2931,12 +2931,20 @@ bool bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base)
     return top != NULL;
 }
 
+/*
+ * Return the BlockDriverStates of all the named nodes.
+ * If @bs is null, return the first one.
+ * Else, return @bs's next sibling, which may be null.
+ *
+ * To iterate over all BlockDriverStates, do
+ * for (bs = bdrv_next_node(NULL); bs; bs = bdrv_next_node(blk)) {
+ *     ...
+ * }
+ */
 BlockDriverState *bdrv_next_node(BlockDriverState *bs)
 {
-    if (!bs) {
-        return QTAILQ_FIRST(&graph_bdrv_states);
-    }
-    return QTAILQ_NEXT(bs, node_list);
+    return bs ? QTAILQ_NEXT(bs, node_list)
+            : QTAILQ_FIRST(&graph_bdrv_states);
 }
 
 const char *bdrv_get_node_name(const BlockDriverState *bs)
-- 
2.5.5
