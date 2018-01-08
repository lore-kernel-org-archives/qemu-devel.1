Received: from eggs.gnu.org ([2001:4830:134:3::10]:51693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTC-0007VJ-6g
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTB-0003AU-9v
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:26 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:41726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTB-0003AA-50
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:25 -0500
Received: by mail-qt0-x242.google.com with SMTP id i40so12057254qti.8
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:47:24 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:51 -0300
Message-Id: <20180108024558.17983-23-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 22/29] piix3: extract piix3_init() from
 i440fx_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/southbridge/i82371_piix.h |  4 +++
 hw/pci-host/piix.c                   | 62 ++++++++++++++++++++----------------
 2 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/include/hw/southbridge/i82371_piix.h b/include/hw/southbridge/i82371_piix.h
index 8a5f9a7596..00a9f4d5b9 100644
--- a/include/hw/southbridge/i82371_piix.h
+++ b/include/hw/southbridge/i82371_piix.h
@@ -22,6 +22,10 @@
  */
 #define RCR_IOPORT 0xcf9
 
+/* piix.c */
+PCIDevice *piix3_init(PCIBus *bus, ISABus **isa_bus,
+                      qemu_irq *pic, int *piix3_devfn);
+
 /* piix4.c */
 extern PCIDevice *piix4_dev;
 
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 0bd22fa33a..6e8cea8372 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -27,6 +27,7 @@
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
+#include "hw/southbridge/i82371_piix.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
@@ -120,11 +121,6 @@ struct PCII440FXState {
  */
 #define I440FX_COREBOOT_RAM_SIZE 0x57
 
-static void piix3_set_irq(void *opaque, int pirq, int level);
-static PCIINTxRoute piix3_route_intx_pin_to_irq(void *opaque, int pci_intx);
-static void piix3_write_config_xen(PCIDevice *dev,
-                               uint32_t address, uint32_t val, int len);
-
 /* return the global irq number corresponding to a given device irq
    pin. We could also use the bus number to have a more precise
    mapping. */
@@ -353,7 +349,6 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
     PCIBus *b;
     PCIDevice *d;
     PCIHostState *s;
-    PIIX3State *piix3;
     PCII440FXState *f;
     unsigned i;
     I440FXState *i440fx;
@@ -406,28 +401,7 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
                  PAM_EXPAN_SIZE);
     }
 
-    /* Xen supports additional interrupt routes from the PCI devices to
-     * the IOAPIC: the four pins of each PCI device on the bus are also
-     * connected to the IOAPIC directly.
-     * These additional routes can be discovered through ACPI. */
-    if (xen_enabled()) {
-        PCIDevice *pci_dev = pci_create_simple_multifunction(b,
-                             -1, true, "PIIX3-xen");
-        piix3 = PIIX3_PCI_DEVICE(pci_dev);
-        pci_bus_irqs(b, xen_piix3_set_irq, xen_pci_slot_get_pirq,
-                piix3, XEN_PIIX_NUM_PIRQS);
-    } else {
-        PCIDevice *pci_dev = pci_create_simple_multifunction(b,
-                             -1, true, "PIIX3");
-        piix3 = PIIX3_PCI_DEVICE(pci_dev);
-        pci_bus_irqs(b, piix3_set_irq, pci_slot_get_pirq, piix3,
-                PIIX_NUM_PIRQS);
-        pci_bus_set_route_irq_fn(b, piix3_route_intx_pin_to_irq);
-    }
-    piix3->pic = pic;
-    *isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
-
-    *piix3_devfn = piix3->dev.devfn;
+    piix3_init(b, isa_bus, pic, piix3_devfn);
 
     ram_size = ram_size / 8 / 1024 / 1024;
     if (ram_size > 255) {
@@ -508,6 +482,38 @@ static PCIINTxRoute piix3_route_intx_pin_to_irq(void *opaque, int pin)
     return route;
 }
 
+PCIDevice *piix3_init(PCIBus *bus, ISABus **isa_bus,
+                      qemu_irq *pic, int *piix3_devfn)
+{
+    PCIDevice *pci_dev;
+    PIIX3State *piix3;
+
+    /* Xen supports additional interrupt routes from the PCI devices to
+     * the IOAPIC: the four pins of each PCI device on the bus are also
+     * connected to the IOAPIC directly.
+     * These additional routes can be discovered through ACPI. */
+    if (xen_enabled()) {
+        pci_dev = pci_create_simple_multifunction(bus,
+                             -1, true, "PIIX3-xen");
+        piix3 = PIIX3_PCI_DEVICE(pci_dev);
+        pci_bus_irqs(bus, xen_piix3_set_irq, xen_pci_slot_get_pirq,
+                piix3, XEN_PIIX_NUM_PIRQS);
+    } else {
+        pci_dev = pci_create_simple_multifunction(bus,
+                             -1, true, "PIIX3");
+        piix3 = PIIX3_PCI_DEVICE(pci_dev);
+        pci_bus_irqs(bus, piix3_set_irq, pci_slot_get_pirq, piix3,
+                PIIX_NUM_PIRQS);
+        pci_bus_set_route_irq_fn(bus, piix3_route_intx_pin_to_irq);
+    }
+    piix3->pic = pic;
+    *isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
+
+    *piix3_devfn = piix3->dev.devfn;
+
+    return pci_dev;
+}
+
 /* irq routing is changed. so rebuild bitmap */
 static void piix3_update_irq_levels(PIIX3State *piix3)
 {
-- 
2.15.1
