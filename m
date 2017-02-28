Received: from eggs.gnu.org ([2001:4830:134:3::10]:44871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioWN-0005nD-4u
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioWM-0007km-9g
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:19 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 21:36:11 +0100
Message-Id: <1488314205-16264-13-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/46] block: Require .bdrv_child_perm() with
 child nodes
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

All block drivers that can have child nodes implement .bdrv_child_perm()
now. Make this officially a requirement by asserting that only drivers
without children can omit .bdrv_child_perm().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
---
 block.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 281ce7b..52c1f28 100644
--- a/block.c
+++ b/block.c
@@ -1360,8 +1360,9 @@ static int bdrv_check_perm(BlockDriverState *bs, uint64_t cumulative_perms,
                                     cumulative_shared_perms, errp);
     }
 
-    /* Drivers may not have .bdrv_child_perm() */
+    /* Drivers that never have children can omit .bdrv_child_perm() */
     if (!drv->bdrv_child_perm) {
+        assert(QLIST_EMPTY(&bs->children));
         return 0;
     }
 
@@ -1420,8 +1421,9 @@ static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
         drv->bdrv_set_perm(bs, cumulative_perms, cumulative_shared_perms);
     }
 
-    /* Drivers may not have .bdrv_child_perm() */
+    /* Drivers that never have children can omit .bdrv_child_perm() */
     if (!drv->bdrv_child_perm) {
+        assert(QLIST_EMPTY(&bs->children));
         return;
     }
 
-- 
1.8.3.1
