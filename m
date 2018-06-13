Received: from eggs.gnu.org ([2001:4830:134:3::10]:50506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fSvMs-0002jV-SR
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fSvMo-0006rq-Jg
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:18:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fSvMo-0006rX-DR
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:18:34 -0400
References: <267f42a5-b7ce-379e-ffd1-f2611393d2ff@web.de>
	<ad56487b-5afe-1420-9903-d5d849f97231@siemens.com>
	<CAFEAcA9V9nFMVixeYjfBj54OT3zhRCVHM495AZHDzxVryh4JFA@mail.gmail.com>
	<6730e270-9906-a43c-68b0-7a09a0743fa5@siemens.com>
	<d64ace8c-30ca-e16c-fd73-746476bf3a6b@siemens.com>
	<7bb24572-0fc1-00de-3552-aca1111059ed@amsat.org>
	<63ee188e-0c66-ce7e-03b2-fd58e4da9116@siemens.com>
	<3a128f8d-46a3-591f-ee09-8c9a3f2401ea@amsat.org>
	<aebcbcd5-f0ab-5f9b-4a9d-3ff9dd94ee4f@siemens.com>
	<e4b86268-ee3a-0f41-d382-5b6c806f9e25@amsat.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3608e071-f66b-9ee5-3896-8562daa9b483@redhat.com>
Date: Wed, 13 Jun 2018 10:18:26 +0800
MIME-Version: 1.0
In-Reply-To: <e4b86268-ee3a-0f41-d382-5b6c806f9e25@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] e1000e: Do not auto-clear ICR bits which
 aren't set in EIAC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Jan Kiszka <jan.kiszka@siemens.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>



On 2018=E5=B9=B406=E6=9C=8813=E6=97=A5 03:00, Philippe Mathieu-Daud=C3=A9=
 wrote:
