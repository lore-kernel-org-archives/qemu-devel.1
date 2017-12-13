Received: from eggs.gnu.org ([2001:4830:134:3::10]:39527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDuJ-0004Xq-EI
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDuI-0007LI-8y
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:35 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 17:44:35 -0300
Message-Id: <20171213204436.5379-11-f4bug@amsat.org>
In-Reply-To: <20171213204436.5379-1-f4bug@amsat.org>
References: <20171213204436.5379-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/11] hw/sd/pxa2xx: implement the
 SD_BUS_MASTER interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Andrzej Zaborowski <balrogg@gmail.com>

This MMC Interface is a SD bus master.
Replace qbus_create_inplace() by sdbus_create_bus(),
remove the PXA2XX_MMCI_BUS type.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/pxa2xx_mmci.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index f34951e1d1..da5f302f3c 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -24,9 +24,6 @@
 #define TYPE_PXA2XX_MMCI "pxa2xx-mmci"
 #define PXA2XX_MMCI(obj) OBJECT_CHECK(PXA2xxMMCIState, (obj), TYPE_PXA2XX_MMCI)
 
-#define TYPE_PXA2XX_MMCI_BUS "pxa2xx-mmci-bus"
-#define PXA2XX_MMCI_BUS(obj) OBJECT_CHECK(SDBus, (obj), TYPE_PXA2XX_MMCI_BUS)
-
 struct PXA2xxMMCIState {
     SysBusDevice parent_obj;
 
@@ -38,7 +35,7 @@ struct PXA2xxMMCIState {
     qemu_irq readonly;
 
     BlockBackend *blk;
-    SDBus sdbus;
+    SDBus *sdbus;
 
     uint32_t status;
     uint32_t clkrt;
@@ -183,7 +180,7 @@ static void pxa2xx_mmci_fifo_update(PXA2xxMMCIState *s)
 
     if (s->cmdat & CMDAT_WR_RD) {
         while (s->bytesleft && s->tx_len) {
-            sdbus_write_data(&s->sdbus, s->tx_fifo[s->tx_start++]);
+            sdbus_write_data(s->sdbus, s->tx_fifo[s->tx_start++]);
             s->tx_start &= 0x1f;
             s->tx_len --;
             s->bytesleft --;
@@ -193,7 +190,7 @@ static void pxa2xx_mmci_fifo_update(PXA2xxMMCIState *s)
     } else
         while (s->bytesleft && s->rx_len < 32) {
             s->rx_fifo[(s->rx_start + (s->rx_len ++)) & 0x1f] =
-                sdbus_read_data(&s->sdbus);
+                sdbus_read_data(s->sdbus);
             s->bytesleft --;
             s->intreq |= INT_RXFIFO_REQ;
         }
@@ -227,7 +224,7 @@ static void pxa2xx_mmci_wakequeues(PXA2xxMMCIState *s)
     request.arg = s->arg;
     request.crc = 0;	/* FIXME */
 
-    rsplen = sdbus_do_command(&s->sdbus, &request, response);
+    rsplen = sdbus_do_command(s->sdbus, &request, response);
     s->intreq |= INT_END_CMD;
 
     memset(s->resp_fifo, 0, sizeof(s->resp_fifo));
@@ -509,8 +506,8 @@ void pxa2xx_mmci_handlers(PXA2xxMMCIState *s, qemu_irq readonly,
     s->readonly = readonly;
     s->inserted = coverswitch;
 
-    pxa2xx_mmci_set_inserted(dev, sdbus_get_inserted(&s->sdbus));
-    pxa2xx_mmci_set_readonly(dev, sdbus_get_readonly(&s->sdbus));
+    pxa2xx_mmci_set_inserted(dev, sdbus_get_inserted(s->sdbus));
+    pxa2xx_mmci_set_readonly(dev, sdbus_get_readonly(s->sdbus));
 }
 
 static void pxa2xx_mmci_reset(DeviceState *d)
@@ -555,21 +552,16 @@ static void pxa2xx_mmci_instance_init(Object *obj)
     qdev_init_gpio_out_named(dev, &s->rx_dma, "rx-dma", 1);
     qdev_init_gpio_out_named(dev, &s->tx_dma, "tx-dma", 1);
 
-    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
-                        TYPE_PXA2XX_MMCI_BUS, DEVICE(obj), "sd-bus");
+    s->sdbus = sdbus_create_bus(dev, "sd-bus");
 }
 
 static void pxa2xx_mmci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    SDBusClass *sbc = SDBUS_MASTER_CLASS(klass);
 
     dc->vmsd = &vmstate_pxa2xx_mmci;
     dc->reset = pxa2xx_mmci_reset;
-}
-
-static void pxa2xx_mmci_bus_class_init(ObjectClass *klass, void *data)
-{
-    SDBusClass *sbc = SD_BUS_CLASS(klass);
 
     sbc->set_inserted = pxa2xx_mmci_set_inserted;
     sbc->set_readonly = pxa2xx_mmci_set_readonly;
@@ -581,19 +573,15 @@ static const TypeInfo pxa2xx_mmci_info = {
     .instance_size = sizeof(PXA2xxMMCIState),
     .instance_init = pxa2xx_mmci_instance_init,
     .class_init = pxa2xx_mmci_class_init,
-};
-
-static const TypeInfo pxa2xx_mmci_bus_info = {
-    .name = TYPE_PXA2XX_MMCI_BUS,
-    .parent = TYPE_SD_BUS,
-    .instance_size = sizeof(SDBus),
-    .class_init = pxa2xx_mmci_bus_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_SD_BUS_MASTER_INTERFACE },
+        { },
+    },
 };
 
 static void pxa2xx_mmci_register_types(void)
 {
     type_register_static(&pxa2xx_mmci_info);
-    type_register_static(&pxa2xx_mmci_bus_info);
 }
 
 type_init(pxa2xx_mmci_register_types)
-- 
2.15.1
