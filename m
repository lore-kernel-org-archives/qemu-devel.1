Received: from eggs.gnu.org ([209.51.188.92]:40785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1giu0D-0007hG-0M
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1giu0B-0002f9-LQ
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:15389)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1giu02-0002TQ-3Q
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:25 -0500
From: Like Xu <like.xu@linux.intel.com>
Date: Mon, 14 Jan 2019 20:24:59 +0800
Message-Id: <1547468699-17633-6-git-send-email-like.xu@linux.intel.com>
In-Reply-To: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
References: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v1 5/5] i386: add CPUID.1F to cpuid_data with
 host_cpuid check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: like.xu@intel.com, imammedo@redhat.com, drjones@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

When cs->nr_dies is larger than 1, the CPUID.1F should be generated
and is added to cpuid_data.entries for guest awareness. This patch
provides a return option in kvm_has_cpuid_1f for default choice.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 target/i386/kvm.c      | 34 +++++++++++++++++++++++++++++++++-
 target/i386/kvm_i386.h |  1 +
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 739cf8c..eb0d1ee 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -120,6 +120,17 @@ bool kvm_has_smm(void)
     return kvm_check_extension(kvm_state, KVM_CAP_X86_SMM);
 }
 
+bool kvm_has_cpuid_1f(void)
+{
+    uint32_t eax = 0x1f, ecx = 1, ebx = 0, edx = 0;
+    host_cpuid(0x1f, 0, &eax, &ebx, &ecx, &edx);
+    if (eax != 0) {
+        printf("It's recommended to disable CPUID.1F emulation \
+                                on Intel non-MCP platform.\n");
+    }
+    return true;
+}
+
 bool kvm_has_adjust_clock_stable(void)
 {
     int ret = kvm_check_extension(kvm_state, KVM_CAP_ADJUST_CLOCK);
@@ -1035,7 +1046,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
-
     for (i = 0; i <= limit; i++) {
         if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
             fprintf(stderr, "unsupported level value: 0x%x\n", limit);
@@ -1127,6 +1137,28 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
+    cpu->enable_cpuid_0x1f =  kvm_has_cpuid_1f();
+    if (cs->nr_dies > 1) {
+        i = 0x1f;
+        for (j = 0; ; j++) {
+            c->function = i;
+            c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+            c->index = j;
+            cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            if (i == 0x1f && j == 3) {
+                break;
+            }
+            if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                fprintf(stderr, "cpuid_data is full, no space for "
+                        "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
+                abort();
+            }
+            c = &cpuid_data.entries[cpuid_i++];
+            if (!cpu->enable_cpuid_0x1f)
+                break;
+        }
+    }
+
     if (limit >= 0x0a) {
         uint32_t eax, edx;
 
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index 3057ba4..ef9d41e 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -38,6 +38,7 @@ bool kvm_has_adjust_clock_stable(void);
 void kvm_synchronize_all_tsc(void);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
+bool kvm_has_cpuid_1f(void);
 
 int kvm_device_pci_assign(KVMState *s, PCIHostDeviceAddress *dev_addr,
                           uint32_t flags, uint32_t *dev_id);
-- 
1.8.3.1
