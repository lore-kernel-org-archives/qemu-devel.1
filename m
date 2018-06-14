Received: from eggs.gnu.org ([2001:4830:134:3::10]:53446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXhx-0001aa-Dy
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXhv-0001ay-NE
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:14:57 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Jun 2018 21:14:39 +0200
Message-Id: <20180614191443.14361-15-armbru@redhat.com>
In-Reply-To: <20180614191443.14361-1-armbru@redhat.com>
References: <20180614191443.14361-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/18] check-block-qdict: Rename
 qdict_flatten()'s variables for clarity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/check-block-qdict.c | 57 ++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/tests/check-block-qdict.c b/tests/check-block-qdict.c
index 5b9f4d506e..29f58a2d3d 100644
--- a/tests/check-block-qdict.c
+++ b/tests/check-block-qdict.c
@@ -37,11 +37,11 @@ static void qdict_defaults_test(void)
 
 static void qdict_flatten_test(void)
 {
-    QList *list1 = qlist_new();
-    QList *list2 = qlist_new();
-    QDict *dict1 = qdict_new();
-    QDict *dict2 = qdict_new();
-    QDict *dict3 = qdict_new();
+    QList *e_1 = qlist_new();
+    QList *e = qlist_new();
+    QDict *e_1_2 = qdict_new();
+    QDict *f = qdict_new();
+    QDict *root = qdict_new();
 
     /*
      * Test the flattening of
@@ -79,35 +79,36 @@ static void qdict_flatten_test(void)
      * }
      */
 
-    qdict_put_int(dict1, "a", 0);
-    qdict_put_int(dict1, "b", 1);
+    qdict_put_int(e_1_2, "a", 0);
+    qdict_put_int(e_1_2, "b", 1);
 
-    qlist_append_int(list1, 23);
-    qlist_append_int(list1, 66);
-    qlist_append(list1, dict1);
-    qlist_append_int(list2, 42);
-    qlist_append(list2, list1);
+    qlist_append_int(e_1, 23);
+    qlist_append_int(e_1, 66);
+    qlist_append(e_1, e_1_2);
+    qlist_append_int(e, 42);
+    qlist_append(e, e_1);
 
-    qdict_put_int(dict2, "c", 2);
-    qdict_put_int(dict2, "d", 3);
-    qdict_put(dict3, "e", list2);
-    qdict_put(dict3, "f", dict2);
-    qdict_put_int(dict3, "g", 4);
+    qdict_put_int(f, "c", 2);
+    qdict_put_int(f, "d", 3);
 
-    qdict_flatten(dict3);
+    qdict_put(root, "e", e);
+    qdict_put(root, "f", f);
+    qdict_put_int(root, "g", 4);
 
-    g_assert(qdict_get_int(dict3, "e.0") == 42);
-    g_assert(qdict_get_int(dict3, "e.1.0") == 23);
-    g_assert(qdict_get_int(dict3, "e.1.1") == 66);
-    g_assert(qdict_get_int(dict3, "e.1.2.a") == 0);
-    g_assert(qdict_get_int(dict3, "e.1.2.b") == 1);
-    g_assert(qdict_get_int(dict3, "f.c") == 2);
-    g_assert(qdict_get_int(dict3, "f.d") == 3);
-    g_assert(qdict_get_int(dict3, "g") == 4);
+    qdict_flatten(root);
 
-    g_assert(qdict_size(dict3) == 8);
+    g_assert(qdict_get_int(root, "e.0") == 42);
+    g_assert(qdict_get_int(root, "e.1.0") == 23);
+    g_assert(qdict_get_int(root, "e.1.1") == 66);
+    g_assert(qdict_get_int(root, "e.1.2.a") == 0);
+    g_assert(qdict_get_int(root, "e.1.2.b") == 1);
+    g_assert(qdict_get_int(root, "f.c") == 2);
+    g_assert(qdict_get_int(root, "f.d") == 3);
+    g_assert(qdict_get_int(root, "g") == 4);
 
-    qobject_unref(dict3);
+    g_assert(qdict_size(root) == 8);
+
+    qobject_unref(root);
 }
 
 static void qdict_array_split_test(void)
-- 
2.17.1
