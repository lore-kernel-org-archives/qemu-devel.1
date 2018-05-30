Received: from eggs.gnu.org ([2001:4830:134:3::10]:41469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fNvN0-00068U-PV
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fNvMx-0005Qh-MI
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:18:06 -0400
Received: from [107.173.13.209] (port=51644 helo=ozlabs.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fNvMx-0005Qb-FR
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:18:03 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 30 May 2018 17:17:56 +1000
Message-Id: <20180530071757.9112-2-aik@ozlabs.ru>
In-Reply-To: <20180530071757.9112-1-aik@ozlabs.ru>
References: <20180530071757.9112-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v3 1/2] object: Handle objects with no
 parents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

At the moment object_get_canonical_path() crashes if the object or one
of its parents does not have a parent, for example, a KVM accelerator
object.

This adds a check for obj!=NULL in a loop to prevent the crash.
In order not to return a wrong path, this checks for currently resolved
partial path and does not add a leading slash to tell the reader that
the path is partial as the owner object is detached.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I have not tested the case with obj==NULL and path!=NULL as this is
for objects which have parents which are not attached to the root
and we do not have such objects in current QEMU afaict but I kept it
just in case.

---
Changes:
v3:
* do not check for obj->parent
* return NULL or incomplete path depending on the situation
---
 qom/object.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 0fc9720..05138ba 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1669,7 +1669,7 @@ gchar *object_get_canonical_path(Object *obj)
     Object *root = object_get_root();
     char *newpath, *path = NULL;
 
-    while (obj != root) {
+    while (obj && obj != root) {
         char *component = object_get_canonical_path_component(obj);
 
         if (path) {
@@ -1684,7 +1684,13 @@ gchar *object_get_canonical_path(Object *obj)
         obj = obj->parent;
     }
 
-    newpath = g_strdup_printf("/%s", path ? path : "");
+    if (obj && path) {
+        newpath = g_strdup_printf("/%s", path);
+    } else if (path) {
+        newpath = g_strdup(path);
+    } else {
+        newpath = NULL;
+    }
     g_free(path);
 
     return newpath;
-- 
2.11.0
