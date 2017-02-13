Received: from eggs.gnu.org ([2001:4830:134:3::10]:59540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKM9-0003UH-Fd
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKM8-0006E1-5P
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:05 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:45 +0100
Message-Id: <1487006583-24350-24-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 23/41] block: Include details on permission
 errors in message
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

Instead of just telling that there was some conflict, we can be specific
and tell which permissions were in conflict and which way the conflict
is.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/block.c b/block.c
index 2116542..d743f50 100644
--- a/block.c
+++ b/block.c
@@ -1381,6 +1381,43 @@ static void bdrv_update_perm(BlockDriverState *bs)
     bdrv_set_perm(bs, cumulative_perms, cumulative_shared_perms);
 }
 
+static char *bdrv_child_link_name(BdrvChild *c)
+{
+    if (c->role->get_link_name) {
+        return c->role->get_link_name(c);
+    }
+
+    return g_strdup("another user");
+}
+
+static char *bdrv_perm_names(uint64_t perm)
+{
+    struct perm_name {
+        uint64_t perm;
+        const char *name;
+    } permissions[] = {
+        { BLK_PERM_CONSISTENT_READ, "consistent read" },
+        { BLK_PERM_WRITE,           "write" },
+        { BLK_PERM_WRITE_UNCHANGED, "write unchanged" },
+        { BLK_PERM_RESIZE,          "resize" },
+        { BLK_PERM_GRAPH_MOD,       "change children" },
+        { 0, NULL }
+    };
+
+    char *result = g_strdup("");
+    struct perm_name *p;
+
+    for (p = permissions; p->name; p++) {
+        if (perm & p->perm) {
+            char *old = result;
+            result = g_strdup_printf("%s%s%s", old, *old ? ", " : "", p->name);
+            g_free(old);
+        }
+    }
+
+    return result;
+}
+
 static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
                                   uint64_t new_shared_perm,
                                   BdrvChild *ignore_child, Error **errp)
@@ -1397,17 +1434,24 @@ static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
             continue;
         }
 
-        if ((new_used_perm & c->shared_perm) != new_used_perm ||
-            (c->perm & new_shared_perm) != c->perm)
-        {
-            const char *user = NULL;
-            if (c->role->get_name) {
-                user = c->role->get_name(c);
-                if (user && !*user) {
-                    user = NULL;
-                }
-            }
-            error_setg(errp, "Conflicts with %s", user ?: "another operation");
+        if ((new_used_perm & c->shared_perm) != new_used_perm) {
+            char *link = bdrv_child_link_name(c);
+            char *perm_names = bdrv_perm_names(new_used_perm & ~c->shared_perm);
+            error_setg(errp, "Conflicts with %s, which does not allow '%s' "
+                             "on %s",
+                       link, perm_names, bdrv_get_node_name(c->bs));
+            g_free(link);
+            g_free(perm_names);
+            return -EPERM;
+        }
+
+        if ((c->perm & new_shared_perm) != c->perm) {
+            char *link = bdrv_child_link_name(c);
+            char *perm_names = bdrv_perm_names(c->perm & ~new_shared_perm);
+            error_setg(errp, "Conflicts with %s, which uses '%s' on %s",
+                       link, perm_names, bdrv_get_node_name(c->bs));
+            g_free(link);
+            g_free(perm_names);
             return -EPERM;
         }
 
-- 
1.8.3.1
