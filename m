Received: from eggs.gnu.org ([209.51.188.92]:58680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvrB1-0005d1-Cs
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:14:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqyt-0006cH-S4
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:01:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gvqyt-0006bS-HT
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:01:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id l5so18914656wrw.6
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:01:43 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3f81d4c5-8c2f-f8b0-286a-ba732a2794c5@redhat.com>
Date: Mon, 18 Feb 2019 23:01:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/14] hw/arm/armsse: Allow boards to
 specify init-svtor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 2/14/19 1:51 PM, Peter Maydell wrote:
> The Musca boards have DAPLink firmware that sets the initial
> secure VTOR value (the location of the vector table) differently
> depending on the boot mode (from flash, from RAM, etc). Export
> the init-svtor as a QOM property of the ARMSSE object so that
> the board can change it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/hw/arm/armsse.h | 3 +++
>  hw/arm/armsse.c         | 8 ++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
> index 444605b44dc..84879f40dd8 100644
> --- a/include/hw/arm/armsse.h
> +++ b/include/hw/arm/armsse.h
> @@ -48,6 +48,8 @@
>   *    if necessary.)
>   *  + QOM property "SRAM_ADDR_WIDTH" sets the number of bits used for the
>   *    address of each SRAM bank (and thus the total amount of internal SRAM)
> + *  + QOM property "init-svtor" sets the initial value of the CPU SVTOR register
> + *    (where it expects to load the PC and SP from the vector table on reset)
>   *  + Named GPIO inputs "EXP_IRQ" 0..n are the expansion interrupts for CPU 0,
>   *    which are wired to its NVIC lines 32 .. n+32
>   *  + Named GPIO inputs "EXP_CPU1_IRQ" 0..n are the expansion interrupts for
> @@ -204,6 +206,7 @@ typedef struct ARMSSE {
>      uint32_t exp_numirq;
>      uint32_t mainclk_frq;
>      uint32_t sram_addr_width;
> +    uint32_t init_svtor;
>  } ARMSSE;
>  
>  typedef struct ARMSSEInfo ARMSSEInfo;
> diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
> index 9a8c49547db..3040ea9324e 100644
> --- a/hw/arm/armsse.c
> +++ b/hw/arm/armsse.c
> @@ -505,11 +505,10 @@ static void armsse_realize(DeviceState *dev, Error **errp)
>           * the INITSVTOR* registers before powering up the CPUs in any case,
>           * so the hardware's default value doesn't matter. QEMU doesn't emulate
>           * the control processor, so instead we behave in the way that the
> -         * firmware does. All boards currently known about have firmware that
> -         * sets the INITSVTOR0 and INITSVTOR1 registers to 0x10000000, like the
> -         * IoTKit default. We can make this more configurable if necessary.
> +         * firmware does. The initial value is configurable by the board code
> +         * to match whatever its firmware does.
>           */
> -        qdev_prop_set_uint32(cpudev, "init-svtor", 0x10000000);
> +        qdev_prop_set_uint32(cpudev, "init-svtor", s->init_svtor);
>          /*
>           * Start all CPUs except CPU0 powered down. In real hardware it is
>           * a configurable property of the SSE-200 which CPUs start powered up
> @@ -1185,6 +1184,7 @@ static Property armsse_properties[] = {
>      DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
>      DEFINE_PROP_UINT32("MAINCLK", ARMSSE, mainclk_frq, 0),
>      DEFINE_PROP_UINT32("SRAM_ADDR_WIDTH", ARMSSE, sram_addr_width, 15),
> +    DEFINE_PROP_UINT32("init-svtor", ARMSSE, init_svtor, 0x10000000),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> 
