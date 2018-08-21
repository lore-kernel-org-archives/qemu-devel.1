Received: from eggs.gnu.org ([2001:4830:134:3::10]:41513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs5tL-00024R-TT
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs5tI-0007OG-IP
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:11 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34906 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs5tH-0007KU-Ne
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:08 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 14:35:39 +0200
Message-Id: <1534854951-6321-35-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534854951-6321-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534854951-6321-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 34/46] target/mips: Add emulation of DSP ASE for
 nanoMIPS - part 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Stefan Markovic <smarkovic@wavecomp.com>

Add emulation of DSP ASE instructions for nanoMIPS - part 6.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 5575964..89ccb95 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17911,6 +17911,60 @@ static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
     tcg_temp_free(t0);
 }
 
+static void gen_pool32axf_7_nanomips_insn(DisasContext *ctx, uint32_t opc,
+                                          int rt, int rs, int rd)
+{
+    TCGv t0 = tcg_temp_new();
+    TCGv rs_t = tcg_temp_new();
+
+    gen_load_gpr(rs_t, rs);
+
+    switch (opc) {
+    case NM_SHRA_R_QB:
+        check_dspr2(ctx);
+        tcg_gen_movi_tl(t0, rd >> 2);
+        switch (extract32(ctx->opcode, 12, 1)) {
+        case 0:
+            /* NM_SHRA_QB */
+            gen_helper_shra_qb(t0, t0, rs_t);
+            gen_store_gpr(t0, rt);
+            break;
+        case 1:
+            /* NM_SHRA_R_QB */
+            gen_helper_shra_r_qb(t0, t0, rs_t);
+            gen_store_gpr(t0, rt);
+            break;
+        }
+        break;
+    case NM_SHRL_PH:
+        check_dspr2(ctx);
+        tcg_gen_movi_tl(t0, rd >> 1);
+        gen_helper_shrl_ph(t0, t0, rs_t);
+        gen_store_gpr(t0, rt);
+        break;
+    case NM_REPL_QB:
+        check_dsp(ctx);
+        {
+            int16_t imm;
+            target_long result;
+            imm = extract32(ctx->opcode, 13, 8);
+            result = (uint32_t)imm << 24 |
+                     (uint32_t)imm << 16 |
+                     (uint32_t)imm << 8  |
+                     (uint32_t)imm;
+            result = (int32_t)result;
+            tcg_gen_movi_tl(t0, result);
+            gen_store_gpr(t0, rt);
+        }
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+    tcg_temp_free(t0);
+    tcg_temp_free(rs_t);
+}
+
 
 static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 {
@@ -18006,6 +18060,10 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_POOL32AXF_7:
+        {
+            int32_t op1 = extract32(ctx->opcode, 9, 3);
+            gen_pool32axf_7_nanomips_insn(ctx, op1, rt, rs, rd);
+        }
         break;
     default:
         generate_exception_end(ctx, EXCP_RI);
-- 
2.7.4
