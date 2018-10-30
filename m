Received: from eggs.gnu.org ([2001:4830:134:3::10]:52786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gHVaq-0003wL-TE
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gHVal-0000aq-0V
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:06:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gHVak-00007d-IZ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:06:02 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Oct 2018 19:04:45 +0400
Message-Id: <20181030150453.9344-3-marcandre.lureau@redhat.com>
In-Reply-To: <20181030150453.9344-1-marcandre.lureau@redhat.com>
References: <20181030150453.9344-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/10] accel: register global_props like
 machine globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

global_props is only used for Xen xen_compat_props. It's a static
array of GlobalProperty, like machine globals in SET_MACHINE_COMPAT().
Let's register the globals the same way, without extra copy allocation.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/qdev-properties.h | 29 -----------------------------
 accel/accel.c                |  9 ++++++++-
 hw/core/qdev-properties.c    | 21 ---------------------
 3 files changed, 8 insertions(+), 51 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 4f60cc88f3..a95f4a73eb 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -255,35 +255,6 @@ void qdev_prop_set_globals(DeviceState *dev);
 void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *=
dev,
                                     Property *prop, const char *value);
=20
-/**
- * register_compat_prop:
- *
- * Register internal (not user-provided) global property, changing the
- * default value of a given property in a device type.  This can be used
- * for enabling machine-type compatibility or for enabling
- * accelerator-specific defaults in devices.
- *
- * The property values set using this function must be always valid and
- * never report setter errors, as the property will have
- * GlobalProperty::errp set to &error_abort.
- *
- * User-provided global properties should override internal global
- * properties, so callers of this function should ensure that it is
- * called before user-provided global properties are registered.
- *
- * @driver: Device type to be affected
- * @property: Property whose default value is going to be changed
- * @value: New default value for the property
- */
-void register_compat_prop(const char *driver, const char *property,
-                          const char *value);
-/*
- * register_compat_props_array(): using register_compat_prop(), which
- * only registers internal global properties (which has lower priority
- * than user-provided global properties)
- */
-void register_compat_props_array(GlobalProperty *prop);
-
 /**
  * qdev_property_add_static:
  * @dev: Device to add the property to.
diff --git a/accel/accel.c b/accel/accel.c
index 966b2d8f53..3da26eb90f 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -34,6 +34,7 @@
 #include "qom/object.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qapi/error.h"
=20
 static const TypeInfo accel_type =3D {
     .name =3D TYPE_ACCEL,
@@ -121,7 +122,13 @@ void configure_accelerator(MachineState *ms)
 void accel_register_compat_props(AccelState *accel)
 {
     AccelClass *class =3D ACCEL_GET_CLASS(accel);
-    register_compat_props_array(class->global_props);
+    GlobalProperty *prop =3D class->global_props;
+
+    for (; prop && prop->driver; prop++) {
+        /* Any compat_props must never cause error */
+        prop->errp =3D &error_abort;
+        qdev_prop_register_global(prop);
+    }
 }
=20
 void accel_setup_post(MachineState *ms)
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 35072dec1e..ab61d502fd 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1180,27 +1180,6 @@ void qdev_prop_register_global(GlobalProperty *pro=
p)
     global_props =3D g_list_append(global_props, prop);
 }
=20
-void register_compat_prop(const char *driver,
-                          const char *property,
-                          const char *value)
-{
-    GlobalProperty *p =3D g_new0(GlobalProperty, 1);
-
-    /* Any compat_props must never cause error */
-    p->errp =3D &error_abort;
-    p->driver =3D driver;
-    p->property =3D property;
-    p->value =3D value;
-    qdev_prop_register_global(p);
-}
-
-void register_compat_props_array(GlobalProperty *prop)
-{
-    for (; prop && prop->driver; prop++) {
-        register_compat_prop(prop->driver, prop->property, prop->value);
-    }
-}
-
 void qdev_prop_register_global_list(GlobalProperty *props)
 {
     int i;
--=20
2.19.0.271.gfe8321ec05
