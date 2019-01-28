Received: from eggs.gnu.org ([209.51.188.92]:40856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goCk0-0000on-5j
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goCjz-0002ao-7L
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:38:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1goCjy-0002ZM-Ta
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:38:43 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 28 Jan 2019 17:38:34 -0200
Message-Id: <20190128193834.3823-3-ehabkost@redhat.com>
In-Reply-To: <20190128193834.3823-1-ehabkost@redhat.com>
References: <20190128193834.3823-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] i386: Enable NPT and NRIPSAVE for AMD CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Vitaly Kuznetsov <vkuznets@redhat.com>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Modern AMD CPUs support NPT and NRIPSAVE features and KVM exposes these
when present. NRIPSAVE apeared somewhere in Opteron_G3 lifetime (e.g.
QuadCore AMD Opteron 2378 has is but QuadCore AMD Opteron HE 2344 doesn't),
NPT was introduced a bit earlier.

Add the FEAT_SVM leaf to Opteron_G4/G5 and EPYC/EPYC-IBPB cpu models.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20190121155051.5628-1-vkuznets@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c      | 8 ++++++++
 target/i386/cpu.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 94ac9dee3d..1690b1935f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -114,7 +114,15 @@ GlobalProperty pc_compat_3_1[] = {
     { "intel-iommu", "dma-drain", "off" },
     { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "off" },
     { "Opteron_G4" "-" TYPE_X86_CPU, "rdtscp", "off" },
+    { "Opteron_G4" "-" TYPE_X86_CPU, "npt", "off" },
+    { "Opteron_G4" "-" TYPE_X86_CPU, "nrip-save", "off" },
     { "Opteron_G5" "-" TYPE_X86_CPU, "rdtscp", "off" },
+    { "Opteron_G5" "-" TYPE_X86_CPU, "npt", "off" },
+    { "Opteron_G5" "-" TYPE_X86_CPU, "nrip-save", "off" },
+    { "EPYC" "-" TYPE_X86_CPU, "npt", "off" },
+    { "EPYC" "-" TYPE_X86_CPU, "nrip-save", "off" },
+    { "EPYC-IBPB" "-" TYPE_X86_CPU, "npt", "off" },
+    { "EPYC-IBPB" "-" TYPE_X86_CPU, "nrip-save", "off" },
     { "Skylake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
     { "Skylake-Client-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
     { "Skylake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 43df813327..7483daef58 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2801,6 +2801,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
             CPUID_EXT3_SSE4A | CPUID_EXT3_ABM | CPUID_EXT3_SVM |
             CPUID_EXT3_LAHF_LM,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
         /* no xsaveopt! */
         .xlevel = 0x8000001A,
         .model_id = "AMD Opteron 62xx class CPU",
@@ -2831,6 +2833,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
             CPUID_EXT3_SSE4A | CPUID_EXT3_ABM | CPUID_EXT3_SVM |
             CPUID_EXT3_LAHF_LM,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
         /* no xsaveopt! */
         .xlevel = 0x8000001A,
         .model_id = "AMD Opteron 63xx class CPU",
@@ -2877,6 +2881,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
         .xlevel = 0x8000001E,
         .model_id = "AMD EPYC Processor",
         .cache_info = &epyc_cache_info,
@@ -2925,6 +2931,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
         .xlevel = 0x8000001E,
         .model_id = "AMD EPYC Processor (with IBPB)",
         .cache_info = &epyc_cache_info,
-- 
2.18.0.rc1.1.g3f1ff2140
