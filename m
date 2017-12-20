Received: from eggs.gnu.org ([2001:4830:134:3::10]:56199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhy6-0004N8-VZ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhy3-00073B-EQ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:46 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:45257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhy3-00072b-7g
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:43 -0500
Received: by mail-wm0-x244.google.com with SMTP id 9so11255301wme.4
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:43 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:20 +0100
Message-Id: <1513790098-9815-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/46] x86/cpu: Enable new SSE/AVX/AVX512 cpu
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

Intel IceLake cpu has added new cpu features,AVX512_VBMI2/GFNI/
VAES/VPCLMULQDQ/AVX512_VNNI/AVX512_BITALG. Those new cpu features
need expose to guest VM.

The bit definition:
CPUID.(EAX=7,ECX=0):ECX[bit 06] AVX512_VBMI2
CPUID.(EAX=7,ECX=0):ECX[bit 08] GFNI
CPUID.(EAX=7,ECX=0):ECX[bit 09] VAES
CPUID.(EAX=7,ECX=0):ECX[bit 10] VPCLMULQDQ
CPUID.(EAX=7,ECX=0):ECX[bit 11] AVX512_VNNI
CPUID.(EAX=7,ECX=0):ECX[bit 12] AVX512_BITALG

The release document ref below link:
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <1511335676-20797-1-git-send-email-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 6 +++---
 target/i386/cpu.h | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 82603e3..325b52e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -437,9 +437,9 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_7_0_ECX] = {
         .feat_names = {
             NULL, "avx512vbmi", "umip", "pku",
-            "ospke", NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, "avx512-vpopcntdq", NULL,
+            "ospke", NULL, "avx512vbmi2", NULL,
+            "gfni", "vaes", "vpclmulqdq", "avx512vnni",
+            "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
             NULL, NULL, "rdpid", NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b086b15..cdbf8b0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -635,6 +635,12 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_ECX_UMIP     (1U << 2)
 #define CPUID_7_0_ECX_PKU      (1U << 3)
 #define CPUID_7_0_ECX_OSPKE    (1U << 4)
+#define CPUID_7_0_ECX_VBMI2    (1U << 6) /* Additional VBMI Instrs */
+#define CPUID_7_0_ECX_GFNI     (1U << 8)
+#define CPUID_7_0_ECX_VAES     (1U << 9)
+#define CPUID_7_0_ECX_VPCLMULQDQ (1U << 10)
+#define CPUID_7_0_ECX_AVX512VNNI (1U << 11)
+#define CPUID_7_0_ECX_AVX512BITALG (1U << 12)
 #define CPUID_7_0_ECX_AVX512_VPOPCNTDQ (1U << 14) /* POPCNT for vectors of DW/QW */
 #define CPUID_7_0_ECX_LA57     (1U << 16)
 #define CPUID_7_0_ECX_RDPID    (1U << 22)
-- 
1.8.3.1
