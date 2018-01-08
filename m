Received: from eggs.gnu.org ([2001:4830:134:3::10]:58693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYgZJ-0008DN-6u
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYgZF-0007hJ-Ov
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:11:01 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:51129)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eYgZF-0007cw-Az
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:10:57 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  9 Jan 2018 00:10:44 +0100
Message-Id: <20180108231048.23966-3-laurent@vivier.eu>
In-Reply-To: <20180108231048.23966-1-laurent@vivier.eu>
References: <20180108231048.23966-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 2/6] target/m68k: add MC68040 MMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Only add MC68040 MMU page table processing and related
registers (Special Status Word, Translation Control Register,
User Root Pointer and Supervisor Root Pointer).

Transparent Translation Registers, DFC/SFC and pflush/ptest
will be added later.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.c       |   4 +-
 target/m68k/cpu.h       | 103 +++++++++++++++++++++++
 target/m68k/helper.c    | 220 ++++++++++++++++++++++++++++++++++++++++++++++--
 target/m68k/monitor.c   |   2 +
 target/m68k/op_helper.c |  95 ++++++++++++++++++++-
 target/m68k/translate.c |   2 +
 6 files changed, 416 insertions(+), 10 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 03126ba543..98919b358b 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -269,9 +269,9 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
     cc->set_pc = m68k_cpu_set_pc;
     cc->gdb_read_register = m68k_cpu_gdb_read_register;
     cc->gdb_write_register = m68k_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = m68k_cpu_handle_mmu_fault;
