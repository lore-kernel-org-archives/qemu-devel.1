Received: from eggs.gnu.org ([2001:4830:134:3::10]:56684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMx-0004Gy-VC
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMu-0000SM-C8
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:15 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:43 +1000
Message-Id: <20180821043343.7514-27-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 26/26] ppc: add DBCR based debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, lvivier@redhat.com, Roman Kapl <rka@sysgo.com>, David Gibson <david@gibson.dropbear.id.au>

From: Roman Kapl <rka@sysgo.com>

Add support for DBCR (debug control register) based debugging as used on
BookE ppc. So far supports only branch and single-step events, but these are
the important ones. GDB in Linux guest can now do single-stepping.

Signed-off-by: Roman Kapl <rka@sysgo.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h                |   5 ++
 target/ppc/excp_helper.c        |  11 ++--
 target/ppc/translate.c          | 107 ++++++++++++++++++++++++--------
 target/ppc/translate_init.inc.c |  17 +++++
 4 files changed, 107 insertions(+), 33 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4edcf62cf7..ec149349e2 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -481,6 +481,11 @@ struct ppc_slb_t {
 #define msr_ts   ((env->msr >> MSR_TS1)  & 3)
 #define msr_tm   ((env->msr >> MSR_TM)   & 1)
 
+#define DBCR0_ICMP (1 << 27)
+#define DBCR0_BRT (1 << 26)
+#define DBSR_ICMP (1 << 27)
+#define DBSR_BRT (1 << 26)
+
 /* Hypervisor bit is more specific */
 #if defined(TARGET_PPC64)
 #define MSR_HVB (1ULL << MSR_SHV)
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index d6e97a90e0..0ec7ae1ad4 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -348,19 +348,16 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     case POWERPC_EXCP_ITLB:      /* Instruction TLB error                    */
         break;
     case POWERPC_EXCP_DEBUG:     /* Debug interrupt                          */
-        switch (excp_model) {
-        case POWERPC_EXCP_BOOKE:
+        if (env->flags & POWERPC_FLAG_DE) {
             /* FIXME: choose one or the other based on CPU type */
             srr0 = SPR_BOOKE_DSRR0;
             srr1 = SPR_BOOKE_DSRR1;
             asrr0 = SPR_BOOKE_CSRR0;
             asrr1 = SPR_BOOKE_CSRR1;
-            break;
-        default:
-            break;
+            /* DBSR already modified by caller */
+        } else {
+            cpu_abort(cs, "Debug exception triggered on unsupported model\n");
         }
-        /* XXX: TODO */
-        cpu_abort(cs, "Debug exception is not implemented yet !\n");
         break;
     case POWERPC_EXCP_SPEU:      /* SPE/embedded floating-point unavailable  */
         env->spr[SPR_BOOKE_ESR] = ESR_SPV;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 9eaa10b421..881743571b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -211,6 +211,7 @@ struct DisasContext {
     bool gtse;
     ppc_spr_t *spr_cb; /* Needed to check rights for mfspr/mtspr */
     int singlestep_enabled;
+    uint32_t flags;
     uint64_t insns_flags;
     uint64_t insns_flags2;
 };
@@ -251,6 +252,17 @@ struct opc_handler_t {
 #endif
 };
 
+/* SPR load/store helpers */
+static inline void gen_load_spr(TCGv t, int reg)
+{
+    tcg_gen_ld_tl(t, cpu_env, offsetof(CPUPPCState, spr[reg]));
+}
+
+static inline void gen_store_spr(int reg, TCGv t)
+{
+    tcg_gen_st_tl(t, cpu_env, offsetof(CPUPPCState, spr[reg]));
+}
+
 static inline void gen_set_access_type(DisasContext *ctx, int access_type)
 {
     if (ctx->need_access_type && ctx->access_type != access_type) {
@@ -313,6 +325,38 @@ static void gen_exception_nip(DisasContext *ctx, uint32_t excp,
     ctx->exception = (excp);
 }
 
+/* Translates the EXCP_TRACE/BRANCH exceptions used on most PowerPCs to
+ * EXCP_DEBUG, if we are running on cores using the debug enable bit (e.g.
+ * BookE).
+ */
+static uint32_t gen_prep_dbgex(DisasContext *ctx, uint32_t excp)
+{
+    if ((ctx->singlestep_enabled & CPU_SINGLE_STEP)
+        && (excp == POWERPC_EXCP_BRANCH)) {
+        /* Trace excpt. has priority */
+        excp = POWERPC_EXCP_TRACE;
+    }
+    if (ctx->flags & POWERPC_FLAG_DE) {
+        target_ulong dbsr = 0;
+        switch (excp) {
+        case POWERPC_EXCP_TRACE:
+            dbsr = DBCR0_ICMP;
+            break;
+        case POWERPC_EXCP_BRANCH:
+            dbsr = DBCR0_BRT;
+            break;
+        }
+        TCGv t0 = tcg_temp_new();
+        gen_load_spr(t0, SPR_BOOKE_DBSR);
+        tcg_gen_ori_tl(t0, t0, dbsr);
+        gen_store_spr(SPR_BOOKE_DBSR, t0);
+        tcg_temp_free(t0);
+        return POWERPC_EXCP_DEBUG;
+    } else {
+        return excp;
+    }
+}
+
 static void gen_debug_exception(DisasContext *ctx)
 {
     TCGv_i32 t0;
@@ -575,17 +619,6 @@ typedef struct opcode_t {
 }
 #endif
 
-/* SPR load/store helpers */
-static inline void gen_load_spr(TCGv t, int reg)
-{
-    tcg_gen_ld_tl(t, cpu_env, offsetof(CPUPPCState, spr[reg]));
-}
-
-static inline void gen_store_spr(int reg, TCGv t)
-{
-    tcg_gen_st_tl(t, cpu_env, offsetof(CPUPPCState, spr[reg]));
-}
-
 /* Invalid instruction */
 static void gen_invalid(DisasContext *ctx)
 {
@@ -3602,6 +3635,24 @@ static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 #endif
 }
 
+static void gen_lookup_and_goto_ptr(DisasContext *ctx)
+{
+    int sse = ctx->singlestep_enabled;
+    if (unlikely(sse)) {
+        if (sse & GDBSTUB_SINGLE_STEP) {
+            gen_debug_exception(ctx);
+        } else if (sse & (CPU_SINGLE_STEP | CPU_BRANCH_STEP)) {
+            uint32_t excp = gen_prep_dbgex(ctx, POWERPC_EXCP_BRANCH);
+            if (excp != POWERPC_EXCP_NONE) {
+                gen_exception(ctx, excp);
+            }
+        }
+        tcg_gen_exit_tb(NULL, 0);
+    } else {
+        tcg_gen_lookup_and_goto_ptr();
+    }
+}
+
 /***                                Branch                                 ***/
 static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
 {
@@ -3614,18 +3665,7 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
         tcg_gen_exit_tb(ctx->base.tb, n);
     } else {
         tcg_gen_movi_tl(cpu_nip, dest & ~3);
-        if (unlikely(ctx->singlestep_enabled)) {
-            if ((ctx->singlestep_enabled &
-                (CPU_BRANCH_STEP | CPU_SINGLE_STEP)) &&
-                (ctx->exception == POWERPC_EXCP_BRANCH ||
-                 ctx->exception == POWERPC_EXCP_TRACE)) {
-                gen_exception_nip(ctx, POWERPC_EXCP_TRACE, dest);
-            }
-            if (ctx->singlestep_enabled & GDBSTUB_SINGLE_STEP) {
-                gen_debug_exception(ctx);
-            }
-        }
-        tcg_gen_lookup_and_goto_ptr();
+        gen_lookup_and_goto_ptr(ctx);
     }
 }
 
@@ -3668,8 +3708,8 @@ static void gen_bcond(DisasContext *ctx, int type)
     uint32_t bo = BO(ctx->opcode);
     TCGLabel *l1;
     TCGv target;
-
     ctx->exception = POWERPC_EXCP_BRANCH;
+
     if (type == BCOND_LR || type == BCOND_CTR || type == BCOND_TAR) {
         target = tcg_temp_local_new();
         if (type == BCOND_CTR)
@@ -3733,10 +3773,11 @@ static void gen_bcond(DisasContext *ctx, int type)
         } else {
             tcg_gen_andi_tl(cpu_nip, target, ~3);
         }
-        tcg_gen_lookup_and_goto_ptr();
+        gen_lookup_and_goto_ptr(ctx);
         tcg_temp_free(target);
     }
     if ((bo & 0x14) != 0x14) {
+        /* fallthrough case */
         gen_set_label(l1);
         gen_goto_tb(ctx, 1, ctx->base.pc_next);
     }
@@ -7419,6 +7460,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->need_access_type = !(env->mmu_model & POWERPC_MMU_64B);
     ctx->le_mode = !!(env->hflags & (1 << MSR_LE));
     ctx->default_tcg_memop_mask = ctx->le_mode ? MO_LE : MO_BE;
+    ctx->flags = env->flags;
 #if defined(TARGET_PPC64)
     ctx->sf_mode = msr_is_64bit(env, env->msr);
     ctx->has_cfar = !!(env->flags & POWERPC_FLAG_CFAR);
@@ -7455,6 +7497,17 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         ctx->singlestep_enabled = 0;
     if ((env->flags & POWERPC_FLAG_BE) && msr_be)
         ctx->singlestep_enabled |= CPU_BRANCH_STEP;
+    if ((env->flags & POWERPC_FLAG_DE) && msr_de) {
+        ctx->singlestep_enabled = 0;
+        target_ulong dbcr0 = env->spr[SPR_BOOKE_DBCR0];
+        if (dbcr0 & DBCR0_ICMP) {
+            ctx->singlestep_enabled |= CPU_SINGLE_STEP;
+        }
+        if (dbcr0 & DBCR0_BRT) {
+            ctx->singlestep_enabled |= CPU_BRANCH_STEP;
+        }
+
+    }
     if (unlikely(ctx->base.singlestep_enabled)) {
         ctx->singlestep_enabled |= GDBSTUB_SINGLE_STEP;
     }
@@ -7565,7 +7618,9 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
                  ctx->exception != POWERPC_SYSCALL &&
                  ctx->exception != POWERPC_EXCP_TRAP &&
                  ctx->exception != POWERPC_EXCP_BRANCH)) {
-        gen_exception_nip(ctx, POWERPC_EXCP_TRACE, ctx->base.pc_next);
+        uint32_t excp = gen_prep_dbgex(ctx, POWERPC_EXCP_TRACE);
+        if (excp != POWERPC_EXCP_NONE)
+            gen_exception_nip(ctx, excp, ctx->base.pc_next);
     }
 
     if (tcg_check_temp_count()) {
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index fe0cb98e6d..d920d3e538 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -498,6 +498,7 @@ static void spr_write_40x_pit(DisasContext *ctx, int sprn, int gprn)
 
 static void spr_write_40x_dbcr0(DisasContext *ctx, int sprn, int gprn)
 {
+    gen_store_spr(sprn, cpu_gpr[gprn]);
     gen_helper_store_40x_dbcr0(cpu_env, cpu_gpr[gprn]);
     /* We must stop translation as we may have rebooted */
     gen_stop_exception(ctx);
@@ -1769,6 +1770,14 @@ static void gen_spr_BookE(CPUPPCState *env, uint64_t ivor_mask)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
+    spr_register(env, SPR_BOOKE_DSRR0, "DSRR0",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+    spr_register(env, SPR_BOOKE_DSRR1, "DSRR1",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
     /* XXX : not implemented */
     spr_register(env, SPR_BOOKE_DBSR, "DBSR",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -1841,6 +1850,14 @@ static void gen_spr_BookE(CPUPPCState *env, uint64_t ivor_mask)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
+    spr_register(env, SPR_BOOKE_SPRG8, "SPRG8",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+    spr_register(env, SPR_BOOKE_SPRG9, "SPRG9",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
 }
 
 static inline uint32_t gen_tlbncfg(uint32_t assoc, uint32_t minsize,
-- 
2.17.1
