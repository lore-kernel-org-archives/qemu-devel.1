Received: from eggs.gnu.org ([2001:4830:134:3::10]:49206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePf9w-0006Sp-FK
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 20:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePf9v-0001zj-K7
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 20:51:32 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAKmqyKNZDeF63PrjUAU4MM8C6VbaJj2Ac6Y4zV1rbF2W9QaYtg@mail.gmail.com>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-5-f4bug@amsat.org>
	<CAKmqyKPvAL3+LAqMBtUOc=0igkSwg4Jmf+Q0ySL7C+oech7AMw@mail.gmail.com>
	<CAAdtpL6pT0GD+xkV5P+-J=SGr8_kTrNVBxc207g4mRuojrGe3w@mail.gmail.com>
	<CAKmqyKMU46dmqEDhm9My=4ZM4GQf3n_ZLdm5JnFTi-mf3hz7SQ@mail.gmail.com>
	<CAAdtpL7ybSzQHHucZTfYtKVR6xwa+r7y0_67b8nJpF_EXMZv6Q@mail.gmail.com>
	<CAKmqyKNZDeF63PrjUAU4MM8C6VbaJj2Ac6Y4zV1rbF2W9QaYtg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Dec 2017 22:51:29 -0300
Message-ID: <CAAdtpL7c6cCWPH_x-JoPuzY6CoTMtqZactvLcfuwGFGRARScZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/14] sdhci: use deposit64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Sai Pavan Boddu <saipava@xilinx.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

>>>> good catch :) I'll respin with:
>>>>
>>>>     case SDHC_ADMASYSADDR:
>>>>         s->admasysaddr = deposit64(s->admasysaddr, 0, 32, value)
>>>>         break;
>>>>     case SDHC_ADMASYSADDR + 4:
>>>>         s->admasysaddr = deposit64(s->admasysaddr, 32, 32, value);
>>>>         break;
>>>
>>> This still doesn't take the mask value into account though.
>>>
>>> Also, doesn't deposit() shift value up in this case? We want to mask
>>> the low bits out. I don't have the code in front of me though, so I
>>> could be wrong here.
>>
>> We have sdhci_mmio_ops.max_access_size = 4, so value will be at most 32bits.
>
> Ah! Good point.
>
>> Now ADMASYSADDR is a 64-bit register, accessible in 2x32-bit.
>>
>> /**
>>  * Deposit @fieldval into the 64 bit @value at the bit field specified
>>  * by the @start and @length parameters, and return the modified
>>  * @value. Bits of @value outside the bit field are not modified.
>>
>> uint64_t deposit64(uint64_t value, int start, int length, uint64_t fieldval);
>>
>> in both access we use length=32
>>
>> at SDHC_ADMASYSADDR we use start=0,
>> while at SDHC_ADMASYSADDR + 4 we use start=32.
>>
>> both deposit the 32b value (32b masked) into a 64b s->admasysaddr.
>>
>> This is good to clarify this now, because the Spec v3 series (and
>> v4.20 if we want it) add a lot of them.
>
> Ok, this sounds fine to me then.
>
> The mask variable is still being ignored though. value should be anded
> with mask.

This is what deposit64() does:

uint64_t deposit64(uint64_t value, int start, int length, uint64_t fieldval)
{
    uint64_t mask;
    assert(start >= 0 && length > 0 && length <= 64 - start);
    mask = (~0ULL >> (64 - length)) << start;
    return (value & ~mask) | ((fieldval << start) & mask);
}
