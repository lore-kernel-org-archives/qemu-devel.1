Received: from eggs.gnu.org ([2001:4830:134:3::10]:55111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgylV-0002N7-MM
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgylU-0002W3-C2
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:09:21 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:33172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgylU-0002Vj-2x
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:09:20 -0500
Received: by mail-wm0-x231.google.com with SMTP id t18so4987455wmt.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 11:09:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170222112338.25492-3-clement.deschamps@antfield.fr>
References: <20170222112338.25492-1-clement.deschamps@antfield.fr>
	<20170222112338.25492-3-clement.deschamps@antfield.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 19:08:58 +0000
Message-ID: <CAFEAcA_jPaQxfoXKz82WaQ+62krkbQ7RCm66DeELj30jOE7_Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 2/3] bcm2835_gpio: add bcm2835 gpio
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Clement Deschamps <clement.deschamps@antfield.fr>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Baumann <andrew.baumann@microsoft.com>

On 22 February 2017 at 11:23, Clement Deschamps
<clement.deschamps@antfield.fr> wrote:
> This adds the BCM2835 GPIO controller.
>
> It implements:
> - The 54 GPIOs as outputs (qemu_irq)
> - The SD controller selection via alternate function of GPIOs 48-53
>
> Signed-off-by: Clement Deschamps <clement.deschamps@antfield.fr>
> ---
>  hw/gpio/Makefile.objs          |   1 +
>  hw/gpio/bcm2835_gpio.c         | 361 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/gpio/bcm2835_gpio.h |  38 +++++
>  3 files changed, 400 insertions(+)
>  create mode 100644 hw/gpio/bcm2835_gpio.c
>  create mode 100644 include/hw/gpio/bcm2835_gpio.h
>
> diff --git a/hw/gpio/Makefile.objs b/hw/gpio/Makefile.objs
> index a43c7cf442..fa0a72e6d0 100644
> --- a/hw/gpio/Makefile.objs
> +++ b/hw/gpio/Makefile.objs
> @@ -7,3 +7,4 @@ common-obj-$(CONFIG_GPIO_KEY) += gpio_key.o
>
>  obj-$(CONFIG_OMAP) += omap_gpio.o
>  obj-$(CONFIG_IMX) += imx_gpio.o
> +obj-$(CONFIG_RASPI) += bcm2835_gpio.o
> diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
> new file mode 100644
> index 0000000000..a75f0ebb6b
> --- /dev/null
> +++ b/hw/gpio/bcm2835_gpio.c
> @@ -0,0 +1,361 @@
> +/*
> + * Raspberry Pi (BCM2835) GPIO Controller
> + *
> + * Copyright (c) 2017 Antfield SAS
> + *
> + * Authors:
> + *  Clement Deschamps <clement.deschamps@antfield.fr>
> + *  Luc Michel <luc.michel@antfield.fr>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/timer.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "hw/sd/sd.h"
> +#include "hw/gpio/bcm2835_gpio.h"
> +
> +#define GPFSEL0   0x00
> +#define GPFSEL1   0x04
> +#define GPFSEL2   0x08
> +#define GPFSEL3   0x0C
> +#define GPFSEL4   0x10
> +#define GPFSEL5   0x14
> +#define GPSET0    0x1C
> +#define GPSET1    0x20
> +#define GPCLR0    0x28
> +#define GPCLR1    0x2C
> +#define GPLEV0    0x34
> +#define GPLEV1    0x38
> +#define GPEDS0    0x40
> +#define GPEDS1    0x44
> +#define GPREN0    0x4C
> +#define GPREN1    0x50
> +#define GPFEN0    0x58
> +#define GPFEN1    0x5C
> +#define GPHEN0    0x64
> +#define GPHEN1    0x68
> +#define GPLEN0    0x70
> +#define GPLEN1    0x74
> +#define GPAREN0   0x7C
> +#define GPAREN1   0x80
> +#define GPAFEN0   0x88
> +#define GPAFEN1   0x8C
> +#define GPPUD     0x94
> +#define GPPUDCLK0 0x98
> +#define GPPUDCLK1 0x9C
> +
> +static uint32_t gpfsel_get(BCM2835GpioState *s, uint8_t reg)
> +{
> +    int i;
> +    uint32_t value = 0;
> +    for (i = 0; i < 10; i++) {
> +        uint32_t index = 10 * reg + i;
> +        if (index < sizeof(s->fsel)) {
> +            value |= (s->fsel[index] & 0x7) << (3 * i);
> +        }
> +    }
> +    return value;
> +}
> +
> +static void sdbus_reparent_card(SDBus *from, SDBus *to)
> +{
> +    BusChild *kid = QTAILQ_FIRST(&from->qbus.children);
> +    if(kid == NULL) {
> +        return;
> +    }
> +    SDState *card = SD_CARD(kid->child);

This inlining of get_card() suggests to me that we want this function
to be defined in hw/sd/core.c, rather than here.

> +    sdbus_set_inserted(from, false);
> +    object_unparent(OBJECT(kid));
> +    qdev_set_parent_bus(DEVICE(card), &to->qbus);
> +    sdbus_set_inserted(to, true);

I think we probably also want to call
 sdbus_set_readonly(to, readonly)
to tell the destination controller the r/o state.
(compare sd_cardchange(), though here we'll need to use
sc->get_readonly() like sdbus_get_readonly() does).

Do we also need to call the SD card object's reset method?

A comment to the effect of:
/* We directly reparent the card object rather than implementing this
 * as a hotpluggable connection because we don't want to expose SD cards
 * to users as being hotpluggable, and we can get away with it in this
 * limited use case. This could perhaps be implemented more cleanly in
 * future by adding support to the hotplug infrastructure for "device
 * can be hotplugged only via code, not by user".
 */

