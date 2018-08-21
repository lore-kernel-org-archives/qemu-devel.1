Received: from eggs.gnu.org ([2001:4830:134:3::10]:41469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs5tK-00023t-PH
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs5tI-0007NE-Db
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:10 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34897 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs5tH-0007Ju-7O
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:07 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 14:35:32 +0200
Message-Id: <1534854951-6321-28-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534854951-6321-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534854951-6321-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 27/46] target/mips: Fix pre-nanoMIPS MT ASE
 instructions availability control
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

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Use bits from configuration registers for availability control
of MT ASE instructions, rather than only ISA_MT bit in insn_flags.
This is done by adding a field in hflags for MT bit, and adding
functions check_mt() and check_cp0_mt().

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index cd7e16c..480d4bf 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1927,6 +1927,35 @@ static inline void check_xnp(DisasContext *ctx)
     }
 }
 
+/*
+ * This code generates a "reserved instruction" exception if the
+ * Config3 MT bit is NOT set.
+ */
+static inline void check_mt(DisasContext *ctx)
+{
+    if (unlikely(!(ctx->CP0_Config3 & (1 << CP0C3_MT)))) {
+        generate_exception_end(ctx, EXCP_RI);
+    }
+}
+
+/*
+ * This code generates a "coprocessor unusable" exception if CP0 is not
+ * available, and, if that is not the case, generates a "reserved instruction"
+ * exception if the Config5 MT bit is NOT set. This is needed for availability
+ * control of some of MT ASE instructions.
+ */
+static inline void check_cp0_mt(DisasContext *ctx)
+{
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_CP0))) {
+        generate_exception_err(ctx, EXCP_CpU, 0);
+    } else {
+        if (unlikely(!(ctx->CP0_Config3 & (1 << CP0C3_MT)))) {
+            generate_exception_err(ctx, EXCP_RI, 0);
+        }
+    }
+}
+
+
 
 /* Define small wrappers for gen_load_fpr* so that we have a uniform
    calling interface for 32 and 64-bit FPRs.  No sense in changing
@@ -8595,7 +8624,7 @@ static void gen_cp0 (CPUMIPSState *env, DisasContext *ctx, uint32_t opc, int rt,
         opn = "mthc0";
         break;
     case OPC_MFTR:
-        check_insn(ctx, ASE_MT);
+        check_cp0_enabled(ctx);
         if (rd == 0) {
             /* Treat as NOP. */
             return;
@@ -8605,7 +8634,7 @@ static void gen_cp0 (CPUMIPSState *env, DisasContext *ctx, uint32_t opc, int rt,
         opn = "mftr";
         break;
     case OPC_MTTR:
-        check_insn(ctx, ASE_MT);
+        check_cp0_enabled(ctx);
         gen_mttr(env, ctx, rd, rt, (ctx->opcode >> 5) & 1,
                  ctx->opcode & 0x7, (ctx->opcode >> 4) & 1);
         opn = "mttr";
@@ -21960,7 +21989,7 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
         gen_rdhwr(ctx, rt, rd, extract32(ctx->opcode, 6, 3));
         break;
     case OPC_FORK:
-        check_insn(ctx, ASE_MT);
+        check_mt(ctx);
         {
             TCGv t0 = tcg_temp_new();
             TCGv t1 = tcg_temp_new();
@@ -21973,7 +22002,7 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_YIELD:
-        check_insn(ctx, ASE_MT);
+        check_mt(ctx);
         {
             TCGv t0 = tcg_temp_new();
 
@@ -23270,22 +23299,22 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
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
