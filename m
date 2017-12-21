Received: from eggs.gnu.org ([2001:4830:134:3::10]:50956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRw6C-0003ax-5i
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:21:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRw6B-0004NM-0j
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:21:04 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43114
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eRw6A-0004Md-QS
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:21:02 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 21 Dec 2017 08:20:35 +0000
Message-Id: <20171221082045.14022-7-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
References: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv3 06/16] apb: APB QOMify tidy-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Use DeviceClass rather than SysBusDeviceClass in pbm_host_class_init() and
adjust pci_pbm_init_device() accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/apb.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index b0f80f63eb..c7837efb7a 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -705,12 +705,12 @@ static const MemoryRegionOps pci_config_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static int pci_pbm_init_device(SysBusDevice *dev)
+static int pci_pbm_init_device(DeviceState *dev)
 {
-    APBState *s;
+    APBState *s = APB_DEVICE(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(s);
     unsigned int i;
 
-    s = APB_DEVICE(dev);
     for (i = 0; i < 8; i++) {
         s->pci_irq_map[i] = (0x1f << 6) | (i << 2);
     }
@@ -728,18 +728,18 @@ static int pci_pbm_init_device(SysBusDevice *dev)
     memory_region_init_io(&s->apb_config, OBJECT(s), &apb_config_ops, s,
                           "apb-config", 0x10000);
     /* at region 0 */
-    sysbus_init_mmio(dev, &s->apb_config);
+    sysbus_init_mmio(sbd, &s->apb_config);
 
     memory_region_init_io(&s->pci_config, OBJECT(s), &pci_config_ops, s,
                           "apb-pci-config", 0x1000000);
     /* at region 1 */
-    sysbus_init_mmio(dev, &s->pci_config);
+    sysbus_init_mmio(sbd, &s->pci_config);
 
     /* pci_ioport */
     memory_region_init(&s->pci_ioport, OBJECT(s), "apb-pci-ioport", 0x1000000);
 
     /* at region 2 */
-    sysbus_init_mmio(dev, &s->pci_ioport);
+    sysbus_init_mmio(sbd, &s->pci_ioport);
 
     return 0;
 }
@@ -783,11 +783,10 @@ static const TypeInfo pbm_pci_host_info = {
 static void pbm_host_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = pci_pbm_init_device;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->init = pci_pbm_init_device;
     dc->reset = pci_pbm_reset;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 static const TypeInfo pbm_host_info = {
-- 
2.11.0
