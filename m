Received: from eggs.gnu.org ([2001:4830:134:3::10]:46112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1er3Io-0002lA-26
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1er3Ij-0004A1-V3
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:05:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38494 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1er3Ij-00049j-QZ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:05:49 -0500
References: <1518185725-69559-1-git-send-email-wanpengli@tencent.com>
	<CANRm+CyaGM+SnFo_iQv2whFb_2p3F3k=pCABzQXBCA9auwqqXQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c4ed1f8b-e3bc-cdeb-aac2-8536ce0c4eea@redhat.com>
Date: Wed, 28 Feb 2018 16:05:46 +0100
MIME-Version: 1.0
In-Reply-To: <CANRm+CyaGM+SnFo_iQv2whFb_2p3F3k=pCABzQXBCA9auwqqXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Wanpeng Li <kernellwp@gmail.com>, kvm <kvm@vger.kernel.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 28/02/2018 13:31, Wanpeng Li wrote:
> Ping,
> 2018-02-09 22:15 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> Add KVM_HINTS_DEDICATED performance hint, guest checks this feature bi=
t
>> to determine if they run on dedicated vCPUs, allowing optimizations su=
ch
>> as usage of qspinlocks.

Eduardo is still on vacation; the patch is okay but the KVM parts are
still in kvm/queue, so I'm just waiting for him (Radim owns the KVM tree
right now).  Feel free to post any patch on top of it.  You can add

Based-on: <1518185725-69559-1-git-send-email-wanpengli@tencent.com>

when you post anything needing KVM_HINTS_DEDICATED, that way patchew can
apply your series and test it correctly.

Thanks,

Paolo

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
>> @@ -358,6 +358,20 @@ static FeatureWordInfo feature_word_info[FEATURE_=
WORDS] =3D {
>>          .cpuid_eax =3D KVM_CPUID_FEATURES, .cpuid_reg =3D R_EAX,
>>          .tcg_features =3D TCG_KVM_FEATURES,
>>      },
>> +    [FEAT_KVM_HINTS] =3D {
>> +        .feat_names =3D {
>> +            "hint-dedicated", NULL, NULL, NULL,
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
>>              NULL /* hv_msr_vp_runtime_access */, NULL /* hv_msr_time_=
refcount_access */,
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index f91e37d..9f73692 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -475,6 +475,7 @@ typedef enum FeatureWord {
>>      FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
>>      FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
>>      FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) =
*/
>> +    FEAT_KVM_HINTS,     /* CPUID[4000_0001].EDX */
>>      FEAT_HYPERV_EAX,    /* CPUID[4000_0003].EAX */
>>      FEAT_HYPERV_EBX,    /* CPUID[4000_0003].EBX */
>>      FEAT_HYPERV_EDX,    /* CPUID[4000_0003].EDX */
>> @@ -670,6 +671,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>>  #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accu=
mulation Single Precision */
>>  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control=
 */
>>
>> +#define KVM_HINTS_DEDICATED (1U << 0)
>> +
>>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Pre=
diction Barrier */
>>
>>  #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index ad4b159..44ee524 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -383,6 +383,9 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s,=
 uint32_t function,
>>          if (!kvm_irqchip_in_kernel()) {
>>              ret &=3D ~(1U << KVM_FEATURE_PV_UNHALT);
>>          }
>> +    } else if (function =3D=3D KVM_CPUID_FEATURES && reg =3D=3D R_EDX=
) {
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
