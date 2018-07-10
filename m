Received: from eggs.gnu.org ([2001:4830:134:3::10]:50480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fcoTR-0003Cc-3n
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fcoTN-0003yn-W9
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:58:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:51105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fcoTN-0003yN-Lp
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:58:13 -0400
From: Jingqi Liu <jingqi.liu@intel.com>
Date: Tue, 10 Jul 2018 16:57:33 +0800
Message-Id: <1531213054-63327-3-git-send-email-jingqi.liu@intel.com>
In-Reply-To: <1531213054-63327-1-git-send-email-jingqi.liu@intel.com>
References: <1531213054-63327-1-git-send-email-jingqi.liu@intel.com>
Subject: [Qemu-devel] [PATCH 2/3] x86/cpu: Enable MOVDIRI cpu feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, wei.w.wang@intel.com, Jingqi Liu <jingqi.liu@intel.com>

MOVDIRI moves doubleword or quadword from register to memory through
direct store which is implemented by using write combining (WC) for
writing data directly into memory without caching the data.

The bit definition:
CPUID.(EAX=7,ECX=0):ECX[bit 27] MOVDIRI

The release document ref below link:
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf

Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e0d151f..775cfcb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -983,7 +983,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
             NULL, NULL, "rdpid", NULL,
-            NULL, "cldemote", NULL, NULL,
+            NULL, "cldemote", NULL, "movdiri",
             NULL, NULL, NULL, NULL,
         },
         .cpuid_eax = 7,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f651105..d94bf2d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -685,6 +685,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_ECX_LA57     (1U << 16)
 #define CPUID_7_0_ECX_RDPID    (1U << 22)
 #define CPUID_7_0_ECX_CLDEMOTE (1U << 25)  /* CLDEMOTE Instruction */
+#define CPUID_7_0_ECX_MOVDIRI  (1U << 27)  /* MOVDIRI Instruction */
 
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
-- 
1.8.3.1
