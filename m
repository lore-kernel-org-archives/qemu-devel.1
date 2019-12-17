Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C6CC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EAC2072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VRnXcZ6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EAC2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5Rt-00005n-7Q
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jm-0002AD-CR
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ji-0007X5-9s
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:34 -0500
Received: from ozlabs.org ([203.11.71.1]:48103)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jg-000727-Fn; Mon, 16 Dec 2019 23:45:30 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWd4y1gz9sTG; Tue, 17 Dec 2019 15:43:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557821;
 bh=tUWiTimI4vG2ukDtApEV0gwVGlWRs2/TqcyikECZ2zc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VRnXcZ6exeFF/z3VWfvFvpnWGqEbs2cCvPyujP0s2xqLsatjYvQ0oSMmtbYU4f3AR
 EQLHMg4EIVk8Rhd1ve6wAeud905xKDX8huN8LtHsK+FjXdwM+TAUOfd4y7JFJVRdbV
 Cmc/KC7Chij604l1KZ23XY8iH7Gy9Zu2Pg6pAxPw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 64/88] ppc/pnv: add a PSI bridge model for POWER10
Date: Tue, 17 Dec 2019 15:42:58 +1100
Message-Id: <20191217044322.351838-65-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The POWER10 PSIHB controller is very similar to the one on POWER9. We
should probably introduce a common PnvPsiXive object.

The ESB page size should be changed to 64k when P10 support is ready.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191205184454.10722-5-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c               | 27 ++++++++++++++++++++-------
 hw/ppc/pnv_psi.c           | 25 ++++++++++++++++++++++++-
 include/hw/ppc/pnv.h       |  9 +++++++++
 include/hw/ppc/pnv_psi.h   |  2 ++
 include/hw/ppc/pnv_xscom.h |  3 +++
 5 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d99cd72840..09263ab747 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -647,9 +647,9 @@ static void pnv_ipmi_bt_init(ISABus *bus, IPMIBmc *bm=
c, uint32_t irq)
=20
 static void pnv_chip_power10_pic_print_info(PnvChip *chip, Monitor *mon)
 {
-    /*
-     * No interrupt controller yet
-     */;
+    Pnv10Chip *chip10 =3D PNV10_CHIP(chip);
+
+    pnv_psi_pic_print_info(&chip10->psi, mon);
 }
=20
 static void pnv_init(MachineState *machine)
@@ -1311,16 +1311,17 @@ static void pnv_chip_power9_class_init(ObjectClas=
s *klass, void *data)
=20
 static void pnv_chip_power10_instance_init(Object *obj)
 {
-    /*
-     * No controllers yet
-     */
-    ;
+    Pnv10Chip *chip10 =3D PNV10_CHIP(obj);
+
+    object_initialize_child(obj, "psi",  &chip10->psi, sizeof(chip10->ps=
i),
+                            TYPE_PNV10_PSI, &error_abort, NULL);
 }
=20
 static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(dev);
     PnvChip *chip =3D PNV_CHIP(dev);
+    Pnv10Chip *chip10 =3D PNV10_CHIP(dev);
     Error *local_err =3D NULL;
=20
     /* XSCOM bridge is first */
@@ -1336,6 +1337,18 @@ static void pnv_chip_power10_realize(DeviceState *=
dev, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
+
+    /* Processor Service Interface (PSI) Host Bridge */
+    object_property_set_int(OBJECT(&chip10->psi), PNV10_PSIHB_BASE(chip)=
,
+                            "bar", &error_fatal);
+    object_property_set_bool(OBJECT(&chip10->psi), true, "realized",
+                             &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_PSIHB_BASE,
+                            &PNV_PSI(&chip10->psi)->xscom_regs);
 }
=20
 static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index e6c266ac4a..572924388b 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -538,6 +538,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
