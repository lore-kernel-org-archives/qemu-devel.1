Received: from eggs.gnu.org ([2001:4830:134:3::10]:37710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95t-0003yJ-KS
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95o-0001cU-Uy
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:49 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:55236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ95o-0001bV-Mo
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:44 -0400
Received: by mail-wm0-x235.google.com with SMTP id i139-v6so4085130wmf.4
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:10:44 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:09:54 +0200
Message-Id: <20180630061040.6018-2-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/47] i386/kvm: add support for Hyper-V TLB
 flush
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

Add support for Hyper-V TLB flush which recently got added to KVM.

Just like regular Hyper-V we announce HV_EX_PROCESSOR_MASKS_RECOMMENDED
regardless of how many vCPUs we have. Windows is 'smart' and uses less
expensive non-EX Hypercall whenever possible (when it wants to flush TLB
for all vCPUs or the maximum vCPU index in the vCPU set requires flushing
is less than 64).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20180610184927.19309-1-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c          |  1 +
 target/i386/cpu.h          |  1 +
 target/i386/hyperv-proto.h |  1 +
 target/i386/kvm.c          | 15 ++++++++++++++-
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1e6a7d0..d57f310 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5415,6 +5415,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("hv-stimer", X86CPU, hyperv_stimer, false),
     DEFINE_PROP_BOOL("hv-frequencies", X86CPU, hyperv_frequencies, false),
     DEFINE_PROP_BOOL("hv-reenlightenment", X86CPU, hyperv_reenlightenment, false),
+    DEFINE_PROP_BOOL("hv-tlbflush", X86CPU, hyperv_tlbflush, false),
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8eaefee..8b1ddfe 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1367,6 +1367,7 @@ struct X86CPU {
     bool hyperv_stimer;
     bool hyperv_frequencies;
     bool hyperv_reenlightenment;
+    bool hyperv_tlbflush;
     bool check_cpuid;
     bool enforce_cpuid;
     bool expose_kvm;
diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
index 93352eb..d6d5a79 100644
--- a/target/i386/hyperv-proto.h
+++ b/target/i386/hyperv-proto.h
@@ -58,6 +58,7 @@
 #define HV_APIC_ACCESS_RECOMMENDED          (1u << 3)
 #define HV_SYSTEM_RESET_RECOMMENDED         (1u << 4)
 #define HV_RELAXED_TIMING_RECOMMENDED       (1u << 5)
+#define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
 
 /*
  * Basic virtualized MSRs
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 032f0ad..ebb2d23 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -601,7 +601,8 @@ static bool hyperv_enabled(X86CPU *cpu)
             cpu->hyperv_runtime ||
             cpu->hyperv_synic ||
             cpu->hyperv_stimer ||
-            cpu->hyperv_reenlightenment);
+            cpu->hyperv_reenlightenment ||
+            cpu->hyperv_tlbflush);
 }
 
 static int kvm_arch_set_tsc_khz(CPUState *cs)
@@ -839,6 +840,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
         if (cpu->hyperv_vapic) {
             c->eax |= HV_APIC_ACCESS_RECOMMENDED;
         }
+        if (cpu->hyperv_tlbflush) {
+            if (kvm_check_extension(cs->kvm_state,
+                                    KVM_CAP_HYPERV_TLBFLUSH) <= 0) {
+                fprintf(stderr, "Hyper-V TLB flush support "
+                        "(requested by 'hv-tlbflush' cpu flag) "
+                        " is not supported by kernel\n");
+                return -ENOSYS;
+            }
+            c->eax |= HV_REMOTE_TLB_FLUSH_RECOMMENDED;
+            c->eax |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
+        }
+
         c->ebx = cpu->hyperv_spinlock_attempts;
 
         c = &cpuid_data.entries[cpuid_i++];
-- 
1.8.3.1
