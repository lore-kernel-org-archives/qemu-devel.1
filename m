Received: from eggs.gnu.org ([2001:4830:134:3::10]:38589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1dv0Ej-0000y5-MX
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1dv0Ed-0007ev-Hq
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:05:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1dv0Ed-0007eY-3P
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:05:39 -0400
Message-Id: <20170921120415.241151389@redhat.com>
Date: Thu, 21 Sep 2017 09:03:43 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
References: <20170921120341.590850215@redhat.com>
Content-Disposition: inline; filename=qemu-toggle-kvmrt-prio
Subject: [Qemu-devel] [patch 2/2] qemu: kvm: support RT_PRIO_HC hypercall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>

Add the following CPU options:

allow-rt-prio-hc: allow guest to execute hypercall to change vcpu 
thread priority.

rt-prio: SCHED_FIFO priority to be used when that hypercall is invoked.

See kernel patchset for details about this hypercall.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 target/i386/cpu.c |    2 ++
 target/i386/cpu.h |    4 ++++
 target/i386/kvm.c |   23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+)

Index: qemu-fifoprio/target/i386/cpu.c
===================================================================
--- qemu-fifoprio.orig/target/i386/cpu.c
+++ qemu-fifoprio/target/i386/cpu.c
@@ -4106,6 +4106,8 @@ static Property x86_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
+    DEFINE_PROP_BOOL("allow-rt-prio-hc", X86CPU, allow_rt_prio_hc, false),
+    DEFINE_PROP_UINT32("rt-prio", X86CPU, rt_prio_hc, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
Index: qemu-fifoprio/target/i386/cpu.h
===================================================================
--- qemu-fifoprio.orig/target/i386/cpu.h
+++ qemu-fifoprio/target/i386/cpu.h
@@ -1215,6 +1215,7 @@ struct X86CPU {
     bool hyperv_runtime;
     bool hyperv_synic;
     bool hyperv_stimer;
+    bool allow_rt_prio_hc;
     bool check_cpuid;
     bool enforce_cpuid;
     bool expose_kvm;
@@ -1270,6 +1271,9 @@ struct X86CPU {
     /* Number of physical address bits supported */
     uint32_t phys_bits;
 
+    /* RT priority of VCPU thread, when hypercall is invoked by guest */
+    uint32_t rt_prio_hc;
+
     /* in order to simplify APIC support, we leave this pointer to the
        user */
     struct DeviceState *apic_state;
Index: qemu-fifoprio/target/i386/kvm.c
===================================================================
--- qemu-fifoprio.orig/target/i386/kvm.c
+++ qemu-fifoprio/target/i386/kvm.c
@@ -673,6 +673,28 @@ static int hyperv_handle_properties(CPUS
 
 static Error *invtsc_mig_blocker;
 
+static int enable_allow_rt_prio_hc(CPUState *cs)
+{
+    int ret;
+    struct kvm_vcpu_rt_prio rt_prio;
+    X86CPU *cpu = X86_CPU(cs);
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_VCPU_RT_PRIO_HC)) {
+        fprintf(stderr, "RT prio hypercall not supported by kernel\n");
+        return -ENOSYS;
+    }
+
+    rt_prio.sched_priority = cpu->rt_prio_hc;
+    rt_prio.enabled = 1;
+
+    ret = kvm_vcpu_ioctl(cs, KVM_ENABLE_VCPU_RT_PRIO_HC, &rt_prio);
+    if (ret) {
+        fprintf(stderr, "RT prio hypercall failed, ret=%d\n", ret);
+    }
+
+    return ret;
+}
+
 #define KVM_MAX_CPUID_ENTRIES  100
 
 int kvm_arch_init_vcpu(CPUState *cs)
@@ -758,6 +780,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
         has_msr_hv_hypercall = true;
     }
 
+    if (cpu->allow_rt_prio_hc) {
+        if (enable_allow_rt_prio_hc(cs)) {
+            abort();
+        }
+    }
+
     if (cpu->expose_kvm) {
         memcpy(signature, "KVMKVMKVM\0\0\0", 12);
         c = &cpuid_data.entries[cpuid_i++];
