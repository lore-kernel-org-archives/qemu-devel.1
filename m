Received: from eggs.gnu.org ([2001:4830:134:3::10]:48438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyc-0007i7-ES
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyZ-0006ax-7R
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:02 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyY-0006a4-VZ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:59 -0400
Received: by mail-wm1-x343.google.com with SMTP id o17-v6so901194wmh.0
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:58 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:04 +0200
Message-Id: <1539894735-14232-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 37/48] hyperv:synic: split capability testing
 and setting
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

Put a bit more consistency into handling KVM_CAP_HYPERV_SYNIC capability,
by checking its availability and determining the feasibility of hv-synic
property first, and enabling it later.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921082217.29481-2-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b0b42d2..2e5b9f6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -735,8 +735,9 @@ static int hyperv_handle_properties(CPUState *cs)
     }
     if (cpu->hyperv_synic) {
         if (!has_msr_hv_synic ||
-            kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_SYNIC, 0)) {
-            fprintf(stderr, "Hyper-V SynIC is not supported by kernel\n");
+            !kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_SYNIC)) {
+            fprintf(stderr, "Hyper-V SynIC (requested by 'hv-synic' cpu flag) "
+                    "is not supported by kernel\n");
             return -ENOSYS;
         }
 
@@ -754,12 +755,14 @@ static int hyperv_handle_properties(CPUState *cs)
 
 static int hyperv_init_vcpu(X86CPU *cpu)
 {
+    CPUState *cs = CPU(cpu);
+    int ret;
+
     if (cpu->hyperv_vpindex && !hv_vpindex_settable) {
         /*
          * the kernel doesn't support setting vp_index; assert that its value
          * is in sync
          */
-        int ret;
         struct {
             struct kvm_msrs info;
             struct kvm_msr_entry entries[1];
@@ -768,7 +771,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
             .entries[0].index = HV_X64_MSR_VP_INDEX,
         };
 
-        ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, &msr_data);
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_MSRS, &msr_data);
         if (ret < 0) {
             return ret;
         }
@@ -780,6 +783,15 @@ static int hyperv_init_vcpu(X86CPU *cpu)
         }
     }
 
+    if (cpu->hyperv_synic) {
+        ret = kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_SYNIC, 0);
+        if (ret < 0) {
+            error_report("failed to turn on HyperV SynIC in KVM: %s",
+                         strerror(-ret));
+            return ret;
+        }
+    }
+
     return 0;
 }
 
-- 
1.8.3.1
