Received: from eggs.gnu.org ([2001:4830:134:3::10]:48465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eHZXd-0000g1-Ly
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:14:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eHZXb-0007bB-Eg
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:14:33 -0500
Received: from mail-eopbgr20115.outbound.protection.outlook.com
	([40.107.2.115]:44320
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eHZXb-0007aQ-7B
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:14:31 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 22 Nov 2017 21:14:16 +0300
Message-Id: <20171122181418.14180-2-rkagan@virtuozzo.com>
In-Reply-To: <20171122181418.14180-1-rkagan@virtuozzo.com>
References: <20171122181418.14180-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] hyperv: set partition-wide MSRs only on
 first vcpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>

From: Evgeny Yakovlev <eyakovlev@virtuozzo.com>

Hyper-V has a notion of partition-wide MSRs.  Those MSRs are read and
written as usual on each VCPU, however the hypervisor maintains a single
global value for all VCPUs.  Thus writing such an MSR from any single
VCPU affects the global value that is read by all other VCPUs.

This leads to an issue during VCPU hotplug: the zero-initialzied values
of those MSRs get synced into KVM and override the global values as has
already been set by the guest.

This change makes the partition-wide MSRs only be synchronized on the
first vcpu.

Signed-off-by: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/cpu.h |  5 ++++-
 target/i386/kvm.c | 23 +++++++++++++++--------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b086b1528b..ea9db80de5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1091,10 +1091,13 @@ typedef struct CPUX86State {
     uint64_t async_pf_en_msr;
     uint64_t pv_eoi_en_msr;
 
+    /* Partition-wide HV MSRs, will be updated only on the first vcpu */
     uint64_t msr_hv_hypercall;
     uint64_t msr_hv_guest_os_id;
-    uint64_t msr_hv_vapic;
     uint64_t msr_hv_tsc;
+
+    /* Per-VCPU HV MSRs */
+    uint64_t msr_hv_vapic;
     uint64_t msr_hv_crash_params[HV_CRASH_PARAMS];
     uint64_t msr_hv_runtime;
     uint64_t msr_hv_synic_control;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b1e32e95d3..563967241b 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1678,19 +1678,26 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL,
                               env->msr_global_ctrl);
         }
-        if (has_msr_hv_hypercall) {
-            kvm_msr_entry_add(cpu, HV_X64_MSR_GUEST_OS_ID,
-                              env->msr_hv_guest_os_id);
-            kvm_msr_entry_add(cpu, HV_X64_MSR_HYPERCALL,
-                              env->msr_hv_hypercall);
+        /*
+         * Hyper-V partition-wide MSRs: to avoid clearing them on cpu hot-add,
+         * only sync them to KVM on the first cpu
+         */
+        if (current_cpu == first_cpu) {
+            if (has_msr_hv_hypercall) {
+                kvm_msr_entry_add(cpu, HV_X64_MSR_GUEST_OS_ID,
+                                  env->msr_hv_guest_os_id);
+                kvm_msr_entry_add(cpu, HV_X64_MSR_HYPERCALL,
+                                  env->msr_hv_hypercall);
+            }
+            if (cpu->hyperv_time) {
+                kvm_msr_entry_add(cpu, HV_X64_MSR_REFERENCE_TSC,
+                                  env->msr_hv_tsc);
+            }
         }
         if (cpu->hyperv_vapic) {
             kvm_msr_entry_add(cpu, HV_X64_MSR_APIC_ASSIST_PAGE,
                               env->msr_hv_vapic);
         }
-        if (cpu->hyperv_time) {
-            kvm_msr_entry_add(cpu, HV_X64_MSR_REFERENCE_TSC, env->msr_hv_tsc);
-        }
         if (has_msr_hv_crash) {
             int j;
 
-- 
2.14.3
