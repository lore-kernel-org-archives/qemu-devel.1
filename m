Received: from eggs.gnu.org ([2001:4830:134:3::10]:34818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clwPb-0000Hi-7r
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clwPZ-0006XP-TE
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:39:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  9 Mar 2017 12:38:57 +0100
Message-Id: <1489059542-14232-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489059542-14232-1-git-send-email-kwolf@redhat.com>
References: <1489059542-14232-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] block: Remove check_new_perm from
 bdrv_replace_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

All callers pass false now, so the parameter can go away again.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index dd9ded8..756d607 100644
--- a/block.c
+++ b/block.c
@@ -1751,8 +1751,18 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
     }
 }
 
-static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs,
-                               bool check_new_perm)
+/*
+ * Updates @child to change its reference to point to @new_bs, including
+ * checking and applying the necessary permisson updates both to the old node
+ * and to @new_bs.
+ *
+ * NULL is passed as @new_bs for removing the reference before freeing @child.
+ *
+ * If @new_bs is not NULL, bdrv_check_perm() must be called beforehand, as this
+ * function uses bdrv_set_perm() to update the permissions according to the new
+ * reference that @new_bs gets.
+ */
+static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
 {
     BlockDriverState *old_bs = child->bs;
     uint64_t perm, shared_perm;
@@ -1770,9 +1780,6 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs,
 
     if (new_bs) {
         bdrv_get_cumulative_perm(new_bs, &perm, &shared_perm);
-        if (check_new_perm) {
-            bdrv_check_perm(new_bs, perm, shared_perm, NULL, &error_abort);
-        }
         bdrv_set_perm(new_bs, perm, shared_perm);
     }
 }
@@ -1803,7 +1810,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
     };
 
     /* This performs the matching bdrv_set_perm() for the above check. */
-    bdrv_replace_child(child, child_bs, false);
+    bdrv_replace_child(child, child_bs);
 
     return child;
 }
@@ -1840,7 +1847,7 @@ static void bdrv_detach_child(BdrvChild *child)
         child->next.le_prev = NULL;
     }
 
-    bdrv_replace_child(child, NULL, false);
+    bdrv_replace_child(child, NULL);
 
     g_free(child->name);
     g_free(child);
-- 
1.8.3.1
