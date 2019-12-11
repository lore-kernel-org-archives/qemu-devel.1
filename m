Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90D8C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 08:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B9820836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 08:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B9820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iexPd-0004Pf-JO
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 03:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iexNM-0001nb-TQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iexNK-000462-RU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:29:40 -0500
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:40968)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iexNK-000438-Hb
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:29:38 -0500
Received: from player730.ha.ovh.net (unknown [10.108.54.52])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 94F0E21AE13
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:29:36 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id CB026D03E7E4;
 Wed, 11 Dec 2019 08:29:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/2] ppc/pnv: Introduce PBA registers
Date: Wed, 11 Dec 2019 09:29:11 +0100
Message-Id: <20191211082912.2625-2-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191211082912.2625-1-clg@kaod.org>
References: <20191211082912.2625-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 12173229795179072486
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelgedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeftddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.98.131
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

The PBA bridge unit (Power Bus Access) connects the OCC (On Chip
Controller) to the Power bus and System Memory. The PBA is used to
gather sensor data, for power management, for sleep states, for
initial boot, among other things.

The PBA logic provides a set of four registers PowerBus Access Base
Address Registers (PBABAR0..3) which map the OCC address space to the
PowerBus space. These registers are setup by the initial FW and define
the PowerBus Range of system memory that can be accessed by PBA.

The current modeling of the PBABAR registers is done under the common
XSCOM handlers. We introduce a specific XSCOM regions for these
registers and fix :

 - BAR sizes and BAR masks
 - The mapping of the OCC common area. It is common to all chips and
   should be mapped once.  We will address per-OCC area in the next
   change.
 - OCC common area is in BAR 3 on P8

Inspired by previous work of Balamuruhan S <bala24@linux.ibm.com>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h       |  16 ++----
 include/hw/ppc/pnv_homer.h |   3 +
 include/hw/ppc/pnv_xscom.h |   6 ++
 hw/ppc/pnv.c               |  12 +++-
 hw/ppc/pnv_homer.c         | 109 +++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_xscom.c         |  32 -----------
 6 files changed, 134 insertions(+), 44 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 56d1161515dd..301c7e62fa73 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -244,12 +244,10 @@ IPMIBmc *pnv_bmc_create(void);
 #define PNV_XSCOM_BASE(chip)                                            =
\
     (0x0003fc0000000000ull + ((uint64_t)(chip)->chip_id) * PNV_XSCOM_SIZ=
E)
=20
-#define PNV_OCC_COMMON_AREA_SIZE    0x0000000000700000ull
-#define PNV_OCC_COMMON_AREA(chip)                                       =
\
-    (0x7fff800000ull + ((uint64_t)PNV_CHIP_INDEX(chip) * \
-                         PNV_OCC_COMMON_AREA_SIZE))
+#define PNV_OCC_COMMON_AREA_SIZE    0x0000000000800000ull
+#define PNV_OCC_COMMON_AREA_BASE    0x7fff800000ull
=20
-#define PNV_HOMER_SIZE              0x0000000000300000ull
+#define PNV_HOMER_SIZE              0x0000000000400000ull
 #define PNV_HOMER_BASE(chip)                                            =
\
     (0x7ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV_HOMER_SIZE=
)
=20
@@ -312,12 +310,10 @@ IPMIBmc *pnv_bmc_create(void);
 #define PNV9_XSCOM_SIZE              0x0000000400000000ull
 #define PNV9_XSCOM_BASE(chip)        PNV9_CHIP_BASE(chip, 0x00603fc00000=
000ull)
=20
-#define PNV9_OCC_COMMON_AREA_SIZE    0x0000000000700000ull
-#define PNV9_OCC_COMMON_AREA(chip)                                      =
\
-    (0x203fff800000ull + ((uint64_t)PNV_CHIP_INDEX(chip) * \
-                           PNV9_OCC_COMMON_AREA_SIZE))
+#define PNV9_OCC_COMMON_AREA_SIZE    0x0000000000800000ull
+#define PNV9_OCC_COMMON_AREA_BASE    0x203fff800000ull
=20
-#define PNV9_HOMER_SIZE              0x0000000000300000ull
+#define PNV9_HOMER_SIZE              0x0000000000400000ull
 #define PNV9_HOMER_BASE(chip)                                           =
