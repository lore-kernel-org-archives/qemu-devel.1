Received: from eggs.gnu.org ([2001:4830:134:3::10]:47505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZh8-0003tb-WC
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZh3-0005Bm-1k
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:30:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRZh2-0005AS-OQ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:30:08 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:27:48 +0400
Message-Id: <20181127092801.21777-16-marcandre.lureau@redhat.com>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 15/28] hw: apply accel compat
 properties without touching globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>

Introduce object_apply_global_props() function, to apply compatibility
properties from a GPtrArray.

For accel compatibility properties, apply them during
device_post_init(), after accel_register_compat_props() has set them.

To populate the compatibility properties, introduce SET_COMPAT(), a
more generic version of SET_MACHINE_COMPAT() that can set compat
properties on other objects than Machine, and using GPtrArray.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/qdev-core.h | 13 +++++++++++++
 include/qom/object.h   |  3 +++
 include/sysemu/accel.h |  4 +---
 accel/accel.c          | 12 ------------
 hw/core/qdev.c         | 11 +++++++++++
 hw/xen/xen-common.c    | 38 +++++++++++++++++++-------------------
 qom/object.c           | 25 +++++++++++++++++++++++++
 vl.c                   |  2 +-
 8 files changed, 73 insertions(+), 35 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index a24d0dd566..82afd3c50d 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -267,6 +267,19 @@ typedef struct GlobalProperty {
     Error **errp;
 } GlobalProperty;
=20
+#define SET_COMPAT(S, COMPAT)                                       \
+    do {                                                            \
+        int i;                                                      \
+        static GlobalProperty props[] =3D {                           \
+            COMPAT                                                  \
+        };                                                          \
+        for (i =3D 0; i < G_N_ELEMENTS(props); i++) {                 \
+            g_ptr_array_add((S)->compat_props, (void *)&props[i]);  \
+        }                                                           \
+    } while (0)
+
+void accel_register_compat_props(const GPtrArray *props);
+
 /*** Board API.  This should go away once we have a machine config file.=
  ***/
=20
 DeviceState *qdev_create(BusState *bus, const char *name);
diff --git a/include/qom/object.h b/include/qom/object.h
index 0139838b69..5183c587f3 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -676,6 +676,9 @@ Object *object_new_with_propv(const char *typename,
                               Error **errp,
                               va_list vargs);
=20
+void object_apply_global_props(Object *obj, const GPtrArray *props,
+                               Error **errp);
+
 /**
  * object_set_props:
  * @obj: the object instance to set properties on
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 637358f430..f331d128e9 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -49,7 +49,7 @@ typedef struct AccelClass {
      * global properties may be overridden by machine-type
      * compat_props or user-provided global properties.
      */
-    GlobalProperty *global_props;
+    GPtrArray *compat_props;
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
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 6b3cc55b27..7066d28271 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -970,8 +970,19 @@ static void device_initfn(Object *obj)
     QLIST_INIT(&dev->gpios);
 }
=20
+static const GPtrArray *ac_compat_props;
+
+void accel_register_compat_props(const GPtrArray *props)
+{
+    ac_compat_props =3D props;
+}
+
 static void device_post_init(Object *obj)
 {
+    if (ac_compat_props) {
+        object_apply_global_props(obj, ac_compat_props, &error_abort);
+    }
+
     qdev_prop_set_globals(DEVICE(obj));
 }
=20
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 6ec14c73ca..4da0292b61 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -159,24 +159,22 @@ static int xen_init(MachineState *ms)
     return 0;
 }
=20
-static GlobalProperty xen_compat_props[] =3D {
-    {
-        .driver =3D "migration",
-        .property =3D "store-global-state",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "migration",
-        .property =3D "send-configuration",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "migration",
-        .property =3D "send-section-footer",
-        .value =3D "off",
-    },
-    { /* end of list */ },
-};
+#define XEN_COMPAT                              \
+    {                                           \
+        .driver =3D "migration",                  \
+        .property =3D "store-global-state",       \
+        .value =3D "off",                         \
+    },                                          \
+    {                                           \
+        .driver =3D "migration",                  \
+        .property =3D "send-configuration",       \
+        .value =3D "off",                         \
+    },                                          \
+    {                                           \
+        .driver =3D "migration",                  \
+        .property =3D "send-section-footer",      \
+        .value =3D "off",                         \
+    }
=20
 static void xen_accel_class_init(ObjectClass *oc, void *data)
 {
@@ -185,7 +183,9 @@ static void xen_accel_class_init(ObjectClass *oc, voi=
d *data)
     ac->init_machine =3D xen_init;
     ac->setup_post =3D xen_setup_post;
     ac->allowed =3D &xen_allowed;
-    ac->global_props =3D xen_compat_props;
+    ac->compat_props =3D g_ptr_array_new();
+
+    SET_COMPAT(ac, XEN_COMPAT);
 }
=20
 #define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
diff --git a/qom/object.c b/qom/object.c
index 17921c0a71..dbdab0aead 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -370,6 +370,31 @@ static void object_post_init_with_type(Object *obj, =
TypeImpl *ti)
     }
 }
=20
+void object_apply_global_props(Object *obj, const GPtrArray *props, Erro=
r **errp)
+{
+    Error *err =3D NULL;
+    int i;
+
+    if (!props) {
+        return;
+    }
+
+    for (i =3D 0; i < props->len; i++) {
+        GlobalProperty *p =3D g_ptr_array_index(props, i);
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
diff --git a/vl.c b/vl.c
index fa25d1ae2d..c06e94271c 100644
--- a/vl.c
+++ b/vl.c
@@ -2963,7 +2963,7 @@ static void user_register_global_props(void)
  */
 static void register_global_properties(MachineState *ms)
 {
-    accel_register_compat_props(ms->accelerator);
+    accel_register_compat_props(ACCEL_GET_CLASS(ms->accelerator)->compat=
_props);
     machine_register_compat_props(ms);
     user_register_global_props();
 }
--=20
2.20.0.rc1
