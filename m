Received: from eggs.gnu.org ([2001:4830:134:3::10]:41611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFizL-0003QT-If
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFizK-0002W7-Q2
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:23:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 May 2017 17:22:50 +0200
Message-Id: <1496157773-10779-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496157773-10779-1-git-send-email-kwolf@redhat.com>
References: <1496157773-10779-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/4] block: Fix anonymous BBs in
 blk_root_inactivate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

blk->name isn't an array, but a pointer that can be NULL. Checking for
an anonymous BB must involve a NULL check first, otherwise we get
crashes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/block-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index f3a6008..7d7f369 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -168,7 +168,7 @@ static int blk_root_inactivate(BdrvChild *child)
      * this point because the VM is stopped) and unattached monitor-owned
      * BlockBackends. If there is still any other user like a block job, then
      * we simply can't inactivate the image. */
-    if (!blk->dev && !blk->name[0]) {
+    if (!blk->dev && !blk_name(blk)[0]) {
         return -EPERM;
     }
 
-- 
1.8.3.1
