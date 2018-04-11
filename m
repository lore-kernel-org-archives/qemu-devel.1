Received: from eggs.gnu.org ([2001:4830:134:3::10]:35042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f6N2K-0005tr-9C
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 17:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f6N2H-0000Fa-2o
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 17:12:12 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:40535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f6N2G-0000F8-Pn
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 17:12:09 -0400
Received: by mail-ot0-x242.google.com with SMTP id j8-v6so3617715ota.7
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 14:12:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410110417.554bc8911fb2e2f0a3d99b2d@gmail.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-20-git-send-email-mjc@sifive.com>
	<20180410062157.0f5876180d0ff5c89dd80393@gmail.com>
	<949f3787-7899-73ba-6c80-d3c20af68fda@redhat.com>
	<20180410110417.554bc8911fb2e2f0a3d99b2d@gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 12 Apr 2018 09:12:07 +1200
Message-ID: <CAHNT7NvEmf0ys6QXk5aLVGB73okjukNb9SoWVeuQu87a3XaTPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 19/23] SiFive RISC-V UART Device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Stefan O'Rear <sorear2@gmail.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Eric Blake <eblake@redhat.com>

On Tue, Apr 10, 2018 at 8:04 PM, Antony Pavlov <antonynpavlov@gmail.com>
wrote:

