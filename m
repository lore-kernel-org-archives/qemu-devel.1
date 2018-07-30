Received: from eggs.gnu.org ([2001:4830:134:3::10]:37220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAyI-0000fu-83
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAyH-00012i-DB
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:24:34 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:36481 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkAyH-00012R-65
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:24:33 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:12:16 +0200
Message-Id: <1532967169-22265-44-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 43/76] target/mips: Add emulation of DSP ASE
 for nanoMIPS - part 6
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

Add emulation of DSP ASE instructions for nanoMIPS - part 6.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 132e40e..5066eff 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17543,6 +17543,61 @@ static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
     tcg_temp_free(v1_t);
 }
 
+static void gen_pool32axf_7_nanomips_insn(DisasContext *ctx, uint32_t opc,
+                                          int ret, int v1, int v2)
+{
+    int16_t imm;
+
+    TCGv t0;
+    TCGv v1_t;
+
+    t0 = tcg_temp_new();
+    v1_t = tcg_temp_new();
+
+    gen_load_gpr(v1_t, v1);
+
+    switch (opc) {
+    case NM_SHRA_R_QB:
+        tcg_gen_movi_tl(t0, v2 >> 2);
+        switch (extract32(ctx->opcode, 12, 1)) {
+        case 0:
+            /* NM_SHRA_QB */
+            check_dspr2(ctx);
+            gen_helper_shra_qb(cpu_gpr[ret], t0, v1_t);
+            break;
+        case 1:
+            /* NM_SHRA_R_QB */
+            check_dspr2(ctx);
+            gen_helper_shra_r_qb(cpu_gpr[ret], t0, v1_t);
+            break;
+        }
+        break;
+    case NM_SHRL_PH:
+        check_dspr2(ctx);
+        tcg_gen_movi_tl(t0, v2 >> 1);
+        gen_helper_shrl_ph(cpu_gpr[ret], t0, v1_t);
+        break;
+    case NM_REPL_QB:
+        {
+            check_dsp(ctx);
+            target_long result;
+            imm = extract32(ctx->opcode, 13, 8);
+            result = (uint32_t)imm << 24 |
+                     (uint32_t)imm << 16 |
+                    (uint32_t)imm << 8  |
+                     (uint32_t)imm;
+            result = (int32_t)result;
+            tcg_gen_movi_tl(cpu_gpr[ret], result);
+        }
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+    tcg_temp_free(t0);
+    tcg_temp_free(v1_t);
+}
+
 
 static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 {
@@ -17644,6 +17699,10 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
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