-#else
+#if defined(CONFIG_SOFTMMU)
+    cc->do_unassigned_access = m68k_cpu_unassigned_access;
     cc->get_phys_page_debug = m68k_cpu_get_phys_page_debug;
 #endif
     cc->disas_set_info = m68k_cpu_disas_set_info;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index c60564a047..c3c4493bd0 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -116,6 +116,11 @@ typedef struct CPUM68KState {
     /* MMU status.  */
     struct {
         uint32_t ar;
+        uint32_t ssw;
+        /* 68040 */
+        uint16_t tcr;
+        uint32_t urp;
+        uint32_t srp;
     } mmu;
 
     /* Control registers.  */
@@ -226,6 +231,90 @@ typedef enum {
 #define M68K_USP    1
 #define M68K_ISP    2
 
+/* bits for 68040 special status word */
+#define M68K_CP_040  0x8000
+#define M68K_CU_040  0x4000
+#define M68K_CT_040  0x2000
+#define M68K_CM_040  0x1000
+#define M68K_MA_040  0x0800
+#define M68K_ATC_040 0x0400
+#define M68K_LK_040  0x0200
+#define M68K_RW_040  0x0100
+#define M68K_SIZ_040 0x0060
+#define M68K_TT_040  0x0018
+#define M68K_TM_040  0x0007
+
+#define M68K_TM_040_DATA  0x0001
+#define M68K_TM_040_CODE  0x0002
+#define M68K_TM_040_SUPER 0x0004
+
+/* bits for 68040 write back status word */
+#define M68K_WBV_040   0x80
+#define M68K_WBSIZ_040 0x60
+#define M68K_WBBYT_040 0x20
+#define M68K_WBWRD_040 0x40
+#define M68K_WBLNG_040 0x00
+#define M68K_WBTT_040  0x18
+#define M68K_WBTM_040  0x07
+
+/* bus access size codes */
+#define M68K_BA_SIZE_MASK    0x60
+#define M68K_BA_SIZE_BYTE    0x20
+#define M68K_BA_SIZE_WORD    0x40
+#define M68K_BA_SIZE_LONG    0x00
+#define M68K_BA_SIZE_LINE    0x60
+
+/* bus access transfer type codes */
+#define M68K_BA_TT_MOVE16    0x08
+
+/* bits for 68040 MMU status register (mmusr) */
+#define M68K_MMU_B_040   0x0800
+#define M68K_MMU_G_040   0x0400
+#define M68K_MMU_U1_040  0x0200
+#define M68K_MMU_U0_040  0x0100
+#define M68K_MMU_S_040   0x0080
+#define M68K_MMU_CM_040  0x0060
+#define M68K_MMU_M_040   0x0010
+#define M68K_MMU_WP_040  0x0004
+#define M68K_MMU_T_040   0x0002
+#define M68K_MMU_R_040   0x0001
+
+#define M68K_MMU_SR_MASK_040 (M68K_MMU_G_040 | M68K_MMU_U1_040 | \
+                              M68K_MMU_U0_040 | M68K_MMU_S_040 | \
+                              M68K_MMU_CM_040 | M68K_MMU_M_040 | \
+                              M68K_MMU_WP_040)
+
+/* bits for 68040 MMU Translation Control Register */
+#define M68K_TCR_ENABLED 0x8000
+#define M68K_TCR_PAGE_8K 0x4000
+
+/* bits for 68040 MMU Table Descriptor / Page Descriptor / TTR */
+#define M68K_DESC_WRITEPROT 0x00000004
+#define M68K_DESC_USED      0x00000008
+#define M68K_DESC_MODIFIED  0x00000010
+#define M68K_DESC_CACHEMODE 0x00000060
+#define M68K_DESC_CM_WRTHRU 0x00000000
+#define M68K_DESC_CM_COPYBK 0x00000020
+#define M68K_DESC_CM_SERIAL 0x00000040
+#define M68K_DESC_CM_NCACHE 0x00000060
+#define M68K_DESC_SUPERONLY 0x00000080
+#define M68K_DESC_USERATTR  0x00000300
+#define M68K_DESC_USERATTR_SHIFT     8
+#define M68K_DESC_GLOBAL    0x00000400
+#define M68K_DESC_URESERVED 0x00000800
+
+#define M68K_POINTER_BASE(entry)    (entry & ~0x1ff)
+#define M68K_ROOT_INDEX(addr)       ((address >> 23) & 0x1fc)
+#define M68K_POINTER_INDEX(addr)    ((address >> 16) & 0x1fc)
+#define M68K_4K_PAGE_BASE(entry)    (next & ~0xff)
+#define M68K_4K_PAGE_INDEX(addr)    ((address >> 10) & 0xfc)
+#define M68K_8K_PAGE_BASE(entry)    (next & ~0x7f)
+#define M68K_8K_PAGE_INDEX(addr)    ((address >> 11) & 0x7c)
+#define M68K_UDT_VALID(entry)       (entry & 2)
+#define M68K_PDT_VALID(entry)       (entry & 3)
+#define M68K_PDT_INDIRECT(entry)    ((entry & 3) == 2)
+#define M68K_INDIRECT_POINTER(addr) (addr & ~3)
+
 /* m68k Control Registers */
 
 /* ColdFire */
@@ -398,6 +487,16 @@ void register_m68k_insns (CPUM68KState *env);
 #define TARGET_PAGE_BITS 10
 #endif
 
+enum {
+    /* 1 bit to define user level / supervisor access */
+    ACCESS_SUPER = 0x01,
+    /* 1 bit to indicate direction */
+    ACCESS_STORE = 0x02,
+    /* Type of instruction that generated the access */
+    ACCESS_CODE  = 0x10, /* Code fetch access                */
+    ACCESS_INT   = 0x20, /* Integer load/store access        */
+};
+
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
@@ -412,6 +511,7 @@ void register_m68k_insns (CPUM68KState *env);
 /* MMU modes definitions */
 #define MMU_MODE0_SUFFIX _kernel
 #define MMU_MODE1_SUFFIX _user
+#define MMU_KERNEL_IDX 0
 #define MMU_USER_IDX 1
 static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
 {
@@ -420,6 +520,9 @@ static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
 
 int m68k_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                               int mmu_idx);
+void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr,
+                                bool is_write, bool is_exec, int is_asi,
+                                unsigned size);
 
 #include "exec/cpu-all.h"
 
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index ef0ec5dadf..c25c99c0fb 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -212,6 +212,15 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
         m68k_switch_sp(env);
         return;
     /* MC680[34]0 */
+    case M68K_CR_TC:
+        env->mmu.tcr = val;
+        return;
+    case M68K_CR_SRP:
+        env->mmu.srp = val;
+        return;
+    case M68K_CR_URP:
+        env->mmu.urp = val;
+        return;
     case M68K_CR_USP:
         env->sp[M68K_USP] = val;
         return;
@@ -238,12 +247,19 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
     case M68K_CR_CACR:
         return env->cacr;
     /* MC680[34]0 */
+    case M68K_CR_TC:
+        return env->mmu.tcr;
+    case M68K_CR_SRP:
+        return env->mmu.srp;
     case M68K_CR_USP:
         return env->sp[M68K_USP];
     case M68K_CR_MSP:
         return env->sp[M68K_SSP];
     case M68K_CR_ISP:
         return env->sp[M68K_ISP];
