Received: from eggs.gnu.org ([2001:4830:134:3::10]:49421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eIG2T-0004DW-AJ
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eIG2P-0004bw-Ed
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:37:13 -0500
Received: from mail-eopbgr40105.outbound.protection.outlook.com
	([40.107.4.105]:57962
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eIG2P-0004a7-6R
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:37:09 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 24 Nov 2017 18:36:55 +0300
Message-Id: <20171124153656.30199-2-rkagan@virtuozzo.com>
In-Reply-To: <20171124153656.30199-1-rkagan@virtuozzo.com>
References: <20171124153656.30199-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/2] qdev-properties: add UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Denis V. Lunev" <den@openvz.org>

UUIDs (GUIDs) are widely used in VMBus-related stuff, so a dedicated
property type becomes helpful.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 include/hw/qdev-properties.h |  3 +++
 hw/core/qdev-properties.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index e2321f1cc1..d4da7dd1f1 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -30,6 +30,7 @@ extern const PropertyInfo qdev_prop_vlan;
 extern const PropertyInfo qdev_prop_pci_devfn;
 extern const PropertyInfo qdev_prop_blocksize;
 extern const PropertyInfo qdev_prop_pci_host_devaddr;
+extern const PropertyInfo qdev_prop_uuid;
 extern const PropertyInfo qdev_prop_arraylen;
 extern const PropertyInfo qdev_prop_link;
 
@@ -212,6 +213,8 @@ extern const PropertyInfo qdev_prop_link;
     DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
 #define DEFINE_PROP_MEMORY_REGION(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, MemoryRegion *)
+#define DEFINE_PROP_UUID(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_uuid, QemuUUID)
 
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 1dc80fcea2..49fea5a40a 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -10,6 +10,7 @@
 #include "net/hub.h"
 #include "qapi/visitor.h"
 #include "chardev/char.h"
+#include "qemu/uuid.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -883,6 +884,57 @@ const PropertyInfo qdev_prop_pci_host_devaddr = {
     .set = set_pci_host_devaddr,
 };
 
+/* --- UUID --- */
+
+static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
+                     Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    QemuUUID *uuid = qdev_get_prop_ptr(dev, prop);
+    char buffer[UUID_FMT_LEN + 1];
+    char *p = buffer;
+
+    qemu_uuid_unparse(uuid, buffer);
+
+    visit_type_str(v, name, &p, errp);
+}
+
+static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
+                    Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    QemuUUID *uuid = qdev_get_prop_ptr(dev, prop);
+    Error *local_err = NULL;
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
+    if (!strcmp(str, "auto")) {
+        qemu_uuid_generate(uuid);
+    } else if (qemu_uuid_parse(str, uuid) < 0) {
+        error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
+    }
+    g_free(str);
+}
+
+const PropertyInfo qdev_prop_uuid = {
+    .name  = "str",
+    .description = "UUID (aka GUID) or \"auto\" for random value",
+    .get   = get_uuid,
+    .set   = set_uuid,
+};
+
 /* --- support for array properties --- */
 
 /* Used as an opaque for the object properties we add for each
-- 
2.14.3
