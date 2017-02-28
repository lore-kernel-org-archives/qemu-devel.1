Received: from eggs.gnu.org ([2001:4830:134:3::10]:43591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cihJI-0004UE-QK
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cihJH-0004FF-Gq
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:55:20 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 13:54:07 +0100
Message-Id: <1488286469-9381-23-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v3 22/44] block: Include details on permission
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
 block.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 11 deletions(-)

diff --git a/block.c b/block.c
index e03cc5d..f72a67f 100644
--- a/block.c
+++ b/block.c
@@ -1462,6 +1462,43 @@ static void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
     *shared_perm = cumulative_shared_perms;
 }
 
+static char *bdrv_child_user_desc(BdrvChild *c)
+{
+    if (c->role->get_parent_desc) {
+        return c->role->get_parent_desc(c);
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
 /*
  * Checks whether a new reference to @bs can be added if the new user requires
  * @new_used_perm/@new_shared_perm as its permissions. If @ignore_child is set,
@@ -1486,17 +1523,25 @@ static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
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
+            char *user = bdrv_child_user_desc(c);
+            char *perm_names = bdrv_perm_names(new_used_perm & ~c->shared_perm);
+            error_setg(errp, "Conflicts with use by %s as '%s', which does not "
+                             "allow '%s' on %s",
+                       user, c->name, perm_names, bdrv_get_node_name(c->bs));
+            g_free(user);
+            g_free(perm_names);
+            return -EPERM;
+        }
+
+        if ((c->perm & new_shared_perm) != c->perm) {
+            char *user = bdrv_child_user_desc(c);
+            char *perm_names = bdrv_perm_names(c->perm & ~new_shared_perm);
+            error_setg(errp, "Conflicts with use by %s as '%s', which uses "
+                             "'%s' on %s",
+                       user, c->name, perm_names, bdrv_get_node_name(c->bs));
+            g_free(user);
+            g_free(perm_names);
             return -EPERM;
         }
 
-- 
1.8.3.1
