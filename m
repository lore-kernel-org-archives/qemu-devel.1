Received: from eggs.gnu.org ([2001:4830:134:3::10]:41161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g0c8k-0004kr-Fi
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 20:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g0c8c-0004mZ-10
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 20:39:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1g0c8Z-0004ga-Jg
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 20:39:08 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Fri, 14 Sep 2018 03:38:27 +0300
Message-Id: <20180914003827.124570-3-liran.alon@oracle.com>
In-Reply-To: <20180914003827.124570-1-liran.alon@oracle.com>
References: <20180914003827.124570-1-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 2/2] KVM: i386: Add support for save and
 restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com
Cc: pbonzini@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, jmattson@google.com, idan.brown@oracle.com, Liran Alon <liran.alon@oracle.com>

Kernel commit 8fcc4b5923af ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")
introduced new IOCTLs to extract and restore KVM internal state used to
run a VM that is in VMX operation.

Utilize these IOCTLs to add support of migration of VMs which are
running nested hypervisors.

Reviewed-by: Nikita Leshchenko <nikita.leshchenko@oracle.com>
Reviewed-by: Patrick Colp <patrick.colp@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 accel/kvm/kvm-all.c   | 14 +++++++++++++
 include/sysemu/kvm.h  |  1 +
 target/i386/cpu.h     |  2 ++
 target/i386/kvm.c     | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/machine.c | 38 +++++++++++++++++++++++++++++++++
 5 files changed, 113 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index de12f78eb8e4..3f0d0dd741b9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -87,6 +87,7 @@ struct KVMState
 #ifdef KVM_CAP_SET_GUEST_DEBUG
     struct kvm_sw_breakpoint_head kvm_sw_breakpoints;
 #endif
+    uint32_t nested_state_len;
     int many_ioeventfds;
     int intx_set_mask;
     bool sync_mmu;
@@ -1628,6 +1629,14 @@ static int kvm_init(MachineState *ms)
     s->debugregs = kvm_check_extension(s, KVM_CAP_DEBUGREGS);
 #endif
 
+    ret = kvm_check_extension(s, KVM_CAP_NESTED_STATE);
+    if (ret < 0) {
+        fprintf(stderr, "kvm failed to get size of nested state (%d)",
+                ret);
+        goto err;
+    }
+    s->nested_state_len = (uint32_t)ret;
+
 #ifdef KVM_CAP_IRQ_ROUTING
     kvm_direct_msi_allowed = (kvm_check_extension(s, KVM_CAP_SIGNAL_MSI) > 0);
 #endif
@@ -2187,6 +2196,11 @@ int kvm_has_debugregs(void)
     return kvm_state->debugregs;
 }
 
+uint32_t kvm_nested_state_length(void)
+{
+    return kvm_state->nested_state_len;
+}
+
 int kvm_has_many_ioeventfds(void)
 {
     if (!kvm_enabled()) {
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 0b64b8e06786..17dadaf57f40 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -210,6 +210,7 @@ bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
 int kvm_has_robust_singlestep(void);
 int kvm_has_debugregs(void);
+uint32_t kvm_nested_state_length(void);
 int kvm_has_pit_state2(void);
 int kvm_has_many_ioeventfds(void);
 int kvm_has_gsi_routing(void);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6e4c2b02f947..3b97b5b280f0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1330,6 +1330,8 @@ typedef struct CPUX86State {
 #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
     void *xsave_buf;
 #endif
+    struct kvm_nested_state *nested_state;
+    uint32_t nested_state_len;   /* needed for migration */
 #if defined(CONFIG_HVF)
     HVFX86EmulatorState *hvf_emul;
 #endif
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index c1cd8c461fe4..8160ab55909a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1191,6 +1191,22 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (has_xsave) {
         env->xsave_buf = qemu_memalign(4096, sizeof(struct kvm_xsave));
     }
+
+    env->nested_state_len = kvm_nested_state_length();
+    if (env->nested_state_len > 0) {
+        uint32_t min_nested_state_len =
+            offsetof(struct kvm_nested_state, size) + sizeof(uint32_t);
+
+        /*
+         * Verify nested state length cover at least the size
+         * field of struct kvm_nested_state
+         */
+        assert(env->nested_state_len >= min_nested_state_len);
+
+        env->nested_state = g_malloc0(env->nested_state_len);
+        env->nested_state->size = env->nested_state_len;
+    }
+
     cpu->kvm_msr_buf = g_malloc0(MSR_BUF_SIZE);
 
     if (!(env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_RDTSCP)) {
@@ -2867,6 +2883,39 @@ static int kvm_get_debugregs(X86CPU *cpu)
     return 0;
 }
 
+static int kvm_put_nested_state(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+
+    if (kvm_nested_state_length() == 0) {
+        return 0;
+    }
+
+    assert(env->nested_state->size <= env->nested_state_len);
+    return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_NESTED_STATE, env->nested_state);
+}
+
+static int kvm_get_nested_state(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+
+    if (kvm_nested_state_length() == 0) {
+        return 0;
+    }
+
+
+    /*
+     * It is possible that migration restored a smaller size into
+     * nested_state->size than what our kernel support.
+     * We preserve migration origin nested_state->size for
+     * call to KVM_SET_NESTED_STATE but wish that our next call
+     * to KVM_GET_NESTED_STATE will use max size our kernel support.
+     */
+    env->nested_state->size = env->nested_state_len;
+
+    return kvm_vcpu_ioctl(CPU(cpu), KVM_GET_NESTED_STATE, env->nested_state);
+}
+
 int kvm_arch_put_registers(CPUState *cpu, int level)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -2874,6 +2923,11 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
+    ret = kvm_put_nested_state(x86_cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     if (level >= KVM_PUT_RESET_STATE) {
         ret = kvm_put_msr_feature_control(x86_cpu);
         if (ret < 0) {
@@ -2989,6 +3043,10 @@ int kvm_arch_get_registers(CPUState *cs)
     if (ret < 0) {
         goto out;
     }
+    ret = kvm_get_nested_state(cpu);
+    if (ret < 0) {
+        goto out;
+    }
     ret = 0;
  out:
     cpu_sync_bndcs_hflags(&cpu->env);
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 084c2c73a8f7..394953de8d1c 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -842,6 +842,43 @@ static const VMStateDescription vmstate_tsc_khz = {
     }
 };
 
+static int nested_state_post_load(void *opaque, int version_id)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    /*
+     * Verify that the size specified in given struct is set
+     * to no more than the size that our kernel support
+     */
+    if (env->nested_state->size > env->nested_state_len) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static bool nested_state_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+    return (env->nested_state_len > 0);
+}
+
+static const VMStateDescription vmstate_nested_state = {
+    .name = "cpu/nested_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = nested_state_post_load,
+    .needed = nested_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_VBUFFER_UINT32(env.nested_state, X86CPU,
+                               0, NULL,
+                               env.nested_state_len),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool mcg_ext_ctl_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -1080,6 +1117,7 @@ VMStateDescription vmstate_x86_cpu = {
         &vmstate_msr_intel_pt,
         &vmstate_msr_virt_ssbd,
         &vmstate_svm_npt,
+        &vmstate_nested_state,
         NULL
     }
 };
-- 
2.16.1
