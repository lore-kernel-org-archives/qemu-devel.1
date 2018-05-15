Received: from eggs.gnu.org ([2001:4830:134:3::10]:35601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIhuq-0008Pf-Dz
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIhun-00011Z-9n
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fIhum-00011D-V7
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:25 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 15 May 2018 18:54:31 -0300
Message-Id: <20180515215436.6457-3-ehabkost@redhat.com>
In-Reply-To: <20180515215436.6457-1-ehabkost@redhat.com>
References: <20180515215436.6457-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] x86/cpu: Enable CLDEMOTE(Demote Cache Line)
 cpu feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jingqi Liu <jingqi.liu@intel.com>

From: Jingqi Liu <jingqi.liu@intel.com>

The CLDEMOTE instruction hints to hardware that the cache line that
contains the linear address should be moved("demoted") from
the cache(s) closest to the processor core to a level more distant
from the processor core. This may accelerate subsequent accesses
to the line by other cores in the same coherence domain,
especially if the line was written by the core that demotes the line.

Intel Snow Ridge has added new cpu feature, CLDEMOTE.
The new cpu feature needs to be exposed to guest VM.

The bit definition:
CPUID.(EAX=7,ECX=0):ECX[bit 25] CLDEMOTE

The release document ref below link:
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf

Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
Message-Id: <1525406253-54846-1-git-send-email-jingqi.liu@intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 1 +
 target/i386/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b58b779bff..8fbe1537c1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -680,6 +680,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_ECX_AVX512_VPOPCNTDQ (1U << 14) /* POPCNT for vectors of DW/QW */
 #define CPUID_7_0_ECX_LA57     (1U << 16)
 #define CPUID_7_0_ECX_RDPID    (1U << 22)
+#define CPUID_7_0_ECX_CLDEMOTE (1U << 25)  /* CLDEMOTE Instruction */
 
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 52fd35b6a1..4b39ab5dd4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -494,7 +494,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
             NULL, NULL, "rdpid", NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "cldemote", NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid_eax = 7,
-- 
2.14.3
