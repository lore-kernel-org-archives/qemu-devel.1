Received: from eggs.gnu.org ([2001:4830:134:3::10]:51675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dihqt-0004Jl-4U
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dihqr-0000Eh-BI
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:02:19 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Fri, 18 Aug 2017 22:23:46 +0800
Message-ID: <1503066227-18251-6-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
References: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v11 5/6] target-arm: kvm64: handle SIGBUS
 signal for synchronous External Abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, edk2-devel@lists.01.org, christoffer.dall@linaro.org, marc.zyngier@arm.com, will.deacon@arm.com, james.morse@arm.com, tbaicar@codeaurora.org, ard.biesheuvel@linaro.org, mingo@kernel.org, bp@suse.de, shiju.jose@huawei.com, zjzhang@codeaurora.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, john.garry@huawei.com, jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com
Cc: huangshaoyu@huawei.com, wuquanming@huawei.com, linuxarm@huawei.com, gengdongjiu@huawei.com, zhengqiang10@huawei.com

Add SIGBUS signal handler. In this handler, it checks
the exception type, translates the host VA which is
delivered by host or KVM to guest PA, then fills this
PA to CPER, finally injects a Error to guest OS through
KVM.

Add synchronous external abort injection logic, setup
spsr_elx, esr_elx, PSTATE, far_elx, elr_elx etc, when
switch to guest OS, it will jump to the synchronous
external abort vector table entry.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Quanming Wu <wuquanming@huawei.com>
---
 include/sysemu/kvm.h          |   2 +-
 linux-headers/asm-arm64/kvm.h |   5 ++
 target/arm/internals.h        |  13 ++++
 target/arm/kvm.c              |  34 ++++++++++
 target/arm/kvm64.c            | 150 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h          |   1 +
 6 files changed, 204 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 3a458f5..90c1605 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -361,7 +361,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
 unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 
-#ifdef TARGET_I386
+#if defined(TARGET_I386) || defined(TARGET_AARCH64)
 #define KVM_HAVE_MCE_INJECTION 1
 void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 #endif
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index d254700..5909c30 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -181,6 +181,11 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM64_SYSREG_OP2_MASK	0x0000000000000007
 #define KVM_REG_ARM64_SYSREG_OP2_SHIFT	0
 
