Received: from eggs.gnu.org ([2001:4830:134:3::10]:39695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWp2U-00043q-AS
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWp2S-0001kL-Vj
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:53:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWp2S-0001jt-Pt
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:53:56 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 18:53:43 -0200
Message-Id: <20181211205346.11118-2-ehabkost@redhat.com>
In-Reply-To: <20181211205346.11118-1-ehabkost@redhat.com>
References: <20181211205346.11118-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] x86/cpu: Enable MOVDIRI cpu feature
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
Message-Id: <1541488407-17045-2-git-send-email-jingqi.liu@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 1 +
 target/i386/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9c52d0cbeb..b4f03ffd74 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -687,6 +687,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_ECX_LA57     (1U << 16)
 #define CPUID_7_0_ECX_RDPID    (1U << 22)
 #define CPUID_7_0_ECX_CLDEMOTE (1U << 25)  /* CLDEMOTE Instruction */
+#define CPUID_7_0_ECX_MOVDIRI  (1U << 27)  /* MOVDIRI Instruction */
 
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f81d35e1f9..227baea337 100644
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
-- 
2.18.0.rc1.1.g3f1ff2140
