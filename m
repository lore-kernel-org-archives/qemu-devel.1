Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A2CC47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C268B207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fpYffW91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C268B207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGK4a-0007Id-7U
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2G-0004qM-E1
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2E-000532-Sv
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:04 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52471)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2E-0004ze-H4; Fri, 04 Oct 2019 05:38:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YG0fgJz9sR5; Fri,  4 Oct 2019 19:37:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181874;
 bh=Zq79dKUo4IKHyr9fOQoxJC0hg42KjH7BDKBwv+bAE20=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fpYffW91TgVLQnJ2CahH3bk1G+FVxytpNpzVaFvVhZNOEXe2TaijT9e066+tCDHkw
 eOZHDImzDN8n2aPgQZOu4rNpTRGrGLU7Tlz465u3weFoOqJOKYDJkxR8un8kNBm5e1
 z1V8od6hAlMC0g2xzeHV7HJMYHroQVC8MQei6TCo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 06/53] hw/ppc/pnv_xscom: retrieve homer/occ base address from
 PBA BARs
Date: Fri,  4 Oct 2019 19:37:00 +1000
Message-Id: <20191004093747.31350-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
 qemu-ppc@nongnu.org, clg@kaod.org, Balamuruhan S <bala24@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Balamuruhan S <bala24@linux.ibm.com>

During PowerNV boot skiboot populates the device tree by
retrieving base address of homer/occ common area from
PBA BARs and prd ipoll mask by accessing xscom read/write
accesses.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
Message-Id: <20190912093056.4516-2-bala24@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_xscom.c   | 34 ++++++++++++++++++++++++++++++----
 include/hw/ppc/pnv.h | 18 ++++++++++++++++++
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 67aab98fef..f01d788a65 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -36,6 +36,16 @@
 #define PRD_P9_IPOLL_REG_MASK           0x000F0033
 #define PRD_P9_IPOLL_REG_STATUS         0x000F0034
=20
+/* PBA BARs */
+#define P8_PBA_BAR0                     0x2013f00
+#define P8_PBA_BAR2                     0x2013f02
+#define P8_PBA_BARMASK0                 0x2013f04
+#define P8_PBA_BARMASK2                 0x2013f06
+#define P9_PBA_BAR0                     0x5012b00
+#define P9_PBA_BAR2                     0x5012b02
+#define P9_PBA_BARMASK0                 0x5012b04
+#define P9_PBA_BARMASK2                 0x5012b06
+
 static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
 {
     /*
@@ -74,6 +84,26 @@ static uint64_t xscom_read_default(PnvChip *chip, uint=
32_t pcba)
     case 0x18002:       /* ECID2 */
         return 0;
=20
+    case P9_PBA_BAR0:
+        return PNV9_HOMER_BASE(chip);
+    case P8_PBA_BAR0:
+        return PNV_HOMER_BASE(chip);
+
+    case P9_PBA_BARMASK0: /* P9 homer region size */
+        return PNV9_HOMER_SIZE;
+    case P8_PBA_BARMASK0: /* P8 homer region size */
+        return PNV_HOMER_SIZE;
+
+    case P9_PBA_BAR2: /* P9 occ common area */
+        return PNV9_OCC_COMMON_AREA(chip);
+    case P8_PBA_BAR2: /* P8 occ common area */
+        return PNV_OCC_COMMON_AREA(chip);
+
+    case P9_PBA_BARMASK2: /* P9 occ common area size */
+        return PNV9_OCC_COMMON_AREA_SIZE;
+    case P8_PBA_BARMASK2: /* P8 occ common area size */
+        return PNV_OCC_COMMON_AREA_SIZE;
+
     case 0x1010c00:     /* PIBAM FIR */
     case 0x1010c03:     /* PIBAM FIR MASK */
=20
@@ -93,13 +123,9 @@ static uint64_t xscom_read_default(PnvChip *chip, uin=
t32_t pcba)
     case 0x2020009:     /* ADU stuff, error register */
     case 0x202000f:     /* ADU stuff, receive status register*/
         return 0;
-    case 0x2013f00:     /* PBA stuff */
     case 0x2013f01:     /* PBA stuff */
-    case 0x2013f02:     /* PBA stuff */
     case 0x2013f03:     /* PBA stuff */
-    case 0x2013f04:     /* PBA stuff */
     case 0x2013f05:     /* PBA stuff */
-    case 0x2013f06:     /* PBA stuff */
     case 0x2013f07:     /* PBA stuff */
         return 0;
     case 0x2013028:     /* CAPP stuff */
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index fb123edc4e..63a4b7b6a7 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -198,6 +198,16 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
 #define PNV_XSCOM_BASE(chip)                                            =
\
     (0x0003fc0000000000ull + ((uint64_t)(chip)->chip_id) * PNV_XSCOM_SIZ=
E)
=20
+#define PNV_OCC_COMMON_AREA_SIZE    0x0000000000700000ull
+#define PNV_OCC_COMMON_AREA(chip)                                       =
\
+    (0x7fff800000ull + ((uint64_t)PNV_CHIP_INDEX(chip) * \
+                         PNV_OCC_COMMON_AREA_SIZE))
+
+#define PNV_HOMER_SIZE              0x0000000000300000ull
+#define PNV_HOMER_BASE(chip)                                            =
\
+    (0x7ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV_HOMER_SIZE=
)
+
+
 /*
  * XSCOM 0x20109CA defines the ICP BAR:
  *
@@ -256,4 +266,12 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
 #define PNV9_XSCOM_SIZE              0x0000000400000000ull
 #define PNV9_XSCOM_BASE(chip)        PNV9_CHIP_BASE(chip, 0x00603fc00000=
000ull)
=20
+#define PNV9_OCC_COMMON_AREA_SIZE    0x0000000000700000ull
+#define PNV9_OCC_COMMON_AREA(chip)                                      =
\
+    (0x203fff800000ull + ((uint64_t)PNV_CHIP_INDEX(chip) * \
+                           PNV9_OCC_COMMON_AREA_SIZE))
+
+#define PNV9_HOMER_SIZE              0x0000000000300000ull
+#define PNV9_HOMER_BASE(chip)                                           =
\
+    (0x203ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV9_HOMER_S=
IZE)
 #endif /* PPC_PNV_H */
--=20
2.21.0


