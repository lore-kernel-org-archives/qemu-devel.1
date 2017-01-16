Received: from eggs.gnu.org ([2001:4830:134:3::10]:49033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cT3cm-0003z3-LZ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cT3ch-0002Wa-Rr
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:30:48 -0500
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Mon, 16 Jan 2017 17:26:58 +0800
Message-ID: <1484558821-15512-4-git-send-email-zhaoshenglong@huawei.com>
In-Reply-To: <1484558821-15512-1-git-send-email-zhaoshenglong@huawei.com>
References: <1484558821-15512-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC 3/6] arm: kvm64: Check if kvm supports
 cross type vCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, drjones@redhat.com, christoffer.dall@linaro.org, kvmarm@lists.cs.columbia.edu, zhaoshenglong@huawei.com, wu.wubin@huawei.com

From: Shannon Zhao <shannon.zhao@linaro.org>

If user requests a specific type vCPU which is not same with the
physical ones and if kvm supports cross type vCPU, we set the
KVM_ARM_VCPU_CROSS bit and set the CPU ID registers.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 target/arm/kvm64.c | 182 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 6111109..70442ea 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -481,7 +481,151 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUClass *ahcc)
     return true;
 }
 
+#define ARM_CPU_ID_MIDR        3, 0, 0, 0, 0
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
+/* ID group 1 registers */
+#define ARM_CPU_ID_REVIDR      3, 0, 0, 0, 6
+#define ARM_CPU_ID_AIDR        3, 1, 0, 0, 7
+
+/* ID group 2 registers */
+#define ARM_CPU_ID_CCSIDR      3, 1, 0, 0, 0
+#define ARM_CPU_ID_CLIDR       3, 1, 0, 0, 1
+#define ARM_CPU_ID_CSSELR      3, 2, 0, 0, 0
+#define ARM_CPU_ID_CTR         3, 3, 0, 0, 1
+
+/* ID group 3 registers */
+#define ARM_CPU_ID_PFR0        3, 0, 0, 1, 0
+#define ARM_CPU_ID_PFR1        3, 0, 0, 1, 1
+#define ARM_CPU_ID_DFR0        3, 0, 0, 1, 2
+#define ARM_CPU_ID_AFR0        3, 0, 0, 1, 3
+#define ARM_CPU_ID_MMFR0       3, 0, 0, 1, 4
+#define ARM_CPU_ID_MMFR1       3, 0, 0, 1, 5
+#define ARM_CPU_ID_MMFR2       3, 0, 0, 1, 6
+#define ARM_CPU_ID_MMFR3       3, 0, 0, 1, 7
+#define ARM_CPU_ID_ISAR0       3, 0, 0, 2, 0
+#define ARM_CPU_ID_ISAR1       3, 0, 0, 2, 1
+#define ARM_CPU_ID_ISAR2       3, 0, 0, 2, 2
+#define ARM_CPU_ID_ISAR3       3, 0, 0, 2, 3
+#define ARM_CPU_ID_ISAR4       3, 0, 0, 2, 4
+#define ARM_CPU_ID_ISAR5       3, 0, 0, 2, 5
+#define ARM_CPU_ID_MMFR4       3, 0, 0, 2, 6
+#define ARM_CPU_ID_MVFR0       3, 0, 0, 3, 0
+#define ARM_CPU_ID_MVFR1       3, 0, 0, 3, 1
+#define ARM_CPU_ID_MVFR2       3, 0, 0, 3, 2
+#define ARM_CPU_ID_AA64PFR0    3, 0, 0, 4, 0
+#define ARM_CPU_ID_AA64PFR1    3, 0, 0, 4, 1
+#define ARM_CPU_ID_AA64DFR0    3, 0, 0, 5, 0
+#define ARM_CPU_ID_AA64DFR1    3, 0, 0, 5, 1
+#define ARM_CPU_ID_AA64AFR0    3, 0, 0, 5, 4
+#define ARM_CPU_ID_AA64AFR1    3, 0, 0, 5, 5
+#define ARM_CPU_ID_AA64ISAR0   3, 0, 0, 6, 0
+#define ARM_CPU_ID_AA64ISAR1   3, 0, 0, 6, 1
+#define ARM_CPU_ID_AA64MMFR0   3, 0, 0, 7, 0
+#define ARM_CPU_ID_AA64MMFR1   3, 0, 0, 7, 1
+#define ARM_CPU_ID_MAX         36
+
+static int kvm_arm_set_id_registers(CPUState *cs)
+{
+    int ret = 0;
+    uint32_t i;
+    ARMCPU *cpu = ARM_CPU(cs);
+    struct kvm_one_reg id_regitsers[ARM_CPU_ID_MAX];
+
+    memset(id_regitsers, 0, ARM_CPU_ID_MAX * sizeof(struct kvm_one_reg));
+
+    id_regitsers[0].id = ARM64_SYS_REG(ARM_CPU_ID_MIDR);
+    id_regitsers[0].addr = (uintptr_t)&cpu->midr;
+
+    id_regitsers[1].id = ARM64_SYS_REG(ARM_CPU_ID_REVIDR);
+    id_regitsers[1].addr = (uintptr_t)&cpu->revidr;
+
+    id_regitsers[2].id = ARM64_SYS_REG(ARM_CPU_ID_MVFR0);
+    id_regitsers[2].addr = (uintptr_t)&cpu->mvfr0;
+
+    id_regitsers[3].id = ARM64_SYS_REG(ARM_CPU_ID_MVFR1);
+    id_regitsers[3].addr = (uintptr_t)&cpu->mvfr1;
+
+    id_regitsers[4].id = ARM64_SYS_REG(ARM_CPU_ID_MVFR2);
+    id_regitsers[4].addr = (uintptr_t)&cpu->mvfr2;
+
+    id_regitsers[5].id = ARM64_SYS_REG(ARM_CPU_ID_PFR0);
+    id_regitsers[5].addr = (uintptr_t)&cpu->id_pfr0;
+
+    id_regitsers[6].id = ARM64_SYS_REG(ARM_CPU_ID_PFR1);
+    id_regitsers[6].addr = (uintptr_t)&cpu->id_pfr1;
+
+    id_regitsers[7].id = ARM64_SYS_REG(ARM_CPU_ID_DFR0);
+    id_regitsers[7].addr = (uintptr_t)&cpu->id_dfr0;
+
+    id_regitsers[8].id = ARM64_SYS_REG(ARM_CPU_ID_AFR0);
+    id_regitsers[8].addr = (uintptr_t)&cpu->id_afr0;
+
+    id_regitsers[9].id = ARM64_SYS_REG(ARM_CPU_ID_MMFR0);
+    id_regitsers[9].addr = (uintptr_t)&cpu->id_mmfr0;
+
+    id_regitsers[10].id = ARM64_SYS_REG(ARM_CPU_ID_MMFR1);
+    id_regitsers[10].addr = (uintptr_t)&cpu->id_mmfr1;
+
+    id_regitsers[11].id = ARM64_SYS_REG(ARM_CPU_ID_MMFR2);
+    id_regitsers[11].addr = (uintptr_t)&cpu->id_mmfr2;
+
+    id_regitsers[12].id = ARM64_SYS_REG(ARM_CPU_ID_MMFR3);
+    id_regitsers[12].addr = (uintptr_t)&cpu->id_mmfr3;
+
+    id_regitsers[13].id = ARM64_SYS_REG(ARM_CPU_ID_ISAR0);
+    id_regitsers[13].addr = (uintptr_t)&cpu->id_isar0;
+
+    id_regitsers[14].id = ARM64_SYS_REG(ARM_CPU_ID_ISAR1);
+    id_regitsers[14].addr = (uintptr_t)&cpu->id_isar1;
+
+    id_regitsers[15].id = ARM64_SYS_REG(ARM_CPU_ID_ISAR2);
+    id_regitsers[15].addr = (uintptr_t)&cpu->id_isar2;
+
+    id_regitsers[16].id = ARM64_SYS_REG(ARM_CPU_ID_ISAR3);
+    id_regitsers[16].addr = (uintptr_t)&cpu->id_isar3;
+
+    id_regitsers[17].id = ARM64_SYS_REG(ARM_CPU_ID_ISAR4);
+    id_regitsers[17].addr = (uintptr_t)&cpu->id_isar4;
+
+    id_regitsers[18].id = ARM64_SYS_REG(ARM_CPU_ID_ISAR5);
+    id_regitsers[18].addr = (uintptr_t)&cpu->id_isar5;
+
+    id_regitsers[19].id = ARM64_SYS_REG(ARM_CPU_ID_AA64PFR0);
+    id_regitsers[19].addr = (uintptr_t)&cpu->id_aa64pfr0;
+
+    id_regitsers[20].id = ARM64_SYS_REG(ARM_CPU_ID_AA64DFR0);
+    id_regitsers[20].addr = (uintptr_t)&cpu->id_aa64dfr0;
+
+    id_regitsers[21].id = ARM64_SYS_REG(ARM_CPU_ID_AA64ISAR0);
+    id_regitsers[21].addr = (uintptr_t)&cpu->id_aa64isar0;
+
+    id_regitsers[22].id = ARM64_SYS_REG(ARM_CPU_ID_AA64MMFR0);
+    id_regitsers[22].addr = (uintptr_t)&cpu->id_aa64mmfr0;
+
+    id_regitsers[23].id = ARM64_SYS_REG(ARM_CPU_ID_CLIDR);
+    id_regitsers[23].addr = (uintptr_t)&cpu->clidr;
+
+    id_regitsers[24].id = ARM64_SYS_REG(ARM_CPU_ID_CTR);
+    id_regitsers[24].addr = (uintptr_t)&cpu->ctr;
+
+
+    for (i = 0; i < ARM_CPU_ID_MAX; i++) {
+        if(id_regitsers[i].id != 0) {
+            ret = kvm_set_one_reg(cs, id_regitsers[i].id,
+                                  (void *)id_regitsers[i].addr);
+            if (ret) {
+                fprintf(stderr, "set ID register 0x%llx failed\n",
+                        id_regitsers[i].id);
+                return ret;
+            }
+        } else {
+            break;
+        }
+    }
+
+    /* TODO: Set CCSIDR */
+    return ret;
+}
 
 int kvm_arch_init_vcpu(CPUState *cs)
 {
@@ -489,6 +633,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
     uint64_t mpidr;
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
+    bool heterogeneous = false, cross = false;
+    struct kvm_vcpu_init init;
 
     if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE ||
         !object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU)) {
@@ -518,12 +664,48 @@ int kvm_arch_init_vcpu(CPUState *cs)
         unset_feature(&env->features, ARM_FEATURE_PMU);
     }
 