> On Tue, 10 Apr 2018 08:17:32 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>
> > On 10.04.2018 05:21, Antony Pavlov wrote:
> > > On Sat,  3 Mar 2018 02:51:47 +1300
> > > Michael Clark <mjc@sifive.com> wrote:
> > >
> > >> QEMU model of the UART on the SiFive E300 and U500 series SOCs.
> > >> BBL supports the SiFive UART for early console access via the SBI
> > >> (Supervisor Binary Interface) and the linux kernel SBI console.
> > >>
> > >> The SiFive UART implements the pre qom legacy interface consistent
> > >> with the 16550a UART in 'hw/char/serial.c'.
> > >>
> > >> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> > >> Signed-off-by: Stefan O'Rear <sorear2@gmail.com>
> > >> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > >> Signed-off-by: Michael Clark <mjc@sifive.com>
> > >> ---
> > >>  hw/riscv/sifive_uart.c         | 176 ++++++++++++++++++++++++++++++
> +++++++++++
> > >>  include/hw/riscv/sifive_uart.h |  71 +++++++++++++++++
> > >>  2 files changed, 247 insertions(+)
> > >>  create mode 100644 hw/riscv/sifive_uart.c
> > >>  create mode 100644 include/hw/riscv/sifive_uart.h
> > >>
> > >> diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
> > >> new file mode 100644
> > >> index 0000000..b0c3798
> > >> --- /dev/null
> > >> +++ b/hw/riscv/sifive_uart.c
> > >> @@ -0,0 +1,176 @@
> > >> +/*
> > >> + * QEMU model of the UART on the SiFive E300 and U500 series SOCs.
> > >> + *
> > >> + * Copyright (c) 2016 Stefan O'Rear
> > >> + *
> > >> + * This program is free software; you can redistribute it and/or
> modify it
> > >> + * under the terms and conditions of the GNU General Public License=
,
> > >> + * version 2 or later, as published by the Free Software Foundation=
.
> > >> + *
> > >> + * This program is distributed in the hope it will be useful, but
> WITHOUT
> > >> + * ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY or
> > >> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License for
> > >> + * more details.
> > >> + *
> > >> + * You should have received a copy of the GNU General Public Licens=
e
> along with
> > >> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > >> + */
> > >> +
> > >> +#include "qemu/osdep.h"
> > >> +#include "qapi/error.h"
> > >> +#include "hw/sysbus.h"
> > >> +#include "chardev/char.h"
> > >> +#include "chardev/char-fe.h"
> > >> +#include "target/riscv/cpu.h"
> > >> +#include "hw/riscv/sifive_uart.h"
> > >>
> > >> +/*
> > >> + * Not yet implemented:
> > >> + *
> > >> + * Transmit FIFO using "qemu/fifo8.h"
> > >> + * SIFIVE_UART_IE_TXWM interrupts
> > >> + * SIFIVE_UART_IE_RXWM interrupts must honor fifo watermark
> > >> + * Rx FIFO watermark interrupt trigger threshold
> > >> + * Tx FIFO watermark interrupt trigger threshold.
> > >> + */
> > >> +
> > >> +static void update_irq(SiFiveUARTState *s)
> > >> +{
> > >> +    int cond =3D 0;
> > >> +    if ((s->ie & SIFIVE_UART_IE_RXWM) && s->rx_fifo_len) {
> > >> +        cond =3D 1;
> > >> +    }
> > >> +    if (cond) {
> > >> +        qemu_irq_raise(s->irq);
> > >> +    } else {
> > >> +        qemu_irq_lower(s->irq);
> > >> +    }
> > >> +}
> > >> +
> > >> +static uint64_t
> > >> +uart_read(void *opaque, hwaddr addr, unsigned int size)
> > >> +{
> > >> +    SiFiveUARTState *s =3D opaque;
> > >> +    unsigned char r;
> > >> +    switch (addr) {
> > >> +    case SIFIVE_UART_RXFIFO:
> > >> +        if (s->rx_fifo_len) {
> > >> +            r =3D s->rx_fifo[0];
> > >> +            memmove(s->rx_fifo, s->rx_fifo + 1, s->rx_fifo_len - 1)=
;
> > >> +            s->rx_fifo_len--;
> > >> +            qemu_chr_fe_accept_input(&s->chr);
> > >> +            update_irq(s);
> > >> +            return r;
> > >> +        }
> > >> +        return 0x80000000;
> > >> +
> > >> +    case SIFIVE_UART_TXFIFO:
> > >> +        return 0; /* Should check tx fifo */
> > >> +    case SIFIVE_UART_IE:
> > >> +        return s->ie;
> > >> +    case SIFIVE_UART_IP:
> > >> +        return s->rx_fifo_len ? SIFIVE_UART_IP_RXWM : 0;
> > >> +    case SIFIVE_UART_TXCTRL:
> > >> +        return s->txctrl;
> > >> +    case SIFIVE_UART_RXCTRL:
> > >> +        return s->rxctrl;
> > >> +    case SIFIVE_UART_DIV:
> > >> +        return s->div;
> > >> +    }
> > >> +
> > >> +    hw_error("%s: bad read: addr=3D0x%x\n",
> > >> +        __func__, (int)addr);
> > >> +    return 0;
> > >> +}
> > >> +
> > >> +static void
> > >> +uart_write(void *opaque, hwaddr addr,
> > >> +           uint64_t val64, unsigned int size)
> > >> +{
> > >> +    SiFiveUARTState *s =3D opaque;
> > >> +    uint32_t value =3D val64;
> > >> +    unsigned char ch =3D value;
> > >> +
> > >> +    switch (addr) {
> > >> +    case SIFIVE_UART_TXFIFO:
> > >> +        qemu_chr_fe_write(&s->chr, &ch, 1);
> > >> +        return;
> > >> +    case SIFIVE_UART_IE:
> > >> +        s->ie =3D val64;
> > >> +        update_irq(s);
> > >> +        return;
> > >> +    case SIFIVE_UART_TXCTRL:
> > >> +        s->txctrl =3D val64;
> > >> +        return;
> > >> +    case SIFIVE_UART_RXCTRL:
> > >> +        s->rxctrl =3D val64;
> > >> +        return;
> > >> +    case SIFIVE_UART_DIV:
> > >> +        s->div =3D val64;
> > >> +        return;
> > >> +    }
> > >> +    hw_error("%s: bad write: addr=3D0x%x v=3D0x%x\n",
> > >> +        __func__, (int)addr, (int)value);
> > >> +}
> > >> +
> > >> +static const MemoryRegionOps uart_ops =3D {
> > >> +    .read =3D uart_read,
> > >> +    .write =3D uart_write,
> > >> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > >> +    .valid =3D {
> > >> +        .min_access_size =3D 4,
> > >> +        .max_access_size =3D 4
> > >> +    }
> > >> +};
> > >> +
> > >> +static void uart_rx(void *opaque, const uint8_t *buf, int size)
> > >> +{
> > >> +    SiFiveUARTState *s =3D opaque;
> > >> +
> > >> +    /* Got a byte.  */
> > >> +    if (s->rx_fifo_len >=3D sizeof(s->rx_fifo)) {
> > >> +        printf("WARNING: UART dropped char.\n");
> > >> +        return;
> > >> +    }
> > >> +    s->rx_fifo[s->rx_fifo_len++] =3D *buf;
> > >> +
> > >> +    update_irq(s);
> > >> +}
> > >> +
> > >> +static int uart_can_rx(void *opaque)
> > >> +{
> > >> +    SiFiveUARTState *s =3D opaque;
> > >> +
> > >> +    return s->rx_fifo_len < sizeof(s->rx_fifo);
> > >> +}
> > >> +
> > >> +static void uart_event(void *opaque, int event)
> > >> +{
> > >> +}
> > >> +
> > >> +static int uart_be_change(void *opaque)
> > >> +{
> > >> +    SiFiveUARTState *s =3D opaque;
> > >> +
> > >> +    qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx,
> uart_event,
> > >> +        uart_be_change, s, NULL, true);
> > >> +
> > >> +    return 0;
> > >> +}
> > >> +
> > >> +/*
> > >> + * Create UART device.
> > >> + */
> > >> +SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space,
> hwaddr base,
> > >> +    Chardev *chr, qemu_irq irq)
> > >> +{
> > >> +    SiFiveUARTState *s =3D g_malloc0(sizeof(SiFiveUARTState));
> > >> +    s->irq =3D irq;
> > >> +    qemu_chr_fe_init(&s->chr, chr, &error_abort);
> > >> +    qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx,
> uart_event,
> > >> +        uart_be_change, s, NULL, true);
> > >> +    memory_region_init_io(&s->mmio, NULL, &uart_ops, s,
> > >> +                          TYPE_SIFIVE_UART, SIFIVE_UART_MAX);
> > >> +    memory_region_add_subregion(address_space, base, &s->mmio);
> > >> +    return s;
> > >> +}
> > >> diff --git a/include/hw/riscv/sifive_uart.h
> b/include/hw/riscv/sifive_uart.h
> > >> new file mode 100644
> > >> index 0000000..504f18a
> > >> --- /dev/null
> > >> +++ b/include/hw/riscv/sifive_uart.h
> > >> @@ -0,0 +1,71 @@
> > >> +/*
> > >> + * SiFive UART interface
> > >> + *
> > >> + * Copyright (c) 2016 Stefan O'Rear
> > >> + * Copyright (c) 2017 SiFive, Inc.
> > >> + *
> > >> + * This program is free software; you can redistribute it and/or
> modify it
> > >> + * under the terms and conditions of the GNU General Public License=
,
> > >> + * version 2 or later, as published by the Free Software Foundation=
.
> > >> + *
> > >> + * This program is distributed in the hope it will be useful, but
> WITHOUT
> > >> + * ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY or
> > >> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License for
> > >> + * more details.
> > >> + *
> > >> + * You should have received a copy of the GNU General Public Licens=
e
> along with
> > >> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > >> + */
> > >> +
> > >> +#ifndef HW_SIFIVE_UART_H
> > >> +#define HW_SIFIVE_UART_H
> > >> +
> > >> +enum {
> > >> +    SIFIVE_UART_TXFIFO        =3D 0,
> > >> +    SIFIVE_UART_RXFIFO        =3D 4,
> > >> +    SIFIVE_UART_TXCTRL        =3D 8,
> > >> +    SIFIVE_UART_TXMARK        =3D 10,
> > >> +    SIFIVE_UART_RXCTRL        =3D 12,
> > >> +    SIFIVE_UART_RXMARK        =3D 14,
> > >> +    SIFIVE_UART_IE            =3D 16,
> > >> +    SIFIVE_UART_IP            =3D 20,
> > >> +    SIFIVE_UART_DIV           =3D 24,
> > >> +    SIFIVE_UART_MAX           =3D 32
> > >> +};
> > >> +
> > >> +enum {
> > >> +    SIFIVE_UART_IE_TXWM       =3D 1, /* Transmit watermark interrup=
t
> enable */
> > >> +    SIFIVE_UART_IE_RXWM       =3D 2  /* Receive watermark interrupt
> enable */
> > >> +};
> > >> +
> > >> +enum {
> > >> +    SIFIVE_UART_IP_TXWM       =3D 1, /* Transmit watermark interrup=
t
> pending */
> > >> +    SIFIVE_UART_IP_RXWM       =3D 2  /* Receive watermark interrupt
> pending */
> > >> +};
> > >> +
> > >> +#define TYPE_SIFIVE_UART "riscv.sifive.uart"
> > >> +
> > >> +#define SIFIVE_UART(obj) \
> > >> +    OBJECT_CHECK(SiFiveUARTState, (obj), TYPE_SIFIVE_UART)
> > >> +
> > >> +typedef struct SiFiveUARTState {
> > >> +    /*< private >*/
> > >> +    SysBusDevice parent_obj;
> > >
> > >
> > > You use SysBusDevive in this header file but there is no 'include
> "hw/sysbus.h"' in the header file itself.
> > >
> > > Please see my comment https://github.com/riscv/riscv-qemu/pull/130#
> issuecomment-379640538
> > >
> > >
> > >> +    /*< public >*/
> > >> +    qemu_irq irq;
> > >> +    MemoryRegion mmio;
> > >> +    CharBackend chr;
> > >
> > > Just the same thing. CharBackend is defined in "chardev/char-fe.h"
> please include it.
> >
> > Honestly, I rather prefer to *not* add more includes to header files
> > than we already have. We already have got lots of "touch this header an=
d
> > you have to recompile almost the whole QEMU" conditions, so to avoid
> > that this situation gets worse, we should rather avoid including header=
s
> > from headers if it is not necessary. Thus if the current sources build
> > fine, no need to change anything here. Just my 0.02 =E2=82=AC.
>
> Adding ONLY NECESSARY header files inclusions to header file __can't
> produce__
> additional recompile efforts.
> Moreover this can decrease number of include directives in c-files.
>
> I __rebased__ my RISC-V board in my out-of tree qemu branch (
> https://github.com/miet-riscv-workgroup/riscv-qemu/tree/20180409.erizo).
> I faced with problem: I have to track dependencies of
> header files from include/hw/riscv/ which I use.
>
> So your "not-add-more-includes-to-header-files" approach has an
> disadvantage:
> if a header file required header list changes, each c-file that includes
> that header file
> must be edited to update the #include statement list.
>
> RISC-V is a very promising architecture. It is possible that we will have
> many RISC-V-related
> c-files in the future in qemu. It will be very painful to change these
> c-files on every RISC-V header
> files requirements change.
>
> To Eric Blake:
> I have added you to CC because of your comment in the conversation
> https://patchwork.kernel.org/patch/10147099/


Currently no headers in include/hw/riscv/*.h include any other headers and
i'd like to keep it that way if possible.

It's not painful if no headers include any other headers. On the contrary
it keeps things simple. There are no implicit dependencies. Core QEMU
header dependencies should not be brought in by riscv specific headers.
That would lead to source modules that do not include their QEMU
dependencies making the situation for managing source modules more opaque.

We have followed the best practice that source files should explicitly
include their header dependencies.