will also be helpful for alerting future readers to the fact
we're doing something pragmatic-but-not-ideal here.

> +}
> +
> +static void gpfsel_set(BCM2835GpioState *s, uint8_t reg, uint32_t value)
> +{
> +    int i;
> +    for (i = 0; i < 10; i++) {
> +        uint32_t index = 10 * reg + i;
> +        if (index < sizeof(s->fsel)) {
> +            int fsel = (value >> (3 * i)) & 0x7;
> +            s->fsel[index] = fsel;
> +        }
> +    }
> +
> +    /* SD controller selection (48-53) */
> +    if (s->sd_fsel != 0
> +            && (s->fsel[48] == 0) /* SD_CLK_R */
> +            && (s->fsel[49] == 0) /* SD_CMD_R */
> +            && (s->fsel[50] == 0) /* SD_DATA0_R */
> +            && (s->fsel[51] == 0) /* SD_DATA1_R */
> +            && (s->fsel[52] == 0) /* SD_DATA2_R */
> +            && (s->fsel[53] == 0) /* SD_DATA3_R */
> +            ) {
> +        /* SDHCI controller selected */
> +        sdbus_reparent_card(&s->sdhost->sdbus, &s->sdhci->sdbus);
> +        s->sd_fsel = 0;
> +    } else if (s->sd_fsel != 4
> +            && (s->fsel[48] == 4) /* SD_CLK_R */
> +            && (s->fsel[49] == 4) /* SD_CMD_R */
> +            && (s->fsel[50] == 4) /* SD_DATA0_R */
> +            && (s->fsel[51] == 4) /* SD_DATA1_R */
> +            && (s->fsel[52] == 4) /* SD_DATA2_R */
> +            && (s->fsel[53] == 4) /* SD_DATA3_R */
> +            ) {
> +        /* SDHost controller selected */
> +        sdbus_reparent_card(&s->sdhci->sdbus, &s->sdhost->sdbus);

It would I think be slightly neater to model this as the
GPIO object exposing an sdbus itself and only taking the
sdbus links from the two controller objects, rather than
taking links to the controllers themselves and grabbing the
sdbus fields out of them. But this isn't user-visible, so
I don't care too much. (We can always come back and tidy it
up later.)

Apart from my comments above about the card-reparenting function
this looks OK to me (and I'd like to squeeze it into 2.9 if we
can; deadline for "patches reviewed and in pull requests is very
near though, 28th).

thanks
-- PMM
