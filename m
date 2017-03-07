Received: from eggs.gnu.org ([2001:4830:134:3::10]:42469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEf-00028K-Vy
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEf-0002g5-6W
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:14 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:31 +0100
Message-Id: <1488901251-16214-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/27] block: Factor out
 bdrv_replace_child_noperm()
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/block.c b/block.c
index 6dc02b8..d4570c8 100644
--- a/block.c
+++ b/block.c
@@ -1713,11 +1713,10 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
     *nshared = shared;
 }
 
-static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs,
-                               bool check_new_perm)
+static void bdrv_replace_child_noperm(BdrvChild *child,
+                                      BlockDriverState *new_bs)
 {
     BlockDriverState *old_bs = child->bs;
-    uint64_t perm, shared_perm;
 
     if (old_bs) {
         if (old_bs->quiesce_counter && child->role->drained_end) {
@@ -1727,7 +1726,29 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs,
             child->role->detach(child);
         }
         QLIST_REMOVE(child, next_parent);
+    }
+
+    child->bs = new_bs;
+
+    if (new_bs) {
+        QLIST_INSERT_HEAD(&new_bs->parents, child, next_parent);
+        if (new_bs->quiesce_counter && child->role->drained_begin) {
+            child->role->drained_begin(child);
+        }
+
+        if (child->role->attach) {
+            child->role->attach(child);
+        }
+    }
+}
 
+static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs,
+                               bool check_new_perm)
+{
+    BlockDriverState *old_bs = child->bs;
+    uint64_t perm, shared_perm;
+
+    if (old_bs) {
         /* Update permissions for old node. This is guaranteed to succeed
          * because we're just taking a parent away, so we're loosening
          * restrictions. */
@@ -1736,23 +1757,14 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs,
         bdrv_set_perm(old_bs, perm, shared_perm);
     }
 
-    child->bs = new_bs;
+    bdrv_replace_child_noperm(child, new_bs);
 
     if (new_bs) {
-        QLIST_INSERT_HEAD(&new_bs->parents, child, next_parent);
-        if (new_bs->quiesce_counter && child->role->drained_begin) {
-            child->role->drained_begin(child);
-        }
-
         bdrv_get_cumulative_perm(new_bs, &perm, &shared_perm);
         if (check_new_perm) {
             bdrv_check_perm(new_bs, perm, shared_perm, &error_abort);
         }
         bdrv_set_perm(new_bs, perm, shared_perm);
-
-        if (child->role->attach) {
-            child->role->attach(child);
-        }
     }
 }
 
-- 
1.8.3.1
