Received: from eggs.gnu.org ([2001:4830:134:3::10]:35090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiRh-0006j1-UT
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiRf-0004T8-8A
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:33 -0400
Received: from mail-ve1eur01on0090.outbound.protection.outlook.com
	([104.47.1.90]:60077
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiRe-0004Si-My
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:31 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:08 +0300
Message-Id: <20170621162424.10462-8-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 07/23] hyperv: ensure VP index equal to QEMU
 cpu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Igor Mammedov <imammedo@redhat.com>

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

This patch also introduces accessor functions to wrap the mapping
between a vCPU and its vp_index.  Besides, a few variables are renamed
to avoid confusion of vp_index with vcpu_id (== apic_id).

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
v1 -> v2:
 - were patches 5, 6 in v1
 - move vp_index initialization to hyperv_init_vcpu
 - check capability before trying to set the msr
 - set the msr on the usual kvm_put_msrs path
 - disable cpu hotplug if msr is not settable

 target/i386/hyperv.h |  5 ++++-
 target/i386/hyperv.c | 16 +++++++++++++---
 target/i386/kvm.c    | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 0c3b562..82f4757 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -32,11 +32,14 @@ struct HvSintRoute {
 
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
 
-HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
+HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
                                       HvSintAckClb sint_ack_clb);
 
 void kvm_hv_sint_route_destroy(HvSintRoute *sint_route);
 
 int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
 
+uint32_t hyperv_vp_index(X86CPU *cpu);
+X86CPU *hyperv_find_vcpu(uint32_t vp_index);
+
 #endif
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 227185c..4f57447 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -16,6 +16,16 @@
 #include "hyperv.h"
 #include "hyperv_proto.h"
 
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
@@ -72,7 +82,7 @@ static void kvm_hv_sint_ack_handler(EventNotifier *notifier)
     }
 }
 
-HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
+HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
                                       HvSintAckClb sint_ack_clb)
 {
     HvSintRoute *sint_route;
@@ -92,7 +102,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
     event_notifier_set_handler(&sint_route->sint_ack_notifier,
                                kvm_hv_sint_ack_handler);
 
-    gsi = kvm_irqchip_add_hv_sint_route(kvm_state, vcpu_id, sint);
+    gsi = kvm_irqchip_add_hv_sint_route(kvm_state, vp_index, sint);
     if (gsi < 0) {
         goto err_gsi;
     }
@@ -105,7 +115,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
     }
     sint_route->gsi = gsi;
     sint_route->sint_ack_clb = sint_ack_clb;
-    sint_route->vcpu_id = vcpu_id;
+    sint_route->vcpu_id = vp_index;
     sint_route->sint = sint;
 
     return sint_route;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 2795b63..9bf7f08 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -86,6 +86,7 @@ static bool has_msr_hv_hypercall;
 static bool has_msr_hv_crash;
 static bool has_msr_hv_reset;
 static bool has_msr_hv_vpindex;
+static bool is_hv_vpindex_settable;
 static bool has_msr_hv_runtime;
 static bool has_msr_hv_synic;
 static bool has_msr_hv_stimer;
@@ -665,6 +666,43 @@ static int hyperv_handle_properties(CPUState *cs)
     return 0;
 }
 
+static int hyperv_init_vcpu(X86CPU *cpu)
+{
+    if (cpu->hyperv_vpindex && !is_hv_vpindex_settable) {
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
+        /*
+         * handling errors from vcpu init at hotplug time is impossible, so
+         * disallow cpu hotplug
+         */
+        MACHINE_GET_CLASS(current_machine)->hot_add_cpu = NULL;
+
+        ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, &msr_data);
+        if (ret < 0) {
+            return ret;
+        }
+        assert(ret == 1);
+
+        if (msr_data.entries[0].data != hyperv_vp_index(cpu)) {
+            fprintf(stderr, "kernel's vp_index != QEMU's vp_index\n");
+            return -ENXIO;
+        }
+    }
+
+    return 0;
+}
+
 static Error *invtsc_mig_blocker;
 
 #define KVM_MAX_CPUID_ENTRIES  100
@@ -1013,6 +1051,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
         has_msr_tsc_aux = false;
     }
 
+    if (hyperv_enabled(cpu)) {
+        r = hyperv_init_vcpu(cpu);
+        if (r) {
+            goto fail;
+        }
+    }
+
     return 0;
 
  fail:
@@ -1204,6 +1249,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     has_pit_state2 = kvm_check_extension(s, KVM_CAP_PIT_STATE2);
 #endif
 
+    is_hv_vpindex_settable = kvm_check_extension(s, KVM_CAP_HYPERV_VP_INDEX);
+
     ret = kvm_get_supported_msrs(s);
     if (ret < 0) {
         return ret;
@@ -1748,6 +1795,10 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         if (has_msr_hv_runtime) {
             kvm_msr_entry_add(cpu, HV_X64_MSR_VP_RUNTIME, env->msr_hv_runtime);
         }
+        if (cpu->hyperv_vpindex && has_msr_hv_vpindex &&
+            is_hv_vpindex_settable) {
+            kvm_msr_entry_add(cpu, HV_X64_MSR_VP_INDEX, hyperv_vp_index(cpu));
+        }
         if (cpu->hyperv_synic) {
             int j;
 
-- 
2.9.4
