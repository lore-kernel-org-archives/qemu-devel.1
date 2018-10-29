Received: from eggs.gnu.org ([2001:4830:134:3::10]:60391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH7jo-00019Z-U0
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH7jn-0004f0-PO
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:37:48 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Oct 2018 14:37:21 +0100
Message-Id: <20181029133722.12415-4-kraxel@redhat.com>
In-Reply-To: <20181029133722.12415-1-kraxel@redhat.com>
References: <20181029133722.12415-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] audio: use object link instead of qdev
 property to pass wm8750 reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@web.de>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

According to qdev-properties.h, properties of pointer type should
be avoided, it seems a link type property is a good substitution.

Cc: Jan Kiszka <jan.kiszka@web.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181022074050.19638-3-maozhongyi@cmss.chinamobile.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/arm/musicpal.c          |  3 ++-
 hw/audio/marvell_88w8618.c | 13 ++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 3dafb41b0b..ac266f9253 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1695,7 +1695,8 @@ static void musicpal_init(MachineState *machine)
     wm8750_dev =3D i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
     dev =3D qdev_create(NULL, "mv88w8618_audio");
     s =3D SYS_BUS_DEVICE(dev);
-    qdev_prop_set_ptr(dev, TYPE_WM8750, wm8750_dev);
+    object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
+                             TYPE_WM8750, NULL);
     qdev_init_nofail(dev);
     sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
     sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index cf6ce6979b..1c7080e844 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -15,6 +15,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/audio/wm8750.h"
 #include "audio/audio.h"
+#include "qapi/error.h"
=20
 #define MP_AUDIO_SIZE           0x00001000
=20
@@ -252,6 +253,11 @@ static void mv88w8618_audio_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &mv88w8618_audio_ops, s,
                           "audio", MP_AUDIO_SIZE);
     sysbus_init_mmio(dev, &s->iomem);
+
+    object_property_add_link(OBJECT(dev), "wm8750", TYPE_WM8750,
+                             (Object **) &s->wm,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, &error_abort);
 }
=20
 static void mv88w8618_audio_realize(DeviceState *dev, Error **errp)
@@ -279,11 +285,6 @@ static const VMStateDescription mv88w8618_audio_vmsd=
 =3D {
     }
 };
=20
-static Property mv88w8618_audio_properties[] =3D {
-    DEFINE_PROP_PTR(TYPE_WM8750, mv88w8618_audio_state, wm),
-    {/* end of list */},
-};
-
 static void mv88w8618_audio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -291,8 +292,6 @@ static void mv88w8618_audio_class_init(ObjectClass *k=
lass, void *data)
     dc->realize =3D mv88w8618_audio_realize;
     dc->reset =3D mv88w8618_audio_reset;
     dc->vmsd =3D &mv88w8618_audio_vmsd;
-    dc->props =3D mv88w8618_audio_properties;
-    /* Reason: pointer property "wm8750" */
     dc->user_creatable =3D false;
 }
=20
--=20
2.9.3
