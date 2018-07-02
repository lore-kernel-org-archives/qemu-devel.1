Received: from eggs.gnu.org ([2001:4830:134:3::10]:44033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fZz5s-0004BY-AD
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fZz5p-00089s-4Q
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:42:16 -0400
Received: from mail-eopbgr00093.outbound.protection.outlook.com
	([40.107.0.93]:20064
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fZz5o-000892-NI
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:42:13 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon,  2 Jul 2018 16:41:56 +0300
Message-Id: <20180702134156.13404-3-rkagan@virtuozzo.com>
In-Reply-To: <20180702134156.13404-1-rkagan@virtuozzo.com>
References: <20180702134156.13404-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] hyperv: ensure VP index equal to QEMU
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liran Alon <liran.alon@oracle.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>

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
---
 target/i386/hyperv.h   |  3 +++
 target/i386/kvm_i386.h |  2 ++
 hw/i386/pc.c           |  5 +++++
 target/i386/hyperv.c   | 10 +++++++++
 target/i386/kvm-stub.c |  5 +++++
 target/i386/kvm.c      | 47 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 72 insertions(+)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index eaf3df34b0..00c9b454bb 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -39,4 +39,7 @@ void kvm_hv_sint_route_destroy(HvSintRoute *sint_route);
 
 int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
 
+uint32_t hyperv_vp_index(X86CPU *cpu);
+X86CPU *hyperv_find_vcpu(uint32_t vp_index);
+
 #endif
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index e5df24cad1..3057ba4f7d 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -63,4 +63,6 @@ void kvm_put_apicbase(X86CPU *cpu, uint64_t value);
 
 bool kvm_enable_x2apic(void);
 bool kvm_has_x2apic_api(void);
+
+bool kvm_hv_vpindex_settable(void);
 #endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f310040351..690e8b7697 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1998,6 +1998,11 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
index 7cc0fbb272..3065d765ed 100644
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
diff --git a/target/i386/kvm-stub.c b/target/i386/kvm-stub.c
index bda4dc2f0c..e7a673e5db 100644
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
index 032f0ad2fc..67c3bedb4c 100644
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
@@ -744,6 +750,37 @@ static int hyperv_handle_properties(CPUState *cs)
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
@@ -1147,6 +1184,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
         has_msr_tsc_aux = false;
     }
 
+    r = hyperv_init_vcpu(cpu);
+    if (r) {
+        goto fail;
+    }
+
     return 0;
 
  fail:
@@ -1338,6 +1380,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     has_pit_state2 = kvm_check_extension(s, KVM_CAP_PIT_STATE2);
 #endif
 
+    hv_vpindex_settable = kvm_check_extension(s, KVM_CAP_HYPERV_VP_INDEX);
+
     ret = kvm_get_supported_msrs(s);
     if (ret < 0) {
         return ret;
@@ -1887,6 +1931,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         if (has_msr_hv_runtime) {
             kvm_msr_entry_add(cpu, HV_X64_MSR_VP_RUNTIME, env->msr_hv_runtime);
         }
+        if (cpu->hyperv_vpindex && hv_vpindex_settable) {
+            kvm_msr_entry_add(cpu, HV_X64_MSR_VP_INDEX, hyperv_vp_index(cpu));
+        }
         if (cpu->hyperv_synic) {
             int j;
 
-- 
2.17.1