+    /* MC68040/MC68LC040 */
+    case M68K_CR_URP:
+        return env->mmu.urp;
     }
     cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
               reg);
@@ -320,23 +336,213 @@ int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
 
 #else
 
-/* MMU */
+/* MMU: 68040 only */
+
+static int get_physical_address(CPUM68KState *env, hwaddr *physical,
+                                int *prot, target_ulong address,
+                                int access_type, target_ulong *page_size)
+{
+    M68kCPU *cpu = m68k_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+    uint32_t page_offset;
+    uint32_t entry;
+    uint32_t next;
+
+    /* Page Table Root Pointer */
+    *prot = PAGE_READ | PAGE_WRITE;
+    if (access_type & ACCESS_CODE) {
+        *prot |= PAGE_EXEC;
+    }
+    if (access_type & ACCESS_SUPER) {
+        next = env->mmu.srp;
+    } else {
+        next = env->mmu.urp;
+    }
+
+    /* Root Index */
+    entry = M68K_POINTER_BASE(next) | M68K_ROOT_INDEX(address);
+
+    next = ldl_phys(cs->as, entry);
+    if (!M68K_UDT_VALID(next)) {
+        return -1;
+    }
+    if (!(next & M68K_DESC_USED)) {
+        stl_phys(cs->as, entry, next | M68K_DESC_USED);
+    }
+    if (next & M68K_DESC_WRITEPROT) {
+        *prot &= ~PAGE_WRITE;
+        if (access_type & ACCESS_STORE) {
+            return -1;
+        }
+    }
+
+    /* Pointer Index */
+    entry = M68K_POINTER_BASE(next) | M68K_POINTER_INDEX(address);
+
+    next = ldl_phys(cs->as, entry);
+    if (!M68K_UDT_VALID(next)) {
+        return -1;
+    }
+    if (!(next & M68K_DESC_USED)) {
+        stl_phys(cs->as, entry, next | M68K_DESC_USED);
+    }
+    if (next & M68K_DESC_WRITEPROT) {
+        *prot &= ~PAGE_WRITE;
+        if (access_type & ACCESS_STORE) {
+            return -1;
+        }
+    }
+
+    /* Page Index */
+    if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
+        entry = M68K_8K_PAGE_BASE(next) | M68K_8K_PAGE_INDEX(address);
+    } else {
+        entry = M68K_4K_PAGE_BASE(next) | M68K_4K_PAGE_INDEX(address);
+    }
+
+    next = ldl_phys(cs->as, entry);
+
+    if (!M68K_PDT_VALID(next)) {
+        return -1;
+    }
+    if (M68K_PDT_INDIRECT(next)) {
+        next = ldl_phys(cs->as, M68K_INDIRECT_POINTER(next));
+    }
+    if (access_type & ACCESS_STORE) {
+        if (next & M68K_DESC_WRITEPROT) {
+            if ((next & M68K_DESC_USED) == 0) {
+                stl_phys(cs->as, entry, next | M68K_DESC_USED);
+            }
+        } else if ((next & (M68K_DESC_MODIFIED | M68K_DESC_USED)) !=
+                           (M68K_DESC_MODIFIED | M68K_DESC_USED)) {
+                stl_phys(cs->as, entry,
+                         next | (M68K_DESC_MODIFIED | M68K_DESC_USED));
+        }
+    } else {
+        if ((next & M68K_DESC_USED) == 0) {
+            stl_phys(cs->as, entry, next | M68K_DESC_USED);
+        }
+    }
+
+    if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
+        *page_size = 8192;
+        page_offset = address & 0x1fff;
+        *physical = (next & ~0x1fff) + page_offset;
+    } else {
+        *page_size = 4096;
+        page_offset = address & 0x0fff;
+        *physical = (next & ~0x0fff) + page_offset;
+    }
+
+    if (next & M68K_DESC_WRITEPROT) {
+        *prot &= ~PAGE_WRITE;
+        if (access_type & ACCESS_STORE) {
+            return -1;
+        }
+    }
+    if (next & M68K_DESC_SUPERONLY) {
+        if ((access_type & ACCESS_SUPER) == 0) {
+            return -1;
+        }
+    }
+
+    return 0;
+}
 
-/* TODO: This will need fixing once the MMU is implemented.  */
 hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    return addr;
