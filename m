Received: from eggs.gnu.org ([2001:4830:134:3::10]:47416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5m-0001Ki-Lc
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5l-0001oB-DX
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY5l-0001jg-2s
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:41 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5j-0006fY-Im
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:57:39 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:56:52 +0100
Message-Id: <20181019165735.22511-3-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/45] target/arm: Add support for VCPU event
 states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Dongjiu Geng <gengdongjiu@huawei.com>

This patch extends the qemu-kvm state sync logic with support for
KVM_GET/SET_VCPU_EVENTS, giving access to yet missing SError exception.
And also it can support the exception state migration.

The SError exception states include SError pending state and ESR value,
the kvm_put/get_vcpu_events() will be called when set or get system
registers. When do migration, if source machine has SError pending,
QEMU will do this migration regardless whether the target machine supports
to specify guest ESR value, because if target machine does not support that,
it can also inject the SError with zero ESR value.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1538067351-23931-3-git-send-email-gengdongjiu@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     |  7 ++++++
 target/arm/kvm_arm.h | 24 ++++++++++++++++++
 target/arm/kvm.c     | 60 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm32.c   | 13 ++++++++++
 target/arm/kvm64.c   | 13 ++++++++++
 target/arm/machine.c | 22 ++++++++++++++++
 6 files changed, 139 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f00c0444c48..a314e557ac0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -531,6 +531,13 @@ typedef struct CPUARMState {
          */
     } exception;
 
+    /* Information associated with an SError */
+    struct {
+        uint8_t pending;
+        uint8_t has_esr;
+        uint64_t esr;
+    } serror;
+
     /* Thumb-2 EE state.  */
     uint32_t teecr;
     uint32_t teehbr;
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 5948e8b5602..21c0129da24 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -121,6 +121,30 @@ bool write_kvmstate_to_list(ARMCPU *cpu);
  */
 void kvm_arm_reset_vcpu(ARMCPU *cpu);
 
+/**
+ * kvm_arm_init_serror_injection:
+ * @cs: CPUState
+ *
+ * Check whether KVM can set guest SError syndrome.
+ */
+void kvm_arm_init_serror_injection(CPUState *cs);
+
+/**
+ * kvm_get_vcpu_events:
+ * @cpu: ARMCPU
+ *
+ * Get VCPU related state from kvm.
+ */
+int kvm_get_vcpu_events(ARMCPU *cpu);
+
+/**
+ * kvm_put_vcpu_events:
+ * @cpu: ARMCPU
+ *
+ * Put VCPU related state to kvm.
+ */
+int kvm_put_vcpu_events(ARMCPU *cpu);
+
 #ifdef CONFIG_KVM
 /**
  * kvm_arm_create_scratch_host_vcpu:
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 54ef5f711b8..09a86e2820b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -34,6 +34,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
 };
 
 static bool cap_has_mp_state;
+static bool cap_has_inject_serror_esr;
 
 static ARMHostCPUFeatures arm_host_cpu_features;
 
@@ -48,6 +49,12 @@ int kvm_arm_vcpu_init(CPUState *cs)
     return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_INIT, &init);
 }
 
+void kvm_arm_init_serror_injection(CPUState *cs)
+{
+    cap_has_inject_serror_esr = kvm_check_extension(cs->kvm_state,
+                                    KVM_CAP_ARM_INJECT_SERROR_ESR);
+}
+
 bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
                                       int *fdarray,
                                       struct kvm_vcpu_init *init)
@@ -522,6 +529,59 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
     return 0;
 }
 
+int kvm_put_vcpu_events(ARMCPU *cpu)
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
+    events.exception.serror_pending = env->serror.pending;
+
+    /* Inject SError to guest with specified syndrome if host kernel
+     * supports it, otherwise inject SError without syndrome.
+     */
+    if (cap_has_inject_serror_esr) {
+        events.exception.serror_has_esr = env->serror.has_esr;
+        events.exception.serror_esr = env->serror.esr;
+    }
+
+    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
+    if (ret) {
+        error_report("failed to put vcpu events");
+    }
+
+    return ret;
+}
+
+int kvm_get_vcpu_events(ARMCPU *cpu)
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
+    if (ret) {
+        error_report("failed to get vcpu events");
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
 void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 {
 }
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 4e91c11796b..0f1e94c7b5e 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -217,6 +217,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
     cpu->mp_affinity = mpidr & ARM32_AFFINITY_MASK;
 
+    /* Check whether userspace can specify guest syndrome value */
+    kvm_arm_init_serror_injection(cs);
+
     return kvm_arm_init_cpreg_list(cpu);
 }
 
@@ -358,6 +361,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
+    ret = kvm_put_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     /* Note that we do not call write_cpustate_to_list()
      * here, so we are only writing the tuple list back to
      * KVM. This is safe because nothing can change the
@@ -445,6 +453,11 @@ int kvm_arch_get_registers(CPUState *cs)
     }
     vfp_set_fpscr(env, fpscr);
 
+    ret = kvm_get_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     if (!write_kvmstate_to_list(cpu)) {
         return EINVAL;
     }
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index e0b82462838..5411486491a 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -546,6 +546,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     kvm_arm_init_debug(cs);
 
+    /* Check whether user space can specify guest syndrome value */
+    kvm_arm_init_serror_injection(cs);
+
     return kvm_arm_init_cpreg_list(cpu);
 }
 
@@ -727,6 +730,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
@@ -863,6 +871,11 @@ int kvm_arch_get_registers(CPUState *cs)
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
index ff4ec22bf75..32bcde070a0 100644
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
+    .name = "cpu/serror",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = serror_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(env.serror.pending, ARMCPU),
+        VMSTATE_UINT8(env.serror.has_esr, ARMCPU),
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
2.19.1
