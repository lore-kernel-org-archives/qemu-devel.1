Received: from eggs.gnu.org ([2001:4830:134:3::10]:40152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNos-0003xK-6Y
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNoq-0007Zd-To
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:34 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:8539)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNoq-0007ZQ-NA
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:32 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 21 Jul 2017 03:37:14 +0100
Message-ID: <1500604635-15027-14-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
References: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 13/14] target/mips: Add EVA support to P5600
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

From: James Hogan <james.hogan@imgtec.com>

Add the Enhanced Virtual Addressing (EVA) feature to the P5600 core
configuration, along with the related Segmentation Control (SC) feature
and writable CP0_EBase.WG bit.

This allows it to run Malta EVA kernels.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/translate_init.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
index 8f8196e..741b390 100644
--- a/target/mips/translate_init.c
+++ b/target/mips/translate_init.c
@@ -421,9 +421,9 @@ static const mips_def_t mips_defs[] =
     },
     {
         /* FIXME:
-         * Config3: CMGCR, SC, PW, VZ, CTXTC, CDMM, TL
+         * Config3: CMGCR, PW, VZ, CTXTC, CDMM, TL
          * Config4: MMUExtDef
-         * Config5: EVA, MRP
+         * Config5: MRP
          * FIR(FCR0): Has2008
          * */
         .name = "P5600",
@@ -436,13 +436,14 @@ static const mips_def_t mips_defs[] =
                        (1 << CP0C1_PC) | (1 << CP0C1_FP),
         .CP0_Config2 = MIPS_CONFIG2,
         .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_MSAP) |
-                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_ULRI) |
-                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
+                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_SC) |
+                       (1 << CP0C3_ULRI) | (1 << CP0C3_RXI) | (1 << CP0C3_LPA) |
+                       (1 << CP0C3_VInt),
         .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << CP0C4_IE) |
                        (0x1c << CP0C4_KScrExist),
         .CP0_Config4_rw_bitmask = 0,
-        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_MVH) | (1 << CP0C5_LLB) |
-                       (1 << CP0C5_MRP),
+        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_EVA) | (1 << CP0C5_MVH) |
+                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP),
         .CP0_Config5_rw_bitmask = (1 << CP0C5_K) | (1 << CP0C5_CV) |
                                   (1 << CP0C5_MSAEn) | (1 << CP0C5_UFE) |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFR),
@@ -453,6 +454,7 @@ static const mips_def_t mips_defs[] =
         .CP0_Status_rw_bitmask = 0x3C68FF1F,
         .CP0_PageGrain_rw_bitmask = (1U << CP0PG_RIE) | (1 << CP0PG_XIE) |
                     (1 << CP0PG_ELPA) | (1 << CP0PG_IEC),
+        .CP0_EBaseWG_rw_bitmask = (1 << CP0EBase_WG),
         .CP1_fcr0 = (1 << FCR0_FREP) | (1 << FCR0_UFRP) | (1 << FCR0_HAS2008) |
                     (1 << FCR0_F64) | (1 << FCR0_L) | (1 << FCR0_W) |
                     (1 << FCR0_D) | (1 << FCR0_S) | (0x03 << FCR0_PRID),
-- 
2.7.4
