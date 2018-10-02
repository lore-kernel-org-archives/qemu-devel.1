Received: from eggs.gnu.org ([2001:4830:134:3::10]:42883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAo-0003Pa-Jz
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAn-0007LT-Sj
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAn-0007Kn-It
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id y16so3820699wrw.3
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 14:25:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 23:25:14 +0200
Message-Id: <20181002212522.23303-6-f4bug@amsat.org>
In-Reply-To: <20181002212522.23303-1-f4bug@amsat.org>
References: <20181002212522.23303-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 05/12] hw/sh4/sh_pci: Use
 DeviceState::realize rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Move from the legacy SysBusDevice::init method to using DeviceState::realize.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sh4/sh_pci.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index 4ec2e35500..379d0685ed 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -120,16 +120,15 @@ static void sh_pci_set_irq(void *opaque, int irq_num, int level)
     qemu_set_irq(pic[irq_num], level);
 }
 
-static int sh_pci_device_init(SysBusDevice *dev)
+static void sh_pci_device_realize(DeviceState *dev, Error **errp)
 {
-    PCIHostState *phb;
-    SHPCIState *s;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SHPCIState *s = SH_PCI_HOST_BRIDGE(dev);
+    PCIHostState *phb = PCI_HOST_BRIDGE(s);
     int i;
 
-    s = SH_PCI_HOST_BRIDGE(dev);
-    phb = PCI_HOST_BRIDGE(s);
     for (i = 0; i < 4; i++) {
-        sysbus_init_irq(dev, &s->irq[i]);
+        sysbus_init_irq(sbd, &s->irq[i]);
     }
     phb->bus = pci_register_root_bus(DEVICE(dev), "pci",
                                      sh_pci_set_irq, sh_pci_map_irq,
@@ -143,13 +142,12 @@ static int sh_pci_device_init(SysBusDevice *dev)
                              &s->memconfig_p4, 0, 0x224);
     memory_region_init_alias(&s->isa, OBJECT(s), "sh_pci.isa",
                              get_system_io(), 0, 0x40000);
-    sysbus_init_mmio(dev, &s->memconfig_p4);
-    sysbus_init_mmio(dev, &s->memconfig_a7);
+    sysbus_init_mmio(sbd, &s->memconfig_p4);
+    sysbus_init_mmio(sbd, &s->memconfig_a7);
     s->iobr = 0xfe240000;
     memory_region_add_subregion(get_system_memory(), s->iobr, &s->isa);
 
     s->dev = pci_create_simple(phb->bus, PCI_DEVFN(0, 0), "sh_pci_host");
-    return 0;
 }
 
 static void sh_pci_host_realize(PCIDevice *d, Error **errp)
@@ -187,9 +185,9 @@ static const TypeInfo sh_pci_host_info = {
 
 static void sh_pci_device_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sdc->init = sh_pci_device_init;
+    dc->realize = sh_pci_device_realize;
 }
 
 static const TypeInfo sh_pci_device_info = {
-- 
2.19.0
