Received: from eggs.gnu.org ([2001:4830:134:3::10]:37790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eXL6E-0007cW-03
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eXL6B-0007sz-4Y
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:03:26 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:43557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eXL6A-0007sh-PV
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:03:22 -0500
Received: by mail-oi0-x244.google.com with SMTP id f69so2511530oig.10
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 22:03:22 -0800 (PST)
MIME-Version: 1.0
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-18-git-send-email-mjc@sifive.com>
	<20180105000725.5a6842a007586b4fbe1ffb5e@gmail.com>
In-Reply-To: <20180105000725.5a6842a007586b4fbe1ffb5e@gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 05 Jan 2018 06:03:11 +0000
Message-ID: <CAHNT7NvEuKe_-MEJwV7MMdLUBkX7QB53nffCSG0DALkM8gGSgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 17/21] SiFive RISC-V UART Device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org

On Fri, 5 Jan 2018 at 9:53 AM, Antony Pavlov <antonynpavlov@gmail.com>
wrote:

> On Wed,  3 Jan 2018 13:44:21 +1300
> Michael Clark <mjc@sifive.com> wrote:
>
> > QEMU model of the UART on the SiFive E300 and U500 series SOCs.
> > BBL supports the SiFive UART for early console access via the SBI
> > (Supervisor Binary Interface) and the linux kernel SBI console.
> >
> > The SiFive UART implements the pre qom legacy interface consistent
> > with the 16550a UART in 'hw/char/serial.c'.
> >
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > ---
> >  hw/riscv/sifive_uart.c         | 182
> +++++++++++++++++++++++++++++++++++++++++
> >  include/hw/riscv/sifive_uart.h |  76 +++++++++++++++++
> >  2 files changed, 258 insertions(+)
> >  create mode 100644 hw/riscv/sifive_uart.c
> >  create mode 100644 include/hw/riscv/sifive_uart.h
> >
> > diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
> > new file mode 100644
> > index 0000000..0e73df6
> > --- /dev/null
> > +++ b/hw/riscv/sifive_uart.c
> > @@ -0,0 +1,182 @@
> > +/*
> > + * QEMU model of the UART on the SiFive E300 and U500 series SOCs.
> > + *
> > + * Copyright (c) 2016 Stefan O'Rear
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> obtaining a copy
> > + * of this software and associated documentation files (the
> "Software"), to deal
> > + * in the Software without restriction, including without limitation
> the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r
> sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
> OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "hw/sysbus.h"
> > +#include "chardev/char.h"
> > +#include "chardev/char-fe.h"
> > +#include "target/riscv/cpu.h"
> > +#include "hw/riscv/sifive_uart.h"
> > +
> > +/*
> > + * Not yet implemented:
> > + *
> > + * Transmit FIFO using "qemu/fifo8.h"
> > + * SIFIVE_UART_IE_TXWM interrupts
> > + * SIFIVE_UART_IE_RXWM interrupts must honor fifo watermark
> > + * Rx FIFO watermark interrupt trigger threshold
> > + * Tx FIFO watermark interrupt trigger threshold.
> > + */
> > +
> > +static void update_irq(SiFiveUARTState *s)
> > +{
> > +    int cond =3D 0;
> > +    if ((s->ie & SIFIVE_UART_IE_RXWM) && s->rx_fifo_len) {
> > +        cond =3D 1;
> > +    }
> > +    if (cond) {
> > +        qemu_irq_raise(s->irq);
> > +    } else {
> > +        qemu_irq_lower(s->irq);
> > +    }
> > +}
> > +
> > +static uint64_t
> > +uart_read(void *opaque, hwaddr addr, unsigned int size)
> > +{
> > +    SiFiveUARTState *s =3D opaque;
> > +    unsigned char r;
> > +    switch (addr) {
> > +    case SIFIVE_UART_RXFIFO:
> > +        if (s->rx_fifo_len) {
> > +            r =3D s->rx_fifo[0];
> > +            memmove(s->rx_fifo, s->rx_fifo + 1, s->rx_fifo_len - 1);
> > +            s->rx_fifo_len--;
>
> qemu already has code for FIFO implementation.
>
> Can we use Fifo8 as hw/char/serial.c does?
>
> Please see my 'hw/sifive_uart: use generic Fifo8' patch:
>
>
> https://github.com/riscv/riscv-qemu/pull/60/commits/6d68a4bc9a617b72ec563=
f72e58e2467998d5c4b
>

Yeah sure, we can. I commented on the PR and it=E2=80=99s still open but th=
e patch
needs to be rebased. You=E2=80=99ll notice this comment in the file.

+/*
> + * Not yet implemented:
> + *
> + * Transmit FIFO using "qemu/fifo8.h"
...

>
>
> > +            qemu_chr_fe_accept_input(&s->chr);
> > +            update_irq(s);
> > +            return r;
> > +        }
> > +        return 0x80000000;
> > +
> > +    case SIFIVE_UART_TXFIFO:
> > +        return 0; /* Should check tx fifo */
> > +    case SIFIVE_UART_IE:
> > +        return s->ie;
> > +    case SIFIVE_UART_IP:
> > +        return s->rx_fifo_len ? SIFIVE_UART_IP_RXWM : 0;
> > +    case SIFIVE_UART_TXCTRL:
> > +        return s->txctrl;
> > +    case SIFIVE_UART_RXCTRL:
> > +        return s->rxctrl;
> > +    case SIFIVE_UART_DIV:
> > +        return s->div;
> > +    }
> > +
> > +    hw_error("%s: bad read: addr=3D0x%x\n",
> > +        __func__, (int)addr);
> > +    return 0;
> > +}
> > +
> > +static void
> > +uart_write(void *opaque, hwaddr addr,
> > +           uint64_t val64, unsigned int size)
> > +{
> > +    SiFiveUARTState *s =3D opaque;
> > +    uint32_t value =3D val64;
> > +    unsigned char ch =3D value;
> > +
> > +    switch (addr) {
> > +    case SIFIVE_UART_TXFIFO:
> > +        qemu_chr_fe_write(&s->chr, &ch, 1);
> > +        return;
> > +    case SIFIVE_UART_IE:
> > +        s->ie =3D val64;
> > +        update_irq(s);
> > +        return;
> > +    case SIFIVE_UART_TXCTRL:
> > +        s->txctrl =3D val64;
> > +        return;
> > +    case SIFIVE_UART_RXCTRL:
> > +        s->rxctrl =3D val64;
> > +        return;
> > +    case SIFIVE_UART_DIV:
> > +        s->div =3D val64;
> > +        return;
> > +    }
> > +    hw_error("%s: bad write: addr=3D0x%x v=3D0x%x\n",
> > +        __func__, (int)addr, (int)value);
> > +}
> > +
> > +static const MemoryRegionOps uart_ops =3D {
> > +    .read =3D uart_read,
> > +    .write =3D uart_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4
> > +    }
> > +};
> > +
> > +static void uart_rx(void *opaque, const uint8_t *buf, int size)
> > +{
> > +    SiFiveUARTState *s =3D opaque;
> > +
> > +    /* Got a byte.  */
> > +    if (s->rx_fifo_len >=3D sizeof(s->rx_fifo)) {
> > +        printf("WARNING: UART dropped char.\n");
> > +        return;
> > +    }
> > +    s->rx_fifo[s->rx_fifo_len++] =3D *buf;
> > +
> > +    update_irq(s);
> > +}
> > +
> > +static int uart_can_rx(void *opaque)
> > +{
> > +    SiFiveUARTState *s =3D opaque;
> > +
> > +    return s->rx_fifo_len < sizeof(s->rx_fifo);
> > +}
> > +
> > +static void uart_event(void *opaque, int event)
> > +{
> > +}
> > +
> > +static int uart_be_change(void *opaque)
> > +{
> > +    SiFiveUARTState *s =3D opaque;
> > +
> > +    qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx, uart_event=
,
> > +        uart_be_change, s, NULL, true);
> > +
> > +    return 0;
> > +}
> > +
> > +/*
> > + * Create UART device.
> > + */
> > +SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwadd=
r
> base,
> > +    Chardev *chr, qemu_irq irq)
> > +{
> > +    SiFiveUARTState *s =3D g_malloc0(sizeof(SiFiveUARTState));
> > +    s->irq =3D irq;
> > +    qemu_chr_fe_init(&s->chr, chr, &error_abort);
> > +    qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx, uart_event=
,
> > +        uart_be_change, s, NULL, true);
> > +    memory_region_init_io(&s->mmio, NULL, &uart_ops, s,
> > +                          TYPE_SIFIVE_UART, SIFIVE_UART_MAX);
> > +    memory_region_add_subregion(address_space, base, &s->mmio);
> > +    return s;
> > +}
> > diff --git a/include/hw/riscv/sifive_uart.h
> b/include/hw/riscv/sifive_uart.h
> > new file mode 100644
> > index 0000000..1ab0106
> > --- /dev/null
> > +++ b/include/hw/riscv/sifive_uart.h
> > @@ -0,0 +1,76 @@
> > +/*
> > + * SiFive UART interface
> > + *
> > + * Copyright (c) 2017 SiFive, Inc.
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> obtaining a copy
> > + * of this software and associated documentation files (the
> "Software"), to deal
> > + * in the Software without restriction, including without limitation
> the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r
> sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
> OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#ifndef HW_SIFIVE_UART_H
> > +#define HW_SIFIVE_UART_H
> > +
> > +enum {
> > +    SIFIVE_UART_TXFIFO        =3D 0,
> > +    SIFIVE_UART_RXFIFO        =3D 4,
> > +    SIFIVE_UART_TXCTRL        =3D 8,
> > +    SIFIVE_UART_TXMARK        =3D 10,
> > +    SIFIVE_UART_RXCTRL        =3D 12,
> > +    SIFIVE_UART_RXMARK        =3D 14,
> > +    SIFIVE_UART_IE            =3D 16,
> > +    SIFIVE_UART_IP            =3D 20,
> > +    SIFIVE_UART_DIV           =3D 24,
> > +    SIFIVE_UART_MAX           =3D 32
> > +};
> > +
> > +enum {
> > +    SIFIVE_UART_IE_TXWM       =3D 1, /* Transmit watermark interrupt
> enable */
> > +    SIFIVE_UART_IE_RXWM       =3D 2  /* Receive watermark interrupt
> enable */
> > +};
> > +
> > +enum {
> > +    SIFIVE_UART_IP_TXWM       =3D 1, /* Transmit watermark interrupt
> pending */
> > +    SIFIVE_UART_IP_RXWM       =3D 2  /* Receive watermark interrupt
> pending */
> > +};
> > +
> > +#define TYPE_SIFIVE_UART "riscv.sifive.uart"
> > +
> > +#define SIFIVE_UART(obj) \
> > +    OBJECT_CHECK(SiFiveUARTState, (obj), TYPE_SIFIVE_UART)
> > +
> > +typedef struct SiFiveUARTState {
> > +    /*< private >*/
> > +    SysBusDevice parent_obj;
> > +
> > +    /*< public >*/
> > +    qemu_irq irq;
> > +    MemoryRegion mmio;
> > +    CharBackend chr;
> > +    uint8_t rx_fifo[8];
> > +    unsigned int rx_fifo_len;
> > +    uint32_t ie;
> > +    uint32_t ip;
> > +    uint32_t txctrl;
> > +    uint32_t rxctrl;
> > +    uint32_t div;
> > +} SiFiveUARTState;
> > +
> > +SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwadd=
r
> base,
> > +    Chardev *chr, qemu_irq irq);
> > +
> > +#endif
> > --
> > 2.7.0
> >
> >
>
>
> --
> Best regards,
>   Antony Pavlov
>
