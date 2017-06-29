Received: from eggs.gnu.org ([2001:4830:134:3::10]:40588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQcW0-0005rZ-DK
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQcVw-0007MM-Dn
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:42:00 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:35997
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dQcVw-0007M4-6M
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:41:56 -0400
References: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
	<1498728533-23160-3-git-send-email-frederic.konrad@adacore.com>
	<CAFEAcA-tuehYiJkYo148N0VPJ3hwhcxYDDersmbs4TOqxQCEKw@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <7e7d94ce-a33c-6253-8dcf-475e93fe388f@adacore.com>
Date: Thu, 29 Jun 2017 18:41:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-tuehYiJkYo148N0VPJ3hwhcxYDDersmbs4TOqxQCEKw@mail.gmail.com>
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



On 06/29/2017 05:14 PM, Peter Maydell wrote:
> On 29 June 2017 at 10:28, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
>> This fixes an odd bug when a ROM is present somewhere and an alias @0x00000000
>> is pointing to the ROM. The "if (rom)" test fails and we don't get a valid reset
>> state. QEMU later crashes with an exception because the ARMv7-M starts with the
>> ARM instruction set. (eg: PC & 0x01 is 0).
>>
>> This patch uses memory_region_get_offset_within_address_space introduced before
>> to check if an alias doesn't point to a flash somewhere.
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> 
> This is awkward, because in the "we have a ROM but it's not been
> copied into memory yet" case, the only thing we have is the
> rom->addr, which is the address which the user's ROM blob said
> it ought to be loaded in at. If the user didn't actually provide
> a ROM blob that loads at 0 that seems a bit like a user error,
> and I don't think this patch will catch all the cases of that
> sort of mistake.

I don't think it's really a user mistake because on the real HW
the alias is configurable.. at least in my case.

There is a "jumper" setting to mirror either the Flash or the
SRAM, etc. So the binaries isn't located at 0 but at the flash
address 0x8000000 or some such. That's the case with u-boot and
the precompiled examples I found for this stm32fxxxx board.

  For instance if address 0 is real flash and the
> high address alias is modelled by having the high address be the
> alias, then if the user passes us an ELF file saying "load to
> the high address" then this change won't catch that I think
> (because doing the memory_region_find/get_offset_within_address_space
> will return 0, which has already been tried). You'd need to
> somehow have a way to say "find all the addresses within this
> AS where this MR is mapped" and try them all...

This is more likely to be a user error :). Maybe we can load
the ROM before the reset but that seems a lot more invasive..

BTW isn't there a trick with the ELF entry somewhere? Or is that
for the Cortex-A?

Thanks,
Fred

> 
> thanks
> -- PMM
> 
