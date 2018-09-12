Received: from eggs.gnu.org ([2001:4830:134:3::10]:33203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g04h9-0007pd-LM
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g04h6-00004r-ER
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:56:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54516 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g04h5-0008W2-Vl
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:56:32 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 12 Sep 2018 16:55:29 +0400
Message-Id: <20180912125531.32131-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180912125531.32131-1-marcandre.lureau@redhat.com>
References: <20180912125531.32131-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 7/9] tests: add user-creatable test to
 test-qdev-global-props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a TYPE_USER_CREATABLE object global property check.

Rename the test, since it is no longer QDev-specific.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ...dev-global-props.c =3D> test-global-props.c} | 128 ++++++++++++++++--
 tests/Makefile.include                        |   4 +-
 2 files changed, 117 insertions(+), 15 deletions(-)
 rename tests/{test-qdev-global-props.c =3D> test-global-props.c} (74%)

diff --git a/tests/test-qdev-global-props.c b/tests/test-global-props.c
similarity index 74%
rename from tests/test-qdev-global-props.c
rename to tests/test-global-props.c
index 9dffdf336d..1c725245bc 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-global-props.c
@@ -27,7 +27,100 @@
 #include "hw/qdev.h"
 #include "qom/object.h"
 #include "qapi/visitor.h"
