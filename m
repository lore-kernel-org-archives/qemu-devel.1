Received: from eggs.gnu.org ([209.51.188.92]:60477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu12-00065W-2S
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu10-00059T-3X
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:20 +1000
Message-Id: <20190426060627.18153-30-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/36] spapr: Drop duplicate PCI swizzle code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

LSI mapping in spapr currently open-codes standard PCI swizzling. It thus
duplicates the code of pci_swizzle_map_irq_fn().

Expose the swizzling formula so that it can be used with a slot number
when building the device tree. Simply drop pci_spapr_map_irq() and call
pci_swizzle_map_irq_fn() instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155448184841.8446.13959787238854054119.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci/pci.c         |  2 +-
 hw/ppc/spapr_pci.c   | 24 ++++--------------------
 include/hw/pci/pci.h |  4 ++++
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1808b242dd..a78023f669 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1556,7 +1556,7 @@ void pci_device_set_intx_routing_notifier(PCIDevice=
 *dev,
  */
 int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin)
 {
-    return (pin + PCI_SLOT(pci_dev->devfn)) % PCI_NUM_PINS;
+    return pci_swizzle(PCI_SLOT(pci_dev->devfn), pin);
 }
=20
 /***********************************************************/
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f005854dec..97961b0128 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -719,26 +719,10 @@ param_error_exit:
     rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
 }
=20
-static int pci_spapr_swizzle(int slot, int pin)
-{
-    return (slot + pin) % PCI_NUM_PINS;
-}
-
-static int pci_spapr_map_irq(PCIDevice *pci_dev, int irq_num)
-{
-    /*
-     * Here we need to convert pci_dev + irq_num to some unique value
-     * which is less than number of IRQs on the specific bus (4).  We
-     * use standard PCI swizzling, that is (slot number + pin number)
-     * % 4.
-     */
-    return pci_spapr_swizzle(PCI_SLOT(pci_dev->devfn), irq_num);
-}
-
 static void pci_spapr_set_irq(void *opaque, int irq_num, int level)
 {
     /*
-     * Here we use the number returned by pci_spapr_map_irq to find a
+     * Here we use the number returned by pci_swizzle_map_irq_fn to find=
 a
      * corresponding qemu_irq.
      */
     SpaprPhbState *phb =3D opaque;
@@ -1766,7 +1750,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
                                 &sphb->iowindow);
=20
     bus =3D pci_register_root_bus(dev, NULL,
-                                pci_spapr_set_irq, pci_spapr_map_irq, sp=
hb,
+                                pci_spapr_set_irq, pci_swizzle_map_irq_f=
n, sphb,
                                 &sphb->memspace, &sphb->iospace,
                                 PCI_DEVFN(0, 0), PCI_NUM_PINS,
                                 TYPE_SPAPR_PHB_ROOT_BUS);
@@ -2259,14 +2243,14 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uin=
t32_t intc_phandle, void *fdt,
     }
=20
     /* Build the interrupt-map, this must matches what is done
-     * in pci_spapr_map_irq
+     * in pci_swizzle_map_irq_fn
      */
     _FDT(fdt_setprop(fdt, bus_off, "interrupt-map-mask",
                      &interrupt_map_mask, sizeof(interrupt_map_mask)));
     for (i =3D 0; i < PCI_SLOT_MAX; i++) {
         for (j =3D 0; j < PCI_NUM_PINS; j++) {
             uint32_t *irqmap =3D interrupt_map[i*PCI_NUM_PINS + j];
-            int lsi_num =3D pci_spapr_swizzle(i, j);
+            int lsi_num =3D pci_swizzle(i, j);
=20
             irqmap[0] =3D cpu_to_be32(b_ddddd(i)|b_fff(0));
             irqmap[1] =3D 0;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 0abb06b357..fdd4c43d3a 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -413,6 +413,10 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_ir=
q, pci_map_irq_fn map_irq,
 void pci_bus_irqs_cleanup(PCIBus *bus);
 int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
 /* 0 <=3D pin <=3D 3 0 =3D INTA, 1 =3D INTB, 2 =3D INTC, 3 =3D INTD */
+static inline int pci_swizzle(int slot, int pin)
+{
+    return (slot + pin) % PCI_NUM_PINS;
+}
 int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
 PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
                               pci_set_irq_fn set_irq, pci_map_irq_fn map=
_irq,
--=20
2.20.1
