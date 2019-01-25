Received: from eggs.gnu.org ([209.51.188.92]:56646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzsM-00039o-32
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzsI-0007Qt-6S
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gmzsG-0007Po-H2
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so9920002wrt.11
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 03:42:16 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 25 Jan 2019 12:41:55 +0100
Message-Id: <20190125114155.32062-9-vkuznets@redhat.com>
In-Reply-To: <20190125114155.32062-1-vkuznets@redhat.com>
References: <20190125114155.32062-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 8/8] i386/kvm: add support for Direct Mode
 for Hyper-V synthetic timers
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

Hyper-V on KVM can only use Synthetic timers with Direct Mode (opting for
an interrupt instead of VMBus message). This new capability is only
announced in KVM_GET_SUPPORTED_HV_CPUID.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c          |  1 +
 target/i386/cpu.h          |  1 +
 target/i386/hyperv-proto.h |  1 +
 target/i386/kvm.c          | 15 +++++++++++++++
 4 files changed, 18 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b776be5223..986cbe88dd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5771,6 +5771,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("hv-tlbflush", X86CPU, hyperv_tlbflush, false),
     DEFINE_PROP_BOOL("hv-evmcs", X86CPU, hyperv_evmcs, false),
     DEFINE_PROP_BOOL("hv-ipi", X86CPU, hyperv_ipi, false),
+    DEFINE_PROP_BOOL("hv-stimer-direct", X86CPU, hyperv_stimer_direct, false),
     DEFINE_PROP_BOOL("hv-all", X86CPU, hyperv_all, false),
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9b5c2715cc..9716cd89d7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1397,6 +1397,7 @@ struct X86CPU {
     bool hyperv_tlbflush;
     bool hyperv_evmcs;
     bool hyperv_ipi;
+    bool hyperv_stimer_direct;
     bool hyperv_all;
     bool check_cpuid;
     bool enforce_cpuid;
diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
index c0272b3a01..cffac10b45 100644
--- a/target/i386/hyperv-proto.h
+++ b/target/i386/hyperv-proto.h
@@ -49,6 +49,7 @@
 #define HV_GUEST_IDLE_STATE_AVAILABLE           (1u << 5)
 #define HV_FREQUENCY_MSRS_AVAILABLE             (1u << 8)
 #define HV_GUEST_CRASH_MSR_AVAILABLE            (1u << 10)
+#define HV_STIMER_DIRECT_MODE_AVAILABLE         (1u << 19)
 
 /*
  * HV_CPUID_ENLIGHTMENT_INFO.EAX bits
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 14d74ca9c7..e7d0f4d3fe 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -648,6 +648,7 @@ static bool hyperv_enabled(X86CPU *cpu)
             cpu->hyperv_reenlightenment ||
             cpu->hyperv_tlbflush ||
             cpu->hyperv_ipi ||
+            cpu->hyperv_stimer_direct ||
             cpu->hyperv_all);
 }
 
@@ -823,6 +824,15 @@ static struct {
             {0}
         }
     },
+    {
+        .name = "hv-stimer-direct",
+        .desc = "direct mode timers",
+        .flags = {
+            {.fw = FEAT_HYPERV_EDX,
+             .bits = HV_STIMER_DIRECT_MODE_AVAILABLE},
+            {0}
+        }
+    },
 };
 
 static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
@@ -1169,6 +1179,8 @@ static int hyperv_handle_properties(CPUState *cs,
     r |= hv_cpuid_check_and_set(cs, cpuid, "hv-tlbflush",
                                 &cpu->hyperv_tlbflush);
     r |= hv_cpuid_check_and_set(cs, cpuid, "hv-ipi", &cpu->hyperv_ipi);
+    r |= hv_cpuid_check_and_set(cs, cpuid, "hv-stimer-direct",
+                                &cpu->hyperv_stimer_direct);
 
     /* Dependencies */
     if (cpu->hyperv_synic && !cpu->hyperv_synic_kvm_only &&
@@ -1189,6 +1201,9 @@ static int hyperv_handle_properties(CPUState *cs,
     if (cpu->hyperv_ipi && !cpu->hyperv_vpindex) {
         r |= hv_report_missing_dep(cpu, "hv-ipi", "hv-vpindex");
     }
+    if (cpu->hyperv_stimer_direct && !cpu->hyperv_stimer) {
+        r |= hv_report_missing_dep(cpu, "hv-stimer-direct", "hv-stimer");
+    }
 
     /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
-- 
2.20.1