+    M68kCPU *cpu = M68K_CPU(cs);
+    CPUM68KState *env = &cpu->env;
+    hwaddr phys_addr;
+    int prot;
+    int access_type;
+    target_ulong page_size;
+
+    if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
+        /* MMU disabled */
+        return addr;
+    }
+
+    access_type = ACCESS_INT;
+    if (env->sr & SR_S) {
+        access_type |= ACCESS_SUPER;
+    }
+    if (get_physical_address(env, &phys_addr, &prot,
+                             addr, access_type, &page_size) != 0) {
+        return -1;
+    }
+    return phys_addr;
 }
 
 int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                               int mmu_idx)
 {
+    M68kCPU *cpu = M68K_CPU(cs);
+    CPUM68KState *env = &cpu->env;
+    hwaddr physical;
     int prot;
+    int access_type;
+    int ret;
+    target_ulong page_size;
+
+    if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
+        /* MMU disabled */
+        tlb_set_page(cs, address & TARGET_PAGE_MASK,
+                     address & TARGET_PAGE_MASK,
+                     PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+                     mmu_idx, TARGET_PAGE_SIZE);
+        return 0;
+    }
+
+    if (rw == 2) {
+        access_type = ACCESS_CODE;
+        rw = 0;
+    } else {
+        access_type = ACCESS_INT;
+        if (rw) {
+            access_type |= ACCESS_STORE;
+        }
+    }
 
