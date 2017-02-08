Received: from eggs.gnu.org ([2001:4830:134:3::10]:43482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cbbZu-0000yZ-0D
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cbbZp-0008CQ-Vb
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:23:09 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:55706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cbbZp-0008BB-Le
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:23:05 -0500
References: <1486595166-34097-1-git-send-email-juro.bystricky@intel.com>
	<1486595166-34097-2-git-send-email-juro.bystricky@intel.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <4c51c959-fe9c-b27f-552a-84d8a2fe68c1@denx.de>
Date: Thu, 9 Feb 2017 00:22:55 +0100
MIME-Version: 1.0
In-Reply-To: <1486595166-34097-2-git-send-email-juro.bystricky@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] nios2: Add Altera JTAG UART
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juro Bystricky <juro.bystricky@intel.com>, qemu-devel@nongnu.org
Cc: crwulff@gmail.com, jurobystricky@hotmail.com

On 02/09/2017 12:06 AM, Juro Bystricky wrote:
> Hardware emulation based on:
> https://www.altera.com/en_US/pdfs/literature/ug/ug_embedded_ip.pdf

Please make the commit message a bit more verbose, looking just at the
commit message, I have no clue what patch I'm looking at. The embedded
IP UG also has like 30 cores in it, so some detail on which core and in
which chapter/page would help.

> Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
> ---
>  default-configs/nios2-softmmu.mak |   1 +
>  hw/char/Makefile.objs             |   1 +
>  hw/char/altera_juart.c            | 268 ++++++++++++++++++++++++++++++++++++++
>  include/hw/char/altera_juart.h    |  44 +++++++
>  4 files changed, 314 insertions(+)
>  create mode 100644 hw/char/altera_juart.c
>  create mode 100644 include/hw/char/altera_juart.h
> 
> diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
> index 74dc70c..6159846 100644
> --- a/default-configs/nios2-softmmu.mak
> +++ b/default-configs/nios2-softmmu.mak
> @@ -4,3 +4,4 @@ CONFIG_NIOS2=y
>  CONFIG_SERIAL=y
>  CONFIG_PTIMER=y
>  CONFIG_ALTERA_TIMER=y
> +CONFIG_ALTERA_JUART=y
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index 6ea76fe..f0d0e25 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -27,5 +27,6 @@ common-obj-$(CONFIG_LM32) += lm32_juart.o
>  common-obj-$(CONFIG_LM32) += lm32_uart.o
>  common-obj-$(CONFIG_MILKYMIST) += milkymist-uart.o
>  common-obj-$(CONFIG_SCLPCONSOLE) += sclpconsole.o sclpconsole-lm.o
> +common-obj-$(CONFIG_ALTERA_JUART) += altera_juart.o
>  
>  obj-$(CONFIG_VIRTIO) += virtio-serial-bus.o
> diff --git a/hw/char/altera_juart.c b/hw/char/altera_juart.c
> new file mode 100644
> index 0000000..f143167
> --- /dev/null
> +++ b/hw/char/altera_juart.c
> @@ -0,0 +1,268 @@
> +/*
> + * QEMU model of the Altera JTAG UART.
> + *
> + * Copyright (c) 2016-2017 Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.

Isn't QEMU GPLv2 only and NOT GPLv2+ ?

> + * The Altera JTAG UART hardware registers are described in:
> + * https://www.altera.com/en_US/pdfs/literature/ug/ug_embedded_ip.pdf
> + *

Drop the trailing newline

> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/char/altera_juart.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/error-report.h"
> +
> +/* Data register */
> +#define R_DATA      0
> +#define DATA_RVALID     BIT(15)
> +#define DATA_RAVAIL     0xFFFF0000
> +
> +/* Control register */
> +#define R_CONTROL   1
> +#define CONTROL_RE      BIT(0)
> +#define CONTROL_WE      BIT(1)
> +#define CONTROL_RI      BIT(8)
> +#define CONTROL_WI      BIT(9)
> +#define CONTROL_AC      BIT(10)
> +#define CONTROL_WSPACE  0xFFFF0000
> +
> +#define CONTROL_WMASK (CONTROL_RE | CONTROL_WE | CONTROL_AC)
> +
> +#define TYPE_ALTERA_JUART "altera-juart"
> +#define ALTERA_JUART(obj) \
> +    OBJECT_CHECK(AlteraJUARTState, (obj), TYPE_ALTERA_JUART)
> +
> +/*
> + * The JTAG UART core generates an interrupt when either of the individual
> + * interrupt conditions is pending and enabled.
> + */
> +static void altera_juart_update_irq(AlteraJUARTState *s)
> +{
> +    unsigned int irq;
> +
> +    irq = ((s->jcontrol & CONTROL_WE) && (s->jcontrol & CONTROL_WI)) ||
> +          ((s->jcontrol & CONTROL_RE) && (s->jcontrol & CONTROL_RI));
> +
> +    qemu_set_irq(s->irq, irq);
> +}
> +
> +static uint64_t altera_juart_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    AlteraJUARTState *s = opaque;
> +    uint32_t r;
> +
> +    addr >>= 2;

