Received: from eggs.gnu.org ([2001:4830:134:3::10]:37431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN5t-0005vV-Gw
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN5s-0006fa-5i
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:38:01 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Nov 2018 16:36:44 +0400
Message-Id: <20181107123652.23417-7-marcandre.lureau@redhat.com>
In-Reply-To: <20181107123652.23417-1-marcandre.lureau@redhat.com>
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v3 06/14] qdev: do not mix compat props
 with global props
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

Machine & Accel props are not provided by user. Let's not mix them
with the global properties.

Call a new helper function object_apply_global_props() during
device_post_init().

Add a stub for current_machine, so qemu-user and tests can find a
fallback symbol when linking with QDev.

The following patches is going to reuse object_apply_global_props()
for qdev globals.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/boards.h            |  1 -
 include/qom/object.h           |  2 ++
 include/sysemu/accel.h         |  4 +---
 accel/accel.c                  | 12 ------------
 hw/core/machine.c              | 18 ------------------
 hw/core/qdev.c                 |  8 ++++++++
 hw/xen/xen-common.c            |  9 ++++++++-
 qom/object.c                   | 25 +++++++++++++++++++++++++
 stubs/machine.c                |  4 ++++
 tests/test-qdev-global-props.c |  1 -
 vl.c                           |  2 --
 stubs/Makefile.objs            |  1 +
 12 files changed, 49 insertions(+), 38 deletions(-)
 create mode 100644 stubs/machine.c

diff --git a/include/hw/boards.h b/include/hw/boards.h
index f82f28468b..c02190fc52 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -69,7 +69,6 @@ int machine_kvm_shadow_mem(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
 bool machine_dump_guest_core(MachineState *machine);
 bool machine_mem_merge(MachineState *machine);
-void machine_register_compat_props(MachineState *machine);
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machi=
ne);
 void machine_set_cpu_numa_node(MachineState *machine,
                                const CpuInstanceProperties *props,
diff --git a/include/qom/object.h b/include/qom/object.h
index f0b0bf39cc..e58eeb280f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -679,6 +679,8 @@ Object *object_new_with_propv(const char *typename,
                               Error **errp,
                               va_list vargs);
=20
+void object_apply_global_props(Object *obj, GArray *props, Error **errp)=
;
+
 /**
  * object_set_props:
  * @obj: the object instance to set properties on
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 637358f430..f4f71134b5 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -49,7 +49,7 @@ typedef struct AccelClass {
      * global properties may be overridden by machine-type
      * compat_props or user-provided global properties.
      */
-    GlobalProperty *global_props;
+    GArray *compat_props;
 } AccelClass;
=20
 #define TYPE_ACCEL "accel"
@@ -67,8 +67,6 @@ typedef struct AccelClass {
 extern unsigned long tcg_tb_size;
=20
 void configure_accelerator(MachineState *ms);
-/* Register accelerator specific global properties */
-void accel_register_compat_props(AccelState *accel);
 /* Called just before os_setup_post (ie just before drop OS privs) */
 void accel_setup_post(MachineState *ms);
=20
diff --git a/accel/accel.c b/accel/accel.c
index 3da26eb90f..6db5d8f4df 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -119,18 +119,6 @@ void configure_accelerator(MachineState *ms)
     }
 }
=20
-void accel_register_compat_props(AccelState *accel)
-{
-    AccelClass *class =3D ACCEL_GET_CLASS(accel);
-    GlobalProperty *prop =3D class->global_props;
-
-    for (; prop && prop->driver; prop++) {
-        /* Any compat_props must never cause error */
-        prop->errp =3D &error_abort;
-        qdev_prop_register_global(prop);
-    }
-}
-
 void accel_setup_post(MachineState *ms)
 {
     AccelState *accel =3D ms->accelerator;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index da50ad6de7..4444d45945 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -844,24 +844,6 @@ static void machine_class_finalize(ObjectClass *klas=
s, void *data)
     g_free(mc->name);
 }