-    address &= TARGET_PAGE_MASK;
-    prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-    tlb_set_page(cs, address, address, prot, mmu_idx, TARGET_PAGE_SIZE);
-    return 0;
+    if (mmu_idx != MMU_USER_IDX) {
+        access_type |= ACCESS_SUPER;
+    }
+
+    ret = get_physical_address(&cpu->env, &physical, &prot,
+                               address, access_type, &page_size);
+    if (ret == 0) {
+        tlb_set_page(cs, address & TARGET_PAGE_MASK,
+                     physical & TARGET_PAGE_MASK,
+                     prot, mmu_idx, page_size);
+        return 0;
+    }
+    /* page fault */
+    env->mmu.ssw = M68K_ATC_040;
+    switch (size) {
+    case 1:
+        env->mmu.ssw |= M68K_BA_SIZE_BYTE;
+        break;
+    case 2:
+        env->mmu.ssw |= M68K_BA_SIZE_WORD;
+        break;
+    case 4:
+        env->mmu.ssw |= M68K_BA_SIZE_LONG;
+        break;
+    }
+    if (access_type & ACCESS_SUPER) {
+        env->mmu.ssw |= M68K_TM_040_SUPER;
+    }
+    if (access_type & ACCESS_CODE) {
+        env->mmu.ssw |= M68K_TM_040_CODE;
+    } else {
+        env->mmu.ssw |= M68K_TM_040_DATA;
+    }
+    if (!(access_type & ACCESS_STORE)) {
+        env->mmu.ssw |= M68K_RW_040;
+    }
+    env->mmu.ar = address;
+    cs->exception_index = EXCP_ACCESS;
+    return 1;
 }
 
 /* Notify CPU of a pending interrupt.  Prioritization and vectoring should
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 52781e85f0..2b83e3bc0d 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -31,6 +31,8 @@ static const MonitorDef monitor_defs[] = {
     { "ssp", offsetof(CPUM68KState, sp[0]) },
     { "usp", offsetof(CPUM68KState, sp[1]) },
     { "isp", offsetof(CPUM68KState, sp[2]) },
+    { "urp", offsetof(CPUM68KState, mmu.urp) },
+    { "srp", offsetof(CPUM68KState, mmu.srp) },
     { NULL },
 };
 
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 67697d4e6d..83ac1e669e 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -360,7 +360,50 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
     sp = env->aregs[7];
 
     sp &= ~1;
-    if (cs->exception_index == EXCP_ADDRESS) {
+    if (cs->exception_index == EXCP_ACCESS) {
+        static int mmu_fault;
+        if (mmu_fault) {
+            cpu_abort(cs, "DOUBLE MMU FAULT\n");
+        }
+        mmu_fault = 1;
+        sp -= 4;
+        cpu_stl_kernel(env, sp, 0); /* push data 3 */
+        sp -= 4;
+        cpu_stl_kernel(env, sp, 0); /* push data 2 */
+        sp -= 4;
+        cpu_stl_kernel(env, sp, 0); /* push data 1 */
+        sp -= 4;
+        cpu_stl_kernel(env, sp, 0); /* write back 1 / push data 0 */
+        sp -= 4;
+        cpu_stl_kernel(env, sp, 0); /* write back 1 address */
+        sp -= 4;
+        cpu_stl_kernel(env, sp, 0); /* write back 2 data */
+        sp -= 4;
+        cpu_stl_kernel(env, sp, 0); /* write back 2 address */
+        sp -= 4;
+        cpu_stl_kernel(env, sp, 0); /* write back 3 data */
+        sp -= 4;
+        cpu_stl_kernel(env, sp, env->mmu.ar); /* write back 3 address */
+        sp -= 4;
+        cpu_stl_kernel(env, sp, env->mmu.ar); /* fault address */
+        sp -= 2;
+        cpu_stw_kernel(env, sp, 0); /* write back 1 status */
+        sp -= 2;
+        cpu_stw_kernel(env, sp, 0); /* write back 2 status */
+        sp -= 2;
+        cpu_stw_kernel(env, sp, 0); /* write back 3 status */
+        sp -= 2;
+        cpu_stw_kernel(env, sp, env->mmu.ssw); /* special status word */
+        sp -= 4;
+        cpu_stl_kernel(env, sp, env->mmu.ar); /* effective address */
+        do_stack_frame(env, &sp, 7, oldsr, 0, retaddr);
+        mmu_fault = 0;
+        if (qemu_loglevel_mask(CPU_LOG_INT)) {
+            qemu_log("            "
+                     "ssw:  %08x ea:   %08x\n",
+                     env->mmu.ssw, env->mmu.ar);
+        }
+    } else if (cs->exception_index == EXCP_ADDRESS) {
         do_stack_frame(env, &sp, 2, oldsr, 0, retaddr);
     } else if (cs->exception_index == EXCP_ILLEGAL ||
                cs->exception_index == EXCP_DIV0 ||
@@ -408,6 +451,56 @@ static inline void do_interrupt_m68k_hardirq(CPUM68KState *env)
 {
     do_interrupt_all(env, 1);
 }
+
+void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
+                                bool is_exec, int is_asi, unsigned size)
+{
+    M68kCPU *cpu = M68K_CPU(cs);
+    CPUM68KState *env = &cpu->env;
+#ifdef DEBUG_UNASSIGNED
+    qemu_log_mask(CPU_LOG_INT, "Unassigned " TARGET_FMT_plx " wr=%d exe=%d\n",
+             addr, is_write, is_exec);
+#endif
+    if (env == NULL) {
+        /* when called from gdb, env is NULL */
+        return;
+    }
+
+    if (m68k_feature(env, M68K_FEATURE_M68040)) {
+        env->mmu.ssw |= M68K_ATC_040;
+        /* FIXME: manage MMU table access error */
+        env->mmu.ssw &= ~M68K_TM_040;
+        if (env->sr & SR_S) { /* SUPERVISOR */
+            env->mmu.ssw |= M68K_TM_040_SUPER;
+        }
+        if (is_exec) { /* instruction or data */
+            env->mmu.ssw |= M68K_TM_040_CODE;
+        } else {
+            env->mmu.ssw |= M68K_TM_040_DATA;
+        }
+        env->mmu.ssw &= ~M68K_BA_SIZE_MASK;
+        switch (size) {
+        case 1:
+            env->mmu.ssw |= M68K_BA_SIZE_BYTE;
+            break;
+        case 2:
+            env->mmu.ssw |= M68K_BA_SIZE_WORD;
+            break;
+        case 4:
+            env->mmu.ssw |= M68K_BA_SIZE_LONG;
+            break;
+        }
+
+        if (!is_write) {
+            env->mmu.ssw |= M68K_RW_040;
+        }
+
+        env->mmu.ar = addr;
+
+        cs->exception_index = EXCP_ACCESS;
+        cpu_loop_exit(cs);
+    }
+}
 #endif
 
 bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f0e86a73d4..5acee66208 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5981,6 +5981,8 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                env->current_sp == M68K_USP ? "->" : "  ", env->sp[M68K_USP],
                env->current_sp == M68K_ISP ? "->" : "  ", env->sp[M68K_ISP]);
     cpu_fprintf(f, "VBR = 0x%08x\n", env->vbr);
+    cpu_fprintf(f, "SSW %08x TCR %08x URP %08x SRP %08x\n",
+                env->mmu.ssw, env->mmu.tcr, env->mmu.urp, env->mmu.srp);
 #endif
 }
 
-- 
2.14.3
