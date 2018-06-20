Received: from eggs.gnu.org ([2001:4830:134:3::10]:35180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbv2-0003o7-3O
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbv1-0004Hr-3x
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:09:00 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:38425)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbv0-0004FQ-UI
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:08:59 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:05:54 +0100
Message-ID: <20180620120620.12806-10-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 09/35] target/mips: Add nanoMIPS 48bit
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

Add nanoMIPS 48bit instructions

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/translate.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index c9b46dd..f3a8845 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16407,6 +16407,72 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_P48I:
+        insn = cpu_lduw_code(env, ctx->base.pc_next + 4);
+        switch ((ctx->opcode >> 16) & 0x1f) {
+        case NM_LI48:
+            if (rt != 0) {
+                tcg_gen_movi_tl(cpu_gpr[rt],
+                                extract32(ctx->opcode, 0, 16) | insn << 16);
+            }
+            break;
+        case NM_ADDIU48:
+            if (rt != 0) {
+                tcg_gen_addi_tl(cpu_gpr[rt], cpu_gpr[rt],
+                                extract32(ctx->opcode, 0, 16) | insn << 16);
+                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
+            }
+            break;
+        case NM_ADDIUGP48:
+            if (rt != 0) {
+                tcg_gen_addi_tl(cpu_gpr[rt], cpu_gpr[28],
+                                extract32(ctx->opcode, 0, 16) | insn << 16);
+                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
+            }
+            break;
+        case NM_ADDIUPC48:
+            if (rt != 0) {
+                int32_t offset = extract32(ctx->opcode, 0, 16) | insn << 16;
+                target_long addr = addr_add(ctx, ctx->base.pc_next + 6, offset);
+
+                tcg_gen_movi_tl(cpu_gpr[rt], addr);
+                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
+            }
+            break;
+        case NM_LWPC48:
+            if (rt != 0) {
+                TCGv t0;
+                t0 = tcg_temp_new();
+
+                int32_t offset = extract32(ctx->opcode, 0, 16) | insn << 16;
+                target_long addr = addr_add(ctx, ctx->base.pc_next + 6, offset);
+
+                tcg_gen_movi_tl(t0, addr);
+                tcg_gen_qemu_ld_tl(cpu_gpr[rt], t0, ctx->mem_idx, MO_TESL);
+                tcg_temp_free(t0);
+            }
+            break;
+        case NM_SWPC48:
+        {
+            TCGv t0, t1;
+            t0 = tcg_temp_new();
+            t1 = tcg_temp_new();
+
+            int32_t offset = extract32(ctx->opcode, 0, 16) | insn << 16;
+            target_long addr = addr_add(ctx, ctx->base.pc_next + 6, offset);
+
+            tcg_gen_movi_tl(t0, addr);
+            gen_load_gpr(t1, rt);
+
+            tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL);
+
+            tcg_temp_free(t0);
+            tcg_temp_free(t1);
+        }
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
         return 6;
     case NM_P_U12:
         switch ((ctx->opcode >> 12) & 0x0f) {
-- 
1.9.1
