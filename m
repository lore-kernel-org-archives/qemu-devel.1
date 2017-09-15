Received: from eggs.gnu.org ([2001:4830:134:3::10]:54152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfL-0006g0-Bk
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfJ-0003NE-Pi
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:22 +1000
Message-Id: <20170915035130.8354-11-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/18] spapr_pci: handle FDT creation errors
 with _FDT()
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

libfdt failures when creating the FDT should cause QEMU to terminate.

Let's use the _FDT() macro which does just that instead of propagating
the error to the caller. spapr_populate_pci_child_dt() no longer needs
to return a value in this case.

Note that, on the way, this get rids of the following nonsensical lines:

    g_assert(!ret);
    if (ret) {

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index abb9f05e7b..75cd939223 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1204,12 +1204,12 @@ static gchar *pci_get_node_name(PCIDevice *dev)
 static uint32_t spapr_phb_get_pci_drc_index(sPAPRPHBState *phb,
                                             PCIDevice *pdev);
 
-static int spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
+static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
                                        sPAPRPHBState *sphb)
 {
     ResourceProps rp;
     bool is_bridge = false;
-    int pci_status, err;
+    int pci_status;
     char *buf = NULL;
     uint32_t drc_index = spapr_phb_get_pci_drc_index(sphb, dev);
     uint32_t ccode = pci_default_read_config(dev, PCI_CLASS_PROG, 3);
@@ -1274,11 +1274,8 @@ static int spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
                                                  ccode & 0xff)));
 
     buf = spapr_phb_get_loc_code(sphb, dev);
-    err = fdt_setprop_string(fdt, offset, "ibm,loc-code", buf);
+    _FDT(fdt_setprop_string(fdt, offset, "ibm,loc-code", buf));
     g_free(buf);
-    if (err < 0) {
-        return err;
-    }
 
     if (drc_index) {
         _FDT(fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_index));
@@ -1306,27 +1303,21 @@ static int spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
     if (sphb->pcie_ecs && pci_is_express(dev)) {
         _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", 0x1));
     }
-
-    return 0;
 }
 
 /* create OF node for pci device and required OF DT properties */
 static int spapr_create_pci_child_dt(sPAPRPHBState *phb, PCIDevice *dev,
                                      void *fdt, int node_offset)
 {
-    int offset, ret;
+    int offset;
     gchar *nodename;
 
     nodename = pci_get_node_name(dev);
-    offset = fdt_add_subnode(fdt, node_offset, nodename);
+    _FDT(offset = fdt_add_subnode(fdt, node_offset, nodename));
     g_free(nodename);
 
-    ret = spapr_populate_pci_child_dt(dev, fdt, offset, phb);
+    spapr_populate_pci_child_dt(dev, fdt, offset, phb);
 
-    g_assert(!ret);
-    if (ret) {
-        return 0;
-    }
     return offset;
 }
 
@@ -1416,10 +1407,6 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
 
     fdt = create_device_tree(&fdt_size);
     fdt_start_offset = spapr_create_pci_child_dt(phb, pdev, fdt, 0);
-    if (!fdt_start_offset) {
-        error_setg(&local_err, "Failed to create pci child device tree node");
-        goto out;
-    }
 
     spapr_drc_attach(drc, DEVICE(pdev), fdt, fdt_start_offset, &local_err);
     if (local_err) {
@@ -2114,11 +2101,8 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
 
     /* Start populating the FDT */
     nodename = g_strdup_printf("pci@%" PRIx64, phb->buid);
-    bus_off = fdt_add_subnode(fdt, 0, nodename);
+    _FDT(bus_off = fdt_add_subnode(fdt, 0, nodename));
     g_free(nodename);
-    if (bus_off < 0) {
-        return bus_off;
-    }
 
     /* Write PHB properties */
     _FDT(fdt_setprop_string(fdt, bus_off, "device_type", "pci"));
-- 
2.13.5
