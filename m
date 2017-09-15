Received: from eggs.gnu.org ([2001:4830:134:3::10]:54106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfK-0006bR-4A
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfH-0003Jz-1P
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:17 +1000
Message-Id: <20170915035130.8354-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/18] spapr_pci: use g_strdup_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Building strings with g_strdup_printf() instead of snprintf() is
a QEMU common practice.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index cd8efb1812..6da73fe6bc 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -61,8 +61,6 @@
 #define RTAS_TYPE_MSI           1
 #define RTAS_TYPE_MSIX          2
 
-#define FDT_NAME_MAX          128
-
 #define _FDT(exp) \
     do { \
         int ret = (exp);                                           \
@@ -1194,7 +1192,7 @@ static const char *pci_find_device_name(uint8_t class, uint8_t subclass,
     return name;
 }
 
-static void pci_get_node_name(char *nodename, int len, PCIDevice *dev)
+static gchar *pci_get_node_name(PCIDevice *dev)
 {
     int slot = PCI_SLOT(dev->devfn);
     int func = PCI_FUNC(dev->devfn);
@@ -1205,9 +1203,9 @@ static void pci_get_node_name(char *nodename, int len, PCIDevice *dev)
                                 ccode & 0xff);
 
     if (func != 0) {
-        snprintf(nodename, len, "%s@%x,%x", name, slot, func);
+        return g_strdup_printf("%s@%x,%x", name, slot, func);
     } else {
-        snprintf(nodename, len, "%s@%x", name, slot);
+        return g_strdup_printf("%s@%x", name, slot);
     }
 }
 
@@ -1325,10 +1323,12 @@ static int spapr_create_pci_child_dt(sPAPRPHBState *phb, PCIDevice *dev,
                                      void *fdt, int node_offset)
 {
     int offset, ret;
-    char nodename[FDT_NAME_MAX];
+    gchar *nodename;
 
-    pci_get_node_name(nodename, FDT_NAME_MAX, dev);
+    nodename = pci_get_node_name(dev);
     offset = fdt_add_subnode(fdt, node_offset, nodename);
+    g_free(nodename);
+
     ret = spapr_populate_pci_child_dt(dev, fdt, offset, phb);
 
     g_assert(!ret);
@@ -2072,7 +2072,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
                           void *fdt)
 {
     int bus_off, i, j, ret;
-    char nodename[FDT_NAME_MAX];
+    gchar *nodename;
     uint32_t bus_range[] = { cpu_to_be32(0), cpu_to_be32(0xff) };
     struct {
         uint32_t hi;
@@ -2121,8 +2121,9 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
     sPAPRFDT s_fdt;
 
     /* Start populating the FDT */
-    snprintf(nodename, FDT_NAME_MAX, "pci@%" PRIx64, phb->buid);
+    nodename = g_strdup_printf("pci@%" PRIx64, phb->buid);
     bus_off = fdt_add_subnode(fdt, 0, nodename);
+    g_free(nodename);
     if (bus_off < 0) {
         return bus_off;
     }
-- 
2.13.5
