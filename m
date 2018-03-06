Received: from eggs.gnu.org ([2001:4830:134:3::10]:44144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJKE-0005Zh-MW
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJKD-00088X-QI
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:36:42 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 20:30:54 +0000
Message-Id: <20180306203103.25563-11-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 10/19] uninorth: fix PCI and AGP bus mixup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Somewhere in the history of time, the initialisation of the PCI buses for the
AGP and PCI host bridges got mixed up in that the PCI host bridge was
creating an instance of the AGP PCI bus, and the AGP PCI bus was missing.

Swap the PCI host bridge over to use the correct PCI bus (including setting
the kMacRISCPCIAddressSelect register used by MacOS X) and add the missing
reference to the AGP PCI bus.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/uninorth.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 426b3c4e33..1f6752c294 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -121,7 +121,7 @@ static void pci_unin_main_realize(DeviceState *dev, Error **errp)
                                    get_system_io(),
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
-    pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
+    pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-pci");
 
     /* DEC 21154 bridge */
 #if 0
@@ -195,6 +195,8 @@ static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
                                    &s->pci_mmio,
                                    get_system_io(),
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
+
+    pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
 }
 
 static void pci_unin_agp_init(Object *obj)
@@ -303,16 +305,6 @@ static void unin_main_pci_host_realize(PCIDevice *d, Error **errp)
     d->config[0x0D] = 0x10;
     /* capabilities_pointer */
     d->config[0x34] = 0x00;
-}
-
-static void unin_agp_pci_host_realize(PCIDevice *d, Error **errp)
-{
-    /* cache_line_size */
-    d->config[0x0C] = 0x08;
-    /* latency_timer */
-    d->config[0x0D] = 0x10;
-    /* capabilities_pointer
-    d->config[0x34] = 0x80; */
 
     /*
      * Set kMacRISCPCIAddressSelect (0x48) register to indicate PCI
@@ -325,6 +317,16 @@ static void unin_agp_pci_host_realize(PCIDevice *d, Error **errp)
     d->config[0x4b] = 0x1;
 }
 
+static void unin_agp_pci_host_realize(PCIDevice *d, Error **errp)
+{
+    /* cache_line_size */
+    d->config[0x0C] = 0x08;
+    /* latency_timer */
+    d->config[0x0D] = 0x10;
+    /* capabilities_pointer
+    d->config[0x34] = 0x80; */
+}
+
 static void u3_agp_pci_host_realize(PCIDevice *d, Error **errp)
 {
     /* cache line size */
-- 
2.11.0
