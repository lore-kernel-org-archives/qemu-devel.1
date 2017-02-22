Received: from eggs.gnu.org ([2001:4830:134:3::10]:50198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgf4G-0006qQ-5L
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 17:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgf4E-0002bM-CC
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 17:07:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgf4E-0002ay-5O
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 17:07:22 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51E09C05681B
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 22:07:22 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 22 Feb 2017 19:07:07 -0300
Message-Id: <20170222220709.3707-2-ehabkost@redhat.com>
In-Reply-To: <20170222220709.3707-1-ehabkost@redhat.com>
References: <20170222220709.3707-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] i386: host_vendor_fms() helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com

Helper function for code that needs to check the host CPU
vendor/family/model/stepping values.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Coding style fix (split long lines)
---
 target/i386/cpu.h |  1 +
 target/i386/cpu.c | 29 +++++++++++++++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5f75ab1b15..647435a1d9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1431,6 +1431,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 void cpu_clear_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
+void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
 
 /* helper.c */
 int x86_cpu_handle_mmu_fault(CPUState *cpu, vaddr addr,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7a04e6ff34..a8e4f37e27 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -682,6 +682,25 @@ void host_cpuid(uint32_t function, uint32_t count,
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
@@ -1547,18 +1566,12 @@ static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
-    uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
 
     xcc->kvm_required = true;
     xcc->ordering = 9;
 
-    host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
-    x86_cpu_vendor_words2str(host_cpudef.vendor, ebx, edx, ecx);
-
-    host_cpuid(0x1, 0, &eax, &ebx, &ecx, &edx);
-    host_cpudef.family = ((eax >> 8) & 0x0F) + ((eax >> 20) & 0xFF);
-    host_cpudef.model = ((eax >> 4) & 0x0F) | ((eax & 0xF0000) >> 12);
-    host_cpudef.stepping = eax & 0x0F;
+    host_vendor_fms(host_cpudef.vendor, &host_cpudef.family,
+                    &host_cpudef.model, &host_cpudef.stepping);
 
     cpu_x86_fill_model_id(host_cpudef.model_id);
 
-- 
2.11.0.259.g40922b1
