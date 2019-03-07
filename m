Received: from eggs.gnu.org ([209.51.188.92]:33871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21cn-0006zw-JQ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21cl-0002Xe-7u
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50986
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h21ck-0001yE-Cb
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:22 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27MIlWW018672
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 17:36:00 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r39urxmjs-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:36:00 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 7 Mar 2019 22:35:58 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Mar 2019 23:35:37 +0100
In-Reply-To: <20190307223548.20516-1-clg@kaod.org>
References: <20190307223548.20516-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190307223548.20516-5-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/15] ppc/pnv: add a LPC Controller class
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

It will ease the introduction of the LPC Controller model for POWER9.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/pnv_lpc.h | 15 +++++++
 hw/ppc/pnv.c             |  2 +-
 hw/ppc/pnv_lpc.c         | 85 ++++++++++++++++++++++++++++------------
 3 files changed, 77 insertions(+), 25 deletions(-)

diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index d657489b07ce..f3f24419b19a 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -24,6 +24,8 @@
 #define TYPE_PNV_LPC "pnv-lpc"
 #define PNV_LPC(obj) \
      OBJECT_CHECK(PnvLpcController, (obj), TYPE_PNV_LPC)
+#define TYPE_PNV8_LPC TYPE_PNV_LPC "-POWER8"
+#define PNV8_LPC(obj) OBJECT_CHECK(PnvLpcController, (obj), TYPE_PNV8_LP=
C)
=20
 typedef struct PnvLpcController {
     DeviceState parent;
@@ -70,6 +72,19 @@ typedef struct PnvLpcController {
     PnvPsi *psi;
 } PnvLpcController;
=20
+#define PNV_LPC_CLASS(klass) \
+     OBJECT_CLASS_CHECK(PnvLpcClass, (klass), TYPE_PNV_LPC)
+#define PNV_LPC_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(PnvLpcClass, (obj), TYPE_PNV_LPC)
+
+typedef struct PnvLpcClass {
+    DeviceClass parent_class;
+
+    int psi_irq;
+
+    DeviceRealize parent_realize;
+} PnvLpcClass;
+
 ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error *=
*errp);
=20
 #endif /* _PPC_PNV_LPC_H */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1cc454cbbc27..922e3ec48bb5 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -794,7 +794,7 @@ static void pnv_chip_power8_instance_init(Object *obj=
)
                                    OBJECT(qdev_get_machine()), &error_ab=
ort);
=20
     object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->lpc)=
,
-                            TYPE_PNV_LPC, &error_abort, NULL);
+                            TYPE_PNV8_LPC, &error_abort, NULL);
     object_property_add_const_link(OBJECT(&chip8->lpc), "psi",
                                    OBJECT(&chip8->psi), &error_abort);
