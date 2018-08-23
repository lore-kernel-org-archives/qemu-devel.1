Received: from eggs.gnu.org ([2001:4830:134:3::10]:60018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fskJA-0004cP-QB
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 03:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fskEN-0006nA-9q
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 03:40:36 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Thu, 23 Aug 2018 11:45:00 -0400
Message-ID: <1535039100-11248-2-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1535039100-11248-1-git-send-email-gengdongjiu@huawei.com>
References: <1535039100-11248-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 2/2] target: arm: Add support for VCPU event
 states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: gengdongjiu@huawei.com, linuxarm@huawei.com

This patch extends the qemu-kvm state sync logic with support for
KVM_GET/SET_VCPU_EVENTS, giving access to yet missing SError exception.
And also it can support the exception state migration.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
Change since v5:
address Peter's comments:
1. Move the "struct serror" before the "end_reset_fields" in CPUARMState
2. Remove ARM_FEATURE_RAS_EXT and add a variable have_inject_serror_esr
3. Use the variable have_inject_serror_esr to track whether the kernel has state we need to migrate
4. Remove printf() in kvm_arch_put_registers()
5. ras_needed/vmstate_ras to serror_needed/vmstate_serror
6. Check to use "return env.serror.pending != 0" instead of "arm_feature(env, ARM_FEATURE_RAS_EXT)" in the ras_needed()

Change since v4:
1. Rebase the code to latest

Change since v3:
1. Add a new new subsection with a suitable 'ras_needed' function
   controlling whether it is present
2. Add a ARM_FEATURE_RAS feature bit for CPUARMState
---
 target/arm/cpu.h     |  7 +++++++
 target/arm/kvm64.c   | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/machine.c | 22 ++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 62c36b4..7030680 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -530,6 +530,13 @@ typedef struct CPUARMState {
          */
     } exception;
 
+    /* Information associated with an SError */
+    struct {
+        uint32_t pending;
+        uint32_t has_esr;
+        uint64_t esr;
+    } serror;
+
     /* Thumb-2 EE state.  */
     uint32_t teecr;
     uint32_t teehbr;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index e0b8246..3913143 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -29,6 +29,7 @@
 #include "hw/arm/arm.h"
 
 static bool have_guest_debug;
+static bool have_inject_serror_esr;
 
 /*
  * Although the ARM implementation of hardware assisted debugging
@@ -546,6 +547,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     kvm_arm_init_debug(cs);
 
+    /* Check whether userspace can specify guest syndrome value */
+    have_inject_serror_esr = kvm_check_extension(cs->kvm_state,
+                                                 KVM_CAP_ARM_INJECT_SERROR_ESR);
+
     return kvm_arm_init_cpreg_list(cpu);
 }
 
@@ -600,6 +605,50 @@ int kvm_arm_cpreg_level(uint64_t regidx)
 #define AARCH64_SIMD_CTRL_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U32 | \
                  KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
 
+static int kvm_put_vcpu_events(ARMCPU *cpu)
+{
+    CPUARMState *env = &cpu->env;
+    struct kvm_vcpu_events events = {};
+
+    if (!kvm_has_vcpu_events()) {
+        return 0;
+    }
+
+    memset(&events, 0, sizeof(events));
+    events.exception.serror_pending = env->serror.pending;
+
+    if (have_inject_serror_esr) {
+        events.exception.serror_has_esr = env->serror.has_esr;
+        events.exception.serror_esr = env->serror.esr;
+    }
+
+    return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
+}
+
+static int kvm_get_vcpu_events(ARMCPU *cpu)
+{
+    CPUARMState *env = &cpu->env;
+    struct kvm_vcpu_events events;
+    int ret;
+
+    if (!kvm_has_vcpu_events()) {
+        return 0;
+    }
+
+    memset(&events, 0, sizeof(events));
+    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_VCPU_EVENTS, &events);
+
+    if (ret < 0) {
+        return ret;
+    }
+
+    env->serror.pending = events.exception.serror_pending;
+    env->serror.has_esr = events.exception.serror_has_esr;
+    env->serror.esr = events.exception.serror_esr;
+
+    return 0;
+}
+
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
     struct kvm_one_reg reg;
@@ -727,6 +776,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
+    ret = kvm_put_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     if (!write_list_to_kvmstate(cpu, level)) {
         return EINVAL;
     }
@@ -863,6 +917,11 @@ int kvm_arch_get_registers(CPUState *cs)
     }
     vfp_set_fpcr(env, fpr);
 
+    ret = kvm_get_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     if (!write_kvmstate_to_list(cpu)) {
         return EINVAL;
     }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index ff4ec22..1a58b5f 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -172,6 +172,27 @@ static const VMStateDescription vmstate_sve = {
 };
 #endif /* AARCH64 */
 
+static bool serror_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+
+    return env->serror.pending != 0;
+}
+
+static const VMStateDescription vmstate_serror = {
+    .name = "cpu/ras",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = serror_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.serror.pending, ARMCPU),
+        VMSTATE_UINT32(env.serror.has_esr, ARMCPU),
+        VMSTATE_UINT64(env.serror.esr, ARMCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool m_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -726,6 +747,7 @@ const VMStateDescription vmstate_arm_cpu = {
 #ifdef TARGET_AARCH64
         &vmstate_sve,
 #endif
+        &vmstate_serror,
         NULL
     }
 };
-- 
1.9.1
