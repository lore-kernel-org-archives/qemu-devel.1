Received: from eggs.gnu.org ([2001:4830:134:3::10]:34368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6h-0003Bv-B2
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6g-0003XQ-Hp
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:50:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXB6g-0003VW-CC
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:50:58 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Jul 2017 15:50:38 -0300
Message-Id: <20170717185051.18740-3-ehabkost@redhat.com>
In-Reply-To: <20170717185051.18740-1-ehabkost@redhat.com>
References: <20170717185051.18740-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 02/15] tests: Test case for
 object_resolve_path*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

Test for partial path lookup using object_resolve_path*().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170707213052.13087-2-ehabkost@redhat.com>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/check-qom-proplist.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 8e432e9..f6e7823 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -568,6 +568,44 @@ static void test_dummy_delchild(void)
     object_unparent(OBJECT(dev));
 }
 
+static void test_qom_partial_path(void)
+{
+    Object *root  = object_get_objects_root();
+    Object *cont1 = container_get(root, "/cont1");
+    Object *obj1  = object_new(TYPE_DUMMY);
+    Object *obj2a = object_new(TYPE_DUMMY);
+    Object *obj2b = object_new(TYPE_DUMMY);
+    bool ambiguous;
+
+    /* Objects created:
+     * /cont1
+     * /cont1/obj1
+     * /cont1/obj2 (obj2a)
+     * /obj2 (obj2b)
+     */
+    object_property_add_child(cont1, "obj1", obj1, &error_abort);
+    object_unref(obj1);
+    object_property_add_child(cont1, "obj2", obj2a, &error_abort);
+    object_unref(obj2a);
+    object_property_add_child(root,  "obj2", obj2b, &error_abort);
+    object_unref(obj2b);
+
+    ambiguous = false;
+    g_assert(!object_resolve_path_type("", TYPE_DUMMY, &ambiguous));
+    g_assert(ambiguous);
+
+    ambiguous = false;
+    g_assert(!object_resolve_path("obj2", &ambiguous));
+    g_assert(ambiguous);
+
+    ambiguous = false;
+    g_assert(object_resolve_path("obj1", &ambiguous) == obj1);
+    g_assert(!ambiguous);
+
+    object_unparent(obj2b);
+    object_unparent(cont1);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -585,6 +623,7 @@ int main(int argc, char **argv)
     g_test_add_func("/qom/proplist/getenum", test_dummy_getenum);
     g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
     g_test_add_func("/qom/proplist/delchild", test_dummy_delchild);
+    g_test_add_func("/qom/resolve/partial", test_qom_partial_path);
 
     return g_test_run();
 }
-- 
2.9.4
