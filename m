Received: from eggs.gnu.org ([2001:4830:134:3::10]:42671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtirf-0003Lh-E8
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 19:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtirb-0007Y7-CZ
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 19:20:39 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtirb-0007Xo-5I
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 19:20:35 -0400
Received: by mail-qk0-x241.google.com with SMTP id i14so4567910qke.3
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 16:20:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 17 Sep 2017 20:20:06 -0300
Message-Id: <20170917232010.14183-3-f4bug@amsat.org>
In-Reply-To: <20170917232010.14183-1-f4bug@amsat.org>
References: <20170917232010.14183-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/6] mips: introduce internal.h and cleanup
 cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, James Hogan <james.hogan@imgtec.com>, Thomas Huth <thuth@redhat.com>

no logical change, only code movement (and fix a comment typo).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: James Hogan <james.hogan@imgtec.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
---
This patch triggers 3 positive falses from checkpatch:

ERROR: space prohibited after that '&' (ctx:WxW)
#664: FILE: target/mips/internal.h:230:
+    if ((env->CP0_VPControl >> CP0VPCtl_DIS) & 1) {
                                              ^
#672: FILE: target/mips/internal.h:238:
+            ((other_cpu->env.CP0_VPControl >> CP0VPCtl_DIS) & 1)) {
                                                             ^
#692: FILE: target/mips/internal.h:258:
+        env->hflags |= (env->CP0_Status >> CP0St_KSU) & MIPS_HFLAG_KSU;
                                                       ^
total: 3 errors, 0 warnings, 842 lines checked

This is a "binary vs unary operators" confusion.

 target/mips/cpu.h        | 354 +--------------------------------------------
 target/mips/internal.h   | 362 +++++++++++++++++++++++++++++++++++++++++++++++
 target/mips/cp0_timer.c  |   1 +
 target/mips/cpu.c        |   1 +
 target/mips/gdbstub.c    |   1 +
 target/mips/helper.c     |   1 +
 target/mips/kvm.c        |   1 +
 target/mips/machine.c    |   1 +
 target/mips/msa_helper.c |   1 +
 target/mips/op_helper.c  |   1 +
 target/mips/translate.c  |   1 +
 11 files changed, 372 insertions(+), 353 deletions(-)
 create mode 100644 target/mips/internal.h

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 74f6a5b098..2f81e0f950 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1,8 +1,6 @@
 #ifndef MIPS_CPU_H
 #define MIPS_CPU_H
 
-//#define DEBUG_OP
-
 #define ALIGNED_ONLY
 
 #define CPUArchState struct CPUMIPSState
@@ -15,56 +13,11 @@
 
 struct CPUMIPSState;
 
-typedef struct r4k_tlb_t r4k_tlb_t;
-struct r4k_tlb_t {
-    target_ulong VPN;
-    uint32_t PageMask;
-    uint16_t ASID;
-    unsigned int G:1;
-    unsigned int C0:3;
-    unsigned int C1:3;
-    unsigned int V0:1;
-    unsigned int V1:1;
-    unsigned int D0:1;
-    unsigned int D1:1;
-    unsigned int XI0:1;
-    unsigned int XI1:1;
-    unsigned int RI0:1;
-    unsigned int RI1:1;
-    unsigned int EHINV:1;
-    uint64_t PFN[2];
-};
-
-#if !defined(CONFIG_USER_ONLY)
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
-struct CPUMIPSTLBContext {
-    uint32_t nb_tlb;
-    uint32_t tlb_in_use;
-    int (*map_address) (struct CPUMIPSState *env, hwaddr *physical, int *prot, target_ulong address, int rw, int access_type);
-    void (*helper_tlbwi)(struct CPUMIPSState *env);
-    void (*helper_tlbwr)(struct CPUMIPSState *env);
-    void (*helper_tlbp)(struct CPUMIPSState *env);
-    void (*helper_tlbr)(struct CPUMIPSState *env);
-    void (*helper_tlbinv)(struct CPUMIPSState *env);
-    void (*helper_tlbinvf)(struct CPUMIPSState *env);
-    union {
-        struct {
-            r4k_tlb_t tlb[MIPS_TLB_MAX];
-        } r4k;
-    } mmu;
-};
-#endif
 
 /* MSA Context */
 #define MSA_WRLEN (128)
 
-enum CPUMIPSMSADataFormat {
-    DF_BYTE = 0,
-    DF_HALF,
-    DF_WORD,
-    DF_DOUBLE
-};
-
 typedef union wr_t wr_t;
 union wr_t {
     int8_t  b[MSA_WRLEN/8];
@@ -682,40 +635,6 @@ static inline MIPSCPU *mips_env_get_cpu(CPUMIPSState *env)
 
 #define ENV_OFFSET offsetof(MIPSCPU, env)
 
-#ifndef CONFIG_USER_ONLY
-extern const struct VMStateDescription vmstate_mips_cpu;
-#endif
-
-void mips_cpu_do_interrupt(CPUState *cpu);
-bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
-void mips_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
-                         int flags);
-hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int mips_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
-int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
-void mips_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
-                                  MMUAccessType access_type,
-                                  int mmu_idx, uintptr_t retaddr);
-
-#if !defined(CONFIG_USER_ONLY)
-int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
-                        target_ulong address, int rw, int access_type);
-int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
-                           target_ulong address, int rw, int access_type);
-int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
-                     target_ulong address, int rw, int access_type);
-void r4k_helper_tlbwi(CPUMIPSState *env);
-void r4k_helper_tlbwr(CPUMIPSState *env);
-void r4k_helper_tlbp(CPUMIPSState *env);
-void r4k_helper_tlbr(CPUMIPSState *env);
-void r4k_helper_tlbinv(CPUMIPSState *env);
-void r4k_helper_tlbinvf(CPUMIPSState *env);
-
-void mips_cpu_unassigned_access(CPUState *cpu, hwaddr addr,
-                                bool is_write, bool is_exec, int unused,
-                                unsigned size);
-#endif
-
 void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf);
 
 #define cpu_signal_handler cpu_mips_signal_handler
