Received: from eggs.gnu.org ([2001:4830:134:3::10]:37141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAy1-0000Qc-2F
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAxz-0000y6-Hz
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:24:17 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35697 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkAxz-0000xn-60
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:24:15 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:12:15 +0200
Message-Id: <1532967169-22265-43-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 42/76] target/mips: Add emulation of DSP ASE
 for nanoMIPS - part 5
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

Add emulation of DSP ASE instructions for nanoMIPS - part 5.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index bbc7788..132e40e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17401,6 +17401,148 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
     tcg_temp_free(v1_t);
 }
 
+static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
+                                          int ret, int v1, int v2)
+{
+    TCGv t0;
+    TCGv v0_t;
+    TCGv v1_t;
+
+    t0 = tcg_temp_new();
+
+    v0_t = tcg_temp_new();
+    v1_t = tcg_temp_new();
+
+    gen_load_gpr(v0_t, ret);
+    gen_load_gpr(v1_t, v1);
+
+    switch (opc) {
+    case NM_ABSQ_S_QB:
+        check_dspr2(ctx);
+        gen_helper_absq_s_qb(cpu_gpr[ret], v0_t, cpu_env);
+        break;
+    case NM_ABSQ_S_PH:
+        check_dsp(ctx);
+        gen_helper_absq_s_ph(cpu_gpr[ret], v1_t, cpu_env);
+        break;
+    case NM_ABSQ_S_W:
+        check_dsp(ctx);
+        gen_helper_absq_s_w(cpu_gpr[ret], v1_t, cpu_env);
+        break;
+    case NM_PRECEQ_W_PHL:
+        check_dsp(ctx);
+        tcg_gen_andi_tl(cpu_gpr[ret], v1_t, 0xFFFF0000);
+        tcg_gen_ext32s_tl(cpu_gpr[ret], cpu_gpr[ret]);
+        break;
+    case NM_PRECEQ_W_PHR:
+        check_dsp(ctx);
+        tcg_gen_andi_tl(cpu_gpr[ret], v1_t, 0x0000FFFF);
+        tcg_gen_shli_tl(cpu_gpr[ret], cpu_gpr[ret], 16);
+        tcg_gen_ext32s_tl(cpu_gpr[ret], cpu_gpr[ret]);
+        break;
+    case NM_PRECEQU_PH_QBL:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbl(cpu_gpr[ret], v1_t);
+        break;
+    case NM_PRECEQU_PH_QBR:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbr(cpu_gpr[ret], v1_t);
+        break;
+    case NM_PRECEQU_PH_QBLA:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbla(cpu_gpr[ret], v1_t);
+        break;
+    case NM_PRECEQU_PH_QBRA:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbra(cpu_gpr[ret], v1_t);
+        break;
+    case NM_PRECEU_PH_QBL:
+        check_dsp(ctx);
+        gen_helper_preceu_ph_qbl(cpu_gpr[ret], v1_t);
+        break;
+    case NM_PRECEU_PH_QBR:
+        check_dsp(ctx);
+        gen_helper_preceu_ph_qbr(cpu_gpr[ret], v1_t);
+        break;
+    case NM_PRECEU_PH_QBLA:
+        check_dsp(ctx);
+        gen_helper_preceu_ph_qbla(cpu_gpr[ret], v1_t);
+        break;
+    case NM_PRECEU_PH_QBRA:
+        check_dsp(ctx);
+        gen_helper_preceu_ph_qbra(cpu_gpr[ret], v1_t);
+        break;
+    case NM_REPLV_PH:
+        check_dsp(ctx);
+        tcg_gen_ext16u_tl(cpu_gpr[ret], v1_t);
+        tcg_gen_shli_tl(t0, cpu_gpr[ret], 16);
+        tcg_gen_or_tl(cpu_gpr[ret], cpu_gpr[ret], t0);
+        tcg_gen_ext32s_tl(cpu_gpr[ret], cpu_gpr[ret]);
+        break;
+    case NM_REPLV_QB:
+        check_dsp(ctx);
+        {
+            TCGv val_t;
+
+            val_t = tcg_temp_new();
+            gen_load_gpr(val_t, v1);
+
+            tcg_gen_ext8u_tl(cpu_gpr[ret], val_t);
+            tcg_gen_shli_tl(t0, cpu_gpr[ret], 8);
+            tcg_gen_or_tl(cpu_gpr[ret], cpu_gpr[ret], t0);
+            tcg_gen_shli_tl(t0, cpu_gpr[ret], 16);
+            tcg_gen_or_tl(cpu_gpr[ret], cpu_gpr[ret], t0);
+            tcg_gen_ext32s_tl(cpu_gpr[ret], cpu_gpr[ret]);
+        }
+        break;
+    case NM_BITREV:
+        check_dsp(ctx);
+        gen_helper_bitrev(cpu_gpr[ret], v1_t);
+        break;
+    case NM_INSV:
+        check_dsp(ctx);
+        {
+            TCGv tv0, tv1;
+
+            tv0 = tcg_temp_new();
+            tv1 = tcg_temp_new();
+
+            gen_load_gpr(tv0, ret);
+            gen_load_gpr(tv1, v1);
+
+            gen_helper_insv(cpu_gpr[ret], cpu_env, tv1, tv0);
+
+            tcg_temp_free(tv0);
+            tcg_temp_free(tv1);
+        }
+        break;
+    case NM_RADDU_W_QB:
+        check_dsp(ctx);
+        gen_helper_raddu_w_qb(cpu_gpr[ret], v1_t);
+        break;
+    case NM_BITSWAP:
+        gen_bitswap(ctx, OPC_BITSWAP, ret, v1);
+        break;
+    case NM_CLO:
+        gen_cl(ctx, OPC_CLO, ret, v1);
+        break;
+    case NM_CLZ:
+        gen_cl(ctx, OPC_CLZ, ret, v1);
+        break;
+    case NM_WSBH:
+        gen_bshfl(ctx, OPC_WSBH, ret, v1);
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+
+    tcg_temp_free(t0);
+
+    tcg_temp_free(v0_t);
+    tcg_temp_free(v1_t);
+}
+
 
 static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 {
@@ -17422,6 +17564,10 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_POOL32AXF_4:
+        {
+            int32_t op1 = extract32(ctx->opcode, 9, 7);
+            gen_pool32axf_4_nanomips_insn(ctx, op1, rt, rs, rd);
+        }
         break;
     case NM_POOL32AXF_5:
         switch (extract32(ctx->opcode, 9, 7)) {
-- 
2.7.4
