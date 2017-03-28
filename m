Received: from eggs.gnu.org ([2001:4830:134:3::10]:33332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csggy-0007oS-Ij
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csggv-0004xC-EI
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:17:04 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 28 Mar 2017 13:16:50 +1100
Message-Id: <20170328021651.19350-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170328021651.19350-1-david@gibson.dropbear.id.au>
References: <20170328021651.19350-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC for-2.10 2/3] pci: Allow host bridges to override
 PCI/PCIe hybrid device behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, aik@ozlabs.ru, marcel@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lersek@redhat.com, David Gibson <david@gibson.dropbear.id.au>

Currently PCI/PCIe hybrid devices - that is, devices which can appear as
either plain PCI or PCIe depending on where they're attached - will only
appear in PCIe mode if they're attached to a PCIe bus via a root port or
downstream port.

This is correct for "standard" PCIe setups, but there are some platforms
which need different behaviour (notably "pseries" whose paravirtualized
PCI host bridges have some idiosyncracies).

This patch allows the host bridge to override the normal behaviour.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci/pci.c              | 11 +++++++++--
 include/hw/pci/pci_host.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 779787b..ac68065 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -392,9 +392,16 @@ bool pci_bus_is_root(PCIBus *bus)
 
 bool pci_allow_hybrid_pcie(PCIDevice *pci_dev)
 {
-    PCIBus *bus = pci_dev->bus;
+    PCIHostState *host_bridge = PCI_HOST_BRIDGE(pci_device_root_bus(pci_dev)->qbus.parent);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_GET_CLASS(host_bridge);
+
+    if (hc->allow_hybrid_pcie) {
+        return hc->allow_hybrid_pcie(host_bridge, pci_dev);
+    } else {
+        PCIBus *bus = pci_dev->bus;
 
-    return pci_bus_is_express(bus) && !pci_bus_is_root(bus);
+        return pci_bus_is_express(bus) && !pci_bus_is_root(bus);
+    }
 }
 
 void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index ba31595..ad03cca 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -54,6 +54,7 @@ typedef struct PCIHostBridgeClass {
     SysBusDeviceClass parent_class;
 
     const char *(*root_bus_path)(PCIHostState *, PCIBus *);
+    bool (*allow_hybrid_pcie)(PCIHostState *, PCIDevice *);
 } PCIHostBridgeClass;
 
 /* common internal helpers for PCI/PCIe hosts, cut off overflows */
-- 
2.9.3
