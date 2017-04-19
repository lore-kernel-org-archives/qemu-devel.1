Received: from eggs.gnu.org ([2001:4830:134:3::10]:55127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1d0vgB-0002og-4J
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 15:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1d0vg8-0005o1-2s
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 15:54:19 -0400
Received: from mail-yb0-x243.google.com ([2607:f8b0:4002:c09::243]:36184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1d0vg7-0005ni-VC
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 15:54:16 -0400
Received: by mail-yb0-x243.google.com with SMTP id b2so2121076yba.3
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 12:54:15 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 19 Apr 2017 15:54:12 -0400
Message-Id: <20170419195413.30141-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC PATCH] tcg/i386: Do not display HT warning for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

When we enable hyperthreading (using threads smp argument), we warn
the user if the cpu is an AMD cpu. This does not make sense on TCG and
is also obsolete now that AMD Ryzen support hyperthreading.

Fix this by adding CPUID_HT bit to the TCG features and explicitly
checking this bit in the cpuid.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 target/i386/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 13c0985f11..f34bb5ead7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -202,12 +202,12 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_FEATURES (CPUID_FP87 | CPUID_PSE | CPUID_TSC | CPUID_MSR | \
           CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC | CPUID_SEP | \
           CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV | CPUID_PAT | \
-          CPUID_PSE36 | CPUID_CLFLUSH | CPUID_ACPI | CPUID_MMX | \
+          CPUID_PSE36 | CPUID_CLFLUSH | CPUID_ACPI | CPUID_MMX | CPUID_HT | \
           CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_DE)
           /* partly implemented:
           CPUID_MTRR, CPUID_MCA, CPUID_CLFLUSH (needed for Win64) */
           /* missing:
-          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_HT, CPUID_TM, CPUID_PBE */
+          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_TM, CPUID_PBE */
 #define TCG_EXT_FEATURES (CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | \
           CPUID_EXT_MONITOR | CPUID_EXT_SSSE3 | CPUID_EXT_CX16 | \
           CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_POPCNT | \
@@ -3643,7 +3643,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
 
-    /* Only Intel CPUs support hyperthreading. Even though QEMU fixes this
+    /* Only some CPUs support hyperthreading. Even though QEMU fixes this
      * issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
      * based on inputs (sockets,cores,threads), it is still better to gives
      * users a warning.
@@ -3651,8 +3651,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * NOTE: the following code has to follow qemu_init_vcpu(). Otherwise
      * cs->nr_threads hasn't be populated yet and the checking is incorrect.
      */
-    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned) {
-        error_report("AMD CPU doesn't support hyperthreading. Please configure"
+    if ((env->features[FEAT_1_EDX] & CPUID_HT) && (cs->nr_threads > 1) && !ht_warned) {
+        error_report("This CPU doesn't support hyperthreading. Please configure"
                      " -smp options properly.");
         ht_warned = true;
     }
-- 
2.11.0
