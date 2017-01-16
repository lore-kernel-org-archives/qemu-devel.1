Received: from eggs.gnu.org ([2001:4830:134:3::10]:42241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cTFtR-00005E-OP
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cTFtN-0002kj-Am
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:36:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:52319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cTFtN-0002kb-0M
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:36:45 -0500
References: <20161231132226.9595-1-marex@denx.de>
	<20161231132226.9595-5-marex@denx.de>
From: Alexander Graf <agraf@suse.de>
Message-ID: <e3bb53cc-e0d6-9eb7-33d8-ad23b4f70d3c@suse.de>
Date: Mon, 16 Jan 2017 23:36:41 +0100
MIME-Version: 1.0
In-Reply-To: <20161231132226.9595-5-marex@denx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 5/7] nios2: Add periodic timer emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>, qemu-devel@nongnu.org
Cc: Jeff Da Silva <jdasilva@altera.com>, Chris Wulff <crwulff@gmail.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Ley Foon Tan <lftan@altera.com>



On 31/12/2016 14:22, Marek Vasut wrote:
> From: Chris Wulff <crwulff@gmail.com>
>
> Add the Altera timer model.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Jeff Da Silva <jdasilva@altera.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Sandra Loosemore <sandra@codesourcery.com>
> Cc: Yves Vandervennet <yvanderv@altera.com>
> ---
> V3: Checkpatch cleanup
> V4: Rebase on top of qemu/master
> ---
>  hw/timer/Makefile.objs  |   1 +
>  hw/timer/altera_timer.c | 237 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 238 insertions(+)
>  create mode 100644 hw/timer/altera_timer.c
>
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 7ba8c23..0867a64 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -18,6 +18,7 @@ common-obj-$(CONFIG_IMX) += imx_gpt.o
>  common-obj-$(CONFIG_LM32) += lm32_timer.o
>  common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
>
> +obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
>  obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
>  obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
>  obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
> diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
> new file mode 100644
> index 0000000..885242b
> --- /dev/null
> +++ b/hw/timer/altera_timer.c
> @@ -0,0 +1,237 @@
> +/*
> + * QEMU model of the Altera timer.
> + *
> + * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qapi/error.h"
> +
> +#include "hw/sysbus.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/ptimer.h"
> +
> +#define R_STATUS      0
> +#define R_CONTROL     1
> +#define R_PERIODL     2
> +#define R_PERIODH     3
> +#define R_SNAPL       4
> +#define R_SNAPH       5
> +#define R_MAX         6
> +
> +#define STATUS_TO     0x0001
> +#define STATUS_RUN    0x0002
> +
> +#define CONTROL_ITO   0x0001
> +#define CONTROL_CONT  0x0002
> +#define CONTROL_START 0x0004
> +#define CONTROL_STOP  0x0008
> +
> +#define TYPE_ALTERA_TIMER "ALTR.timer"
> +#define ALTERA_TIMER(obj) \
> +    OBJECT_CHECK(AlteraTimer, (obj), TYPE_ALTERA_TIMER)
> +
> +typedef struct AlteraTimer {
> +    SysBusDevice  busdev;
> +    MemoryRegion  mmio;
> +    qemu_irq      irq;
> +    uint32_t      freq_hz;
> +    QEMUBH       *bh;
> +    ptimer_state *ptimer;
> +    uint32_t      regs[R_MAX];
> +} AlteraTimer;
> +
> +static int timer_irq_state(AlteraTimer *t)
> +{
> +    bool irq = (t->regs[R_STATUS] & STATUS_TO) &&
> +               (t->regs[R_CONTROL] & CONTROL_ITO);
> +    return irq;
> +}
> +
> +static uint64_t timer_read(void *opaque, hwaddr addr,
> +                           unsigned int size)
> +{
> +    AlteraTimer *t = opaque;
> +    uint64_t r = 0;
> +
> +    addr >>= 2;
> +    addr &= 0x7;

You don't need that & here (and below). The ANDing of addresses stems 
from pre-memregion days where you would get the physical address as 
"addr" argument rather than the offset in your region.

> +    switch (addr) {
> +    case R_CONTROL:
> +        r = t->regs[R_CONTROL] & (CONTROL_ITO | CONTROL_CONT);
> +        break;
> +
> +    default:
> +        if (addr < ARRAY_SIZE(t->regs)) {
> +            r = t->regs[addr];
> +        }
> +        break;
> +    }
> +
> +    return r;
> +}
> +
> +static void timer_write(void *opaque, hwaddr addr,
> +                        uint64_t value, unsigned int size)
> +{
> +    AlteraTimer *t = opaque;
> +    uint64_t tvalue;
> +    uint32_t count = 0;
> +    int irqState = timer_irq_state(t);
> +
> +    addr >>= 2;
> +    addr &= 0x7;

^

Other than that, lgtm.

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex
