Received: from eggs.gnu.org ([2001:4830:134:3::10]:42100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1g9ThH-0007OQ-VY
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1g9ThH-0004wy-5T
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:27:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1g9ThG-0004wZ-TS
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:27:35 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Mon,  8 Oct 2018 13:27:26 +0200
Message-Id: <20181008112726.16140-3-vkuznets@redhat.com>
In-Reply-To: <20181008112726.16140-1-vkuznets@redhat.com>
References: <20181008112726.16140-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] i386/kvm: add support for Hyper-V IPI send
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

Hyper-V PV IPI support is merged to KVM, enable the feature in Qemu. When
enabled, this allows Windows guests to send IPIs to other vCPUs with a
single hypercall even when there are >64 vCPUs in the request.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c          |  1 +
 target/i386/cpu.h          |  1 +
 target/i386/hyperv-proto.h |  1 +
 target/i386/kvm.c          | 14 +++++++++++++-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c88876dfe3..32ea041c06 100644
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
index 730c06f80a..caa1544b2e 100644
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
index d6d5a79293..87f36d14e8 100644
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
index dc4047b02f..795aa52938 100644
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
2.17.1
