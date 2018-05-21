Received: from eggs.gnu.org ([2001:4830:134:3::10]:43442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fKssA-0005lt-Se
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fKssA-0000gW-3A
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:01:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fKss9-0000gF-Up
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:01:42 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 21 May 2018 19:01:31 -0300
Message-Id: <20180521220133.17445-2-ehabkost@redhat.com>
In-Reply-To: <20180521220133.17445-1-ehabkost@redhat.com>
References: <20180521220133.17445-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] i386: define the 'ssbd' CPUID feature bit
 (CVE-2018-3639)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

New microcode introduces the "Speculative Store Bypass Disable"
CPUID feature bit. This needs to be exposed to guest OS to allow
them to protect against CVE-2018-3639.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-Id: <20180521215424.13520-2-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 1 +
 target/i386/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8bc54d70bf..f0b68905de 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -685,6 +685,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network I=
nstructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumul=
ation Single Precision */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
+#define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store By=
pass Disable */
=20
 #define KVM_HINTS_DEDICATED (1U << 0)
=20
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e5e66a75d4..a1185b17d1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -805,7 +805,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORD=
S] =3D {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "ssbd",
         },
         .cpuid_eax =3D 7,
         .cpuid_needs_ecx =3D true, .cpuid_ecx =3D 0,
--=20
2.14.3
