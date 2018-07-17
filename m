Received: from eggs.gnu.org ([2001:4830:134:3::10]:42592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffRH7-0002mf-PK
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffRH6-0007R8-Bj
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:48:25 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:37459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffRH6-0007Qt-6F
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:48:24 -0400
Received: by mail-oi0-x243.google.com with SMTP id k81-v6so2514371oib.4
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:48:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b8ec9c149fe42f3d3ea469c8d8680b2b87a81e35.1530395710.git.jcd@tribudubois.net>
References: <cover.1530395710.git.jcd@tribudubois.net>
	<b8ec9c149fe42f3d3ea469c8d8680b2b87a81e35.1530395710.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 15:48:03 +0100
Message-ID: <CAFEAcA-ZyZnb0J9sqAG3T=RwDcU5r956mPJvMgGEX_mbZgjgzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] i.MX6UL: Add i.MX6UL specific CCM
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Andrey Smirnov <andrew.smirnov@gmail.com>

On 30 June 2018 at 22:58, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>  hw/misc/Makefile.objs        |   1 +
>  hw/misc/imx6ul_ccm.c         | 887 +++++++++++++++++++++++++++++++++++
>  include/hw/misc/imx6ul_ccm.h | 228 +++++++++
>  3 files changed, 1116 insertions(+)
>  create mode 100644 hw/misc/imx6ul_ccm.c
>  create mode 100644 include/hw/misc/imx6ul_ccm.h
>
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 9350900845..51d27b3af1 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -36,6 +36,7 @@ obj-$(CONFIG_IMX) += imx_ccm.o
>  obj-$(CONFIG_IMX) += imx31_ccm.o
>  obj-$(CONFIG_IMX) += imx25_ccm.o
>  obj-$(CONFIG_IMX) += imx6_ccm.o
> +obj-$(CONFIG_IMX) += imx6ul_ccm.o
>  obj-$(CONFIG_IMX) += imx6_src.o
>  obj-$(CONFIG_IMX) += imx7_ccm.o
>  obj-$(CONFIG_IMX) += imx2_wdt.o
> diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
> new file mode 100644
> index 0000000000..fc894b087e
> --- /dev/null
> +++ b/hw/misc/imx6ul_ccm.c
> @@ -0,0 +1,887 @@
> +/*
> + * IMX6UL Clock Control Module
> + *
> + * Copyright (c) 2018 Jean-Christophe Dubois <jcd@tribudubois.net>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * To get the timer frequencies right, we need to emulate at least part of
> + * the CCM.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/misc/imx6ul_ccm.h"
> +#include "qemu/log.h"
> +
> +#ifndef DEBUG_IMX6UL_CCM
> +#define DEBUG_IMX6UL_CCM 0
> +#endif
> +
> +#define DPRINTF(fmt, args...) \
> +    do { \
> +        if (DEBUG_IMX6UL_CCM) { \
> +            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX6UL_CCM, \
> +                                             __func__, ##args); \
> +        } \
> +    } while (0)

Tracepoints would be preferable to more DPRINTF macros for
new devices, ideally.

> +static uint64_t imx6ul_ccm_get_periph_clk2_sel_clk(IMX6ULCCMState *dev)
> +{
> +    uint64_t freq = 0;
> +
> +    switch (EXTRACT(dev->ccm[CCM_CBCMR], PERIPH_CLK2_SEL)) {
> +    case 0:
> +        freq = imx6ul_analog_get_pll3_clk(dev);
> +        break;
> +    case 1:
> +        freq = imx6ul_analog_get_osc_clk(dev);
> +        break;
> +    case 2:
> +        freq = imx6ul_analog_pll2_bypass_clk(dev);
> +        break;

PERIPH_CLK2_SEL is a 2-bit field, right? Since there's
nothing that prevents the guest from writing 0b11 to it,
we need a case 3: here. (The guest should never be able
to trigger a QEMU assertion failure.)

> +    default:
> +        /* We should never get there */
> +        g_assert_not_reached();
> +        break;

You don't need a 'break' here, as execution never returns
from g_assert_not_reached(). The comment I think also
can be dropped -- it just tells you what you can already
determine from the g_assert_not_reached().

> +    }
> +
> +    DPRINTF("freq = %d\n", (uint32_t)freq);
> +
> +    return freq;
> +}


> +static uint64_t imx6ul_ccm_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    uint32_t value = 0;
> +    uint32_t index = offset >> 2;
> +    IMX6ULCCMState *s = (IMX6ULCCMState *)opaque;
> +
> +    value = s->ccm[index];

It looks like the index is forced to be in range by the size
of this MemoryRegion. An assertion here will help to convince
static analysis tools that this really can't overflow the array.
(Similarly in the write fn below.)

> +
> +    DPRINTF("reg[%s] => 0x%" PRIx32 "\n", imx6ul_ccm_reg_name(index), value);
> +
> +    return (uint64_t)value;
> +}
> +#define EXTRACT(value, name) extract32(value, name##_SHIFT, name##_LENGTH)

Please don't define ad-hoc extract macros. Either just use
extract32() directly, or use the macros that include/hw/registerfields.h
provides.

thanks
-- PMM
