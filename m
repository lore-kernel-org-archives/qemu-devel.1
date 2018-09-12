Received: from eggs.gnu.org ([2001:4830:134:3::10]:33057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g04gk-0007Uz-4M
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g04gh-00080v-EH
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:56:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g04gh-000801-5M
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:56:07 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 12 Sep 2018 16:55:26 +0400
Message-Id: <20180912125531.32131-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180912125531.32131-1-marcandre.lureau@redhat.com>
References: <20180912125531.32131-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/9] qom/globals: move qdev globals to qom
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

Move the global properties handling to QOM. For now, this is just a
simple moving & renaming and the globals are only applied to
TYPE_DEVICE. The following patches will generalize the global handling
to other object types.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/qdev-core.h         | 20 ---------
 include/hw/qdev-properties.h   |  4 +-
 include/qom/globals.h          | 32 +++++++++++++++
 accel/accel.c                  |  2 +-
 hw/core/machine.c              |  2 +-
 hw/core/qdev-properties.c      | 67 ------------------------------
 hw/core/qdev.c                 |  2 +-
 qom/cpu.c                      |  2 +-
 qom/globals.c                  | 75 ++++++++++++++++++++++++++++++++++
 target/i386/cpu.c              |  2 +-
 target/sparc/cpu.c             |  2 +-
 tests/test-qdev-global-props.c |  6 +--
 vl.c                           |  8 ++--
 qom/Makefile.objs              |  2 +-
 14 files changed, 122 insertions(+), 104 deletions(-)
 create mode 100644 include/qom/globals.h
 create mode 100644 qom/globals.c

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index f1fd0f8736..9e4695d03f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -246,26 +246,6 @@ struct PropertyInfo {
     ObjectPropertyRelease *release;
 };
=20
-/**
- * GlobalProperty:
- * @user_provided: Set to true if property comes from user-provided conf=
ig
- * (command-line or config file).
- * @used: Set to true if property was used when initializing a device.
- * @errp: Error destination, used like first argument of error_setg()
- *        in case property setting fails later. If @errp is NULL, we
- *        print warnings instead of ignoring errors silently. For
- *        hotplugged devices, errp is always ignored and warnings are
- *        printed instead.
- */
-typedef struct GlobalProperty {
-    const char *driver;
-    const char *property;
-    const char *value;
-    bool user_provided;
-    bool used;
-    Error **errp;
-} GlobalProperty;
-
 /*** Board API.  This should go away once we have a machine config file.=
  ***/
=20
 DeviceState *qdev_create(BusState *bus, const char *name);
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 3ab9cd2eb6..c8b727f081 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -4,6 +4,7 @@
 #include "qapi/qapi-types-block.h"
 #include "qapi/qapi-types-misc.h"
 #include "hw/qdev-core.h"
+#include "qom/globals.h"
=20
 /*** qdev-properties.c ***/
=20
@@ -248,9 +249,6 @@ void qdev_prop_set_enum(DeviceState *dev, const char =
*name, int value);
 /* FIXME: Remove opaque pointer properties.  */
 void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value);
=20
-void qdev_prop_register_global(GlobalProperty *prop);
-int qdev_prop_check_globals(void);
-void qdev_prop_set_globals(DeviceState *dev);
 void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *=
dev,
                                     Property *prop, const char *value);
=20
diff --git a/include/qom/globals.h b/include/qom/globals.h
new file mode 100644
index 0000000000..28a0390233
--- /dev/null
+++ b/include/qom/globals.h
@@ -0,0 +1,32 @@
+#ifndef QOM_GLOBALS
+#define QOM_GLOBALS
+
+#include "qom/object.h"
+
+/**
+ * GlobalProperty:
+ * @user_provided: Set to true if property comes from user-provided conf=
ig
+ * (command-line or config file).
+ * @used: Set to true if property was used when initializing a device.
+ * @errp: Error destination, used like first argument of error_setg()
+ *        in case property setting fails later. If @errp is NULL, we
+ *        print warnings instead of ignoring errors silently. For
+ *        hotplugged devices, errp is always ignored and warnings are
+ *        printed instead.
+ */
+typedef struct GlobalProperty {
+    const char *driver;
+    const char *property;
+    const char *value;
+    bool user_provided;
+    bool used;
+    Error **errp;
+} GlobalProperty;
+
+void object_property_register_global(GlobalProperty *prop);
+
+void object_property_set_globals(Object *obj);
+
+int object_property_check_globals(void);
+
+#endif
diff --git a/accel/accel.c b/accel/accel.c
index 3da26eb90f..6916e0d63d 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -127,7 +127,7 @@ void accel_register_compat_props(AccelState *accel)
     for (; prop && prop->driver; prop++) {
         /* Any compat_props must never cause error */
         prop->errp =3D &error_abort;
-        qdev_prop_register_global(prop);
+        object_property_register_global(prop);
     }
 }
