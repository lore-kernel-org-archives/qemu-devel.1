Received: from eggs.gnu.org ([2001:4830:134:3::10]:40149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1Lm-0002iw-Rb
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1Ll-0001DB-MV
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:43:54 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46010 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fi1Ll-0001Br-Ac
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:43:53 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 24 Jul 2018 19:31:15 +0200
Message-Id: <1532453527-22911-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 03/55] target/mips: Add nanoMIPS DSP ASE
 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add nanoMIPS opcodes for DSP ASE instruction pools and instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6a99a61..227b2c0 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16142,10 +16142,154 @@ enum {
 
 /* POOL32Axf instruction pool */
 enum {
+    NM_POOL32AXF_1 = 0x01,
+    NM_POOL32AXF_2 = 0x02,
     NM_POOL32AXF_4 = 0x04,
     NM_POOL32AXF_5 = 0x05,
+    NM_POOL32AXF_7 = 0x07,
 };
 
+/* POOL32Axf_1 instruction pool */
+enum {
+    NM_POOL32AXF_1_0 = 0x00,
+    NM_POOL32AXF_1_1 = 0x01,
+    NM_POOL32AXF_1_3 = 0x03,
+    NM_POOL32AXF_1_4 = 0x04,
+    NM_POOL32AXF_1_5 = 0x05,
+    NM_POOL32AXF_1_7 = 0x07,
+};
+
+/* POOL32Axf_2 instruction pool */
+enum {
+    NM_POOL32AXF_2_0_7     = 0x00,
+    NM_POOL32AXF_2_8_15    = 0x01,
+    NM_POOL32AXF_2_16_23   = 0x02,
+    NM_POOL32AXF_2_24_31   = 0x03,
+};
+
+/* POOL32Axf_{4, 5} instruction pool */
+enum {
+    /* nanoMIPS DSP instructions */
+    NM_ABSQ_S_QB        = 0x00,
+    NM_ABSQ_S_PH        = 0x08,
+    NM_ABSQ_S_W         = 0x10,
+    NM_PRECEQ_W_PHL     = 0x28,
+    NM_PRECEQ_W_PHR     = 0x30,
+    NM_PRECEQU_PH_QBL   = 0x38,
+    NM_PRECEQU_PH_QBR   = 0x48,
+    NM_PRECEU_PH_QBL    = 0x58,
+    NM_PRECEU_PH_QBR    = 0x68,
+    NM_PRECEQU_PH_QBLA  = 0x39,
+    NM_PRECEQU_PH_QBRA  = 0x49,
+    NM_PRECEU_PH_QBLA   = 0x59,
+    NM_PRECEU_PH_QBRA   = 0x69,
+    NM_REPLV_PH         = 0x01,
+    NM_REPLV_QB         = 0x09,
+    NM_BITREV           = 0x18,
+    NM_INSV             = 0x20,
+    NM_RADDU_W_QB       = 0x78,
+
+    NM_BITSWAP          = 0x05,
+    NM_WSBH             = 0x3d,
+};
+
+/* POOL32Axf_7 instruction pool */
+enum {
+    NM_SHRA_R_QB    = 0x0,
+    NM_SHRL_PH      = 0x1,
+    NM_REPL_QB      = 0x2,
+};
+
+/* POOL32Axf_1_0 instruction pool */
+enum {
+    NM_MFHI = 0x0,
+    NM_MFLO = 0x1,
+    NM_MTHI = 0x2,
+    NM_MTLO = 0x3,
+};
+
+/* POOL32Axf_1_1 instruction pool */
+enum {
+    NM_MTHLIP = 0x0,
+    NM_SHILOV = 0x1,
+};
+
+/* POOL32Axf_1_3 instruction pool */
+enum {
+    NM_RDDSP    = 0x0,
+    NM_WRDSP    = 0x1,
+    NM_EXTP     = 0x2,
+    NM_EXTPDP   = 0x3,
+};
+
+/* POOL32Axf_1_4 instruction pool */
+enum {
+    NM_SHLL_QB  = 0x0,
+    NM_SHRL_QB  = 0x1,
+};
+
+/* POOL32Axf_1_5 instruction pool */
+enum {
+    NM_MAQ_S_W_PHR   = 0x0,
+    NM_MAQ_S_W_PHL   = 0x1,
+    NM_MAQ_SA_W_PHR  = 0x2,
+    NM_MAQ_SA_W_PHL  = 0x3,
+};
+
+/* POOL32Axf_1_7 instruction pool */
+enum {
+    NM_EXTR_W       = 0x0,
+    NM_EXTR_R_W     = 0x1,
+    NM_EXTR_RS_W    = 0x2,
+    NM_EXTR_S_H     = 0x3,
+};
+
+/* POOL32Axf_2_0_7 instruction pool */
+enum {
+    NM_DPA_W_PH     = 0x0,
+    NM_DPAQ_S_W_PH  = 0x1,
+    NM_DPS_W_PH     = 0x2,
+    NM_DPSQ_S_W_PH  = 0x3,
+    NM_BALIGN       = 0x4,
+    NM_MADD         = 0x5,
+    NM_MULT         = 0x6,
+    NM_EXTRV_W      = 0x7,
+};
+
+/* POOL32Axf_2_8_15 instruction pool */
+enum {
+    NM_DPAX_W_PH    = 0x0,
+    NM_DPAQ_SA_L_W  = 0x1,
+    NM_DPSX_W_PH    = 0x2,
+    NM_DPSQ_SA_L_W  = 0x3,
+    NM_MADDU        = 0x5,
+    NM_MULTU        = 0x6,
+    NM_EXTRV_R_W    = 0x7,
+};
+
+/* POOL32Axf_2_16_23 instruction pool */
+enum {
+    NM_DPAU_H_QBL       = 0x0,
+    NM_DPAQX_S_W_PH     = 0x1,
+    NM_DPSU_H_QBL       = 0x2,
+    NM_DPSQX_S_W_PH     = 0x3,
+    NM_EXTPV            = 0x4,
+    NM_MSUB             = 0x5,
+    NM_MULSA_W_PH       = 0x6,
+    NM_EXTRV_RS_W       = 0x7,
+};
+
+/* POOL32Axf_2_24_31 instruction pool */
+enum {
+    NM_DPAU_H_QBR       = 0x0,
+    NM_DPAQX_SA_W_PH    = 0x1,
+    NM_DPSU_H_QBR       = 0x2,
+    NM_DPSQX_SA_W_PH    = 0x3,
+    NM_EXTPDPV          = 0x4,
+    NM_MSUBU            = 0x5,
+    NM_MULSAQ_S_W_PH    = 0x6,
+    NM_EXTRV_S_H        = 0x7,
+};
 /* POOL32Axf_{4, 5} instruction pool */
 enum {
     NM_CLO      = 0x25,
-- 
2.7.4
