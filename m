Received: from eggs.gnu.org ([2001:4830:134:3::10]:40777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnTx-0007vO-Nt
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnTv-0002we-SY
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnTv-0002wO-Ix
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:39 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:02:55 -0300
Message-Id: <20170901150317.10380-8-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/29] sparc: embed sparc_def_t into
 CPUSPARCState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Make CPUSPARCState::def embedded so it would be allocated as part
of cpu instance and we won't have to worry about cleaning def pointer
up mannualy on cpu destruction.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1503592308-93913-4-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 linux-user/sparc/target_syscall.h |  2 +-
 target/sparc/cpu.h                |  8 ++++----
 target/sparc/cpu.c                | 39 ++++++++++++++++-----------------=
------
 target/sparc/int32_helper.c       |  2 +-
 target/sparc/int64_helper.c       |  2 +-
 target/sparc/ldst_helper.c        | 14 +++++++-------
 target/sparc/mmu_helper.c         |  2 +-
 target/sparc/translate.c          |  2 +-
 target/sparc/win_helper.c         |  4 ++--
 9 files changed, 34 insertions(+), 41 deletions(-)

diff --git a/linux-user/sparc/target_syscall.h b/linux-user/sparc/target_=
syscall.h
index f97aa6b075..5f09abfe89 100644
--- a/linux-user/sparc/target_syscall.h
+++ b/linux-user/sparc/target_syscall.h
@@ -31,7 +31,7 @@ struct target_pt_regs {
=20
 static inline abi_ulong target_shmlba(CPUSPARCState *env)
 {
-    if (!(env->def->features & CPU_FEATURE_FLUSH)) {
+    if (!(env->def.features & CPU_FEATURE_FLUSH)) {
         return 64 * 1024;
     } else {
         return 256 * 1024;
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 95a36a4bdc..0e41916a52 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -529,7 +529,7 @@ struct CPUSPARCState {
 #define SOFTINT_INTRMASK (0xFFFE)
 #define SOFTINT_REG_MASK (SOFTINT_STIMER|SOFTINT_INTRMASK|SOFTINT_TIMER)
 #endif
-    sparc_def_t *def;
+    sparc_def_t def;
=20
     void *irq_manager;
     void (*qemu_irq_ack)(CPUSPARCState *env, void *irq_manager, int intn=
o);
@@ -679,7 +679,7 @@ int cpu_sparc_signal_handler(int host_signum, void *p=
info, void *puc);
 #if defined (TARGET_SPARC64)
 static inline int cpu_has_hypervisor(CPUSPARCState *env1)
 {
-    return env1->def->features & CPU_FEATURE_HYPV;
+    return env1->def.features & CPU_FEATURE_HYPV;
 }
=20
 static inline int cpu_hypervisor_mode(CPUSPARCState *env1)
@@ -788,14 +788,14 @@ static inline void cpu_get_tb_cpu_state(CPUSPARCSta=
te *env, target_ulong *pc,
     if (env->pstate & PS_AM) {
         flags |=3D TB_FLAG_AM_ENABLED;
     }
-    if ((env->def->features & CPU_FEATURE_FLOAT)
+    if ((env->def.features & CPU_FEATURE_FLOAT)
         && (env->pstate & PS_PEF)
         && (env->fprs & FPRS_FEF)) {
         flags |=3D TB_FLAG_FPU_ENABLED;
     }
     flags |=3D env->asi << TB_FLAG_ASI_SHIFT;
 #else
-    if ((env->def->features & CPU_FEATURE_FLOAT) && env->psref) {
+    if ((env->def.features & CPU_FEATURE_FLOAT) && env->psref) {
         flags |=3D TB_FLAG_FPU_ENABLED;
     }
 #endif
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index a82fc238f4..281a99f8dd 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -66,7 +66,7 @@ static void sparc_cpu_reset(CPUState *s)
     env->lsu =3D 0;
 #else
     env->mmuregs[0] &=3D ~(MMU_E | MMU_NF);
-    env->mmuregs[0] |=3D env->def->mmu_bm;
+    env->mmuregs[0] |=3D env->def.mmu_bm;
 #endif
     env->pc =3D 0;
     env->npc =3D env->pc + 4;
@@ -120,18 +120,18 @@ static int cpu_sparc_register(SPARCCPU *cpu, const =
char *cpu_model)
         return -1;
     }
=20
-    env->version =3D env->def->iu_version;
-    env->fsr =3D env->def->fpu_version;
-    env->nwindows =3D env->def->nwindows;
+    env->version =3D env->def.iu_version;
+    env->fsr =3D env->def.fpu_version;
+    env->nwindows =3D env->def.nwindows;
 #if !defined(TARGET_SPARC64)
-    env->mmuregs[0] |=3D env->def->mmu_version;
+    env->mmuregs[0] |=3D env->def.mmu_version;
     cpu_sparc_set_id(env, 0);
-    env->mxccregs[7] |=3D env->def->mxcc_version;
+    env->mxccregs[7] |=3D env->def.mxcc_version;
 #else
-    env->mmu_version =3D env->def->mmu_version;
-    env->maxtl =3D env->def->maxtl;
-    env->version |=3D env->def->maxtl << 8;
-    env->version |=3D env->def->nwindows - 1;
+    env->mmu_version =3D env->def.mmu_version;
+    env->maxtl =3D env->def.maxtl;
+    env->version |=3D env->def.maxtl << 8;
+    env->version |=3D env->def.nwindows - 1;
 #endif
     return 0;
 }
@@ -557,7 +557,7 @@ static void sparc_cpu_parse_features(CPUState *cs, ch=
ar *features,
                                      Error **errp)
 {
     SPARCCPU *cpu =3D SPARC_CPU(cs);
-    sparc_def_t *cpu_def =3D cpu->env.def;
+    sparc_def_t *cpu_def =3D &cpu->env.def;
     char *featurestr;
     uint32_t plus_features =3D 0;
     uint32_t minus_features =3D 0;
@@ -818,8 +818,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Err=
or **errp)
     SPARCCPU *cpu =3D SPARC_CPU(dev);
     CPUSPARCState *env =3D &cpu->env;
=20
-    if ((env->def->features & CPU_FEATURE_FLOAT)) {
-        env->def->features |=3D CPU_FEATURE_FLOAT128;
+    if ((env->def.features & CPU_FEATURE_FLOAT)) {
+        env->def.features |=3D CPU_FEATURE_FLOAT128;
     }
 #endif
=20
@@ -847,15 +847,9 @@ static void sparc_cpu_initfn(Object *obj)
         gen_intermediate_code_init(env);
     }
=20
-    env->def =3D g_memdup(scc->cpu_def, sizeof(*scc->cpu_def));
-}
-
-static void sparc_cpu_uninitfn(Object *obj)
-{
-    SPARCCPU *cpu =3D SPARC_CPU(obj);
-    CPUSPARCState *env =3D &cpu->env;
-
-    g_free(env->def);
+    if (scc->cpu_def) {
+        env->def =3D *scc->cpu_def;
+    }
 }
=20
 static void sparc_cpu_class_init(ObjectClass *oc, void *data)
@@ -904,7 +898,6 @@ static const TypeInfo sparc_cpu_type_info =3D {
     .parent =3D TYPE_CPU,
     .instance_size =3D sizeof(SPARCCPU),
     .instance_init =3D sparc_cpu_initfn,
-    .instance_finalize =3D sparc_cpu_uninitfn,
     .abstract =3D true,
     .class_size =3D sizeof(SPARCCPUClass),
     .class_init =3D sparc_cpu_class_init,
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index eec9a4d49f..c7724928c0 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -108,7 +108,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 #if !defined(CONFIG_USER_ONLY)
     if (env->psret =3D=3D 0) {
         if (cs->exception_index =3D=3D 0x80 &&
-            env->def->features & CPU_FEATURE_TA0_SHUTDOWN) {
+            env->def.features & CPU_FEATURE_TA0_SHUTDOWN) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         } else {
             cpu_abort(cs, "Trap 0x%02x while interrupts disabled, Error =
state",
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index f942973c22..f3e7f32de6 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -147,7 +147,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         }
     }
=20
-    if (env->def->features & CPU_FEATURE_GL) {
+    if (env->def.features & CPU_FEATURE_GL) {
         tsptr->tstate |=3D (env->gl & 7ULL) << 40;
         cpu_gl_switch_gregs(env, env->gl + 1);
         env->gl++;
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 57968d9143..fb489cb5fd 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -513,7 +513,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulo=
ng addr,
         case 0x00:          /* Leon3 Cache Control */
         case 0x08:          /* Leon3 Instruction Cache config */
         case 0x0C:          /* Leon3 Date Cache config */
-            if (env->def->features & CPU_FEATURE_CACHE_CTRL) {
+            if (env->def.features & CPU_FEATURE_CACHE_CTRL) {
                 ret =3D leon3_cache_control_ld(env, addr, size);
             }
             break;
@@ -736,7 +736,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong a=
ddr, uint64_t val,
         case 0x00:          /* Leon3 Cache Control */
         case 0x08:          /* Leon3 Instruction Cache config */
         case 0x0C:          /* Leon3 Date Cache config */
-            if (env->def->features & CPU_FEATURE_CACHE_CTRL) {
+            if (env->def.features & CPU_FEATURE_CACHE_CTRL) {
                 leon3_cache_control_st(env, addr, val, size);
             }
             break;
@@ -904,15 +904,15 @@ void helper_st_asi(CPUSPARCState *env, target_ulong=
 addr, uint64_t val,
                 /* Mappings generated during no-fault mode
                    are invalid in normal mode.  */
                 if ((oldreg ^ env->mmuregs[reg])
-                    & (MMU_NF | env->def->mmu_bm)) {
+                    & (MMU_NF | env->def.mmu_bm)) {
                     tlb_flush(CPU(cpu));
                 }
                 break;
             case 1: /* Context Table Pointer Register */
-                env->mmuregs[reg] =3D val & env->def->mmu_ctpr_mask;
+                env->mmuregs[reg] =3D val & env->def.mmu_ctpr_mask;
                 break;
             case 2: /* Context Register */
-                env->mmuregs[reg] =3D val & env->def->mmu_cxr_mask;
+                env->mmuregs[reg] =3D val & env->def.mmu_cxr_mask;
                 if (oldreg !=3D env->mmuregs[reg]) {
                     /* we flush when the MMU context changes because
                        QEMU has no MMU context support */
@@ -923,11 +923,11 @@ void helper_st_asi(CPUSPARCState *env, target_ulong=
 addr, uint64_t val,
             case 4: /* Synchronous Fault Address Register */
                 break;
             case 0x10: /* TLB Replacement Control Register */
-                env->mmuregs[reg] =3D val & env->def->mmu_trcr_mask;
+                env->mmuregs[reg] =3D val & env->def.mmu_trcr_mask;
                 break;
             case 0x13: /* Synchronous Fault Status Register with Read
                           and Clear */
-                env->mmuregs[3] =3D val & env->def->mmu_sfsr_mask;
+                env->mmuregs[3] =3D val & env->def.mmu_sfsr_mask;
                 break;
             case 0x14: /* Synchronous Fault Address Register */
                 env->mmuregs[4] =3D val;
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 8b4664d996..126ea5e3ee 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -95,7 +95,7 @@ static int get_physical_address(CPUSPARCState *env, hwa=
ddr *physical,
     if (mmu_idx =3D=3D MMU_PHYS_IDX) {
         *page_size =3D TARGET_PAGE_SIZE;
         /* Boot mode: instruction fetches are taken from PROM */
-        if (rw =3D=3D 2 && (env->mmuregs[0] & env->def->mmu_bm)) {
+        if (rw =3D=3D 2 && (env->mmuregs[0] & env->def.mmu_bm)) {
             *physical =3D env->prom_addr | (address & 0x7ffffULL);
             *prot =3D PAGE_READ | PAGE_EXEC;
             return 0;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 3bde47be83..6290705b11 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5756,7 +5756,7 @@ void gen_intermediate_code(CPUState *cs, Translatio=
nBlock * tb)
     dc->npc =3D (target_ulong) tb->cs_base;
     dc->cc_op =3D CC_OP_DYNAMIC;
     dc->mem_idx =3D tb->flags & TB_FLAG_MMU_MASK;
-    dc->def =3D env->def;
+    dc->def =3D &env->def;
     dc->fpu_enabled =3D tb_fpu_enabled(tb->flags);
     dc->address_mask_32bit =3D tb_am_enabled(tb->flags);
     dc->singlestep =3D (cs->singlestep_enabled || singlestep);
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 154279ecda..8290a21142 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -295,7 +295,7 @@ void helper_wrcwp(CPUSPARCState *env, target_ulong ne=
w_cwp)
=20
 static inline uint64_t *get_gregset(CPUSPARCState *env, uint32_t pstate)
 {
-    if (env->def->features & CPU_FEATURE_GL) {
+    if (env->def.features & CPU_FEATURE_GL) {
         return env->glregs + (env->gl & 7) * 8;
     }
=20
@@ -343,7 +343,7 @@ void cpu_change_pstate(CPUSPARCState *env, uint32_t n=
ew_pstate)
     uint32_t pstate_regs, new_pstate_regs;
     uint64_t *src, *dst;
=20
-    if (env->def->features & CPU_FEATURE_GL) {
+    if (env->def.features & CPU_FEATURE_GL) {
         /* PS_AG, IG and MG are not implemented in this case */
         new_pstate &=3D ~(PS_AG | PS_IG | PS_MG);
         env->pstate =3D new_pstate;
--=20
2.13.5
