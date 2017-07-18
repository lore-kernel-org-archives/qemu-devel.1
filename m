Received: from eggs.gnu.org ([2001:4830:134:3::10]:53154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKX-0000U3-W5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKX-0007fe-3Z
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:29 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 18 Jul 2017 16:17:54 +0200
Message-Id: <1500387486-5469-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
References: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/21] block/qapi: Use blk_all_next() for
 query-block
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

This patch replaces the blk_next() loop in query-block by a
blk_all_next() one so that we also get access to BlockBackends that
aren't owned by the monitor. For now, the next thing we do is check
whether each BB has a name, so there is no semantic difference.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/qapi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index c8a45ec..164dd2b 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -472,8 +472,14 @@ BlockInfoList *qmp_query_block(Error **errp)
     BlockBackend *blk;
     Error *local_err = NULL;
 
-    for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
-        BlockInfoList *info = g_malloc0(sizeof(*info));
+    for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
+        BlockInfoList *info;
+
+        if (!*blk_name(blk)) {
+            continue;
+        }
+
+        info = g_malloc0(sizeof(*info));
         bdrv_query_info(blk, &info->value, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-- 
1.8.3.1
