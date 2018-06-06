Received: from eggs.gnu.org ([2001:4830:134:3::10]:42435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQaQN-0006ni-95
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQaQL-00027P-Uj
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:32:35 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:33943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQaQL-00026o-Ne
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:32:33 -0400
Received: by mail-ot0-x241.google.com with SMTP id i5-v6so7745407otf.1
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 08:32:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1806061619030.42561@zero.eik.bme.hu>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<fdb61fc16922f78190f0db04a11dd20519cd2fb5.1528291908.git.balaton@eik.bme.hu>
	<CAFEAcA_GwgmiZPQ9NmY9a7_OwYFCBHFZiVQzk1nZEoxYaD+mwQ@mail.gmail.com>
	<alpine.BSF.2.21.1806061619030.42561@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Jun 2018 16:32:12 +0100
Message-ID: <CAFEAcA8NOAME70Sdv7rEV67rp0NEhMqdRqRm=iLQUKmo3oTvLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 7/8] sm501: Do not clear read only bits
 when writing register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 6 June 2018 at 15:28, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Wed, 6 Jun 2018, Peter Maydell wrote:
>>
>> On 6 June 2018 at 14:31, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>
>>> When writing a register that has read only bits besides reserved bits
>>> we have to avoid changing read only bits that may have non zero
>>> default values.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>  hw/display/sm501.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>>> index e47be99..7ec1434 100644
>>> --- a/hw/display/sm501.c
>>> +++ b/hw/display/sm501.c
>>> @@ -836,10 +836,10 @@ static void sm501_system_config_write(void *opaque,
>>> hwaddr addr,
>>>
>>>      switch (addr) {
>>>      case SM501_SYSTEM_CONTROL:
>>> -        s->system_control = value & 0xE300B8F7;
>>> +        s->system_control |= value & 0xEF00B8F7;
>>
>>
>> This will mean that you can't clear a r/w bit by writing a
>> zero to it -- is that the hardware behaviour? The
>
>
> Not really sure about real hardware behaviour. I only have that not very
> detailed docs we've looked at before but I assume r/w bits could be changed
> by writing them.
>
>> description in the commit message suggests that you want
>>   s->whatever = (value & rw_bit_mask) | ro_one_bits_mask;
>
>
> Wouldn't that always set ro bits?

It will enforce that the RO 1 bits are always 1 (by
ORing those bits in). It's not the only way to do it.
(NB we OR the "ro_one_bits", not "ro_bits".)

>I need to leave ro bits untouched by
> written value and only set rw bits. The previous version masked out ro bits
> which also cleared them due to assigning with =. Maybe
>
> s->whatever &= ro_bits_mask;
> s->whatever |= value & rw_bits_mask;

Yes, this works (and I have a feeling it's what we tend to use.)

>>> @@ -853,7 +853,7 @@ static void sm501_system_config_write(void *opaque,
>>> hwaddr addr,
>>>          s->dram_control |=  value & 0x7FFFFFC3;

Hmm, does dram_control also need to behave the same way?

>>>          break;
>>>      case SM501_ARBTRTN_CONTROL:
>>> -        s->arbitration_control =  value & 0x37777777;
>>> +        s->arbitration_control = value & 0x37777777;
>>
>>
>> Was this intended to be changed too?
>
>
> Yes, just a simple white space cleanup. Does that worth a separate patch or
> enough to mention in commit message to make it clear it's intended change?

I would personally put it in its own patch, but if you put it
in this one do mention it in the commit message. Otherwise
given the patch is changing four 'foo_control' registers it
looks like this one was typoed. (It will look less so if
the change for the others isn't just "add a '|'", though.)

thanks
-- PMM
