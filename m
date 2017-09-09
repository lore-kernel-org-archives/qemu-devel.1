Received: from eggs.gnu.org ([2001:4830:134:3::10]:50969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dqhL1-0007ps-Lw
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dqhKw-00069q-Of
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:27 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:53098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dqhKw-000687-3Z
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:22 -0400
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id CDAE871BB4
	for <qemu-devel@nongnu.org>; Sat,  9 Sep 2017 17:06:20 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Sat, 09 Sep 2017 17:06:18 +0200
Message-ID: <150496957801.9654.17692506571556698840.stgit@bahia>
In-Reply-To: <150496954641.9654.1998704077006846521.stgit@bahia>
References: <150496954641.9654.1998704077006846521.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 3/5] spapr_pci: use g_strdup_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Building strings with g_strdup_printf() instead of snprintf() is
a QEMU common practice.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index cd8efb181223..6da73fe6bc29 100644
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
