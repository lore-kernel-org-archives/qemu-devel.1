Received: from eggs.gnu.org ([209.51.188.92]:38092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYbV-0003Al-Ht
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYbS-0001MO-LK
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:51:56 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYbQ-0001Iw-Ix
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:51:53 -0400
Received: by mail-oi1-x242.google.com with SMTP id t184so4384651oie.11
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556774049.git.alistair@alistair23.me>
	<PSXP216MB0277F0C5EFED03D58540BD70DD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0277F0C5EFED03D58540BD70DD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:51:39 +0100
Message-ID: <CAFEAcA9gxWQ4Lr8-DS7ExdZuDF8xHSCY7AmkHKEs1uCTVmA+Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 4/5] hw/arm: Add the STM32F4xx SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>

On Thu, 2 May 2019 at 06:41, Alistair Francis <alistair@alistair23.me> wrote:
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  MAINTAINERS                     |   8 +
>  default-configs/arm-softmmu.mak |   1 +
>  hw/arm/Kconfig                  |   3 +
>  hw/arm/Makefile.objs            |   1 +
>  hw/arm/stm32f405_soc.c          | 306 ++++++++++++++++++++++++++++++++
>  include/hw/arm/stm32f405_soc.h  |  74 ++++++++
>  6 files changed, 393 insertions(+)
>  create mode 100644 hw/arm/stm32f405_soc.c
>  create mode 100644 include/hw/arm/stm32f405_soc.h
>

> +static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    STM32F405State *s = STM32F405_SOC(dev_soc);
> +    DeviceState *dev, *armv7m;
> +    SysBusDevice *busdev;
> +    Error *err = NULL;
> +    int i;
> +
> +    s->system_memory = get_system_memory();
> +    s->sram = g_new(MemoryRegion, 1);
> +    s->flash = g_new(MemoryRegion, 1);
> +    s->flash_alias = g_new(MemoryRegion, 1);

What I meant by my comment on v1 was that rather than doing
g_new() here you can just have the STM32F405State struct
have
 MemoryRegion sram;
 MemoryRegion flash;
etc

and then instead of
  memory_region_init_ram(s->flash, ...)
you use
  memory_region_init_ram(&s->flash, ...)
etc

which avoids doing separate memory allocations (which would
need to be freed if you then do an error-exit from the
realize function, I think).

And you don't need to have an s->system_memory -- that
can just be a local variable, because it's just caching
the pointer to the global system memory MemoryRegion.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
