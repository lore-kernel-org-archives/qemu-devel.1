Received: from eggs.gnu.org ([2001:4830:134:3::10]:36229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dg4f1-0001hm-P6
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dg4ew-0003Ch-AZ
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dg4ev-0003CM-TE
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:06 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 Aug 2017 09:46:48 +0200
Message-Id: <20170811074652.31474-2-david@redhat.com>
In-Reply-To: <20170811074652.31474-1-david@redhat.com>
References: <20170811074652.31474-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 1/5] target/s390x: introduce internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com

cpu.h should only contain what really has to be accessed outside of
target/s390x/. Add internal.h which can only be used inside target/s390x/.

Move everything that isn't fast enough to run away and restructure it
right away.

Minor style fixes to avoid checkpatch warning to:
- struct Lowcore: "{" goes into same line as typedef
- struct LowCore: add spaces around "-" in array length calculations
- time2tod() and tod2time(): move "{" to separate line
- get_per_atmid(): add space between ")" and "?". Move cases by one char.
- get_per_atmid(): drop extra paremthesis around (1 << 6)

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/arch_dump.c   |   1 +
 target/s390x/cc_helper.c   |   1 +
 target/s390x/cpu.c         |   1 +
 target/s390x/cpu.h         | 492 +--------------------------------------
 target/s390x/cpu_models.c  |   1 +
 target/s390x/diag.c        |   1 +
 target/s390x/excp_helper.c |   1 +
 target/s390x/fpu_helper.c  |   1 +
 target/s390x/gdbstub.c     |   1 +
 target/s390x/helper.c      |   1 +
 target/s390x/int_helper.c  |   1 +
 target/s390x/internal.h    | 560 +++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/interrupt.c   |   1 +
 target/s390x/ioinst.c      |   1 +
 target/s390x/kvm.c         |   1 +
 target/s390x/machine.c     |   1 +
 target/s390x/mem_helper.c  |   1 +
 target/s390x/misc_helper.c |   1 +
 target/s390x/mmu_helper.c  |   1 +
 target/s390x/translate.c   |   1 +
 20 files changed, 579 insertions(+), 491 deletions(-)
 create mode 100644 target/s390x/internal.h

diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 96c9fb9..a6a61ee 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internal.h"
 #include "elf.h"
 #include "exec/cpu-all.h"
 #include "sysemu/dump.h"
diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
index 1cf8551..f008897 100644
--- a/target/s390x/cc_helper.c
+++ b/target/s390x/cc_helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internal.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 489bc25..dadd383 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "internal.h"
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/timer.h"
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 29fdd5d..1ab88ad 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -213,20 +213,6 @@ static inline S390CPU *s390_env_get_cpu(CPUS390XState *env)
 extern const struct VMStateDescription vmstate_s390_cpu;
 #endif
 
-void s390_cpu_do_interrupt(CPUState *cpu);
-bool s390_cpu_exec_interrupt(CPUState *cpu, int int_req);
-void s390_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
-                         int flags);
-int s390_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
-                              int cpuid, void *opaque);
-
-hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
-int s390_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
-int s390_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
-void s390_cpu_gdb_init(CPUState *cs);
-void s390x_cpu_debug_excp_handler(CPUState *cs);
-
 #include "sysemu/kvm.h"
 
 /* distinguish between 24 bit and 31 bit addressing */
@@ -366,17 +352,6 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
 #define MMU_SECONDARY_IDX       1
 #define MMU_HOME_IDX            2
 
-static inline bool psw_key_valid(CPUS390XState *env, uint8_t psw_key)
-{
-    uint16_t pkm = env->cregs[3] >> 16;
-
-    if (env->psw.mask & PSW_MASK_PSTATE) {
-        /* PSW key has range 0..15, it is valid if the bit is 1 in the PKM */
-        return pkm & (0x80 >> psw_key);
-    }
-    return true;
-}
-
 static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
 {
     switch (env->psw.mask & PSW_MASK_ASC) {
@@ -393,20 +368,6 @@ static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
     }
 }
 
-static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
-{
-    switch (mmu_idx) {
-    case MMU_PRIMARY_IDX:
-        return PSW_ASC_PRIMARY;
-    case MMU_SECONDARY_IDX:
-        return PSW_ASC_SECONDARY;
-    case MMU_HOME_IDX:
-        return PSW_ASC_HOME;
-    default:
-        abort();
-    }
-}
-
 static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
@@ -415,26 +376,6 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
     *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
 }
 
-#define MAX_ILEN 6
-
-/* While the PoO talks about ILC (a number between 1-3) what is actually
-   stored in LowCore is shifted left one bit (an even between 2-6).  As
-   this is the actual length of the insn and therefore more useful, that
-   is what we want to pass around and manipulate.  To make sure that we
-   have applied this distinction universally, rename the "ILC" to "ILEN".  */
-static inline int get_ilen(uint8_t opc)
-{
-    switch (opc >> 6) {
-    case 0:
-        return 2;
-    case 1:
-    case 2:
-        return 4;
-    default:
-        return 6;
-    }
-}
-
 /* PER bits from control register 9 */
 #define PER_CR9_EVENT_BRANCH           0x80000000
 #define PER_CR9_EVENT_IFETCH           0x40000000
@@ -451,101 +392,25 @@ static inline int get_ilen(uint8_t opc)
 #define PER_CODE_EVENT_STORE_REAL      0x0800
 #define PER_CODE_EVENT_NULLIFICATION   0x0100
 
-/* Compute the ATMID field that is stored in the per_perc_atmid lowcore
-   entry when a PER exception is triggered.  */
-static inline uint8_t get_per_atmid(CPUS390XState *env)
-{
-    return ((env->psw.mask & PSW_MASK_64) ?      (1 << 7) : 0) |
-           (                                     (1 << 6)    ) |
-           ((env->psw.mask & PSW_MASK_32) ?      (1 << 5) : 0) |
-           ((env->psw.mask & PSW_MASK_DAT)?      (1 << 4) : 0) |
-           ((env->psw.mask & PSW_ASC_SECONDARY)? (1 << 3) : 0) |
-           ((env->psw.mask & PSW_ASC_ACCREG)?    (1 << 2) : 0);
-}
-
-/* Check if an address is within the PER starting address and the PER
-   ending address.  The address range might loop.  */
-static inline bool get_per_in_range(CPUS390XState *env, uint64_t addr)
-{
-    if (env->cregs[10] <= env->cregs[11]) {
-        return env->cregs[10] <= addr && addr <= env->cregs[11];
-    } else {
-        return env->cregs[10] <= addr || addr <= env->cregs[11];
-    }
-}
-
 S390CPU *cpu_s390x_init(const char *cpu_model);
 S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp);
-S390CPU *cpu_s390x_create(const char *cpu_model, Error **errp);
-void s390x_translate_init(void);
 
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
    is returned if the signal was handled by the virtual CPU.  */
 int cpu_s390x_signal_handler(int host_signum, void *pinfo,
                            void *puc);
