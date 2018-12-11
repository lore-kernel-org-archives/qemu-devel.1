Received: from eggs.gnu.org ([2001:4830:134:3::10]:39736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWp2a-00047U-GE
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWp2X-0001mJ-3b
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:54:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWp2W-0001lz-TN
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:54:01 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 18:53:44 -0200
Message-Id: <20181211205346.11118-3-ehabkost@redhat.com>
In-Reply-To: <20181211205346.11118-1-ehabkost@redhat.com>
References: <20181211205346.11118-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] x86/cpu: Enable MOVDIR64B cpu feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Liu Jingqi <jingqi.liu@intel.com>, Xu Tao <tao3.xu@intel.com>

From: Liu Jingqi <jingqi.liu@intel.com>

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
Message-Id: <1541488407-17045-3-git-send-email-jingqi.liu@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 1 +
 target/i386/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b4f03ffd74..ef41a033c5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -688,6 +688,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_ECX_RDPID    (1U << 22)
 #define CPUID_7_0_ECX_CLDEMOTE (1U << 25)  /* CLDEMOTE Instruction */
 #define CPUID_7_0_ECX_MOVDIRI  (1U << 27)  /* MOVDIRI Instruction */
+#define CPUID_7_0_ECX_MOVDIR64B (1U << 28) /* MOVDIR64B Instruction */
 
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 227baea337..86a934d450 100644
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
-- 
2.18.0.rc1.1.g3f1ff2140
