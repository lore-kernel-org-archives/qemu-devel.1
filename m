Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BEFC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5544020896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5544020896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34138 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb7LJ-0003BH-AZ
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 13:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42048)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hb7I1-0001F3-Vi
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hb7I0-0005za-Bb
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:44:01 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:34977)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hb7I0-0005xi-3Q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:44:00 -0400
Received: from player792.ha.ovh.net (unknown [10.109.143.238])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 6C3F619E7EC
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 19:43:58 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id 201CD6D91683;
 Wed, 12 Jun 2019 17:43:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 12 Jun 2019 19:43:44 +0200
Message-Id: <20190612174345.9799-2-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612174345.9799-1-clg@kaod.org>
References: <20190612174345.9799-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 4169770307637316582
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehjedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.58.226
Subject: [Qemu-devel] [PATCH 1/2] ppc/pnc: fix XSCOM MMIO base address for
 P9 machines with multiple chips
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PNV_XSCOM_BASE and PNV_XSCOM_SIZE macros are specific to POWER8
and they are used when the device tree is populated and the MMIO
region created, even for POWER9 chips. This is not too much of a
problem today because we don't have important devices on the second
chip, but we might have oneday (PHBs).

Fix by using the appropriate macros in case of P9.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h       |  3 +++
 include/hw/ppc/pnv_xscom.h |  2 +-
 hw/ppc/pnv.c               | 24 ++++++++++++++++--------
 hw/ppc/pnv_xscom.c         | 17 ++++++++++++-----
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 703e5ef222de..aa926d120771 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -283,4 +283,7 @@ int pnv_bmc_hiomap(IPMIBmc *bmc);
 #define PNV9_PSIHB_ESB_SIZE          0x0000000000010000ull
 #define PNV9_PSIHB_ESB_BASE(chip)    PNV9_CHIP_BASE(chip, 0x00060302031c=
0000ull)
=20
+#define PNV9_XSCOM_SIZE              0x0000000400000000ull
+#define PNV9_XSCOM_BASE(chip)        PNV9_CHIP_BASE(chip, 0x00603fc00000=
000ull)
+
 #endif /* PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 7ddc82c3a288..78fcf88a495b 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -102,7 +102,7 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV9_XSCOM_PEC_PCI_BASE   0xd010800
 #define PNV9_XSCOM_PEC_PCI_SIZE   0x200
=20
-extern void pnv_xscom_realize(PnvChip *chip, Error **errp);
+extern void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp=
);
 extern int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
=20
 extern void pnv_xscom_add_subregion(PnvChip *chip, hwaddr offset,
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7b60c97339dd..92c01dfc09ef 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -902,6 +902,14 @@ static void pnv_chip_power8_realize(DeviceState *dev=
, Error **errp)
     Error *local_err =3D NULL;
     int i;
=20
+    /* XSCOM bridge is first */
+    pnv_xscom_realize(chip, PNV_XSCOM_SIZE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
+
     pcc->parent_realize(dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1092,6 +1100,14 @@ static void pnv_chip_power9_realize(DeviceState *d=
ev, Error **errp)
     Error *local_err =3D NULL;
     uint32_t i;
=20
+    /* XSCOM bridge is first */
+    pnv_xscom_realize(chip, PNV9_XSCOM_SIZE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV9_XSCOM_BASE(chip));
+
     pcc->parent_realize(dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1301,14 +1317,6 @@ static void pnv_chip_realize(DeviceState *dev, Err=
or **errp)
     PnvChip *chip =3D PNV_CHIP(dev);
     Error *error =3D NULL;
=20
-    /* XSCOM bridge */
-    pnv_xscom_realize(chip, &error);
-    if (error) {
-        error_propagate(errp, error);
-        return;
-    }
-    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
-
     /* Cores */
     pnv_chip_core_realize(chip, &error);
     if (error) {
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index cc7c66320f23..770176326526 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -211,17 +211,17 @@ const MemoryRegionOps pnv_xscom_ops =3D {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
-void pnv_xscom_realize(PnvChip *chip, Error **errp)
+void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp)
 {
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(chip);
     char *name;
=20
     name =3D g_strdup_printf("xscom-%x", chip->chip_id);
     memory_region_init_io(&chip->xscom_mmio, OBJECT(chip), &pnv_xscom_op=
s,
-                          chip, name, PNV_XSCOM_SIZE);
+                          chip, name, size);
     sysbus_init_mmio(sbd, &chip->xscom_mmio);
=20
-    memory_region_init(&chip->xscom, OBJECT(chip), name, PNV_XSCOM_SIZE)=
;
+    memory_region_init(&chip->xscom, OBJECT(chip), name, size);
     address_space_init(&chip->xscom_as, &chip->xscom, name);
     g_free(name);
 }
@@ -263,12 +263,19 @@ static const char compat_p9[] =3D "ibm,power9-xscom=
\0ibm,xscom";
=20
 int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset)
 {
-    uint64_t reg[] =3D { cpu_to_be64(PNV_XSCOM_BASE(chip)),
-                       cpu_to_be64(PNV_XSCOM_SIZE) };
+    uint64_t reg[2];
     int xscom_offset;
     ForeachPopulateArgs args;
     char *name;
=20
+    if (pnv_chip_is_power9(chip)) {
+        reg[0] =3D cpu_to_be64(PNV9_XSCOM_BASE(chip));
+        reg[1] =3D cpu_to_be64(PNV9_XSCOM_SIZE);
+    } else {
+        reg[0] =3D cpu_to_be64(PNV_XSCOM_BASE(chip));
+        reg[1] =3D cpu_to_be64(PNV_XSCOM_SIZE);
+    }
+
     name =3D g_strdup_printf("xscom@%" PRIx64, be64_to_cpu(reg[0]));
     xscom_offset =3D fdt_add_subnode(fdt, root_offset, name);
     _FDT(xscom_offset);
--=20
2.21.0