=20
-void machine_register_compat_props(MachineState *machine)
-{
-    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
-    int i;
-    GlobalProperty *p;
-
-    if (!mc->compat_props) {
-        return;
-    }
-
-    for (i =3D 0; i < mc->compat_props->len; i++) {
-        p =3D g_array_index(mc->compat_props, GlobalProperty *, i);
-        /* Machine compat_props must never cause errors: */
-        p->errp =3D &error_abort;
-        qdev_prop_register_global(p);
-    }
-}
-
 static const TypeInfo machine_info =3D {
     .name =3D TYPE_MACHINE,
     .parent =3D TYPE_OBJECT,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 6b3cc55b27..30890f2c8d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -972,6 +972,14 @@ static void device_initfn(Object *obj)
=20
 static void device_post_init(Object *obj)
 {
+    if (current_machine) {
+        MachineClass *mc =3D MACHINE_GET_CLASS(current_machine);
+        AccelClass *ac =3D ACCEL_GET_CLASS(current_machine->accelerator)=
;
+
+        object_apply_global_props(obj, mc->compat_props, &error_abort);
+        object_apply_global_props(obj, ac->compat_props, &error_abort);
+    }
+
     qdev_prop_set_globals(DEVICE(obj));
 }
=20
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 6ec14c73ca..d1ef7a53cc 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -181,11 +181,18 @@ static GlobalProperty xen_compat_props[] =3D {
 static void xen_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac =3D ACCEL_CLASS(oc);
+    int i;
+
     ac->name =3D "Xen";
     ac->init_machine =3D xen_init;
     ac->setup_post =3D xen_setup_post;
     ac->allowed =3D &xen_allowed;
-    ac->global_props =3D xen_compat_props;
+
+    ac->compat_props =3D g_array_new(false, false, sizeof(void *));
+    for (i =3D 0; xen_compat_props[i].driver !=3D NULL; i++) {
+        GlobalProperty *prop =3D &xen_compat_props[i];
+        g_array_append_val(ac->compat_props, prop);
+    }
 }
=20
 #define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
diff --git a/qom/object.c b/qom/object.c
index eb770dbf7f..9acdf9e16d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -372,6 +372,31 @@ static void object_post_init_with_type(Object *obj, =
TypeImpl *ti)
     }
 }
=20
+void object_apply_global_props(Object *obj, GArray *props, Error **errp)
+{
+    Error *err =3D NULL;
+    int i;
+
+    if (!props) {
+        return;
+    }
+
+    for (i =3D 0; i < props->len; i++) {
+        GlobalProperty *p =3D g_array_index(props, GlobalProperty *, i);
+
+        if (object_dynamic_cast(obj, p->driver) =3D=3D NULL) {
+            continue;
+        }
+        p->used =3D true;
+        object_property_parse(obj, p->value, p->property, &err);
+        if (err !=3D NULL) {
+            error_prepend(&err, "can't apply global %s.%s=3D%s: ",
+                          p->driver, p->property, p->value);
+            error_propagate(errp, err);
+        }
+    }
+}
+
 static void object_initialize_with_type(void *data, size_t size, TypeImp=
l *type)
 {
     Object *obj =3D data;
diff --git a/stubs/machine.c b/stubs/machine.c
new file mode 100644
index 0000000000..51d40fd677
--- /dev/null
+++ b/stubs/machine.c
@@ -0,0 +1,4 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+MachineClass *current_machine;
diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-prop=
s.c
index b1eb505442..3a8d3170a0 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -28,7 +28,6 @@
 #include "qom/object.h"
 #include "qapi/visitor.h"
=20
-
 #define TYPE_STATIC_PROPS "static_prop_type"
 #define STATIC_TYPE(obj) \
     OBJECT_CHECK(MyType, (obj), TYPE_STATIC_PROPS)
diff --git a/vl.c b/vl.c
index 55bab005b6..2aea884c9d 100644
--- a/vl.c
+++ b/vl.c
@@ -2963,8 +2963,6 @@ static void user_register_global_props(void)
  */
 static void register_global_properties(MachineState *ms)
 {
-    accel_register_compat_props(ms->accelerator);
-    machine_register_compat_props(ms);
     user_register_global_props();
 }
=20
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 5dd0aeeec6..6ce33ae46f 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -18,6 +18,7 @@ stub-obj-y +=3D iothread-lock.o
 stub-obj-y +=3D is-daemonized.o
 stub-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
 stub-obj-y +=3D machine-init-done.o
+stub-obj-y +=3D machine.o
 stub-obj-y +=3D migr-blocker.o
 stub-obj-y +=3D change-state-handler.o
 stub-obj-y +=3D monitor.o
--=20
2.19.1.708.g4ede3d42df
