Received: from eggs.gnu.org ([2001:4830:134:3::10]:43367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYw6U-0003HP-Qr
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYw6O-00042g-PJ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:46:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eYw6O-000428-Gz
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:46:12 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  9 Jan 2018 13:45:19 -0200
Message-Id: <20180109154519.25634-8-ehabkost@redhat.com>
In-Reply-To: <20180109154519.25634-1-ehabkost@redhat.com>
References: <20180109154519.25634-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 7/7] [RFC] i386: Add PCID to {Westmere,
 SandyBridge, IvyBridge}-IBRS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vincent Bernat <vincent@bernat.im>, Jiri Denemark <jdenemar@redhat.com>

RFC NOTE: we need to confirm if all
Westmere/SandyBridge/IvyBridge CPUs out there support PCID,
before applying this patch.

RFC NOTE 2: in parallel, we are evaluating the possibility of
enabling PCID on the existing Westmere/SandyBridge/IvyBridge CPU
models, see
https://patchew.org/QEMU/20180108205052.24385-1-vincent@bernat.im/
and
https://patchew.org/QEMU/20180109070112.30806-1-vincent@bernat.im/

PCID was already available on Westmere, SandyBridge and
IvyBridge, but we can't easily add it to the existing CPU models
without breaking libvirt expectations about CPU model runnability
(a runnable CPU model shouldn't become runnable just because of a
machine-type or QEMU upgrade).

However, Westmere-IBRS, SandyBridge-IBRS and IvyBridge-IBRS are
new CPU models, so we can safely add PCID to them.

Note that PCID is not necessary to mitigate Meltdown and/or
Spectre, but it is really helpful to make performance not suffer
when enabling KPTI on guest kernels.

Cc: Jiri Denemark <jdenemar@redhat.com>
Suggested-by: Vincent Bernat <vincent@bernat.im>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9c36f9bd44..ad79fbb111 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1119,6 +1119,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
             CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
             CPUID_DE | CPUID_FP87,
+        /* Missing: CPUID_EXT_PCID */
         .features[FEAT_1_ECX] =
             CPUID_EXT_AES | CPUID_EXT_POPCNT | CPUID_EXT_SSE42 |
             CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
@@ -1148,7 +1149,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_ECX] =
             CPUID_EXT_AES | CPUID_EXT_POPCNT | CPUID_EXT_SSE42 |
             CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 | CPUID_EXT_PCID,
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
         .features[FEAT_8000_0001_ECX] =
@@ -1173,6 +1174,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
             CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
             CPUID_DE | CPUID_FP87,
+        /* Missing: CPUID_EXT_PCID */
         .features[FEAT_1_ECX] =
             CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
             CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
@@ -1209,7 +1211,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
             CPUID_EXT_X2APIC | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
             CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
-            CPUID_EXT_SSE3,
+            CPUID_EXT_SSE3 | CPUID_EXT_PCID,
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
             CPUID_EXT2_SYSCALL,
@@ -1237,6 +1239,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
             CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
             CPUID_DE | CPUID_FP87,
+        /* Missing: CPUID_EXT_PCID */
         .features[FEAT_1_ECX] =
             CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
             CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
@@ -1276,7 +1279,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
             CPUID_EXT_X2APIC | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
             CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
-            CPUID_EXT_SSE3 | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+            CPUID_EXT_SSE3 | CPUID_EXT_F16C | CPUID_EXT_RDRAND | CPUID_EXT_PCID,
         .features[FEAT_7_0_EBX] =
             CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_SMEP |
             CPUID_7_0_EBX_ERMS,
-- 
2.14.3
