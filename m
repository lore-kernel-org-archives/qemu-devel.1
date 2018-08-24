Received: from eggs.gnu.org ([2001:4830:134:3::10]:35808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UL-0007gn-L2
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UK-0004oJ-Oi
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8UI-0004PP-Ou
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:38 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8U7-0006bG-Lu
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:27 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:27 +0100
Message-Id: <20180824093343.11346-37-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 36/52] hw/ssi/pl022: Use DeviceState::realize
 rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Move from the legacy SysBusDevice::init method to using
DeviceState::realize.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180820141116.9118-19-peter.maydell@linaro.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