@@ -746,42 +665,6 @@ static inline int cpu_mmu_index (CPUMIPSState *env, bool ifetch)
     return hflags_mmu_index(env->hflags);
 }
 
-static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
-{
-    return (env->CP0_Status & (1 << CP0St_IE)) &&
-        !(env->CP0_Status & (1 << CP0St_EXL)) &&
-        !(env->CP0_Status & (1 << CP0St_ERL)) &&
-        !(env->hflags & MIPS_HFLAG_DM) &&
-        /* Note that the TCStatus IXMT field is initialized to zero,
-           and only MT capable cores can set it to one. So we don't
-           need to check for MT capabilities here.  */
-        !(env->active_tc.CP0_TCStatus & (1 << CP0TCSt_IXMT));
-}
-
-/* Check if there is pending and not masked out interrupt */
-static inline bool cpu_mips_hw_interrupts_pending(CPUMIPSState *env)
-{
-    int32_t pending;
-    int32_t status;
-    bool r;
-
-    pending = env->CP0_Cause & CP0Ca_IP_mask;
-    status = env->CP0_Status & CP0Ca_IP_mask;
-
-    if (env->CP0_Config3 & (1 << CP0C3_VEIC)) {
-        /* A MIPS configured with a vectorizing external interrupt controller
-           will feed a vector into the Cause pending lines. The core treats
-           the status lines as a vector level, not as indiviual masks.  */
-        r = pending > status;
-    } else {
-        /* A MIPS configured with compatibility or VInt (Vectored Interrupts)
-           treats the pending lines as individual interrupt lines, the status
-           lines are individual masks.  */
-        r = (pending & status) != 0;
-    }
-    return r;
-}
-
 #include "exec/cpu-all.h"
 
 /* Memory access type :
@@ -847,14 +730,13 @@ enum {
 #define EXCP_SC 0x100
 
 /*
- * This is an interrnally generated WAKE request line.
+ * This is an internally generated WAKE request line.
  * It is driven by the CPU itself. Raised when the MT
  * block wants to wake a VPE from an inactive state and
  * cleared when VPE goes from active to inactive.
  */
 #define CPU_INTERRUPT_WAKE CPU_INTERRUPT_TGT_INT_0
 
-void mips_tcg_init(void);
 MIPSCPU *cpu_mips_init(const char *cpu_model);
 int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
 
@@ -863,84 +745,18 @@ bool cpu_supports_cps_smp(const char *cpu_model);
 bool cpu_supports_isa(const char *cpu_model, unsigned int isa);
 void cpu_set_exception_base(int vp_index, target_ulong address);
 
-/* TODO QOM'ify CPU reset and remove */
-void cpu_state_reset(CPUMIPSState *s);
-
-/* mips_timer.c */
-uint32_t cpu_mips_get_random (CPUMIPSState *env);
-uint32_t cpu_mips_get_count (CPUMIPSState *env);
-void cpu_mips_store_count (CPUMIPSState *env, uint32_t value);
-void cpu_mips_store_compare (CPUMIPSState *env, uint32_t value);
-void cpu_mips_start_count(CPUMIPSState *env);
-void cpu_mips_stop_count(CPUMIPSState *env);
-
 /* mips_int.c */
 void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level);
 
 /* helper.c */
