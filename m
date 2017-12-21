Received: from eggs.gnu.org ([2001:4830:134:3::10]:45200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1pS-0006t0-Rg
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1pR-0004so-D2
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1pR-0004sA-3T
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:09 -0500
Date: Thu, 21 Dec 2017 16:28:01 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-3-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/25] qdev-properties: add UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Roman Kagan <rkagan@virtuozzo.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Roman Kagan <rkagan@virtuozzo.com>

UUIDs (GUIDs) are widely used in VMBus-related stuff, so a dedicated
property type becomes helpful.

The property accepts a string-formatted UUID or a special keyword "auto"
meaning a randomly generated UUID; the latter is also the default when
the property is not given a value explicitly.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/qdev-properties.h |  9 +++++++
 hw/core/qdev-properties.c    | 61 ++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 70 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index e2321f1..97e810e 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -30,6 +30,7 @@ extern const PropertyInfo qdev_prop_vlan;
 extern const PropertyInfo qdev_prop_pci_devfn;
 extern const PropertyInfo qdev_prop_blocksize;
 extern const PropertyInfo qdev_prop_pci_host_devaddr;
+extern const PropertyInfo qdev_prop_uuid;
 extern const PropertyInfo qdev_prop_arraylen;
 extern const PropertyInfo qdev_prop_link;
=20
@@ -213,6 +214,14 @@ extern const PropertyInfo qdev_prop_link;
 #define DEFINE_PROP_MEMORY_REGION(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, MemoryRegion *)
=20
+#define DEFINE_PROP_UUID(_name, _state, _field) {                  \
+        .name      =3D (_name),                                      \
+        .info      =3D &qdev_prop_uuid,                              \
+        .offset    =3D offsetof(_state, _field)                      \
+            + type_check(QemuUUID, typeof_field(_state, _field)),  \
+        .set_default =3D true,                                       \
+        }
+
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
=20
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 1dc80fc..24c1780 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -10,6 +10,7 @@
 #include "net/hub.h"
 #include "qapi/visitor.h"
 #include "chardev/char.h"
+#include "qemu/uuid.h"
=20
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -883,6 +884,66 @@ const PropertyInfo qdev_prop_pci_host_devaddr =3D {
     .set =3D set_pci_host_devaddr,
 };
=20
+/* --- UUID --- */
+
+static void get_uuid(Object *obj, Visitor *v, const char *name, void *op=
aque,
+                     Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    QemuUUID *uuid =3D qdev_get_prop_ptr(dev, prop);
+    char buffer[UUID_FMT_LEN + 1];
+    char *p =3D buffer;
+
+    qemu_uuid_unparse(uuid, buffer);
+
+    visit_type_str(v, name, &p, errp);
+}
+
+#define UUID_VALUE_AUTO        "auto"
+
+static void set_uuid(Object *obj, Visitor *v, const char *name, void *op=
aque,
+                    Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    QemuUUID *uuid =3D qdev_get_prop_ptr(dev, prop);
+    Error *local_err =3D NULL;
+    char *str;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_str(v, name, &str, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (!strcmp(str, UUID_VALUE_AUTO)) {
+        qemu_uuid_generate(uuid);
+    } else if (qemu_uuid_parse(str, uuid) < 0) {
+        error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
+    }
+    g_free(str);
+}
+
+static void set_default_uuid_auto(Object *obj, const Property *prop)
+{
+    object_property_set_str(obj, UUID_VALUE_AUTO, prop->name, &error_abo=
rt);
+}
+
+const PropertyInfo qdev_prop_uuid =3D {
+    .name  =3D "str",
+    .description =3D "UUID (aka GUID) or \"" UUID_VALUE_AUTO
+        "\" for random value (default)",
+    .get   =3D get_uuid,
+    .set   =3D set_uuid,
+    .set_default_value =3D set_default_uuid_auto,
+};
+
 /* --- support for array properties --- */
=20
 /* Used as an opaque for the object properties we add for each
--=20
MST
