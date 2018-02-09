Received: from eggs.gnu.org ([2001:4830:134:3::10]:55349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ek9eB-00009s-Ii
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ek9eA-00008W-Eb
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:27:27 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:39616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1ek9eA-000081-7o
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:27:26 -0500
Received: by mail-ot0-x241.google.com with SMTP id f18so7870441otf.6
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 06:27:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5100a4b2-0fe4-b6be-5d6f-4b61a23dc870@gnu.org>
References: <1518083060-5881-1-git-send-email-wanpengli@tencent.com>
	<5100a4b2-0fe4-b6be-5d6f-4b61a23dc870@gnu.org>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 9 Feb 2018 22:27:25 +0800
Message-ID: <CANRm+CyNRXfvb0G4Bwo0mVwJryEJp=gYWGWejwGo6jm4t2bahg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Paolo Bonzini <bonzini@gnu.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

2018-02-09 16:41 GMT+08:00 Paolo Bonzini <bonzini@gnu.org>:
> On 08/02/2018 10:44, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> Add PV_DEDICATED hint cpuid feature bit.
>
> Please add a new feature word, since this is not a PV feature but more
> like a performance hint.

Do it in v2.

Regards,
Wanpeng Li

>
> Thanks,
>
> Paolo
>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>>  target/i386/cpu.c | 4 ++++
>>  target/i386/cpu.h | 3 +++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index d70954b..cf48931 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -4076,6 +4076,9 @@ static int x86_cpu_filter_features(X86CPU *cpu)
>>              x86_cpu_get_supported_feature_word(w, false);
>>          uint32_t requested_features =3D env->features[w];
>>          env->features[w] &=3D host_feat;
>> +        if (cpu->pv_dedicated && (w =3D=3D FEAT_KVM)) {
>> +            env->features[w] |=3D CPUID_PV_DEDICATED;
>> +        }
>>          cpu->filtered_features[w] =3D requested_features & ~env->featur=
es[w];
>>          if (cpu->filtered_features[w]) {
>>              rv =3D 1;
>> @@ -4682,6 +4685,7 @@ static Property x86_cpu_properties[] =3D {
>>                       false),
>>      DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, tr=
ue),
>>      DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
>> +    DEFINE_PROP_BOOL("pv-dedicated", X86CPU, pv_dedicated, false),
>>
>>      /*
>>       * From "Requirements for Implementing the Microsoft
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index f91e37d..8000da5 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -672,6 +672,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>>
>>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Predi=
ction Barrier */
>>
>> +#define CPUID_PV_DEDICATED     (1U << 8)
>> +
>>  #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
>>  #define CPUID_XSAVE_XSAVEC     (1U << 1)
>>  #define CPUID_XSAVE_XGETBV1    (1U << 2)
>> @@ -1276,6 +1278,7 @@ struct X86CPU {
>>      bool expose_kvm;
>>      bool expose_tcg;
>>      bool migratable;
>> +    bool pv_dedicated;
>>      bool max_features; /* Enable all supported features automatically *=
/
>>      uint32_t apic_id;
>>
>>
>
