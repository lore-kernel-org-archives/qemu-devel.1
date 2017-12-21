Received: from eggs.gnu.org ([2001:4830:134:3::10]:45263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1pY-0006xM-I9
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1pV-0004vu-4L
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1pU-0004vM-Rn
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:13 -0500
Date: Thu, 21 Dec 2017 16:28:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-4-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/25] vmgenid: use UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Roman Kagan <rkagan@virtuozzo.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>

From: Roman Kagan <rkagan@virtuozzo.com>

Switch vmgenid device to use the UUID property type introduced in the
previous patch for its 'guid' property.

One semantic change it introduces is that post-realize modification of
'guid' via HMP or QMP will now be rejected with an error; however,
according to docs/specs/vmgenid.txt this is actually desirable.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Ben Warren <ben@skyportsystems.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/vmgenid.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 105044f..ba6f47b 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -162,21 +162,6 @@ static void vmgenid_update_guest(VmGenIdState *vms)
     }
 }
=20
-static void vmgenid_set_guid(Object *obj, const char *value, Error **err=
p)
-{
-    VmGenIdState *vms =3D VMGENID(obj);
-
-    if (!strcmp(value, "auto")) {
-        qemu_uuid_generate(&vms->guid);
-    } else if (qemu_uuid_parse(value, &vms->guid) < 0) {
-        error_setg(errp, "'%s. %s': Failed to parse GUID string: %s",
-                   object_get_typename(OBJECT(vms)), VMGENID_GUID, value=
);
-        return;
-    }
-
-    vmgenid_update_guest(vms);
-}
-
 /* After restoring an image, we need to update the guest memory and noti=
fy
  * it of a potential change to VM Generation ID
  */
@@ -224,23 +209,24 @@ static void vmgenid_realize(DeviceState *dev, Error=
 **errp)
     }
=20
     qemu_register_reset(vmgenid_handle_reset, vms);
+
+    vmgenid_update_guest(vms);
 }
=20
+static Property vmgenid_device_properties[] =3D {
+    DEFINE_PROP_UUID(VMGENID_GUID, VmGenIdState, guid),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void vmgenid_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->vmsd =3D &vmstate_vmgenid;
     dc->realize =3D vmgenid_realize;
+    dc->props =3D vmgenid_device_properties;
     dc->hotpluggable =3D false;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-
-    object_class_property_add_str(klass, VMGENID_GUID, NULL,
-                                  vmgenid_set_guid, NULL);
-    object_class_property_set_description(klass, VMGENID_GUID,
-                                    "Set Global Unique Identifier "
-                                    "(big-endian) or auto for random val=
ue",
-                                    NULL);
 }
=20
 static const TypeInfo vmgenid_device_info =3D {
--=20
MST
