Received: from eggs.gnu.org ([2001:4830:134:3::10]:38453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB9-0007r2-Cw
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB8-0001Hd-Ar
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:07 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:43333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdB8-0001Di-3Z
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:06 -0400
Received: by mail-wr0-x22b.google.com with SMTP id c5-v6so6682437wrs.10
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:06:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:05:02 +0200
Message-Id: <1530216310-52873-53-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 52/60] i386/cpu: make -cpu host support
 monitor/mwait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

From: "Michael S. Tsirkin" <mst@redhat.com>

When guest CPU PM is enabled, and with -cpu host, expose the host CPU
MWAIT leaf in the CPUID so guest can make good PM decisions.

Note: the result is 100% CPU utilization reported by host as host
no longer knows that the CPU is halted.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180622192148.178309-3-mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 19 ++++++++++++++-----
 target/i386/cpu.h |  9 +++++++++
 target/i386/kvm.c |  9 +++++++++
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e6c2f8a..b54f36a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3959,11 +3959,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     case 5:
-        /* mwait info: needed for Core compatibility */
-        *eax = 0; /* Smallest monitor-line size in bytes */
-        *ebx = 0; /* Largest monitor-line size in bytes */
-        *ecx = CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
-        *edx = 0;
+        /* MONITOR/MWAIT Leaf */
+        *eax = cpu->mwait.eax; /* Smallest monitor-line size in bytes */
+        *ebx = cpu->mwait.ebx; /* Largest monitor-line size in bytes */
+        *ecx = cpu->mwait.ecx; /* flags */
+        *edx = cpu->mwait.edx; /* mwait substates */
         break;
     case 6:
         /* Thermal and Power Leaf */
@@ -4811,6 +4811,15 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         goto out;
     }
 
+    if (xcc->host_cpuid_required && enable_cpu_pm) {
+        host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
+                   &cpu->mwait.ecx, &cpu->mwait.edx);
+        env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
+    }
+    /* mwait extended info: needed for Core compatibility */
+    /* We always wake on interrupt even if host does not have the capability */
+    cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
+
     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
         error_setg(errp, "apic-id property was not initialized properly");
         return;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 16c59b7..8eaefee 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1382,6 +1382,15 @@ struct X86CPU {
     /* if true the CPUID code directly forward host cache leaves to the guest */
     bool cache_info_passthrough;
 
+    /* if true the CPUID code directly forwards
+     * host monitor/mwait leaves to the guest */
+    struct {
+        uint32_t eax;
+        uint32_t ebx;
+        uint32_t ecx;
+        uint32_t edx;
+    } mwait;
+
     /* Features that were filtered out because of missing host capabilities */
     uint32_t filtered_features[FEATURE_WORDS];
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index dc991f6..c5f72d6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -366,6 +366,15 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         if (!kvm_irqchip_in_kernel()) {
             ret &= ~CPUID_EXT_X2APIC;
         }
+
+        if (enable_cpu_pm) {
+            int disable_exits = kvm_check_extension(s,
+                                                    KVM_CAP_X86_DISABLE_EXITS);
+
+            if (disable_exits & KVM_X86_DISABLE_EXITS_MWAIT) {
+                ret |= CPUID_EXT_MONITOR;
+            }
+        }
     } else if (function == 6 && reg == R_EAX) {
         ret |= CPUID_6_EAX_ARAT; /* safe to allow because of emulated APIC */
     } else if (function == 7 && index == 0 && reg == R_EBX) {
-- 
1.8.3.1
