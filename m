Received: from eggs.gnu.org ([2001:4830:134:3::10]:60192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fneYH-0003Hw-Co
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fneY7-0000sy-Pj
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:36:05 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fneY7-0000sW-JS
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:35:55 -0400
Received: by mail-pf1-x442.google.com with SMTP id p12-v6so2363458pfh.2
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 23:35:55 -0700 (PDT)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Thu,  9 Aug 2018 14:35:38 +0800
Message-Id: <1533796538-24173-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC v4 6/6] i386/acpi-build: pxb-pcie start bus
 should always be 0 in separate pci domain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

The bus_nr indicates the bus number of pxb-pcie under pcie.0, but since pxb
host can be put into different pci domain, the start bus should always be 0

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 hw/i386/acpi-build.c                | 14 ++------------
 hw/pci-bridge/pci_expander_bridge.c | 10 +++++-----
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index a7d9af2..0911008 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -91,7 +91,6 @@ typedef struct AcpiMcfgInfo {
     uint64_t mcfg_base;
     uint32_t mcfg_size;
     uint32_t domain_nr;
-    uint8_t bus_nr; // start bus number
     struct AcpiMcfgInfo *next;
 } AcpiMcfgInfo;
 
@@ -2470,8 +2469,8 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
     while (info) {
         mcfg[0].allocation[count].address = cpu_to_le64(info->mcfg_base);
         mcfg[0].allocation[count].pci_segment = cpu_to_le16(info->domain_nr);
-        mcfg[0].allocation[count].start_bus_number = info->bus_nr;
-        mcfg[0].allocation[count++].end_bus_number = info->bus_nr + \
+        mcfg[0].allocation[count].start_bus_number = 0;
+        mcfg[0].allocation[count++].end_bus_number = \
                                     PCIE_MMCFG_BUS(info->mcfg_size - 1);
         info = info->next;
     }
@@ -2694,15 +2693,6 @@ static AcpiMcfgInfo *acpi_get_mcfg(void)
         mcfg->mcfg_size = qnum_get_uint(qobject_to(QNum, o));
         qobject_unref(o);
 
-        o = object_property_get_qobject(obj, PROP_PXB_BUS_NR, NULL);
-        if (!o) {
-            /* we are in q35 host again */
-            mcfg->bus_nr = 0;
-        } else {
-            mcfg->bus_nr = qnum_get_uint(qobject_to(QNum, o));
-            qobject_unref(o);
-        }
-
         pci_host = OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host), next));
     }
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 686b026..53f5776 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -91,7 +91,7 @@ static int pxb_bus_num(PCIBus *bus)
 {
     PXBDev *pxb = convert_to_pxb(bus->parent_dev);
 
-    return pxb->bus_nr;
+    return pxb->domain_nr ? 0 : pxb->bus_nr;
 }
 
 static int pxb_domain_num(PCIBus *bus)
@@ -145,8 +145,8 @@ static void pxb_pcie_foreach(gpointer data, gpointer user_data)
 
     if (pxb->domain_nr > 0) {
         /* only reserve what users ask for to reduce memory cost. Plus one
-         * as the interval [bus_nr, max_bus] has (max_bus-bus_nr+1) buses */
-        pxb_mcfg_hole_size += ((pxb->max_bus - pxb->bus_nr + 1ULL) * MiB);
+         * as the interval [0, max_bus] has (max_bus+1) buses */
+        pxb_mcfg_hole_size += ((pxb->max_bus + 1ULL) * MiB);
     }
 }
 
@@ -385,9 +385,9 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
         /* will be overwritten by firmware, but kept for readability */
         qdev_prop_set_uint64(ds, PCIE_HOST_MCFG_BASE,
             pxb->domain_nr ? pxb_pcie_mcfg_base : MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT);
-        /* +1 because [bus_nr, max_bus] has (max_bus-bus_nr+1) buses */
+        /* +1 because [0, max_bus] has (max_bus+1) buses */
         qdev_prop_set_uint64(ds, PCIE_HOST_MCFG_SIZE,
-            pxb->domain_nr ? (pxb->max_bus - pxb->bus_nr + 1ULL) * MiB : 0);
+            pxb->domain_nr ? (pxb->max_bus + 1ULL) * MiB : 0);
         if (pxb->domain_nr)
             pxb_pcie_mcfg_base += ((pxb->max_bus + 1ULL) * MiB);
 
-- 
2.7.4