=20
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 547be609cafe..3c509a30a0af 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -245,6 +245,7 @@ static const MemoryRegionOps pnv_lpc_xscom_ops =3D {
 static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
 {
     bool lpc_to_opb_irq =3D false;
+    PnvLpcClass *plc =3D PNV_LPC_GET_CLASS(lpc);
=20
     /* Update LPC controller to OPB line */
     if (lpc->lpc_hc_irqser_ctrl & LPC_HC_IRQSER_EN) {
@@ -267,7 +268,7 @@ static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
     lpc->opb_irq_stat |=3D lpc->opb_irq_input & lpc->opb_irq_mask;
=20
     /* Reflect the interrupt */
-    pnv_psi_irq_set(lpc->psi, PSIHB_IRQ_LPC_I2C, lpc->opb_irq_stat !=3D =
0);
+    pnv_psi_irq_set(lpc->psi, plc->psi_irq, lpc->opb_irq_stat !=3D 0);
 }
=20
 static uint64_t lpc_hc_read(void *opaque, hwaddr addr, unsigned size)
@@ -419,11 +420,65 @@ static const MemoryRegionOps opb_master_ops =3D {
     },
 };
=20
+static void pnv_lpc_power8_realize(DeviceState *dev, Error **errp)
+{
+    PnvLpcController *lpc =3D PNV_LPC(dev);
+    PnvLpcClass *plc =3D PNV_LPC_GET_CLASS(dev);
+    Error *local_err =3D NULL;
+
+    plc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /* P8 uses a XSCOM region for LPC registers */
+    pnv_xscom_region_init(&lpc->xscom_regs, OBJECT(lpc),
+                          &pnv_lpc_xscom_ops, lpc, "xscom-lpc",
+                          PNV_XSCOM_LPC_SIZE);
+}
+
+static void pnv_lpc_power8_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
+    PnvLpcClass *plc =3D PNV_LPC_CLASS(klass);
+
+    dc->desc =3D "PowerNV LPC Controller POWER8";
+
+    xdc->dt_xscom =3D pnv_lpc_dt_xscom;
+
+    plc->psi_irq =3D PSIHB_IRQ_LPC_I2C;
+
+    device_class_set_parent_realize(dc, pnv_lpc_power8_realize,
+                                    &plc->parent_realize);
+}
+
+static const TypeInfo pnv_lpc_power8_info =3D {
+    .name          =3D TYPE_PNV8_LPC,
+    .parent        =3D TYPE_PNV_LPC,
+    .instance_size =3D sizeof(PnvLpcController),
+    .class_init    =3D pnv_lpc_power8_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
 static void pnv_lpc_realize(DeviceState *dev, Error **errp)
 {
     PnvLpcController *lpc =3D PNV_LPC(dev);
     Object *obj;
-    Error *error =3D NULL;
+    Error *local_err =3D NULL;
+
+    obj =3D object_property_get_link(OBJECT(dev), "psi", &local_err);
+    if (!obj) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'psi' not found: ");
+        return;
+    }
+    /* The LPC controller needs PSI to generate interrupts  */
+    lpc->psi =3D PNV_PSI(obj);
=20
     /* Reg inits */
     lpc->lpc_hc_fw_rd_acc_size =3D LPC_HC_FW_RD_4B;
@@ -463,46 +518,28 @@ static void pnv_lpc_realize(DeviceState *dev, Error=
 **errp)
                           "lpc-hc", LPC_HC_REGS_OPB_SIZE);
     memory_region_add_subregion(&lpc->opb_mr, LPC_HC_REGS_OPB_ADDR,
                                 &lpc->lpc_hc_regs);
-
-    /* XScom region for LPC registers */
-    pnv_xscom_region_init(&lpc->xscom_regs, OBJECT(dev),
-                          &pnv_lpc_xscom_ops, lpc, "xscom-lpc",
-                          PNV_XSCOM_LPC_SIZE);
-
-    /* get PSI object from chip */
-    obj =3D object_property_get_link(OBJECT(dev), "psi", &error);
-    if (!obj) {
-        error_setg(errp, "%s: required link 'psi' not found: %s",
-                   __func__, error_get_pretty(error));
-        return;
-    }
-    lpc->psi =3D PNV_PSI(obj);
 }
=20
 static void pnv_lpc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
-
-    xdc->dt_xscom =3D pnv_lpc_dt_xscom;
=20
     dc->realize =3D pnv_lpc_realize;
+    dc->desc =3D "PowerNV LPC Controller";
 }
=20
 static const TypeInfo pnv_lpc_info =3D {
     .name          =3D TYPE_PNV_LPC,
     .parent        =3D TYPE_DEVICE,
-    .instance_size =3D sizeof(PnvLpcController),
     .class_init    =3D pnv_lpc_class_init,
-    .interfaces =3D (InterfaceInfo[]) {
-        { TYPE_PNV_XSCOM_INTERFACE },
-        { }
-    }
+    .class_size    =3D sizeof(PnvLpcClass),
+    .abstract      =3D true,
 };
=20
 static void pnv_lpc_register_types(void)
 {
     type_register_static(&pnv_lpc_info);
+    type_register_static(&pnv_lpc_power8_info);
 }
=20
 type_init(pnv_lpc_register_types)
--=20
2.20.1