-int s390_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
-                              int mmu_idx);
 
 
 #ifndef CONFIG_USER_ONLY
-void do_restart_interrupt(CPUS390XState *env);
-void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
-                                   MMUAccessType access_type,
-                                   int mmu_idx, uintptr_t retaddr);
-
-static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
-                                       uint8_t *ar)
-{
-    hwaddr addr = 0;
-    uint8_t reg;
-
-    reg = ipb >> 28;
-    if (reg > 0) {
-        addr = env->regs[reg];
-    }
-    addr += (ipb >> 16) & 0xfff;
-    if (ar) {
-        *ar = reg;
-    }
-
-    return addr;
-}
-
-/* Base/displacement are at the same locations. */
-#define decode_basedisp_rs decode_basedisp_s
-
-/* helper functions for run_on_cpu() */
-static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
-{
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
-
-    scc->cpu_reset(cs);
-}
-static inline void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_data arg)
-{
-    cpu_reset(cs);
-}
-
-void s390x_tod_timer(void *opaque);
-void s390x_cpu_timer(void *opaque);
 
 int s390_virtio_hypercall(CPUS390XState *env);
 
 #ifdef CONFIG_KVM
-void kvm_s390_service_interrupt(uint32_t parm);
-void kvm_s390_vcpu_interrupt(S390CPU *cpu, struct kvm_s390_irq *irq);
-void kvm_s390_floating_interrupt(struct kvm_s390_irq *irq);
 int kvm_s390_inject_flic(struct kvm_s390_irq *irq);
-void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code);
-int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
-                    int len, bool is_write);
 int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_clock);
 #else
-static inline void kvm_s390_service_interrupt(uint32_t parm)
-{
-}
 static inline int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
 {
     return -ENOSYS;
@@ -554,15 +419,6 @@ static inline int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
 {
     return -ENOSYS;
 }
-static inline int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar,
-                                  void *hostbuf, int len, bool is_write)
-{
-    return -ENOSYS;
-}
-static inline void kvm_s390_access_exception(S390CPU *cpu, uint16_t code,
-                                             uint64_t te_code)
-{
-}
 #endif
 
 static inline int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
@@ -586,50 +442,15 @@ static inline int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
 }
 
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
-unsigned int s390_cpu_halt(S390CPU *cpu);
-void s390_cpu_unhalt(S390CPU *cpu);
 unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
-static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
-{
-    return cpu->env.cpu_state;
-}
 
 void gtod_save(QEMUFile *f, void *opaque);
 int gtod_load(QEMUFile *f, void *opaque, int version_id);
 
-void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
-                    uint64_t param64);
-
-/* ioinst.c */
-void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1);
-void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1);
-void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1);
-void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
-void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
-void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb);
-void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
-int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
-void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb);
-int ioinst_handle_tpi(S390CPU *cpu, uint32_t ipb);
-void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
-                        uint32_t ipb);
-void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1);
-void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1);
-void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1);
-
 /* service interrupts are floating therefore we must not pass an cpustate */
 void s390_sclp_extint(uint32_t parm);
 
 #else