+/* AArch64 fault registers */
+#define KVM_REG_ARM64_FAULT             (0x0014 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM64_FAULT_ESR_EC      (0)
+#define KVM_REG_ARM64_FAULT_FAR         (1)
+
 #define ARM64_SYS_REG_SHIFT_MASK(x,n) \
 	(((x) << KVM_REG_ARM64_SYSREG_ ## n ## _SHIFT) & \
 	KVM_REG_ARM64_SYSREG_ ## n ## _MASK)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1f6efef..fc0ad6d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -235,6 +235,19 @@ enum arm_exception_class {
 #define ARM_EL_ISV_SHIFT 24
 #define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
 #define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
+#define ARM_EL_EC_MASK  ((0x3F) << ARM_EL_EC_SHIFT)
+#define ARM_EL_FSC_TYPE (0x3C)
+
+#define FSC_SEA         (0x10)
+#define FSC_SEA_TTW0    (0x14)
+#define FSC_SEA_TTW1    (0x15)
+#define FSC_SEA_TTW2    (0x16)
+#define FSC_SEA_TTW3    (0x17)
+#define FSC_SECC        (0x18)
+#define FSC_SECC_TTW0   (0x1c)
+#define FSC_SECC_TTW1   (0x1d)
+#define FSC_SECC_TTW2   (0x1e)
+#define FSC_SECC_TTW3   (0x1f)
 
 /* Utility functions for constructing various kinds of syndrome value.
  * Note that in general we follow the AArch64 syndrome values; in a
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7c17f0d..2e1716a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -129,6 +129,39 @@ void kvm_arm_destroy_scratch_host_vcpu(int *fdarray)
     }
 }
 
+typedef struct HWPoisonPage {
+    ram_addr_t ram_addr;
+    QLIST_ENTRY(HWPoisonPage) list;
+} HWPoisonPage;
+
+static QLIST_HEAD(, HWPoisonPage) hwpoison_page_list =
+    QLIST_HEAD_INITIALIZER(hwpoison_page_list);
+
+static void kvm_unpoison_all(void *param)
+{
+    HWPoisonPage *page, *next_page;
+
+    QLIST_FOREACH_SAFE(page, &hwpoison_page_list, list, next_page) {
+        QLIST_REMOVE(page, list);
+        qemu_ram_remap(page->ram_addr, TARGET_PAGE_SIZE);
+        g_free(page);
+    }
+}
+
+void kvm_hwpoison_page_add(ram_addr_t ram_addr)
+{
+    HWPoisonPage *page;
+
+    QLIST_FOREACH(page, &hwpoison_page_list, list) {
+        if (page->ram_addr == ram_addr) {
+            return;
+        }
+    }
+    page = g_new(HWPoisonPage, 1);
+    page->ram_addr = ram_addr;
+    QLIST_INSERT_HEAD(&hwpoison_page_list, page, list);
+}
+
 static void kvm_arm_host_cpu_class_init(ObjectClass *oc, void *data)
 {
     ARMHostCPUClass *ahcc = ARM_HOST_CPU_CLASS(oc);
@@ -182,6 +215,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
 
+    qemu_register_reset(kvm_unpoison_all, NULL);
     type_register_static(&host_arm_cpu_type_info);
 
     return 0;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 0781367..d3bdab2 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -27,6 +27,8 @@
 #include "kvm_arm.h"
 #include "internals.h"
 #include "hw/arm/arm.h"
+#include "hw/acpi/acpi-defs.h"
+#include "hw/acpi/hest_ghes.h"
 
 static bool have_guest_debug;
 
@@ -590,6 +592,79 @@ int kvm_arm_cpreg_level(uint64_t regidx)
     return KVM_PUT_RUNTIME_STATE;
 }
 
+static int kvm_arm_cpreg_value(ARMCPU *cpu, ptrdiff_t fieldoffset)
+{
+    int i;
+
+    for (i = 0; i < cpu->cpreg_array_len; i++) {
+        uint32_t regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
+        const ARMCPRegInfo *ri;
+        ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
+        if (!ri) {
+            continue;
+        }
+
+        if (ri->type & ARM_CP_NO_RAW) {
+            continue;
+        }
+
+        if (ri->fieldoffset == fieldoffset) {
+            cpu->cpreg_values[i] = read_raw_cp_reg(&cpu->env, ri);
+            return 0;
+        }
+    }
+    return -EINVAL;
+}
+
+/* Inject synchronous external abort */
+static int kvm_inject_arm_sea(CPUState *c)
+{
+    ARMCPU *cpu = ARM_CPU(c);
+    CPUARMState *env = &cpu->env;
+    unsigned long cpsr = pstate_read(env);
+    uint32_t esr = 0;
+    int ret;
+
+    c->exception_index = EXCP_DATA_ABORT;
+    /* Inject the exception to El1 */
+    env->exception.target_el = 1;
+    CPUClass *cc = CPU_GET_CLASS(c);
+
+    esr |= (EC_DATAABORT << ARM_EL_EC_SHIFT);
+    /* This exception syndrome includes {I,D}FSC in the bits [5:0]
+     */
+    esr |= (env->exception.syndrome & 0x3f);
+
+    /* This exception is EL0 or EL1 fault. */
+    if ((cpsr & 0xf) == PSTATE_MODE_EL0t) {
+        esr |= (EC_INSNABORT << ARM_EL_EC_SHIFT);
+    } else {
+        esr |= (EC_INSNABORT_SAME_EL << ARM_EL_EC_SHIFT);
+    }
+
+    /* In the aarch64, there is only 32-bit instruction*/
+    esr |= ARM_EL_IL;
+    env->exception.syndrome = esr;
+    cc->do_interrupt(c);
+
+    /* set ESR_EL1 */
+    ret = kvm_arm_cpreg_value(cpu, offsetof(CPUARMState, cp15.esr_el[1]));
+
+    if (ret) {
+        fprintf(stderr, "<%s> failed to set esr_el1\n", __func__);
+        abort();
+    }
+
+    /* set FAR_EL1 */
+    ret = kvm_arm_cpreg_value(cpu, offsetof(CPUARMState, cp15.far_el[1]));
+    if (ret) {
+        fprintf(stderr, "<%s> failed to set far_el1\n", __func__);
+        abort();
+    }
+
+    return 0;
+}
+
 #define AARCH64_CORE_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
                  KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
 
@@ -599,6 +674,9 @@ int kvm_arm_cpreg_level(uint64_t regidx)
 #define AARCH64_SIMD_CTRL_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U32 | \
                  KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
 
+#define AARCH64_FAULT_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
+                 KVM_REG_ARM64_FAULT | (x))
+
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
     struct kvm_one_reg reg;
@@ -873,6 +951,22 @@ int kvm_arch_get_registers(CPUState *cs)
     }
     vfp_set_fpcr(env, fpr);
 
