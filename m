Received: from eggs.gnu.org ([2001:4830:134:3::10]:39795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eJJ6N-0004XY-Br
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eJJ6L-00019c-42
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:05:35 -0500
Received: from mail-eopbgr20114.outbound.protection.outlook.com
	([40.107.2.114]:24928
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eJJ6K-00017r-S8
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:05:33 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon, 27 Nov 2017 16:05:18 +0300
Message-Id: <20171127130518.26703-3-rkagan@virtuozzo.com>
In-Reply-To: <20171127130518.26703-1-rkagan@virtuozzo.com>
References: <20171127130518.26703-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/2] vmgenid: use UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Denis V. Lunev" <den@openvz.org>, minyard@acm.org, "Daniel P. Berrange" <berrange@redhat.com>

Switch vmgenid device to use the UUID property type introduced in the
previous patch for its 'guid' property.

One semantic change it introduces is that post-realize modification of
'guid' via HMP or QMP will now be rejected with an error; however,
according to docs/specs/vmgenid.txt this is actually desirable.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
v1 -> v2:
 - use the corresponding define for "guid" field name

 hw/acpi/vmgenid.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 105044f666..ba6f47b67b 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -162,21 +162,6 @@ static void vmgenid_update_guest(VmGenIdState *vms)
     }
 }
 
-static void vmgenid_set_guid(Object *obj, const char *value, Error **errp)
-{
-    VmGenIdState *vms = VMGENID(obj);
-
-    if (!strcmp(value, "auto")) {
-        qemu_uuid_generate(&vms->guid);
-    } else if (qemu_uuid_parse(value, &vms->guid) < 0) {
-        error_setg(errp, "'%s. %s': Failed to parse GUID string: %s",
-                   object_get_typename(OBJECT(vms)), VMGENID_GUID, value);
-        return;
-    }
-
-    vmgenid_update_guest(vms);
-}
-
 /* After restoring an image, we need to update the guest memory and notify
  * it of a potential change to VM Generation ID
  */
@@ -224,23 +209,24 @@ static void vmgenid_realize(DeviceState *dev, Error **errp)
     }
 
     qemu_register_reset(vmgenid_handle_reset, vms);
+
+    vmgenid_update_guest(vms);
 }
 
+static Property vmgenid_device_properties[] = {
+    DEFINE_PROP_UUID(VMGENID_GUID, VmGenIdState, guid),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void vmgenid_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_vmgenid;
     dc->realize = vmgenid_realize;
+    dc->props = vmgenid_device_properties;
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-
-    object_class_property_add_str(klass, VMGENID_GUID, NULL,
-                                  vmgenid_set_guid, NULL);
-    object_class_property_set_description(klass, VMGENID_GUID,
-                                    "Set Global Unique Identifier "
-                                    "(big-endian) or auto for random value",
-                                    NULL);
 }
 
 static const TypeInfo vmgenid_device_info = {
-- 
2.14.3