-static inline unsigned int s390_cpu_halt(S390CPU *cpu)
-{
-    return 0;
-}
-
-static inline void s390_cpu_unhalt(S390CPU *cpu)
-{
-}
-
 static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
 {
     return 0;
@@ -643,10 +464,6 @@ extern void subsystem_reset(void);
 
 void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 #define cpu_list s390_cpu_list
-void s390_cpu_model_register_props(Object *obj);
-void s390_cpu_model_class_register_props(ObjectClass *oc);
-void s390_realize_cpu_model(CPUState *cs, Error **errp);
-ObjectClass *s390_cpu_class_by_name(const char *name);
 
 #define EXCP_EXT 1 /* external interrupt */
 #define EXCP_SVC 2 /* supervisor call (syscall) */
@@ -683,115 +500,6 @@ ObjectClass *s390_cpu_class_by_name(const char *name);
 /* Total Core Registers. */
 #define S390_NUM_CORE_REGS 18
 
-/* CC optimization */
-
-/* Instead of computing the condition codes after each x86 instruction,
- * QEMU just stores the result (called CC_DST), the type of operation
- * (called CC_OP) and whatever operands are needed (CC_SRC and possibly
- * CC_VR). When the condition codes are needed, the condition codes can
- * be calculated using this information. Condition codes are not generated
- * if they are only needed for conditional branches.
- */
-enum cc_op {
-    CC_OP_CONST0 = 0,           /* CC is 0 */
-    CC_OP_CONST1,               /* CC is 1 */
-    CC_OP_CONST2,               /* CC is 2 */
-    CC_OP_CONST3,               /* CC is 3 */
-
-    CC_OP_DYNAMIC,              /* CC calculation defined by env->cc_op */
-    CC_OP_STATIC,               /* CC value is env->cc_op */
-
-    CC_OP_NZ,                   /* env->cc_dst != 0 */
-    CC_OP_LTGT_32,              /* signed less/greater than (32bit) */
-    CC_OP_LTGT_64,              /* signed less/greater than (64bit) */
-    CC_OP_LTUGTU_32,            /* unsigned less/greater than (32bit) */
-    CC_OP_LTUGTU_64,            /* unsigned less/greater than (64bit) */
-    CC_OP_LTGT0_32,             /* signed less/greater than 0 (32bit) */
-    CC_OP_LTGT0_64,             /* signed less/greater than 0 (64bit) */
-
-    CC_OP_ADD_64,               /* overflow on add (64bit) */
-    CC_OP_ADDU_64,              /* overflow on unsigned add (64bit) */
-    CC_OP_ADDC_64,              /* overflow on unsigned add-carry (64bit) */
-    CC_OP_SUB_64,               /* overflow on subtraction (64bit) */
-    CC_OP_SUBU_64,              /* overflow on unsigned subtraction (64bit) */
-    CC_OP_SUBB_64,              /* overflow on unsigned sub-borrow (64bit) */
-    CC_OP_ABS_64,               /* sign eval on abs (64bit) */
-    CC_OP_NABS_64,              /* sign eval on nabs (64bit) */
-
-    CC_OP_ADD_32,               /* overflow on add (32bit) */
-    CC_OP_ADDU_32,              /* overflow on unsigned add (32bit) */
-    CC_OP_ADDC_32,              /* overflow on unsigned add-carry (32bit) */
-    CC_OP_SUB_32,               /* overflow on subtraction (32bit) */
-    CC_OP_SUBU_32,              /* overflow on unsigned subtraction (32bit) */
-    CC_OP_SUBB_32,              /* overflow on unsigned sub-borrow (32bit) */
-    CC_OP_ABS_32,               /* sign eval on abs (64bit) */
-    CC_OP_NABS_32,              /* sign eval on nabs (64bit) */
-
-    CC_OP_COMP_32,              /* complement */
-    CC_OP_COMP_64,              /* complement */
-
-    CC_OP_TM_32,                /* test under mask (32bit) */
-    CC_OP_TM_64,                /* test under mask (64bit) */
-
-    CC_OP_NZ_F32,               /* FP dst != 0 (32bit) */
-    CC_OP_NZ_F64,               /* FP dst != 0 (64bit) */
-    CC_OP_NZ_F128,              /* FP dst != 0 (128bit) */
-
-    CC_OP_ICM,                  /* insert characters under mask */
-    CC_OP_SLA_32,               /* Calculate shift left signed (32bit) */
-    CC_OP_SLA_64,               /* Calculate shift left signed (64bit) */
-    CC_OP_FLOGR,                /* find leftmost one */
-    CC_OP_MAX
-};
-
-static const char *cc_names[] = {
-    [CC_OP_CONST0]    = "CC_OP_CONST0",
-    [CC_OP_CONST1]    = "CC_OP_CONST1",
-    [CC_OP_CONST2]    = "CC_OP_CONST2",
-    [CC_OP_CONST3]    = "CC_OP_CONST3",
-    [CC_OP_DYNAMIC]   = "CC_OP_DYNAMIC",
-    [CC_OP_STATIC]    = "CC_OP_STATIC",
-    [CC_OP_NZ]        = "CC_OP_NZ",
-    [CC_OP_LTGT_32]   = "CC_OP_LTGT_32",
-    [CC_OP_LTGT_64]   = "CC_OP_LTGT_64",
-    [CC_OP_LTUGTU_32] = "CC_OP_LTUGTU_32",
-    [CC_OP_LTUGTU_64] = "CC_OP_LTUGTU_64",
-    [CC_OP_LTGT0_32]  = "CC_OP_LTGT0_32",
-    [CC_OP_LTGT0_64]  = "CC_OP_LTGT0_64",
-    [CC_OP_ADD_64]    = "CC_OP_ADD_64",
-    [CC_OP_ADDU_64]   = "CC_OP_ADDU_64",
-    [CC_OP_ADDC_64]   = "CC_OP_ADDC_64",
-    [CC_OP_SUB_64]    = "CC_OP_SUB_64",
-    [CC_OP_SUBU_64]   = "CC_OP_SUBU_64",
-    [CC_OP_SUBB_64]   = "CC_OP_SUBB_64",
-    [CC_OP_ABS_64]    = "CC_OP_ABS_64",
-    [CC_OP_NABS_64]   = "CC_OP_NABS_64",
-    [CC_OP_ADD_32]    = "CC_OP_ADD_32",
-    [CC_OP_ADDU_32]   = "CC_OP_ADDU_32",
-    [CC_OP_ADDC_32]   = "CC_OP_ADDC_32",
-    [CC_OP_SUB_32]    = "CC_OP_SUB_32",
-    [CC_OP_SUBU_32]   = "CC_OP_SUBU_32",
-    [CC_OP_SUBB_32]   = "CC_OP_SUBB_32",
-    [CC_OP_ABS_32]    = "CC_OP_ABS_32",
-    [CC_OP_NABS_32]   = "CC_OP_NABS_32",
-    [CC_OP_COMP_32]   = "CC_OP_COMP_32",
-    [CC_OP_COMP_64]   = "CC_OP_COMP_64",
-    [CC_OP_TM_32]     = "CC_OP_TM_32",
-    [CC_OP_TM_64]     = "CC_OP_TM_64",
-    [CC_OP_NZ_F32]    = "CC_OP_NZ_F32",
-    [CC_OP_NZ_F64]    = "CC_OP_NZ_F64",
-    [CC_OP_NZ_F128]   = "CC_OP_NZ_F128",
-    [CC_OP_ICM]       = "CC_OP_ICM",
-    [CC_OP_SLA_32]    = "CC_OP_SLA_32",
-    [CC_OP_SLA_64]    = "CC_OP_SLA_64",
-    [CC_OP_FLOGR]     = "CC_OP_FLOGR",
-};
-
-static inline const char *cc_name(int cc_op)
-{
-    return cc_names[cc_op];
-}
-
 static inline void setcc(S390CPU *cpu, uint64_t cc)
 {
     CPUS390XState *env = &cpu->env;
@@ -801,130 +509,6 @@ static inline void setcc(S390CPU *cpu, uint64_t cc)
     env->cc_op = cc;
 }
 
-#ifndef CONFIG_USER_ONLY
-
-typedef struct LowCore
-{
-    /* prefix area: defined by architecture */
-    uint32_t        ccw1[2];                  /* 0x000 */
-    uint32_t        ccw2[4];                  /* 0x008 */
-    uint8_t         pad1[0x80-0x18];          /* 0x018 */
-    uint32_t        ext_params;               /* 0x080 */
-    uint16_t        cpu_addr;                 /* 0x084 */
-    uint16_t        ext_int_code;             /* 0x086 */
-    uint16_t        svc_ilen;                 /* 0x088 */
-    uint16_t        svc_code;                 /* 0x08a */
-    uint16_t        pgm_ilen;                 /* 0x08c */
-    uint16_t        pgm_code;                 /* 0x08e */
-    uint32_t        data_exc_code;            /* 0x090 */
-    uint16_t        mon_class_num;            /* 0x094 */
-    uint16_t        per_perc_atmid;           /* 0x096 */
-    uint64_t        per_address;              /* 0x098 */
-    uint8_t         exc_access_id;            /* 0x0a0 */
-    uint8_t         per_access_id;            /* 0x0a1 */
-    uint8_t         op_access_id;             /* 0x0a2 */
-    uint8_t         ar_access_id;             /* 0x0a3 */
-    uint8_t         pad2[0xA8-0xA4];          /* 0x0a4 */
-    uint64_t        trans_exc_code;           /* 0x0a8 */
-    uint64_t        monitor_code;             /* 0x0b0 */
-    uint16_t        subchannel_id;            /* 0x0b8 */
-    uint16_t        subchannel_nr;            /* 0x0ba */
-    uint32_t        io_int_parm;              /* 0x0bc */
-    uint32_t        io_int_word;              /* 0x0c0 */
-    uint8_t         pad3[0xc8-0xc4];          /* 0x0c4 */
-    uint32_t        stfl_fac_list;            /* 0x0c8 */
-    uint8_t         pad4[0xe8-0xcc];          /* 0x0cc */
-    uint32_t        mcck_interruption_code[2]; /* 0x0e8 */
-    uint8_t         pad5[0xf4-0xf0];          /* 0x0f0 */
-    uint32_t        external_damage_code;     /* 0x0f4 */
-    uint64_t        failing_storage_address;  /* 0x0f8 */
-    uint8_t         pad6[0x110-0x100];        /* 0x100 */
-    uint64_t        per_breaking_event_addr;  /* 0x110 */
-    uint8_t         pad7[0x120-0x118];        /* 0x118 */
-    PSW             restart_old_psw;          /* 0x120 */
-    PSW             external_old_psw;         /* 0x130 */
-    PSW             svc_old_psw;              /* 0x140 */
-    PSW             program_old_psw;          /* 0x150 */
-    PSW             mcck_old_psw;             /* 0x160 */
-    PSW             io_old_psw;               /* 0x170 */
-    uint8_t         pad8[0x1a0-0x180];        /* 0x180 */
-    PSW             restart_new_psw;          /* 0x1a0 */
-    PSW             external_new_psw;         /* 0x1b0 */
-    PSW             svc_new_psw;              /* 0x1c0 */
-    PSW             program_new_psw;          /* 0x1d0 */
-    PSW             mcck_new_psw;             /* 0x1e0 */
-    PSW             io_new_psw;               /* 0x1f0 */
-    PSW             return_psw;               /* 0x200 */
-    uint8_t         irb[64];                  /* 0x210 */
-    uint64_t        sync_enter_timer;         /* 0x250 */
-    uint64_t        async_enter_timer;        /* 0x258 */
-    uint64_t        exit_timer;               /* 0x260 */
-    uint64_t        last_update_timer;        /* 0x268 */
-    uint64_t        user_timer;               /* 0x270 */
-    uint64_t        system_timer;             /* 0x278 */
-    uint64_t        last_update_clock;        /* 0x280 */
-    uint64_t        steal_clock;              /* 0x288 */
-    PSW             return_mcck_psw;          /* 0x290 */
-    uint8_t         pad9[0xc00-0x2a0];        /* 0x2a0 */
-    /* System info area */
-    uint64_t        save_area[16];            /* 0xc00 */
-    uint8_t         pad10[0xd40-0xc80];       /* 0xc80 */
-    uint64_t        kernel_stack;             /* 0xd40 */
-    uint64_t        thread_info;              /* 0xd48 */
-    uint64_t        async_stack;              /* 0xd50 */
-    uint64_t        kernel_asce;              /* 0xd58 */
-    uint64_t        user_asce;                /* 0xd60 */
-    uint64_t        panic_stack;              /* 0xd68 */
-    uint64_t        user_exec_asce;           /* 0xd70 */
-    uint8_t         pad11[0xdc0-0xd78];       /* 0xd78 */
-
-    /* SMP info area: defined by DJB */
-    uint64_t        clock_comparator;         /* 0xdc0 */
-    uint64_t        ext_call_fast;            /* 0xdc8 */
-    uint64_t        percpu_offset;            /* 0xdd0 */
-    uint64_t        current_task;             /* 0xdd8 */
-    uint32_t        softirq_pending;          /* 0xde0 */
-    uint32_t        pad_0x0de4;               /* 0xde4 */
-    uint64_t        int_clock;                /* 0xde8 */
-    uint8_t         pad12[0xe00-0xdf0];       /* 0xdf0 */
-
-    /* 0xe00 is used as indicator for dump tools */
-    /* whether the kernel died with panic() or not */
-    uint32_t        panic_magic;              /* 0xe00 */
-
-    uint8_t         pad13[0x11b8-0xe04];      /* 0xe04 */
-
-    /* 64 bit extparam used for pfault, diag 250 etc  */
-    uint64_t        ext_params2;               /* 0x11B8 */
-
-    uint8_t         pad14[0x1200-0x11C0];      /* 0x11C0 */
-
-    /* System info area */
-
-    uint64_t        floating_pt_save_area[16]; /* 0x1200 */
-    uint64_t        gpregs_save_area[16];      /* 0x1280 */
-    uint32_t        st_status_fixed_logout[4]; /* 0x1300 */
-    uint8_t         pad15[0x1318-0x1310];      /* 0x1310 */
-    uint32_t        prefixreg_save_area;       /* 0x1318 */
-    uint32_t        fpt_creg_save_area;        /* 0x131c */
-    uint8_t         pad16[0x1324-0x1320];      /* 0x1320 */
-    uint32_t        tod_progreg_save_area;     /* 0x1324 */
-    uint32_t        cpu_timer_save_area[2];    /* 0x1328 */
-    uint32_t        clock_comp_save_area[2];   /* 0x1330 */
-    uint8_t         pad17[0x1340-0x1338];      /* 0x1338 */
-    uint32_t        access_regs_save_area[16]; /* 0x1340 */
-    uint64_t        cregs_save_area[16];       /* 0x1380 */
-
-    /* align to the top of the prefix area */
-
-    uint8_t         pad18[0x2000-0x1400];      /* 0x1400 */
-} QEMU_PACKED LowCore;
-
-LowCore *cpu_map_lowcore(CPUS390XState *env);
-void cpu_unmap_lowcore(LowCore *lowcore);
-
-#endif
-
 /* STSI */
 #define STSI_LEVEL_MASK         0x00000000f0000000ULL
 #define STSI_LEVEL_CURRENT      0x0000000000000000ULL
@@ -1100,15 +684,7 @@ struct sysib_322 {
 /* SIGP order code mask corresponding to bit positions 56-63 */
 #define SIGP_ORDER_MASK 0x000000ff
 
-void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
-uint64_t get_psw_mask(CPUS390XState *env);
-target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr);
-int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
-                  target_ulong *raddr, int *flags, bool exc);
 int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
-uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, uint64_t dst,
-                 uint64_t vr);
-void s390_cpu_recompute_watchpoints(CPUState *cs);
 
 int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
                          int len, bool is_write);
@@ -1120,46 +696,15 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 #define s390_cpu_virt_mem_check_write(cpu, laddr, ar, len)   \
         s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
 
-/* The value of the TOD clock for 1.1.1970. */
-#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
-
-/* Converts ns to s390's clock format */
-static inline uint64_t time2tod(uint64_t ns) {
-    return (ns << 9) / 125;
-}
-
-/* Converts s390's clock format to ns */
-static inline uint64_t tod2time(uint64_t t) {
-    return (t * 125) >> 9;
-}
-
 /* from s390-virtio-ccw */
 #define MEM_SECTION_SIZE             0x10000000UL
 #define MAX_AVAIL_SLOTS              32
 
-/* fpu_helper.c */
-uint32_t set_cc_nz_f32(float32 v);
-uint32_t set_cc_nz_f64(float64 v);
-uint32_t set_cc_nz_f128(float128 v);
-
-/* misc_helper.c */
-#ifndef CONFIG_USER_ONLY
-int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
-void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3);
-#endif
 /* automatically detect the instruction length */
 #define ILEN_AUTO                   0xff
 void program_interrupt(CPUS390XState *env, uint32_t code, int ilen);
