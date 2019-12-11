Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6020C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 08:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DBB20836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 08:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DBB20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iexOb-0003Fu-Op
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 03:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iexNT-0001xZ-0q
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iexNR-0004GM-1G
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:29:46 -0500
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:42887)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iexNQ-0004Db-O3
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:29:44 -0500
Received: from player730.ha.ovh.net (unknown [10.108.42.5])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 197FF121865
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:29:42 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id 5F25CD03E88B;
 Wed, 11 Dec 2019 08:29:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 2/2] ppc/pnv: Fix OCC common area region mapping
Date: Wed, 11 Dec 2019 09:29:12 +0100
Message-Id: <20191211082912.2625-3-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191211082912.2625-1-clg@kaod.org>
References: <20191211082912.2625-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 12174918643125554150
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelgedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeftddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgepud
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.111.180
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, bala24@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---

 include/hw/ppc/pnv.h     |  4 ++++
 include/hw/ppc/pnv_occ.h |  8 ++++++--
 hw/ppc/pnv.c             |  4 ++--
 hw/ppc/pnv_occ.c         | 11 ++++-------
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 301c7e62fa73..92f80b1ccead 100644
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
index 66b0989be69d..f8d3061419dc 100644
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
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index af7317a86d2f..0be0b6b411c3 100644
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
index 765c0a6ce595..924fdabc9e63 100644
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
--=20
2.21.0


