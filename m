Received: from eggs.gnu.org ([2001:4830:134:3::10]:38534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gDSjt-0005QN-4J
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gDSjr-0007sM-Ox
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:14:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gDSjr-0007q9-Gk
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:14:43 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 19 Oct 2018 13:14:32 +0200
Message-Id: <20181019111432.5040-3-vkuznets@redhat.com>
In-Reply-To: <20181019111432.5040-1-vkuznets@redhat.com>
References: <20181019111432.5040-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] x86: hv_evmcs CPU flag support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

Adds a new CPU flag to enable the Enlightened VMCS KVM feature.
QEMU enables KVM_CAP_HYPERV_ENLIGHTENED_VMCS and gets back the
version to be advertised in lower 16 bits of CPUID.0x4000000A:EAX.

Suggested-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c          |  1 +
 target/i386/cpu.h          |  1 +
 target/i386/hyperv-proto.h |  3 +++
 target/i386/kvm.c          | 20 ++++++++++++++++++--
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c88876dfe3..5c0e84fb99 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5564,6 +5564,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("hv-frequencies", X86CPU, hyperv_frequencies, false),
     DEFINE_PROP_BOOL("hv-reenlightenment", X86CPU, hyperv_reenlightenment, false),
     DEFINE_PROP_BOOL("hv-tlbflush", X86CPU, hyperv_tlbflush, false),
+    DEFINE_PROP_BOOL("hv-evmcs", X86CPU, hyperv_evmcs, false),
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 730c06f80a..013d953b57 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1382,6 +1382,7 @@ struct X86CPU {
     bool hyperv_frequencies;
     bool hyperv_reenlightenment;
     bool hyperv_tlbflush;
+    bool hyperv_evmcs;
     bool check_cpuid;
     bool enforce_cpuid;
     bool expose_kvm;
diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
index d6d5a79293..fcb0c416f8 100644
--- a/target/i386/hyperv-proto.h
+++ b/target/i386/hyperv-proto.h
@@ -18,7 +18,9 @@
 #define HV_CPUID_FEATURES                     0x40000003
 #define HV_CPUID_ENLIGHTMENT_INFO             0x40000004
 #define HV_CPUID_IMPLEMENT_LIMITS             0x40000005
+#define HV_CPUID_NESTED_FEATURES              0x4000000A
 #define HV_CPUID_MIN                          0x40000005
+#define HV_CPUID_MIN_NESTED                   0x4000000A
 #define HV_CPUID_MAX                          0x4000ffff
 #define HV_HYPERVISOR_PRESENT_BIT             0x80000000
 
@@ -59,6 +61,7 @@
 #define HV_SYSTEM_RESET_RECOMMENDED         (1u << 4)
 #define HV_RELAXED_TIMING_RECOMMENDED       (1u << 5)
 #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
+#define HV_ENLIGHTENED_VMCS_RECOMMENDED     (1u << 14)
 
 /*
  * Basic virtualized MSRs
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index a46ad102d8..8e383e7197 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -798,6 +798,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     uint32_t unused;
     struct kvm_cpuid_entry2 *c;
     uint32_t signature[3];
+    uint16_t evmcs_version;
     int kvm_base = KVM_CPUID_SIGNATURE;
     int r;
     Error *local_err = NULL;
@@ -841,7 +842,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
             memset(signature, 0, 12);
             memcpy(signature, cpu->hyperv_vendor_id, len);
         }
-        c->eax = HV_CPUID_MIN;
+        c->eax = cpu->hyperv_evmcs ? HV_CPUID_MIN_NESTED : HV_CPUID_MIN;
         c->ebx = signature[0];
         c->ecx = signature[1];
         c->edx = signature[2];
@@ -888,7 +889,16 @@ int kvm_arch_init_vcpu(CPUState *cs)
             c->eax |= HV_REMOTE_TLB_FLUSH_RECOMMENDED;
             c->eax |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
         }
-
+        if (cpu->hyperv_evmcs) {
+            if (kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_ENLIGHTENED_VMCS, 0,
+                                    (uintptr_t)&evmcs_version)) {
+                fprintf(stderr, "Hyper-V Enlightened VMCS "
+                        "(requested by 'hv-evmcs' cpu flag) "
+                        "is not supported by kernel\n");
+                return -ENOSYS;
+            }
+            c->eax |= HV_ENLIGHTENED_VMCS_RECOMMENDED;
+        }
         c->ebx = cpu->hyperv_spinlock_attempts;
 
         c = &cpuid_data.entries[cpuid_i++];
@@ -899,6 +909,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
         kvm_base = KVM_CPUID_SIGNATURE_NEXT;
         has_msr_hv_hypercall = true;
+
+        if (cpu->hyperv_evmcs) {
+            c = &cpuid_data.entries[cpuid_i++];
+            c->function = HV_CPUID_NESTED_FEATURES;
+            c->eax = evmcs_version;
+        }
     }
 
     if (cpu->expose_kvm) {
-- 
2.17.2
