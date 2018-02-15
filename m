Received: from eggs.gnu.org ([2001:4830:134:3::10]:33846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1emS0v-0004Tu-NT
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:28:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1emS0u-0005sw-Kr
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:28:25 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:46500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1emS0u-0005qQ-Cp
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:28:24 -0500
Received: by mail-lf0-x242.google.com with SMTP id q194so1644631lfe.13
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:28:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518555259-26463-1-git-send-email-rbraun@sceen.net>
References: <20180209093643.GC27456@shattrath>
	<1518555259-26463-1-git-send-email-rbraun@sceen.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2018 14:27:51 -0800
Message-ID: <CAKmqyKMVh5KYxrPPL6Cg8foua3Ot_m3-_Uu+S+H=32sD8mfzJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] hw/char/stm32f2xx_usart: fix TXE/TC bit
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Braun <rbraun@sceen.net>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>

On Tue, Feb 13, 2018 at 12:54 PM, Richard Braun <rbraun@sceen.net> wrote:
> I/O currently being synchronous, there is no reason to ever clear the
> SR_TXE bit. However the SR_TC bit may be cleared by software writing
> to the SR register, so set it on each write.
>
> In addition, fix the reset value of the USART status register.
>
> Signed-off-by: Richard Braun <rbraun@sceen.net>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/char/stm32f2xx_usart.c         | 12 ++++++++----
>  include/hw/char/stm32f2xx_usart.h |  7 ++++++-
>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
> index 07b462d4b6..032b5fda13 100644
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
> @@ -137,7 +135,9 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
>      switch (addr) {
>      case USART_SR:
>          if (value <= 0x3FF) {
> -            s->usart_sr = value;
> +            /* I/O being synchronous, TXE is always set. In addition, it may
> +               only be set by hardware, so keep it set here. */
> +            s->usart_sr = value | USART_SR_TXE;
>          } else {
>              s->usart_sr &= value;
>          }
> @@ -151,8 +151,12 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
>              /* XXX this blocks entire thread. Rewrite to use
>               * qemu_chr_fe_write and background I/O callbacks */
>              qemu_chr_fe_write_all(&s->chr, &ch, 1);
> +            /* XXX I/O are currently synchronous, making it impossible for
> +               software to observe transient states where TXE or TC aren't
> +               set. Unlike TXE however, which is read-only, software may
> +               clear TC by writing 0 to the SR register, so set it again
> +               on each write. */
>              s->usart_sr |= USART_SR_TC;
> -            s->usart_sr &= ~USART_SR_TXE;
>          }
>          return;
>      case USART_BRR:
> diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2xx_usart.h
> index 9d03a7527c..7ea7448813 100644
> --- a/include/hw/char/stm32f2xx_usart.h
> +++ b/include/hw/char/stm32f2xx_usart.h
> @@ -37,7 +37,12 @@
>  #define USART_CR3  0x14
>  #define USART_GTPR 0x18
>
> -#define USART_SR_RESET 0x00C00000
> +/*
> + * XXX The reset value mentioned in "24.6.1 Status register" seems bogus.
> + * Looking at "Table 98 USART register map and reset values", it seems it
> + * should be 0xc0, and that's how real hardware behaves.
> + */
> +#define USART_SR_RESET (USART_SR_TXE | USART_SR_TC)
>
>  #define USART_SR_TXE  (1 << 7)
>  #define USART_SR_TC   (1 << 6)
> --
> 2.11.0
>
>
