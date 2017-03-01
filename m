Received: from eggs.gnu.org ([2001:4830:134:3::10]:46487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7o-00082a-BX
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7l-00006J-GX
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:28 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:39 +1100
Message-Id: <20170301044405.1792-25-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 24/50] spapr/pci: populate PCI DT in reverse
 order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, Greg Kurz <gkurz@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <gkurz@linux.vnet.ibm.com>

Since commit 1d2d974244c6 "spapr_pci: enumerate and add PCI device tree", QEMU
populates the PCI device tree in the opposite order compared to SLOF.

Before 1d2d974244c6:

Populating /pci@800000020000000
                     00 0000 (D) : 1af4 1000    virtio [ net ]
                     00 0800 (D) : 1af4 1001    virtio [ block ]
                     00 1000 (D) : 1af4 1009    virtio [ network ]
Populating /pci@800000020000000/unknown-legacy-device@2

7e5294b8 :  /pci@800000020000000
7e52b998 :  |-- ethernet@0
7e52c0c8 :  |-- scsi@1
7e52c7e8 :  +-- unknown-legacy-device@2 ok

Since 1d2d974244c6:

Populating /pci@800000020000000
                     00 1000 (D) : 1af4 1009    virtio [ network ]
Populating /pci@800000020000000/unknown-legacy-device@2
                     00 0800 (D) : 1af4 1001    virtio [ block ]
                     00 0000 (D) : 1af4 1000    virtio [ net ]

7e5e8118 :  /pci@800000020000000
7e5ea6a0 :  |-- unknown-legacy-device@2
7e5eadb8 :  |-- scsi@1
7e5eb4d8 :  +-- ethernet@0 ok

This behaviour change is not actually a bug since no assumptions should be
made on DT ordering. But it has no real justification either, other than
being the consequence of the way fdt_add_subnode() inserts new elements
to the front of the FDT rather than adding them to the tail.

This patch reverts to the historical SLOF ordering by walking PCI devices
in reverse order. This reconciles pseries with x86 machine types behavior.
It is expected to make things easier when porting existing applications to
power.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
(slight update to the changelog)
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci/pci.c         | 28 ++++++++++++++++++++++++++++
 hw/ppc/spapr_pci.c   | 12 ++++++------
 include/hw/pci/pci.h |  4 ++++
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index a563555..273f1e4 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1530,6 +1530,34 @@ static const pci_class_desc pci_class_descriptions[] =
     { 0, NULL}
 };
 
+static void pci_for_each_device_under_bus_reverse(PCIBus *bus,
+                                                  void (*fn)(PCIBus *b,
+                                                             PCIDevice *d,
+                                                             void *opaque),
+                                                  void *opaque)
+{
+    PCIDevice *d;
+    int devfn;
+
+    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        d = bus->devices[ARRAY_SIZE(bus->devices) - 1 - devfn];
+        if (d) {
+            fn(bus, d, opaque);
+        }
+    }
+}
+
+void pci_for_each_device_reverse(PCIBus *bus, int bus_num,
+                         void (*fn)(PCIBus *b, PCIDevice *d, void *opaque),
+                         void *opaque)
+{
+    bus = pci_find_bus_nr(bus, bus_num);
+
+    if (bus) {
+        pci_for_each_device_under_bus_reverse(bus, fn, opaque);
+    }
+}
+
 static void pci_for_each_device_under_bus(PCIBus *bus,
                                           void (*fn)(PCIBus *b, PCIDevice *d,
                                                      void *opaque),
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 1c4fa8b..84a0f31 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2044,9 +2044,9 @@ static void spapr_populate_pci_devices_dt(PCIBus *bus, PCIDevice *pdev,
     s_fdt.fdt = p->fdt;
     s_fdt.node_off = offset;
     s_fdt.sphb = p->sphb;
-    pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
-                        spapr_populate_pci_devices_dt,
-                        &s_fdt);
+    pci_for_each_device_reverse(sec_bus, pci_bus_num(sec_bus),
+                                spapr_populate_pci_devices_dt,
+                                &s_fdt);
 }
 
 static void spapr_phb_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
@@ -2215,9 +2215,9 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
     s_fdt.fdt = fdt;
     s_fdt.node_off = bus_off;
     s_fdt.sphb = phb;
-    pci_for_each_device(bus, pci_bus_num(bus),
-                        spapr_populate_pci_devices_dt,
-                        &s_fdt);
+    pci_for_each_device_reverse(bus, pci_bus_num(bus),
+                                spapr_populate_pci_devices_dt,
+                                &s_fdt);
 
     ret = spapr_drc_populate_dt(fdt, bus_off, OBJECT(phb),
                                 SPAPR_DR_CONNECTOR_TYPE_PCI);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 6983f13..9349acb 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -429,6 +429,10 @@ int pci_bus_numa_node(PCIBus *bus);
 void pci_for_each_device(PCIBus *bus, int bus_num,
                          void (*fn)(PCIBus *bus, PCIDevice *d, void *opaque),
                          void *opaque);
+void pci_for_each_device_reverse(PCIBus *bus, int bus_num,
+                                 void (*fn)(PCIBus *bus, PCIDevice *d,
+                                            void *opaque),
+                                 void *opaque);
 void pci_for_each_bus_depth_first(PCIBus *bus,
                                   void *(*begin)(PCIBus *bus, void *parent_state),
                                   void (*end)(PCIBus *bus, void *state),
-- 
2.9.3
