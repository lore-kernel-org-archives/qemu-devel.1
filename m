Received: from eggs.gnu.org ([2001:4830:134:3::10]:42134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuF-0003eZ-A2
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuE-0007P4-Eh
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:43 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 15:11:12 +0100
Message-Id: <20180820141116.9118-19-peter.maydell@linaro.org>
In-Reply-To: <20180820141116.9118-1-peter.maydell@linaro.org>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 18/22] hw/ssi/pl022: Use DeviceState::realize
 rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Move from the legacy SysBusDevice::init method to using
DeviceState::realize.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/pl022.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index c9989537062..3ac57f4c96a 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -270,26 +270,24 @@ static const VMStateDescription vmstate_pl022 = {
     }
 };
 
-static int pl022_init(SysBusDevice *sbd)
+static void pl022_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev = DEVICE(sbd);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     PL022State *s = PL022(dev);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &pl022_ops, s, "pl022", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
     s->ssi = ssi_create_bus(dev, "ssi");
-    return 0;
 }
 
 static void pl022_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sdc->init = pl022_init;
     dc->reset = pl022_reset;
     dc->vmsd = &vmstate_pl022;
+    dc->realize = pl022_realize;
 }
 
 static const TypeInfo pl022_info = {
-- 
2.18.0