> Cc'ing Jason who is also listed as co-maintainer:
>
>    ./scripts/get_maintainer.pl -f hw/net/e1000e_core.c
>    Dmitry Fleytman <dmitry.fleytman@gmail.com> (maintainer:e1000e)
>    Jason Wang <jasowang@redhat.com> (odd fixer:Network devices)
>
> On 06/12/2018 03:43 PM, Jan Kiszka wrote:
>> On 2018-06-12 20:38, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 06/12/2018 03:30 PM, Jan Kiszka wrote:
>>>> On 2018-06-12 20:11, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> Hi Jan,
>>>>>
>>>>> On 06/12/2018 02:22 PM, Jan Kiszka wrote:
>>>>>> On 2018-05-22 09:00, Jan Kiszka wrote:
>>>>>>> On 2018-04-16 17:29, Peter Maydell wrote:
>>>>>>>> On 16 April 2018 at 16:25, Jan Kiszka <jan.kiszka@siemens.com> w=
rote:
>>>>>>>>> On 2018-04-01 23:17, Jan Kiszka wrote:
>>>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>>
>>>>>>>>>> The spec does not justify clearing of any E1000_ICR_OTHER_CAUS=
ES when
>>>>>>>>>> E1000_ICR_OTHER is set in EIAC. In fact, removing this code fi=
xes the
>>>>>>>>>> issue the Linux driver runs into since 4aea7a5c5e94 ("e1000e: =
Avoid
>>>>>>>>>> receiver overrun interrupt bursts") and was worked around by
>>>>>>>>>> 745d0bd3af99 ("e1000e: Remove Other from EIAC").
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> This resolves the issue I reported on February 18 ("e1000e: MS=
I-X
>>>>>>>>>> problem with recent Linux drivers").
>>>>>>>>>>
>>>>>>>>>>   hw/net/e1000e_core.c | 4 ----
>>>>>>>>>>   1 file changed, 4 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>>>>>>>>>> index ecf9b15555..d38f025c0f 100644
>>>>>>>>>> --- a/hw/net/e1000e_core.c
>>>>>>>>>> +++ b/hw/net/e1000e_core.c
>>>>>>>>>> @@ -2022,10 +2022,6 @@ e1000e_msix_notify_one(E1000ECore *core=
, uint32_t cause, uint32_t int_cfg)
>>>>>>>>>>
>>>>>>>>>>       effective_eiac =3D core->mac[EIAC] & cause;
>>>>>>>>>>
>>>>>>>>>> -    if (effective_eiac =3D=3D E1000_ICR_OTHER) {
>>>>>>>>>> -        effective_eiac |=3D E1000_ICR_OTHER_CAUSES;
>>>>>>>>>> -    }
>>>>>>>>>> -
>>>>>>>>>>       core->mac[ICR] &=3D ~effective_eiac;
>>>>>>>>>>
>>>>>>>>>>       if (!(core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
>>>>>>>>>>
>>>>>>>>> Ping for this - as well as https://patchwork.ozlabs.org/patch/8=
95476.
>>>>>>>>>
>>>>>>>>> Given that q35 uses e1000e by default and many Linux kernel ver=
sions no
>>>>>>>>> longer work, this should likely go into upcoming and stable ver=
sions
>>>>>>>> I'd rather not put it into 2.12 at this point in the release
>>>>>>>> cycle unless it's a regression from 2.11, I think.
>>>>>>> Second ping - nothing hit the repo so far, nor did I receive feed=
back.
>>>>>>>
>>>>>> And another ping. For both.
>>>>>>
>>>>>> These days I had to help someone with a broken QEMU setup that fai=
led
>>>>>> installing from network. It turned out that "modprobe e1000e IntMo=
de=3D0"
>>>>>> was needed to workaround the issues my patches address.
>>>>> What about the IMS register? It is set just after.
>>>>>
>>>>> Looking at b38636b8372, can you test this patch?
>>>>>
>>>>> -- >8 --
>>>>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>>>>> index c93c4661ed..a484b68a5a 100644
>>>>> --- a/hw/net/e1000e_core.c
>>>>> +++ b/hw/net/e1000e_core.c
>>>>> @@ -2022,13 +2022,13 @@ e1000e_msix_notify_one(E1000ECore *core,
>>>>> uint32_t cause, uint32_t int_cfg)
>>>>>
>>>>>       effective_eiac =3D core->mac[EIAC] & cause;
>>>>>
>>>>> -    if (effective_eiac =3D=3D E1000_ICR_OTHER) {
>>>>> -        effective_eiac |=3D E1000_ICR_OTHER_CAUSES;
>>>>> -    }
>>>>> -
>>>>>       core->mac[ICR] &=3D ~effective_eiac;
>>>>>
>>>>>       if (!(core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
>>>>> +        if (effective_eiac =3D=3D E1000_ICR_OTHER) {
>>>>> +            effective_eiac |=3D E1000_ICR_OTHER_CAUSES;
>>>>> +        }
>>>>> +
>>>>>           core->mac[IMS] &=3D ~effective_eiac;
>>>>>       }
>>>>>   }
>>>>>
>>>> Before testing this: What would be the reasoning for this change?
>>> Not breaking the purpose of b38636b8372 :)
>> I disagree on this expansion of bit 31 ("other causes"). I see no
>> indication in the spec that setting this bit for autoclear has more
>> impact than on the very same bit itself. Therefore I'm asking for a
>> reasoning - based on the spec.
>    Interrupt Cause Registers
>
>      Other bits in this register are the legacy indication of
>      interrupts as the MDIC complete, management and link status
>      change. There is a specific Other Cause bit that is set if
>      one of these bits are set, this bit can be mapped to a
>      specific MSI-X interrupt message.
>
> I spent half an hour reading the relevant parts of the spec and can't
> figure out, so I'll let the authors of b38636b8372 to review your patch=
.
>
> Regards,
>
> Phil.

Looking at EIAC part of the spec:

Bits 24:20 in this register enables clearing of the corresponding bit in=20
ICR following
interrupt generation. When a bit is set, the corresponding bit in ICR=20
and in IMS is
automatically cleared following an interrupt.

It looks to me that only the other bit itself need to be cleared.

Thanks
