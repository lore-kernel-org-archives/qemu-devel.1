Received: from eggs.gnu.org ([209.51.188.92]:46530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gn1aT-0002tf-Ut
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gn1aS-0002eh-Nn
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:32:01 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36390 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gn1aS-0002W6-HD
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:32:00 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 25 Jan 2019 14:31:29 +0100
Message-Id: <1548423098-31864-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 05/14] target/mips: Extend gen_scwp()
 functionality to support EVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Extend gen_scwp() functionality to support EVA by adding an
additional argument, modify internals of the function to handle
new functionality, and accordingly change its invocations.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index b362b03..aaf7dff 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -3714,7 +3714,7 @@ static void gen_st_cond (DisasContext *ctx, uint32_t opc, int rt,
 }
 
 static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
-                    uint32_t reg1, uint32_t reg2)
+                    uint32_t reg1, uint32_t reg2, bool eva)
 {
     TCGv taddr = tcg_temp_local_new();
     TCGv lladdr = tcg_temp_local_new();
@@ -3742,7 +3742,7 @@ static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
 
     tcg_gen_ld_i64(llval, cpu_env, offsetof(CPUMIPSState, llval_wp));
     tcg_gen_atomic_cmpxchg_i64(val, taddr, llval, tval,
-                               ctx->mem_idx, MO_64);
+                               eva ? MIPS_HFLAG_UM : ctx->mem_idx, MO_64);
     if (reg1 != 0) {
         tcg_gen_movi_tl(cpu_gpr[reg1], 1);
     }
@@ -21550,7 +21550,8 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         break;
                     case NM_SCWP:
                         check_xnp(ctx);
-                        gen_scwp(ctx, rs, 0, rt, extract32(ctx->opcode, 3, 5));
+                        gen_scwp(ctx, rs, 0, rt, extract32(ctx->opcode, 3, 5),
+                                 false);
                         break;
                     }
                     break;
@@ -21654,7 +21655,8 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         check_xnp(ctx);
                         check_eva(ctx);
                         check_cp0_enabled(ctx);
-                        gen_scwp(ctx, rs, 0, rt, extract32(ctx->opcode, 3, 5));
+                        gen_scwp(ctx, rs, 0, rt, extract32(ctx->opcode, 3, 5),
+                                 true);
                         break;
                     default:
                         generate_exception_end(ctx, EXCP_RI);
-- 
2.7.4