-int mips_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
-                              int mmu_idx);
-
-/* op_helper.c */
-uint32_t float_class_s(uint32_t arg, float_status *fst);
-uint64_t float_class_d(uint64_t arg, float_status *fst);
-
-#if !defined(CONFIG_USER_ONLY)
-void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra);
-hwaddr cpu_mips_translate_address (CPUMIPSState *env, target_ulong address,
-		                               int rw);
-#endif
 target_ulong exception_resume_pc (CPUMIPSState *env);
 
-/* op_helper.c */
-extern unsigned int ieee_rm[];
-int ieee_ex_to_mips(int xcpt);
-
-static inline void restore_rounding_mode(CPUMIPSState *env)
-{
-    set_float_rounding_mode(ieee_rm[env->active_fpu.fcr31 & 3],
-                            &env->active_fpu.fp_status);
-}
-
-static inline void restore_flush_mode(CPUMIPSState *env)
-{
-    set_flush_to_zero((env->active_fpu.fcr31 & (1 << FCR31_FS)) != 0,
-                      &env->active_fpu.fp_status);
-}
-
 static inline void restore_snan_bit_mode(CPUMIPSState *env)
 {
     set_snan_bit_is_one((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) == 0,
                         &env->active_fpu.fp_status);
 }
 
-static inline void restore_fp_status(CPUMIPSState *env)
-{
-    restore_rounding_mode(env);
-    restore_flush_mode(env);
-    restore_snan_bit_mode(env);
-}
-
-static inline void restore_msa_fp_status(CPUMIPSState *env)
-{
-    float_status *status = &env->active_tc.msa_fp_status;
-    int rounding_mode = (env->active_tc.msacsr & MSACSR_RM_MASK) >> MSACSR_RM;
-    bool flush_to_zero = (env->active_tc.msacsr & MSACSR_FS_MASK) != 0;
-
-    set_float_rounding_mode(ieee_rm[rounding_mode], status);
-    set_flush_to_zero(flush_to_zero, status);
-    set_flush_inputs_to_zero(flush_to_zero, status);
-}
-
-static inline void restore_pamask(CPUMIPSState *env)
-{
-    if (env->hflags & MIPS_HFLAG_ELPA) {
-        env->PAMask = (1ULL << env->PABITS) - 1;
-    } else {
-        env->PAMask = PAMASK_BASE;
-    }
-}
-
 static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
@@ -950,172 +766,4 @@ static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, target_ulong *pc,
                             MIPS_HFLAG_HWRENA_ULR);
 }
 