=20
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6b68e1218f..5f532939e4 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -855,7 +855,7 @@ void machine_register_compat_props(MachineState *mach=
ine)
         p =3D g_array_index(mc->compat_props, GlobalProperty *, i);
         /* Machine compat_props must never cause errors: */
         p->errp =3D &error_abort;
-        qdev_prop_register_global(p);
+        object_property_register_global(p);
     }
 }
=20
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index bd84c4ea4c..4605ca9b78 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1173,73 +1173,6 @@ void qdev_prop_set_ptr(DeviceState *dev, const cha=
r *name, void *value)
     *ptr =3D value;
 }
=20
-static GList *global_props;
-
-void qdev_prop_register_global(GlobalProperty *prop)
-{
-    global_props =3D g_list_append(global_props, prop);
-}
-
-int qdev_prop_check_globals(void)
-{
-    GList *l;
-    int ret =3D 0;
-
-    for (l =3D global_props; l; l =3D l->next) {
-        GlobalProperty *prop =3D l->data;
-        ObjectClass *oc;
-        DeviceClass *dc;
-        if (prop->used) {
-            continue;
-        }
-        if (!prop->user_provided) {
-            continue;
-        }
-        oc =3D object_class_by_name(prop->driver);
-        oc =3D object_class_dynamic_cast(oc, TYPE_DEVICE);
-        if (!oc) {
-            warn_report("global %s.%s has invalid class name",
-                        prop->driver, prop->property);
-            ret =3D 1;
-            continue;
-        }
-        dc =3D DEVICE_CLASS(oc);
-        if (!dc->hotpluggable && !prop->used) {
-            warn_report("global %s.%s=3D%s not used",
-                        prop->driver, prop->property, prop->value);
-            ret =3D 1;
-            continue;
-        }
-    }
-    return ret;
-}
-
-void qdev_prop_set_globals(DeviceState *dev)
-{
-    GList *l;
-
-    for (l =3D global_props; l; l =3D l->next) {
-        GlobalProperty *prop =3D l->data;
-        Error *err =3D NULL;
-
-        if (object_dynamic_cast(OBJECT(dev), prop->driver) =3D=3D NULL) =
{
-            continue;
-        }
-        prop->used =3D true;
-        object_property_parse(OBJECT(dev), prop->value, prop->property, =
&err);
-        if (err !=3D NULL) {
-            error_prepend(&err, "can't apply global %s.%s=3D%s: ",
-                          prop->driver, prop->property, prop->value);
-            if (!dev->hotplugged && prop->errp) {
-                error_propagate(prop->errp, err);
-            } else {
-                assert(prop->user_provided);
-                warn_report_err(err);
-            }
-        }
-    }
-}
-
 /* --- 64bit unsigned int 'size' type --- */
=20
 static void get_size(Object *obj, Visitor *v, const char *name, void *op=
aque,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 529b82de18..473060b551 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -976,7 +976,7 @@ static void device_initfn(Object *obj)
=20
 static void device_post_init(Object *obj)
 {
-    qdev_prop_set_globals(DEVICE(obj));
+    object_property_set_globals(obj);
 }
=20
 /* Unlink device from bus and free the structure.  */
diff --git a/qom/cpu.c b/qom/cpu.c
index 92599f3541..aaabe67648 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -314,7 +314,7 @@ static void cpu_common_parse_features(const char *typ=
ename, char *features,
             prop->property =3D g_strdup(featurestr);
             prop->value =3D g_strdup(val);
             prop->errp =3D &error_fatal;
-            qdev_prop_register_global(prop);
+            object_property_register_global(prop);
         } else {
             error_setg(errp, "Expected key=3Dvalue format, found %s.",
                        featurestr);
diff --git a/qom/globals.c b/qom/globals.c
new file mode 100644
index 0000000000..587f4a1b5c
--- /dev/null
+++ b/qom/globals.c
@@ -0,0 +1,75 @@
+#include "qemu/osdep.h"
+
+#include "hw/qdev.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qom/globals.h"
+#include "qom/object_interfaces.h"
+
+static GList *global_props;
+
+void object_property_register_global(GlobalProperty *prop)
+{
+    global_props =3D g_list_append(global_props, prop);
+}
+
+void object_property_set_globals(Object *obj)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    GList *l;
+
+    for (l =3D global_props; l; l =3D l->next) {
+        GlobalProperty *prop =3D l->data;
+        Error *err =3D NULL;
+
+        if (object_dynamic_cast(OBJECT(dev), prop->driver) =3D=3D NULL) =
{
+            continue;
+        }
+        prop->used =3D true;
+        object_property_parse(OBJECT(dev), prop->value, prop->property, =
&err);
+        if (err !=3D NULL) {
+            error_prepend(&err, "can't apply global %s.%s=3D%s: ",
+                          prop->driver, prop->property, prop->value);
+            if (!dev->hotplugged && prop->errp) {
+                error_propagate(prop->errp, err);
+            } else {
+                assert(prop->user_provided);
+                warn_report_err(err);
+            }
+        }
+    }
+}
+
+int object_property_check_globals(void)
+{
+    GList *l;
+    int ret =3D 0;
+
+    for (l =3D global_props; l; l =3D l->next) {
+        GlobalProperty *prop =3D l->data;
+        ObjectClass *oc;
+        DeviceClass *dc;
+        if (prop->used) {
+            continue;
+        }
+        if (!prop->user_provided) {
+            continue;
+        }
+        oc =3D object_class_by_name(prop->driver);
+        oc =3D object_class_dynamic_cast(oc, TYPE_DEVICE);
+        if (!oc) {
+            warn_report("global %s.%s has invalid class name",
+                        prop->driver, prop->property);
+            ret =3D 1;
+            continue;
+        }
+        dc =3D DEVICE_CLASS(oc);
+        if (!dc->hotpluggable && !prop->used) {
+            warn_report("global %s.%s=3D%s not used",
+                        prop->driver, prop->property, prop->value);
+            ret =3D 1;
+            continue;
+        }
+    }
+    return ret;
+}
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f24295e6e4..ead1f67805 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3414,7 +3414,7 @@ static void x86_cpu_parse_featurestr(const char *ty=
pename, char *features,
         prop->property =3D g_strdup(name);
         prop->value =3D g_strdup(val);
         prop->errp =3D &error_fatal;
-        qdev_prop_register_global(prop);
+        object_property_register_global(prop);
     }
=20
     if (ambiguous) {
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 0f090ece54..3fde246d0d 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -112,7 +112,7 @@ cpu_add_feat_as_prop(const char *typename, const char=
 *name, const char *val)
     prop->property =3D g_strdup(name);
     prop->value =3D g_strdup(val);
     prop->errp =3D &error_fatal;
-    qdev_prop_register_global(prop);
+    object_property_register_global(prop);
 }
=20
 /* Parse "+feature,-feature,feature=3Dfoo" CPU feature string */
diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-prop=
s.c
index d8596e6637..9dffdf336d 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -94,7 +94,7 @@ static void register_global_list(GlobalProperty *props)
     int i;
=20
     for (i =3D 0; props[i].driver !=3D NULL; i++) {
-        qdev_prop_register_global(props + i);
+        object_property_register_global(props + i);
     }
 }
