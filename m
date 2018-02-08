Received: from eggs.gnu.org ([2001:4830:134:3::10]:44176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejnf1-0007Xh-Qq
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejnf0-0007Wr-Mt
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:58:51 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:38587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejnf0-0007WS-Fd
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:58:50 -0500
Received: by mail-ot0-x241.google.com with SMTP id h14so4564965otj.5
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 06:58:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517776881-14115-1-git-send-email-rbraun@sceen.net>
References: <1517776881-14115-1-git-send-email-rbraun@sceen.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 14:58:29 +0000
Message-ID: <CAFEAcA_XagA3SuqNTHd06nH4nTXTNztRBAYOQxF8cJmaVXBhoQ@mail.gmail.com>
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
To: Richard Braun <rbraun@sceen.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>

On 4 February 2018 at 20:41, Richard Braun <rbraun@sceen.net> wrote:
> Consider that data is always immediately sent. As a result, keep
> the SR_TXE and SR_TC bits always set. In addition, fix the reset value
> of the USART status register.

Do you know what the data sheet means when it says that TC
can be cleared by "a read from the USART_SR register followed
by a write to the USART_DR register" ?

If we supported interrupts properly (which we don't seem to)
I suspect we'd need something more than "TXE and TC are always set",
or the guest would probably never clear the TXE and TC interrupts.

cc'ing Alistair, who wrote the stm32 USART code.

> Signed-off-by: Richard Braun <rbraun@sceen.net>
> ---
>  hw/char/stm32f2xx_usart.c         | 4 ----
>  include/hw/char/stm32f2xx_usart.h | 7 ++++++-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
> index 07b462d4b6..a914f98a2a 100644
> --- a/hw/char/stm32f2xx_usart.c
> +++ b/hw/char/stm32f2xx_usart.c
> @@ -96,12 +96,10 @@ static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
>      switch (addr) {
>      case USART_SR:
>          retvalue = s->usart_sr;
> -        s->usart_sr &= ~USART_SR_TC;
>          qemu_chr_fe_accept_input(&s->chr);
>          return retvalue;
>      case USART_DR:
>          DB_PRINT("Value: 0x%" PRIx32 ", %c\n", s->usart_dr, (char) s->usart_dr);
> -        s->usart_sr |= USART_SR_TXE;
>          s->usart_sr &= ~USART_SR_RXNE;
>          qemu_chr_fe_accept_input(&s->chr);
>          qemu_set_irq(s->irq, 0);
> @@ -151,8 +149,6 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
>              /* XXX this blocks entire thread. Rewrite to use
>               * qemu_chr_fe_write and background I/O callbacks */
>              qemu_chr_fe_write_all(&s->chr, &ch, 1);
> -            s->usart_sr |= USART_SR_TC;
> -            s->usart_sr &= ~USART_SR_TXE;

The guest can clear the TC and TXE bits by writing to the USART_SR
directly, so this code should set both of them, I think ?

>          }
>          return;
>      case USART_BRR:
> diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2xx_usart.h
> index 9d03a7527c..bbba3965a1 100644
> --- a/include/hw/char/stm32f2xx_usart.h
> +++ b/include/hw/char/stm32f2xx_usart.h
> @@ -37,7 +37,12 @@
>  #define USART_CR3  0x14
>  #define USART_GTPR 0x18
>
> -#define USART_SR_RESET 0x00C00000
> +/*
> + * XXX The reset value mentioned in 24.6.1 Status register seems bogus.
> + * Looking at Table 98 USART register map and reset values, it seems it
> + * should be 0xc0, and that's how real hardware behaves.
> + */
> +#define USART_SR_RESET (USART_SR_TXE | USART_SR_TC)
>
>  #define USART_SR_TXE  (1 << 7)
>  #define USART_SR_TC   (1 << 6)

Yep, I agree that the previous reset value was wrong.

thanks
-- PMM