-static inline int mips_vpe_active(CPUMIPSState *env)
-{
-    int active = 1;
-
-    /* Check that the VPE is enabled.  */
-    if (!(env->mvp->CP0_MVPControl & (1 << CP0MVPCo_EVP))) {
-        active = 0;
-    }
-    /* Check that the VPE is activated.  */
-    if (!(env->CP0_VPEConf0 & (1 << CP0VPEC0_VPA))) {
-        active = 0;
-    }
-
-    /* Now verify that there are active thread contexts in the VPE.
-
-       This assumes the CPU model will internally reschedule threads
-       if the active one goes to sleep. If there are no threads available
-       the active one will be in a sleeping state, and we can turn off
-       the entire VPE.  */
-    if (!(env->active_tc.CP0_TCStatus & (1 << CP0TCSt_A))) {
-        /* TC is not activated.  */
-        active = 0;
-    }
-    if (env->active_tc.CP0_TCHalt & 1) {
-        /* TC is in halt state.  */
-        active = 0;
-    }
-
-    return active;
-}
-
-static inline int mips_vp_active(CPUMIPSState *env)
-{
-    CPUState *other_cs = first_cpu;
-
-    /* Check if the VP disabled other VPs (which means the VP is enabled) */
-    if ((env->CP0_VPControl >> CP0VPCtl_DIS) & 1) {
-        return 1;
-    }
-
-    /* Check if the virtual processor is disabled due to a DVP */
-    CPU_FOREACH(other_cs) {
-        MIPSCPU *other_cpu = MIPS_CPU(other_cs);
-        if ((&other_cpu->env != env) &&
-            ((other_cpu->env.CP0_VPControl >> CP0VPCtl_DIS) & 1)) {
-            return 0;
-        }
-    }
-    return 1;
-}
-
-static inline void compute_hflags(CPUMIPSState *env)
-{
-    env->hflags &= ~(MIPS_HFLAG_COP1X | MIPS_HFLAG_64 | MIPS_HFLAG_CP0 |
-                     MIPS_HFLAG_F64 | MIPS_HFLAG_FPU | MIPS_HFLAG_KSU |
-                     MIPS_HFLAG_AWRAP | MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR2 |
-                     MIPS_HFLAG_SBRI | MIPS_HFLAG_MSA | MIPS_HFLAG_FRE |
-                     MIPS_HFLAG_ELPA | MIPS_HFLAG_ERL);
-    if (env->CP0_Status & (1 << CP0St_ERL)) {
-        env->hflags |= MIPS_HFLAG_ERL;
-    }
-    if (!(env->CP0_Status & (1 << CP0St_EXL)) &&
-        !(env->CP0_Status & (1 << CP0St_ERL)) &&
-        !(env->hflags & MIPS_HFLAG_DM)) {
-        env->hflags |= (env->CP0_Status >> CP0St_KSU) & MIPS_HFLAG_KSU;
-    }
-#if defined(TARGET_MIPS64)
-    if ((env->insn_flags & ISA_MIPS3) &&
-        (((env->hflags & MIPS_HFLAG_KSU) != MIPS_HFLAG_UM) ||
-         (env->CP0_Status & (1 << CP0St_PX)) ||
-         (env->CP0_Status & (1 << CP0St_UX)))) {
-        env->hflags |= MIPS_HFLAG_64;
-    }
-
-    if (!(env->insn_flags & ISA_MIPS3)) {
-        env->hflags |= MIPS_HFLAG_AWRAP;
-    } else if (((env->hflags & MIPS_HFLAG_KSU) == MIPS_HFLAG_UM) &&
-               !(env->CP0_Status & (1 << CP0St_UX))) {
-        env->hflags |= MIPS_HFLAG_AWRAP;
-    } else if (env->insn_flags & ISA_MIPS64R6) {
-        /* Address wrapping for Supervisor and Kernel is specified in R6 */
-        if ((((env->hflags & MIPS_HFLAG_KSU) == MIPS_HFLAG_SM) &&
-             !(env->CP0_Status & (1 << CP0St_SX))) ||
-            (((env->hflags & MIPS_HFLAG_KSU) == MIPS_HFLAG_KM) &&
-             !(env->CP0_Status & (1 << CP0St_KX)))) {
-            env->hflags |= MIPS_HFLAG_AWRAP;
-        }
-    }
-#endif
-    if (((env->CP0_Status & (1 << CP0St_CU0)) &&
-         !(env->insn_flags & ISA_MIPS32R6)) ||
-        !(env->hflags & MIPS_HFLAG_KSU)) {
-        env->hflags |= MIPS_HFLAG_CP0;
-    }
-    if (env->CP0_Status & (1 << CP0St_CU1)) {
-        env->hflags |= MIPS_HFLAG_FPU;
-    }
-    if (env->CP0_Status & (1 << CP0St_FR)) {
-        env->hflags |= MIPS_HFLAG_F64;
-    }
-    if (((env->hflags & MIPS_HFLAG_KSU) != MIPS_HFLAG_KM) &&
-        (env->CP0_Config5 & (1 << CP0C5_SBRI))) {
-        env->hflags |= MIPS_HFLAG_SBRI;
-    }
-    if (env->insn_flags & ASE_DSPR2) {
-        /* Enables access MIPS DSP resources, now our cpu is DSP ASER2,
-           so enable to access DSPR2 resources. */
-        if (env->CP0_Status & (1 << CP0St_MX)) {
-            env->hflags |= MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR2;
-        }
-
-    } else if (env->insn_flags & ASE_DSP) {
-        /* Enables access MIPS DSP resources, now our cpu is DSP ASE,
-           so enable to access DSP resources. */
-        if (env->CP0_Status & (1 << CP0St_MX)) {
-            env->hflags |= MIPS_HFLAG_DSP;
-        }
-
-    }
-    if (env->insn_flags & ISA_MIPS32R2) {
-        if (env->active_fpu.fcr0 & (1 << FCR0_F64)) {
-            env->hflags |= MIPS_HFLAG_COP1X;
-        }
-    } else if (env->insn_flags & ISA_MIPS32) {
-        if (env->hflags & MIPS_HFLAG_64) {
-            env->hflags |= MIPS_HFLAG_COP1X;
-        }
-    } else if (env->insn_flags & ISA_MIPS4) {
-        /* All supported MIPS IV CPUs use the XX (CU3) to enable
-           and disable the MIPS IV extensions to the MIPS III ISA.
-           Some other MIPS IV CPUs ignore the bit, so the check here
-           would be too restrictive for them.  */
-        if (env->CP0_Status & (1U << CP0St_CU3)) {
-            env->hflags |= MIPS_HFLAG_COP1X;
-        }
-    }
-    if (env->insn_flags & ASE_MSA) {
-        if (env->CP0_Config5 & (1 << CP0C5_MSAEn)) {
-            env->hflags |= MIPS_HFLAG_MSA;
-        }
-    }
-    if (env->active_fpu.fcr0 & (1 << FCR0_FREP)) {
-        if (env->CP0_Config5 & (1 << CP0C5_FRE)) {
-            env->hflags |= MIPS_HFLAG_FRE;
-        }
-    }
-    if (env->CP0_Config3 & (1 << CP0C3_LPA)) {
-        if (env->CP0_PageGrain & (1 << CP0PG_ELPA)) {
-            env->hflags |= MIPS_HFLAG_ELPA;
-        }
-    }
-}
-
-void cpu_mips_tlb_flush(CPUMIPSState *env);
-void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu, int tc);
-void cpu_mips_store_status(CPUMIPSState *env, target_ulong val);
-void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val);
-
-void QEMU_NORETURN do_raise_exception_err(CPUMIPSState *env, uint32_t exception,
-                                          int error_code, uintptr_t pc);
-
-static inline void QEMU_NORETURN do_raise_exception(CPUMIPSState *env,
-                                                    uint32_t exception,
-                                                    uintptr_t pc)
-{
-    do_raise_exception_err(env, exception, 0, pc);
-}
-
 #endif /* MIPS_CPU_H */
