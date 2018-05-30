Received: from eggs.gnu.org ([2001:4830:134:3::10]:34351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fO3tA-0002O5-CJ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fO3t9-0002V9-Hq
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:23:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59864 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fO3t9-0002Uo-DG
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:23:51 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 30 May 2018 18:23:49 +0200
Message-Id: <20180530162349.31100-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] qom: support orphan objects in
 object_get_canonical_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru

Mostly a rewrite, in order to keep the loop simple.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 0fc972030e..4f30431ae3 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1669,25 +1669,28 @@ gchar *object_get_canonical_path(Object *obj)
     Object *root = object_get_root();
     char *newpath, *path = NULL;
 
-    while (obj != root) {
+    if (obj == root) {
+        return g_strdup("/");
+    }
+
+    do {
         char *component = object_get_canonical_path_component(obj);
 
-        if (path) {
-            newpath = g_strdup_printf("%s/%s", component, path);
-            g_free(component);
+        if (!component) {
+            /* A canonical path must be complete, so discard what was
+             * collected so far.
+             */
             g_free(path);
-            path = newpath;
-        } else {
-            path = component;
+            return NULL;
         }
 
-        obj = obj->parent;
-    }
-
-    newpath = g_strdup_printf("/%s", path ? path : "");
-    g_free(path);
+        newpath = g_strdup_printf("/%s%s", component, path ? path : "");
+        g_free(path);
+        g_free(component);
+        path = newpath;
+    } while ((obj = obj->parent) != root);
 
-    return newpath;
+    return path;
 }
 
 Object *object_resolve_path_component(Object *parent, const gchar *part)
-- 
2.17.0