+    if (is_a64(env)) {
+        reg.id = AARCH64_FAULT_REG(KVM_REG_ARM64_FAULT_ESR_EC);
+        reg.addr = (uintptr_t)(&env->exception.syndrome);
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+
+        reg.id = AARCH64_FAULT_REG(KVM_REG_ARM64_FAULT_FAR);
+        reg.addr = (uintptr_t)(&env->exception.vaddress);
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
     if (!write_kvmstate_to_list(cpu)) {
         return EINVAL;
     }
@@ -887,6 +981,62 @@ int kvm_arch_get_registers(CPUState *cs)
     return ret;
 }
 
+static bool is_abort_sea(unsigned long syndrome)
+{
+    unsigned long fault_status;
+    uint8_t ec = ((syndrome & ARM_EL_EC_MASK) >> ARM_EL_EC_SHIFT);
+    if ((ec != EC_INSNABORT) && (ec != EC_DATAABORT)) {
+        return false;
+    }
+
+    fault_status = syndrome & ARM_EL_FSC_TYPE;
+    switch (fault_status) {
+    case FSC_SEA:
+    case FSC_SEA_TTW0:
+    case FSC_SEA_TTW1:
+    case FSC_SEA_TTW2:
+    case FSC_SEA_TTW3:
+    case FSC_SECC:
+    case FSC_SECC_TTW0:
+    case FSC_SECC_TTW1:
+    case FSC_SECC_TTW2:
+    case FSC_SECC_TTW3:
+        return true;
+    default:
+        return false;
+    }
+}
+
+void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
+{
+    ram_addr_t ram_addr;
+    hwaddr paddr;
+
+    ARMCPU *cpu = ARM_CPU(c);
+    CPUARMState *env = &cpu->env;
+    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
+    if (addr) {
+        ram_addr = qemu_ram_addr_from_host(addr);
+        if (ram_addr != RAM_ADDR_INVALID &&
+            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
+            kvm_cpu_synchronize_state(c);
+            kvm_hwpoison_page_add(ram_addr);
+            if (is_abort_sea(env->exception.syndrome)) {
+                ghes_update_guest(ACPI_HEST_NOTIFY_SEA, paddr);
+                kvm_inject_arm_sea(c);
+            }
+            return;
+        }
+        fprintf(stderr, "Hardware memory error for memory used by "
+                "QEMU itself instead of guest system!\n");
+    }
+
+    if (code == BUS_MCEERR_AR) {
+        fprintf(stderr, "Hardware memory error!\n");
+        exit(1);
+    }
+}
+
 /* C6.6.29 BRK instruction */
 static const uint32_t brk_insn = 0xd4200000;
 
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 633d088..7cdde97 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -288,4 +288,5 @@ static inline const char *its_class_name(void)
     }
 }
 
+void kvm_hwpoison_page_add(ram_addr_t ram_addr);
 #endif
-- 
1.8.3.1
