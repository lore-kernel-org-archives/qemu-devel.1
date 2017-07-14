Received: from eggs.gnu.org ([2001:4830:134:3::10]:41182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11X-0001Qv-Gj
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11V-0001FY-OH
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW11V-0001EX-Fx
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:49 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:51:56 +0200
Message-Id: <1500040339-119465-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 05/28] sparc: embed sparc_def_t into
 CPUSPARCState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Make CPUSPARCState::def embedded so it would be allocated as part
of cpu instance and we won't have to worry about cleaning def pointer
up mannualy on cpu destruction.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
Embedded CPUSPARCState::def also needed for follow up patch
to use its fields with static qdev properties.

CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
---
 linux-user/sparc/target_syscall.h |  2 +-
 target/sparc/cpu.h                |  8 ++++----
 target/sparc/cpu.c                | 39 ++++++++++++++++-----------------------
 target/sparc/int32_helper.c       |  2 +-
 target/sparc/int64_helper.c       |  2 +-
 target/sparc/ldst_helper.c        | 14 +++++++-------
 target/sparc/mmu_helper.c         |  2 +-
 target/sparc/translate.c          |  2 +-
 target/sparc/win_helper.c         |  4 ++--
 9 files changed, 34 insertions(+), 41 deletions(-)

diff --git a/linux-user/sparc/target_syscall.h b/linux-user/sparc/target_syscall.h
index f97aa6b..5f09abf 100644
--- a/linux-user/sparc/target_syscall.h
+++ b/linux-user/sparc/target_syscall.h
@@ -31,7 +31,7 @@ struct target_pt_regs {
 
 static inline abi_ulong target_shmlba(CPUSPARCState *env)
 {
-    if (!(env->def->features & CPU_FEATURE_FLUSH)) {
+    if (!(env->def.features & CPU_FEATURE_FLUSH)) {
         return 64 * 1024;
     } else {
         return 256 * 1024;
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 95a36a4..0e41916 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -529,7 +529,7 @@ struct CPUSPARCState {
 #define SOFTINT_INTRMASK (0xFFFE)
 #define SOFTINT_REG_MASK (SOFTINT_STIMER|SOFTINT_INTRMASK|SOFTINT_TIMER)
 #endif
-    sparc_def_t *def;
+    sparc_def_t def;
 
     void *irq_manager;
     void (*qemu_irq_ack)(CPUSPARCState *env, void *irq_manager, int intno);
@@ -679,7 +679,7 @@ int cpu_sparc_signal_handler(int host_signum, void *pinfo, void *puc);
 #if defined (TARGET_SPARC64)
 static inline int cpu_has_hypervisor(CPUSPARCState *env1)
 {
-    return env1->def->features & CPU_FEATURE_HYPV;
+    return env1->def.features & CPU_FEATURE_HYPV;
 }
 
 static inline int cpu_hypervisor_mode(CPUSPARCState *env1)
@@ -788,14 +788,14 @@ static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, target_ulong *pc,
     if (env->pstate & PS_AM) {
         flags |= TB_FLAG_AM_ENABLED;
     }
-    if ((env->def->features & CPU_FEATURE_FLOAT)
+    if ((env->def.features & CPU_FEATURE_FLOAT)
         && (env->pstate & PS_PEF)
         && (env->fprs & FPRS_FEF)) {
         flags |= TB_FLAG_FPU_ENABLED;
     }
     flags |= env->asi << TB_FLAG_ASI_SHIFT;
 #else
-    if ((env->def->features & CPU_FEATURE_FLOAT) && env->psref) {
+    if ((env->def.features & CPU_FEATURE_FLOAT) && env->psref) {
         flags |= TB_FLAG_FPU_ENABLED;
     }
 #endif
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index f8cf751..110a5cd 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -66,7 +66,7 @@ static void sparc_cpu_reset(CPUState *s)
     env->lsu = 0;
 #else
     env->mmuregs[0] &= ~(MMU_E | MMU_NF);
-    env->mmuregs[0] |= env->def->mmu_bm;
+    env->mmuregs[0] |= env->def.mmu_bm;
 #endif
     env->pc = 0;
     env->npc = env->pc + 4;
@@ -120,18 +120,18 @@ static int cpu_sparc_register(SPARCCPU *cpu, const char *cpu_model)
         return -1;
     }
 
-    env->version = env->def->iu_version;
-    env->fsr = env->def->fpu_version;
-    env->nwindows = env->def->nwindows;
+    env->version = env->def.iu_version;
+    env->fsr = env->def.fpu_version;
+    env->nwindows = env->def.nwindows;
 #if !defined(TARGET_SPARC64)
-    env->mmuregs[0] |= env->def->mmu_version;
+    env->mmuregs[0] |= env->def.mmu_version;
     cpu_sparc_set_id(env, 0);
-    env->mxccregs[7] |= env->def->mxcc_version;
+    env->mxccregs[7] |= env->def.mxcc_version;
 #else
-    env->mmu_version = env->def->mmu_version;
-    env->maxtl = env->def->maxtl;
-    env->version |= env->def->maxtl << 8;
-    env->version |= env->def->nwindows - 1;
+    env->mmu_version = env->def.mmu_version;
+    env->maxtl = env->def.maxtl;
+    env->version |= env->def.maxtl << 8;
+    env->version |= env->def.nwindows - 1;
 #endif
     return 0;
 }
@@ -558,7 +558,7 @@ static void sparc_cpu_parse_features(CPUState *cs, char *features,
                                      Error **errp)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
-    sparc_def_t *cpu_def = cpu->env.def;
+    sparc_def_t *cpu_def = &cpu->env.def;
     char *featurestr;
     uint32_t plus_features = 0;
     uint32_t minus_features = 0;
@@ -819,8 +819,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     SPARCCPU *cpu = SPARC_CPU(dev);
     CPUSPARCState *env = &cpu->env;
 
-    if ((env->def->features & CPU_FEATURE_FLOAT)) {
-        env->def->features |= CPU_FEATURE_FLOAT128;
+    if ((env->def.features & CPU_FEATURE_FLOAT)) {
+        env->def.features |= CPU_FEATURE_FLOAT128;
     }
 #endif
 
@@ -848,15 +848,9 @@ static void sparc_cpu_initfn(Object *obj)
         gen_intermediate_code_init(env);
     }
 
-    env->def = g_memdup(scc->cpu_def, sizeof(*scc->cpu_def));
-}
-
-static void sparc_cpu_uninitfn(Object *obj)
-{
-    SPARCCPU *cpu = SPARC_CPU(obj);
-    CPUSPARCState *env = &cpu->env;
-
-    g_free(env->def);
+    if (scc->cpu_def) {
+        env->def = *scc->cpu_def;
+    }
 }
 
 static void sparc_cpu_class_init(ObjectClass *oc, void *data)
@@ -905,7 +899,6 @@ static const TypeInfo sparc_cpu_type_info = {
     .parent = TYPE_CPU,
     .instance_size = sizeof(SPARCCPU),
     .instance_init = sparc_cpu_initfn,
-    .instance_finalize = sparc_cpu_uninitfn,
     .abstract = false,
     .class_size = sizeof(SPARCCPUClass),
     .class_init = sparc_cpu_class_init,
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index eec9a4d..c772492 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -108,7 +108,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 #if !defined(CONFIG_USER_ONLY)
     if (env->psret == 0) {
         if (cs->exception_index == 0x80 &&
-            env->def->features & CPU_FEATURE_TA0_SHUTDOWN) {
+            env->def.features & CPU_FEATURE_TA0_SHUTDOWN) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         } else {
             cpu_abort(cs, "Trap 0x%02x while interrupts disabled, Error state",
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index f942973..f3e7f32 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -147,7 +147,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         }
     }
 
-    if (env->def->features & CPU_FEATURE_GL) {
+    if (env->def.features & CPU_FEATURE_GL) {
         tsptr->tstate |= (env->gl & 7ULL) << 40;
         cpu_gl_switch_gregs(env, env->gl + 1);
         env->gl++;
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 57968d9..fb489cb 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -513,7 +513,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
         case 0x00:          /* Leon3 Cache Control */
         case 0x08:          /* Leon3 Instruction Cache config */
         case 0x0C:          /* Leon3 Date Cache config */
-            if (env->def->features & CPU_FEATURE_CACHE_CTRL) {
+            if (env->def.features & CPU_FEATURE_CACHE_CTRL) {
                 ret = leon3_cache_control_ld(env, addr, size);
             }
             break;
@@ -736,7 +736,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
         case 0x00:          /* Leon3 Cache Control */
         case 0x08:          /* Leon3 Instruction Cache config */
         case 0x0C:          /* Leon3 Date Cache config */
-            if (env->def->features & CPU_FEATURE_CACHE_CTRL) {
+            if (env->def.features & CPU_FEATURE_CACHE_CTRL) {
                 leon3_cache_control_st(env, addr, val, size);
             }
             break;
@@ -904,15 +904,15 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                 /* Mappings generated during no-fault mode
                    are invalid in normal mode.  */
                 if ((oldreg ^ env->mmuregs[reg])
-                    & (MMU_NF | env->def->mmu_bm)) {
+                    & (MMU_NF | env->def.mmu_bm)) {
                     tlb_flush(CPU(cpu));
                 }
                 break;
             case 1: /* Context Table Pointer Register */
-                env->mmuregs[reg] = val & env->def->mmu_ctpr_mask;
+                env->mmuregs[reg] = val & env->def.mmu_ctpr_mask;
                 break;
             case 2: /* Context Register */
-                env->mmuregs[reg] = val & env->def->mmu_cxr_mask;
+                env->mmuregs[reg] = val & env->def.mmu_cxr_mask;
                 if (oldreg != env->mmuregs[reg]) {
                     /* we flush when the MMU context changes because
                        QEMU has no MMU context support */
@@ -923,11 +923,11 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
             case 4: /* Synchronous Fault Address Register */
                 break;
             case 0x10: /* TLB Replacement Control Register */
-                env->mmuregs[reg] = val & env->def->mmu_trcr_mask;
+                env->mmuregs[reg] = val & env->def.mmu_trcr_mask;
                 break;
             case 0x13: /* Synchronous Fault Status Register with Read
                           and Clear */
-                env->mmuregs[3] = val & env->def->mmu_sfsr_mask;
+                env->mmuregs[3] = val & env->def.mmu_sfsr_mask;
                 break;
             case 0x14: /* Synchronous Fault Address Register */
                 env->mmuregs[4] = val;
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 8b4664d..126ea5e 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -95,7 +95,7 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
     if (mmu_idx == MMU_PHYS_IDX) {
         *page_size = TARGET_PAGE_SIZE;
         /* Boot mode: instruction fetches are taken from PROM */
-        if (rw == 2 && (env->mmuregs[0] & env->def->mmu_bm)) {
+        if (rw == 2 && (env->mmuregs[0] & env->def.mmu_bm)) {
             *physical = env->prom_addr | (address & 0x7ffffULL);
             *prot = PAGE_READ | PAGE_EXEC;
             return 0;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index aa6734d..5641931 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5765,7 +5765,7 @@ void gen_intermediate_code(CPUSPARCState * env, TranslationBlock * tb)
     dc->npc = (target_ulong) tb->cs_base;
     dc->cc_op = CC_OP_DYNAMIC;
     dc->mem_idx = tb->flags & TB_FLAG_MMU_MASK;
-    dc->def = env->def;
+    dc->def = &env->def;
     dc->fpu_enabled = tb_fpu_enabled(tb->flags);
     dc->address_mask_32bit = tb_am_enabled(tb->flags);
     dc->singlestep = (cs->singlestep_enabled || singlestep);
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 154279e..8290a21 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -295,7 +295,7 @@ void helper_wrcwp(CPUSPARCState *env, target_ulong new_cwp)
 
 static inline uint64_t *get_gregset(CPUSPARCState *env, uint32_t pstate)
 {
-    if (env->def->features & CPU_FEATURE_GL) {
+    if (env->def.features & CPU_FEATURE_GL) {
         return env->glregs + (env->gl & 7) * 8;
     }
 
@@ -343,7 +343,7 @@ void cpu_change_pstate(CPUSPARCState *env, uint32_t new_pstate)
     uint32_t pstate_regs, new_pstate_regs;
     uint64_t *src, *dst;
 
-    if (env->def->features & CPU_FEATURE_GL) {
+    if (env->def.features & CPU_FEATURE_GL) {
         /* PS_AG, IG and MG are not implemented in this case */
         new_pstate &= ~(PS_AG | PS_IG | PS_MG);
         env->pstate = new_pstate;
-- 
2.7.4
