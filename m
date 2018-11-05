Received: from eggs.gnu.org ([2001:4830:134:3::10]:54825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJi2M-0002nA-AB
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJi2L-0005J9-7c
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:47:38 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJi2J-0005Dw-By
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:47:35 -0500
Received: by mail-oi1-x242.google.com with SMTP id v83-v6so8042645oia.5
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 08:47:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102170730.12432-9-contrib@steffen-goertz.de>
References: <20181102170730.12432-1-contrib@steffen-goertz.de>
	<20181102170730.12432-9-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 16:47:13 +0000
Message-ID: <CAFEAcA-om87hPdXCjUB5ueOoaRynYidrqQzvm1cf0YPwLjRRZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 08/13] hw/gpio/nrf51_gpio: Add nRF51
 GPIO peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On 2 November 2018 at 17:07, Steffen G=C3=B6rtz <contrib@steffen-goertz.de>=
 wrote:
> This adds a model of the nRF51 GPIO peripheral.
>
> Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
>
> The nRF51 series microcontrollers support up to 32 GPIO pins in various c=
onfigurations.
> The pins can be used as input pins with pull-ups or pull-down.
> Furthermore, three different output driver modes per level are
> available (disconnected, standard, high-current).
>
> The GPIO-Peripheral has a mechanism for detecting level changes which is
> not featured in this model.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Hi; I just had a few minor nits here...

> ---
>  Makefile.objs                |   1 +
>  hw/gpio/Makefile.objs        |   1 +
>  hw/gpio/nrf51_gpio.c         | 300 +++++++++++++++++++++++++++++++++++
>  hw/gpio/trace-events         |   7 +
>  include/hw/gpio/nrf51_gpio.h |  69 ++++++++
>  5 files changed, 378 insertions(+)
>  create mode 100644 hw/gpio/nrf51_gpio.c
>  create mode 100644 hw/gpio/trace-events
>  create mode 100644 include/hw/gpio/nrf51_gpio.h
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 1e1ff387d7..fbc3bad1e1 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -243,6 +243,7 @@ trace-events-subdirs +=3D hw/vfio
>  trace-events-subdirs +=3D hw/virtio
>  trace-events-subdirs +=3D hw/watchdog
>  trace-events-subdirs +=3D hw/xen
> +trace-events-subdirs +=3D hw/gpio
>  trace-events-subdirs +=3D io
>  trace-events-subdirs +=3D linux-user
>  trace-events-subdirs +=3D migration
> diff --git a/hw/gpio/Makefile.objs b/hw/gpio/Makefile.objs
> index fa0a72e6d0..e5da0cb54f 100644
> --- a/hw/gpio/Makefile.objs
> +++ b/hw/gpio/Makefile.objs
> @@ -8,3 +8,4 @@ common-obj-$(CONFIG_GPIO_KEY) +=3D gpio_key.o
>  obj-$(CONFIG_OMAP) +=3D omap_gpio.o
>  obj-$(CONFIG_IMX) +=3D imx_gpio.o
>  obj-$(CONFIG_RASPI) +=3D bcm2835_gpio.o
> +obj-$(CONFIG_NRF51_SOC) +=3D nrf51_gpio.o
> diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
> new file mode 100644
> index 0000000000..0a378e03ab
> --- /dev/null
> +++ b/hw/gpio/nrf51_gpio.c
> @@ -0,0 +1,300 @@
> +/*
> + * nRF51 System-on-Chip general purpose input/output register definition
> + *
> + * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.=
pdf
> + * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1.p=
df
> + *
> + * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/gpio/nrf51_gpio.h"
> +#include "trace.h"
> +
> +/*
> + * Check if the output driver is connected to the direction switch
> + * given the current configuration and logic level.
> + * It is not differentiated between standard and "high"(-power) drive mo=
des.
> + */
> +static bool is_connected(uint32_t config, uint32_t level)
> +{
> +    bool state;
> +    uint32_t drive_config =3D extract32(config, 8, 3);
> +
> +    switch (drive_config) {
> +    case 0 ... 3:
> +        state =3D true;
> +        break;
> +    case 4 ... 5:
> +        state =3D level !=3D 0;
> +        break;
> +    case 6 ... 7:
> +        state =3D level =3D=3D 0;
> +        break;
> +    default:
> +        /* Some compilers can not infer the value range of extract32(..,=
 3) */

Usually we handle this with g_assert_not_reached().

> +        state =3D false;
> +        break;
> +    }
> +
> +    return state;
> +}

> +static void nrf51_gpio_write(void *opaque, hwaddr offset,
> +                       uint64_t value, unsigned int size)
> +{
> +    NRF51GPIOState *s =3D NRF51_GPIO(opaque);
> +    size_t idx;
> +
> +    trace_nrf51_gpio_write(offset, value);
> +
> +    switch (offset) {
> +    case NRF51_GPIO_REG_OUT:
> +        s->out =3D value;
> +        break;
> +
> +    case NRF51_GPIO_REG_OUTSET:
> +        s->out |=3D value;
> +        break;
> +
> +    case NRF51_GPIO_REG_OUTCLR:
> +        s->out &=3D ~value;
> +        break;
> +
> +    case NRF51_GPIO_REG_DIR:
> +        s->dir =3D value;
> +        reflect_dir_bit_in_cnf(s);
> +        break;
> +
> +    case NRF51_GPIO_REG_DIRSET:
> +        s->dir |=3D value;
> +        reflect_dir_bit_in_cnf(s);
> +        break;
> +
> +    case NRF51_GPIO_REG_DIRCLR:
> +        s->dir &=3D ~value;
> +        reflect_dir_bit_in_cnf(s);
> +        break;
> +
> +    case NRF51_GPIO_REG_CNF_START ... NRF51_GPIO_REG_CNF_END:
> +        idx =3D (offset - NRF51_GPIO_REG_CNF_START) / 4;
> +        s->cnf[idx] =3D value;
> +        /* direction is exposed in both the DIR register and the DIR bit
> +         * of each PINs CNF configuration register. */

Nonstandard multiline comment format; see CODING_STYLE for the
preferred form.

> +        s->dir =3D (s->dir & ~(1UL << idx)) | ((value & 0x01) << idx);
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +    }
> +
> +    update_state(s);
> +}

> +
> +static const VMStateDescription vmstate_nrf51_gpio =3D {
> +    .name =3D TYPE_NRF51_GPIO,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .minimum_version_id_old =3D 1,

You don't need to specify minimum_version_id_old unless
you provide a load_state_old handler.

> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(out, NRF51GPIOState),
> +        VMSTATE_UINT32(in, NRF51GPIOState),
> +        VMSTATE_UINT32(in_mask, NRF51GPIOState),
> +        VMSTATE_UINT32(dir, NRF51GPIOState),
> +        VMSTATE_UINT32_ARRAY(cnf, NRF51GPIOState, NRF51_GPIO_PINS),
> +        VMSTATE_UINT32(old_out, NRF51GPIOState),
> +        VMSTATE_UINT32(old_out_connected, NRF51GPIOState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
