Received: from eggs.gnu.org ([2001:4830:134:3::10]:53222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gC5OD-0008J9-UW
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gC5OA-00053V-NR
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 15 Oct 2018 19:06:26 +0300
Message-Id: <20181015160633.63130-5-vsementsov@virtuozzo.com>
In-Reply-To: <20181015160633.63130-1-vsementsov@virtuozzo.com>
References: <20181015160633.63130-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 04/11] block: improve should_update_child
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com

As it already said in the comment, we don't want to create loops in
parent->child relations. So, when we try to append @to to @c, we should
check that @c is not in @to children subtree, and we should check it
recursively, not only the first level. The patch provides BFS-based
search, to check the relations.

This is needed for further fleecing-hook filter usage: we need to
append it to source, when the hook is already a parent of target, and
source may be in a backing chain of target (fleecing-scheme). So, on
appending, the hook should not became a child (direct or through
children subtree) of the target.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index c298ca6a19..7f605b0bf0 100644
--- a/block.c
+++ b/block.c
@@ -3432,7 +3432,7 @@ void bdrv_close_all(void)
 
 static bool should_update_child(BdrvChild *c, BlockDriverState *to)
 {
-    BdrvChild *to_c;
+    GList *queue = NULL, *pos;
 
     if (c->role->stay_at_node) {
         return false;
@@ -3468,13 +3468,35 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
      * if A is a child of B, that means we cannot replace A by B there
      * because that would create a loop.  Silently detaching A from B
      * is also not really an option.  So overall just leaving A in
-     * place there is the most sensible choice. */
-    QLIST_FOREACH(to_c, &to->children, next) {
-        if (to_c == c) {
-            return false;
+     * place there is the most sensible choice.
+     *
+     * upd: If the child @c belongs to the @to's children, or children of it's
+     * children and so on - this would create a loop to. To prevent it let's do
+     * a BFS search on @to children subtree.
+     */
+
+    pos = queue = g_list_append(queue, to);
+    while (pos) {
+        BlockDriverState *v = pos->data;
+        BdrvChild *c2;
+
+        QLIST_FOREACH(c2, &v->children, next) {
+            if (c2 == c) {
+                g_list_free(queue);
+                return false;
+            }
+
+            if (g_list_find(queue, c2->bs)) {
+                continue;
+            }
+
+            queue = g_list_append(queue, c2->bs);
         }
+
+        pos = pos->next;
     }
 
+    g_list_free(queue);
     return true;
 }
 
-- 
2.18.0
