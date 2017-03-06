Received: from eggs.gnu.org ([2001:4830:134:3::10]:54620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvPA-0002as-GR
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvP9-0001CT-GE
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:22:36 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  6 Mar 2017 17:21:58 +0100
Message-Id: <1488817322-11397-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 06/10] block: Factor out should_update_child()
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/block.c b/block.c
index f293ccb..6dc02b8 100644
--- a/block.c
+++ b/block.c
@@ -2886,28 +2886,40 @@ void bdrv_close_all(void)
     assert(QTAILQ_EMPTY(&all_bdrv_states));
 }
 
+static bool should_update_child(BdrvChild *c, BlockDriverState *to)
+{
+    BdrvChild *to_c;
+
+    if (c->role->stay_at_node) {
+        return false;
+    }
+
+    if (c->role == &child_backing) {
+        /* If @from is a backing file of @to, ignore the child to avoid
+         * creating a loop. We only want to change the pointer of other
+         * parents. */
+        QLIST_FOREACH(to_c, &to->children, next) {
+            if (to_c == c) {
+                break;
+            }
+        }
+        if (to_c) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static void change_parent_backing_link(BlockDriverState *from,
                                        BlockDriverState *to)
 {
-    BdrvChild *c, *next, *to_c;
+    BdrvChild *c, *next;
 
     QLIST_FOREACH_SAFE(c, &from->parents, next_parent, next) {
-        if (c->role->stay_at_node) {
+        if (!should_update_child(c, to)) {
             continue;
         }
-        if (c->role == &child_backing) {
-            /* If @from is a backing file of @to, ignore the child to avoid
-             * creating a loop. We only want to change the pointer of other
-             * parents. */
-            QLIST_FOREACH(to_c, &to->children, next) {
-                if (to_c == c) {
-                    break;
-                }
-            }
-            if (to_c) {
-                continue;
-            }
-        }
 
         bdrv_ref(to);
         /* FIXME Are we sure that bdrv_replace_child() can't run into
-- 
1.8.3.1
