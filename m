Received: from eggs.gnu.org ([2001:4830:134:3::10]:44905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUFD-0005te-CA
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUFC-0003WT-L4
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:48:07 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Apr 2017 15:47:44 +0200
Message-Id: <1491572865-8549-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
References: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/10] block: Assert attached child node has
 right aio context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block.c b/block.c
index 927ba89..b8a3011 100644
--- a/block.c
+++ b/block.c
@@ -1752,6 +1752,9 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
 {
     BlockDriverState *old_bs = child->bs;
 
+    if (old_bs && new_bs) {
+        assert(bdrv_get_aio_context(old_bs) == bdrv_get_aio_context(new_bs));
+    }
     if (old_bs) {
         if (old_bs->quiesce_counter && child->role->drained_end) {
             child->role->drained_end(child);
@@ -1852,6 +1855,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
     bdrv_get_cumulative_perm(parent_bs, &perm, &shared_perm);
 
     assert(parent_bs->drv);
+    assert(bdrv_get_aio_context(parent_bs) == bdrv_get_aio_context(child_bs));
     parent_bs->drv->bdrv_child_perm(parent_bs, NULL, child_role,
                                     perm, shared_perm, &perm, &shared_perm);
 
-- 
1.8.3.1
