Received: from eggs.gnu.org ([2001:4830:134:3::10]:45832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fspmD-00052T-EP
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fspm9-0000Bu-A2
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:35:53 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41924 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fspm8-000089-Ga
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:35:49 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 23 Aug 2018 15:34:18 +0200
Message-Id: <1535031276-22911-29-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1535031276-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1535031276-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v4 28/46] target/mips: Implement MT ASE support
 for nanoMIPS
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

Add emulation of MT ASE instructions for nanoMIPS.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e0eb7e4..95632dd 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16989,7 +16989,7 @@ static void gen_pool16c_nanomips_insn(DisasContext *ctx)
     }
 }
 
-static void gen_pool32a0_nanomips_insn(DisasContext *ctx)
+static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 {
     int rt = extract32(ctx->opcode, 21, 5);
     int rs = extract32(ctx->opcode, 16, 5);
@@ -17157,6 +17157,87 @@ static void gen_pool32a0_nanomips_insn(DisasContext *ctx)
             tcg_temp_free(t0);
         }
         break;
+    case NM_D_E_MT_VPE:
+        {
+            uint8_t sc = extract32(ctx->opcode, 10, 1);
+            TCGv t0 = tcg_temp_new();
+
+            switch (sc) {
+            case 0:
+                if (rs == 1) {
+                    /* DMT */
+                    check_cp0_mt(ctx);
+                    gen_helper_dmt(t0);
+                    gen_store_gpr(t0, rt);
+                } else if (rs == 0) {
+                    /* DVPE */
+                    check_cp0_mt(ctx);
+                    gen_helper_dvpe(t0, cpu_env);
+                    gen_store_gpr(t0, rt);
+                } else {
+                    generate_exception_end(ctx, EXCP_RI);
+                }
+                break;
+            case 1:
+                if (rs == 1) {
+                    /* EMT */
+                    check_cp0_mt(ctx);
+                    gen_helper_emt(t0);
+                    gen_store_gpr(t0, rt);
+                } else if (rs == 0) {
+                    /* EVPE */
+                    check_cp0_mt(ctx);
+                    gen_helper_evpe(t0, cpu_env);
+                    gen_store_gpr(t0, rt);
+                } else {
+                    generate_exception_end(ctx, EXCP_RI);
+                }
+                break;
+            }
+
+            tcg_temp_free(t0);
+        }
+        break;
+    case NM_FORK:
+        check_mt(ctx);
+        {
+            TCGv t0 = tcg_temp_new();
+            TCGv t1 = tcg_temp_new();
+
+            gen_load_gpr(t0, rt);
+            gen_load_gpr(t1, rs);
+            gen_helper_fork(t0, t1);
+            tcg_temp_free(t0);
+            tcg_temp_free(t1);
+        }
+        break;
+    case NM_MFTR:
+    case NM_MFHTR:
+        check_cp0_enabled(ctx);
+        if (rd == 0) {
+            /* Treat as NOP. */
+            return;
+        }
+        gen_mftr(env, ctx, rs, rt, extract32(ctx->opcode, 10, 1),
+                 extract32(ctx->opcode, 11, 5), extract32(ctx->opcode, 3, 1));
+        break;
+    case NM_MTTR:
+    case NM_MTHTR:
+        check_cp0_enabled(ctx);
+        gen_mttr(env, ctx, rs, rt, extract32(ctx->opcode, 10, 1),
+                 extract32(ctx->opcode, 11, 5), extract32(ctx->opcode, 3, 1));
+        break;
+    case NM_YIELD:
+        check_mt(ctx);
+        {
+            TCGv t0 = tcg_temp_new();
+
+            gen_load_gpr(t0, rs);
+            gen_helper_yield(t0, cpu_env, t0);
+            gen_store_gpr(t0, rt);
+            tcg_temp_free(t0);
+        }
+        break;
 #endif
     default:
         generate_exception_end(ctx, EXCP_RI);
@@ -18049,7 +18130,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
     case NM_POOL32A:
         switch (ctx->opcode & 0x07) {
         case NM_POOL32A0:
-            gen_pool32a0_nanomips_insn(ctx);
+            gen_pool32a0_nanomips_insn(env, ctx);
             break;
         case NM_POOL32A7:
             switch (extract32(ctx->opcode, 3, 3)) {
-- 
2.7.4