Hmmmmm, how will unaligned read from one of these registers be handled
on real HW ? ie. read from address 0x3 ? What about writes ?

> +    switch (addr) {
> +    case R_DATA:
> +        r = s->rx_fifo[(s->rx_fifo_pos - s->rx_fifo_len) & (FIFO_LENGTH - 1)];
> +        if (s->rx_fifo_len) {
> +            s->rx_fifo_len--;
> +            qemu_chr_fe_accept_input(&s->chr);
> +            s->jdata = r | DATA_RVALID | (s->rx_fifo_len << 16);
> +            s->jcontrol |= CONTROL_RI;
> +        } else {
> +            s->jdata = 0;
> +            s->jcontrol &= ~CONTROL_RI;
> +        }
> +
> +        altera_juart_update_irq(s);
> +        return s->jdata;
> +
> +    case R_CONTROL:
> +        return s->jcontrol;
> +    }
> +
> +    return 0;
> +}
> +
> +static void altera_juart_write(void *opaque, hwaddr addr,
> +                       uint64_t val64, unsigned int size)
> +{
> +    AlteraJUARTState *s = opaque;
> +    uint32_t value = val64;

Is this needed ?

> +    unsigned char c;
> +
> +    addr >>= 2;
> +
> +    switch (addr) {
> +    case R_DATA:
> +        c = value & 0xFF;
> +        /*
> +         * We do not decrement the write fifo,
> +         * we "tranmsmit" instanteniously, CONTROL_WI always asserted
> +         */
> +        s->jcontrol |= CONTROL_WI;
> +        s->jdata = c;
> +        qemu_chr_fe_write(&s->chr, &c, 1);
> +        altera_juart_update_irq(s);
> +        break;
> +
> +    case R_CONTROL:
> +        /* Only RE and WE are writable */
> +        value &= CONTROL_WMASK;
> +        s->jcontrol &= ~(CONTROL_WMASK);

The parenthesis are not needed.

> +        s->jcontrol |= value;
> +
> +        /* Writing 1 to AC clears it to 0 */
> +        if (value & CONTROL_AC) {
> +            s->jcontrol &= ~CONTROL_AC;
> +        }
> +        altera_juart_update_irq(s);
> +        break;
> +    }
> +}
> +
> +static void altera_juart_receive(void *opaque, const uint8_t *buf, int size)
> +{
> +    int i;
> +    AlteraJUARTState *s = opaque;
> +
> +    if (s->rx_fifo_len >= FIFO_LENGTH) {
> +        fprintf(stderr, "WARNING: UART dropped char.\n");

Can this ever happen ? can_receive will IMO prevent this case.

> +        return;
> +    }
> +
> +    for (i = 0; i < size; i++) {
> +        s->rx_fifo[s->rx_fifo_pos] = buf[i];
> +        s->rx_fifo_pos++;
> +        s->rx_fifo_pos &= (FIFO_LENGTH - 1);
> +        s->rx_fifo_len++;
> +    }
> +    s->jcontrol |= CONTROL_RI;
> +    altera_juart_update_irq(s);
> +}

[...]

> diff --git a/include/hw/char/altera_juart.h b/include/hw/char/altera_juart.h
> new file mode 100644
> index 0000000..8a9c892
> --- /dev/null
> +++ b/include/hw/char/altera_juart.h
> @@ -0,0 +1,44 @@
> +/*
> + * Altera JTAG UART emulation
> + *
> + * Copyright (c) 2016-2017 Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef ALTERA_JUART_H
> +#define ALTERA_JUART_H
> +
> +#include "hw/sysbus.h"
> +#include "sysemu/char.h"
> +
> +/*
> + * The read and write FIFO depths can be set from 8 to 32,768 bytes.
> + * Only powers of two are allowed. A depth of 64 is generally optimal for
> + * performance, and larger values are rarely necessary.
> + */
> +
> +#define FIFO_LENGTH 64

Should probably be a QOM property, no ?

> +typedef struct AlteraJUARTState {
> +    SysBusDevice busdev;
> +    MemoryRegion mmio;
> +    CharBackend chr;
> +    qemu_irq irq;
> +
> +    unsigned int rx_fifo_pos;
> +    unsigned int rx_fifo_len;
> +    uint32_t jdata;
> +    uint32_t jcontrol;
> +    uint8_t rx_fifo[FIFO_LENGTH];
> +} AlteraJUARTState;
> +
> +void altera_juart_create(int channel, const hwaddr addr, qemu_irq irq);
> +
> +#endif /* ALTERA_JUART_H */
> 
btw for trivial patches like this, cover letter is not necessary .

-- 
Best regards,
Marek Vasut