-void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
-void QEMU_NORETURN runtime_exception(CPUS390XState *env, int excp,
-                                     uintptr_t retaddr);
 
 #ifdef CONFIG_KVM
-void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
-void kvm_s390_io_interrupt(uint16_t subchannel_id,
-                           uint16_t subchannel_nr, uint32_t io_int_parm,
-                           uint32_t io_int_word);
-void kvm_s390_crw_mchk(void);
 void kvm_s390_enable_css_support(S390CPU *cpu);
 int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
@@ -1167,27 +712,11 @@ int kvm_s390_cpu_restart(S390CPU *cpu);
 int kvm_s390_get_memslot_count(KVMState *s);
 int kvm_s390_cmma_active(void);
 void kvm_s390_cmma_reset(void);
-int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
 void kvm_s390_reset_vcpu(S390CPU *cpu);
 int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit, uint64_t *hw_limit);
-void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
-int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
-int kvm_s390_get_ri(void);
-int kvm_s390_get_gs(void);
 void kvm_s390_crypto_reset(void);
 #else
-static inline void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code)
-{
-}
-static inline void kvm_s390_io_interrupt(uint16_t subchannel_id,
-                                        uint16_t subchannel_nr,
-                                        uint32_t io_int_parm,
-                                        uint32_t io_int_word)
-{
-}
-static inline void kvm_s390_crw_mchk(void)
-{
-}
+
 static inline void kvm_s390_enable_css_support(S390CPU *cpu)
 {
 }
@@ -1208,10 +737,6 @@ static inline int kvm_s390_get_memslot_count(KVMState *s)
 {
   return MAX_AVAIL_SLOTS;
 }
-static inline int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
-{
-    return -ENOSYS;
-}
 static inline void kvm_s390_reset_vcpu(S390CPU *cpu)
 {
 }
@@ -1220,21 +745,6 @@ static inline int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit,
 {
     return 0;
 }
