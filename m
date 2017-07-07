Received: from eggs.gnu.org ([2001:4830:134:3::10]:44027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTaq6-0007uH-Tw
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTaq5-0000eC-Q2
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:31:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dTaq5-0000di-H2
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:31:01 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  7 Jul 2017 18:30:52 -0300
Message-Id: <20170707213052.13087-3-ehabkost@redhat.com>
In-Reply-To: <20170707213052.13087-1-ehabkost@redhat.com>
References: <20170707213052.13087-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qom: Fix ambiguous path detection when
 ambiguous=NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

object_resolve_path*() ambiguous path detection breaks when
ambiguous==NULL and the object tree have 3 objects of the same type and
only 2 of them are under the same parent.  e.g.:

 /container/obj1 (TYPE_FOO)
 /container/obj2 (TYPE_FOO)
 /obj2 (TYPE_FOO)

With the above tree, object_resolve_path_type("", TYPE_FOO, NULL) will
incorrectly return /obj2, because the search inside "/container" will
return NULL, and the match at "/obj2" won't be detected as ambiguous.

Fix that by always calling object_resolve_partial_path() with a non-NULL
ambiguous parameter.

Test case included.

Reported-by: Igor Mammedov <imammedo@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qom/object.c               | 17 ++++++++---------
 tests/check-qom-proplist.c |  3 +++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 5f6fdfa..0cdddcb 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1712,15 +1712,13 @@ static Object *object_resolve_partial_path(Object *parent,
                                             typename, ambiguous);
         if (found) {
             if (obj) {
-                if (ambiguous) {
-                    *ambiguous = true;
-                }
+                *ambiguous = true;
                 return NULL;
             }
             obj = found;
         }
 
-        if (ambiguous && *ambiguous) {
+        if (*ambiguous) {
             return NULL;
         }
     }
@@ -1729,7 +1727,7 @@ static Object *object_resolve_partial_path(Object *parent,
 }
 
 Object *object_resolve_path_type(const char *path, const char *typename,
-                                 bool *ambiguous)
+                                 bool *ambiguousp)
 {
     Object *obj;
     gchar **parts;
@@ -1738,11 +1736,12 @@ Object *object_resolve_path_type(const char *path, const char *typename,
     assert(parts);
 
     if (parts[0] == NULL || strcmp(parts[0], "") != 0) {
-        if (ambiguous) {
-            *ambiguous = false;
-        }
+        bool ambiguous = false;
         obj = object_resolve_partial_path(object_get_root(), parts,
-                                          typename, ambiguous);
+                                          typename, &ambiguous);
+        if (ambiguousp) {
+            *ambiguousp = ambiguous;
+        }
     } else {
         obj = object_resolve_abs_path(object_get_root(), parts, typename, 1);
     }
diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index abafbd7..381532c 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -593,14 +593,17 @@ static void test_qom_partial_path(void)
     ambiguous = false;
     g_assert(!object_resolve_path_type("", TYPE_DUMMY, &ambiguous));
     g_assert(ambiguous);
+    g_assert(!object_resolve_path_type("", TYPE_DUMMY, NULL));
 
     ambiguous = false;
     g_assert(!object_resolve_path("obj2", &ambiguous));
     g_assert(ambiguous);
+    g_assert(!object_resolve_path("obj2", NULL));
 
     ambiguous = false;
     g_assert(object_resolve_path("obj1", &ambiguous) == obj1);
     g_assert(!ambiguous);
+    g_assert(object_resolve_path("obj1", NULL) == obj1);
 
     object_unparent(obj1);
     object_unparent(obj2a);
-- 
2.9.4
