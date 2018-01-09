Received: from eggs.gnu.org ([2001:4830:134:3::10]:57901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bernat@luffy.cx>) id 1eYnuW-0001UX-J8
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 02:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bernat@luffy.cx>) id 1eYnuQ-0007de-TD
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 02:01:24 -0500
Received: from bart.luffy.cx ([78.47.78.131]:51060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bernat@luffy.cx>) id 1eYnuQ-0007cP-J4
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 02:01:18 -0500
From: Vincent Bernat <vincent@bernat.im>
Date: Tue,  9 Jan 2018 08:01:12 +0100
Message-Id: <20180109070112.30806-1-vincent@bernat.im>
Subject: [Qemu-devel] [PATCH x86-next v2] target-i386: add PCID flag to
 Westmere, Sandy Bridge and Ivy Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Vincent Bernat <vincent@bernat.im>

PCID has been introduced in Westmere and, since Linux 3.6
(ad756a1603c5), KVM exposes PCID flag if host has it. Update CPU model
for Westmere, Sandy Bridge and Ivy Bridge accordingly.

Ensure compat 2.11 keeps PCID disabled by default for those models and
document the new requirement for host kernel.

Signed-off-by: Vincent Bernat <vincent@bernat.im>
---
 include/hw/i386/pc.h | 14 +++++++++++++-
 qemu-doc.texi        | 11 +++++++++++
 target/i386/cpu.c    |  7 ++++---
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index bb49165fe0a4..f4ccbfdc4ac2 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -327,6 +327,18 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = "Skylake-Server" "-" TYPE_X86_CPU,\
         .property = "clflushopt",\
         .value    = "off",\
+    },{\
+        .driver   = "Westmere-" TYPE_X86_CPU,\
+        .property = "pcid",\
+        .value    = "off",\
+    },{\
+        .driver   = "SandyBridge-" TYPE_X86_CPU,\
+        .property = "pcid",\
+        .value    = "off",\
+    },{\
+        .driver   = "IvyBridge-" TYPE_X86_CPU,\
+        .property = "pcid",\
+        .value    = "off",\
     },
 
 #define PC_COMPAT_2_10 \
@@ -351,7 +363,7 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = "mch",\
         .property = "extended-tseg-mbytes",\
         .value    = stringify(0),\
-    },\
+    },
 
 #define PC_COMPAT_2_8 \
     HW_COMPAT_2_8 \
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 8d0c809ad5cf..9e1a03181427 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -37,6 +37,7 @@
 * QEMU System emulator for non PC targets::
 * QEMU Guest Agent::
 * QEMU User space emulator::
+* System requirements::
 * Implementation notes::
 * Deprecated features::
 * License::
@@ -2565,6 +2566,16 @@ Act as if the host page size was 'pagesize' bytes
 Run the emulation in single step mode.
 @end table
 
+@node System requirements
+@chapter System requirements
+
+@section KVM kernel module
+
+On x86_64 hosts, the default set of CPU features enabled by the KVM
+accelerator require the host to be running Linux v3.6 or newer. If the
+minimum requirement is not met, the guest will not be runnable,
+depending on the selected CPU model. Older emulated machines, like
+``pc-q35-2.10'', may work with older kernels.
 
 @include qemu-tech.texi
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 65f785c7e739..873c0151ef57 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1081,7 +1081,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_ECX] =
             CPUID_EXT_AES | CPUID_EXT_POPCNT | CPUID_EXT_SSE42 |
             CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 | CPUID_EXT_PCID,
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
         .features[FEAT_8000_0001_ECX] =
@@ -1109,7 +1109,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
             CPUID_EXT_X2APIC | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
             CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
-            CPUID_EXT_SSE3,
+            CPUID_EXT_SSE3 | CPUID_EXT_PCID,
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
             CPUID_EXT2_SYSCALL,
@@ -1140,7 +1140,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
             CPUID_EXT_X2APIC | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
             CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
-            CPUID_EXT_SSE3 | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+            CPUID_EXT_SSE3 | CPUID_EXT_F16C | CPUID_EXT_RDRAND |
+            CPUID_EXT_PCID,
         .features[FEAT_7_0_EBX] =
             CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_SMEP |
             CPUID_7_0_EBX_ERMS,
-- 
2.15.1
