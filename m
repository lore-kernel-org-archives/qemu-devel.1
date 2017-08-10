Received: from eggs.gnu.org ([2001:4830:134:3::10]:43074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dfwlx-0003G9-NJ
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 19:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dfwlu-0002q4-Ff
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 19:21:49 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dfwlu-0002pg-3P
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 19:21:46 -0400
Received: by mail-lf0-x243.google.com with SMTP id w199so1367319lff.2
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 16:21:46 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Fri, 11 Aug 2017 02:21:28 +0300
Message-Id: <1502407288-22226-4-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1502407288-22226-1-git-send-email-zuban32s@gmail.com>
References: <1502407288-22226-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH v5 3/3] pci: enable RedHat PCI bridges to
 reserve additional resource on PCI init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: marcel@redhat.com, mst@redhat.com, kevin@koconnor.net, kraxel@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

In case of Red Hat Generic PCIE Root Port reserve additional buses
and/or IO/MEM/PREF space, which values are provided in a vendor-specific capability.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 src/fw/dev-pci.h |   2 +-
 src/fw/pciinit.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++------
 src/hw/pci_ids.h |   3 ++
 3 files changed, 116 insertions(+), 14 deletions(-)

diff --git a/src/fw/dev-pci.h b/src/fw/dev-pci.h
index cf16b2e..99ccc12 100644
--- a/src/fw/dev-pci.h
+++ b/src/fw/dev-pci.h
@@ -38,7 +38,7 @@
 #define PCI_CAP_REDHAT_TYPE_OFFSET  3
 
 /* List of valid Red Hat vendor-specific capability types */
-#define REDHAT_CAP_RESOURCE_RESERVE    1
+#define REDHAT_CAP_RESOURCE_RESERVE 1
 
 
 /* Offsets of RESOURCE_RESERVE capability fields */
diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
index 864954f..d9aef56 100644
--- a/src/fw/pciinit.c
+++ b/src/fw/pciinit.c
@@ -15,6 +15,7 @@
 #include "hw/pcidevice.h" // pci_probe_devices
 #include "hw/pci_ids.h" // PCI_VENDOR_ID_INTEL
 #include "hw/pci_regs.h" // PCI_COMMAND
+#include "fw/dev-pci.h" // REDHAT_CAP_RESOURCE_RESERVE
 #include "list.h" // struct hlist_node
 #include "malloc.h" // free
 #include "output.h" // dprintf
@@ -522,6 +523,32 @@ static void pci_bios_init_platform(void)
     }
 }
 
+static u8 pci_find_resource_reserve_capability(u16 bdf)
+{
+    if (pci_config_readw(bdf, PCI_VENDOR_ID) == PCI_VENDOR_ID_REDHAT &&
+        pci_config_readw(bdf, PCI_DEVICE_ID) ==
+                PCI_DEVICE_ID_REDHAT_ROOT_PORT) {
+        u8 cap = 0;
+        do {
+            cap = pci_find_capability(bdf, PCI_CAP_ID_VNDR, cap);
+        } while (cap &&
+                 pci_config_readb(bdf, cap + PCI_CAP_REDHAT_TYPE_OFFSET) !=
+                        REDHAT_CAP_RESOURCE_RESERVE);
+        if (cap) {
+            u8 cap_len = pci_config_readb(bdf, cap + PCI_CAP_FLAGS);
+            if (cap_len < RES_RESERVE_CAP_SIZE) {
+                dprintf(1, "PCI: QEMU resource reserve cap length %d is invalid\n",
+                        cap_len);
+            }
+        } else {
+            dprintf(1, "PCI: invalid QEMU resource reserve cap offset\n");
+        }
+        return cap;
+    } else {
+        dprintf(1, "PCI: QEMU resource reserve cap not found\n");
+        return 0;
+    }
+}
 
 /****************************************************************
  * Bus initialization
@@ -578,9 +605,28 @@ pci_bios_init_bus_rec(int bus, u8 *pci_bus)
         pci_bios_init_bus_rec(secbus, pci_bus);
 
         if (subbus != *pci_bus) {
+            u8 res_bus = 0;
+            u8 cap = pci_find_resource_reserve_capability(bdf);
+
+            if (cap) {
+                u32 tmp_res_bus = pci_config_readl(bdf,
+                        cap + RES_RESERVE_BUS_RES);
+                if (tmp_res_bus != (u32)-1) {
+                    res_bus = tmp_res_bus & 0xFF;
+                    if ((u8)(res_bus + secbus) < secbus ||
+                            (u8)(res_bus + secbus) < res_bus) {
+                        dprintf(1, "PCI: bus_reserve value %d is invalid\n",
+                                res_bus);
+                        res_bus = 0;
+                    }
+                }
+                res_bus = (*pci_bus > secbus + res_bus) ? *pci_bus
+                        : secbus + res_bus;
+            }
             dprintf(1, "PCI: subordinate bus = 0x%x -> 0x%x\n",
-                    subbus, *pci_bus);
-            subbus = *pci_bus;
+                    subbus, res_bus);
+            subbus = res_bus;
+            *pci_bus = res_bus;
         } else {
             dprintf(1, "PCI: subordinate bus = 0x%x\n", subbus);
         }
@@ -844,22 +890,74 @@ static int pci_bios_check_devices(struct pci_bus *busses)
              */
             parent = &busses[0];
         int type;
