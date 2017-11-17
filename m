Received: from eggs.gnu.org ([2001:4830:134:3::10]:56520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eFgvF-0000of-3U
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eFgvD-0008VB-PT
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:43:09 -0500
Received: from chuckie.co.uk ([82.165.15.123]:59109
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eFgvD-0008T1-H2
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:43:07 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 17 Nov 2017 13:42:38 +0000
Message-Id: <1510926167-23326-7-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 06/15] apb: APB QOMify tidy-up
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
---
 hw/pci-host/apb.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index b0f80f6..c7837ef 100644
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
1.7.10.4
