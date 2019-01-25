Received: from eggs.gnu.org ([209.51.188.92]:46484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gn1aK-0002lq-LH
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gn1aJ-0002YG-9g
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:31:52 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36395 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gn1aI-0002WG-IO
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:31:51 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 25 Jan 2019 14:31:32 +0100
Message-Id: <1548423098-31864-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 08/14] target/mips: Add I6500 core configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Yongbok Kim <yongbok.kim@imgtec.com>

Add I6500 core configuration. Note that this configuration is
supported only on best-effort basis due to the lack of certain
features in QEMU.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate_init.inc.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index acab097..bf559af 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -722,6 +722,46 @@ const mips_def_t mips_defs[] =
         .mmu_type = MMU_TYPE_R4000,
     },
     {
+        .name = "I6500",
+        .CP0_PRid = 0x1B000,
+        .CP0_Config0 = MIPS_CONFIG0 | (0x2 << CP0C0_AR) | (0x2 << CP0C0_AT) |
+                       (MMU_TYPE_R4000 << CP0C0_MT),
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (15 << CP0C1_MMU) |
+                       (2 << CP0C1_IS) | (5 << CP0C1_IL) | (3 << CP0C1_IA) |
+                       (2 << CP0C1_DS) | (5 << CP0C1_DL) | (3 << CP0C1_DA) |
+                       (0 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
+        .CP0_Config2 = MIPS_CONFIG2,
+        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) |
+                       (1 << CP0C3_CMGCR) | (1 << CP0C3_MSAP) |
+                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_ULRI) |
+                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
+        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) |
+                       (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
+        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP) |
+                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP),
+        .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI) |
+                                  (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
+        .CP0_LLAddr_rw_bitmask = 0,
+        .CP0_LLAddr_shift = 0,
+        .SYNCI_Step = 64,
+        .CCRes = 2,
+        .CP0_Status_rw_bitmask = 0x30D8FFFF,
+        .CP0_PageGrain = (1 << CP0PG_IEC) | (1 << CP0PG_XIE) |
+                         (1U << CP0PG_RIE),
+        .CP0_PageGrain_rw_bitmask = (1 << CP0PG_ELPA),
+        .CP0_EBaseWG_rw_bitmask = (1 << CP0EBase_WG),
+        .CP1_fcr0 = (1 << FCR0_FREP) | (1 << FCR0_HAS2008) | (1 << FCR0_F64) |
+                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
+                    (1 << FCR0_S) | (0x03 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),
+        .CP1_fcr31_rw_bitmask = 0x0103FFFF,
+        .MSAIR = 0x03 << MSAIR_ProcID,
+        .SEGBITS = 48,
+        .PABITS = 48,
+        .insn_flags = CPU_MIPS64R6 | ASE_MSA,
+        .mmu_type = MMU_TYPE_R4000,
+    },
+    {
         .name = "Loongson-2E",
         .CP0_PRid = 0x6302,
         /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.  */
-- 
2.7.4
