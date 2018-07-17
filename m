Received: from eggs.gnu.org ([2001:4830:134:3::10]:48463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZI-00059x-GM
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZB-0007DV-Uh
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffRZB-0007D2-Ok
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:05 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Jul 2018 17:06:46 +0200
Message-Id: <1531840015-28804-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
References: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/13] hyperv: ensure VP index equal to QEMU
 cpu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

Hyper-V identifies vCPUs by Virtual Processor (VP) index which can be
queried by the guest via HV_X64_MSR_VP_INDEX msr.  It is defined by the
spec as a sequential number which can't exceed the maximum number of
vCPUs per VM.

It has to be owned by QEMU in order to preserve it across migration.

However, the initial implementation in KVM didn't allow to set this
msr, and KVM used its own notion of VP index.  Fortunately, the way
vCPUs are created in QEMU/KVM makes it likely that the KVM value is
equal to QEMU cpu_index.

So choose cpu_index as the value for vp_index, and push that to KVM on
kernels that support setting the msr.  On older ones that don't, query
the kernel value and assert that it's in sync with QEMU.

Besides, since handling errors from vCPU init at hotplug time is
impossible, disable vCPU hotplug.

This patch also introduces accessor functions to encapsulate the mapping
between a vCPU and its vp_index.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180702134156.13404-3-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c           |  5 +++++
 target/i386/hyperv.c   | 10 ++++++++++
 target/i386/hyperv.h   |  3 +++
 target/i386/kvm-stub.c |  5 +++++
 target/i386/kvm.c      | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm_i386.h |  2 ++
 6 files changed, 72 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 50d5553..83a4444 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1999,6 +1999,11 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     }
     cpu->thread_id = topo.smt_id;
 
+    if (cpu->hyperv_vpindex && !kvm_hv_vpindex_settable()) {
+        error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
+        return;
+    }
+
     cs = CPU(cpu);
     cs->cpu_index = idx;
 
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 7cc0fbb..3065d76 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -16,6 +16,16 @@
 #include "hyperv.h"
 #include "hyperv-proto.h"
 
+uint32_t hyperv_vp_index(X86CPU *cpu)
+{
+    return CPU(cpu)->cpu_index;
+}
+
+X86CPU *hyperv_find_vcpu(uint32_t vp_index)
+{
+    return X86_CPU(qemu_get_cpu(vp_index));
+}
+
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
 {
     CPUX86State *env = &cpu->env;
diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index eaf3df3..00c9b45 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -39,4 +39,7 @@ void kvm_hv_sint_route_destroy(HvSintRoute *sint_route);
 
 int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
 
+uint32_t hyperv_vp_index(X86CPU *cpu);
+X86CPU *hyperv_find_vcpu(uint32_t vp_index);
+
 #endif
diff --git a/target/i386/kvm-stub.c b/target/i386/kvm-stub.c
index bda4dc2..e7a673e 100644
--- a/target/i386/kvm-stub.c
+++ b/target/i386/kvm-stub.c
@@ -40,3 +40,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
     abort();
 }
 #endif
+
+bool kvm_hv_vpindex_settable(void)
+{
+    return false;
+}
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ebb2d23..9313602 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -85,6 +85,7 @@ static bool has_msr_hv_hypercall;
 static bool has_msr_hv_crash;
 static bool has_msr_hv_reset;
 static bool has_msr_hv_vpindex;
+static bool hv_vpindex_settable;
 static bool has_msr_hv_runtime;
 static bool has_msr_hv_synic;
 static bool has_msr_hv_stimer;
@@ -162,6 +163,11 @@ bool kvm_enable_x2apic(void)
              has_x2apic_api);
 }
 
+bool kvm_hv_vpindex_settable(void)
+{
+    return hv_vpindex_settable;
+}
+
 static int kvm_get_tsc(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -745,6 +751,37 @@ static int hyperv_handle_properties(CPUState *cs)
     return 0;
 }
 
+static int hyperv_init_vcpu(X86CPU *cpu)
+{
+    if (cpu->hyperv_vpindex && !hv_vpindex_settable) {
+        /*
+         * the kernel doesn't support setting vp_index; assert that its value
+         * is in sync
+         */
+        int ret;
+        struct {
+            struct kvm_msrs info;
+            struct kvm_msr_entry entries[1];
+        } msr_data = {
+            .info.nmsrs = 1,
+            .entries[0].index = HV_X64_MSR_VP_INDEX,
+        };
+
+        ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, &msr_data);
+        if (ret < 0) {
+            return ret;
+        }
+        assert(ret == 1);
+
+        if (msr_data.entries[0].data != hyperv_vp_index(cpu)) {
+            error_report("kernel's vp_index != QEMU's vp_index");
+            return -ENXIO;
+        }
+    }
+
+    return 0;
+}
+
 static Error *invtsc_mig_blocker;
 
 #define KVM_MAX_CPUID_ENTRIES  100
@@ -1160,6 +1197,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
         has_msr_tsc_aux = false;
     }
 
+    r = hyperv_init_vcpu(cpu);
+    if (r) {
+        goto fail;
+    }
+
     return 0;
 
  fail:
@@ -1351,6 +1393,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     has_pit_state2 = kvm_check_extension(s, KVM_CAP_PIT_STATE2);
 #endif
 
+    hv_vpindex_settable = kvm_check_extension(s, KVM_CAP_HYPERV_VP_INDEX);
+
     ret = kvm_get_supported_msrs(s);
     if (ret < 0) {
         return ret;
@@ -1900,6 +1944,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         if (has_msr_hv_runtime) {
             kvm_msr_entry_add(cpu, HV_X64_MSR_VP_RUNTIME, env->msr_hv_runtime);
         }
+        if (cpu->hyperv_vpindex && hv_vpindex_settable) {
+            kvm_msr_entry_add(cpu, HV_X64_MSR_VP_INDEX, hyperv_vp_index(cpu));
+        }
         if (cpu->hyperv_synic) {
             int j;
 
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index e5df24c..3057ba4 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -63,4 +63,6 @@ void kvm_put_apicbase(X86CPU *cpu, uint64_t value);
 
 bool kvm_enable_x2apic(void);
 bool kvm_has_x2apic_api(void);
+
+bool kvm_hv_vpindex_settable(void);
 #endif
-- 
1.8.3.1
