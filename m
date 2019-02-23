Received: from eggs.gnu.org ([209.51.188.92]:54718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gxcr1-0005re-8i
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 14:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gxcqx-00021v-Ob
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 14:20:53 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 23 Feb 2019 22:20:39 +0300
Message-Id: <20190223192041.289782-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190223192041.289782-1-vsementsov@virtuozzo.com>
References: <20190223192041.289782-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v6 1/3] block: improve should_update_child
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com

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

v6: rewrite using GHashTable and GQueue for efficient BFS.

 block.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 4ad0e90d7e..d7c2ff655c 100644
--- a/block.c
+++ b/block.c
@@ -3542,7 +3542,9 @@ void bdrv_close_all(void)
 
 static bool should_update_child(BdrvChild *c, BlockDriverState *to)
 {
-    BdrvChild *to_c;
+    GQueue *queue;
+    GHashTable *found;
+    bool ret;
 
     if (c->role->stay_at_node) {
         return false;
@@ -3578,14 +3580,43 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
      * if A is a child of B, that means we cannot replace A by B there
      * because that would create a loop.  Silently detaching A from B
      * is also not really an option.  So overall just leaving A in
-     * place there is the most sensible choice. */
-    QLIST_FOREACH(to_c, &to->children, next) {
-        if (to_c == c) {
-            return false;
+     * place there is the most sensible choice.
+     *
+     * We would also create a loop in any cases where @c is only
+     * indirectly referenced by @to. Prevent this by returning false
+     * if @c is found (by breadth-first search) anywhere in the whole
+     * subtree of @to.
+     */
+
+    ret = true;
+    found = g_hash_table_new(NULL, NULL);
+    g_hash_table_add(found, to);
+    queue = g_queue_new();
+    g_queue_push_tail(queue, to);
+
+    while (!g_queue_is_empty(queue)) {
+        BlockDriverState *v = g_queue_pop_head(queue);
+        BdrvChild *c2;
+
+        QLIST_FOREACH(c2, &v->children, next) {
+            if (c2 == c) {
+                ret = false;
+                break;
+            }
+
+            if (g_hash_table_contains(found, c2->bs)) {
+                continue;
+            }
+
+            g_queue_push_tail(queue, c2->bs);
+            g_hash_table_add(found, c2->bs);
         }
     }
 
-    return true;
+    g_queue_free(queue);
+    g_hash_table_destroy(found);
+
+    return ret;
 }
 
 void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
-- 
2.18.0
