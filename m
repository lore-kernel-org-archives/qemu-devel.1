Received: from eggs.gnu.org ([2001:4830:134:3::10]:40866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSTZ1-00044J-EW
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSTYy-0000Q1-9Y
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:37:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44985)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSTYy-0000Pk-3D
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:37:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 17:37:12 -0300
Message-Id: <20180611203712.12086-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC PATCH] i386: Remove ospke CPUID flag name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

RFC NOTE: Paolo, Richard, as far as I can see, there's no point
in enabling OSPKE in user-mode QEMU.  Do you confirm that?

OSPKE is not a static feature flag: it changes dynamically at
runtime depending on CR4, and it was never configurable: KVM
never returned OSPKE on GET_SUPPORTED_CPUID, and on TCG enables
it automatically if CR4_PKE_MASK is set.

Remove OSPKE from the feature name array so users don't try to
configure it manually.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 94260412e2..f101771ac0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -564,7 +564,8 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_7_0_EBX_HLE, CPUID_7_0_EBX_AVX2,
           CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM,
           CPUID_7_0_EBX_RDSEED */
-#define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_OSPKE | \
+#define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_PKU | \
+          /* CPUID_7_0_ECX_OSPKE is dynamic */ \
           CPUID_7_0_ECX_LA57)
 #define TCG_7_0_EDX_FEATURES 0
 #define TCG_APM_FEATURES 0
@@ -781,7 +782,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_7_0_ECX] = {
         .feat_names = {
             NULL, "avx512vbmi", "umip", "pku",
-            "ospke", NULL, "avx512vbmi2", NULL,
+            NULL /* ospke */, NULL, "avx512vbmi2", NULL,
             "gfni", "vaes", "vpclmulqdq", "avx512vnni",
             "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
-- 
2.18.0.rc1.1.g3f1ff2140
