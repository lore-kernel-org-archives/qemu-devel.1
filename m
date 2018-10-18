Received: from eggs.gnu.org ([2001:4830:134:3::10]:48444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyc-0007iA-GE
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyb-0006cJ-9G
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:02 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyb-0006bp-2e
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id 189-v6so1576941wmw.2
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:33:00 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:06 +0200
Message-Id: <1539894735-14232-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 39/48] hyperv: only add SynIC in compatible
 configurations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

Certain configurations do not allow SynIC to be used in QEMU.  In
particular,

- when hyperv_vpindex is off, SINT routes can't be used as they refer to
  the destination vCPU by vp_index

- older KVM (which doesn't expose KVM_CAP_HYPERV_SYNIC2) zeroes out
  SynIC message and event pages on every msr load, breaking migration

OTOH in-KVM users of SynIC -- SynIC timers -- do work in those
configurations, and we shouldn't stop the guest from using them.

To cover both scenarios, introduce an X86CPU property that makes CPU
init code to skip creation of the SynIC object (and thus disables any
SynIC use in QEMU) but keeps the KVM part of the SynIC working.
The property is clear by default but is set via compat logic for older
machine types.

As a result, when hv_synic and a modern machine type are specified, QEMU
will refuse to run unless vp_index is on and the kernel is recent
enough.  OTOH with an older machine type QEMU will run fine with
hv_synic=on against an older kernel and/or without vp_index enabled but
will disallow the in-QEMU uses of SynIC (in e.g. VMBus).

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921082217.29481-4-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h |  8 ++++++++
 target/i386/cpu.c    |  2 ++
 target/i386/cpu.h    |  1 +
 target/i386/kvm.c    | 30 ++++++++++++++++++++++--------
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6894f37..dfe6746 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -294,6 +294,14 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+#define PC_COMPAT_3_0 \
+    HW_COMPAT_3_0 \
+    {\
+        .driver   = TYPE_X86_CPU,\
+        .property = "x-hv-synic-kvm-only",\
+        .value    = "on",\
+    }
+
 #define PC_COMPAT_2_12 \
     HW_COMPAT_2_12 \
     {\
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 32ea041..f0d9f7c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5607,6 +5607,8 @@ static Property x86_cpu_properties[] = {
      * to the specific Windows version being used."
      */
     DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
+    DEFINE_PROP_BOOL("x-hv-synic-kvm-only", X86CPU, hyperv_synic_kvm_only,
+                     false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index caa1544..663f3a5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1378,6 +1378,7 @@ struct X86CPU {
     bool hyperv_vpindex;
     bool hyperv_runtime;
     bool hyperv_synic;
+    bool hyperv_synic_kvm_only;
     bool hyperv_stimer;
     bool hyperv_frequencies;
     bool hyperv_reenlightenment;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index cf6270a..7b7a565 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -734,8 +734,18 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |= HV_VP_RUNTIME_AVAILABLE;
     }
     if (cpu->hyperv_synic) {
-        if (!has_msr_hv_synic ||
-            !kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_SYNIC)) {
+        unsigned int cap = KVM_CAP_HYPERV_SYNIC;
+        if (!cpu->hyperv_synic_kvm_only) {
+            if (!cpu->hyperv_vpindex) {
+                fprintf(stderr, "Hyper-V SynIC "
+                        "(requested by 'hv-synic' cpu flag) "
+                        "requires Hyper-V VP_INDEX ('hv-vpindex')\n");
+            return -ENOSYS;
+            }
+            cap = KVM_CAP_HYPERV_SYNIC2;
+        }
+
+        if (!has_msr_hv_synic || !kvm_check_extension(cs->kvm_state, cap)) {
             fprintf(stderr, "Hyper-V SynIC (requested by 'hv-synic' cpu flag) "
                     "is not supported by kernel\n");
             return -ENOSYS;
@@ -784,18 +794,22 @@ static int hyperv_init_vcpu(X86CPU *cpu)
     }
 
     if (cpu->hyperv_synic) {
-        ret = kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_SYNIC, 0);
+        uint32_t synic_cap = cpu->hyperv_synic_kvm_only ?
+            KVM_CAP_HYPERV_SYNIC : KVM_CAP_HYPERV_SYNIC2;
+        ret = kvm_vcpu_enable_cap(cs, synic_cap, 0);
         if (ret < 0) {
             error_report("failed to turn on HyperV SynIC in KVM: %s",
                          strerror(-ret));
             return ret;
         }
 
-        ret = hyperv_x86_synic_add(cpu);
-        if (ret < 0) {
-            error_report("failed to create HyperV SynIC: %s",
-                         strerror(-ret));
-            return ret;
+        if (!cpu->hyperv_synic_kvm_only) {
+            ret = hyperv_x86_synic_add(cpu);
+            if (ret < 0) {
+                error_report("failed to create HyperV SynIC: %s",
+                             strerror(-ret));
+                return ret;
+            }
         }
     }
 
-- 
1.8.3.1
