Received: from eggs.gnu.org ([2001:4830:134:3::10]:37489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN62-0006Rs-0R
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN61-0006jU-0P
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:38:09 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Nov 2018 16:36:45 +0400
Message-Id: <20181107123652.23417-8-marcandre.lureau@redhat.com>
In-Reply-To: <20181107123652.23417-1-marcandre.lureau@redhat.com>
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v3 07/14] qdev: all globals are now
 user-provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, Artyom Tarasenko <atar4qemu@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Berger <stefanb@linux.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Considering that CPU features are provided via command line, the
global_props are now all user-provided globals. No need to track this
anymore for qdev_prop_check_globals().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/qdev-core.h         |  3 --
 hw/core/qdev-properties.c      |  4 ---
 tests/test-qdev-global-props.c | 57 ++++------------------------------
 vl.c                           |  1 -
 4 files changed, 6 insertions(+), 59 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index a24d0dd566..baaf097212 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -249,8 +249,6 @@ struct PropertyInfo {
=20
 /**
  * GlobalProperty:
- * @user_provided: Set to true if property comes from user-provided conf=
ig
- * (command-line or config file).
  * @used: Set to true if property was used when initializing a device.
  * @errp: Error destination, used like first argument of error_setg()
  *        in case property setting fails later. If @errp is NULL, we
@@ -262,7 +260,6 @@ typedef struct GlobalProperty {
     const char *driver;
     const char *property;
     const char *value;
-    bool user_provided;
     bool used;
     Error **errp;
 } GlobalProperty;
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index bd84c4ea4c..43c30a57f4 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1192,9 +1192,6 @@ int qdev_prop_check_globals(void)
         if (prop->used) {
             continue;
         }
-        if (!prop->user_provided) {
-            continue;
-        }
         oc =3D object_class_by_name(prop->driver);
         oc =3D object_class_dynamic_cast(oc, TYPE_DEVICE);
         if (!oc) {
@@ -1233,7 +1230,6 @@ void qdev_prop_set_globals(DeviceState *dev)
             if (!dev->hotplugged && prop->errp) {
                 error_propagate(prop->errp, err);
             } else {
-                assert(prop->user_provided);
                 warn_report_err(err);
             }
         }
diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-prop=
s.c
index 3a8d3170a0..f49a1b70b5 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -215,12 +215,12 @@ static void test_dynamic_globalprop_subprocess(void=
)
 {
     MyType *mt;
     static GlobalProperty props[] =3D {
-        { TYPE_DYNAMIC_PROPS, "prop1", "101", true },
-        { TYPE_DYNAMIC_PROPS, "prop2", "102", true },
-        { TYPE_DYNAMIC_PROPS"-bad", "prop3", "103", true },
-        { TYPE_UNUSED_HOTPLUG, "prop4", "104", true },
-        { TYPE_UNUSED_NOHOTPLUG, "prop5", "105", true },
-        { TYPE_NONDEVICE, "prop6", "106", true },
+        { TYPE_DYNAMIC_PROPS, "prop1", "101", },
+        { TYPE_DYNAMIC_PROPS, "prop2", "102", },
+        { TYPE_DYNAMIC_PROPS"-bad", "prop3", "103", },
+        { TYPE_UNUSED_HOTPLUG, "prop4", "104", },
+        { TYPE_UNUSED_NOHOTPLUG, "prop5", "105", },
+        { TYPE_NONDEVICE, "prop6", "106", },
         {}
     };
     int global_error;
@@ -255,46 +255,6 @@ static void test_dynamic_globalprop(void)
     g_test_trap_assert_stdout("");
 }
=20
-/* Test setting of dynamic properties using user_provided=3Dfalse proper=
ties */
-static void test_dynamic_globalprop_nouser_subprocess(void)
-{
-    MyType *mt;
-    static GlobalProperty props[] =3D {
-        { TYPE_DYNAMIC_PROPS, "prop1", "101" },
-        { TYPE_DYNAMIC_PROPS, "prop2", "102" },
-        { TYPE_DYNAMIC_PROPS"-bad", "prop3", "103" },
-        { TYPE_UNUSED_HOTPLUG, "prop4", "104" },
-        { TYPE_UNUSED_NOHOTPLUG, "prop5", "105" },
-        { TYPE_NONDEVICE, "prop6", "106" },
-        {}
-    };
-    int global_error;
-
-    register_global_properties(props);
-
-    mt =3D DYNAMIC_TYPE(object_new(TYPE_DYNAMIC_PROPS));
-    qdev_init_nofail(DEVICE(mt));
-
-    g_assert_cmpuint(mt->prop1, =3D=3D, 101);
-    g_assert_cmpuint(mt->prop2, =3D=3D, 102);
-    global_error =3D qdev_prop_check_globals();
-    g_assert_cmpuint(global_error, =3D=3D, 0);
-    g_assert(props[0].used);
-    g_assert(props[1].used);
-    g_assert(!props[2].used);
-    g_assert(!props[3].used);
-    g_assert(!props[4].used);
-    g_assert(!props[5].used);
-}
-
-static void test_dynamic_globalprop_nouser(void)
-{
-    g_test_trap_subprocess("/qdev/properties/dynamic/global/nouser/subpr=
ocess", 0, 0);
-    g_test_trap_assert_passed();
-    g_test_trap_assert_stderr("");
-    g_test_trap_assert_stdout("");
-}
-
 /* Test if global props affecting subclasses are applied in the right or=
der */
 static void test_subclass_global_props(void)
 {
@@ -344,11 +304,6 @@ int main(int argc, char **argv)
     g_test_add_func("/qdev/properties/dynamic/global",
                     test_dynamic_globalprop);
=20
-    g_test_add_func("/qdev/properties/dynamic/global/nouser/subprocess",
-                    test_dynamic_globalprop_nouser_subprocess);
-    g_test_add_func("/qdev/properties/dynamic/global/nouser",
-                    test_dynamic_globalprop_nouser);
-
     g_test_add_func("/qdev/properties/global/subclass",
                     test_subclass_global_props);
=20
diff --git a/vl.c b/vl.c
index 2aea884c9d..d11b070e70 100644
--- a/vl.c
+++ b/vl.c
@@ -2931,7 +2931,6 @@ static int global_init_func(void *opaque, QemuOpts =
*opts, Error **errp)
     g->driver   =3D qemu_opt_get(opts, "driver");
     g->property =3D qemu_opt_get(opts, "property");
     g->value    =3D qemu_opt_get(opts, "value");
-    g->user_provided =3D true;
     g->errp =3D &error_fatal;
     qdev_prop_register_global(g);
     return 0;
--=20
2.19.1.708.g4ede3d42df
