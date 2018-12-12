Received: from eggs.gnu.org ([2001:4830:134:3::10]:56403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bp@alien8.de>) id 1gXAo7-0005D4-5U
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 15:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bp@alien8.de>) id 1gXAo2-0004FV-NX
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 15:08:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bp@alien8.de>) id 1gXAo2-0003tn-8t
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 15:08:30 -0500
Date: Wed, 12 Dec 2018 21:08:03 +0100
From: Borislav Petkov <bp@alien8.de>
Message-ID: <20181212200803.GG6653@zn.tnic>
References: <20181210184153.GB5482@zn.tnic> <20181210190600.GK4669@habkost.net>
	<20181210194258.GD5482@zn.tnic> <20181210200843.GN4669@habkost.net>
	<20181211103839.GC921@redhat.com>
	<20181211115546.GQ4669@habkost.net>
	<e4d9a943-2de2-34a7-3f52-ee3d64ea889a@redhat.com>
	<20181211153017.GN921@redhat.com> <20181211161440.GG27375@zn.tnic>
	<20181212195235.GX7141@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181212195235.GX7141@habkost.net>
Subject: [Qemu-devel] [PATCH -v2] target-i386: Reenable RDTSCP support on
 Opteron_G[345] CPU models CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Andre Przywara <andre.przywara@arm.com>, kvm ML <kvm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On Wed, Dec 12, 2018 at 05:52:35PM -0200, Eduardo Habkost wrote:
> Why did you remove this entry from PC_COMPAT_2_4?
> 
> We must keep compatibility with old behavior of Opteron_G2 on
> pc-2.4, even if the old behavior was incorrect.

Ok, hunk reverted. v2 below.

Thx.

---
From: Borislav Petkov <bp@suse.de>

The missing functionality was added ~3 years ago with the Linux commit

  46896c73c1a4 ("KVM: svm: add support for RDTSCP")

so reenable RDTSCP support on those CPU models.

Opteron_G2 - being family 15, model 6, doesn't have RDTSCP support
(the real hardware doesn't have it. K8 got RDTSCP support with the NPT
models, i.e., models >= 0x40).

Document the host's minimum required kernel version, while at it.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
v2: Keep Opteron_G2 in PC_COMPAT_2_4 unchanged.

 include/hw/i386/pc.h | 13 +++++++++++++
 qemu-doc.texi        | 13 +++++++++++++
 target/i386/cpu.c    | 11 ++++-------
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 9d29c4b1df2a..236d962d2547 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -296,6 +296,19 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_3_1 \
     HW_COMPAT_3_1 \
+    {\
+        .driver   = "Opteron_G3" "-" TYPE_X86_CPU,\
+        .property = "rdtscp",\
+        .value    = "off",\
+    },{\
+        .driver   = "Opteron_G4" "-" TYPE_X86_CPU,\
+        .property = "rdtscp",\
+        .value    = "off",\
+    },{\
+        .driver   = "Opteron_G5" "-" TYPE_X86_CPU,\
+        .property = "rdtscp",\
+        .value    = "off",\
+    },
 
 #define PC_COMPAT_3_0 \
     HW_COMPAT_3_0 \
diff --git a/qemu-doc.texi b/qemu-doc.texi
index f7ad1dfe4b69..16b955cbf985 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -37,6 +37,7 @@
 * QEMU System emulator for non PC targets::
 * QEMU Guest Agent::
 * QEMU User space emulator::
+* System requirements::
 * Implementation notes::
 * Deprecated features::
 * Supported build platforms::
@@ -2813,6 +2814,18 @@ Act as if the host page size was 'pagesize' bytes
 Run the emulation in single step mode.
 @end table
 
+@node System requirements
+@chapter System requirements
+
+@section KVM kernel module
+
+On x86_64 hosts, the default set of CPU features enabled by the KVM accelerator
+require the host to be running Linux v4.5 or newer.
+
+The OpteronG[345] CPU models require KVM support for RDTSCP, which was
+added with Linux 4.5 which is supported by the major distros. And even
+if RHEL7 has kernel 3.10, KVM there has the required functionality there
+to make it close to a 4.5 or newer kernel.
 
 @include qemu-tech.texi
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f81d35e1f914..a7def11b27cd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2706,7 +2706,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_DE | CPUID_FP87,
         .features[FEAT_1_ECX] =
             CPUID_EXT_CX16 | CPUID_EXT_SSE3,
-        /* Missing: CPUID_EXT2_RDTSCP */
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
         .features[FEAT_8000_0001_ECX] =
@@ -2730,9 +2729,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_ECX] =
             CPUID_EXT_POPCNT | CPUID_EXT_CX16 | CPUID_EXT_MONITOR |
             CPUID_EXT_SSE3,
-        /* Missing: CPUID_EXT2_RDTSCP */
         .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL |
+            CPUID_EXT2_RDTSCP,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A |
             CPUID_EXT3_ABM | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
@@ -2757,10 +2756,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_POPCNT | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
             CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
             CPUID_EXT_SSE3,
-        /* Missing: CPUID_EXT2_RDTSCP */
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
+            CPUID_EXT2_SYSCALL | CPUID_EXT2_RDTSCP,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_FMA4 | CPUID_EXT3_XOP |
             CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
@@ -2788,10 +2786,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_AES | CPUID_EXT_POPCNT | CPUID_EXT_SSE42 |
             CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_FMA |
             CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
-        /* Missing: CPUID_EXT2_RDTSCP */
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
+            CPUID_EXT2_SYSCALL | CPUID_EXT2_RDTSCP,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_TBM | CPUID_EXT3_FMA4 | CPUID_EXT3_XOP |
             CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
-- 
2.19.1

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
