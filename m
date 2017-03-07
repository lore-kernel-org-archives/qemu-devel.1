Received: from eggs.gnu.org ([2001:4830:134:3::10]:42554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEm-0002Fp-Ba
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEh-0002kk-FH
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:20 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:33 +0100
Message-Id: <1488901251-16214-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/27] block: Handle permission errors in
 change_parent_backing_link()
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

Instead of just trying to change parents by parent over to reference @to
instead of @from, and abort()ing whenever the permissions don't allow
this, do proper permission checking beforehand and pass any error to the
callers.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 50 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index a7b09d3..a310132 100644
--- a/block.c
+++ b/block.c
@@ -2933,21 +2933,53 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
 }
 
 static void change_parent_backing_link(BlockDriverState *from,
-                                       BlockDriverState *to)
+                                       BlockDriverState *to, Error **errp)
 {
     BdrvChild *c, *next;
+    GSList *list = NULL, *p;
+    uint64_t old_perm, old_shared;
+    uint64_t perm = 0, shared = BLK_PERM_ALL;
+    int ret;
+
+    /* Make sure that @from doesn't go away until we have successfully attached
+     * all of its parents to @to. */
+    bdrv_ref(from);
 
+    /* Put all parents into @list and calculate their cumulative permissions */
     QLIST_FOREACH_SAFE(c, &from->parents, next_parent, next) {
         if (!should_update_child(c, to)) {
             continue;
         }
+        list = g_slist_prepend(list, c);
+        perm |= c->perm;
+        shared &= c->shared_perm;
+    }
+
+    /* Check whether the required permissions can be granted on @to, ignoring
+     * all BdrvChild in @list so that they can't block themselves. */
+    ret = bdrv_check_update_perm(to, perm, shared, list, errp);
+    if (ret < 0) {
+        bdrv_abort_perm_update(to);
+        goto out;
+    }
+
+    /* Now actually perform the change. We performed the permission check for
+     * all elements of @list at once, so set the permissions all at once at the
+     * very end. */
+    for (p = list; p != NULL; p = p->next) {
+        c = p->data;
 
         bdrv_ref(to);
-        /* FIXME Are we sure that bdrv_replace_child() can't run into
-         * &error_abort because of permissions? */
-        bdrv_replace_child(c, to, true);
+        bdrv_replace_child_noperm(c, to);
         bdrv_unref(from);
     }
+
+    bdrv_get_cumulative_perm(to, &old_perm, &old_shared);
+    bdrv_set_perm(to, old_perm | perm, old_shared | shared);
+
+out:
+    g_slist_free(list);
+    bdrv_unref(from);
 }
 
 /*
@@ -2980,7 +3012,12 @@ void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
         goto out;
     }
 
-    change_parent_backing_link(bs_top, bs_new);
+    change_parent_backing_link(bs_top, bs_new, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        bdrv_set_backing_hd(bs_new, NULL, &error_abort);
+        goto out;
+    }
 
     /* bs_new is now referenced by its new parents, we don't need the
      * additional reference any more. */
@@ -2995,7 +3032,8 @@ void bdrv_replace_in_backing_chain(BlockDriverState *old, BlockDriverState *new)
 
     bdrv_ref(old);
 
-    change_parent_backing_link(old, new);
+    /* FIXME Proper error handling */
+    change_parent_backing_link(old, new, &error_abort);
 
     bdrv_unref(old);
 }
-- 
1.8.3.1