=20
@@ -233,7 +233,7 @@ static void test_dynamic_globalprop_subprocess(void)
=20
     g_assert_cmpuint(mt->prop1, =3D=3D, 101);
     g_assert_cmpuint(mt->prop2, =3D=3D, 102);
-    all_used =3D qdev_prop_check_globals();
+    all_used =3D object_property_check_globals();
     g_assert_cmpuint(all_used, =3D=3D, 1);
     g_assert(props[0].used);
     g_assert(props[1].used);
@@ -278,7 +278,7 @@ static void test_dynamic_globalprop_nouser_subprocess=
(void)
=20
     g_assert_cmpuint(mt->prop1, =3D=3D, 101);
     g_assert_cmpuint(mt->prop2, =3D=3D, 102);
-    all_used =3D qdev_prop_check_globals();
+    all_used =3D object_property_check_globals();
     g_assert_cmpuint(all_used, =3D=3D, 0);
     g_assert(props[0].used);
     g_assert(props[1].used);
diff --git a/vl.c b/vl.c
index 5ba06adf78..03b8bda0ac 100644
--- a/vl.c
+++ b/vl.c
@@ -903,7 +903,7 @@ static void configure_rtc(QemuOpts *opts)
                 .value    =3D "slew",
             };
=20
-            qdev_prop_register_global(&slew_lost_ticks);
+            object_property_register_global(&slew_lost_ticks);
         } else if (!strcmp(value, "none")) {
             /* discard is default */
         } else {
@@ -2872,7 +2872,7 @@ static int global_init_func(void *opaque, QemuOpts =
*opts, Error **errp)
     g->value    =3D qemu_opt_get(opts, "value");
     g->user_provided =3D true;
     g->errp =3D &error_fatal;
-    qdev_prop_register_global(g);
+    object_property_register_global(g);
     return 0;
 }
=20
@@ -3564,7 +3564,7 @@ int main(int argc, char **argv, char **envp)
                     .value    =3D "slew",
                 };
=20
-                qdev_prop_register_global(&slew_lost_ticks);
+                object_property_register_global(&slew_lost_ticks);
                 warn_report("This option is deprecated, "
                             "use '-rtc driftfix=3Dslew' instead.");
                 break;
@@ -4623,7 +4623,7 @@ int main(int argc, char **argv, char **envp)
         }
     }
=20
-    qdev_prop_check_globals();
+    object_property_check_globals();
     if (vmstate_dump_file) {
         /* dump and exit */
         dump_vmstate_json_to_file(vmstate_dump_file);
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index 516349eec3..723851ff28 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -1,4 +1,4 @@
 qom-obj-y =3D object.o container.o qom-qobject.o
-qom-obj-y +=3D object_interfaces.o
+qom-obj-y +=3D object_interfaces.o globals.o
=20
 common-obj-y =3D cpu.o
--=20
2.19.0.rc1