-static inline void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
-{
-}
-static inline int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
-{
-    return 0;
-}
-static inline int kvm_s390_get_ri(void)
-{
-    return 0;
-}
-static inline int kvm_s390_get_gs(void)
-{
-    return 0;
-}
 static inline void kvm_s390_crypto_reset(void)
 {
 }
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index fa1338f..798699e 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internal.h"
 #include "gen-features.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 10ac845..984e87c 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internal.h"
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
 #include "hw/watchdog/wdt_diag288.h"
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index d183377..9e925de 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "internal.h"
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 26f124f..ffbeb3b 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internal.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index a7efafe..b8c81da 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "cpu.h"
+#include "internal.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "qemu/bitops.h"
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 0c989b1..601fb2c 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "internal.h"
 #include "exec/gdbstub.h"
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
diff --git a/target/s390x/int_helper.c b/target/s390x/int_helper.c
index f26f36a..0076bea 100644
--- a/target/s390x/int_helper.c
+++ b/target/s390x/int_helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internal.h"
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
new file mode 100644
index 0000000..9a55271
--- /dev/null
+++ b/target/s390x/internal.h
@@ -0,0 +1,560 @@
+/*
+ * s390x internal definitions and helpers
+ *
+ *  Copyright (c) 2009 Ulrich Hecht
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * Contributions after 2012-10-29 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ *
+ * You should have received a copy of the GNU (Lesser) General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef S390X_INTERNAL_H
+#define S390X_INTERNAL_H
+
+#include "cpu.h"
+
+#ifndef CONFIG_USER_ONLY
+typedef struct LowCore {
+    /* prefix area: defined by architecture */
+    uint32_t        ccw1[2];                  /* 0x000 */
+    uint32_t        ccw2[4];                  /* 0x008 */
+    uint8_t         pad1[0x80 - 0x18];        /* 0x018 */
+    uint32_t        ext_params;               /* 0x080 */
+    uint16_t        cpu_addr;                 /* 0x084 */
+    uint16_t        ext_int_code;             /* 0x086 */
+    uint16_t        svc_ilen;                 /* 0x088 */
+    uint16_t        svc_code;                 /* 0x08a */
+    uint16_t        pgm_ilen;                 /* 0x08c */
+    uint16_t        pgm_code;                 /* 0x08e */
+    uint32_t        data_exc_code;            /* 0x090 */
+    uint16_t        mon_class_num;            /* 0x094 */
+    uint16_t        per_perc_atmid;           /* 0x096 */
+    uint64_t        per_address;              /* 0x098 */
+    uint8_t         exc_access_id;            /* 0x0a0 */
+    uint8_t         per_access_id;            /* 0x0a1 */
+    uint8_t         op_access_id;             /* 0x0a2 */
+    uint8_t         ar_access_id;             /* 0x0a3 */
+    uint8_t         pad2[0xA8 - 0xA4];        /* 0x0a4 */
+    uint64_t        trans_exc_code;           /* 0x0a8 */
+    uint64_t        monitor_code;             /* 0x0b0 */
+    uint16_t        subchannel_id;            /* 0x0b8 */
+    uint16_t        subchannel_nr;            /* 0x0ba */
+    uint32_t        io_int_parm;              /* 0x0bc */
+    uint32_t        io_int_word;              /* 0x0c0 */
+    uint8_t         pad3[0xc8 - 0xc4];        /* 0x0c4 */
+    uint32_t        stfl_fac_list;            /* 0x0c8 */
+    uint8_t         pad4[0xe8 - 0xcc];        /* 0x0cc */
+    uint32_t        mcck_interruption_code[2]; /* 0x0e8 */
+    uint8_t         pad5[0xf4 - 0xf0];        /* 0x0f0 */
+    uint32_t        external_damage_code;     /* 0x0f4 */
+    uint64_t        failing_storage_address;  /* 0x0f8 */
+    uint8_t         pad6[0x110 - 0x100];      /* 0x100 */
+    uint64_t        per_breaking_event_addr;  /* 0x110 */
+    uint8_t         pad7[0x120 - 0x118];      /* 0x118 */
+    PSW             restart_old_psw;          /* 0x120 */
+    PSW             external_old_psw;         /* 0x130 */
+    PSW             svc_old_psw;              /* 0x140 */
+    PSW             program_old_psw;          /* 0x150 */
+    PSW             mcck_old_psw;             /* 0x160 */
+    PSW             io_old_psw;               /* 0x170 */
+    uint8_t         pad8[0x1a0 - 0x180];      /* 0x180 */
+    PSW             restart_new_psw;          /* 0x1a0 */
+    PSW             external_new_psw;         /* 0x1b0 */
+    PSW             svc_new_psw;              /* 0x1c0 */
+    PSW             program_new_psw;          /* 0x1d0 */
+    PSW             mcck_new_psw;             /* 0x1e0 */
+    PSW             io_new_psw;               /* 0x1f0 */
+    PSW             return_psw;               /* 0x200 */
+    uint8_t         irb[64];                  /* 0x210 */
+    uint64_t        sync_enter_timer;         /* 0x250 */
+    uint64_t        async_enter_timer;        /* 0x258 */
+    uint64_t        exit_timer;               /* 0x260 */
+    uint64_t        last_update_timer;        /* 0x268 */
+    uint64_t        user_timer;               /* 0x270 */
+    uint64_t        system_timer;             /* 0x278 */
+    uint64_t        last_update_clock;        /* 0x280 */
+    uint64_t        steal_clock;              /* 0x288 */
+    PSW             return_mcck_psw;          /* 0x290 */
+    uint8_t         pad9[0xc00 - 0x2a0];      /* 0x2a0 */
+    /* System info area */
+    uint64_t        save_area[16];            /* 0xc00 */
+    uint8_t         pad10[0xd40 - 0xc80];     /* 0xc80 */
+    uint64_t        kernel_stack;             /* 0xd40 */
+    uint64_t        thread_info;              /* 0xd48 */
+    uint64_t        async_stack;              /* 0xd50 */
+    uint64_t        kernel_asce;              /* 0xd58 */
+    uint64_t        user_asce;                /* 0xd60 */
+    uint64_t        panic_stack;              /* 0xd68 */
+    uint64_t        user_exec_asce;           /* 0xd70 */
+    uint8_t         pad11[0xdc0 - 0xd78];     /* 0xd78 */
+
+    /* SMP info area: defined by DJB */
+    uint64_t        clock_comparator;         /* 0xdc0 */
+    uint64_t        ext_call_fast;            /* 0xdc8 */
+    uint64_t        percpu_offset;            /* 0xdd0 */
+    uint64_t        current_task;             /* 0xdd8 */
+    uint32_t        softirq_pending;          /* 0xde0 */
+    uint32_t        pad_0x0de4;               /* 0xde4 */
+    uint64_t        int_clock;                /* 0xde8 */
+    uint8_t         pad12[0xe00 - 0xdf0];     /* 0xdf0 */
+
+    /* 0xe00 is used as indicator for dump tools */
+    /* whether the kernel died with panic() or not */
+    uint32_t        panic_magic;              /* 0xe00 */
+
+    uint8_t         pad13[0x11b8 - 0xe04];    /* 0xe04 */
+
+    /* 64 bit extparam used for pfault, diag 250 etc  */
+    uint64_t        ext_params2;               /* 0x11B8 */
+
+    uint8_t         pad14[0x1200 - 0x11C0];    /* 0x11C0 */
+
+    /* System info area */
+
+    uint64_t        floating_pt_save_area[16]; /* 0x1200 */
+    uint64_t        gpregs_save_area[16];      /* 0x1280 */
+    uint32_t        st_status_fixed_logout[4]; /* 0x1300 */
+    uint8_t         pad15[0x1318 - 0x1310];    /* 0x1310 */
+    uint32_t        prefixreg_save_area;       /* 0x1318 */
+    uint32_t        fpt_creg_save_area;        /* 0x131c */
+    uint8_t         pad16[0x1324 - 0x1320];    /* 0x1320 */
+    uint32_t        tod_progreg_save_area;     /* 0x1324 */
+    uint32_t        cpu_timer_save_area[2];    /* 0x1328 */
+    uint32_t        clock_comp_save_area[2];   /* 0x1330 */
+    uint8_t         pad17[0x1340 - 0x1338];    /* 0x1338 */
+    uint32_t        access_regs_save_area[16]; /* 0x1340 */
+    uint64_t        cregs_save_area[16];       /* 0x1380 */
+
+    /* align to the top of the prefix area */
+
+    uint8_t         pad18[0x2000 - 0x1400];    /* 0x1400 */
+} QEMU_PACKED LowCore;
+#endif /* CONFIG_USER_ONLY */
+
+static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
+{
+    switch (mmu_idx) {
+    case MMU_PRIMARY_IDX:
+        return PSW_ASC_PRIMARY;
+    case MMU_SECONDARY_IDX:
+        return PSW_ASC_SECONDARY;
+    case MMU_HOME_IDX:
+        return PSW_ASC_HOME;
+    default:
+        abort();
+    }
+}
+
+static inline bool psw_key_valid(CPUS390XState *env, uint8_t psw_key)
+{
+    uint16_t pkm = env->cregs[3] >> 16;
+
+    if (env->psw.mask & PSW_MASK_PSTATE) {
+        /* PSW key has range 0..15, it is valid if the bit is 1 in the PKM */
+        return pkm & (0x80 >> psw_key);
+    }
+    return true;
+}
+
+#define MAX_ILEN 6
+
+/* While the PoO talks about ILC (a number between 1-3) what is actually
+   stored in LowCore is shifted left one bit (an even between 2-6).  As
+   this is the actual length of the insn and therefore more useful, that
+   is what we want to pass around and manipulate.  To make sure that we
+   have applied this distinction universally, rename the "ILC" to "ILEN".  */
+static inline int get_ilen(uint8_t opc)
+{
+    switch (opc >> 6) {
+    case 0:
+        return 2;
+    case 1:
+    case 2:
+        return 4;
+    default:
+        return 6;
+    }
+}
+
+/* Compute the ATMID field that is stored in the per_perc_atmid lowcore
+   entry when a PER exception is triggered.  */
+static inline uint8_t get_per_atmid(CPUS390XState *env)
+{
+    return ((env->psw.mask & PSW_MASK_64) ?       (1 << 7) : 0) |
+                                                  (1 << 6)      |
+           ((env->psw.mask & PSW_MASK_32) ?       (1 << 5) : 0) |
+           ((env->psw.mask & PSW_MASK_DAT) ?      (1 << 4) : 0) |
+           ((env->psw.mask & PSW_ASC_SECONDARY) ? (1 << 3) : 0) |
+           ((env->psw.mask & PSW_ASC_ACCREG) ?    (1 << 2) : 0);
+}
+
+/* Check if an address is within the PER starting address and the PER
+   ending address.  The address range might loop.  */
+static inline bool get_per_in_range(CPUS390XState *env, uint64_t addr)
+{
+    if (env->cregs[10] <= env->cregs[11]) {
+        return env->cregs[10] <= addr && addr <= env->cregs[11];
+    } else {
+        return env->cregs[10] <= addr || addr <= env->cregs[11];
+    }
+}
+
+/* CC optimization */
+
+/* Instead of computing the condition codes after each x86 instruction,
+ * QEMU just stores the result (called CC_DST), the type of operation
+ * (called CC_OP) and whatever operands are needed (CC_SRC and possibly
+ * CC_VR). When the condition codes are needed, the condition codes can
+ * be calculated using this information. Condition codes are not generated
+ * if they are only needed for conditional branches.
+ */
+enum cc_op {
+    CC_OP_CONST0 = 0,           /* CC is 0 */
+    CC_OP_CONST1,               /* CC is 1 */
+    CC_OP_CONST2,               /* CC is 2 */
+    CC_OP_CONST3,               /* CC is 3 */
+
+    CC_OP_DYNAMIC,              /* CC calculation defined by env->cc_op */
+    CC_OP_STATIC,               /* CC value is env->cc_op */
+
+    CC_OP_NZ,                   /* env->cc_dst != 0 */
+    CC_OP_LTGT_32,              /* signed less/greater than (32bit) */
+    CC_OP_LTGT_64,              /* signed less/greater than (64bit) */
+    CC_OP_LTUGTU_32,            /* unsigned less/greater than (32bit) */
+    CC_OP_LTUGTU_64,            /* unsigned less/greater than (64bit) */
+    CC_OP_LTGT0_32,             /* signed less/greater than 0 (32bit) */
+    CC_OP_LTGT0_64,             /* signed less/greater than 0 (64bit) */
+
+    CC_OP_ADD_64,               /* overflow on add (64bit) */
+    CC_OP_ADDU_64,              /* overflow on unsigned add (64bit) */
+    CC_OP_ADDC_64,              /* overflow on unsigned add-carry (64bit) */
+    CC_OP_SUB_64,               /* overflow on subtraction (64bit) */
+    CC_OP_SUBU_64,              /* overflow on unsigned subtraction (64bit) */
+    CC_OP_SUBB_64,              /* overflow on unsigned sub-borrow (64bit) */
+    CC_OP_ABS_64,               /* sign eval on abs (64bit) */
+    CC_OP_NABS_64,              /* sign eval on nabs (64bit) */
+
+    CC_OP_ADD_32,               /* overflow on add (32bit) */
+    CC_OP_ADDU_32,              /* overflow on unsigned add (32bit) */
+    CC_OP_ADDC_32,              /* overflow on unsigned add-carry (32bit) */
+    CC_OP_SUB_32,               /* overflow on subtraction (32bit) */
+    CC_OP_SUBU_32,              /* overflow on unsigned subtraction (32bit) */
+    CC_OP_SUBB_32,              /* overflow on unsigned sub-borrow (32bit) */
+    CC_OP_ABS_32,               /* sign eval on abs (64bit) */
+    CC_OP_NABS_32,              /* sign eval on nabs (64bit) */
+
+    CC_OP_COMP_32,              /* complement */
+    CC_OP_COMP_64,              /* complement */
+
+    CC_OP_TM_32,                /* test under mask (32bit) */
+    CC_OP_TM_64,                /* test under mask (64bit) */
+
+    CC_OP_NZ_F32,               /* FP dst != 0 (32bit) */
+    CC_OP_NZ_F64,               /* FP dst != 0 (64bit) */
+    CC_OP_NZ_F128,              /* FP dst != 0 (128bit) */
+
+    CC_OP_ICM,                  /* insert characters under mask */
+    CC_OP_SLA_32,               /* Calculate shift left signed (32bit) */
+    CC_OP_SLA_64,               /* Calculate shift left signed (64bit) */
+    CC_OP_FLOGR,                /* find leftmost one */
+    CC_OP_MAX
+};
+
+static const char *cc_names[] = {
+    [CC_OP_CONST0]    = "CC_OP_CONST0",
+    [CC_OP_CONST1]    = "CC_OP_CONST1",
+    [CC_OP_CONST2]    = "CC_OP_CONST2",
+    [CC_OP_CONST3]    = "CC_OP_CONST3",
+    [CC_OP_DYNAMIC]   = "CC_OP_DYNAMIC",
+    [CC_OP_STATIC]    = "CC_OP_STATIC",
+    [CC_OP_NZ]        = "CC_OP_NZ",
+    [CC_OP_LTGT_32]   = "CC_OP_LTGT_32",
+    [CC_OP_LTGT_64]   = "CC_OP_LTGT_64",
+    [CC_OP_LTUGTU_32] = "CC_OP_LTUGTU_32",
+    [CC_OP_LTUGTU_64] = "CC_OP_LTUGTU_64",
+    [CC_OP_LTGT0_32]  = "CC_OP_LTGT0_32",
+    [CC_OP_LTGT0_64]  = "CC_OP_LTGT0_64",
+    [CC_OP_ADD_64]    = "CC_OP_ADD_64",
+    [CC_OP_ADDU_64]   = "CC_OP_ADDU_64",
+    [CC_OP_ADDC_64]   = "CC_OP_ADDC_64",
+    [CC_OP_SUB_64]    = "CC_OP_SUB_64",
+    [CC_OP_SUBU_64]   = "CC_OP_SUBU_64",
+    [CC_OP_SUBB_64]   = "CC_OP_SUBB_64",
+    [CC_OP_ABS_64]    = "CC_OP_ABS_64",
+    [CC_OP_NABS_64]   = "CC_OP_NABS_64",
+    [CC_OP_ADD_32]    = "CC_OP_ADD_32",
+    [CC_OP_ADDU_32]   = "CC_OP_ADDU_32",
+    [CC_OP_ADDC_32]   = "CC_OP_ADDC_32",
+    [CC_OP_SUB_32]    = "CC_OP_SUB_32",
+    [CC_OP_SUBU_32]   = "CC_OP_SUBU_32",
+    [CC_OP_SUBB_32]   = "CC_OP_SUBB_32",
+    [CC_OP_ABS_32]    = "CC_OP_ABS_32",
+    [CC_OP_NABS_32]   = "CC_OP_NABS_32",
+    [CC_OP_COMP_32]   = "CC_OP_COMP_32",
+    [CC_OP_COMP_64]   = "CC_OP_COMP_64",
+    [CC_OP_TM_32]     = "CC_OP_TM_32",
+    [CC_OP_TM_64]     = "CC_OP_TM_64",
+    [CC_OP_NZ_F32]    = "CC_OP_NZ_F32",
+    [CC_OP_NZ_F64]    = "CC_OP_NZ_F64",
+    [CC_OP_NZ_F128]   = "CC_OP_NZ_F128",
+    [CC_OP_ICM]       = "CC_OP_ICM",
+    [CC_OP_SLA_32]    = "CC_OP_SLA_32",
+    [CC_OP_SLA_64]    = "CC_OP_SLA_64",
+    [CC_OP_FLOGR]     = "CC_OP_FLOGR",
+};
+
+static inline const char *cc_name(int cc_op)
+{
+    return cc_names[cc_op];
+}
+
+/* The value of the TOD clock for 1.1.1970. */
+#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
+
+/* Converts ns to s390's clock format */
+static inline uint64_t time2tod(uint64_t ns)
+{
+    return (ns << 9) / 125;
+}
+
+/* Converts s390's clock format to ns */
+static inline uint64_t tod2time(uint64_t t)
+{
+    return (t * 125) >> 9;
+}
+
+static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
+                                       uint8_t *ar)
+{
+    hwaddr addr = 0;
+    uint8_t reg;
+
+    reg = ipb >> 28;
+    if (reg > 0) {
+        addr = env->regs[reg];
+    }
+    addr += (ipb >> 16) & 0xfff;
+    if (ar) {
+        *ar = reg;
+    }
+
+    return addr;
+}
+
+/* Base/displacement are at the same locations. */
+#define decode_basedisp_rs decode_basedisp_s
+
+/* helper functions for run_on_cpu() */
+static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
+
+    scc->cpu_reset(cs);
+}
+
+static inline void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_data arg)
+{
+    cpu_reset(cs);
+}
+
+static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
+{
+    return cpu->env.cpu_state;
+}
+
+
+/* arch_dump.c */
+int s390_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
+                              int cpuid, void *opaque);
+
+
+/* cc_helper.c */
+void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
+uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, uint64_t dst,
+                 uint64_t vr);
+
+
+/* cpu.c */
+#ifndef CONFIG_USER_ONLY
+unsigned int s390_cpu_halt(S390CPU *cpu);
+void s390_cpu_unhalt(S390CPU *cpu);
+#else
+static inline unsigned int s390_cpu_halt(S390CPU *cpu)
+{
+    return 0;
+}
+
+static inline void s390_cpu_unhalt(S390CPU *cpu)
+{
+}
+#endif
+
+
+/* cpu_models.c */
+void s390_cpu_model_register_props(Object *obj);
+void s390_cpu_model_class_register_props(ObjectClass *oc);
+void s390_realize_cpu_model(CPUState *cs, Error **errp);
+ObjectClass *s390_cpu_class_by_name(const char *name);
+
+
+/* excp_helper.c */
+void s390x_cpu_debug_excp_handler(CPUState *cs);
+void s390_cpu_do_interrupt(CPUState *cpu);
+bool s390_cpu_exec_interrupt(CPUState *cpu, int int_req);
+int s390_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+                              int mmu_idx);
+void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                   MMUAccessType access_type,
+                                   int mmu_idx, uintptr_t retaddr);
+
+
+/* fpu_helper.c */
+uint32_t set_cc_nz_f32(float32 v);
+uint32_t set_cc_nz_f64(float64 v);
+uint32_t set_cc_nz_f128(float128 v);
+
+
+/* gdbstub.c */
+int s390_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int s390_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+void s390_cpu_gdb_init(CPUState *cs);
+
+
+/* helper.c */
+void s390_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
+                         int flags);
+hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+uint64_t get_psw_mask(CPUS390XState *env);
+void s390_cpu_recompute_watchpoints(CPUState *cs);
+void s390x_tod_timer(void *opaque);
+void s390x_cpu_timer(void *opaque);
+S390CPU *cpu_s390x_create(const char *cpu_model, Error **errp);
+void do_restart_interrupt(CPUS390XState *env);
+#ifndef CONFIG_USER_ONLY
+LowCore *cpu_map_lowcore(CPUS390XState *env);
+void cpu_unmap_lowcore(LowCore *lowcore);
+#endif /* CONFIG_USER_ONLY */
+
+
+/* interrupt.c */
+void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
+void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
+                    uint64_t param64);
+
+
+/* ioinst.c */
+void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1);
+void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1);
+void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1);
+void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
+void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
+void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb);
+void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
+int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
+void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb);
+int ioinst_handle_tpi(S390CPU *cpu, uint32_t ipb);
+void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
+                        uint32_t ipb);
+void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1);
+void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1);
+void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1);
+
+
+/* kvm.c */
+#ifdef CONFIG_KVM
+void kvm_s390_floating_interrupt(struct kvm_s390_irq *irq);
+void kvm_s390_service_interrupt(uint32_t parm);
+void kvm_s390_vcpu_interrupt(S390CPU *cpu, struct kvm_s390_irq *irq);
+void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code);
+int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
+                    int len, bool is_write);
+void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
+void kvm_s390_io_interrupt(uint16_t subchannel_id,
+                           uint16_t subchannel_nr, uint32_t io_int_parm,
+                           uint32_t io_int_word);
+void kvm_s390_crw_mchk(void);
+int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
+void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
+int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
+int kvm_s390_get_ri(void);
+int kvm_s390_get_gs(void);
+#else
+static inline void kvm_s390_service_interrupt(uint32_t parm)
+{
+}
+static inline void kvm_s390_access_exception(S390CPU *cpu, uint16_t code,
+                                             uint64_t te_code)
+{
+}
+static inline int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar,
+                                  void *hostbuf, int len, bool is_write)
+{
+    return -ENOSYS;
+}
+static inline void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code)
+{
+}
+static inline void kvm_s390_io_interrupt(uint16_t subchannel_id,
+                                        uint16_t subchannel_nr,
+                                        uint32_t io_int_parm,
+                                        uint32_t io_int_word)
+{
+}
+static inline void kvm_s390_crw_mchk(void)
+{
+}
+static inline int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
+{
+    return -ENOSYS;
+}
+static inline void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
+{
+}
+static inline int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
+{
+    return 0;
+}
+static inline int kvm_s390_get_ri(void)
+{
+    return 0;
+}
+static inline int kvm_s390_get_gs(void)
+{
+    return 0;
+}
+#endif /* CONFIG_KVM */
+
+
+/* mem_helper.c */
+target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr);
+
+
+/* mmu_helper.c */
+int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
+                  target_ulong *raddr, int *flags, bool exc);
+
+
+/* misc_helper.c */
+void QEMU_NORETURN runtime_exception(CPUS390XState *env, int excp,
+                                     uintptr_t retaddr);
+int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
+void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3);
+
+
+/* translate.c */
+void s390x_translate_init(void);
+
+#endif /* S390X_INTERNAL_H */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index fde3da7..119ca74 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
+#include "internal.h"
 #include "exec/exec-all.h"
 #include "sysemu/kvm.h"
 #include "hw/s390x/ioinst.h"
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 51fbea6..803ef5b 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
+#include "internal.h"
 #include "hw/s390x/ioinst.h"
 #include "trace.h"
 #include "hw/s390x/s390-pci-bus.h"
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index c4c5791..6bb358c 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -29,6 +29,7 @@
 
 #include "qemu-common.h"
 #include "cpu.h"
+#include "internal.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index 2dcadfd..592db6b 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "cpu.h"
+#include "internal.h"
 #include "sysemu/kvm.h"
 
 static int cpu_post_load(void *opaque, int version_id)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index c71dce4..d8eca38 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internal.h"
 #include "exec/address-spaces.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index d23ffcd..d9baca4 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
+#include "internal.h"
 #include "exec/memory.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 1ad0158..09fe5bb 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
+#include "internal.h"
 #include "sysemu/kvm.h"
 #include "trace.h"
 #include "hw/s390x/storage-keys.h"
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index cd96a8d..4b0db7b 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -30,6 +30,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internal.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg-op.h"
-- 
2.9.4
