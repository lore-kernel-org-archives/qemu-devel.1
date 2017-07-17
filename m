Received: from eggs.gnu.org ([2001:4830:134:3::10]:34419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6m-0003G2-J8
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6l-0003ce-EF
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXB6l-0003bb-52
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:03 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Jul 2017 15:50:40 -0300
Message-Id: <20170717185051.18740-5-ehabkost@redhat.com>
In-Reply-To: <20170717185051.18740-1-ehabkost@redhat.com>
References: <20170717185051.18740-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 04/15] test-qdev-global-props: Test global
 property ordering
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

Test case to detect the bug fixed by commit
"qdev: fix the order compat and global properties are applied".

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170711004303.3902-3-ehabkost@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/test-qdev-global-props.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.c
index b25fe89..d81b086 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -33,6 +33,8 @@
 #define STATIC_TYPE(obj) \
     OBJECT_CHECK(MyType, (obj), TYPE_STATIC_PROPS)
 
+#define TYPE_SUBCLASS "static_prop_subtype"
+
 #define PROP_DEFAULT 100
 
 typedef struct MyType {
@@ -63,6 +65,11 @@ static const TypeInfo static_prop_type = {
     .class_init = static_prop_class_init,
 };
 
+static const TypeInfo subclass_type = {
+    .name = TYPE_SUBCLASS,
+    .parent = TYPE_STATIC_PROPS,
+};
+
 /* Test simple static property setting to default value */
 static void test_static_prop_subprocess(void)
 {
@@ -279,12 +286,35 @@ static void test_dynamic_globalprop_nouser(void)
     g_test_trap_assert_stdout("");
 }
 
+/* Test if global props affecting subclasses are applied in the right order */
+static void test_subclass_global_props(void)
+{
+    MyType *mt;
+    /* Global properties must be applied in the order they were registered */
+    static GlobalProperty props[] = {
+        { TYPE_STATIC_PROPS, "prop1", "101" },
+        { TYPE_SUBCLASS,     "prop1", "102" },
+        { TYPE_SUBCLASS,     "prop2", "103" },
+        { TYPE_STATIC_PROPS, "prop2", "104" },
+        {}
+    };
+
+    qdev_prop_register_global_list(props);
+
+    mt = STATIC_TYPE(object_new(TYPE_SUBCLASS));
+    qdev_init_nofail(DEVICE(mt));
+
+    g_assert_cmpuint(mt->prop1, ==, 102);
+    g_assert_cmpuint(mt->prop2, ==, 104);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
     module_call_init(MODULE_INIT_QOM);
     type_register_static(&static_prop_type);
+    type_register_static(&subclass_type);
     type_register_static(&dynamic_prop_type);
     type_register_static(&hotplug_type);
     type_register_static(&nohotplug_type);
@@ -310,6 +340,9 @@ int main(int argc, char **argv)
     g_test_add_func("/qdev/properties/dynamic/global/nouser",
                     test_dynamic_globalprop_nouser);
 
+    g_test_add_func("/qdev/properties/global/subclass",
+                    test_subclass_global_props);
+
     g_test_run();
 
     return 0;
-- 
2.9.4