-        u8 pcie_cap = pci_find_capability(s->bus_dev->bdf, PCI_CAP_ID_EXP, 0);
+        u16 bdf = s->bus_dev->bdf;
+        u8 pcie_cap = pci_find_capability(bdf, PCI_CAP_ID_EXP, 0);
+        u8 qemu_cap = pci_find_resource_reserve_capability(bdf);
+
         int hotplug_support = pci_bus_hotplug_support(s, pcie_cap);
         for (type = 0; type < PCI_REGION_TYPE_COUNT; type++) {
             u64 align = (type == PCI_REGION_TYPE_IO) ?
-                PCI_BRIDGE_IO_MIN : PCI_BRIDGE_MEM_MIN;
+                    PCI_BRIDGE_IO_MIN : PCI_BRIDGE_MEM_MIN;
             if (!pci_bridge_has_region(s->bus_dev, type))
                 continue;
-            if (pci_region_align(&s->r[type]) > align)
-                 align = pci_region_align(&s->r[type]);
-            u64 sum = pci_region_sum(&s->r[type]);
-            int resource_optional = pcie_cap && (type == PCI_REGION_TYPE_IO);
-            if (!sum && hotplug_support && !resource_optional)
-                sum = align; /* reserve min size for hot-plug */
-            u64 size = ALIGN(sum, align);
-            int is64 = pci_bios_bridge_region_is64(&s->r[type],
-                                            s->bus_dev, type);
+            u64 size;
+            int is64;
+            int qemu_cap_used = 0;
+            if (qemu_cap) {
+                u32 tmp_size;
+                u64 tmp_size_64;
+                switch(type) {
+                case PCI_REGION_TYPE_IO:
+                    tmp_size_64 = (pci_config_readl(bdf, qemu_cap + RES_RESERVE_IO) |
+                            (u64)pci_config_readl(bdf, qemu_cap + RES_RESERVE_IO + 4) << 32);
+                    if (tmp_size_64 != (u64)-1) {
+                        size = tmp_size_64;
+                        is64 = 0;
+                        qemu_cap_used = 1;
+                    }
+                    break;
+                case PCI_REGION_TYPE_MEM:
+                    tmp_size = pci_config_readl(bdf, qemu_cap + RES_RESERVE_MEM);
+                    if (tmp_size != (u32)-1) {
+                        size = tmp_size;
+                        is64 = 0;
+                        qemu_cap_used = 1;
+                    }
+                    break;
+                case PCI_REGION_TYPE_PREFMEM:
+                    tmp_size = pci_config_readl(bdf, qemu_cap + RES_RESERVE_PREF_MEM_32);
+                    tmp_size_64 = (pci_config_readl(bdf, qemu_cap + RES_RESERVE_PREF_MEM_64) |
+                            (u64)pci_config_readl(bdf, qemu_cap + RES_RESERVE_PREF_MEM_64 + 4) << 32);
+                    if (tmp_size != (u32)-1 && tmp_size_64 == (u64)-1) {
+                        size = tmp_size;
+                        is64 = 0;
+                        qemu_cap_used = 1;
+                    } else if (tmp_size == (u32)-1 && tmp_size_64 != (u64)-1) {
+                        size = tmp_size_64;
+                        is64 = 1;
+                        qemu_cap_used = 1;
+                    } else if (tmp_size != (u32)-1 && tmp_size_64 != (u64)-1) {
+                        dprintf(1, "PCI: resource reserve cap PREF32 and PREF64"
+                                " conflict\n");
+                    }
+                    break;
+                default:
+                    break;
+                }
+            }
+            if (!qemu_cap_used) {
+                if (pci_region_align(&s->r[type]) > align)
+                     align = pci_region_align(&s->r[type]);
+                u64 sum = pci_region_sum(&s->r[type]);
+                int resource_optional = pcie_cap && (type == PCI_REGION_TYPE_IO);
+                if (!sum && hotplug_support && !resource_optional)
+                    sum = align; /* reserve min size for hot-plug */
+                size = ALIGN(sum, align);
+                is64 = pci_bios_bridge_region_is64(&s->r[type],
+                                                s->bus_dev, type);
+            } else {
+                dprintf(1, "PCI: resource reserve cap used\n");
+            }
             // entry->bar is -1 if the entry represents a bridge region
             struct pci_region_entry *entry = pci_region_create_entry(
                 parent, s->bus_dev, -1, size, align, type, is64);
@@ -951,6 +1049,7 @@ pci_region_map_one_entry(struct pci_region_entry *entry, u64 addr)
 
     u16 bdf = entry->dev->bdf;
     u64 limit = addr + entry->size - 1;
+
     if (entry->type == PCI_REGION_TYPE_IO) {
         pci_config_writeb(bdf, PCI_IO_BASE, addr >> PCI_IO_SHIFT);
         pci_config_writew(bdf, PCI_IO_BASE_UPPER16, 0);
diff --git a/src/hw/pci_ids.h b/src/hw/pci_ids.h
index 4ac73b4..38fa2ca 100644
--- a/src/hw/pci_ids.h
+++ b/src/hw/pci_ids.h
@@ -2263,6 +2263,9 @@
 #define PCI_DEVICE_ID_KORENIX_JETCARDF0	0x1600
 #define PCI_DEVICE_ID_KORENIX_JETCARDF1	0x16ff
 
+#define PCI_VENDOR_ID_REDHAT		0x1b36
+#define PCI_DEVICE_ID_REDHAT_ROOT_PORT	0x000C
+
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
-- 
2.7.4