=20
 static const char compat_p8[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
 static const char compat_p9[] =3D "ibm,power9-psihb-x\0ibm,psihb-x";
+static const char compat_p10[] =3D "ibm,power10-psihb-x\0ibm,psihb-x";
=20
 static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
 {
@@ -557,7 +558,10 @@ static int pnv_psi_dt_xscom(PnvXScomInterface *dev, =
void *fdt, int xscom_offset)
     _FDT(fdt_setprop(fdt, offset, "reg", reg, sizeof(reg)));
     _FDT(fdt_setprop_cell(fdt, offset, "#address-cells", 2));
     _FDT(fdt_setprop_cell(fdt, offset, "#size-cells", 1));
-    if (ppc->chip_type =3D=3D PNV_CHIP_POWER9) {
+    if (ppc->chip_type =3D=3D PNV_CHIP_POWER10) {
+        _FDT(fdt_setprop(fdt, offset, "compatible", compat_p10,
+                         sizeof(compat_p10)));
+    } else if (ppc->chip_type =3D=3D PNV_CHIP_POWER9) {
         _FDT(fdt_setprop(fdt, offset, "compatible", compat_p9,
                          sizeof(compat_p9)));
     } else {
@@ -909,6 +913,24 @@ static const TypeInfo pnv_psi_power9_info =3D {
     },
 };
=20
+static void pnv_psi_power10_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PnvPsiClass *ppc =3D PNV_PSI_CLASS(klass);
+
+    dc->desc    =3D "PowerNV PSI Controller POWER10";
+
+    ppc->chip_type  =3D PNV_CHIP_POWER10;
+    ppc->xscom_pcba =3D PNV10_XSCOM_PSIHB_BASE;
+    ppc->xscom_size =3D PNV10_XSCOM_PSIHB_SIZE;
+}
+
+static const TypeInfo pnv_psi_power10_info =3D {
+    .name          =3D TYPE_PNV10_PSI,
+    .parent        =3D TYPE_PNV9_PSI,
+    .class_init    =3D pnv_psi_power10_class_init,
+};
+
 static void pnv_psi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -938,6 +960,7 @@ static void pnv_psi_register_types(void)
     type_register_static(&pnv_psi_info);
     type_register_static(&pnv_psi_power8_info);
     type_register_static(&pnv_psi_power9_info);
+    type_register_static(&pnv_psi_power10_info);
 }
=20
 type_init(pnv_psi_register_types);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index bfa61edfba..47b7370b27 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -112,6 +112,9 @@ typedef struct Pnv9Chip {
 typedef struct Pnv10Chip {
     /*< private >*/
     PnvChip      parent_obj;
+
+    /*< public >*/
+    Pnv9Psi      psi;
 } Pnv10Chip;
=20
 typedef struct PnvChipClass {
@@ -326,4 +329,10 @@ IPMIBmc *pnv_bmc_create(void);
 #define PNV10_XSCOM_SIZE             0x0000000400000000ull
 #define PNV10_XSCOM_BASE(chip)       PNV10_CHIP_BASE(chip, 0x00603fc0000=
0000ull)
=20
+#define PNV10_PSIHB_ESB_SIZE        0x0000000000100000ull
+#define PNV10_PSIHB_ESB_BASE(chip)  PNV10_CHIP_BASE(chip, 0x000603020200=
0000ull)
+
+#define PNV10_PSIHB_SIZE            0x0000000000100000ull
+#define PNV10_PSIHB_BASE(chip)      PNV10_CHIP_BASE(chip, 0x000603020300=
0000ull)
+
 #endif /* PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index e82df9709f..a044aab304 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -69,6 +69,8 @@ typedef struct Pnv9Psi {
     XiveSource source;
 } Pnv9Psi;
=20
+#define TYPE_PNV10_PSI TYPE_PNV_PSI "-POWER10"
+
 #define PNV_PSI_CLASS(klass) \
      OBJECT_CLASS_CHECK(PnvPsiClass, (klass), TYPE_PNV_PSI)
 #define PNV_PSI_GET_CLASS(obj) \
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 790eb3d8f3..a40d2a2a2a 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -106,6 +106,9 @@ typedef struct PnvXScomInterfaceClass {
     ((uint64_t) PNV10_XSCOM_EQ_BASE(core) | PNV10_XSCOM_EC(core & 0x3))
 #define PNV10_XSCOM_EC_SIZE        0x100000
=20
+#define PNV10_XSCOM_PSIHB_BASE     0x3011D00
+#define PNV10_XSCOM_PSIHB_SIZE     0x100
+
 extern void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp=
);
 extern int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
=20
--=20
2.23.0


