Received: from eggs.gnu.org ([2001:4830:134:3::10]:56657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cmPYJ-0005dY-MS
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cmPYF-00066U-Rt
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:46:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cmPYF-00064i-Lz
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:46:07 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 10 Mar 2017 15:45:50 -0300
Message-Id: <20170310184552.1481-2-ehabkost@redhat.com>
In-Reply-To: <20170310184552.1481-1-ehabkost@redhat.com>
References: <20170310184552.1481-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] i386: host_vendor_fms() helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Helper function for code that needs to check the host CPU
vendor/family/model/stepping values.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170309181212.18864-2-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h |  1 +
 target/i386/cpu.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ac2ad6d443..385dcc8fea 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1436,6 +1436,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 void cpu_clear_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
+void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
 
 /* helper.c */
 int x86_cpu_handle_mmu_fault(CPUState *cpu, vaddr addr,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fba92125ab..30ba1bd06b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -688,6 +688,25 @@ void host_cpuid(uint32_t function, uint32_t count,
         *edx = vec[3];
 }
 
+void host_vendor_fms(char *vendor, int *family, int *model, int *stepping)
+{
+    uint32_t eax, ebx, ecx, edx;
+
+    host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
+    x86_cpu_vendor_words2str(vendor, ebx, edx, ecx);
+
+    host_cpuid(0x1, 0, &eax, &ebx, &ecx, &edx);
+    if (family) {
+        *family = ((eax >> 8) & 0x0F) + ((eax >> 20) & 0xFF);
+    }
+    if (model) {
+        *model = ((eax >> 4) & 0x0F) | ((eax & 0xF0000) >> 12);
+    }
+    if (stepping) {
+        *stepping = eax & 0x0F;
+    }
+}
+
 /* CPU class name definitions: */
 
 #define X86_CPU_TYPE_SUFFIX "-" TYPE_X86_CPU
-- 
2.11.0.259.g40922b1
