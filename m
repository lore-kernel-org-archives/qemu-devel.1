Received: from eggs.gnu.org ([2001:4830:134:3::10]:46461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAWpy-0007km-FB
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAWpk-0005c3-5n
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:00:54 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:29657)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAWpi-0005ah-Sx
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:00:40 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Thu, 11 Oct 2018 17:00:06 +0800
Message-Id: <20181011090007.1103-4-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181011090007.1103-1-maozhongyi@cmss.chinamobile.com>
References: <20181011090007.1103-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 3/4] audio: use object link instead of qdev
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

According to qdev-properties.h, properties of pointer type should
be avoided, it seems a link type property is a good substitution.

Cc: Jan Kiszka <jan.kiszka@web.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-arm@nongnu.org

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 hw/arm/musicpal.c          |  3 ++-
 hw/audio/marvell_88w8618.c | 14 ++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 3dafb41b0b..ac266f9253 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1695,7 +1695,8 @@ static void musicpal_init(MachineState *machine)
     wm8750_dev = i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
     dev = qdev_create(NULL, "mv88w8618_audio");
     s = SYS_BUS_DEVICE(dev);
-    qdev_prop_set_ptr(dev, TYPE_WM8750, wm8750_dev);
+    object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
+                             TYPE_WM8750, NULL);
     qdev_init_nofail(dev);
     sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
     sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index cf6ce6979b..baab4a3d53 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -15,6 +15,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/audio/wm8750.h"
 #include "audio/audio.h"
+#include "qapi/error.h"
 
 #define MP_AUDIO_SIZE           0x00001000
 
@@ -252,6 +253,11 @@ static void mv88w8618_audio_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &mv88w8618_audio_ops, s,
                           "audio", MP_AUDIO_SIZE);
     sysbus_init_mmio(dev, &s->iomem);
+
+    object_property_add_link(OBJECT(dev), "mv88w8618", TYPE_WM8750,
+                             (Object **) &s->wm,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, &error_abort);
 }
 
 static void mv88w8618_audio_realize(DeviceState *dev, Error **errp)
@@ -279,11 +285,6 @@ static const VMStateDescription mv88w8618_audio_vmsd = {
     }
 };
 
-static Property mv88w8618_audio_properties[] = {
-    DEFINE_PROP_PTR(TYPE_WM8750, mv88w8618_audio_state, wm),
-    {/* end of list */},
-};
-
 static void mv88w8618_audio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -291,9 +292,6 @@ static void mv88w8618_audio_class_init(ObjectClass *klass, void *data)
     dc->realize = mv88w8618_audio_realize;
     dc->reset = mv88w8618_audio_reset;
     dc->vmsd = &mv88w8618_audio_vmsd;
-    dc->props = mv88w8618_audio_properties;
-    /* Reason: pointer property "wm8750" */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo mv88w8618_audio_info = {
-- 
2.17.1
