Received: from eggs.gnu.org ([2001:4830:134:3::10]:53232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCNK-0001kb-6E
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCNI-0005ah-Mi
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:49:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCNI-0005ZO-B1
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:49:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BD0B307D840
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 21:48:59 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 01:48:23 +0400
Message-Id: <20181212214850.29953-2-marcandre.lureau@redhat.com>
In-Reply-To: <20181212214850.29953-1-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 01/28] hw: apply accel compat properties
 without touching globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com

Instead of registering compat properties as globals, let's keep them
in their own array, to avoid mixing with user globals.

Introduce object_apply_global_props() function, to apply compatibility
properties from a GPtrArray.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/qdev-core.h | 10 ++++++++++
 include/qom/object.h   |  3 +++
 include/sysemu/accel.h |  4 +---
 accel/accel.c          | 12 ------------
 hw/core/qdev.c         |  9 +++++++++
 hw/xen/xen-common.c    |  9 ++++++---
 qom/object.c           | 25 +++++++++++++++++++++++++
 vl.c                   |  1 -
 8 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 92851e55df..84e612f473 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -267,6 +267,16 @@ typedef struct GlobalProperty {
     Error **errp;
 } GlobalProperty;
=20
+static inline void
+compat_props_add(GPtrArray *arr,
+                 GlobalProperty props[], size_t nelem)
+{
+    int i;
+    for (i =3D 0; i < nelem; i++) {
+        g_ptr_array_add(arr, (void *)&props[i]);
+    }
+}
+
 /*** Board API.  This should go away once we have a machine config file.=
  ***/
=20
 DeviceState *qdev_create(BusState *bus, const char *name);
diff --git a/include/qom/object.h b/include/qom/object.h
index bcae3f4951..e0262962b5 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -675,6 +675,9 @@ Object *object_new_with_propv(const char *typename,
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
index 6b3cc55b27..53b507164f 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -972,6 +972,15 @@ static void device_initfn(Object *obj)
=20
 static void device_post_init(Object *obj)
 {
+    if (object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE)) {
+        MachineState *m =3D MACHINE(qdev_get_machine());
+        AccelClass *ac =3D ACCEL_GET_CLASS(m->accelerator);
+
+        if (ac->compat_props) {
+            object_apply_global_props(obj, ac->compat_props, &error_abor=
t);
+        }
+    }
+
     qdev_prop_set_globals(DEVICE(obj));
 }
=20
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 6ec14c73ca..4532aa8632 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -174,18 +174,21 @@ static GlobalProperty xen_compat_props[] =3D {
         .driver =3D "migration",
         .property =3D "send-section-footer",
         .value =3D "off",
-    },
-    { /* end of list */ },
+    }
 };
=20
 static void xen_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac =3D ACCEL_CLASS(oc);
+
     ac->name =3D "Xen";
     ac->init_machine =3D xen_init;
     ac->setup_post =3D xen_setup_post;
     ac->allowed =3D &xen_allowed;
-    ac->global_props =3D xen_compat_props;
+    ac->compat_props =3D g_ptr_array_new();
+
+    compat_props_add(ac->compat_props,
+                     xen_compat_props, G_N_ELEMENTS(xen_compat_props));
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
index a5ae5f23d2..88ba658572 100644
--- a/vl.c
+++ b/vl.c
@@ -2968,7 +2968,6 @@ static void user_register_global_props(void)
  */
 static void register_global_properties(MachineState *ms)
 {
-    accel_register_compat_props(ms->accelerator);
     machine_register_compat_props(ms);
     user_register_global_props();
 }
--=20
2.20.0
