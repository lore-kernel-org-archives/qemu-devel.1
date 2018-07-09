Received: from eggs.gnu.org ([2001:4830:134:3::10]:54673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fcd9R-0006Dm-E9
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 16:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fcd9O-0006Ze-CP
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 16:52:53 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33404 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fcd9O-0006ZD-0D
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 16:52:50 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  9 Jul 2018 22:50:14 +0200
Message-Id: <1531169431-10772-17-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 16/33] target/mips: Implement MT ASE support
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
Cc: f4bug@amsat.org, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add emulation of MT ASE instructions for nanoMIPS.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e18e279..c55d809 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16463,7 +16463,7 @@ static void gen_pool16c_nanomips_insn(DisasContext *ctx)
     }
 }
 
-static void gen_pool32a0_nanomips_insn(DisasContext *ctx)
+static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 {
     int rt = (ctx->opcode >> 21) & 0x1f;
     int rs = (ctx->opcode >> 16) & 0x1f;
@@ -16636,6 +16636,87 @@ static void gen_pool32a0_nanomips_insn(DisasContext *ctx)
             tcg_temp_free(t0);
         }
         break;
+    case NM_D_E_MT_VPE:
+        {
+            uint8_t sc = (ctx->opcode >> 10) & 1;
+            TCGv t0 = tcg_temp_new();
+
+            switch (sc) {
+            case 0:
+                if (rs == 1) {
+                    /* DMT */
+                    check_insn(ctx, ASE_MT);
+                    gen_helper_dmt(t0);
+                    gen_store_gpr(t0, rt);
+                } else if (rs == 0) {
+                    /* DVPE */
+                    check_insn(ctx, ASE_MT);
+                    gen_helper_dvpe(t0, cpu_env);
+                    gen_store_gpr(t0, rt);
+                } else {
+                    generate_exception_end(ctx, EXCP_RI);
+                }
+                break;
+            case 1:
+                if (rs == 1) {
+                    /* EMT */
+                    check_insn(ctx, ASE_MT);
+                    gen_helper_emt(t0);
+                    gen_store_gpr(t0, rt);
+                } else if (rs == 0) {
+                    /* EVPE */
+                    check_insn(ctx, ASE_MT);
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
+    break;
+    case NM_FORK:
+        check_insn(ctx, ASE_MT);
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
+        check_insn(ctx, ASE_MT);
+        if (rd == 0) {
+            /* Treat as NOP. */
+            return;
+        }
+        gen_mftr(env, ctx, rs, rt, (ctx->opcode >> 10) & 1,
+                 (ctx->opcode >> 11) & 0x1f, (ctx->opcode >> 3) & 1);
+        break;
+    case NM_MTTR:
+    case NM_MTHTR:
+        check_insn(ctx, ASE_MT);
+        gen_mttr(env, ctx, rs, rt, (ctx->opcode >> 10) & 1,
+                 (ctx->opcode >> 11) & 0x1f, (ctx->opcode >> 3) & 1);
+        break;
+    case NM_YIELD:
+        check_insn(ctx, ASE_MT);
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
@@ -17385,7 +17466,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
     case NM_POOL32A:
         switch (ctx->opcode & 0x07) {
         case NM_POOL32A0:
-            gen_pool32a0_nanomips_insn(ctx);
+            gen_pool32a0_nanomips_insn(env, ctx);
             break;
         case NM_POOL32A7:
         {
-- 
2.7.4
