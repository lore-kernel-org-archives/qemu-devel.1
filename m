Received: from eggs.gnu.org ([2001:4830:134:3::10]:45684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQrEc-0004tc-1c
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 04:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQrEa-00077w-Ju
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 04:25:02 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:41097
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dQrEa-00075X-9J
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 04:25:00 -0400
References: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
	<1498728533-23160-3-git-send-email-frederic.konrad@adacore.com>
	<CAFEAcA-tuehYiJkYo148N0VPJ3hwhcxYDDersmbs4TOqxQCEKw@mail.gmail.com>
	<7e7d94ce-a33c-6253-8dcf-475e93fe388f@adacore.com>
	<CAFEAcA_EcMOQ6afbmZK1jYUuWGzAUzj8AKRLvoDEsezsQkPYzA@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <f7ff9307-f341-f7df-3c80-374626f7631a@adacore.com>
Date: Fri, 30 Jun 2017 10:24:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_EcMOQ6afbmZK1jYUuWGzAUzj8AKRLvoDEsezsQkPYzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/3] arm: fix the armv7m reset state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, alistair@alistair23.me



On 06/29/2017 06:45 PM, Peter Maydell wrote:
> On 29 June 2017 at 17:41, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
>> On 06/29/2017 05:14 PM, Peter Maydell wrote:
>>> This is awkward, because in the "we have a ROM but it's not been
>>> copied into memory yet" case, the only thing we have is the
>>> rom->addr, which is the address which the user's ROM blob said
>>> it ought to be loaded in at. If the user didn't actually provide
>>> a ROM blob that loads at 0 that seems a bit like a user error,
>>> and I don't think this patch will catch all the cases of that
>>> sort of mistake.
>>
>>
>> I don't think it's really a user mistake because on the real HW
>> the alias is configurable.. at least in my case.
>>
>> There is a "jumper" setting to mirror either the Flash or the
>> SRAM, etc. So the binaries isn't located at 0 but at the flash
>> address 0x8000000 or some such. That's the case with u-boot and
>> the precompiled examples I found for this stm32fxxxx board.
>>
>>>   For instance if address 0 is real flash and the
>>> high address alias is modelled by having the high address be the
>>> alias, then if the user passes us an ELF file saying "load to
>>> the high address" then this change won't catch that I think
>>> (because doing the memory_region_find/get_offset_within_address_space
>>> will return 0, which has already been tried). You'd need to
>>> somehow have a way to say "find all the addresses within this
>>> AS where this MR is mapped" and try them all...
>>
>>
>> This is more likely to be a user error :). Maybe we can load
>> the ROM before the reset but that seems a lot more invasive..
> 
> It's the same thing, though, right? If the user's ELF file
> says "vector table is at 0x8000000" then we should either
> (a) say that's a user error, or
> (b) handle it right, whether we implemented the QEMU model with
> the flash at 0 and the alias at 0x8000000, or with the flash
> at 0x8000000 and the alias at 0.

Hi Peter,

Fondamentaly yes, it is the same.. but it seems really strange to
me to load the elf in the alias.

If I choose (a) I'll need to objcpy all the elf to 0 or modify
the build script which should work on the real board.. This seems
not really a good option to me.

If I choose (b) I won't be able to load it to SRAM and it is
basically the same result I'll need to move or modify the config.

Thanks,
Fred

> 
>> BTW isn't there a trick with the ELF entry somewhere? Or is that
>> for the Cortex-A?
> 
> We don't honour the ELF entry point on M profile (arguably
> a bug) -- armv7m_load_kernel() ignores the entry point
> returned by load_elf() in the 'entry' variable.
> 
> thanks
> -- PMM
> 
