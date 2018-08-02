Received: from eggs.gnu.org ([2001:4830:134:3::10]:58727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEc3-0002V2-GG
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEbz-00043f-Iw
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:29:59 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60823 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1flEbz-00042u-7S
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:29:55 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu,  2 Aug 2018 16:16:18 +0200
Message-Id: <1533219424-7627-32-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 31/77] target/mips: Add emulation of misc
 nanoMIPS instructions (pool32axf)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of misc nanoMIPS instructions situated in pool32axf.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 19f011e..7cc1a92 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16772,6 +16772,87 @@ static void gen_pool32a0_nanomips_insn(DisasContext *ctx)
     }
 }
 
+static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
+{
+    int rt = extract32(ctx->opcode, 21, 5);
+    int rs = extract32(ctx->opcode, 16, 5);
+
+    switch (extract32(ctx->opcode, 6, 3)) {
+    case NM_POOL32AXF_4:
+    case NM_POOL32AXF_5:
+        switch (extract32(ctx->opcode, 9, 7)) {
+#ifndef CONFIG_USER_ONLY
+        case NM_TLBP:
+            gen_cp0(env, ctx, OPC_TLBP, 0, 0);
+            break;
+        case NM_TLBR:
+            gen_cp0(env, ctx, OPC_TLBR, 0, 0);
+            break;
+        case NM_TLBWI:
+            gen_cp0(env, ctx, OPC_TLBWI, 0, 0);
+            break;
+        case NM_TLBWR:
+            gen_cp0(env, ctx, OPC_TLBWR, 0, 0);
+            break;
+        case NM_TLBINV:
+            gen_cp0(env, ctx, OPC_TLBINV, 0, 0);
+            break;
+        case NM_TLBINVF:
+            gen_cp0(env, ctx, OPC_TLBINVF, 0, 0);
+            break;
+        case NM_DI:
+            check_cp0_enabled(ctx);
+            {
+                TCGv t0 = tcg_temp_new();
+
+                save_cpu_state(ctx, 1);
+                gen_helper_di(t0, cpu_env);
+                gen_store_gpr(t0, rt);
+            /* Stop translation as we may have switched the execution mode */
+                ctx->base.is_jmp = DISAS_STOP;
+                tcg_temp_free(t0);
+            }
+            break;
+        case NM_EI:
+            check_cp0_enabled(ctx);
+            {
+                TCGv t0 = tcg_temp_new();
+
+                save_cpu_state(ctx, 1);
+                gen_helper_ei(t0, cpu_env);
+                gen_store_gpr(t0, rt);
+            /* Stop translation as we may have switched the execution mode */
+                ctx->base.is_jmp = DISAS_STOP;
+                tcg_temp_free(t0);
+            }
+            break;
+        case NM_RDPGPR:
+            gen_load_srsgpr(rs, rt);
+            break;
+        case NM_WRPGPR:
+            gen_store_srsgpr(rs, rt);
+            break;
+        case NM_WAIT:
+            gen_cp0(env, ctx, OPC_WAIT, 0, 0);
+            break;
+        case NM_DERET:
+            gen_cp0(env, ctx, OPC_DERET, 0, 0);
+            break;
+        case NM_ERETX:
+            gen_cp0(env, ctx, OPC_ERET, 0, 0);
+            break;
+#endif
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
 static void gen_pool32f_nanomips_insn(DisasContext *ctx)
 {
     int rt, rs, rd;
@@ -17141,6 +17222,14 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             gen_pool32a0_nanomips_insn(ctx);
             break;
         case NM_POOL32A7:
+            switch (extract32(ctx->opcode, 3, 3)) {
+            case NM_POOL32AXF:
+                gen_pool32axf_nanomips_insn(env, ctx);
+                break;
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
             break;
         default:
             generate_exception_end(ctx, EXCP_RI);
-- 
1.9.1