\
     (0x203ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV9_HOMER_S=
IZE)
=20
diff --git a/include/hw/ppc/pnv_homer.h b/include/hw/ppc/pnv_homer.h
index abaec43c2d62..1e91c950f691 100644
--- a/include/hw/ppc/pnv_homer.h
+++ b/include/hw/ppc/pnv_homer.h
@@ -33,6 +33,7 @@ typedef struct PnvHomer {
     DeviceState parent;
=20
     struct PnvChip *chip;
+    MemoryRegion pba_regs;
     MemoryRegion regs;
 } PnvHomer;
=20
@@ -44,6 +45,8 @@ typedef struct PnvHomer {
 typedef struct PnvHomerClass {
     DeviceClass parent_class;
=20
+    int pba_size;
+    const MemoryRegionOps *pba_ops;
     int homer_size;
     const MemoryRegionOps *homer_ops;
=20
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index a40d2a2a2a98..97b091afbe71 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -70,6 +70,9 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV_XSCOM_OCC_BASE        0x0066000
 #define PNV_XSCOM_OCC_SIZE        0x6000
=20
+#define PNV_XSCOM_PBA_BASE        0x2013f00
+#define PNV_XSCOM_PBA_SIZE        0x40
+
 /*
  * Layout of the XSCOM PCB addresses (POWER 9)
  */
@@ -84,6 +87,9 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV9_XSCOM_OCC_BASE       PNV_XSCOM_OCC_BASE
 #define PNV9_XSCOM_OCC_SIZE       0x8000
=20
+#define PNV9_XSCOM_PBA_BASE       0x5012b00
+#define PNV9_XSCOM_PBA_SIZE       0x40
+
 #define PNV9_XSCOM_PSIHB_BASE     0x5012900
 #define PNV9_XSCOM_PSIHB_SIZE     0x100
=20
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 67d0ad55b870..af7317a86d2f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1065,7 +1065,7 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
     pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip8->occ.xscom_=
regs);
=20
     /* OCC SRAM model */
-    memory_region_add_subregion(get_system_memory(), PNV_OCC_COMMON_AREA=
(chip),
+    memory_region_add_subregion(get_system_memory(), PNV_OCC_COMMON_AREA=
_BASE,
                                 &chip8->occ.sram_regs);
=20
     /* HOMER */
@@ -1077,6 +1077,10 @@ static void pnv_chip_power8_realize(DeviceState *d=
ev, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
+    /* Homer Xscom region */
+    pnv_xscom_add_subregion(chip, PNV_XSCOM_PBA_BASE, &chip8->homer.pba_=
regs);
+
+    /* Homer mmio region */
     memory_region_add_subregion(get_system_memory(), PNV_HOMER_BASE(chip=
),
                                 &chip8->homer.regs);
 }
@@ -1274,7 +1278,7 @@ static void pnv_chip_power9_realize(DeviceState *de=
v, Error **errp)
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.xscom=
_regs);
=20
     /* OCC SRAM model */
-    memory_region_add_subregion(get_system_memory(), PNV9_OCC_COMMON_ARE=
A(chip),
+    memory_region_add_subregion(get_system_memory(), PNV9_OCC_COMMON_ARE=
A_BASE,
                                 &chip9->occ.sram_regs);
=20
     /* HOMER */
@@ -1286,6 +1290,10 @@ static void pnv_chip_power9_realize(DeviceState *d=
ev, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
+    /* Homer Xscom region */
+    pnv_xscom_add_subregion(chip, PNV9_XSCOM_PBA_BASE, &chip9->homer.pba=
_regs);
+
+    /* Homer mmio region */
     memory_region_add_subregion(get_system_memory(), PNV9_HOMER_BASE(chi=
p),
                                 &chip9->homer.regs);
 }
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index 994a378108da..a08b7914f746 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -17,6 +17,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "exec/hwaddr.h"
 #include "exec/memory.h"
@@ -25,6 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_homer.h"
+#include "hw/ppc/pnv_xscom.h"
=20
=20
 static bool core_max_array(PnvHomer *homer, hwaddr addr)
@@ -114,10 +116,67 @@ static const MemoryRegionOps pnv_power8_homer_ops =3D=
 {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
+/* P8 PBA BARs */
+#define PBA_BAR0                     0x00
+#define PBA_BAR1                     0x01
+#define PBA_BAR2                     0x02
+#define PBA_BAR3                     0x03
+#define PBA_BARMASK0                 0x04
+#define PBA_BARMASK1                 0x05
+#define PBA_BARMASK2                 0x06
+#define PBA_BARMASK3                 0x07
+
+static uint64_t pnv_homer_power8_pba_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    PnvHomer *homer =3D PNV_HOMER(opaque);
+    PnvChip *chip =3D homer->chip;
+    uint32_t reg =3D addr >> 3;
+    uint64_t val =3D 0;
+
+    switch (reg) {
+    case PBA_BAR0:
+        val =3D PNV_HOMER_BASE(chip);
+        break;
+    case PBA_BARMASK0: /* P8 homer region mask */
+        val =3D (PNV_HOMER_SIZE - 1) & 0x300000;
+        break;
+    case PBA_BAR3: /* P8 occ common area */
+        val =3D PNV_OCC_COMMON_AREA_BASE;
+        break;
+    case PBA_BARMASK3: /* P8 occ common area mask */
+        val =3D (PNV_OCC_COMMON_AREA_SIZE - 1) & 0x700000;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "PBA: read to unimplemented register: O=
x%"
+                      HWADDR_PRIx "\n", addr >> 3);
+    }
+    return val;
+}
+
+static void pnv_homer_power8_pba_write(void *opaque, hwaddr addr,
+                                         uint64_t val, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "PBA: write to unimplemented register: Ox%"
+                  HWADDR_PRIx "\n", addr >> 3);
+}
+
+static const MemoryRegionOps pnv_homer_power8_pba_ops =3D {
+    .read =3D pnv_homer_power8_pba_read,
+    .write =3D pnv_homer_power8_pba_write,
+    .valid.min_access_size =3D 8,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 8,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
 static void pnv_homer_power8_class_init(ObjectClass *klass, void *data)
 {
     PnvHomerClass *homer =3D PNV_HOMER_CLASS(klass);
=20
+    homer->pba_size =3D PNV_XSCOM_PBA_SIZE;
+    homer->pba_ops =3D &pnv_homer_power8_pba_ops;
     homer->homer_size =3D PNV_HOMER_SIZE;
     homer->homer_ops =3D &pnv_power8_homer_ops;
     homer->core_max_base =3D PNV8_CORE_MAX_BASE;
@@ -210,10 +269,57 @@ static const MemoryRegionOps pnv_power9_homer_ops =3D=
 {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
+static uint64_t pnv_homer_power9_pba_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    PnvHomer *homer =3D PNV_HOMER(opaque);
+    PnvChip *chip =3D homer->chip;
+    uint32_t reg =3D addr >> 3;
+    uint64_t val =3D 0;
+
+    switch (reg) {
+    case PBA_BAR0:
+        val =3D PNV9_HOMER_BASE(chip);
+        break;
+    case PBA_BARMASK0: /* P9 homer region mask */
+        val =3D (PNV9_HOMER_SIZE - 1) & 0x300000;
+        break;
+    case PBA_BAR2: /* P9 occ common area */
+        val =3D PNV9_OCC_COMMON_AREA_BASE;
+        break;
+    case PBA_BARMASK2: /* P9 occ common area size */
+        val =3D (PNV9_OCC_COMMON_AREA_SIZE - 1) & 0x700000;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "PBA: read to unimplemented register: O=
x%"
+                      HWADDR_PRIx "\n", addr >> 3);
+    }
+    return val;
+}
+
+static void pnv_homer_power9_pba_write(void *opaque, hwaddr addr,
+                                         uint64_t val, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "PBA: write to unimplemented register: Ox%"
+                  HWADDR_PRIx "\n", addr >> 3);
+}
+
+static const MemoryRegionOps pnv_homer_power9_pba_ops =3D {
+    .read =3D pnv_homer_power9_pba_read,
+    .write =3D pnv_homer_power9_pba_write,
+    .valid.min_access_size =3D 8,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 8,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
 static void pnv_homer_power9_class_init(ObjectClass *klass, void *data)
 {
     PnvHomerClass *homer =3D PNV_HOMER_CLASS(klass);
=20
+    homer->pba_size =3D PNV9_XSCOM_PBA_SIZE;
+    homer->pba_ops =3D &pnv_homer_power9_pba_ops;
     homer->homer_size =3D PNV9_HOMER_SIZE;
     homer->homer_ops =3D &pnv_power9_homer_ops;
     homer->core_max_base =3D PNV9_CORE_MAX_BASE;
@@ -233,6 +339,9 @@ static void pnv_homer_realize(DeviceState *dev, Error=
 **errp)
=20
     assert(homer->chip);
=20
+    pnv_xscom_region_init(&homer->pba_regs, OBJECT(dev), hmrc->pba_ops,
+                          homer, "xscom-pba", hmrc->pba_size);
+
     /* homer region */
     memory_region_init_io(&homer->regs, OBJECT(dev),
                           hmrc->homer_ops, homer, "homer-main-memory",
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 277f65adeb87..6d3745a49e50 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -36,16 +36,6 @@
 #define PRD_P9_IPOLL_REG_MASK           0x000F0033
 #define PRD_P9_IPOLL_REG_STATUS         0x000F0034
=20
-/* PBA BARs */
-#define P8_PBA_BAR0                     0x2013f00
-#define P8_PBA_BAR2                     0x2013f02
-#define P8_PBA_BARMASK0                 0x2013f04
-#define P8_PBA_BARMASK2                 0x2013f06
-#define P9_PBA_BAR0                     0x5012b00
-#define P9_PBA_BAR2                     0x5012b02
-#define P9_PBA_BARMASK0                 0x5012b04
-#define P9_PBA_BARMASK2                 0x5012b06
-
 static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
 {
     /*
@@ -90,26 +80,6 @@ static uint64_t xscom_read_default(PnvChip *chip, uint=
32_t pcba)
     case 0x18002:       /* ECID2 */
         return 0;
=20
-    case P9_PBA_BAR0:
-        return PNV9_HOMER_BASE(chip);
-    case P8_PBA_BAR0:
-        return PNV_HOMER_BASE(chip);
-
-    case P9_PBA_BARMASK0: /* P9 homer region size */
-        return PNV9_HOMER_SIZE;
-    case P8_PBA_BARMASK0: /* P8 homer region size */
-        return PNV_HOMER_SIZE;
-
-    case P9_PBA_BAR2: /* P9 occ common area */
-        return PNV9_OCC_COMMON_AREA(chip);
-    case P8_PBA_BAR2: /* P8 occ common area */
-        return PNV_OCC_COMMON_AREA(chip);
-
-    case P9_PBA_BARMASK2: /* P9 occ common area size */
-        return PNV9_OCC_COMMON_AREA_SIZE;
-    case P8_PBA_BARMASK2: /* P8 occ common area size */
-        return PNV_OCC_COMMON_AREA_SIZE;
-
     case 0x1010c00:     /* PIBAM FIR */
     case 0x1010c03:     /* PIBAM FIR MASK */
=20
@@ -130,9 +100,7 @@ static uint64_t xscom_read_default(PnvChip *chip, uin=
t32_t pcba)
     case 0x202000f:     /* ADU stuff, receive status register*/
         return 0;
     case 0x2013f01:     /* PBA stuff */
-    case 0x2013f03:     /* PBA stuff */
     case 0x2013f05:     /* PBA stuff */
-    case 0x2013f07:     /* PBA stuff */
         return 0;
     case 0x2013028:     /* CAPP stuff */
     case 0x201302a:     /* CAPP stuff */
--=20
2.21.0


