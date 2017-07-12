Received: from eggs.gnu.org ([2001:4830:134:3::10]:45270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVHDy-0007CR-SC
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVHDy-0001U6-0o
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:39 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Jul 2017 14:57:24 +0200
Message-Id: <1499864249-26305-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 4/9] block/qapi: Use blk_all_next() for
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
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This patch replaces the blk_next() loop in query-block by a
blk_all_next() one so that we also get access to BlockBackends that
aren't owned by the monitor. For now, the next thing we do is check
whether each BB has a name, so there is no semantical difference.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qapi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 705cd11..2f86c79 100644
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
