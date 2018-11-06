Received: from eggs.gnu.org ([2001:4830:134:3::10]:47882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1gJvdf-0000fz-3c
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 02:19:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1gJvdc-0007Ba-CG
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 02:19:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:41915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1gJvdc-00076J-1V
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 02:19:00 -0500
From: Liu Jingqi <jingqi.liu@intel.com>
Date: Tue,  6 Nov 2018 15:13:26 +0800
Message-Id: <1541488407-17045-2-git-send-email-jingqi.liu@intel.com>
In-Reply-To: <1541488407-17045-1-git-send-email-jingqi.liu@intel.com>
References: <1541488407-17045-1-git-send-email-jingqi.liu@intel.com>
Subject: [Qemu-devel] [PATCH v2 1/2] x86/cpu: Enable MOVDIRI cpu feature
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

MOVDIRI moves doubleword or quadword from register to memory through
direct store which is implemented by using write combining (WC) for
writing data directly into memory without caching the data.

The bit definition:
CPUID.(EAX=7,ECX=0):ECX[bit 27] MOVDIRI

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
index af7e9f0..d9ab68c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1023,7 +1023,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
             NULL, NULL, "rdpid", NULL,
-            NULL, "cldemote", NULL, NULL,
+            NULL, "cldemote", NULL, "movdiri",
             NULL, NULL, NULL, NULL,
         },
         .cpuid = {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ad0e0b4..3debba3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -687,6 +687,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_ECX_LA57     (1U << 16)
 #define CPUID_7_0_ECX_RDPID    (1U << 22)
 #define CPUID_7_0_ECX_CLDEMOTE (1U << 25)  /* CLDEMOTE Instruction */
+#define CPUID_7_0_ECX_MOVDIRI  (1U << 27)  /* MOVDIRI Instruction */
 
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
-- 
2.7.4
