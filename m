Received: from eggs.gnu.org ([2001:4830:134:3::10]:53501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gZxAQ-0007Lg-Lk
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gZxAN-0005n8-Hf
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:11:06 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gZxAN-0005mX-AV
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:11:03 -0500
Received: by mail-wm1-x344.google.com with SMTP id b11so1771707wmj.1
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 04:11:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Dec 2018 13:11:00 +0100
Message-Id: <20181220121100.21554-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/i386: Disable MPX support on named CPU
 models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

MPX support is being phased out by Intel; GCC has dropped it, Linux
is also going to do that.  Even though KVM will have special code
to support MPX after the kernel proper stops enabling it in XCR0,
we probably also want to deprecate that in a few years.  As a start,
do not enable it by default for any named CPU model starting with
the 4.0 machine types; this include Skylake, Icelake and Cascadelake.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h | 29 +++++++++++++++++++++++++++++
 target/i386/cpu.c    | 14 +++++++-------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 9d29c4b1df..39619e9c01 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -296,6 +296,35 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_3_1 \
     HW_COMPAT_3_1 \
+    {\
+        .driver   = "Skylake-Client" "-" TYPE_X86_CPU,\
+        .property = "mpx",\
+        .value    = "on",\
+    },{\
+        .driver   = "Skylake-Client-IBRS" "-" TYPE_X86_CPU,\
+        .property = "mpx",\
+        .value    = "on",\
+    },{\
+        .driver   = "Skylake-Server" "-" TYPE_X86_CPU,\
+        .property = "mpx",\
+        .value    = "on",\
+    },{\
+        .driver   = "Skylake-Server-IBRS" "-" TYPE_X86_CPU,\
+        .property = "mpx",\
+        .value    = "on",\
+    },{\
+        .driver   = "Cascadelake-Server" "-" TYPE_X86_CPU,\
+        .property = "mpx",\
+        .value    = "on",\
+    },{\
+        .driver   = "Icelake-Client" "-" TYPE_X86_CPU,\
+        .property = "mpx",\
+        .value    = "on",\
+    },{\
+        .driver   = "Icelake-Server" "-" TYPE_X86_CPU,\
+        .property = "mpx",\
+        .value    = "on",\
+    },
 
 #define PC_COMPAT_3_0 \
     HW_COMPAT_3_0 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 677a3bd5fb..1dc1f569da 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2296,7 +2296,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX,
+            CPUID_7_0_EBX_SMAP,
         /* Missing: XSAVES (not supported by some Linux versions,
          * including v4.1 to v4.12).
          * KVM doesn't yet expose any XSAVES state save component,
@@ -2343,7 +2343,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX,
+            CPUID_7_0_EBX_SMAP,
         /* Missing: XSAVES (not supported by some Linux versions,
          * including v4.1 to v4.12).
          * KVM doesn't yet expose any XSAVES state save component,
@@ -2388,7 +2388,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
@@ -2440,7 +2440,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL,
@@ -2490,7 +2490,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
@@ -2546,7 +2546,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_INTEL_PT,
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_INTEL_PT,
         .features[FEAT_7_0_ECX] =
             CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
             CPUID_7_0_ECX_OSPKE | CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
@@ -2601,7 +2601,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
-- 
2.20.1
