Received: from eggs.gnu.org ([2001:4830:134:3::10]:41231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK9Cq-0003Lq-LC
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK93W-0001PB-60
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:42 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:45471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gK93V-0008M7-Af
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:37 -0500
Received: by mail-wr1-x431.google.com with SMTP id k15-v6so12228472wre.12
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 13:38:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Nov 2018 22:37:48 +0100
Message-Id: <1541540283-45699-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
References: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/17] x86: hv_evmcs CPU flag support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Adds a new CPU flag to enable the Enlightened VMCS KVM feature.
QEMU enables KVM_CAP_HYPERV_ENLIGHTENED_VMCS and gets back the
version to be advertised in lower 16 bits of CPUID.0x4000000A:EAX.

Suggested-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20181022165506.30332-3-vkuznets@redhat.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c          |  1 +
 target/i386/cpu.h          |  1 +
 target/i386/hyperv-proto.h |  2 ++
 target/i386/kvm.c          | 30 ++++++++++++++++++++++++++++--
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index af7e9f0..f81d35e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5732,6 +5732,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("hv-frequencies", X86CPU, hyperv_frequencies, false),
     DEFINE_PROP_BOOL("hv-reenlightenment", X86CPU, hyperv_reenlightenment, false),
     DEFINE_PROP_BOOL("hv-tlbflush", X86CPU, hyperv_tlbflush, false),
+    DEFINE_PROP_BOOL("hv-evmcs", X86CPU, hyperv_evmcs, false),
     DEFINE_PROP_BOOL("hv-ipi", X86CPU, hyperv_ipi, false),
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ad0e0b4..9c52d0c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1391,6 +1391,7 @@ struct X86CPU {
     bool hyperv_frequencies;
     bool hyperv_reenlightenment;
     bool hyperv_tlbflush;
+    bool hyperv_evmcs;
     bool hyperv_ipi;
     bool check_cpuid;
     bool enforce_cpuid;
diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
index 8c572cd..c0272b3 100644
--- a/target/i386/hyperv-proto.h
+++ b/target/i386/hyperv-proto.h
@@ -18,6 +18,7 @@
 #define HV_CPUID_FEATURES                     0x40000003
 #define HV_CPUID_ENLIGHTMENT_INFO             0x40000004
 #define HV_CPUID_IMPLEMENT_LIMITS             0x40000005
+#define HV_CPUID_NESTED_FEATURES              0x4000000A
 #define HV_CPUID_MIN                          0x40000005
 #define HV_CPUID_MAX                          0x4000ffff
 #define HV_HYPERVISOR_PRESENT_BIT             0x80000000
@@ -60,6 +61,7 @@
 #define HV_RELAXED_TIMING_RECOMMENDED       (1u << 5)
 #define HV_CLUSTER_IPI_RECOMMENDED          (1u << 10)
 #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
+#define HV_ENLIGHTENED_VMCS_RECOMMENDED     (1u << 14)
 
 /*
  * Basic virtualized MSRs
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 796a049..f524e7d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -869,6 +869,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     uint32_t unused;
     struct kvm_cpuid_entry2 *c;
     uint32_t signature[3];
+    uint16_t evmcs_version;
     int kvm_base = KVM_CPUID_SIGNATURE;
     int r;
     Error *local_err = NULL;
@@ -912,7 +913,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
             memset(signature, 0, 12);
             memcpy(signature, cpu->hyperv_vendor_id, len);
         }
-        c->eax = HV_CPUID_MIN;
+        c->eax = cpu->hyperv_evmcs ?
+            HV_CPUID_NESTED_FEATURES : HV_CPUID_IMPLEMENT_LIMITS;
         c->ebx = signature[0];
         c->ecx = signature[1];
         c->edx = signature[2];
@@ -970,7 +972,16 @@ int kvm_arch_init_vcpu(CPUState *cs)
             c->eax |= HV_CLUSTER_IPI_RECOMMENDED;
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
@@ -981,6 +992,21 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
         kvm_base = KVM_CPUID_SIGNATURE_NEXT;
         has_msr_hv_hypercall = true;
+
+        if (cpu->hyperv_evmcs) {
+            __u32 function;
+
+            /* Create zeroed 0x40000006..0x40000009 leaves */
+            for (function = HV_CPUID_IMPLEMENT_LIMITS + 1;
+                 function < HV_CPUID_NESTED_FEATURES; function++) {
+                c = &cpuid_data.entries[cpuid_i++];
+                c->function = function;
+            }
+
+            c = &cpuid_data.entries[cpuid_i++];
+            c->function = HV_CPUID_NESTED_FEATURES;
+            c->eax = evmcs_version;
+        }
     }
 
     if (cpu->expose_kvm) {
-- 
1.8.3.1