diff --git a/target/mips/internal.h b/target/mips/internal.h
new file mode 100644
index 0000000000..91c2df4537
--- /dev/null
+++ b/target/mips/internal.h
@@ -0,0 +1,362 @@
+/* mips internal definitions and helpers
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef MIPS_INTERNAL_H
+#define MIPS_INTERNAL_H
+
+enum CPUMIPSMSADataFormat {
+    DF_BYTE = 0,
+    DF_HALF,
+    DF_WORD,
+    DF_DOUBLE
+};
+
+void mips_cpu_do_interrupt(CPUState *cpu);
+bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
+void mips_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
+                         int flags);
+hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+int mips_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+void mips_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
+                                  MMUAccessType access_type,
+                                  int mmu_idx, uintptr_t retaddr);
+
+#if !defined(CONFIG_USER_ONLY)
+
+typedef struct r4k_tlb_t r4k_tlb_t;
+struct r4k_tlb_t {
+    target_ulong VPN;
+    uint32_t PageMask;
+    uint16_t ASID;
+    unsigned int G:1;
+    unsigned int C0:3;
+    unsigned int C1:3;
+    unsigned int V0:1;
+    unsigned int V1:1;
+    unsigned int D0:1;
+    unsigned int D1:1;
+    unsigned int XI0:1;
+    unsigned int XI1:1;
+    unsigned int RI0:1;
+    unsigned int RI1:1;
+    unsigned int EHINV:1;
+    uint64_t PFN[2];
+};
+
+struct CPUMIPSTLBContext {
+    uint32_t nb_tlb;
+    uint32_t tlb_in_use;
+    int (*map_address)(struct CPUMIPSState *env, hwaddr *physical, int *prot,
+                       target_ulong address, int rw, int access_type);
+    void (*helper_tlbwi)(struct CPUMIPSState *env);
+    void (*helper_tlbwr)(struct CPUMIPSState *env);
+    void (*helper_tlbp)(struct CPUMIPSState *env);
+    void (*helper_tlbr)(struct CPUMIPSState *env);
+    void (*helper_tlbinv)(struct CPUMIPSState *env);
+    void (*helper_tlbinvf)(struct CPUMIPSState *env);
+    union {
+        struct {
+            r4k_tlb_t tlb[MIPS_TLB_MAX];
+        } r4k;
+    } mmu;
+};
+
+int no_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
+                       target_ulong address, int rw, int access_type);
+int fixed_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
+                          target_ulong address, int rw, int access_type);
+int r4k_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
+                    target_ulong address, int rw, int access_type);
+void r4k_helper_tlbwi(CPUMIPSState *env);
+void r4k_helper_tlbwr(CPUMIPSState *env);
+void r4k_helper_tlbp(CPUMIPSState *env);
+void r4k_helper_tlbr(CPUMIPSState *env);
+void r4k_helper_tlbinv(CPUMIPSState *env);
+void r4k_helper_tlbinvf(CPUMIPSState *env);
+void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
+
+void mips_cpu_unassigned_access(CPUState *cpu, hwaddr addr,
+                                bool is_write, bool is_exec, int unused,
+                                unsigned size);
+hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong address,
+                                  int rw);
+#endif
+
+#define cpu_signal_handler cpu_mips_signal_handler
+
+#ifndef CONFIG_USER_ONLY
+extern const struct VMStateDescription vmstate_mips_cpu;
+#endif
+
+static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
+{
+    return (env->CP0_Status & (1 << CP0St_IE)) &&
+        !(env->CP0_Status & (1 << CP0St_EXL)) &&
+        !(env->CP0_Status & (1 << CP0St_ERL)) &&
+        !(env->hflags & MIPS_HFLAG_DM) &&
+        /* Note that the TCStatus IXMT field is initialized to zero,
+           and only MT capable cores can set it to one. So we don't
+           need to check for MT capabilities here.  */
+        !(env->active_tc.CP0_TCStatus & (1 << CP0TCSt_IXMT));
+}
+
+/* Check if there is pending and not masked out interrupt */
+static inline bool cpu_mips_hw_interrupts_pending(CPUMIPSState *env)
+{
+    int32_t pending;
+    int32_t status;
+    bool r;
+
+    pending = env->CP0_Cause & CP0Ca_IP_mask;
+    status = env->CP0_Status & CP0Ca_IP_mask;
+
+    if (env->CP0_Config3 & (1 << CP0C3_VEIC)) {
+        /* A MIPS configured with a vectorizing external interrupt controller
+           will feed a vector into the Cause pending lines. The core treats
+           the status lines as a vector level, not as indiviual masks.  */
+        r = pending > status;
+    } else {
+        /* A MIPS configured with compatibility or VInt (Vectored Interrupts)
+           treats the pending lines as individual interrupt lines, the status
+           lines are individual masks.  */
+        r = (pending & status) != 0;
+    }
+    return r;
+}
+
+void mips_tcg_init(void);
+
+/* TODO QOM'ify CPU reset and remove */
+void cpu_state_reset(CPUMIPSState *s);
+
+/* cp0_timer.c */
+uint32_t cpu_mips_get_random(CPUMIPSState *env);
+uint32_t cpu_mips_get_count(CPUMIPSState *env);
+void cpu_mips_store_count(CPUMIPSState *env, uint32_t value);
+void cpu_mips_store_compare(CPUMIPSState *env, uint32_t value);
+void cpu_mips_start_count(CPUMIPSState *env);
+void cpu_mips_stop_count(CPUMIPSState *env);
+
+/* helper.c */
+int mips_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+                              int mmu_idx);
+
+/* op_helper.c */
+uint32_t float_class_s(uint32_t arg, float_status *fst);
+uint64_t float_class_d(uint64_t arg, float_status *fst);
+
+extern unsigned int ieee_rm[];
+int ieee_ex_to_mips(int xcpt);
+
+static inline void restore_rounding_mode(CPUMIPSState *env)
+{
+    set_float_rounding_mode(ieee_rm[env->active_fpu.fcr31 & 3],
+                            &env->active_fpu.fp_status);
+}
+
+static inline void restore_flush_mode(CPUMIPSState *env)
+{
+    set_flush_to_zero((env->active_fpu.fcr31 & (1 << FCR31_FS)) != 0,
+                      &env->active_fpu.fp_status);
+}
+
+static inline void restore_fp_status(CPUMIPSState *env)
+{
+    restore_rounding_mode(env);
+    restore_flush_mode(env);
+    restore_snan_bit_mode(env);
+}
+
+static inline void restore_msa_fp_status(CPUMIPSState *env)
+{
+    float_status *status = &env->active_tc.msa_fp_status;
+    int rounding_mode = (env->active_tc.msacsr & MSACSR_RM_MASK) >> MSACSR_RM;
+    bool flush_to_zero = (env->active_tc.msacsr & MSACSR_FS_MASK) != 0;
+
+    set_float_rounding_mode(ieee_rm[rounding_mode], status);
+    set_flush_to_zero(flush_to_zero, status);
+    set_flush_inputs_to_zero(flush_to_zero, status);
+}
+
+static inline void restore_pamask(CPUMIPSState *env)
+{
+    if (env->hflags & MIPS_HFLAG_ELPA) {
+        env->PAMask = (1ULL << env->PABITS) - 1;
+    } else {
+        env->PAMask = PAMASK_BASE;
+    }
+}
+
+static inline int mips_vpe_active(CPUMIPSState *env)
+{
+    int active = 1;
+
+    /* Check that the VPE is enabled.  */
+    if (!(env->mvp->CP0_MVPControl & (1 << CP0MVPCo_EVP))) {
+        active = 0;
+    }
+    /* Check that the VPE is activated.  */
+    if (!(env->CP0_VPEConf0 & (1 << CP0VPEC0_VPA))) {
+        active = 0;
+    }
+
+    /* Now verify that there are active thread contexts in the VPE.
+
+       This assumes the CPU model will internally reschedule threads
+       if the active one goes to sleep. If there are no threads available
+       the active one will be in a sleeping state, and we can turn off
+       the entire VPE.  */
+    if (!(env->active_tc.CP0_TCStatus & (1 << CP0TCSt_A))) {
+        /* TC is not activated.  */
+        active = 0;
+    }
+    if (env->active_tc.CP0_TCHalt & 1) {
+        /* TC is in halt state.  */
+        active = 0;
+    }
+
+    return active;
+}
+
+static inline int mips_vp_active(CPUMIPSState *env)
+{
+    CPUState *other_cs = first_cpu;
+
+    /* Check if the VP disabled other VPs (which means the VP is enabled) */
+    if ((env->CP0_VPControl >> CP0VPCtl_DIS) & 1) {
+        return 1;
+    }
+
+    /* Check if the virtual processor is disabled due to a DVP */
+    CPU_FOREACH(other_cs) {
+        MIPSCPU *other_cpu = MIPS_CPU(other_cs);
+        if ((&other_cpu->env != env) &&
+            ((other_cpu->env.CP0_VPControl >> CP0VPCtl_DIS) & 1)) {
+            return 0;
+        }
+    }
+    return 1;
+}
+
+static inline void compute_hflags(CPUMIPSState *env)
+{
+    env->hflags &= ~(MIPS_HFLAG_COP1X | MIPS_HFLAG_64 | MIPS_HFLAG_CP0 |
+                     MIPS_HFLAG_F64 | MIPS_HFLAG_FPU | MIPS_HFLAG_KSU |
+                     MIPS_HFLAG_AWRAP | MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR2 |
+                     MIPS_HFLAG_SBRI | MIPS_HFLAG_MSA | MIPS_HFLAG_FRE |
+                     MIPS_HFLAG_ELPA | MIPS_HFLAG_ERL);
+    if (env->CP0_Status & (1 << CP0St_ERL)) {
+        env->hflags |= MIPS_HFLAG_ERL;
+    }
+    if (!(env->CP0_Status & (1 << CP0St_EXL)) &&
+        !(env->CP0_Status & (1 << CP0St_ERL)) &&
+        !(env->hflags & MIPS_HFLAG_DM)) {
+        env->hflags |= (env->CP0_Status >> CP0St_KSU) & MIPS_HFLAG_KSU;
+    }
+#if defined(TARGET_MIPS64)
+    if ((env->insn_flags & ISA_MIPS3) &&
+        (((env->hflags & MIPS_HFLAG_KSU) != MIPS_HFLAG_UM) ||
+         (env->CP0_Status & (1 << CP0St_PX)) ||
+         (env->CP0_Status & (1 << CP0St_UX)))) {
+        env->hflags |= MIPS_HFLAG_64;
+    }
+
+    if (!(env->insn_flags & ISA_MIPS3)) {
+        env->hflags |= MIPS_HFLAG_AWRAP;
+    } else if (((env->hflags & MIPS_HFLAG_KSU) == MIPS_HFLAG_UM) &&
+               !(env->CP0_Status & (1 << CP0St_UX))) {
+        env->hflags |= MIPS_HFLAG_AWRAP;
+    } else if (env->insn_flags & ISA_MIPS64R6) {
+        /* Address wrapping for Supervisor and Kernel is specified in R6 */
+        if ((((env->hflags & MIPS_HFLAG_KSU) == MIPS_HFLAG_SM) &&
+             !(env->CP0_Status & (1 << CP0St_SX))) ||
+            (((env->hflags & MIPS_HFLAG_KSU) == MIPS_HFLAG_KM) &&
+             !(env->CP0_Status & (1 << CP0St_KX)))) {
+            env->hflags |= MIPS_HFLAG_AWRAP;
+        }
+    }
+#endif
+    if (((env->CP0_Status & (1 << CP0St_CU0)) &&
+         !(env->insn_flags & ISA_MIPS32R6)) ||
+        !(env->hflags & MIPS_HFLAG_KSU)) {
+        env->hflags |= MIPS_HFLAG_CP0;
+    }
+    if (env->CP0_Status & (1 << CP0St_CU1)) {
+        env->hflags |= MIPS_HFLAG_FPU;
+    }
+    if (env->CP0_Status & (1 << CP0St_FR)) {
+        env->hflags |= MIPS_HFLAG_F64;
+    }
+    if (((env->hflags & MIPS_HFLAG_KSU) != MIPS_HFLAG_KM) &&
+        (env->CP0_Config5 & (1 << CP0C5_SBRI))) {
+        env->hflags |= MIPS_HFLAG_SBRI;
+    }
+    if (env->insn_flags & ASE_DSPR2) {
+        /* Enables access MIPS DSP resources, now our cpu is DSP ASER2,
+           so enable to access DSPR2 resources. */
+        if (env->CP0_Status & (1 << CP0St_MX)) {
+            env->hflags |= MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR2;
+        }
+
+    } else if (env->insn_flags & ASE_DSP) {
+        /* Enables access MIPS DSP resources, now our cpu is DSP ASE,
+           so enable to access DSP resources. */
+        if (env->CP0_Status & (1 << CP0St_MX)) {
+            env->hflags |= MIPS_HFLAG_DSP;
+        }
+
+    }
+    if (env->insn_flags & ISA_MIPS32R2) {
+        if (env->active_fpu.fcr0 & (1 << FCR0_F64)) {
+            env->hflags |= MIPS_HFLAG_COP1X;
+        }
+    } else if (env->insn_flags & ISA_MIPS32) {
+        if (env->hflags & MIPS_HFLAG_64) {
+            env->hflags |= MIPS_HFLAG_COP1X;
+        }
+    } else if (env->insn_flags & ISA_MIPS4) {
+        /* All supported MIPS IV CPUs use the XX (CU3) to enable
+           and disable the MIPS IV extensions to the MIPS III ISA.
+           Some other MIPS IV CPUs ignore the bit, so the check here
+           would be too restrictive for them.  */
+        if (env->CP0_Status & (1U << CP0St_CU3)) {
+            env->hflags |= MIPS_HFLAG_COP1X;
+        }
+    }
+    if (env->insn_flags & ASE_MSA) {
+        if (env->CP0_Config5 & (1 << CP0C5_MSAEn)) {
+            env->hflags |= MIPS_HFLAG_MSA;
+        }
+    }
+    if (env->active_fpu.fcr0 & (1 << FCR0_FREP)) {
+        if (env->CP0_Config5 & (1 << CP0C5_FRE)) {
+            env->hflags |= MIPS_HFLAG_FRE;
+        }
+    }
+    if (env->CP0_Config3 & (1 << CP0C3_LPA)) {
+        if (env->CP0_PageGrain & (1 << CP0PG_ELPA)) {
+            env->hflags |= MIPS_HFLAG_ELPA;
+        }
+    }
+}
+
+void cpu_mips_tlb_flush(CPUMIPSState *env);
+void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu, int tc);
+void cpu_mips_store_status(CPUMIPSState *env, target_ulong val);
+void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val);
+
+void QEMU_NORETURN do_raise_exception_err(CPUMIPSState *env, uint32_t exception,
+                                          int error_code, uintptr_t pc);
+
+static inline void QEMU_NORETURN do_raise_exception(CPUMIPSState *env,
+                                                    uint32_t exception,
+                                                    uintptr_t pc)
+{
+    do_raise_exception_err(env, exception, 0, pc);
+}
+
+#endif
diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
index a9a58c5604..f4716395df 100644
--- a/target/mips/cp0_timer.c
+++ b/target/mips/cp0_timer.c
@@ -24,6 +24,7 @@
 #include "hw/mips/cpudevs.h"
 #include "qemu/timer.h"
 #include "sysemu/kvm.h"
+#include "internal.h"
 
 #define TIMER_PERIOD 10 /* 10 ns period for 100 Mhz frequency */
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 1bb66b7a5a..68bf423e9d 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "internal.h"
 #include "kvm_mips.h"
 #include "qemu-common.h"
 #include "sysemu/kvm.h"
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 7c682289c2..6d1fb70f2c 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "cpu.h"
+#include "internal.h"
 #include "exec/gdbstub.h"
 
 int mips_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
diff --git a/target/mips/helper.c b/target/mips/helper.c
index ca39aca08a..ea076261af 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
+#include "internal.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 3317905e71..e604aa8b12 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -16,6 +16,7 @@
 
 #include "qemu-common.h"
 #include "cpu.h"
+#include "internal.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 898825de3b..20100d5adb 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "cpu.h"
+#include "internal.h"
 #include "hw/hw.h"
 #include "migration/cpu.h"
 
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 1fdb0d9792..f167a42655 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internal.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 320f2b0dc4..e537a8bfd8 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
+#include "internal.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
diff --git a/target/mips/translate.c b/target/mips/translate.c
index c78d27294c..f0febaf1b2 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23,6 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internal.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg-op.h"
-- 
2.14.1
