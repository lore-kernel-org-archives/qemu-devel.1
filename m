Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0365C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8FDC2464F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FDC2464F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icwFd-0002fa-Kk
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:53:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1icw8E-00065P-8s
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1icw8C-0001Su-Gi
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:45:41 -0500
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:39987)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1icw8C-0001M8-6f
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:45:40 -0500
Received: from player158.ha.ovh.net (unknown [10.109.143.72])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 50735116856
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 19:45:38 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id 241BECDB1560;
 Thu,  5 Dec 2019 18:45:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 4/5] ppc/pnv: add a PSI bridge model for POWER10
Date: Thu,  5 Dec 2019 19:44:53 +0100
Message-Id: <20191205184454.10722-5-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205184454.10722-1-clg@kaod.org>
References: <20191205184454.10722-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 5787688474466290662
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekuddguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudehkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.39.154
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The POWER10 PSIHB controller is very similar to the one on POWER9. We
should probably introduce a common PnvPsiXive object.

The ESB page size should be changed to 64k when P10 support is ready.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h       |  9 +++++++++
 include/hw/ppc/pnv_psi.h   |  2 ++
 include/hw/ppc/pnv_xscom.h |  3 +++
 hw/ppc/pnv.c               | 27 ++++++++++++++++++++-------
 hw/ppc/pnv_psi.c           | 25 ++++++++++++++++++++++++-
 5 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index bfa61edfbabd..47b7370b27d8 100644
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
index e82df9709fb8..a044aab304ae 100644
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
index 790eb3d8f3b0..a40d2a2a2a98 100644
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
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d99cd72840be..09263ab747d8 100644
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
index f15aaa5c9cc0..32e4cbdb09bb 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -539,6 +539,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
=20
 static const char compat_p8[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
 static const char compat_p9[] =3D "ibm,power9-psihb-x\0ibm,psihb-x";
+static const char compat_p10[] =3D "ibm,power10-psihb-x\0ibm,psihb-x";
=20
 static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
 {
@@ -558,7 +559,10 @@ static int pnv_psi_dt_xscom(PnvXScomInterface *dev, =
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
@@ -910,6 +914,24 @@ static const TypeInfo pnv_psi_power9_info =3D {
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
@@ -939,6 +961,7 @@ static void pnv_psi_register_types(void)
     type_register_static(&pnv_psi_info);
     type_register_static(&pnv_psi_power8_info);
     type_register_static(&pnv_psi_power9_info);
+    type_register_static(&pnv_psi_power10_info);
 }
=20
 type_init(pnv_psi_register_types);
--=20
2.21.0


