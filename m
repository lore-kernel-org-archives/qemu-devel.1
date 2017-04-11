Received: from eggs.gnu.org ([2001:4830:134:3::10]:38085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxxkV-0006YX-V1
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxxkS-0003YQ-PB
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:31 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:43511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxxkS-0003Wb-GK
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:28 -0400
Received: from player778.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 1559D313C5
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 17:30:27 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Apr 2017 17:29:59 +0200
Message-Id: <1491924606-20026-2-git-send-email-clg@kaod.org>
In-Reply-To: <1491924606-20026-1-git-send-email-clg@kaod.org>
References: <1491924606-20026-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/8] ppc/pnv: Add support for POWER8+ LPC
 Controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

It adds the Naples chip which supports proper LPC interrupts via the
LPC controller rather than via an external CPLD.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[clg: - updated for qemu-2.9
      - ported on latest PowerNV patchset
      - moved the IRQ handler in pnv_lpc.c
      - introduced pnv_lpc_isa_irq_create() to create the ISA IRQs ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v2:

 - used PNV_LPC() macro to cast the 'opaque' parameter

 Changes since v1:

 - moved the IRQ handler in pnv_lpc.c
 - introduced pnv_lpc_isa_irq_create() to create the ISA IRQs=20

 hw/ppc/pnv.c             | 45 +++-------------------
 hw/ppc/pnv_lpc.c         | 97 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
 include/hw/ppc/pnv_lpc.h |  8 ++++
 3 files changed, 108 insertions(+), 42 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 16f32c9bbd9d..27589b91d1cf 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -346,36 +346,6 @@ static void ppc_powernv_reset(void)
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 }
=20
-/* If we don't use the built-in LPC interrupt deserializer, we need
- * to provide a set of qirqs for the ISA bus or things will go bad.
- *
- * Most machines using pre-Naples chips (without said deserializer)
- * have a CPLD that will collect the SerIRQ and shoot them as a
- * single level interrupt to the P8 chip. So let's setup a hook
- * for doing just that.
- */
-static void pnv_lpc_isa_irq_handler_cpld(void *opaque, int n, int level)
-{
-    PnvMachineState *pnv =3D POWERNV_MACHINE(qdev_get_machine());
-    uint32_t old_state =3D pnv->cpld_irqstate;
-    PnvChip *chip =3D opaque;
-
-    if (level) {
-        pnv->cpld_irqstate |=3D 1u << n;
-    } else {
-        pnv->cpld_irqstate &=3D ~(1u << n);
-    }
-    if (pnv->cpld_irqstate !=3D old_state) {
-        pnv_psi_irq_set(&chip->psi, PSIHB_IRQ_EXTERNAL,
-                        pnv->cpld_irqstate !=3D 0);
-    }
-}
-
-static void pnv_lpc_isa_irq_handler(void *opaque, int n, int level)
-{
-     /* XXX TODO */
-}
-
 static ISABus *pnv_isa_create(PnvChip *chip)
 {
     PnvLpcController *lpc =3D &chip->lpc;
@@ -390,16 +360,7 @@ static ISABus *pnv_isa_create(PnvChip *chip)
     isa_bus =3D isa_bus_new(NULL, &lpc->isa_mem, &lpc->isa_io,
                           &error_fatal);
=20
-    /* Not all variants have a working serial irq decoder. If not,
-     * handling of LPC interrupts becomes a platform issue (some
-     * platforms have a CPLD to do it).
-     */
-    if (pcc->chip_type =3D=3D PNV_CHIP_POWER8NVL) {
-        irqs =3D qemu_allocate_irqs(pnv_lpc_isa_irq_handler, chip, ISA_N=
UM_IRQS);
-    } else {
-        irqs =3D qemu_allocate_irqs(pnv_lpc_isa_irq_handler_cpld, chip,
-                                  ISA_NUM_IRQS);
-    }
+    irqs =3D pnv_lpc_isa_irq_create(lpc, pcc->chip_type, ISA_NUM_IRQS);
=20
     isa_bus_irqs(isa_bus, irqs);
     return isa_bus;
@@ -699,6 +660,10 @@ static void pnv_chip_init(Object *obj)
     object_property_add_child(obj, "occ", OBJECT(&chip->occ), NULL);
     object_property_add_const_link(OBJECT(&chip->occ), "psi",
                                    OBJECT(&chip->psi), &error_abort);
+
+    /* The LPC controller needs PSI to generate interrupts */
+    object_property_add_const_link(OBJECT(&chip->lpc), "psi",
+                                   OBJECT(&chip->psi), &error_abort);
 }
