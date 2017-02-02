Received: from eggs.gnu.org ([2001:4830:134:3::10]:58957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cZLkk-0000Gn-C9
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cZLkh-0007QI-Ba
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:05:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cZLkh-0007Pv-2o
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:04:59 -0500
Message-Id: <20170202180400.069973224@redhat.com>
Date: Thu, 02 Feb 2017 15:53:34 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
References: <20170202175332.346975248@redhat.com>
Content-Disposition: inline; filename=qemu-support-allow-freq-hc
Subject: [Qemu-devel] [patch 2/2] kvm: introduce cpu flag to enable cpu
 frequency changes via hypercall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

Guests with DPDK, whose vcpus run isolated on physical CPUs, want
to control the frequency of such physical CPUs.

Introduce a allow-freq-hc CPU flag to enable such hypercalls.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 target/i386/cpu.c      |    1 +
 target/i386/cpu.h      |    6 ++++++
 target/i386/kvm.c      |   29 +++++++++++++++++++++++++++++
 target/i386/kvm_i386.h |    1 +
 4 files changed, 37 insertions(+)

Index: qemu/target/i386/cpu.c
===================================================================
--- qemu.orig/target/i386/cpu.c	2017-01-31 09:18:52.944948296 -0200
+++ qemu/target/i386/cpu.c	2017-01-31 09:47:58.050671578 -0200
@@ -3659,6 +3659,7 @@
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
+    DEFINE_PROP_BOOL("allow-freq-hc", X86CPU, allow_freq_hc, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
Index: qemu/target/i386/cpu.h
===================================================================
--- qemu.orig/target/i386/cpu.h	2017-01-31 09:18:52.944948296 -0200
+++ qemu/target/i386/cpu.h	2017-01-31 09:47:58.051671580 -0200
@@ -1243,6 +1243,12 @@
      */
     bool enable_l3_cache;
 
+    /* Direct frequency hypercalls from guest userspace can be
+     * enabled/disabled via cpu option 'allow_freq_hc=on/off'.
+     * It is disabled by default.
+     */
+    bool allow_freq_hc;
+
     /* Compatibility bits for old machine types: */
     bool enable_cpuid_0xb;
 
Index: qemu/target/i386/kvm.c
===================================================================
--- qemu.orig/target/i386/kvm.c	2017-01-31 09:18:52.944948296 -0200
+++ qemu/target/i386/kvm.c	2017-01-31 10:05:01.546855265 -0200
@@ -163,6 +163,11 @@
              has_x2apic_api);
 }
 
+bool kvm_has_allow_freq_hc(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ALLOW_FREQ_HC);
+}
+
 static int kvm_get_tsc(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -692,6 +697,15 @@
     return 0;
 }
 
+static int kvm_set_vcpu_allow_freq(X86CPU *cpu)
+{
+    struct kvm_vcpu_allow_freq fr;
+
+    fr.enable = 1;
+
+    return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_ALLOW_FREQ_HC, &fr);
+}
+
 static Error *invtsc_mig_blocker;
 
 #define KVM_MAX_CPUID_ENTRIES  100
@@ -1040,6 +1054,21 @@
         has_msr_tsc_aux = false;
     }
 
+    if (cpu->allow_freq_hc) {
+        int ret;
+
+        if (!kvm_has_allow_freq_hc()) {
+            error_report("kvm: allow freq hypercall not supported");
+            return -ENOTSUP;
+        }
+
+        ret = kvm_set_vcpu_allow_freq(cpu);
+        if (ret) {
+            error_report("kvm: kvm_set_allow_freq failure, ret=%d", ret);
+            return ret;
+        }
+    }
+
     return 0;
 
  fail:
Index: qemu/target/i386/kvm_i386.h
===================================================================
--- qemu.orig/target/i386/kvm_i386.h	2017-01-31 09:18:52.944948296 -0200
+++ qemu/target/i386/kvm_i386.h	2017-01-31 09:47:58.052671582 -0200
@@ -21,6 +21,7 @@
 void kvm_synchronize_all_tsc(void);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
+bool kvm_has_allow_freq_hc(void);
 
 int kvm_device_pci_assign(KVMState *s, PCIHostDeviceAddress *dev_addr,
                           uint32_t flags, uint32_t *dev_id);
