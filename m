Received: from eggs.gnu.org ([2001:4830:134:3::10]:48110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyJ-0007JU-FT
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyH-0006LL-BB
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyG-0006CF-9J
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id 185-v6so1627868wmt.2
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:40 +0200
Message-Id: <1539894735-14232-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/48] i386/kvm: add support for Hyper-V IPI send
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

Hyper-V PV IPI support is merged to KVM, enable the feature in Qemu. When
enabled, this allows Windows guests to send IPIs to other vCPUs with a
single hypercall even when there are >64 vCPUs in the request.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20181009130853.6412-3-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c          |  1 +
 target/i386/cpu.h          |  1 +
 target/i386/hyperv-proto.h |  1 +
 target/i386/kvm.c          | 14 +++++++++++++-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c88876d..32ea041 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5564,6 +5564,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("hv-frequencies", X86CPU, hyperv_frequencies, false),
     DEFINE_PROP_BOOL("hv-reenlightenment", X86CPU, hyperv_reenlightenment, false),
     DEFINE_PROP_BOOL("hv-tlbflush", X86CPU, hyperv_tlbflush, false),
+    DEFINE_PROP_BOOL("hv-ipi", X86CPU, hyperv_ipi, false),
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 730c06f..caa1544 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1382,6 +1382,7 @@ struct X86CPU {
     bool hyperv_frequencies;
     bool hyperv_reenlightenment;
     bool hyperv_tlbflush;
+    bool hyperv_ipi;
     bool check_cpuid;
     bool enforce_cpuid;
     bool expose_kvm;
diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
index d6d5a79..87f36d1 100644
--- a/target/i386/hyperv-proto.h
+++ b/target/i386/hyperv-proto.h
@@ -58,6 +58,7 @@
 #define HV_APIC_ACCESS_RECOMMENDED          (1u << 3)
 #define HV_SYSTEM_RESET_RECOMMENDED         (1u << 4)
 #define HV_RELAXED_TIMING_RECOMMENDED       (1u << 5)
+#define HV_CLUSTER_IPI_RECOMMENDED          (1u << 10)
 #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
 
 /*
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 302f420..4e62b5c 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -608,7 +608,8 @@ static bool hyperv_enabled(X86CPU *cpu)
             cpu->hyperv_synic ||
             cpu->hyperv_stimer ||
             cpu->hyperv_reenlightenment ||
-            cpu->hyperv_tlbflush);
+            cpu->hyperv_tlbflush ||
+            cpu->hyperv_ipi);
 }
 
 static int kvm_arch_set_tsc_khz(CPUState *cs)
@@ -888,6 +889,17 @@ int kvm_arch_init_vcpu(CPUState *cs)
             c->eax |= HV_REMOTE_TLB_FLUSH_RECOMMENDED;
             c->eax |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
         }
+        if (cpu->hyperv_ipi) {
+            if (kvm_check_extension(cs->kvm_state,
+                                    KVM_CAP_HYPERV_SEND_IPI) <= 0) {
+                fprintf(stderr, "Hyper-V IPI send support "
+                        "(requested by 'hv-ipi' cpu flag) "
+                        " is not supported by kernel\n");
+                return -ENOSYS;
+            }
+            c->eax |= HV_CLUSTER_IPI_RECOMMENDED;
+            c->eax |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
+        }
 
         c->ebx = cpu->hyperv_spinlock_attempts;
 
-- 
1.8.3.1
