Received: from eggs.gnu.org ([2001:4830:134:3::10]:44273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1euTY6-0002OR-JF
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 20:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1euTY5-00028v-CN
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 20:43:50 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1euTY5-00028V-6v
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 20:43:49 -0500
Received: by mail-oi0-x242.google.com with SMTP id c18so8361597oiy.9
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 17:43:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180309141653.GA2871@localhost.localdomain>
References: <1518185725-69559-1-git-send-email-wanpengli@tencent.com>
	<20180309141653.GA2871@localhost.localdomain>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Sat, 10 Mar 2018 09:43:47 +0800
Message-ID: <CANRm+CyB6aziOToWQBxRJg5jVriQT3B7GfGpJT8rgmLDLUVCxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target-i386: add KVM_HINTS_DEDICATED
 performance hint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

2018-03-09 22:16 GMT+08:00 Eduardo Habkost <ehabkost@redhat.com>:
> On Fri, Feb 09, 2018 at 06:15:25AM -0800, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> Add KVM_HINTS_DEDICATED performance hint, guest checks this feature bit
>> to determine if they run on dedicated vCPUs, allowing optimizations such
>> as usage of qspinlocks.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>> v1 -> v2:
>>  * add a new feature word
>>
>>  target/i386/cpu.c | 14 ++++++++++++++
>>  target/i386/cpu.h |  3 +++
>>  target/i386/kvm.c |  4 ++++
>>  3 files changed, 21 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index d70954b..e2974ad 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -358,6 +358,20 @@ static FeatureWordInfo feature_word_info[FEATURE_WO=
RDS] =3D {
>>          .cpuid_eax =3D KVM_CPUID_FEATURES, .cpuid_reg =3D R_EAX,
>>          .tcg_features =3D TCG_KVM_FEATURES,
>>      },
>> +    [FEAT_KVM_HINTS] =3D {
>> +        .feat_names =3D {
>> +            "hint-dedicated", NULL, NULL, NULL,
>
> I suggest naming it "kvm-hint-dedicated", to indicate it's
> KVM-specific.
>
> If there are no objections, I can rename it while applying.

Looks good to me, thanks Eduardo.

Regards,
Wanpeng Li

>
> With the rename:
>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>
>
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +        },
>> +        .cpuid_eax =3D KVM_CPUID_FEATURES, .cpuid_reg =3D R_EDX,
>> +        .tcg_features =3D TCG_KVM_FEATURES,
>> +    },
>>      [FEAT_HYPERV_EAX] =3D {
>>          .feat_names =3D {
>>              NULL /* hv_msr_vp_runtime_access */, NULL /* hv_msr_time_re=
fcount_access */,
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index f91e37d..9f73692 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -475,6 +475,7 @@ typedef enum FeatureWord {
>>      FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
>>      FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
>>      FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
>> +    FEAT_KVM_HINTS,     /* CPUID[4000_0001].EDX */
>>      FEAT_HYPERV_EAX,    /* CPUID[4000_0003].EAX */
>>      FEAT_HYPERV_EBX,    /* CPUID[4000_0003].EBX */
>>      FEAT_HYPERV_EDX,    /* CPUID[4000_0003].EDX */
>> @@ -670,6 +671,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>>  #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumu=
lation Single Precision */
>>  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control *=
/
>>
>> +#define KVM_HINTS_DEDICATED (1U << 0)
>> +
>>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Predi=
ction Barrier */
>>
>>  #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index ad4b159..44ee524 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -383,6 +383,9 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, u=
int32_t function,
>>          if (!kvm_irqchip_in_kernel()) {
>>              ret &=3D ~(1U << KVM_FEATURE_PV_UNHALT);
>>          }
>> +    } else if (function =3D=3D KVM_CPUID_FEATURES && reg =3D=3D R_EDX) =
{
>> +        ret |=3D KVM_HINTS_DEDICATED;
>> +        found =3D 1;
>>      }
>>
>>      /* fallback for older kernels */
>> @@ -801,6 +804,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>          c =3D &cpuid_data.entries[cpuid_i++];
>>          c->function =3D KVM_CPUID_FEATURES | kvm_base;
>>          c->eax =3D env->features[FEAT_KVM];
>> +        c->edx =3D env->features[FEAT_KVM_HINTS];
>>      }
>>
>>      cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
>> --
>> 2.7.4
>>
>
> --
> Eduardo
