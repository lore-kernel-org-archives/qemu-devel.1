Received: from eggs.gnu.org ([2001:4830:134:3::10]:37276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dsnZq-00027u-9Q
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dsnZo-0004Jo-Nu
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:10:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Sep 2017 12:10:05 +0200
Message-Id: <20170915101008.16646-4-kwolf@redhat.com>
In-Reply-To: <20170915101008.16646-1-kwolf@redhat.com>
References: <20170915101008.16646-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] block: Add reopen queue to
 bdrv_check_perm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

In the context of bdrv_reopen(), we'll have to look at the state of the
graph as it will be after the reopen. This interface addition is in
preparation for the change.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/block.c b/block.c
index c7724c85e3..0b499fda4c 100644
--- a/block.c
+++ b/block.c
@@ -1531,7 +1531,8 @@ static int bdrv_fill_options(QDict **options, const char *filename,
     return 0;
 }
 
-static int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
+static int bdrv_child_check_perm(BdrvChild *c, BlockReopenQueue *q,
+                                 uint64_t perm, uint64_t shared,
                                  GSList *ignore_children, Error **errp);
 static void bdrv_child_abort_perm_update(BdrvChild *c);
 static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared);
@@ -1562,7 +1563,8 @@ static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
  * A call to this function must always be followed by a call to bdrv_set_perm()
  * or bdrv_abort_perm_update().
  */
-static int bdrv_check_perm(BlockDriverState *bs, uint64_t cumulative_perms,
+static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
+                           uint64_t cumulative_perms,
                            uint64_t cumulative_shared_perms,
                            GSList *ignore_children, Error **errp)
 {
@@ -1597,11 +1599,11 @@ static int bdrv_check_perm(BlockDriverState *bs, uint64_t cumulative_perms,
     /* Check all children */
     QLIST_FOREACH(c, &bs->children, next) {
         uint64_t cur_perm, cur_shared;
-        bdrv_child_perm(bs, c->bs, c, c->role, NULL,
+        bdrv_child_perm(bs, c->bs, c, c->role, q,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
-        ret = bdrv_child_check_perm(c, cur_perm, cur_shared, ignore_children,
-                                    errp);
+        ret = bdrv_child_check_perm(c, q, cur_perm, cur_shared,
+                                    ignore_children, errp);
         if (ret < 0) {
             return ret;
         }
@@ -1727,7 +1729,8 @@ char *bdrv_perm_names(uint64_t perm)
  *
  * Needs to be followed by a call to either bdrv_set_perm() or
  * bdrv_abort_perm_update(). */
-static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
+static int bdrv_check_update_perm(BlockDriverState *bs, BlockReopenQueue *q,
+                                  uint64_t new_used_perm,
                                   uint64_t new_shared_perm,
                                   GSList *ignore_children, Error **errp)
 {
@@ -1769,19 +1772,20 @@ static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
         cumulative_shared_perms &= c->shared_perm;
     }
 
-    return bdrv_check_perm(bs, cumulative_perms, cumulative_shared_perms,
+    return bdrv_check_perm(bs, q, cumulative_perms, cumulative_shared_perms,
                            ignore_children, errp);
 }
 
 /* Needs to be followed by a call to either bdrv_child_set_perm() or
  * bdrv_child_abort_perm_update(). */
-static int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
+static int bdrv_child_check_perm(BdrvChild *c, BlockReopenQueue *q,
+                                 uint64_t perm, uint64_t shared,
                                  GSList *ignore_children, Error **errp)
 {
     int ret;
 
     ignore_children = g_slist_prepend(g_slist_copy(ignore_children), c);
-    ret = bdrv_check_update_perm(c->bs, perm, shared, ignore_children, errp);
+    ret = bdrv_check_update_perm(c->bs, q, perm, shared, ignore_children, errp);
     g_slist_free(ignore_children);
 
     return ret;
@@ -1809,7 +1813,7 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
 {
     int ret;
 
-    ret = bdrv_child_check_perm(c, perm, shared, NULL, errp);
+    ret = bdrv_child_check_perm(c, NULL, perm, shared, NULL, errp);
     if (ret < 0) {
         bdrv_child_abort_perm_update(c);
         return ret;
@@ -1950,7 +1954,7 @@ static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
          * because we're just taking a parent away, so we're loosening
          * restrictions. */
         bdrv_get_cumulative_perm(old_bs, &perm, &shared_perm);
-        bdrv_check_perm(old_bs, perm, shared_perm, NULL, &error_abort);
+        bdrv_check_perm(old_bs, NULL, perm, shared_perm, NULL, &error_abort);
         bdrv_set_perm(old_bs, perm, shared_perm);
     }
 
@@ -1969,7 +1973,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
     BdrvChild *child;
     int ret;
 
-    ret = bdrv_check_update_perm(child_bs, perm, shared_perm, NULL, errp);
+    ret = bdrv_check_update_perm(child_bs, NULL, perm, shared_perm, NULL, errp);
     if (ret < 0) {
         bdrv_abort_perm_update(child_bs);
         return NULL;
@@ -3184,7 +3188,7 @@ void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
 
     /* Check whether the required permissions can be granted on @to, ignoring
      * all BdrvChild in @list so that they can't block themselves. */
-    ret = bdrv_check_update_perm(to, perm, shared, list, errp);
+    ret = bdrv_check_update_perm(to, NULL, perm, shared, list, errp);
     if (ret < 0) {
         bdrv_abort_perm_update(to);
         goto out;
@@ -4054,7 +4058,7 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
 
     /* Update permissions, they may differ for inactive nodes */
     bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-    ret = bdrv_check_perm(bs, perm, shared_perm, NULL, &local_err);
+    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, &local_err);
     if (ret < 0) {
         bs->open_flags |= BDRV_O_INACTIVE;
         error_propagate(errp, local_err);
@@ -4121,7 +4125,7 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
 
         /* Update permissions, they may differ for inactive nodes */
         bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-        bdrv_check_perm(bs, perm, shared_perm, NULL, &error_abort);
+        bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, &error_abort);
         bdrv_set_perm(bs, perm, shared_perm);
     }
 
-- 
2.13.5