+#include "qom/object_interfaces.h"
=20
+#define TYPE_DUMMY "qemu-dummy"
+
+typedef struct DummyObject DummyObject;
+typedef struct DummyObjectClass DummyObjectClass;
+
+#define DUMMY_OBJECT(obj)                           \
+    OBJECT_CHECK(DummyObject, (obj), TYPE_DUMMY)
+
+struct DummyObject {
+    Object parent_obj;
+
+    char *sv;
+};
+
+struct DummyObjectClass {
+    ObjectClass parent_class;
+};
+
+static void dummy_set_sv(Object *obj,
+                         const char *value,
+                         Error **errp)
+{
+    DummyObject *dobj =3D DUMMY_OBJECT(obj);
+
+    g_free(dobj->sv);
+    dobj->sv =3D g_strdup(value);
+}
+
+static char *dummy_get_sv(Object *obj,
+                          Error **errp)
+{
+    DummyObject *dobj =3D DUMMY_OBJECT(obj);
+
+    return g_strdup(dobj->sv);
+}
+
+
+
+static void dummy_class_init(ObjectClass *cls, void *data)
+{
+    object_class_property_add_str(cls, "sv",
+                                  dummy_get_sv,
+                                  dummy_set_sv,
+                                  NULL);
+}
+
+
+static void dummy_finalize(Object *obj)
+{
+    DummyObject *dobj =3D DUMMY_OBJECT(obj);
+
+    g_free(dobj->sv);
+}
+
+
+static const TypeInfo dummy_info =3D {
+    .name          =3D TYPE_DUMMY,
+    .parent        =3D TYPE_OBJECT,
+    .instance_size =3D sizeof(DummyObject),
+    .instance_finalize =3D dummy_finalize,
+    .class_size =3D sizeof(DummyObjectClass),
+    .class_init =3D dummy_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void test_global_props_uc_subprocess(void)
+{
+    DummyObject *d;
+    static GlobalProperty gp =3D {
+        TYPE_DUMMY, "sv", "foobar",
+    };
+
+    d =3D DUMMY_OBJECT(object_new(TYPE_DUMMY));
+    g_assert_null(d->sv);
+    object_unref(OBJECT(d));
+
+    object_property_register_global(&gp);
+    d =3D DUMMY_OBJECT(object_new(TYPE_DUMMY));
+    g_assert_cmpstr(d->sv, =3D=3D, "foobar");
+    object_unref(OBJECT(d));
+}
+
+static void test_global_props_uc(void)
+{
+    g_test_trap_subprocess("/global-props/usercreatable/subprocess", 0, =
0);
+    g_test_trap_assert_passed();
+    g_test_trap_assert_stderr("");
+    g_test_trap_assert_stdout("");
+}
=20
 #define TYPE_STATIC_PROPS "static_prop_type"
 #define STATIC_TYPE(obj) \
@@ -83,7 +176,8 @@ static void test_static_prop_subprocess(void)
=20
 static void test_static_prop(void)
 {
-    g_test_trap_subprocess("/qdev/properties/static/default/subprocess",=
 0, 0);
+    g_test_trap_subprocess("/global-props/qdev/static/default/subprocess=
",
+                           0, 0);
     g_test_trap_assert_passed();
     g_test_trap_assert_stderr("");
     g_test_trap_assert_stdout("");
@@ -119,7 +213,7 @@ static void test_static_globalprop_subprocess(void)
=20
 static void test_static_globalprop(void)
 {
-    g_test_trap_subprocess("/qdev/properties/static/global/subprocess", =
0, 0);
+    g_test_trap_subprocess("/global-props/qdev/static/global/subprocess"=
, 0, 0);
     g_test_trap_assert_passed();
     g_test_trap_assert_stderr("");
     g_test_trap_assert_stdout("");
@@ -245,7 +339,8 @@ static void test_dynamic_globalprop_subprocess(void)
=20
 static void test_dynamic_globalprop(void)
 {
-    g_test_trap_subprocess("/qdev/properties/dynamic/global/subprocess",=
 0, 0);
+    g_test_trap_subprocess("/global-props/qdev/dynamic/global/subprocess=
",
+                           0, 0);
     g_test_trap_assert_passed();
     g_test_trap_assert_stderr_unmatched("*prop1*");
     g_test_trap_assert_stderr_unmatched("*prop2*");
@@ -290,7 +385,8 @@ static void test_dynamic_globalprop_nouser_subprocess=
(void)
=20
 static void test_dynamic_globalprop_nouser(void)
 {
-    g_test_trap_subprocess("/qdev/properties/dynamic/global/nouser/subpr=
ocess", 0, 0);
+    g_test_trap_subprocess("/global-props/qdev"
+                           "/dynamic/global/nouser/subprocess", 0, 0);
     g_test_trap_assert_passed();
     g_test_trap_assert_stderr("");
     g_test_trap_assert_stdout("");
@@ -323,6 +419,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
=20
     module_call_init(MODULE_INIT_QOM);
+    type_register_static(&dummy_info);
     type_register_static(&static_prop_type);
     type_register_static(&subclass_type);
     type_register_static(&dynamic_prop_type);
@@ -330,27 +427,32 @@ int main(int argc, char **argv)
     type_register_static(&nohotplug_type);
     type_register_static(&nondevice_type);
=20
-    g_test_add_func("/qdev/properties/static/default/subprocess",
+    g_test_add_func("/global-props/usercreatable/subprocess",
+                    test_global_props_uc_subprocess);
+    g_test_add_func("/global-props/usercreatable",
+                    test_global_props_uc);
+
+    g_test_add_func("/global-props/qdev/static/default/subprocess",
                     test_static_prop_subprocess);
-    g_test_add_func("/qdev/properties/static/default",
+    g_test_add_func("/global-props/qdev/static/default",
                     test_static_prop);
=20
-    g_test_add_func("/qdev/properties/static/global/subprocess",
+    g_test_add_func("/global-props/qdev/static/global/subprocess",
                     test_static_globalprop_subprocess);
-    g_test_add_func("/qdev/properties/static/global",
+    g_test_add_func("/global-props/qdev/static/global",
                     test_static_globalprop);
=20
-    g_test_add_func("/qdev/properties/dynamic/global/subprocess",
+    g_test_add_func("/global-props/qdev/dynamic/global/subprocess",
                     test_dynamic_globalprop_subprocess);
-    g_test_add_func("/qdev/properties/dynamic/global",
+    g_test_add_func("/global-props/qdev/dynamic/global",
                     test_dynamic_globalprop);
=20
-    g_test_add_func("/qdev/properties/dynamic/global/nouser/subprocess",
+    g_test_add_func("/global-props/qdev/dynamic/global/nouser/subprocess=
",
                     test_dynamic_globalprop_nouser_subprocess);
-    g_test_add_func("/qdev/properties/dynamic/global/nouser",
+    g_test_add_func("/global-props/qdev/dynamic/global/nouser",
                     test_dynamic_globalprop_nouser);
=20
-    g_test_add_func("/qdev/properties/global/subclass",
+    g_test_add_func("/global-props/qdev/global/subclass",
                     test_subclass_global_props);
=20
     g_test_run();
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 87c81d1dcc..080b218fd3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -128,7 +128,7 @@ check-unit-y +=3D tests/test-qht-par$(EXESUF)
 gcov-files-test-qht-par-y =3D util/qht.c
 check-unit-y +=3D tests/test-bitops$(EXESUF)
 check-unit-y +=3D tests/test-bitcnt$(EXESUF)
-check-unit-y +=3D tests/test-qdev-global-props$(EXESUF)
+check-unit-y +=3D tests/test-global-props$(EXESUF)
 check-unit-y +=3D tests/check-qom-interface$(EXESUF)
 gcov-files-check-qom-interface-y =3D qom/object.c
 check-unit-y +=3D tests/check-qom-proplist$(EXESUF)
@@ -657,7 +657,7 @@ tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-ut=
il-obj-y)
 tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-=
obj-y)
 tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-ob=
j-y)
=20
-tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
+tests/test-global-props$(EXESUF): tests/test-global-props.o \
 	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
 	hw/core/bus.o \
 	hw/core/irq.o \
--=20
2.19.0.rc1
