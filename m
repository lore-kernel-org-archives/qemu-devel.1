Received: from eggs.gnu.org ([2001:4830:134:3::10]:37224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1clZDu-0007yC-S3
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1clZDr-0003DN-NZ
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:38 -0500
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:43415)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1clZDr-0003Cf-F3
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:35 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id DF25438686
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 11:53:33 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  8 Mar 2017 11:52:51 +0100
Message-Id: <1488970371-8865-9-git-send-email-clg@kaod.org>
In-Reply-To: <1488970371-8865-1-git-send-email-clg@kaod.org>
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.10 8/8] ppc/pnv: Add support for POWER8+
 LPC Controller
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
      - ported on latest PowerNV patchset ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c             | 15 ++++++++++++++-
 hw/ppc/pnv_lpc.c         | 47 ++++++++++++++++++++++++++++++++++++++++++=
+++--
 include/hw/ppc/pnv_lpc.h |  9 +++++++++
 3 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index ca5a078bc6c6..65dfe5b4c97b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -376,7 +376,14 @@ static void pnv_lpc_isa_irq_handler_cpld(void *opaqu=
e, int n, int level)
=20
 static void pnv_lpc_isa_irq_handler(void *opaque, int n, int level)
 {
-     /* XXX TODO */
+    PnvChip *chip =3D opaque;
+    PnvLpcController *lpc =3D &chip->lpc;
+
+    /* The Naples HW latches the 1 levels, clearing is done by SW */
+    if (level) {
+        lpc->lpc_hc_irqstat |=3D LPC_HC_IRQ_SERIRQ0 >> n;
+        pnv_lpc_eval_irqs(lpc);
+    }
 }
=20
 static ISABus *pnv_isa_create(PnvChip *chip)
@@ -719,6 +726,12 @@ static void pnv_chip_init(Object *obj)
     object_property_add_child(obj, "occ", OBJECT(&chip->occ), NULL);
     object_property_add_const_link(OBJECT(&chip->occ), "psi",
                                    OBJECT(&chip->psi), &error_abort);
+
+    /*
+     * The LPC controller needs PSI to generate interrupts
+     */
+    object_property_add_const_link(OBJECT(&chip->lpc), "psi",
+                                   OBJECT(&chip->psi), &error_abort);
 }
=20
 static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 78db52415b11..20cbb6a0dbbd 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -250,6 +250,34 @@ static const MemoryRegionOps pnv_lpc_xscom_ops =3D {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
+void pnv_lpc_eval_irqs(PnvLpcController *lpc)
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
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 38e5506975aa..53040026c37b 100644
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
@@ -62,6 +64,13 @@ typedef struct PnvLpcController {
=20
     /* XSCOM registers */
     MemoryRegion xscom_regs;
+
+    /* PSI to generate interrupts */
+    PnvPsi *psi;
 } PnvLpcController;
=20
+#define   LPC_HC_IRQ_SERIRQ0            0x80000000 /* all bits down to .=
.. */
+
+void pnv_lpc_eval_irqs(PnvLpcController *lpc);
+
 #endif /* _PPC_PNV_LPC_H */
--=20
2.7.4
