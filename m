Received: from eggs.gnu.org ([2001:4830:134:3::10]:37136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evTcT-0008Ft-U6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evTcS-0000zM-12
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:00:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evTcR-0000yy-PF
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:00:27 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 17:00:20 -0300
Message-Id: <20180312200022.9760-2-ehabkost@redhat.com>
In-Reply-To: <20180312200022.9760-1-ehabkost@redhat.com>
References: <20180312200022.9760-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] target-i386: add KVM_HINTS_DEDICATED
 performance hint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Wanpeng Li <wanpengli@tencent.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>

From: Wanpeng Li <wanpengli@tencent.com>

Add KVM_HINTS_DEDICATED performance hint, guest checks this feature bit
to determine if they run on dedicated vCPUs, allowing optimizations such
as usage of qspinlocks.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Message-Id: <1518185725-69559-1-git-send-email-wanpengli@tencent.com>
[ehabkost: Renamed property to kvm-hint-dedicated]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h |  3 +++
 target/i386/cpu.c | 14 ++++++++++++++
 target/i386/kvm.c |  4 ++++
 3 files changed, 21 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index faf39ec1ce..8d977ec567 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -471,6 +471,7 @@ typedef enum FeatureWord {
     FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
     FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
+    FEAT_KVM_HINTS,     /* CPUID[4000_0001].EDX */
     FEAT_HYPERV_EAX,    /* CPUID[4000_0003].EAX */
     FEAT_HYPERV_EBX,    /* CPUID[4000_0003].EBX */
     FEAT_HYPERV_EDX,    /* CPUID[4000_0003].EDX */
@@ -666,6 +667,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumul=
ation Single Precision */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
=20
+#define KVM_HINTS_DEDICATED (1U << 0)
+
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Predic=
tion Barrier */
=20
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2c04645cea..5ea1931b7e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -359,6 +359,20 @@ static FeatureWordInfo feature_word_info[FEATURE_WOR=
DS] =3D {
         .cpuid_eax =3D KVM_CPUID_FEATURES, .cpuid_reg =3D R_EAX,
         .tcg_features =3D TCG_KVM_FEATURES,
     },
+    [FEAT_KVM_HINTS] =3D {
+        .feat_names =3D {
+            "kvm-hint-dedicated", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid_eax =3D KVM_CPUID_FEATURES, .cpuid_reg =3D R_EDX,
+        .tcg_features =3D TCG_KVM_FEATURES,
+    },
     [FEAT_HYPERV_EAX] =3D {
         .feat_names =3D {
             NULL /* hv_msr_vp_runtime_access */, NULL /* hv_msr_time_ref=
count_access */,
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ad4b159b28..44ee524188 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -383,6 +383,9 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, ui=
nt32_t function,
         if (!kvm_irqchip_in_kernel()) {
             ret &=3D ~(1U << KVM_FEATURE_PV_UNHALT);
         }
+    } else if (function =3D=3D KVM_CPUID_FEATURES && reg =3D=3D R_EDX) {
+        ret |=3D KVM_HINTS_DEDICATED;
+        found =3D 1;
     }
=20
     /* fallback for older kernels */
@@ -801,6 +804,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         c =3D &cpuid_data.entries[cpuid_i++];
         c->function =3D KVM_CPUID_FEATURES | kvm_base;
         c->eax =3D env->features[FEAT_KVM];
+        c->edx =3D env->features[FEAT_KVM_HINTS];
     }
=20
     cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
--=20
2.14.3
