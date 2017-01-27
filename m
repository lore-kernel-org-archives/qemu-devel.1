Received: from eggs.gnu.org ([2001:4830:134:3::10]:55836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cXCIh-0005qV-2M
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 14:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cXCIe-0005zE-AL
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 14:35:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cXCIe-0005w2-2k
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 14:35:08 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 20:35:04 +0100
Message-Id: <20170127193504.32290-2-pbonzini@redhat.com>
In-Reply-To: <20170127193504.32290-1-pbonzini@redhat.com>
References: <20170127193504.32290-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/41] x86-KVM: Supply TSC and APIC clock rates
 to guest like VMWare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>

From: Phil Dennis-Jordan <phil@philjordan.eu>

This fixes timekeeping of x86-64 Darwin/OS X/macOS guests when using KVM.

Darwin/OS X/macOS for x86-64 uses the TSC for timekeeping; it normally calibrates this by querying various clock frequency scaling MSRs. Details depend on the exact CPU model detected. The local APIC timer frequency is extracted from (EFI) firmware.

This is problematic in the presence of virtualisation, as the MSRs in question are typically not handled by the hypervisor. VMWare (Fusion) advertises TSC and APIC frequency via a custom 0x40000010 CPUID leaf, in the eax and ebx registers respectively. This is documented at https://lwn.net/Articles/301888/ among other places.

Darwin/OS X/macOS looks for the generic 0x40000000 hypervisor leaf, and if this indicates via eax that leaf 0x40000010 might be available, that is in turn queried for the two frequencies.

This adds a CPU option "vmware-cpuid-freq" to enable the same behaviour when running Qemu with KVM acceleration, if the KVM TSC frequency can be determined, and it is stable. (invtsc or user-specified) The virtualised APIC bus cycle is hardcoded to 1GHz in KVM, so ebx of the CPUID leaf is also hardcoded to this value.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Message-Id: <1484921496-11257-2-git-send-email-phil@philjordan.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c |  1 +
 target/i386/cpu.h |  4 ++++
 target/i386/kvm.c | 36 ++++++++++++++++++++++++++++++------
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cff23e1..e41375e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3658,6 +3658,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
+    DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 10c5a35..4d788d5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1214,6 +1214,10 @@ struct X86CPU {
     bool host_features;
     uint32_t apic_id;
 
+    /* Enables publishing of TSC increment and Local APIC bus frequencies to
+     * the guest OS in CPUID page 0x40000010, the same way that VMWare does. */
+    bool vmware_cpuid_freq;
+
     /* if true the CPUID code directly forward host cache leaves to the guest */
     bool cache_info_passthrough;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 8e130cc..27fd050 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -982,12 +982,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
-    cpuid_data.cpuid.padding = 0;
-    r = kvm_vcpu_ioctl(cs, KVM_SET_CPUID2, &cpuid_data);
-    if (r) {
-        goto fail;
-    }
-
     r = kvm_arch_set_tsc_khz(cs);
     if (r < 0) {
         goto fail;
@@ -1007,6 +1001,36 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
+    if (cpu->vmware_cpuid_freq
+        /* Guests depend on 0x40000000 to detect this feature, so only expose
+         * it if KVM exposes leaf 0x40000000. (Conflicts with Hyper-V) */
+        && cpu->expose_kvm
+        && kvm_base == KVM_CPUID_SIGNATURE
+        /* TSC clock must be stable and known for this feature. */
+        && ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC)
+            || env->user_tsc_khz != 0)
+        && env->tsc_khz != 0) {
+
+        c = &cpuid_data.entries[cpuid_i++];
+        c->function = KVM_CPUID_SIGNATURE | 0x10;
+        c->eax = env->tsc_khz;
+        /* LAPIC resolution of 1ns (freq: 1GHz) is hardcoded in KVM's
+         * APIC_BUS_CYCLE_NS */
+        c->ebx = 1000000;
+        c->ecx = c->edx = 0;
+
+        c = cpuid_find_entry(&cpuid_data.cpuid, kvm_base, 0);
+        c->eax = MAX(c->eax, KVM_CPUID_SIGNATURE | 0x10);
+    }
+
+    cpuid_data.cpuid.nent = cpuid_i;
+
+    cpuid_data.cpuid.padding = 0;
+    r = kvm_vcpu_ioctl(cs, KVM_SET_CPUID2, &cpuid_data);
+    if (r) {
+        goto fail;
+    }
+
     if (has_xsave) {
         env->kvm_xsave_buf = qemu_memalign(4096, sizeof(struct kvm_xsave));
     }
-- 
2.9.3
