Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536BAC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7F520733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eBku1mLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7F520733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5YI-0000me-1o
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kV-0002r8-8u
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kT-00009j-SK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:19 -0500
Received: from ozlabs.org ([203.11.71.1]:35459)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4kT-00082r-GH; Mon, 16 Dec 2019 23:46:17 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWk0d4Fz9sRh; Tue, 17 Dec 2019 15:43:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557826;
 bh=IBWkRFwx/vIV/i59CX152JuOWpLUoM7587gE3heFvug=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eBku1mLSpKH5yermo1D60LiF7wiQEVVVmIgVLnPeASJoB4x/p83aQoYywdzxRxnQE
 43SeBw63KFz9T6QIaPxu+A8XrvV6rT/MpBvRzz9RQTjaDXQ0xhVXNHYtxZQVxRyjN7
 Pph3OezXuH8ZzNGkzcZ5ooeINv/UTWHBHl/OHhdI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 74/88] ppc/pnv: Fix OCC common area region mapping
Date: Tue, 17 Dec 2019 15:43:08 +1100
Message-Id: <20191217044322.351838-75-david@gibson.dropbear.id.au>
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

The OCC common area is mapped at a unique address on the system and
each OCC is assigned a segment to expose its sensor data :

  -----------------------------------------------------------------------=
--
  | Start (Offset from | End           | Size     |Description           =
 |
  | BAR2 base address) |               |          |                      =
 |
  -----------------------------------------------------------------------=
--
  |    0x00580000      |  0x005A57FF   |150kB     |OCC 0 Sensor Data Bloc=
k|
  |    0x005A5800      |  0x005CAFFF   |150kB     |OCC 1 Sensor Data Bloc=
k|
  |        :           |       :       |  :       |            :         =
 |
  |    0x00686800      |  0x006ABFFF   |150kB     |OCC 7 Sensor Data Bloc=
k|
  |    0x006AC000      |  0x006FFFFF   |336kB     |Reserved              =
 |
  -----------------------------------------------------------------------=
--

Maximum size is 1.5MB.

We could define a "OCC common area" memory region at the machine level
and sub regions for each OCC. But it adds some extra complexity to the
models. Fix the current layout with a simpler model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191211082912.2625-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c             |  4 ++--
 hw/ppc/pnv_occ.c         | 11 ++++-------
 include/hw/ppc/pnv.h     |  4 ++++
 include/hw/ppc/pnv_occ.h |  8 ++++++--
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index af7317a86d..0be0b6b411 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1065,7 +1065,7 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
     pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip8->occ.xscom_=
regs);
=20
     /* OCC SRAM model */
-    memory_region_add_subregion(get_system_memory(), PNV_OCC_COMMON_AREA=
_BASE,
+    memory_region_add_subregion(get_system_memory(), PNV_OCC_SENSOR_BASE=
(chip),
                                 &chip8->occ.sram_regs);
=20
     /* HOMER */
@@ -1278,7 +1278,7 @@ static void pnv_chip_power9_realize(DeviceState *de=
v, Error **errp)
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.xscom=
_regs);
=20
     /* OCC SRAM model */
-    memory_region_add_subregion(get_system_memory(), PNV9_OCC_COMMON_ARE=
A_BASE,
+    memory_region_add_subregion(get_system_memory(), PNV9_OCC_SENSOR_BAS=
E(chip),
                                 &chip9->occ.sram_regs);
=20
     /* HOMER */
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 765c0a6ce5..924fdabc9e 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -167,9 +167,7 @@ static void pnv_occ_power8_class_init(ObjectClass *kl=
ass, void *data)
     PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
=20
     poc->xscom_size =3D PNV_XSCOM_OCC_SIZE;
-    poc->sram_size =3D PNV_OCC_COMMON_AREA_SIZE;
     poc->xscom_ops =3D &pnv_occ_power8_xscom_ops;
-    poc->sram_ops =3D &pnv_occ_sram_ops;
     poc->psi_irq =3D PSIHB_IRQ_OCC;
 }