=20
 static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 78db52415b11..5d20c15e6729 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -250,6 +250,34 @@ static const MemoryRegionOps pnv_lpc_xscom_ops =3D {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
+static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
+{
+    bool lpc_to_opb_irq =3D false;
+
+    /* Update LPC controller to OPB line */
+    if (lpc->lpc_hc_irqser_ctrl & LPC_HC_IRQSER_EN) {
+        uint32_t irqs;
+
+        irqs =3D lpc->lpc_hc_irqstat & lpc->lpc_hc_irqmask;
+        lpc_to_opb_irq =3D (irqs !=3D 0);
+    }
+
+    /* We don't honor the polarity register, it's pointless and unused
+     * anyway
+     */
+    if (lpc_to_opb_irq) {
+        lpc->opb_irq_input |=3D OPB_MASTER_IRQ_LPC;
+    } else {
+        lpc->opb_irq_input &=3D ~OPB_MASTER_IRQ_LPC;
+    }
+
+    /* Update OPB internal latch */
+    lpc->opb_irq_stat |=3D lpc->opb_irq_input & lpc->opb_irq_mask;
+
+    /* Reflect the interrupt */
+    pnv_psi_irq_set(lpc->psi, PSIHB_IRQ_LPC_I2C, lpc->opb_irq_stat !=3D =
0);
+}
+
 static uint64_t lpc_hc_read(void *opaque, hwaddr addr, unsigned size)
 {
     PnvLpcController *lpc =3D opaque;
@@ -300,12 +328,15 @@ static void lpc_hc_write(void *opaque, hwaddr addr,=
 uint64_t val,
         break;
     case LPC_HC_IRQSER_CTRL:
         lpc->lpc_hc_irqser_ctrl =3D val;
+        pnv_lpc_eval_irqs(lpc);
         break;
     case LPC_HC_IRQMASK:
         lpc->lpc_hc_irqmask =3D val;
+        pnv_lpc_eval_irqs(lpc);
         break;
     case LPC_HC_IRQSTAT:
         lpc->lpc_hc_irqstat &=3D ~val;
+        pnv_lpc_eval_irqs(lpc);
         break;
     case LPC_HC_ERROR_ADDRESS:
         break;
@@ -363,14 +394,15 @@ static void opb_master_write(void *opaque, hwaddr a=
ddr,
     switch (addr) {
     case OPB_MASTER_LS_IRQ_STAT:
         lpc->opb_irq_stat &=3D ~val;
+        pnv_lpc_eval_irqs(lpc);
         break;
     case OPB_MASTER_LS_IRQ_MASK:
-        /* XXX Filter out reserved bits */
         lpc->opb_irq_mask =3D val;
+        pnv_lpc_eval_irqs(lpc);
         break;
     case OPB_MASTER_LS_IRQ_POL:
-        /* XXX Filter out reserved bits */
         lpc->opb_irq_pol =3D val;
+        pnv_lpc_eval_irqs(lpc);
         break;
     case OPB_MASTER_LS_IRQ_INPUT:
         /* Read only */
@@ -398,6 +430,8 @@ static const MemoryRegionOps opb_master_ops =3D {
 static void pnv_lpc_realize(DeviceState *dev, Error **errp)
 {
     PnvLpcController *lpc =3D PNV_LPC(dev);
+    Object *obj;
+    Error *error =3D NULL;
=20
     /* Reg inits */
     lpc->lpc_hc_fw_rd_acc_size =3D LPC_HC_FW_RD_4B;
@@ -441,6 +475,15 @@ static void pnv_lpc_realize(DeviceState *dev, Error =
**errp)
     pnv_xscom_region_init(&lpc->xscom_regs, OBJECT(dev),
                           &pnv_lpc_xscom_ops, lpc, "xscom-lpc",
                           PNV_XSCOM_LPC_SIZE);
+
+    /* get PSI object from chip */
+    obj =3D object_property_get_link(OBJECT(dev), "psi", &error);
+    if (!obj) {
+        error_setg(errp, "%s: required link 'psi' not found: %s",
+                   __func__, error_get_pretty(error));
+        return;
+    }
+    lpc->psi =3D PNV_PSI(obj);
 }
=20
 static void pnv_lpc_class_init(ObjectClass *klass, void *data)
@@ -470,3 +513,53 @@ static void pnv_lpc_register_types(void)
 }
=20
 type_init(pnv_lpc_register_types)
+
+/* If we don't use the built-in LPC interrupt deserializer, we need
+ * to provide a set of qirqs for the ISA bus or things will go bad.
+ *
+ * Most machines using pre-Naples chips (without said deserializer)
+ * have a CPLD that will collect the SerIRQ and shoot them as a
+ * single level interrupt to the P8 chip. So let's setup a hook
+ * for doing just that.
+ */
+static void pnv_lpc_isa_irq_handler_cpld(void *opaque, int n, int level)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(qdev_get_machine());
+    uint32_t old_state =3D pnv->cpld_irqstate;
+    PnvLpcController *lpc =3D PNV_LPC(opaque);
+
+    if (level) {
+        pnv->cpld_irqstate |=3D 1u << n;
+    } else {
+        pnv->cpld_irqstate &=3D ~(1u << n);
+    }
+
+    if (pnv->cpld_irqstate !=3D old_state) {
+        pnv_psi_irq_set(lpc->psi, PSIHB_IRQ_EXTERNAL, pnv->cpld_irqstate=
 !=3D 0);
+    }
+}
+
+static void pnv_lpc_isa_irq_handler(void *opaque, int n, int level)
+{
+    PnvLpcController *lpc =3D PNV_LPC(opaque);
+
+    /* The Naples HW latches the 1 levels, clearing is done by SW */
+    if (level) {
+        lpc->lpc_hc_irqstat |=3D LPC_HC_IRQ_SERIRQ0 >> n;
+        pnv_lpc_eval_irqs(lpc);
+    }
+}
+
+qemu_irq *pnv_lpc_isa_irq_create(PnvLpcController *lpc, int chip_type,
+                                 int nirqs)
+{
+    /* Not all variants have a working serial irq decoder. If not,
+     * handling of LPC interrupts becomes a platform issue (some
+     * platforms have a CPLD to do it).
+     */
+    if (chip_type =3D=3D PNV_CHIP_POWER8NVL) {
+        return qemu_allocate_irqs(pnv_lpc_isa_irq_handler, lpc, nirqs);
+    } else {
+        return qemu_allocate_irqs(pnv_lpc_isa_irq_handler_cpld, lpc, nir=
qs);
+    }
+}
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 38e5506975aa..ccf969af9448 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -23,6 +23,8 @@
 #define PNV_LPC(obj) \
      OBJECT_CHECK(PnvLpcController, (obj), TYPE_PNV_LPC)
=20
+typedef struct PnvPsi PnvPsi;
+
 typedef struct PnvLpcController {
     DeviceState parent;
=20
@@ -62,6 +64,12 @@ typedef struct PnvLpcController {
=20
     /* XSCOM registers */
     MemoryRegion xscom_regs;
+
+    /* PSI to generate interrupts */
+    PnvPsi *psi;
 } PnvLpcController;
=20
+qemu_irq *pnv_lpc_isa_irq_create(PnvLpcController *lpc, int chip_type,
+                                 int nirqs);
+
 #endif /* _PPC_PNV_LPC_H */
--=20
2.7.4
