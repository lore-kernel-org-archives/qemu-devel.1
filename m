Received: from eggs.gnu.org ([2001:4830:134:3::10]:40617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cTrAf-0004dx-CY
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cTrAb-0002X7-TP
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:25:05 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cTrAb-0002Wc-Id
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:25:01 -0500
Received: by mail-wm0-x22d.google.com with SMTP id c85so246394114wmi.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 06:25:01 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 18 Jan 2017 15:24:17 +0100
Message-Id: <1484749457-87117-1-git-send-email-phil@philjordan.eu>
Subject: [Qemu-devel] [PATCH] x86-KVM: Supply TSC and APIC clock rates to
 guest like VMWare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, Phil Dennis-Jordan <phil@philjordan.eu>

This fixes timekeeping of x86-64 Darwin/OS X/macOS guests when using KVM.

Darwin/OS X/macOS for x86-64 uses the TSC for timekeeping; it normally calibrates this by querying various clock frequency scaling MSRs. Details depend on the exact CPU model detected. The local APIC timer frequency is extracted from (EFI) firmware.

This is problematic in the presence of virtualisation, as the MSRs in question are typically not handled by the hypervisor. VMWare (Fusion) advertises TSC and APIC frequency via a custom 0x40000010 CPUID leaf, in the eax and ebx registers respectively. This is documented at https://lwn.net/Articles/301888/ among other places.

Darwin/OS X/macOS looks for the generic 0x40000000 hypervisor leaf, and if this indicates via eax that leaf 0x40000010 might be available, that is in turn queried for the two frequencies.

This adds a CPU option "vmware-tsc-apic-clocks" to enable the same behaviour when running Qemu with KVM acceleration, if the KVM TSC frequency can be established. The virtualised APIC bus cycle is hardcoded to 1GHz in KVM, so ebx of the CPUID leaf is also hardcoded to this value.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

---
 target/i386/cpu.c |  1 +
 target/i386/cpu.h |  4 ++++
 target/i386/kvm.c | 40 ++++++++++++++++++++++++++++++++--------
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index aba11ae..e5523d4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3677,6 +3677,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
+    DEFINE_PROP_BOOL("vmware-tsc-apic-clocks", X86CPU, vmware_clock_rates, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6c1902b..1d8590b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1213,6 +1213,10 @@ struct X86CPU {
     bool host_features;
     uint32_t apic_id;
 
+    /* Enables publishing of TSC increment and Local APIC bus frequencies to
+     * the guest OS in CPUID page 0x40000010, the same way that VMWare does. */
+    bool vmware_clock_rates;
+
     /* if true the CPUID code directly forward host cache leaves to the guest */
     bool cache_info_passthrough;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 10a9cd8..7830b3a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -778,10 +778,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     if (cpu->expose_kvm) {
+        uint32_t kvm_max_page = KVM_CPUID_FEATURES | kvm_base;
+        if (cpu->vmware_clock_rates && kvm_base == KVM_CPUID_SIGNATURE) {
+            kvm_max_page = MAX(kvm_max_page, KVM_CPUID_SIGNATURE | 0x10);
+        }
         memcpy(signature, "KVMKVMKVM\0\0\0", 12);
         c = &cpuid_data.entries[cpuid_i++];
         c->function = KVM_CPUID_SIGNATURE | kvm_base;
-        c->eax = KVM_CPUID_FEATURES | kvm_base;
+        c->eax = kvm_max_page;
         c->ebx = signature[0];
         c->ecx = signature[1];
         c->edx = signature[2];
@@ -910,7 +914,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
-    cpuid_data.cpuid.nent = cpuid_i;
 
     if (((env->cpuid_version >> 8)&0xF) >= 6
         && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
@@ -973,12 +976,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
         vmstate_x86_cpu.unmigratable = 1;
     }
 
-    cpuid_data.cpuid.padding = 0;
-    r = kvm_vcpu_ioctl(cs, KVM_SET_CPUID2, &cpuid_data);
-    if (r) {
-        return r;
-    }
-
     r = kvm_arch_set_tsc_khz(cs);
     if (r < 0) {
         return r;
@@ -998,6 +995,33 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
+    if (cpu->vmware_clock_rates) {
+        if (cpu->expose_kvm
+            && kvm_base == KVM_CPUID_SIGNATURE
+            && env->tsc_khz != 0) {
+            /* Publish TSC and LAPIC resolution on CPUID page 0x40000010
+             * like VMWare for benefit of Darwin guests. */
+            c = &cpuid_data.entries[cpuid_i++];
+            c->function = KVM_CPUID_SIGNATURE | 0x10;
+            c->eax = env->tsc_khz;
+            /* LAPIC resolution of 1ns (freq: 1GHz) is hardcoded in KVM's
+             * APIC_BUS_CYCLE_NS*/
+            c->ebx = 1000000;
+            c->ecx = c->edx = 0;
+        } else {
+            error_report(
+                "Warning: VMWare-style TSC/LAPIC clock reporting impossible.");
+        }
+    }
+
+    cpuid_data.cpuid.nent = cpuid_i;
+
+    cpuid_data.cpuid.padding = 0;
+    r = kvm_vcpu_ioctl(cs, KVM_SET_CPUID2, &cpuid_data);
+    if (r) {
+        return r;
+    }
+
     if (has_xsave) {
         env->kvm_xsave_buf = qemu_memalign(4096, sizeof(struct kvm_xsave));
     }
-- 
2.3.2 (Apple Git-55)
