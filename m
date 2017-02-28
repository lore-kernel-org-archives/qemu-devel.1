Received: from eggs.gnu.org ([2001:4830:134:3::10]:44897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioWP-0005pZ-5T
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioWO-0007lb-2d
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:21 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 21:36:12 +0100
Message-Id: <1488314205-16264-14-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/46] block: Request real permissions in
 bdrv_attach_child()
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

Now that all block drivers with children tell us what permissions they
need from each of their children, bdrv_attach_child() can use this
information and make the right requirements while trying to attach new
children.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 52c1f28..bed2367 100644
--- a/block.c
+++ b/block.c
@@ -1680,10 +1680,16 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              Error **errp)
 {
     BdrvChild *child;
+    uint64_t perm, shared_perm;
+
+    bdrv_get_cumulative_perm(parent_bs, &perm, &shared_perm);
+
+    assert(parent_bs->drv);
+    parent_bs->drv->bdrv_child_perm(parent_bs, NULL, child_role,
+                                    perm, shared_perm, &perm, &shared_perm);
 
-    /* FIXME Use real permissions */
     child = bdrv_root_attach_child(child_bs, child_name, child_role,
-                                   0, BLK_PERM_ALL, parent_bs, errp);
+                                   perm, shared_perm, parent_bs, errp);
     if (child == NULL) {
         return NULL;
     }
-- 
1.8.3.1
