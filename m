Received: from eggs.gnu.org ([209.51.188.92]:43998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwsvZ-00033T-NT
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwsvS-0001Xy-Hw
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:18:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-10-armbru@redhat.com>
	<87zhqp2igg.fsf@zen.linaroharston> <87tvgxvz4p.fsf@dusky.pond.sub.org>
	<alpine.BSF.2.21.9999.1902211828250.71091@zero.eik.bme.hu>
Date: Thu, 21 Feb 2019 19:18:10 +0100
In-Reply-To: <alpine.BSF.2.21.9999.1902211828250.71091@zero.eik.bme.hu>
	(BALATON Zoltan's message of "Thu, 21 Feb 2019 18:36:00 +0100 (CET)")
Message-ID: <87zhqpuhst.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/10] pflash: Clean up after commit
 368a354f02b part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, lersek@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, david@gibson.dropbear.id.au

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Thu, 21 Feb 2019, Markus Armbruster wrote:
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>>> Markus Armbruster <armbru@redhat.com> writes:
>>>
>>>> QOMification left parameter @size unused in pflash_cfi01_register()
>>>> and pflash_cfi02_register().  register().  Obviously, @size should
>>>> match @sector_len and @nb_blocs, i.e. size =3D=3D sector_len * nb_bloc=
s.
>>>> All callers satisfy this.
>>>>
>>>> Remove @nb_blocs and compute it from @size and @sector_len.
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>> [...]
>>>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>>>> index a989a8c439..a5dae67c26 100644
>>>> --- a/hw/ppc/sam460ex.c
>>>> +++ b/hw/ppc/sam460ex.c
>>>> @@ -97,7 +97,7 @@ static int sam460ex_load_uboot(void)
>>>>      if (!pflash_cfi01_register(FLASH_BASE | ((hwaddr)FLASH_BASE_H << =
32),
>>>>                                 "sam460ex.flash", FLASH_SIZE,
>>>>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : N=
ULL,
>>>> -                               65536, FLASH_SIZE / 65536,
>>>> +                               65536,
>>>
>>> 64 * KiB?
>>
>> I generally prefer to keep big, repetitive patches as mechanical as
>> possible.  But if it's desired, I'll make this change.
>>
>> Zoltan, David, David, you're maintainers, do you have a preference?
>
> For the sam460ex, this is 64 * KiB now before your patches which
> matches other similar numbers in this file. I've already said I prefer
> to keep it as 64 * KiB in reply to your [PATCH 04/10] which changed it
> and you've agreed to that a few days ago. If you fix that patch
> (04/10) this one remains mechanical.

You're 100% right.  I failed to recall that detail from previous review
when I wrote the reply above.

Thanks!
