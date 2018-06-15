Received: from eggs.gnu.org ([2001:4830:134:3::10]:35284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1fTrGS-000516-Qc
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1fTrGP-00084y-Ie
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:07:52 -0400
Received: from thoth.sbs.de ([192.35.17.2]:41829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1fTrGP-0007bO-3A
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:07:49 -0400
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
	<3608e071-f66b-9ee5-3896-8562daa9b483@redhat.com>
	<49ec5839-bcaa-39d1-e815-377bcf7cdd6b@amsat.org>
	<6eeac4b0-7a10-de17-1fdd-8d4417934623@redhat.com>
	<4b28b3a0-634b-fc7b-230f-9a1dfec9fc0c@redhat.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <642829e1-1ea1-58b8-4b7a-faf172d00140@siemens.com>
Date: Fri, 15 Jun 2018 18:06:20 +0200
MIME-Version: 1.0
In-Reply-To: <4b28b3a0-634b-fc7b-230f-9a1dfec9fc0c@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

On 2018-06-15 04:07, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B406=E6=9C=8813=E6=97=A5 10:29, Jason Wang wrote:
>>
>>
>> On 2018=E5=B9=B406=E6=9C=8813=E6=97=A5 10:26, Philippe Mathieu-Daud=C3=
=A9 wrote:
>>> Hi Jason,
>>>
>>> On 06/12/2018 11:18 PM, Jason Wang wrote:
>>>> On 2018=E5=B9=B406=E6=9C=8813=E6=97=A5 03:00, Philippe Mathieu-Daud=C3=
=A9 wrote:
>>>>> Cc'ing Jason who is also listed as co-maintainer:
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 ./scripts/get_maintainer.pl -f hw/net/e1000e_cor=
e.c
>>>>> =C2=A0=C2=A0=C2=A0 Dmitry Fleytman <dmitry.fleytman@gmail.com> (mai=
ntainer:e1000e)
>>>>> =C2=A0=C2=A0=C2=A0 Jason Wang <jasowang@redhat.com> (odd fixer:Netw=
ork devices)
>>>>>
>>>>> On 06/12/2018 03:43 PM, Jan Kiszka wrote:
>>>>>> On 2018-06-12 20:38, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>> On 06/12/2018 03:30 PM, Jan Kiszka wrote:
>>>>>>>> On 2018-06-12 20:11, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>>>> Hi Jan,
>>>>>>>>>
>>>>>>>>> On 06/12/2018 02:22 PM, Jan Kiszka wrote:
>>>>>>>>>> On 2018-05-22 09:00, Jan Kiszka wrote:
>>>>>>>>>>> On 2018-04-16 17:29, Peter Maydell wrote:
>>>>>>>>>>>> On 16 April 2018 at 16:25, Jan Kiszka <jan.kiszka@siemens.co=
m>
>>>>>>>>>>>> wrote:
>>>>>>>>>>>>> On 2018-04-01 23:17, Jan Kiszka wrote:
>>>>>>>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The spec does not justify clearing of any
>>>>>>>>>>>>>> E1000_ICR_OTHER_CAUSES when
>>>>>>>>>>>>>> E1000_ICR_OTHER is set in EIAC. In fact, removing this cod=
e
>>>>>>>>>>>>>> fixes the
>>>>>>>>>>>>>> issue the Linux driver runs into since 4aea7a5c5e94 ("e100=
0e:
>>>>>>>>>>>>>> Avoid
>>>>>>>>>>>>>> receiver overrun interrupt bursts") and was worked around =
by
>>>>>>>>>>>>>> 745d0bd3af99 ("e1000e: Remove Other from EIAC").
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This resolves the issue I reported on February 18 ("e1000e=
:
>>>>>>>>>>>>>> MSI-X
>>>>>>>>>>>>>> problem with recent Linux drivers").
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> =C2=A0=C2=A0 hw/net/e1000e_core.c | 4 ----
>>>>>>>>>>>>>> =C2=A0=C2=A0 1 file changed, 4 deletions(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>>>>>>>>>>>>>> index ecf9b15555..d38f025c0f 100644
>>>>>>>>>>>>>> --- a/hw/net/e1000e_core.c
>>>>>>>>>>>>>> +++ b/hw/net/e1000e_core.c
>>>>>>>>>>>>>> @@ -2022,10 +2022,6 @@ e1000e_msix_notify_one(E1000ECore
>>>>>>>>>>>>>> *core, uint32_t cause, uint32_t int_cfg)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 effective_eiac =3D co=
re->mac[EIAC] & cause;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 if (effective_eiac =3D=3D E1000_ICR_OT=
HER) {
>>>>>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 effective_eiac=
 |=3D E1000_ICR_OTHER_CAUSES;
>>>>>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>>>>> -
>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 core->mac[ICR] &=3D ~=
effective_eiac;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(core->mac[CTRL_=
EXT] & E1000_CTRL_EXT_IAME)) {
>>>>>>>>>>>>>>
>>>>>>>>>>>>> Ping for this - as well as
>>>>>>>>>>>>> https://patchwork.ozlabs.org/patch/895476.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Given that q35 uses e1000e by default and many Linux kernel
>>>>>>>>>>>>> versions no
>>>>>>>>>>>>> longer work, this should likely go into upcoming and stable
>>>>>>>>>>>>> versions
>>>>>>>>>>>> I'd rather not put it into 2.12 at this point in the release
>>>>>>>>>>>> cycle unless it's a regression from 2.11, I think.
>>>>>>>>>>> Second ping - nothing hit the repo so far, nor did I receive
>>>>>>>>>>> feedback.
>>>>>>>>>>>
>>>>>>>>>> And another ping. For both.
>>>>>>>>>>
>>>>>>>>>> These days I had to help someone with a broken QEMU setup that
>>>>>>>>>> failed
>>>>>>>>>> installing from network. It turned out that "modprobe e1000e
>>>>>>>>>> IntMode=3D0"
>>>>>>>>>> was needed to workaround the issues my patches address.
>>>>>>>>> What about the IMS register? It is set just after.
>>>>>>>>>
>>>>>>>>> Looking at b38636b8372, can you test this patch?
>>>>>>>>>
>>>>>>>>> -- >8 --
>>>>>>>>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>>>>>>>>> index c93c4661ed..a484b68a5a 100644
>>>>>>>>> --- a/hw/net/e1000e_core.c
>>>>>>>>> +++ b/hw/net/e1000e_core.c
>>>>>>>>> @@ -2022,13 +2022,13 @@ e1000e_msix_notify_one(E1000ECore *core=
,
>>>>>>>>> uint32_t cause, uint32_t int_cfg)
>>>>>>>>>
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 effective_eiac =3D core->m=
ac[EIAC] & cause;
>>>>>>>>>
>>>>>>>>> -=C2=A0=C2=A0=C2=A0 if (effective_eiac =3D=3D E1000_ICR_OTHER) =
{
>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 effective_eiac |=3D=
 E1000_ICR_OTHER_CAUSES;
>>>>>>>>> -=C2=A0=C2=A0=C2=A0 }
>>>>>>>>> -
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 core->mac[ICR] &=3D ~effec=
tive_eiac;
>>>>>>>>>
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(core->mac[CTRL_EXT] =
& E1000_CTRL_EXT_IAME)) {
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (effective_eiac =
=3D=3D E1000_ICR_OTHER) {
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 effective_eiac |=3D E1000_ICR_OTHER_CAUSES;
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>> +
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
re->mac[IMS] &=3D ~effective_eiac;
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>
>>>>>>>> Before testing this: What would be the reasoning for this change=
?
>>>>>>> Not breaking the purpose of b38636b8372 :)
>>>>>> I disagree on this expansion of bit 31 ("other causes"). I see no
>>>>>> indication in the spec that setting this bit for autoclear has mor=
e
>>>>>> impact than on the very same bit itself. Therefore I'm asking for =
a
>>>>>> reasoning - based on the spec.
>>>>> =C2=A0=C2=A0=C2=A0 Interrupt Cause Registers
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Other bits in this register are the =
legacy indication of
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts as the MDIC complete, man=
agement and link status
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 change. There is a specific Other Ca=
use bit that is set if
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 one of these bits are set, this bit =
can be mapped to a
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 specific MSI-X interrupt message.
>>>>>
>>>>> I spent half an hour reading the relevant parts of the spec and can=
't
>>>>> figure out, so I'll let the authors of b38636b8372 to review your
>>>>> patch.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Phil.
>>>> Looking at EIAC part of the spec:
>>>>
>>>> Bits 24:20 in this register enables clearing of the corresponding
>>>> bit in
>>>> ICR following
>>>> interrupt generation. When a bit is set, the corresponding bit in IC=
R
>>>> and in IMS is
>>>> automatically cleared following an interrupt.
>>> Thanks for looking at this.
>>>
>>>> It looks to me that only the other bit itself need to be cleared.
>>> So no need to set the other_causes bits, thus Jan patch is correct?
>>>
>>> Thanks,
>>>
>>> Phil.
>>>
>>
>> Yes, I think so. But I think we can wait for few days to see if Dmitry
>> have come comments.
>>
>> Thanks
>>
>=20
> Ok, I applied this first.

Thanks.

Did you already have a look at https://patchwork.ozlabs.org/patch/895476
as well?

Jan
