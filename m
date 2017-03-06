Received: from eggs.gnu.org ([2001:4830:134:3::10]:54694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvPE-0002fL-Mj
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvPD-0001ET-GV
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:22:40 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  6 Mar 2017 17:22:00 +0100
Message-Id: <1488817322-11397-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 08/10] block: Ignore multiple children in
 bdrv_check_update_perm()
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

change_parent_backing_link() will need to update multiple BdrvChild
objects at once. Checking permissions reference by reference doesn't
work because permissions need to be consistent only with all parents
moved to the new child.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                   | 35 ++++++++++++++++++++++-------------
 include/block/block_int.h |  2 +-
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/block.c b/block.c
index d4570c8..a7b09d3 100644
--- a/block.c
+++ b/block.c
@@ -1398,7 +1398,8 @@ static int bdrv_fill_options(QDict **options, const char *filename,
  * or bdrv_abort_perm_update().
  */
 static int bdrv_check_perm(BlockDriverState *bs, uint64_t cumulative_perms,
-                           uint64_t cumulative_shared_perms, Error **errp)
+                           uint64_t cumulative_shared_perms,
+                           GSList *ignore_children, Error **errp)
 {
     BlockDriver *drv = bs->drv;
     BdrvChild *c;
@@ -1434,7 +1435,8 @@ static int bdrv_check_perm(BlockDriverState *bs, uint64_t cumulative_perms,
         drv->bdrv_child_perm(bs, c, c->role,
                              cumulative_perms, cumulative_shared_perms,
                              &cur_perm, &cur_shared);
-        ret = bdrv_child_check_perm(c, cur_perm, cur_shared, errp);
+        ret = bdrv_child_check_perm(c, cur_perm, cur_shared, ignore_children,
+                                    errp);
         if (ret < 0) {
             return ret;
         }
@@ -1554,15 +1556,15 @@ static char *bdrv_perm_names(uint64_t perm)
 
 /*
  * Checks whether a new reference to @bs can be added if the new user requires
- * @new_used_perm/@new_shared_perm as its permissions. If @ignore_child is set,
- * this old reference is ignored in the calculations; this allows checking
- * permission updates for an existing reference.
+ * @new_used_perm/@new_shared_perm as its permissions. If @ignore_children is
+ * set, the BdrvChild objects in this list are ignored in the calculations;
+ * this allows checking permission updates for an existing reference.
  *
  * Needs to be followed by a call to either bdrv_set_perm() or
  * bdrv_abort_perm_update(). */
 static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
                                   uint64_t new_shared_perm,
-                                  BdrvChild *ignore_child, Error **errp)
+                                  GSList *ignore_children, Error **errp)
 {
     BdrvChild *c;
     uint64_t cumulative_perms = new_used_perm;
@@ -1572,7 +1574,7 @@ static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
     assert(new_shared_perm & BLK_PERM_WRITE_UNCHANGED);
 
     QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c == ignore_child) {
+        if (g_slist_find(ignore_children, c)) {
             continue;
         }
 
@@ -1602,15 +1604,22 @@ static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
         cumulative_shared_perms &= c->shared_perm;
     }
 
-    return bdrv_check_perm(bs, cumulative_perms, cumulative_shared_perms, errp);
+    return bdrv_check_perm(bs, cumulative_perms, cumulative_shared_perms,
+                           ignore_children, errp);
 }
 
 /* Needs to be followed by a call to either bdrv_child_set_perm() or
  * bdrv_child_abort_perm_update(). */
 int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
-                          Error **errp)
+                          GSList *ignore_children, Error **errp)
 {
-    return bdrv_check_update_perm(c->bs, perm, shared, c, errp);
+    int ret;
+
+    ignore_children = g_slist_prepend(g_slist_copy(ignore_children), c);
+    ret = bdrv_check_update_perm(c->bs, perm, shared, ignore_children, errp);
+    g_slist_free(ignore_children);
+
+    return ret;
 }
 
 void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared)
@@ -1635,7 +1644,7 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
 {
     int ret;
 
-    ret = bdrv_child_check_perm(c, perm, shared, errp);
+    ret = bdrv_child_check_perm(c, perm, shared, NULL, errp);
     if (ret < 0) {
         bdrv_child_abort_perm_update(c);
         return ret;
@@ -1753,7 +1762,7 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs,
          * because we're just taking a parent away, so we're loosening
          * restrictions. */
         bdrv_get_cumulative_perm(old_bs, &perm, &shared_perm);
-        bdrv_check_perm(old_bs, perm, shared_perm, &error_abort);
+        bdrv_check_perm(old_bs, perm, shared_perm, NULL, &error_abort);
         bdrv_set_perm(old_bs, perm, shared_perm);
     }
 
@@ -1762,7 +1771,7 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs,
     if (new_bs) {
         bdrv_get_cumulative_perm(new_bs, &perm, &shared_perm);
         if (check_new_perm) {
-            bdrv_check_perm(new_bs, perm, shared_perm, &error_abort);
+            bdrv_check_perm(new_bs, perm, shared_perm, NULL, &error_abort);
         }
         bdrv_set_perm(new_bs, perm, shared_perm);
     }
diff --git a/include/block/block_int.h b/include/block/block_int.h
index a57c0bf..fc83f7f 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -890,7 +890,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
 void bdrv_root_unref_child(BdrvChild *child);
 
 int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
-                          Error **errp);
+                          GSList *ignore_children, Error **errp);
 void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared);
 void bdrv_child_abort_perm_update(BdrvChild *c);
 int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
-- 
1.8.3.1
