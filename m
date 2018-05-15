Received: from eggs.gnu.org ([2001:4830:134:3::10]:34368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apilotti@cloudbasesolutions.com>) id 1fIjnM-0006sJ-Pi
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apilotti@cloudbasesolutions.com>) id 1fIjnI-0000M0-Hp
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:55:52 -0400
Received: from mail.cloudbasesolutions.com ([91.232.152.5]:58990)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apilotti@cloudbasesolutions.com>) id 1fIjnI-0000LN-6e
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:55:48 -0400
From: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Date: Tue, 15 May 2018 23:55:24 +0000
Message-ID: <9ED401B4-3DF6-4BC8-9D38-14C78C9D1A66@cloudbasesolutions.com>
References: <1526384258-3581-1-git-send-email-lpetrut@cloudbasesolutions.com>,
	<b1f9836f-96ee-d782-1882-51c97e21d252@redhat.com>
In-Reply-To: <b1f9836f-96ee-d782-1882-51c97e21d252@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] WHPX Add signature CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "petrutlucian94@gmail.com" <petrutlucian94@gmail.com>, Lucian Petrut <lpetrut@cloudbasesolutions.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Justin Terry <juterry@microsoft.com>, Richard Henderson <rth@twiddle.net>

Hi Paolo,

The main reason for different signatures is to allow guest workloads to be =
aware of the differences between the two platforms (eg VirtIO vs VMBus).

Thanks,

Alessandro

> On 15 May 2018, at 16:44, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>> On 15/05/2018 13:37, petrutlucian94@gmail.com wrote:
>> From: Lucian Petrut <lpetrut@cloudbasesolutions.com>
>>=20
>> Adds the CPUID trap for CPUID 0x40000000, sending the WHPX signature
>> to the guest upon request. This is consistent with other QEMU
>> accelerators (KVM).
>>=20
>> Signed-off-by: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
>> Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
>> Signed-off-by: Lucian Petrut <lpetrut@cloudbasesolutions.com>
>=20
> Is it worth defining a different signature?  Can WHPX implement part of
> the Hyper-V spec, and if so would it be better to return the Hv
> signature ("Hv#1") instead?
>=20
> Thanks,
>=20
> Paolo
>=20
>> ---
>> As opposed to the previous patch, this one will set the result of
>> this specific CPUID leaf when initializing the accelerator so that
>> we avoid a vcpu exit.
>>=20
>> target/i386/whpx-all.c | 23 +++++++++++++++++++++++
>> 1 file changed, 23 insertions(+)
>>=20
>> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
>> index 5843517..c8310de 100644
>> --- a/target/i386/whpx-all.c
>> +++ b/target/i386/whpx-all.c
>> @@ -29,6 +29,8 @@
>> #include <WinHvPlatform.h>
>> #include <WinHvEmulation.h>
>>=20
>> +#define WHPX_CPUID_SIGNATURE 0x40000000
>> +
>> struct whpx_state {
>>     uint64_t mem_quota;
>>     WHV_PARTITION_HANDLE partition;
>> @@ -1342,6 +1344,27 @@ static int whpx_accel_init(MachineState *ms)
>>                                  cpuidExitList,
>>                                  RTL_NUMBER_OF(cpuidExitList) * sizeof(U=
INT32));
>>=20
>> +    UINT32 signature[3] =3D {0};
>> +    memcpy(signature, "WHPXWHPXWHPX", 12);
>> +
>> +    WHV_X64_CPUID_RESULT cpuidResultList[1] =3D {0};
>> +    cpuidResultList[0].Function =3D WHPX_CPUID_SIGNATURE;
>> +    cpuidResultList[0].Eax =3D 0;
>> +    cpuidResultList[0].Ebx =3D signature[0];
>> +    cpuidResultList[0].Ecx =3D signature[1];
>> +    cpuidResultList[0].Edx =3D signature[2];
>> +    hr =3D WHvSetPartitionProperty(whpx->partition,
>> +                                 WHvPartitionPropertyCodeCpuidResultLis=
t,
>> +                                 cpuidResultList,
>> +                                 RTL_NUMBER_OF(cpuidResultList) *
>> +                                    sizeof(WHV_X64_CPUID_RESULT));
>> +    if (FAILED(hr)) {
>> +        error_report("WHPX: Failed to set partition CpuidResultList hr=
=3D%08lx",
>> +                     hr);
>> +        ret =3D -EINVAL;
>> +        goto error;
>> +    }
>> +
>>     if (FAILED(hr)) {
>>         error_report("WHPX: Failed to set partition CpuidExitList hr=3D%=
08lx",
>>                      hr);
>>=20
>=20