+    /*
+     * Check if host is a heterogeneous system. It doesn't support -cpu host on
+     * heterogeneous system. If user requests a specific type VCPU, it should
+     * set the KVM_ARM_VCPU_CROSS bit to tell KVM that userspace want a specific
+     * vCPU. If KVM supports cross type vCPU, then set the ID registers.
+     */
+    if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_HETEROGENEOUS)) {
+        heterogeneous = true;
+    }
+
+    if (strcmp(object_get_typename(OBJECT(cpu)), TYPE_ARM_HOST_CPU) == 0) {
+        if (heterogeneous) {
+            fprintf(stderr, "heterogeneous system can't support host guest CPU type\n");
+            return -EINVAL;
+        }
+    } else if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_CROSS_VCPU)) {
+        init.features[0] = 1 << KVM_ARM_VCPU_CROSS;
+        if (kvm_vm_ioctl(cs->kvm_state, KVM_ARM_PREFERRED_TARGET, &init) < 0) {
+            return -EINVAL;
+        }
+
+        if (init.target != (cpu->midr & 0xFF00FFF0) || heterogeneous) {
+            cpu->kvm_target = QEMU_KVM_ARM_TARGET_GENERIC_V8;
+            cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_CROSS;
+            cross = true;
+       }
+    }
+
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cs);
     if (ret) {
         return ret;
     }
 
+    if (cross) {
+        ret = kvm_arm_set_id_registers(cs);
+        if (ret) {
+            fprintf(stderr, "set vcpu ID registers failed\n");
+            return ret;
+        }
+    }
+
     /*
      * When KVM is in use, PSCI is emulated in-kernel and not by qemu.
      * Currently KVM has its own idea about MPIDR assignment, so we
-- 
2.0.4
