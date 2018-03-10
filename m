Received: from eggs.gnu.org ([2001:4830:134:3::10]:36369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1euazL-0000Oy-Fa
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 04:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1euazG-0002jJ-Vc
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 04:40:27 -0500
Received: from chuckie.co.uk ([82.165.15.123]:50721
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1euazG-0002iP-KQ
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 04:40:22 -0500
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-20-git-send-email-mjc@sifive.com>
	<f52deedb-6cd7-13b1-082d-ebd6e8ff9290@amsat.org>
	<CAHNT7NvJXQJ8zRYR=p-E99sQmt0v7YtDnoqcgR3t20XkZUqzbg@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <973a09e1-13a9-ac8a-2601-55aa7c8356bc@ilande.co.uk>
Date: Sat, 10 Mar 2018 09:40:12 +0000
MIME-Version: 1.0
In-Reply-To: <CAHNT7NvJXQJ8zRYR=p-E99sQmt0v7YtDnoqcgR3t20XkZUqzbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 19/23] SiFive RISC-V UART Device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Stefan O'Rear <sorear2@gmail.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>

On 10/03/18 03:02, Michael Clark wrote:

> On Sat, Mar 10, 2018 at 1:39 AM, Philippe Mathieu-Daudé <f4bug@amsat.org>
> wrote:
> 
>> On 03/02/2018 02:51 PM, Michael Clark wrote:
>>> QEMU model of the UART on the SiFive E300 and U500 series SOCs.
>>> BBL supports the SiFive UART for early console access via the SBI
>>> (Supervisor Binary Interface) and the linux kernel SBI console.
>>>
>>> The SiFive UART implements the pre qom legacy interface consistent
>>> with the 16550a UART in 'hw/char/serial.c'.

FWIW I can highly recommend switching over to the QOM/qdev APIs where 
possible since it makes rewiring machines much easier, and passing 
around direct types such as qemu_irq via custom functions means people 
are less likely to touch them.

>>> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Stefan O'Rear <sorear2@gmail.com>
>>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>>> Signed-off-by: Michael Clark <mjc@sifive.com>
>>> ---
>>>   hw/riscv/sifive_uart.c         | 176 ++++++++++++++++++++++++++++++
>> +++++++++++
>>>   include/hw/riscv/sifive_uart.h |  71 +++++++++++++++++
>>>   2 files changed, 247 insertions(+)
>>>   create mode 100644 hw/riscv/sifive_uart.c
>>>   create mode 100644 include/hw/riscv/sifive_uart.h
>>>
>>> diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
>>> new file mode 100644
>>> index 0000000..b0c3798
>>> --- /dev/null
>>> +++ b/hw/riscv/sifive_uart.c
>>> @@ -0,0 +1,176 @@
>>> +/*
>>> + * QEMU model of the UART on the SiFive E300 and U500 series SOCs.
>>> + *
>>> + * Copyright (c) 2016 Stefan O'Rear
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>> it
>>> + * under the terms and conditions of the GNU General Public License,
>>> + * version 2 or later, as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope it will be useful, but
>> WITHOUT
>>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
>> License for
>>> + * more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>> along with
>>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "hw/sysbus.h"
>>> +#include "chardev/char.h"
>>> +#include "chardev/char-fe.h"
>>> +#include "target/riscv/cpu.h"
>>> +#include "hw/riscv/sifive_uart.h"
>>> +
>>> +/*
>>> + * Not yet implemented:
>>> + *
>>> + * Transmit FIFO using "qemu/fifo8.h"
>>> + * SIFIVE_UART_IE_TXWM interrupts
>>> + * SIFIVE_UART_IE_RXWM interrupts must honor fifo watermark
>>> + * Rx FIFO watermark interrupt trigger threshold
>>> + * Tx FIFO watermark interrupt trigger threshold.
>>> + */
>>> +
>>> +static void update_irq(SiFiveUARTState *s)
>>> +{
>>> +    int cond = 0;
>>> +    if ((s->ie & SIFIVE_UART_IE_RXWM) && s->rx_fifo_len) {
>>> +        cond = 1;
>>> +    }
>>> +    if (cond) {
>>> +        qemu_irq_raise(s->irq);
>>> +    } else {
>>> +        qemu_irq_lower(s->irq);
>>> +    }
>>
>> or     qemu_set_irq(s->irq, cond);
>>
>>> +}
>>> +
>>> +static uint64_t
>>> +uart_read(void *opaque, hwaddr addr, unsigned int size)
>>> +{
>>> +    SiFiveUARTState *s = opaque;
>>> +    unsigned char r;
>>> +    switch (addr) {
>>> +    case SIFIVE_UART_RXFIFO:
>>> +        if (s->rx_fifo_len) {
>>> +            r = s->rx_fifo[0];
>>> +            memmove(s->rx_fifo, s->rx_fifo + 1, s->rx_fifo_len - 1);
>>> +            s->rx_fifo_len--;
>>> +            qemu_chr_fe_accept_input(&s->chr);
>>> +            update_irq(s);
>>> +            return r;
>>> +        }
>>> +        return 0x80000000;
>>
>> Can you add a #define for this bit?
>>
>>> +
>>> +    case SIFIVE_UART_TXFIFO:
>>> +        return 0; /* Should check tx fifo */
>>> +    case SIFIVE_UART_IE:
>>> +        return s->ie;
>>> +    case SIFIVE_UART_IP:
>>> +        return s->rx_fifo_len ? SIFIVE_UART_IP_RXWM : 0;
>>> +    case SIFIVE_UART_TXCTRL:
>>> +        return s->txctrl;
>>> +    case SIFIVE_UART_RXCTRL:
>>> +        return s->rxctrl;
>>> +    case SIFIVE_UART_DIV:
>>> +        return s->div;
>>> +    }
>>> +
>>> +    hw_error("%s: bad read: addr=0x%x\n",
>>> +        __func__, (int)addr);
>>
>> qemu_log(GUEST_ERROR)?
>>
>>> +    return 0;
>>> +}
>>> +
>>> +static void
>>> +uart_write(void *opaque, hwaddr addr,
>>> +           uint64_t val64, unsigned int size)
>>> +{
>>> +    SiFiveUARTState *s = opaque;
>>> +    uint32_t value = val64;
>>> +    unsigned char ch = value;
>>> +
>>> +    switch (addr) {
>>> +    case SIFIVE_UART_TXFIFO:
>>> +        qemu_chr_fe_write(&s->chr, &ch, 1);
>>> +        return;
>>> +    case SIFIVE_UART_IE:
>>> +        s->ie = val64;
>>> +        update_irq(s);
>>> +        return;
>>> +    case SIFIVE_UART_TXCTRL:
>>> +        s->txctrl = val64;
>>> +        return;
>>> +    case SIFIVE_UART_RXCTRL:
>>> +        s->rxctrl = val64;
>>> +        return;
>>> +    case SIFIVE_UART_DIV:
>>> +        s->div = val64;
>>> +        return;
>>> +    }
>>> +    hw_error("%s: bad write: addr=0x%x v=0x%x\n",
>>> +        __func__, (int)addr, (int)value);
>>
>> Ditto.
>>
>>> +}
>>> +
>>> +static const MemoryRegionOps uart_ops = {
>>> +    .read = uart_read,
>>> +    .write = uart_write,
>>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>>> +    .valid = {
>>> +        .min_access_size = 4,
>>> +        .max_access_size = 4
>>> +    }
>>> +};
>>> +
>>> +static void uart_rx(void *opaque, const uint8_t *buf, int size)
>>> +{
>>> +    SiFiveUARTState *s = opaque;
>>> +
>>> +    /* Got a byte.  */
>>> +    if (s->rx_fifo_len >= sizeof(s->rx_fifo)) {
>>> +        printf("WARNING: UART dropped char.\n");
>>
>> replace printf() by warn_report()?
>>
>>> +        return;
>>> +    }
>>> +    s->rx_fifo[s->rx_fifo_len++] = *buf;
>>> +
>>> +    update_irq(s);
>>> +}
>>> +
>>> +static int uart_can_rx(void *opaque)
>>> +{
>>> +    SiFiveUARTState *s = opaque;
>>> +
>>> +    return s->rx_fifo_len < sizeof(s->rx_fifo);
>>> +}
>>> +
>>> +static void uart_event(void *opaque, int event)
>>> +{
>>> +}
>>> +
>>> +static int uart_be_change(void *opaque)
>>> +{
>>> +    SiFiveUARTState *s = opaque;
>>> +
>>> +    qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx, uart_event,
>>> +        uart_be_change, s, NULL, true);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/*
>>> + * Create UART device.
>>> + */
>>> +SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space,
>> hwaddr base,
>>> +    Chardev *chr, qemu_irq irq)
>>> +{
>>> +    SiFiveUARTState *s = g_malloc0(sizeof(SiFiveUARTState));
>>> +    s->irq = irq;
>>> +    qemu_chr_fe_init(&s->chr, chr, &error_abort);
>>> +    qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx, uart_event,
>>> +        uart_be_change, s, NULL, true);
>>> +    memory_region_init_io(&s->mmio, NULL, &uart_ops, s,
>>> +                          TYPE_SIFIVE_UART, SIFIVE_UART_MAX);
>>> +    memory_region_add_subregion(address_space, base, &s->mmio);
>>> +    return s;
>>> +}
>>> diff --git a/include/hw/riscv/sifive_uart.h b/include/hw/riscv/sifive_
>> uart.h
>>> new file mode 100644
>>> index 0000000..504f18a
>>> --- /dev/null
>>> +++ b/include/hw/riscv/sifive_uart.h
>>> @@ -0,0 +1,71 @@
>>> +/*
>>> + * SiFive UART interface
>>> + *
>>> + * Copyright (c) 2016 Stefan O'Rear
>>> + * Copyright (c) 2017 SiFive, Inc.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>> it
>>> + * under the terms and conditions of the GNU General Public License,
>>> + * version 2 or later, as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope it will be useful, but
>> WITHOUT
>>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
>> License for
>>> + * more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>> along with
>>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#ifndef HW_SIFIVE_UART_H
>>> +#define HW_SIFIVE_UART_H
>>> +
>>> +enum {
>>> +    SIFIVE_UART_TXFIFO        = 0,
>>> +    SIFIVE_UART_RXFIFO        = 4,
>>> +    SIFIVE_UART_TXCTRL        = 8,
>>> +    SIFIVE_UART_TXMARK        = 10,
>>> +    SIFIVE_UART_RXCTRL        = 12,
>>> +    SIFIVE_UART_RXMARK        = 14,
>>> +    SIFIVE_UART_IE            = 16,
>>> +    SIFIVE_UART_IP            = 20,
>>> +    SIFIVE_UART_DIV           = 24,
>>> +    SIFIVE_UART_MAX           = 32
>>> +};
>>> +
>>> +enum {
>>> +    SIFIVE_UART_IE_TXWM       = 1, /* Transmit watermark interrupt
>> enable */
>>> +    SIFIVE_UART_IE_RXWM       = 2  /* Receive watermark interrupt
>> enable */
>>> +};
>>> +
>>> +enum {
>>> +    SIFIVE_UART_IP_TXWM       = 1, /* Transmit watermark interrupt
>> pending */
>>> +    SIFIVE_UART_IP_RXWM       = 2  /* Receive watermark interrupt
>> pending */
>>> +};
>>
>> These 2 enums don't need to be exported and can stay in sifive_uart.c.
>>
>>> +
>>> +#define TYPE_SIFIVE_UART "riscv.sifive.uart"
>>> +
>>> +#define SIFIVE_UART(obj) \
>>> +    OBJECT_CHECK(SiFiveUARTState, (obj), TYPE_SIFIVE_UART)
>>> +
>>> +typedef struct SiFiveUARTState {
>>> +    /*< private >*/
>>> +    SysBusDevice parent_obj;
>>> +
>>> +    /*< public >*/
>>> +    qemu_irq irq;
>>> +    MemoryRegion mmio;
>>> +    CharBackend chr;
>>> +    uint8_t rx_fifo[8];
>>> +    unsigned int rx_fifo_len;
>>> +    uint32_t ie;
>>> +    uint32_t ip;
>>> +    uint32_t txctrl;
>>> +    uint32_t rxctrl;
>>> +    uint32_t div;
>>> +} SiFiveUARTState;
>>> +
>>> +SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space,
>> hwaddr base,
>>> +    Chardev *chr, qemu_irq irq);
>>> +
>>> +#endif
>>>
>>
>> removing printf():
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
> 
> I will go through and make these changes and include them in the post-merge
> cleanup patch series...

Another general note: for each of the main QEMU platforms supported 
there is a home page on the official wiki, so do make sure that you set 
yourself a template for RiscV and add some information to help people 
get started.

As an example here's the SPARC page which I currently maintain: 
https://wiki.qemu.org/Documentation/Platforms/SPARC. I tend to also keep 
a rough changelog there too so people can see which features have been 
added in which QEMU version.


HTH,

Mark.
