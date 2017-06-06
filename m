Received: from eggs.gnu.org ([2001:4830:134:3::10]:47315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5G-0005fb-Mf
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5D-0007Bq-Bd
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:02 -0400
Received: from mail-eopbgr30133.outbound.protection.outlook.com
	([40.107.3.133]:4192
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dIJ5D-00075V-0L
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:19:59 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Jun 2017 21:19:28 +0300
Message-Id: <20170606181948.16238-4-rkagan@virtuozzo.com>
In-Reply-To: <20170606181948.16238-1-rkagan@virtuozzo.com>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 03/23] hyperv: set partition-wide MSRs only on
 first vcpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

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
 target/i386/kvm.c | 20 ++++++++++++--------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9335dcc..7af2cce 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1089,10 +1089,13 @@ typedef struct CPUX86State {
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
index a6debbd..3a80913 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1719,19 +1719,23 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL,
                               env->msr_global_ctrl);
         }
-        if (has_msr_hv_hypercall) {
-            kvm_msr_entry_add(cpu, HV_X64_MSR_GUEST_OS_ID,
-                              env->msr_hv_guest_os_id);
-            kvm_msr_entry_add(cpu, HV_X64_MSR_HYPERCALL,
-                              env->msr_hv_hypercall);
+        /* Sync partition-wide MSRs only on first VCPU to avoid races */
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
2.9.4
