Received: from eggs.gnu.org ([209.51.188.92]:58910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj3Qv-0006Ly-5I
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj3Qt-00026f-Se
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:41:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gj3Qt-00025m-JF
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:41:43 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Jan 2019 12:34:29 -0200
Message-Id: <20190114143432.4771-3-ehabkost@redhat.com>
In-Reply-To: <20190114143432.4771-1-ehabkost@redhat.com>
References: <20190114143432.4771-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] target-i386: Reenable RDTSCP support on
 Opteron_G[345] CPU models CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Borislav Petkov <bp@suse.de>

From: Borislav Petkov <bp@suse.de>

The missing functionality was added ~3 years ago with the Linux commit

  46896c73c1a4 ("KVM: svm: add support for RDTSCP")

so reenable RDTSCP support on those CPU models.

Opteron_G2 - being family 15, model 6, doesn't have RDTSCP support
(the real hardware doesn't have it. K8 got RDTSCP support with the NPT
models, i.e., models >= 0x40).

Document the host's minimum required kernel version, while at it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Message-ID: <20181212200803.GG6653@zn.tnic>
[ehabkost: moved compat properties code to pc.c]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c      |  3 +++
 target/i386/cpu.c | 11 ++++-------
 qemu-doc.texi     | 13 +++++++++++++
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index fc65049e1d..5cac33fcb9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -112,6 +112,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 
 GlobalProperty pc_compat_3_1[] = {
     { "intel-iommu", "dma-drain", "off" },
+    { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "off" },
+    { "Opteron_G4" "-" TYPE_X86_CPU, "rdtscp", "off" },
+    { "Opteron_G5" "-" TYPE_X86_CPU, "rdtscp", "off" },
 };
 const size_t pc_compat_3_1_len = G_N_ELEMENTS(pc_compat_3_1);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bd005f5374..4cfc0daf97 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2736,7 +2736,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_DE | CPUID_FP87,
         .features[FEAT_1_ECX] =
             CPUID_EXT_CX16 | CPUID_EXT_SSE3,
-        /* Missing: CPUID_EXT2_RDTSCP */
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
         .features[FEAT_8000_0001_ECX] =
@@ -2760,9 +2759,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -2787,10 +2786,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
@@ -2818,10 +2816,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
diff --git a/qemu-doc.texi b/qemu-doc.texi
index f7ad1dfe4b..16b955cbf9 100644
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
 
-- 
2.18.0.rc1.1.g3f1ff2140
