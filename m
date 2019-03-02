Received: from eggs.gnu.org ([209.51.188.92]:33203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0ACA-0005Ox-NC
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0AC9-0004PH-0L
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:21:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0AC8-0004N6-M3
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:21:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id t18so1290782wrx.2
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 11:21:12 -0800 (PST)
References: <20190122121413.31437-1-ysato@users.sourceforge.jp>
	<20190302062138.10713-1-ysato@users.sourceforge.jp>
	<20190302062138.10713-9-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c3a5e54c-e7f0-5102-fa56-ee5b42a021a7@redhat.com>
Date: Sat, 2 Mar 2019 20:21:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190302062138.10713-9-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v3 08/11] RX62N internal serial
 communication interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org

Hi Yoshinori,

On 3/2/19 7:21 AM, Yoshinori Sato wrote:
> This module supported only non FIFO type.
> Hardware manual.
> https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033ej0140_rx62n.pdf?key=086621e01bd70347c18ea7f794aa9cc3

This link also works without the trailing
"?key=086621e01bd70347c18ea7f794aa9cc3".

> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  hw/char/Makefile.objs         |   2 +-
>  hw/char/renesas_sci.c         | 288 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/char/renesas_sci.h |  42 ++++++

QEMU provides a git config helper to improve git diff by showing headers
first and C sources after: scripts/git.orderfile
I recommend you to look at it.

I'll review the header, then back to source.

>  3 files changed, 331 insertions(+), 1 deletion(-)
>  create mode 100644 hw/char/renesas_sci.c
>  create mode 100644 include/hw/char/renesas_sci.h
> 
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index c4947d7ae7..68eae7b9a5 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -15,7 +15,7 @@ common-obj-$(CONFIG_CADENCE) += cadence_uart.o
>  obj-$(CONFIG_EXYNOS4) += exynos4210_uart.o
>  obj-$(CONFIG_COLDFIRE) += mcf_uart.o
>  obj-$(CONFIG_OMAP) += omap_uart.o
> -obj-$(CONFIG_SH4) += sh_serial.o
> +obj-$(CONFIG_RENESAS_SCI) += renesas_sci.o
>  obj-$(CONFIG_PSERIES) += spapr_vty.o
>  obj-$(CONFIG_DIGIC) += digic-uart.o
>  obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
> diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
> new file mode 100644
> index 0000000000..56d070a329
> --- /dev/null
> +++ b/hw/char/renesas_sci.c
> @@ -0,0 +1,288 @@
> +/*
> + * Renesas Serial Communication Interface

I'd add here:

Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
(Rev.1.40 R01UH0033EJ0140)

> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "hw/char/renesas_sci.h"
> +#include "qemu/error-report.h"
> +
> +#define freq_to_ns(freq) (1000000000LL / freq)

You can directly use NANOSECONDS_PER_SECOND in update_trtime().

> +
> +static int can_receive(void *opaque)
> +{
> +    RSCIState *sci = RSCI(opaque);
> +    if (sci->rx_next > qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) {
> +        return 0;
> +    } else {
> +        return sci->scr & 0x10;

It is way easier to review a code using definitions generated by the
"hw/registerfields.h" API, a recent example is hw/char/cmsdk-apb-uart.c.

> +    }
> +}
> +
> +static void receive(void *opaque, const uint8_t *buf, int size)
> +{
> +    RSCIState *sci = RSCI(opaque);
> +    sci->rdr = buf[0];
> +    if (sci->ssr & 0x40 || size > 1) {
> +        sci->ssr |= 0x20;
> +        if (sci->scr & 0x40) {
> +            qemu_set_irq(sci->irq[ERI], 1);
> +        }
> +    } else {
> +        sci->ssr |= 0x40;
> +        sci->rx_next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime;
> +        if (sci->scr & 0x40) {
> +            qemu_set_irq(sci->irq[RXI], 1);
> +            qemu_set_irq(sci->irq[RXI], 0);

Both lines are equivalent to:

               qemu_irq_pulse(sci->irq[RXI]);

> +        }
> +    }
> +}
> +
> +static void send_byte(RSCIState *sci)
> +{
> +    if (qemu_chr_fe_backend_connected(&sci->chr)) {
> +        qemu_chr_fe_write_all(&sci->chr, &sci->tdr, 1);
> +    }
> +    timer_mod(sci->timer,
> +              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime);
> +    sci->ssr &= ~0x04;
> +    sci->ssr |= 0x80;
> +    qemu_set_irq(sci->irq[TEI], 0);
> +    if (sci->scr & 0x80) {
> +        qemu_set_irq(sci->irq[TXI], 1);
> +        qemu_set_irq(sci->irq[TXI], 0);
> +    }
> +}
> +
> +static void txend(void *opaque)
> +{
> +    RSCIState *sci = RSCI(opaque);
> +    if ((sci->ssr & 0x80) == 0) {
> +        send_byte(sci);
> +    } else {
> +        sci->ssr |= 0x04;
> +        if (sci->scr & 0x04) {
> +            qemu_set_irq(sci->irq[TEI], 1);
> +        }
> +    }
> +}
> +
> +static void update_trtime(RSCIState *sci)
> +{
> +    static const int div[] = {1, 4, 16, 64};
> +    int w;
> +
> +    w = (sci->smr & 0x40) ? 7 : 8;      /* CHR */
> +    w += (sci->smr >> 5) & 1;           /* PE */
> +    w += (sci->smr & 0x08) ? 2 : 1;     /* STOP */
> +    sci->trtime = w * freq_to_ns(sci->input_freq) *
> +        32 * div[sci->smr & 0x03] * sci->brr;

