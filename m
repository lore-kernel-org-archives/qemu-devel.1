Received: from eggs.gnu.org ([2001:4830:134:3::10]:33815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ejvhd-000431-Ta
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ejvhc-0005aW-Sm
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:34:05 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ejvhc-0005Zi-Lu
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:34:04 -0500
Received: by mail-lf0-x244.google.com with SMTP id k19so8782950lfj.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 15:34:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_XagA3SuqNTHd06nH4nTXTNztRBAYOQxF8cJmaVXBhoQ@mail.gmail.com>
References: <1517776881-14115-1-git-send-email-rbraun@sceen.net>
	<CAFEAcA_XagA3SuqNTHd06nH4nTXTNztRBAYOQxF8cJmaVXBhoQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 8 Feb 2018 15:33:32 -0800
Message-ID: <CAKmqyKOecR8kg3ec1jNbxV+VmZFeQw+sjC8LGBNAaR6pcOwrHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/char/stm32f2xx_usart: improve TXE/TC
 bit handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Braun <rbraun@sceen.net>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Feb 8, 2018 at 6:58 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 4 February 2018 at 20:41, Richard Braun <rbraun@sceen.net> wrote:
>> Consider that data is always immediately sent. As a result, keep
>> the SR_TXE and SR_TC bits always set. In addition, fix the reset value
>> of the USART status register.
>
> Do you know what the data sheet means when it says that TC
> can be cleared by "a read from the USART_SR register followed
> by a write to the USART_DR register" ?

I'm not sure if they have to be consecutive or as long as they
eventually happen it's fine.

I no longer have HW to test on so it's hard to say.

>
> If we supported interrupts properly (which we don't seem to)
> I suspect we'd need something more than "TXE and TC are always set",
> or the guest would probably never clear the TXE and TC interrupts.
>
> cc'ing Alistair, who wrote the stm32 USART code.
>
>> Signed-off-by: Richard Braun <rbraun@sceen.net>
>> ---
>>  hw/char/stm32f2xx_usart.c         | 4 ----
>>  include/hw/char/stm32f2xx_usart.h | 7 ++++++-
>>  2 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
>> index 07b462d4b6..a914f98a2a 100644
>> --- a/hw/char/stm32f2xx_usart.c
>> +++ b/hw/char/stm32f2xx_usart.c
>> @@ -96,12 +96,10 @@ static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
>>      switch (addr) {
>>      case USART_SR:
>>          retvalue = s->usart_sr;
>> -        s->usart_sr &= ~USART_SR_TC;

This does seem to be the wrong behavior. It should be cleared after
writing to the USART_DR register (and after this read).

>>          qemu_chr_fe_accept_input(&s->chr);
>>          return retvalue;
>>      case USART_DR:
>>          DB_PRINT("Value: 0x%" PRIx32 ", %c\n", s->usart_dr, (char) s->usart_dr);
>> -        s->usart_sr |= USART_SR_TXE;

Doesn't software expect this to be set? Maybe this was just a nasty
workaround to ensure it was set at some point.

>>          s->usart_sr &= ~USART_SR_RXNE;
>>          qemu_chr_fe_accept_input(&s->chr);
>>          qemu_set_irq(s->irq, 0);
>> @@ -151,8 +149,6 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
>>              /* XXX this blocks entire thread. Rewrite to use
>>               * qemu_chr_fe_write and background I/O callbacks */
>>              qemu_chr_fe_write_all(&s->chr, &ch, 1);
>> -            s->usart_sr |= USART_SR_TC;
>> -            s->usart_sr &= ~USART_SR_TXE;
>
> The guest can clear the TC and TXE bits by writing to the USART_SR
> directly, so this code should set both of them, I think ?

Shouldn't this clear both?

TXE: "It is cleared by a write to the USART_DR register."
TC: "a read from the USART_SR register followed by a write to the
USART_DR register"

I guess the TC should only clear after a read though.

>
>>          }
>>          return;
>>      case USART_BRR:
>> diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2xx_usart.h
>> index 9d03a7527c..bbba3965a1 100644
>> --- a/include/hw/char/stm32f2xx_usart.h
>> +++ b/include/hw/char/stm32f2xx_usart.h
>> @@ -37,7 +37,12 @@
>>  #define USART_CR3  0x14
>>  #define USART_GTPR 0x18
>>
>> -#define USART_SR_RESET 0x00C00000
>> +/*
>> + * XXX The reset value mentioned in 24.6.1 Status register seems bogus.
>> + * Looking at Table 98 USART register map and reset values, it seems it
>> + * should be 0xc0, and that's how real hardware behaves.
>> + */
>> +#define USART_SR_RESET (USART_SR_TXE | USART_SR_TC)
>>
>>  #define USART_SR_TXE  (1 << 7)
>>  #define USART_SR_TC   (1 << 6)
>
> Yep, I agree that the previous reset value was wrong.

Ah, that is confusing that it's different in different places. The new
one looks fine though.

Alistair

>
> thanks
> -- PMM
>
