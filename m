Received: from eggs.gnu.org ([2001:4830:134:3::10]:56068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJl3-0005Nn-Sr
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJkv-0000hN-BN
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:15 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43527 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqJku-0000e5-KE
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:09 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 16:57:33 +0200
Message-Id: <1534431497-1385-41-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v9 40/84] target/mips: Fix pre-nanoMIPS MT ASE
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Use bits from configuration registers for availability control
of MT ASE instructions, rather than only ISA_MT bit in insn_flags.
This is done by adding a field in hflags for MT bit, and adding
functions check_mt() and check_cp0_mt().

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  3 ++-
 target/mips/internal.h  |  6 +++++-
 target/mips/translate.c | 45 +++++++++++++++++++++++++++++++++++++--------
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 468b686..bf9c634 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -556,7 +556,7 @@ struct CPUMIPSState {
 #define EXCP_INST_NOTAVAIL 0x2 /* No valid instruction word for BadInstr */
     uint32_t hflags;    /* CPU State */
     /* TMASK defines different execution modes */
-#define MIPS_HFLAG_TMASK  0x3F5807FF
+#define MIPS_HFLAG_TMASK  0x7F5807FF
 #define MIPS_HFLAG_MODE   0x00007 /* execution modes                    */
     /* The KSU flags must be the lowest bits in hflags. The flag order
        must be the same as defined for CP0 Status. This allows to use
@@ -608,6 +608,7 @@ struct CPUMIPSState {
 #define MIPS_HFLAG_ITC_CACHE  0x8000000 /* CACHE instr. operates on ITC tag */
 #define MIPS_HFLAG_ERL   0x10000000 /* error level flag */
 #define MIPS_HFLAG_XNP   0x20000000
+#define MIPS_HFLAG_MT    0x40000000
     target_ulong btarget;        /* Jump / branch target               */
     target_ulong bcond;          /* Branch condition (if needed)       */
 
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 97485da..c0e447b 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -308,7 +308,8 @@ static inline void compute_hflags(CPUMIPSState *env)
                      MIPS_HFLAG_F64 | MIPS_HFLAG_FPU | MIPS_HFLAG_KSU |
                      MIPS_HFLAG_AWRAP | MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR2 |
                      MIPS_HFLAG_SBRI | MIPS_HFLAG_MSA | MIPS_HFLAG_FRE |
-                     MIPS_HFLAG_ELPA | MIPS_HFLAG_ERL | MIPS_HFLAG_XNP);
+                     MIPS_HFLAG_ELPA | MIPS_HFLAG_ERL | MIPS_HFLAG_XNP |
+                     MIPS_HFLAG_MT);
     if (env->CP0_Status & (1 << CP0St_ERL)) {
         env->hflags |= MIPS_HFLAG_ERL;
     }
@@ -405,6 +406,9 @@ static inline void compute_hflags(CPUMIPSState *env)
     if (env->CP0_Config5 & (1 << CP0C5_XNP)) {
         env->hflags |= MIPS_HFLAG_XNP;
     }
+    if (env->CP0_Config3 & (1 << CP0C3_MT)) {
+        env->hflags |= MIPS_HFLAG_MT;
+    }
 }
 
 void cpu_mips_tlb_flush(CPUMIPSState *env);
diff --git a/target/mips/translate.c b/target/mips/translate.c
index dcb3d25..e8c0509 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1925,6 +1925,35 @@ static inline void check_xnp(DisasContext *ctx)
     }
 }
 
+/*
+ * This code generates a "reserved instruction" exception if the
+ * Config5 MT bit is NOT set.
+ */
+static inline void check_mt(DisasContext *ctx)
+{
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_MT))) {
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
+        if (unlikely(!(ctx->hflags & MIPS_HFLAG_MT))) {
+            generate_exception_err(ctx, EXCP_RI, 0);
+        }
+    }
+}
+
+
 
 /* Define small wrappers for gen_load_fpr* so that we have a uniform
    calling interface for 32 and 64-bit FPRs.  No sense in changing
@@ -8471,7 +8500,7 @@ static void gen_cp0 (CPUMIPSState *env, DisasContext *ctx, uint32_t opc, int rt,
         opn = "mthc0";
         break;
     case OPC_MFTR:
-        check_insn(ctx, ASE_MT);
+        check_cp0_enabled(ctx);
         if (rd == 0) {
             /* Treat as NOP. */
             return;
@@ -8481,7 +8510,7 @@ static void gen_cp0 (CPUMIPSState *env, DisasContext *ctx, uint32_t opc, int rt,
         opn = "mftr";
         break;
     case OPC_MTTR:
-        check_insn(ctx, ASE_MT);
+        check_cp0_enabled(ctx);
         gen_mttr(env, ctx, rd, rt, (ctx->opcode >> 5) & 1,
                  ctx->opcode & 0x7, (ctx->opcode >> 4) & 1);
         opn = "mttr";
@@ -21797,7 +21826,7 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
         gen_rdhwr(ctx, rt, rd, extract32(ctx->opcode, 6, 3));
         break;
     case OPC_FORK:
-        check_insn(ctx, ASE_MT);
+        check_mt(ctx);
         {
             TCGv t0 = tcg_temp_new();
             TCGv t1 = tcg_temp_new();
@@ -21810,7 +21839,7 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_YIELD:
-        check_insn(ctx, ASE_MT);
+        check_mt(ctx);
         {
             TCGv t0 = tcg_temp_new();
 
@@ -23107,22 +23136,22 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
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
