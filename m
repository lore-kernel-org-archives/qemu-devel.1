Received: from eggs.gnu.org ([2001:4830:134:3::10]:58196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eXLe0-0004bo-MW
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:38:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eXLdx-0002DU-Ey
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:38:20 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eXLdw-0002Cb-R3
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:38:17 -0500
Received: by mail-oi0-x242.google.com with SMTP id f69so2547045oig.10
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 22:38:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5a9771ac-f4ca-09fb-e3fa-d74156a89996@adacore.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-18-git-send-email-mjc@sifive.com>
	<5a9771ac-f4ca-09fb-e3fa-d74156a89996@adacore.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 5 Jan 2018 19:38:15 +1300
Message-ID: <CAHNT7NuqvpptRzOxSfNEzPdEN4Rz2yrAfbcs23KC3u64dY-hDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 17/21] SiFive RISC-V UART Device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Thu, Jan 4, 2018 at 3:57 AM, KONRAD Frederic <frederic.konrad@adacore.com
> wrote:

> Hi all,
>
>
> On 01/03/2018 01:44 AM, Michael Clark wrote:
>
>> QEMU model of the UART on the SiFive E300 and U500 series SOCs.
>> BBL supports the SiFive UART for early console access via the SBI
>> (Supervisor Binary Interface) and the linux kernel SBI console.
>>
>> The SiFive UART implements the pre qom legacy interface consistent
>> with the 16550a UART in 'hw/char/serial.c'.
>>
>> Signed-off-by: Michael Clark <mjc@sifive.com>
>> ---
>>   hw/riscv/sifive_uart.c         | 182 ++++++++++++++++++++++++++++++
>> +++++++++++
>>   include/hw/riscv/sifive_uart.h |  76 +++++++++++++++++
>>   2 files changed, 258 insertions(+)
>>   create mode 100644 hw/riscv/sifive_uart.c
>>   create mode 100644 include/hw/riscv/sifive_uart.h
>>
>> diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
>> new file mode 100644
>> index 0000000..0e73df6
>> --- /dev/null
>> +++ b/hw/riscv/sifive_uart.c
>> @@ -0,0 +1,182 @@
>> +/*
>> + * QEMU model of the UART on the SiFive E300 and U500 series SOCs.
>> + *
>> + * Copyright (c) 2016 Stefan O'Rear
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining
>> a copy
>> + * of this software and associated documentation files (the "Software"),
>> to deal
>> + * in the Software without restriction, including without limitation the
>> rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
>> sell
>> + * copies of the Software, and to permit persons to whom the Software is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
>> SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/sysbus.h"
>> +#include "chardev/char.h"
>> +#include "chardev/char-fe.h"
>> +#include "target/riscv/cpu.h"
>> +#include "hw/riscv/sifive_uart.h"
>> +
>> +/*
>> + * Not yet implemented:
>> + *
>> + * Transmit FIFO using "qemu/fifo8.h"
>> + * SIFIVE_UART_IE_TXWM interrupts
>> + * SIFIVE_UART_IE_RXWM interrupts must honor fifo watermark
>> + * Rx FIFO watermark interrupt trigger threshold
>> + * Tx FIFO watermark interrupt trigger threshold.
>> + */
>> +
>> +static void update_irq(SiFiveUARTState *s)
>> +{
>> +    int cond = 0;
>> +    if ((s->ie & SIFIVE_UART_IE_RXWM) && s->rx_fifo_len) {
>> +        cond = 1;
>> +    }
>> +    if (cond) {
>> +        qemu_irq_raise(s->irq);
>> +    } else {
>> +        qemu_irq_lower(s->irq);
>> +    }
>> +}
>> +
>> +static uint64_t
>> +uart_read(void *opaque, hwaddr addr, unsigned int size)
>> +{
>> +    SiFiveUARTState *s = opaque;
>> +    unsigned char r;
>> +    switch (addr) {
>> +    case SIFIVE_UART_RXFIFO:
>> +        if (s->rx_fifo_len) {
>> +            r = s->rx_fifo[0];
>> +            memmove(s->rx_fifo, s->rx_fifo + 1, s->rx_fifo_len - 1);
>> +            s->rx_fifo_len--;
>> +            qemu_chr_fe_accept_input(&s->chr);
>> +            update_irq(s);
>> +            return r;
>> +        }
>> +        return 0x80000000;
>> +
>> +    case SIFIVE_UART_TXFIFO:
>> +        return 0; /* Should check tx fifo */
>> +    case SIFIVE_UART_IE:
>> +        return s->ie;
>> +    case SIFIVE_UART_IP:
>> +        return s->rx_fifo_len ? SIFIVE_UART_IP_RXWM : 0;
>> +    case SIFIVE_UART_TXCTRL:
>> +        return s->txctrl;
>> +    case SIFIVE_UART_RXCTRL:
>> +        return s->rxctrl;
>> +    case SIFIVE_UART_DIV:
>> +        return s->div;
>> +    }
>> +
>> +    hw_error("%s: bad read: addr=0x%x\n",
>> +        __func__, (int)addr);
>> +    return 0;
>> +}
>> +
>> +static void
>> +uart_write(void *opaque, hwaddr addr,
>> +           uint64_t val64, unsigned int size)
>> +{
>> +    SiFiveUARTState *s = opaque;
>> +    uint32_t value = val64;
>> +    unsigned char ch = value;
>> +
>> +    switch (addr) {
>> +    case SIFIVE_UART_TXFIFO:
>> +        qemu_chr_fe_write(&s->chr, &ch, 1);
>> +        return;
>> +    case SIFIVE_UART_IE:
>> +        s->ie = val64;
>> +        update_irq(s);
>> +        return;
>> +    case SIFIVE_UART_TXCTRL:
>> +        s->txctrl = val64;
>> +        return;
>> +    case SIFIVE_UART_RXCTRL:
>> +        s->rxctrl = val64;
>> +        return;
>> +    case SIFIVE_UART_DIV:
>> +        s->div = val64;
>> +        return;
>> +    }
>> +    hw_error("%s: bad write: addr=0x%x v=0x%x\n",
>> +        __func__, (int)addr, (int)value);
>> +}
>> +
>> +static const MemoryRegionOps uart_ops = {
>> +    .read = uart_read,
>> +    .write = uart_write,
>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4
>> +    }
>> +};
>> +
>> +static void uart_rx(void *opaque, const uint8_t *buf, int size)
>> +{
>> +    SiFiveUARTState *s = opaque;
>> +
>> +    /* Got a byte.  */
>> +    if (s->rx_fifo_len >= sizeof(s->rx_fifo)) {
>> +        printf("WARNING: UART dropped char.\n");
>>
>
> I'd use qemu_log instead.


It's on our todo list to replace all printf's with
appropiate qemu_log_mask, trace events, assertions etc. The code is
currently littered with printfs and exits.


> +        return;
>> +    }
>> +    s->rx_fifo[s->rx_fifo_len++] = *buf;
>> +
>> +    update_irq(s);
>> +}
>> +
>> +static int uart_can_rx(void *opaque)
>> +{
>> +    SiFiveUARTState *s = opaque;
>> +
>> +    return s->rx_fifo_len < sizeof(s->rx_fifo);
>> +}
>> +
>> +static void uart_event(void *opaque, int event)
>> +{
>> +}
>> +
>> +static int uart_be_change(void *opaque)
>> +{
>> +    SiFiveUARTState *s = opaque;
>> +
>> +    qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx, uart_event,
>> +        uart_be_change, s, NULL, true);
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Create UART device.
>> + */
>> +SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr
>> base,
>> +    Chardev *chr, qemu_irq irq)
>> +{
>> +    SiFiveUARTState *s = g_malloc0(sizeof(SiFiveUARTState));
>>
>
> You need to create a qemu object for that instead of using
> g_malloc0. There are plenty of example in the code.
>
> eg: hw/char/pl011.c
>

I'm aware of that. We've encapsulated many of the other hardware widgets
using qom however based on the patch header we followed the lead of
hw/char/serial.c using the legacy pre qom model.

This was done for very deliberate reasons, because there have been quite a
few chardev changes (front-end, back-end split, and hot plugging) since our
forward port, so we used hw/char/serial.c as reference. We're also going to
use hw/char/serial.c as reference for fifo8 as the SiFive UART has an 8
character FIFO.

I can add it to the to-do list. In any case we can remove machines that
depend on SiFive UART from our next patch set if pre qom devices are a
blocker. The virt machine uses hw/char/serial.c and thats the machine the
Linux distro builders want to use because it's the only RISC-V QEMU machine
with working network and block devices.

The todo list is growing ;-) We have to classify things as to whether they
are blockers, or whether they can be done in tree.

