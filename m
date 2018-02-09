Received: from eggs.gnu.org ([2001:4830:134:3::10]:58372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ek7jC-0007mI-5v
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ek7jA-0003OY-SC
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:24:30 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:37387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1ek7jA-0003Ku-Mo
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:24:28 -0500
Received: by mail-oi0-x243.google.com with SMTP id t78so5987871oih.4
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 04:24:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180209114615.GG13981@localhost.localdomain>
References: <1518083060-5881-1-git-send-email-wanpengli@tencent.com>
	<20180208181207.GB13981@localhost.localdomain>
	<fcb084ce-1615-f100-4137-e0fa46098d7b@redhat.com>
	<20180209114615.GG13981@localhost.localdomain>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 9 Feb 2018 20:24:26 +0800
Message-ID: <CANRm+CyJi0r-Gm=ivJDwBhsW1dM5tAhBBx84G+miOQDaF+nLUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target-i386: adds PV_DEDICATED hint CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

2018-02-09 19:46 GMT+08:00 Eduardo Habkost <ehabkost@redhat.com>:
> On Fri, Feb 09, 2018 at 09:41:41AM +0100, Paolo Bonzini wrote:
>> On 08/02/2018 19:12, Eduardo Habkost wrote:
>> > On Thu, Feb 08, 2018 at 05:44:20PM +0800, Wanpeng Li wrote:
>> >> From: Wanpeng Li <wanpengli@tencent.com>
>> >>
>> >> Add PV_DEDICATED hint cpuid feature bit.
>> >>
>> > [...]
>> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> >> index d70954b..cf48931 100644
>> >> --- a/target/i386/cpu.c
>> >> +++ b/target/i386/cpu.c
>> >> @@ -4076,6 +4076,9 @@ static int x86_cpu_filter_features(X86CPU *cpu)
>> >>              x86_cpu_get_supported_feature_word(w, false);
>> >>          uint32_t requested_features = env->features[w];
>> >>          env->features[w] &= host_feat;
>> >> +        if (cpu->pv_dedicated && (w == FEAT_KVM)) {
>> >> +            env->features[w] |= CPUID_PV_DEDICATED;
>> >> +        }
>> >
>> > Why do this trick here instead of just adding "pv-dedicated" to
>> > feature_word_info[FEAT_KVM].feat_names?
>>
>> I think because it can be added independent of KVM_GET_SUPPORTED_CPUID.
>
> If QEMU knows it can be enabled if outside GET_SUPPORTED_CPUID,
> kvm_arch_get_supported_cpuid() can return it as supported.

The guest fails to detect the new cpuid this time.

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d70954b..e2974ad 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -358,6 +358,20 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EAX,
         .tcg_features = TCG_KVM_FEATURES,
     },
+    [FEAT_KVM_HINTS] = {
+        .feat_names = {
+            "hint-dedicated", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EDX,
+        .tcg_features = TCG_KVM_FEATURES,
+    },
     [FEAT_HYPERV_EAX] = {
         .feat_names = {
             NULL /* hv_msr_vp_runtime_access */, NULL /*
hv_msr_time_refcount_access */,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f91e37d..9f73692 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -475,6 +475,7 @@ typedef enum FeatureWord {
     FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
     FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
+    FEAT_KVM_HINTS,     /* CPUID[4000_0001].EDX */
     FEAT_HYPERV_EAX,    /* CPUID[4000_0003].EAX */
     FEAT_HYPERV_EBX,    /* CPUID[4000_0003].EBX */
     FEAT_HYPERV_EDX,    /* CPUID[4000_0003].EDX */
@@ -670,6 +671,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply
Accumulation Single Precision */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */

+#define KVM_HINTS_DEDICATED (1U << 0)
+
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch
Prediction Barrier */

 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ad4b159..a0aad80 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -383,6 +383,9 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s,
uint32_t function,
         if (!kvm_irqchip_in_kernel()) {
             ret &= ~(1U << KVM_FEATURE_PV_UNHALT);
         }
+    } else if (function == KVM_CPUID_FEATURES && reg == R_EDX) {
+        ret |= KVM_HINTS_DEDICATED;
+        found = 1;
     }

     /* fallback for older kernels */


Regards,
Wanpeng Li
