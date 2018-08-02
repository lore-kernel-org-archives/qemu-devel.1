Received: from eggs.gnu.org ([2001:4830:134:3::10]:44586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fl3a9-0001OK-SO
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fl3a8-0007Rd-JN
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:43:17 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fl3a8-0007QT-96
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:43:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id e7-v6so522916wrs.9
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 19:43:16 -0700 (PDT)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Thu,  2 Aug 2018 10:42:23 +0800
Message-Id: <1533177743-20894-7-git-send-email-whois.zihan.yang@gmail.com>
In-Reply-To: <1533177743-20894-1-git-send-email-whois.zihan.yang@gmail.com>
References: <1533177743-20894-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC v3 6/6] pci_expander_bridge: add start_bus
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>

The former bus_nr property indicates the bus number of pxb-pcie device on
pcie.0 bus, not the Base Bus Number of pxb-pcie host bridge. Use start_bus
property to represent this BBN when building acpi table

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 hw/i386/acpi-build.c                        | 22 +++++++++++-----------
 hw/pci-bridge/pci_expander_bridge.c         | 25 ++++++++++++++-----------
 include/hw/pci-bridge/pci_expander_bridge.h |  2 +-
 3 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4b6ef78..874e0fa 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -91,7 +91,7 @@ typedef struct AcpiMcfgInfo {
     uint64_t mcfg_base;
     uint32_t mcfg_size;
     uint32_t domain_nr;
-    uint8_t bus_nr; // start bus number
+    uint8_t start_bus; // start bus number
     struct AcpiMcfgInfo *next;
 } AcpiMcfgInfo;
 
@@ -2129,7 +2129,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         QObject *o;
         PCIBus *bus = NULL;
         uint32_t domain_nr;
-        uint8_t bus_nr;
+        uint8_t start_bus;
         int index = 0;
 
         pci_host = acpi_get_i386_pci_host();
@@ -2145,12 +2145,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             domain_nr = qnum_get_uint(qobject_to(QNum, o));
             qobject_unref(o);
 
-            o = object_property_get_qobject(pci_host, "bus_nr", NULL);
+            o = object_property_get_qobject(pci_host, "start_bus", NULL);
             if (!o) {
                 /* we are in q35 host */
-                bus_nr = 0;
+                start_bus = 0;
             } else {
-                bus_nr = qnum_get_uint(qobject_to(QNum, o));
+                start_bus = qnum_get_uint(qobject_to(QNum, o));
                 qobject_unref(o);
             }
 