Obviously one of the advantage of being in-tree is that we might get help
from the wider qemu-devel community.

There are however a lot of baseline clean-ups we need to do first before we
start expanding device support and we have to choose which device gets
attention first. Currently it's looking like emulation of the SiFive
AON/PRCI block for power-off and reset. This is used by the E-series,
U-series and likely the virt machine. The spike machine uses HTIF.

Thanks,
> Fred
>
>
> +    s->irq = irq;
>> +    qemu_chr_fe_init(&s->chr, chr, &error_abort);
>> +    qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx, uart_event,
>> +        uart_be_change, s, NULL, true);
>> +    memory_region_init_io(&s->mmio, NULL, &uart_ops, s,
>> +                          TYPE_SIFIVE_UART, SIFIVE_UART_MAX);
>> +    memory_region_add_subregion(address_space, base, &s->mmio);
>> +    return s;
>> +}
>> diff --git a/include/hw/riscv/sifive_uart.h
>> b/include/hw/riscv/sifive_uart.h
>> new file mode 100644
>> index 0000000..1ab0106
>> --- /dev/null
>> +++ b/include/hw/riscv/sifive_uart.h
>> @@ -0,0 +1,76 @@
>> +/*
>> + * SiFive UART interface
>> + *
>> + * Copyright (c) 2017 SiFive, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining
>> a copy
>> + * of this software and associated documentation files (the "Software"),
>> to deal
>> + * in the Software without restriction, including without limitation the
>> rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
>> sell
>> + * copies of the Software, and to permit persons to whom the Software is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
>> SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#ifndef HW_SIFIVE_UART_H
>> +#define HW_SIFIVE_UART_H
>> +
>> +enum {
>> +    SIFIVE_UART_TXFIFO        = 0,
>> +    SIFIVE_UART_RXFIFO        = 4,
>> +    SIFIVE_UART_TXCTRL        = 8,
>> +    SIFIVE_UART_TXMARK        = 10,
>> +    SIFIVE_UART_RXCTRL        = 12,
>> +    SIFIVE_UART_RXMARK        = 14,
>> +    SIFIVE_UART_IE            = 16,
>> +    SIFIVE_UART_IP            = 20,
>> +    SIFIVE_UART_DIV           = 24,
>> +    SIFIVE_UART_MAX           = 32
>> +};
>> +
>> +enum {
>> +    SIFIVE_UART_IE_TXWM       = 1, /* Transmit watermark interrupt
>> enable */
>> +    SIFIVE_UART_IE_RXWM       = 2  /* Receive watermark interrupt enable
>> */
>> +};
>> +
>> +enum {
>> +    SIFIVE_UART_IP_TXWM       = 1, /* Transmit watermark interrupt
>> pending */
>> +    SIFIVE_UART_IP_RXWM       = 2  /* Receive watermark interrupt
>> pending */
>> +};
>> +
>> +#define TYPE_SIFIVE_UART "riscv.sifive.uart"
>> +
>> +#define SIFIVE_UART(obj) \
>> +    OBJECT_CHECK(SiFiveUARTState, (obj), TYPE_SIFIVE_UART)
>> +
>> +typedef struct SiFiveUARTState {
>> +    /*< private >*/
>> +    SysBusDevice parent_obj;
>> +
>> +    /*< public >*/
>> +    qemu_irq irq;
>> +    MemoryRegion mmio;
>> +    CharBackend chr;
>> +    uint8_t rx_fifo[8];
>> +    unsigned int rx_fifo_len;
>> +    uint32_t ie;
>> +    uint32_t ip;
>> +    uint32_t txctrl;
>> +    uint32_t rxctrl;
>> +    uint32_t div;
>> +} SiFiveUARTState;
>> +
>> +SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr
>> base,
>> +    Chardev *chr, qemu_irq irq);
>> +
>> +#endif
>>
>>
