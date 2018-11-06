Received: from eggs.gnu.org ([2001:4830:134:3::10]:47884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1gJvdf-0000g4-3y
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 02:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1gJvdd-0007Cy-28
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 02:19:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:41913)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1gJvdc-00070M-Ng
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 02:19:01 -0500
From: Liu Jingqi <jingqi.liu@intel.com>
Date: Tue,  6 Nov 2018 15:13:27 +0800
Message-Id: <1541488407-17045-3-git-send-email-jingqi.liu@intel.com>
In-Reply-To: <1541488407-17045-1-git-send-email-jingqi.liu@intel.com>
References: <1541488407-17045-1-git-send-email-jingqi.liu@intel.com>
Subject: [Qemu-devel] [PATCH v2 2/2] x86/cpu: Enable MOVDIR64B cpu feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net
Cc: qemu-devel@nongnu.org, tao3.xu@intel.com, Liu Jingqi <jingqi.liu@intel.com>

MOVDIR64B moves 64-bytes as direct-store with 64-bytes write atomicity.
Direct store is implemented by using write combining (WC) for writing
data directly into memory without caching the data.

The bit definition:
CPUID.(EAX=7,ECX=0):ECX[bit 28] MOVDIR64B

The release document ref below link:
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf

Cc: Xu Tao <tao3.xu@intel.com>
Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d9ab68c..32e1551 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1024,7 +1024,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "la57", NULL, NULL, NULL,
             NULL, NULL, "rdpid", NULL,
             NULL, "cldemote", NULL, "movdiri",
-            NULL, NULL, NULL, NULL,
+            "movdir64b", NULL, NULL, NULL,
         },
         .cpuid = {
             .eax = 7,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3debba3..937a3a2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -688,6 +688,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_ECX_RDPID    (1U << 22)
 #define CPUID_7_0_ECX_CLDEMOTE (1U << 25)  /* CLDEMOTE Instruction */
 #define CPUID_7_0_ECX_MOVDIRI  (1U << 27)  /* MOVDIRI Instruction */
+#define CPUID_7_0_ECX_MOVDIR64B (1U << 28) /* MOVDIR64B Instruction */
 
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
-- 
2.7.4
