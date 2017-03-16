Received: from eggs.gnu.org ([2001:4830:134:3::10]:48488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coJf8-00067i-OM
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coJf7-0006n1-56
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:53:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1coJf6-0006ms-VC
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:53:05 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 15 Mar 2017 20:52:57 -0400
Message-Id: <20170316005259.21970-2-jsnow@redhat.com>
In-Reply-To: <20170316005259.21970-1-jsnow@redhat.com>
References: <20170316005259.21970-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-rc1 1/3] ide: qdev: register ide bus
 unrealize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Li Qiang <liq3ea@gmail.com>, Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liq3ea@gmail.com>

we have an idebus unrealize function, but it was being
registered as the unrealize function for the IDE Device,
so it was not getting invoked on device teardown because
nothing is "unrealizing" the IDE devices themselves.

Suggested-by: John Snow <jsnow@redhat.com>
Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 1488449293-80280-2-git-send-email-liqiang6-s@360.cn
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/qdev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 4383cd1..299e592 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -31,7 +31,7 @@
 /* --------------------------------- */
=20
 static char *idebus_get_fw_dev_path(DeviceState *dev);
-static void idebus_unrealize(DeviceState *qdev, Error **errp);
+static void idebus_unrealize(BusState *qdev, Error **errp);
=20
 static Property ide_props[] =3D {
     DEFINE_PROP_UINT32("unit", IDEDevice, unit, -1),
@@ -43,14 +43,15 @@ static void ide_bus_class_init(ObjectClass *klass, vo=
id *data)
     BusClass *k =3D BUS_CLASS(klass);
=20
     k->get_fw_dev_path =3D idebus_get_fw_dev_path;
+    k->unrealize =3D idebus_unrealize;
 }
=20
-static void idebus_unrealize(DeviceState *qdev, Error **errp)
+static void idebus_unrealize(BusState *bus, Error **errp)
 {
-    IDEBus *bus =3D DO_UPCAST(IDEBus, qbus, qdev->parent_bus);
+    IDEBus *ibus =3D IDE_BUS(bus);
=20
-    if (bus->vmstate) {
-        qemu_del_vm_change_state_handler(bus->vmstate);
+    if (ibus->vmstate) {
+        qemu_del_vm_change_state_handler(ibus->vmstate);
     }
 }
=20
@@ -370,7 +371,6 @@ static void ide_device_class_init(ObjectClass *klass,=
 void *data)
     k->init =3D ide_qdev_init;
     set_bit(DEVICE_CATEGORY_STORAGE, k->categories);
     k->bus_type =3D TYPE_IDE_BUS;
-    k->unrealize =3D idebus_unrealize;
     k->props =3D ide_props;
 }
=20
--=20
2.9.3
