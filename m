Received: from eggs.gnu.org ([209.51.188.92]:56992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj3KI-0000gW-Tl
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj3KH-0005iN-3E
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:34:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gj3KF-0005fm-3Z
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:34:51 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Jan 2019 12:34:30 -0200
Message-Id: <20190114143432.4771-4-ehabkost@redhat.com>
In-Reply-To: <20190114143432.4771-1-ehabkost@redhat.com>
References: <20190114143432.4771-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] target/i386: Disable MPX support on named
 CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

MPX support is being phased out by Intel; GCC has dropped it, Linux
is also going to do that.  Even though KVM will have special code
to support MPX after the kernel proper stops enabling it in XCR0,
we probably also want to deprecate that in a few years.  As a start,
do not enable it by default for any named CPU model starting with
the 4.0 machine types; this include Skylake, Icelake and Cascadelake.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20181220121100.21554-1-pbonzini@redhat.com>
Reviewed-by: =C2=A0 Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c      |  7 +++++++
 target/i386/cpu.c | 14 +++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5cac33fcb9..73d688f842 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -115,6 +115,13 @@ GlobalProperty pc_compat_3_1[] =3D {
     { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "off" },
     { "Opteron_G4" "-" TYPE_X86_CPU, "rdtscp", "off" },
     { "Opteron_G5" "-" TYPE_X86_CPU, "rdtscp", "off" },
+    { "Skylake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
+    { "Skylake-Client-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
+    { "Skylake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
+    { "Skylake-Server-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
+    { "Cascadelake-Server" "-" TYPE_X86_CPU,  "mpx", "on" },
+    { "Icelake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
+    { "Icelake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
 };
 const size_t pc_compat_3_1_len =3D G_N_ELEMENTS(pc_compat_3_1);
=20
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4cfc0daf97..9d4dccf020 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2326,7 +2326,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP =
|
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX=
 |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX,
+            CPUID_7_0_EBX_SMAP,
         /* Missing: XSAVES (not supported by some Linux versions,
          * including v4.1 to v4.12).
          * KVM doesn't yet expose any XSAVES state save component,
@@ -2373,7 +2373,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP =
|
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX=
 |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX,
+            CPUID_7_0_EBX_SMAP,
         /* Missing: XSAVES (not supported by some Linux versions,
          * including v4.1 to v4.12).
          * KVM doesn't yet expose any XSAVES state save component,
@@ -2418,7 +2418,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP =
|
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX=
 |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLWB =
|
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
@@ -2470,7 +2470,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP =
|
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX=
 |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLWB =
|
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL,
@@ -2520,7 +2520,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP =
|
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX=
 |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLWB =
|
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
@@ -2576,7 +2576,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP =
|
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX=
 |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_INTEL=
_PT,
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_INTEL_PT,
         .features[FEAT_7_0_ECX] =3D
             CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU =
|
             CPUID_7_0_ECX_OSPKE | CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GF=
NI |
@@ -2631,7 +2631,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP =
|
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX=
 |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLWB =
|
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
--=20
2.18.0.rc1.1.g3f1ff2140
