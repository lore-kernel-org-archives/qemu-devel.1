Received: from eggs.gnu.org ([2001:4830:134:3::10]:41718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWRRO-0000pw-Sd
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWRRN-0007Gq-OI
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:09:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fWRRN-0007Gj-IZ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:09:49 -0400
Date: Fri, 22 Jun 2018 22:09:48 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180622190936.177827-3-mst@redhat.com>
References: <20180622190936.177827-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622190936.177827-1-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v5 2/2] i386/cpu: make -cpu host support
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org

When guest CPU PM is enabled, and with -cpu host, expose the host CPU
MWAIT leaf in the CPUID so guest can make good PM decisions.

Note: the result is 100% CPU utilization reported by host as host
no longer knows that the CPU is halted.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h |  9 +++++++++
 target/i386/cpu.c | 19 ++++++++++++++-----
 target/i386/kvm.c |  9 +++++++++
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 664504610e..309f804573 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1378,6 +1378,15 @@ struct X86CPU {
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
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 94260412e2..a4fb856d58 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3760,11 +3760,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -4595,6 +4595,15 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
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
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index cf9107be4b..805968d5b7 100644
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
MST
