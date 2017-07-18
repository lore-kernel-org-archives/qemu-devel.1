Received: from eggs.gnu.org ([2001:4830:134:3::10]:47151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7S-0003yV-W7
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7Q-0005Kx-Uy
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:51 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:65244)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7Q-0005KT-LM
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:48 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 18 Jul 2017 12:55:58 +0100
Message-ID: <23192b07f6f0355b65da1a04fbd012a2cd48abfe.1500378931.git-series.james.hogan@imgtec.com>
In-Reply-To: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 13/14] target/mips: Add EVA support to P5600
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

Add the Enhanced Virtual Addressing (EVA) feature to the P5600 core
configuration, along with the related Segmentation Control (SC) feature
and writable CP0_EBase.WG bit.

This allows it to run Malta EVA kernels.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
Changes in v2:
- Rename CP0_EBase_rw_bitmask to CP0_EBaseWG_rw_bitmask (Yongbok).
---
 target/mips/translate_init.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
index 8f8196ed5a6d..741b39023744 100644
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
git-series 0.8.10
