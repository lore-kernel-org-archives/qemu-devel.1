Received: from eggs.gnu.org ([2001:4830:134:3::10]:34070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6lY-0000tH-2o
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6lV-000732-37
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:12 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49417 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs6lU-0006zV-Hp
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:08 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 15:31:43 +0200
Message-Id: <1534858316-12945-34-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534858316-12945-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534858316-12945-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v3 33/46] target/mips: Add emulation of DSP ASE
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
Cc: peter.maydell@linaro.org

From: Stefan Markovic <smarkovic@wavecomp.com>

Add emulation of DSP ASE instructions for nanoMIPS - part 5.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e713079..5575964 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17773,6 +17773,144 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
     tcg_temp_free(v1_t);
 }
 
+static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
+                                          int rt, int rs)
+{
+    int ret = rt;
+    TCGv t0 = tcg_temp_new();
+    TCGv v0_t = tcg_temp_new();
+
+    gen_load_gpr(v0_t, rs);
+
+    switch (opc) {
+    case NM_ABSQ_S_QB:
+        check_dspr2(ctx);
+        gen_helper_absq_s_qb(v0_t, v0_t, cpu_env);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_ABSQ_S_PH:
+        check_dsp(ctx);
+        gen_helper_absq_s_ph(v0_t, v0_t, cpu_env);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_ABSQ_S_W:
+        check_dsp(ctx);
+        gen_helper_absq_s_w(v0_t, v0_t, cpu_env);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_PRECEQ_W_PHL:
+        check_dsp(ctx);
+        tcg_gen_andi_tl(v0_t, v0_t, 0xFFFF0000);
+        tcg_gen_ext32s_tl(v0_t, v0_t);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_PRECEQ_W_PHR:
+        check_dsp(ctx);
+        tcg_gen_andi_tl(v0_t, v0_t, 0x0000FFFF);
+        tcg_gen_shli_tl(v0_t, v0_t, 16);
+        tcg_gen_ext32s_tl(v0_t, v0_t);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_PRECEQU_PH_QBL:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbl(v0_t, v0_t);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_PRECEQU_PH_QBR:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbr(v0_t, v0_t);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_PRECEQU_PH_QBLA:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbla(v0_t, v0_t);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_PRECEQU_PH_QBRA:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbra(v0_t, v0_t);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_PRECEU_PH_QBL:
+        check_dsp(ctx);
+        gen_helper_preceu_ph_qbl(v0_t, v0_t);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_PRECEU_PH_QBR:
+        check_dsp(ctx);
+        gen_helper_preceu_ph_qbr(v0_t, v0_t);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_PRECEU_PH_QBLA:
+        check_dsp(ctx);
+        gen_helper_preceu_ph_qbla(v0_t, v0_t);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_PRECEU_PH_QBRA:
+        check_dsp(ctx);
+        gen_helper_preceu_ph_qbra(v0_t, v0_t);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_REPLV_PH:
+        check_dsp(ctx);
+        tcg_gen_ext16u_tl(v0_t, v0_t);
+        tcg_gen_shli_tl(t0, v0_t, 16);
+        tcg_gen_or_tl(v0_t, v0_t, t0);
+        tcg_gen_ext32s_tl(v0_t, v0_t);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_REPLV_QB:
+        check_dsp(ctx);
+        tcg_gen_ext8u_tl(v0_t, v0_t);
+        tcg_gen_shli_tl(t0, v0_t, 8);
+        tcg_gen_or_tl(v0_t, v0_t, t0);
+        tcg_gen_shli_tl(t0, v0_t, 16);
+        tcg_gen_or_tl(v0_t, v0_t, t0);
+        tcg_gen_ext32s_tl(v0_t, v0_t);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_BITREV:
+        check_dsp(ctx);
+        gen_helper_bitrev(v0_t, v0_t);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_INSV:
+        check_dsp(ctx);
+        {
+            TCGv tv0 = tcg_temp_new();
+
+            gen_load_gpr(tv0, rt);
+            gen_helper_insv(v0_t, cpu_env, v0_t, tv0);
+            gen_store_gpr(v0_t, ret);
+            tcg_temp_free(tv0);
+        }
+        break;
+    case NM_RADDU_W_QB:
+        check_dsp(ctx);
+        gen_helper_raddu_w_qb(v0_t, v0_t);
+        gen_store_gpr(v0_t, ret);
+        break;
+    case NM_BITSWAP:
+        gen_bitswap(ctx, OPC_BITSWAP, ret, rs);
+        break;
+    case NM_CLO:
+        gen_cl(ctx, OPC_CLO, ret, rs);
+        break;
+    case NM_CLZ:
+        gen_cl(ctx, OPC_CLZ, ret, rs);
+        break;
+    case NM_WSBH:
+        gen_bshfl(ctx, OPC_WSBH, ret, rs);
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+
+    tcg_temp_free(v0_t);
+    tcg_temp_free(t0);
+}
+
 
 static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 {
@@ -17794,6 +17932,10 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_POOL32AXF_4:
+        {
+            int32_t op1 = extract32(ctx->opcode, 9, 7);
+            gen_pool32axf_4_nanomips_insn(ctx, op1, rt, rs);
+        }
         break;
     case NM_POOL32AXF_5:
         switch (extract32(ctx->opcode, 9, 7)) {
-- 
2.7.4