@@ -2158,7 +2158,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             if (bus) {
                 Aml *scope = aml_scope("PCI%d", index);
                 aml_append(scope, aml_name_decl("_SEG", aml_int(domain_nr)));
-                aml_append(scope, aml_name_decl("_BBN", aml_int(bus_nr)));
+                aml_append(scope, aml_name_decl("_BBN", aml_int(start_bus)));
                 /* Scan all PCI buses. Generate tables to support hotplug. */
                 build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
 
@@ -2486,8 +2486,8 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
     while (info) {
         mcfg[count].allocation[0].address = cpu_to_le64(info->mcfg_base);
         mcfg[count].allocation[0].pci_segment = cpu_to_le16(info->domain_nr);
-        mcfg[count].allocation[0].start_bus_number = info->bus_nr;
-        mcfg[count++].allocation[0].end_bus_number = info->bus_nr + \
+        mcfg[count].allocation[0].start_bus_number = info->start_bus;
+        mcfg[count++].allocation[0].end_bus_number = info->start_bus + \
                                     PCIE_MMCFG_BUS(info->mcfg_size - 1);
         info = info->next;
     }
@@ -2710,12 +2710,12 @@ static AcpiMcfgInfo *acpi_get_mcfg(void)
         mcfg->mcfg_size = qnum_get_uint(qobject_to(QNum, o));
         qobject_unref(o);
 
-        o = object_property_get_qobject(obj, PROP_PXB_BUS_NR, NULL);
+        o = object_property_get_qobject(obj, PROP_PXB_PCIE_START_BUS, NULL);
         if (!o) {
             /* we are in q35 host again */
-            mcfg->bus_nr = 0;
+            mcfg->start_bus = 0;
         } else {
-            mcfg->bus_nr = qnum_get_uint(qobject_to(QNum, o));
+            mcfg->start_bus = qnum_get_uint(qobject_to(QNum, o));
             qobject_unref(o);
         }
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 38212db..85630ff 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -46,6 +46,7 @@ typedef struct PXBBus {
 #define TYPE_PXB_PCIE_DEVICE "pxb-pcie"
 #define PXB_PCIE_DEV(obj) OBJECT_CHECK(PXBDev, (obj), TYPE_PXB_PCIE_DEVICE)
 
+#define PROP_PXB_BUS_NR "bus_nr"
 #define PROP_PXB_PCIE_MAX_BUS "max_bus"
 #define PROP_PXB_NUMA_NODE "numa_node"
 
@@ -62,8 +63,9 @@ typedef struct PXBDev {
     PXBPCIEHost *pxbhost;
 
     uint32_t domain_nr; /* PCI domain number, non-zero means separate domain */
+    uint8_t start_bus;  /* indicates the BBN of pxb-pcie-host bridge */
     uint8_t max_bus;    /* max bus number to use(including this one) */
-    uint8_t bus_nr;
+    uint8_t bus_nr;     /* bus number of pxb-pcie device on pcei.0 bus */
     uint16_t numa_node;
 } PXBDev;
 
@@ -137,8 +139,8 @@ static void pxb_pcie_foreach(gpointer data, gpointer user_data)
 
     if (pxb->domain_nr > 0) {
         /* only reserve what users ask for to reduce memory cost. Plus one
-         * as the interval [bus_nr, max_bus] has (max_bus-bus_nr+1) buses */
-        pxb_mcfg_hole_size += ((pxb->max_bus - pxb->bus_nr + 1ULL) * MiB);
+         * as the interval [start_bus, max_bus] has (max_bus-start_bus+1) buses */
+        pxb_mcfg_hole_size += ((pxb->max_bus - pxb->start_bus + 1ULL) * MiB);
     }
 }
 
@@ -333,11 +335,11 @@ static gint pxb_compare(gconstpointer a, gconstpointer b)
 {
     const PXBDev *pxb_a = a, *pxb_b = b;
 
-    /* check domain_nr, then bus_nr */
+    /* check domain_nr, then start_bus */
     return pxb_a->domain_nr < pxb_b->domain_nr ? -1 :
            pxb_a->domain_nr > pxb_b->domain_nr ?  1 :
-           pxb_a->bus_nr < pxb_b->bus_nr ? -1 :
-           pxb_a->bus_nr > pxb_b->bus_nr ?  1 :
+           pxb_a->start_bus < pxb_b->start_bus ? -1 :
+           pxb_a->start_bus > pxb_b->start_bus ?  1 :
            0;
 }
 
@@ -362,7 +364,7 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
     }
 
     if (pcie) {
-        g_assert (pxb->max_bus >= pxb->bus_nr);
+        g_assert (pxb->max_bus >= pxb->start_bus);
         ds = qdev_create(NULL, TYPE_PXB_PCIE_HOST);
         /* attach it under /machine, so that we can resolve a valid path in
          * object_property_set_link below */
@@ -377,9 +379,9 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
         /* will be overwritten by firmware, but kept for readability */
         qdev_prop_set_uint64(ds, PCIE_HOST_MCFG_BASE,
             pxb->domain_nr ? pxb_pcie_mcfg_base : MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT);
-        /* +1 because [bus_nr, max_bus] has (max_bus-bus_nr+1) buses */
+        /* +1 because [start_bus, max_bus] has (max_bus-start_bus+1) buses */
         qdev_prop_set_uint64(ds, PCIE_HOST_MCFG_SIZE,
-            pxb->domain_nr ? (pxb->max_bus - pxb->bus_nr + 1ULL) * MiB : 0);
+            pxb->domain_nr ? (pxb->max_bus - pxb->start_bus + 1ULL) * MiB : 0);
         if (pxb->domain_nr)
             pxb_pcie_mcfg_base += ((pxb->max_bus + 1ULL) * MiB);
 
@@ -389,7 +391,7 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
         bus = pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PXB_BUS);
         bds = qdev_create(BUS(bus), "pci-bridge");
         bds->id = dev_name;
-        qdev_prop_set_uint8(bds, PCI_BRIDGE_DEV_PROP_CHASSIS_NR, pxb->bus_nr);
+        qdev_prop_set_uint8(bds, PCI_BRIDGE_DEV_PROP_CHASSIS_NR, pxb->start_bus);
         qdev_prop_set_bit(bds, PCI_BRIDGE_DEV_PROP_SHPC, false);
     }
 
@@ -482,7 +484,8 @@ static Property pxb_pcie_dev_properties[] = {
     DEFINE_PROP_UINT8(PROP_PXB_BUS_NR, PXBDev, bus_nr, 0),
     DEFINE_PROP_UINT16(PROP_PXB_NUMA_NODE, PXBDev, numa_node, NUMA_NODE_UNASSIGNED),
     DEFINE_PROP_UINT32(PROP_PXB_PCIE_DOMAIN_NR, PXBDev, domain_nr, 0),
-    /* set a small default value, bus interval is [bus_nr, max_bus] */
+    DEFINE_PROP_UINT8(PROP_PXB_PCIE_START_BUS, PXBDev, start_bus, 0),
+    /* set a small default value, bus interval is [start_bus, max_bus] */
     DEFINE_PROP_UINT8(PROP_PXB_PCIE_MAX_BUS, PXBDev, max_bus, 16),
 
     DEFINE_PROP_END_OF_LIST(),
diff --git a/include/hw/pci-bridge/pci_expander_bridge.h b/include/hw/pci-bridge/pci_expander_bridge.h
index e6d3b67..54b050c 100644
--- a/include/hw/pci-bridge/pci_expander_bridge.h
+++ b/include/hw/pci-bridge/pci_expander_bridge.h
@@ -5,7 +5,7 @@
 #define PROP_PXB_PCIE_HOST "x-pxb-host"
 
 #define PROP_PXB_PCIE_DOMAIN_NR "domain_nr"
-#define PROP_PXB_BUS_NR "bus_nr"
+#define PROP_PXB_PCIE_START_BUS "start_bus"
 
 #define PXB_PCIE_HOST_BRIDGE_CONFIG_ADDR_BASE 0x1000
 #define PXB_PCIE_HOST_BRIDGE_CONFIG_DATA_BASE 0x1004
-- 
2.7.4
