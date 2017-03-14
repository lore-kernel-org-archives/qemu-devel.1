Received: from eggs.gnu.org ([2001:4830:134:3::10]:48949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cne2f-0007S3-7O
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 00:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cne2c-00079u-4v
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 00:26:37 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 14 Mar 2017 15:26:25 +1100
Message-Id: <20170314042626.20020-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170314042626.20020-1-david@gibson.dropbear.id.au>
References: <20170314042626.20020-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 3/4] pseries: Don't expose PCIe extended config
 space on older machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, pbonzini@redhat.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

bb9986452 "spapr_pci: Advertise access to PCIe extended config space"
allowed guests to access the extended config space of PCI Express devices
via the PAPR interfaces, even though the paravirtualized bus mostly acts
like plain PCI.

However, that patch enabled access unconditionally, including for existing
machine types, which is an unwise change in behaviour.  This patch limits
the change to pseries-2.9 (and later) machine types.

Suggested-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              | 9 +++++++--
 hw/ppc/spapr_pci.c          | 4 +++-
 include/hw/pci-host/spapr.h | 2 ++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c3bb991..6ee566d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3163,8 +3163,13 @@ DEFINE_SPAPR_MACHINE(2_9, "2.9", true);
 /*
  * pseries-2.8
  */
-#define SPAPR_COMPAT_2_8                            \
-    HW_COMPAT_2_8
+#define SPAPR_COMPAT_2_8                                        \
+    HW_COMPAT_2_8                                               \
+    {                                                           \
+        .driver   = TYPE_SPAPR_PCI_HOST_BRIDGE,                 \
+        .property = "pcie-extended-configuration-space",        \
+        .value    = "off",                                      \
+    },
 
 static void spapr_machine_2_8_instance_options(MachineState *machine)
 {
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 919d3c2..98c52e4 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1321,7 +1321,7 @@ static int spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
     _FDT(fdt_setprop(fdt, offset, "assigned-addresses",
                      (uint8_t *)rp.assigned, rp.assigned_len));
 
-    if (pci_is_express(dev)) {
+    if (sphb->pcie_ecs && pci_is_express(dev)) {
         _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", 0x1));
     }
 
@@ -1858,6 +1858,8 @@ static Property spapr_phb_properties[] = {
     DEFINE_PROP_UINT32("numa_node", sPAPRPHBState, numa_node, -1),
     DEFINE_PROP_BOOL("pre-2.8-migration", sPAPRPHBState,
                      pre_2_8_migration, false),
+    DEFINE_PROP_BOOL("pcie-extended-configuration-space", sPAPRPHBState,
+                     pcie_ecs, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index dfa7614..1c2e970 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -80,6 +80,8 @@ struct sPAPRPHBState {
 
     uint32_t numa_node;
 
+    bool pcie_ecs; /* Allow access to PCIe extended config space? */
+
     /* Fields for migration compatibility hacks */
     bool pre_2_8_migration;
     uint32_t mig_liobn;
-- 
2.9.3
