Received: from eggs.gnu.org ([2001:4830:134:3::10]:43544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMtVg-0000U4-Jz
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:39:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMtVd-0000fq-Gp
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:39:04 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMtVd-0000fL-Ca
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:39:01 -0500
Received: by mail-yb1-f196.google.com with SMTP id i17-v6so6722087ybp.13
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 03:39:01 -0800 (PST)
MIME-Version: 1.0
References: <CAErn8fSCPZ1YKnf0OWq98S3-GFK9-3=uWgwfMO5Hut7PiDpcrw@mail.gmail.com>
In-Reply-To: <CAErn8fSCPZ1YKnf0OWq98S3-GFK9-3=uWgwfMO5Hut7PiDpcrw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 14 Nov 2018 12:38:49 +0100
Message-ID: <CAAdtpL7mr=HBxtYtxce-i5d+6qCNc0NvHN3F22DTQLy3J=AUsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Corrected memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: skintigh@gmail.com
Cc: Alistair Francis <alistair@alistair23.me>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Hi Seth,

On Wed, Nov 14, 2018 at 8:25 AM Seth K <skintigh@gmail.com> wrote:
>
> I corrected these 2 memory regions based on specifications from the chip
> manufacturer. The existing ranges seem to overlap and and cause odd
> behavior and/or crashes when trying to set up multiple UARTs,
> I also played with changing MAX_SERIAL_PORTS to 8 to match the hardware,
> but I did not include that in this patch as I never fully tested its
> effects.
> This is my first patch, I hope I did it correctly,
> Seth Kintigh

Welcome to QEMU, and thanks for your patch :)

I checked the DocID15818 (Rev 15) datasheet for this chip and your
patch is technically correct.

I suggest the patch title as "hw/arm/stm32f205: Fix the UART and Timer
region size" (note: use present rather than past).

However for the legal stuff, the QEMU project states all patches "must
include a Signed-off-by: line".
Please have a look at the following page which explains everything you
need to know in order to send useful contributions:
https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:_line

> ---

Note than the commit message stay in the repository history forever.
You can add information not related to the patch below the previous
"---" line, it will be cut out when your patch is applied to the
repository.
Here would go your "This is my first patch, I hope I did it correctly"
and signature.

Regards,

Phil.

>  hw/char/stm32f2xx_usart.c  | 2 +-
>  hw/timer/stm32f2xx_timer.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
> index 032b5fda13..f3363a2952 100644
> --- a/hw/char/stm32f2xx_usart.c
> +++ b/hw/char/stm32f2xx_usart.c
> @@ -202,7 +202,7 @@ static void stm32f2xx_usart_init(Object *obj)
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
>
>      memory_region_init_io(&s->mmio, obj, &stm32f2xx_usart_ops, s,
> -                          TYPE_STM32F2XX_USART, 0x2000);
> +                          TYPE_STM32F2XX_USART, 0x400);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>  }
>
> diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
> index 58fc7b1188..ae744d1642 100644
> --- a/hw/timer/stm32f2xx_timer.c
> +++ b/hw/timer/stm32f2xx_timer.c
> @@ -308,7 +308,7 @@ static void stm32f2xx_timer_init(Object *obj)
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
>
>      memory_region_init_io(&s->iomem, obj, &stm32f2xx_timer_ops, s,
> -                          "stm32f2xx_timer", 0x4000);
> +                          "stm32f2xx_timer", 0x400);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
>
>      s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, stm32f2xx_timer_interrupt,
> s);
> --
> 2.11.0
