Received: from eggs.gnu.org ([2001:4830:134:3::10]:42148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuF-0003f5-Ps
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuE-0007Oj-2W
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:43 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 15:11:10 +0100
Message-Id: <20180820141116.9118-17-peter.maydell@linaro.org>
In-Reply-To: <20180820141116.9118-1-peter.maydell@linaro.org>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 16/22] hw/ssi/pl022: Set up reset function in
 class init
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

Currently the PL022 calls pl022_reset() from its class init
function. Make it register a DeviceState reset method instead,
so that we reset the device on system reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/pl022.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index 379d3093987..0b5f90b857f 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -203,8 +203,10 @@ static void pl022_write(void *opaque, hwaddr offset,
     }
 }
 
-static void pl022_reset(PL022State *s)
+static void pl022_reset(DeviceState *dev)
 {
+    PL022State *s = PL022(dev);
+
     s->rx_fifo_len = 0;
     s->tx_fifo_len = 0;
     s->im = 0;
@@ -277,7 +279,6 @@ static int pl022_init(SysBusDevice *sbd)
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
     s->ssi = ssi_create_bus(dev, "ssi");
-    pl022_reset(s);
     vmstate_register(dev, -1, &vmstate_pl022, s);
     return 0;
 }
@@ -285,8 +286,10 @@ static int pl022_init(SysBusDevice *sbd)
 static void pl022_class_init(ObjectClass *klass, void *data)
 {
     SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     sdc->init = pl022_init;
+    dc->reset = pl022_reset;
 }
 
 static const TypeInfo pl022_info = {
-- 
2.18.0
