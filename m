Received: from eggs.gnu.org ([2001:4830:134:3::10]:56685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0bRd-0000oF-UD
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0bRc-0002XH-Lg
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:17:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 18 Apr 2017 19:17:22 -0300
Message-Id: <20170418221724.5707-5-ehabkost@redhat.com>
In-Reply-To: <20170418221724.5707-1-ehabkost@redhat.com>
References: <20170418221724.5707-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v2 4/6] pci: Manually simplify QOM casts at
 pci_host_bus_init*() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Aurelien Jarno <aurelien@aurel32.net>, qemu-ppc@nongnu.org

Those redundant casts were not detected by the Coccinelle patch because
there are multiple variables and casts involved. Fix them manually.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/pci-host/q35.c      | 2 +-
 hw/pci-host/uninorth.c | 2 +-
 hw/ppc/spapr_pci.c     | 2 +-
 hw/sh4/sh_pci.c        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 947dc3f124..4258076979 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -49,7 +49,7 @@ static void q35_host_realize(DeviceState *dev, Error **errp)
     sysbus_add_io(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, &pci->data_mem);
     sysbus_init_ioports(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, 4);
 
-    pci->bus = pci_host_bus_init(PCI_HOST_BRIDGE(s), "pcie.0",
+    pci->bus = pci_host_bus_init(pci, "pcie.0",
                                  s->mch.pci_address_space,
                                  s->mch.address_space_io, 0, TYPE_PCIE_BUS);
     PC_MACHINE(qdev_get_machine())->bus = pci->bus;
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 079faad6ff..d9fb5fdc93 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -233,7 +233,7 @@ PCIBus *pci_pmac_init(qemu_irq *pic,
     memory_region_add_subregion(address_space_mem, 0x80000000ULL,
                                 &d->pci_hole);
 
-    h->bus = pci_host_bus_init_irqs(PCI_HOST_BRIDGE(dev), NULL,
+    h->bus = pci_host_bus_init_irqs(h, NULL,
                                     pci_unin_set_irq, pci_unin_map_irq, pic,
                                     &d->pci_mmio, address_space_io,
                                     PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7f29cc77b0..ce132c5eea 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1697,7 +1697,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
                                 &sphb->iowindow);
 
-    bus = pci_host_bus_init_irqs(PCI_HOST_BRIDGE(dev), NULL,
+    bus = pci_host_bus_init_irqs(phb, NULL,
                                  pci_spapr_set_irq, pci_spapr_map_irq, sphb,
                                  &sphb->memspace, &sphb->iospace,
                                  PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS);
diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index f589b1628e..8be2e830e9 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -131,7 +131,7 @@ static int sh_pci_device_init(SysBusDevice *dev)
     for (i = 0; i < 4; i++) {
         sysbus_init_irq(dev, &s->irq[i]);
     }
-    phb->bus = pci_host_bus_init_irqs(PCI_HOST_BRIDGE(dev), "pci",
+    phb->bus = pci_host_bus_init_irqs(phb, "pci",
                                       sh_pci_set_irq, sh_pci_map_irq, s->irq,
                                       get_system_memory(), get_system_io(),
                                       PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
-- 
2.11.0.259.g40922b1
