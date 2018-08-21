Received: from eggs.gnu.org ([2001:4830:134:3::10]:34032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6lX-0000sZ-AA
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6lU-00070p-I9
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:11 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49375 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs6lT-0006xI-R0
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:08 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 15:31:26 +0200
Message-Id: <1534858316-12945-17-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534858316-12945-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534858316-12945-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v3 16/46] target/mips: Add emulation of nanoMIPS
 48-bit instructions
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

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of LI48, ADDIU48, ADDIUGP48, ADDIUPC48, LWPC48, and
SWPC48 instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 8bc08f7..98df88e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16946,7 +16946,71 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_P48I:
-        return 6;
+        {
+            insn = cpu_lduw_code(env, ctx->base.pc_next + 4);
+            target_long addr_off = extract32(ctx->opcode, 0, 16) | insn << 16;
+            switch (extract32(ctx->opcode, 16, 5)) {
+            case NM_LI48:
+                if (rt != 0) {
+                    tcg_gen_movi_tl(cpu_gpr[rt], addr_off);
+                }
+                break;
+            case NM_ADDIU48:
+                if (rt != 0) {
+                    tcg_gen_addi_tl(cpu_gpr[rt], cpu_gpr[rt], addr_off);
+                    tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
+                }
+                break;
+            case NM_ADDIUGP48:
+                if (rt != 0) {
+                    gen_op_addr_addi(ctx, cpu_gpr[rt], cpu_gpr[28], addr_off);
+                }
+                break;
+            case NM_ADDIUPC48:
+                if (rt != 0) {
+                    target_long addr = addr_add(ctx, ctx->base.pc_next + 6,
+                                                addr_off);
+
+                    tcg_gen_movi_tl(cpu_gpr[rt], addr);
+                }
+                break;
+            case NM_LWPC48:
+                if (rt != 0) {
+                    TCGv t0;
+                    t0 = tcg_temp_new();
+
+                    target_long addr = addr_add(ctx, ctx->base.pc_next + 6,
+                                                addr_off);
+
+                    tcg_gen_movi_tl(t0, addr);
+                    tcg_gen_qemu_ld_tl(cpu_gpr[rt], t0, ctx->mem_idx, MO_TESL);
+                    tcg_temp_free(t0);
+                }
+                break;
+            case NM_SWPC48:
+                {
+                    TCGv t0, t1;
+                    t0 = tcg_temp_new();
+                    t1 = tcg_temp_new();
+
+                    target_long addr = addr_add(ctx, ctx->base.pc_next + 6,
+                                                addr_off);
+
+                    tcg_gen_movi_tl(t0, addr);
+                    gen_load_gpr(t1, rt);
+
+                    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL);
+
+                    tcg_temp_free(t0);
+                    tcg_temp_free(t1);
+                }
+                break;
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+            return 6;
+        }
     case NM_P_U12:
         switch (extract32(ctx->opcode, 12, 4)) {
         case NM_ORI:
-- 
2.7.4
