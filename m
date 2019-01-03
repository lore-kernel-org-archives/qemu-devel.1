Received: from eggs.gnu.org ([208.118.235.92]:39267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gezpr-0005Nu-Rd
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gezpo-0005OB-5C
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:02:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gezpo-0005NZ-0J
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:02:40 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Thu,  3 Jan 2019 11:02:34 +0100
Message-Id: <20190103100234.450-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] i386: Enable NPT and NRIPSAVE for AMD CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>

Modern AMD CPUs support NPT and NRIPSAVE features and KVM exposes these
when present. NRIPSAVE apeared somewhere in Opteron_G3 lifetime (e.g.
QuadCore AMD Opteron 2378 has is but QuadCore AMD Opteron HE 2344 doesn't=
),
NPT was introduced a bit earlier.

Add the FEAT_SVM leaf to Opteron_G4/G5 and EPYC/EPYC-IBPB cpu models.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 677a3bd5fb..eb8f9079a6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2766,6 +2766,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
             CPUID_EXT3_SSE4A | CPUID_EXT3_ABM | CPUID_EXT3_SVM |
             CPUID_EXT3_LAHF_LM,
+        .features[FEAT_SVM] =3D
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
         /* no xsaveopt! */
         .xlevel =3D 0x8000001A,
         .model_id =3D "AMD Opteron 62xx class CPU",
@@ -2797,6 +2799,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
             CPUID_EXT3_SSE4A | CPUID_EXT3_ABM | CPUID_EXT3_SVM |
             CPUID_EXT3_LAHF_LM,
+        .features[FEAT_SVM] =3D
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
         /* no xsaveopt! */
         .xlevel =3D 0x8000001A,
         .model_id =3D "AMD Opteron 63xx class CPU",
@@ -2843,6 +2847,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =3D
             CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =3D
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
         .xlevel =3D 0x8000001E,
         .model_id =3D "AMD EPYC Processor",
         .cache_info =3D &epyc_cache_info,
@@ -2891,6 +2897,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =3D
             CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =3D
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
         .xlevel =3D 0x8000001E,
         .model_id =3D "AMD EPYC Processor (with IBPB)",
         .cache_info =3D &epyc_cache_info,
--=20
2.20.1
