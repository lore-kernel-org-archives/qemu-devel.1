Received: from eggs.gnu.org ([2001:4830:134:3::10]:35467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbvz-00051G-LW
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbvv-0004lE-MG
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:09:59 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:60207)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbvv-0004gG-C8
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:09:55 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:05:57 +0100
Message-ID: <20180620120620.12806-13-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 12/35] target/mips: Add nanoMIPS pool32axf
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

Add nanoMIPS pool32axf instructions

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/translate.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 0c261c7..60d9287 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16493,6 +16493,93 @@ static void gen_pool32a0_nanomips_insn(DisasContext *ctx)
     }
 }
 
+static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
+{
+    int rt = (ctx->opcode >> 21) & 0x1f;
+    int rs = (ctx->opcode >> 16) & 0x1f;
+
+    switch ((ctx->opcode >> 6) & 0x07) {
+    case NM_POOL32AXF_4:
+    case NM_POOL32AXF_5:
+        switch ((ctx->opcode >> 9) & 0x7f) {
+        case NM_CLO:
+            gen_cl(ctx, OPC_CLO, rt, rs);
+            break;
+        case NM_CLZ:
+            gen_cl(ctx, OPC_CLZ, rt, rs);
+            break;
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
@@ -16862,6 +16949,13 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             gen_pool32a0_nanomips_insn(ctx);
             break;
         case NM_POOL32A7:
+        {
+            switch ((ctx->opcode >> 3) & 0x07) {
+            case NM_POOL32AXF:
+                gen_pool32axf_nanomips_insn(env, ctx);
+                break;
+            }
+        }
             break;
         default:
             generate_exception_end(ctx, EXCP_RI);
-- 
1.9.1
