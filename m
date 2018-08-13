Received: from eggs.gnu.org ([2001:4830:134:3::10]:59344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH36-0005Ok-Cg
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH32-00072V-Tq
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55743 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH32-00071U-Ik
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:32 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:52:35 +0200
Message-Id: <1534182832-554-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 10/87] target/mips: Fix MT ASE instructions'
 availability control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Use bits from configuration registers for availability control
of MT ASE instructions, rather than only ISA_MT bit in insn_flags.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index b73f434..af9714b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -8393,7 +8393,7 @@ static void gen_cp0 (CPUMIPSState *env, DisasContext *ctx, uint32_t opc, int rt,
         opn = "mthc0";
         break;
     case OPC_MFTR:
-        check_insn(ctx, ASE_MT);
+        check_cp0_enabled(ctx);
         if (rd == 0) {
             /* Treat as NOP. */
             return;
@@ -8403,7 +8403,7 @@ static void gen_cp0 (CPUMIPSState *env, DisasContext *ctx, uint32_t opc, int rt,
         opn = "mftr";
         break;
     case OPC_MTTR:
-        check_insn(ctx, ASE_MT);
+        check_cp0_enabled(ctx);
         gen_mttr(env, ctx, rd, rt, (ctx->opcode >> 5) & 1,
                  ctx->opcode & 0x7, (ctx->opcode >> 4) & 1);
         opn = "mttr";
@@ -18619,7 +18619,7 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
         gen_rdhwr(ctx, rt, rd, extract32(ctx->opcode, 6, 3));
         break;
     case OPC_FORK:
-        check_insn(ctx, ASE_MT);
+        check_mt(ctx);
         {
             TCGv t0 = tcg_temp_new();
             TCGv t1 = tcg_temp_new();
@@ -18632,7 +18632,7 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_YIELD:
-        check_insn(ctx, ASE_MT);
+        check_mt(ctx);
         {
             TCGv t0 = tcg_temp_new();
 
@@ -19929,22 +19929,22 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
                 op2 = MASK_MFMC0(ctx->opcode);
                 switch (op2) {
                 case OPC_DMT:
-                    check_insn(ctx, ASE_MT);
+                    check_cp0_mt(ctx);
                     gen_helper_dmt(t0);
                     gen_store_gpr(t0, rt);
                     break;
                 case OPC_EMT:
-                    check_insn(ctx, ASE_MT);
+                    check_cp0_mt(ctx);
                     gen_helper_emt(t0);
                     gen_store_gpr(t0, rt);
                     break;
                 case OPC_DVPE:
-                    check_insn(ctx, ASE_MT);
+                    check_cp0_mt(ctx);
                     gen_helper_dvpe(t0, cpu_env);
                     gen_store_gpr(t0, rt);
                     break;
                 case OPC_EVPE:
-                    check_insn(ctx, ASE_MT);
+                    check_cp0_mt(ctx);
                     gen_helper_evpe(t0, cpu_env);
                     gen_store_gpr(t0, rt);
                     break;
-- 
2.7.4