Or:

       sci->trtime   = (sci->smr & 0x40) ? 7 : 8;
       sci->trtime  += (sci->smr >> 5) & 1;
       sci->trtime  += (sci->smr & 0x08) ? 2 : 1;
       sci->trtime  *= 32 * sci->brr;
       sci->trtime <<= 2 * (sci->smr & 0x03);
       sci->trtime  *= NANOSECONDS_PER_SECOND;
       sci->trtime  /= sci->input_freq;

> +}
> +
> +static void sci_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> +{
> +    hwaddr offset = addr & 0x07;

You create the region with memory_region_init_io(size=8), so no need to &=7.

> +    RSCIState *sci = RSCI(opaque);
> +    int error = 0;
> +
> +    switch (offset) {
> +    case 0: /* SMR */
> +        if ((sci->scr & 0x30) == 0) {
> +            sci->smr = val;
> +            update_trtime(sci);
> +        }
> +        break;
> +    case 1: /* BRR */
> +        if ((sci->scr & 0x30) == 0) {
> +            sci->brr = val;
> +            update_trtime(sci);
> +        }
> +        break;
> +    case 2: /* SCR */
> +        sci->scr = val;
> +        if (sci->scr & 0x20) {
> +            sci->ssr |= 0x84;
> +            qemu_set_irq(sci->irq[TXI], 1);
> +            qemu_set_irq(sci->irq[TXI], 0);
> +        }
> +        if ((sci->scr & 0x04) == 0) {
> +            qemu_set_irq(sci->irq[TEI], 0);
> +        }
> +        if ((sci->scr & 0x40) == 0) {
> +            qemu_set_irq(sci->irq[ERI], 0);
> +        }
> +        break;
> +    case 3: /* TDR */
> +        sci->tdr = val;
> +        if (sci->ssr & 0x04) {
> +            send_byte(sci);
> +        } else{
> +            sci->ssr &= ~0x80;
> +        }
> +        break;
> +    case 4: /* SSR */
> +        sci->ssr &= ~0x38 | (val & 0x38);

This expression is not clear... Don't you want:

           sci->ssr &= ~0x38;
           sci->ssr |= val & 0x38;

> +        if (((sci->read_ssr & 0x38) ^ (sci->ssr & 0x38)) &&
> +            (sci->ssr & 0x38) == 0) {

Is this equivalent to:

           if ((sci->ssr & 0x38) == 0 && (sci->read_ssr & 0x38) != 0) {

> +            qemu_set_irq(sci->irq[ERI], 0);
> +        }
> +        break;
> +    case 5: /* RDR */
> +        error = 1; break;

Here error is due to read-only register, QEMU provides:

           qemu_log_mask(LOG_GUEST_ERROR, "Read only register: "...

> +    case 6: /* SCMR */
> +        sci->scmr = val; break;
> +    case 7: /* SEMR */
> +        sci->semr = val; break;
> +    }
> +
> +    if (error) {
> +        error_report("rsci: unsupported write request to %08lx", addr);

"unsupported" is not very clear, for unimplemented you can use:

           qemu_log_mask(LOG_UNIMP,
                         "Register XX not implemented\n");

> +    }
> +}
> +
> +static uint64_t sci_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    hwaddr offset = addr & 0x07;
> +    RSCIState *sci = RSCI(opaque);
> +    int error = 0;
> +    switch (offset) {
> +    case 0: /* SMR */
> +        return sci->smr;
> +    case 1: /* BRR */
> +        return sci->brr;
> +    case 2: /* SCR */
> +        return sci->scr;
> +    case 3: /* TDR */
> +        return sci->tdr;
> +    case 4: /* SSR */
> +        sci->read_ssr = sci->ssr;
> +        return sci->ssr;
> +    case 5: /* RDR */
> +        sci->ssr &= ~0x40;
> +        return sci->rdr;
> +    case 6: /* SCMR */
> +        return sci->scmr;
> +    case 7: /* SEMR */
> +        return sci->semr;
> +    }
> +
> +    if (error) {
> +        error_report("rsci: unsupported write request to %08lx", addr);
> +    }
> +    return -1;
> +}
> +
> +static const MemoryRegionOps sci_ops = {
> +    .write = sci_write,
> +    .read  = sci_read,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 1,

You can drop the implicit ".min_access_size = 1".

> +        .max_access_size = 1,
> +    },
> +};
> +
> +static void rsci_reset(DeviceState *dev)
> +{
> +    RSCIState *sci = RSCI(dev);
> +    sci->smr = sci->scr = 0x00;
> +    sci->brr = 0xff;
> +    sci->tdr = 0xff;
> +    sci->rdr = 0x00;
> +    sci->ssr = 0x84;
> +    sci->scmr = 0x00;
> +    sci->semr = 0x00;
> +    sci->rx_next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +}
> +
> +static void sci_event(void *opaque, int event)
> +{
> +    RSCIState *sci = RSCI(opaque);
> +    if (event == CHR_EVENT_BREAK) {
> +        sci->ssr |= 0x10;
> +        if (sci->scr & 0x40) {
> +            qemu_set_irq(sci->irq[ERI], 1);
> +        }
> +    }
> +}
> +
> +static void rsci_realize(DeviceState *dev, Error **errp)
> +{
> +    RSCIState *sci = RSCI(dev);
> +
> +    qemu_chr_fe_set_handlers(&sci->chr, can_receive, receive,
> +                             sci_event, NULL, sci, NULL, true);

You might want to check s->input_freq != 0 here.

> +}
> +
> +static void rsci_init(Object *obj)
> +{
> +    SysBusDevice *d = SYS_BUS_DEVICE(obj);
> +    RSCIState *sci = RSCI(obj);
> +    int i;
> +
> +    memory_region_init_io(&sci->memory, OBJECT(sci), &sci_ops,
> +                          sci, "renesas-sci", 0x8);
> +    sysbus_init_mmio(d, &sci->memory);
> +
> +    for (i = 0; i < 4; i++) {

4 -> ARRAY_COUNT(sci->irq) or SCI_IRQ_COUNT.

> +        sysbus_init_irq(d, &sci->irq[i]);
> +    }
> +    sci->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, txend, sci);
> +}
> +
> +static const VMStateDescription vmstate_rcmt = {
> +    .name = "renesas-sci",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static Property rsci_properties[] = {
> +    DEFINE_PROP_UINT64("input-freq", RSCIState, input_freq, 0),
> +    DEFINE_PROP_CHR("chardev", RSCIState, chr),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void rsci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = rsci_realize;
> +    dc->props = rsci_properties;
> +    dc->vmsd = &vmstate_rcmt;
> +    dc->reset = rsci_reset;
> +}
> +
> +static const TypeInfo rsci_info = {
> +    .name       = TYPE_RENESAS_SCI,
> +    .parent     = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(RSCIState),
> +    .instance_init = rsci_init,
> +    .class_init = rsci_class_init,
> +};
> +
> +static void rsci_register_types(void)
> +{
> +    type_register_static(&rsci_info);
> +}
> +
> +type_init(rsci_register_types)
> diff --git a/include/hw/char/renesas_sci.h b/include/hw/char/renesas_sci.h
> new file mode 100644
> index 0000000000..47e3e7a5d7
> --- /dev/null
> +++ b/include/hw/char/renesas_sci.h
> @@ -0,0 +1,42 @@
> +/*
> + * Renesas Serial Communication Interface
> + *
> + * Copyright (c) 2018 Yoshinori Sato
> + *
> + * This code is licensed under the GPL version 2 or later.
> + *
> + */
> +
> +#include "chardev/char-fe.h"
> +#include "qemu/timer.h"
> +#include "hw/sysbus.h"
> +
> +#define TYPE_RENESAS_SCI "renesas-sci"
> +#define RSCI(obj) OBJECT_CHECK(RSCIState, (obj), TYPE_RENESAS_SCI)
> +

Since those definitions are related, I recommend using:

enum SciIrqIndex {
    ERI = 0,
    RXI = 1,
    ...

> +#define ERI 0
> +#define RXI 1
> +#define TXI 2
> +#define TEI 3

   SCI_IRQ_COUNT = 4
};

> +
> +typedef struct {
> +    SysBusDevice parent_obj;
> +    MemoryRegion memory;
> +
> +    uint8_t smr;
> +    uint8_t brr;
> +    uint8_t scr;
> +    uint8_t tdr;
> +    uint8_t ssr;
> +    uint8_t rdr;
> +    uint8_t scmr;
> +    uint8_t semr;
> +
> +    uint8_t read_ssr;
> +    long long trtime;
> +    long long rx_next;

Can you use int64_t to keep both consistent?

> +    QEMUTimer *timer;
> +    CharBackend chr;
> +    uint64_t input_freq;
> +    qemu_irq irq[4];

Now you can use irq[SCI_IRQ_COUNT];

> +} RSCIState;
> 

Regards,

Phil.