=20
@@ -240,9 +238,7 @@ static void pnv_occ_power9_class_init(ObjectClass *kl=
ass, void *data)
     PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
=20
     poc->xscom_size =3D PNV9_XSCOM_OCC_SIZE;
-    poc->sram_size =3D PNV9_OCC_COMMON_AREA_SIZE;
     poc->xscom_ops =3D &pnv_occ_power9_xscom_ops;
-    poc->sram_ops =3D &pnv_occ_sram_ops;
     poc->psi_irq =3D PSIHB9_IRQ_OCC;
 }
=20
@@ -266,9 +262,10 @@ static void pnv_occ_realize(DeviceState *dev, Error =
**errp)
     pnv_xscom_region_init(&occ->xscom_regs, OBJECT(dev), poc->xscom_ops,
                           occ, "xscom-occ", poc->xscom_size);
=20
-    /* XScom region for OCC SRAM registers */
-    pnv_xscom_region_init(&occ->sram_regs, OBJECT(dev), poc->sram_ops,
-                          occ, "occ-common-area", poc->sram_size);
+    /* OCC common area mmio region for OCC SRAM registers */
+    memory_region_init_io(&occ->sram_regs, OBJECT(dev), &pnv_occ_sram_op=
s,
+                          occ, "occ-common-area",
+                          PNV_OCC_SENSOR_DATA_BLOCK_SIZE);
 }
=20
 static Property pnv_occ_properties[] =3D {
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 301c7e62fa..92f80b1cce 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -246,6 +246,8 @@ IPMIBmc *pnv_bmc_create(void);
=20
 #define PNV_OCC_COMMON_AREA_SIZE    0x0000000000800000ull
 #define PNV_OCC_COMMON_AREA_BASE    0x7fff800000ull
+#define PNV_OCC_SENSOR_BASE(chip)   (PNV_OCC_COMMON_AREA_BASE + \
+    PNV_OCC_SENSOR_DATA_BLOCK_BASE(PNV_CHIP_INDEX(chip)))
=20
 #define PNV_HOMER_SIZE              0x0000000000400000ull
 #define PNV_HOMER_BASE(chip)                                            =
\
@@ -312,6 +314,8 @@ IPMIBmc *pnv_bmc_create(void);
=20
 #define PNV9_OCC_COMMON_AREA_SIZE    0x0000000000800000ull
 #define PNV9_OCC_COMMON_AREA_BASE    0x203fff800000ull
+#define PNV9_OCC_SENSOR_BASE(chip)   (PNV9_OCC_COMMON_AREA_BASE +       =
\
+    PNV_OCC_SENSOR_DATA_BLOCK_BASE(PNV_CHIP_INDEX(chip)))
=20
 #define PNV9_HOMER_SIZE              0x0000000000400000ull
 #define PNV9_HOMER_BASE(chip)                                           =
\
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index 66b0989be6..f8d3061419 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -29,6 +29,9 @@
 #define TYPE_PNV9_OCC TYPE_PNV_OCC "-POWER9"
 #define PNV9_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV9_OCC)
=20
+#define PNV_OCC_SENSOR_DATA_BLOCK_OFFSET 0x00580000
+#define PNV_OCC_SENSOR_DATA_BLOCK_SIZE   0x00025800
+
 typedef struct PnvOCC {
     DeviceState xd;
=20
@@ -50,10 +53,11 @@ typedef struct PnvOCCClass {
     DeviceClass parent_class;
=20
     int xscom_size;
-    int sram_size;
     const MemoryRegionOps *xscom_ops;
-    const MemoryRegionOps *sram_ops;
     int psi_irq;
 } PnvOCCClass;
=20
+#define PNV_OCC_SENSOR_DATA_BLOCK_BASE(i)                               =
\
+    (PNV_OCC_SENSOR_DATA_BLOCK_OFFSET + (i) * PNV_OCC_SENSOR_DATA_BLOCK_=
SIZE)
+
 #endif /* PPC_PNV_OCC_H */
--=20
2.23.0


