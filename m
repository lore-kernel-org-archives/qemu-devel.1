Received: from eggs.gnu.org ([2001:4830:134:3::10]:54554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dUwqI-0003x6-3c
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dUwqB-0004ss-7H
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:12:50 -0400
MIME-Version: 1.0
In-Reply-To: <1499771839-32518-3-git-send-email-peter.maydell@linaro.org>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<1499771839-32518-3-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Jul 2017 17:12:06 +0200
Message-ID: <CAKmqyKPn+JEVWmpzypZt=8kH80aNa+aNAZLhPSWvHy+h5gyd=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/7] hw/char/cmsdk-apb-uart.c: Implement
 CMSDK APB UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On Tue, Jul 11, 2017 at 1:17 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> Implement a model of the simple "APB UART" provided in
> the Cortex-M System Design Kit (CMSDK).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/char/Makefile.objs            |   1 +
>  include/hw/char/cmsdk-apb-uart.h |  78 ++++++++
>  hw/char/cmsdk-apb-uart.c         | 390 +++++++++++++++++++++++++++++++++++++++
>  default-configs/arm-softmmu.mak  |   2 +
>  hw/char/trace-events             |   9 +
>  5 files changed, 480 insertions(+)
>  create mode 100644 include/hw/char/cmsdk-apb-uart.h
>  create mode 100644 hw/char/cmsdk-apb-uart.c
>
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index 55fcb68..1bcd37e 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -19,6 +19,7 @@ obj-$(CONFIG_DIGIC) += digic-uart.o
>  obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
>  obj-$(CONFIG_RASPI) += bcm2835_aux.o
>
> +common-obj-$(CONFIG_CMSDK_APB_UART) += cmsdk-apb-uart.o
>  common-obj-$(CONFIG_ETRAXFS) += etraxfs_ser.o
>  common-obj-$(CONFIG_ISA_DEBUG) += debugcon.o
>  common-obj-$(CONFIG_GRLIB) += grlib_apbuart.o
> diff --git a/include/hw/char/cmsdk-apb-uart.h b/include/hw/char/cmsdk-apb-uart.h
> new file mode 100644
> index 0000000..c41fba9
> --- /dev/null
> +++ b/include/hw/char/cmsdk-apb-uart.h
> @@ -0,0 +1,78 @@
> +/*
> + * ARM CMSDK APB UART emulation
> + *
> + * Copyright (c) 2017 Linaro Limited
> + * Written by Peter Maydell
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 or
> + *  (at your option) any later version.
> + */
> +
> +#ifndef CMSDK_APB_UART_H
> +#define CMSDK_APB_UART_H
> +
> +#include "hw/sysbus.h"
> +#include "chardev/char-fe.h"
> +
> +#define TYPE_CMSDK_APB_UART "cmsdk-apb-uart"
> +#define CMSDK_APB_UART(obj) OBJECT_CHECK(CMSDKAPBUART, (obj), \
> +                                         TYPE_CMSDK_APB_UART)
> +
> +typedef struct {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion iomem;
> +    CharBackend chr;
> +    qemu_irq txint;
> +    qemu_irq rxint;
> +    qemu_irq txovrint;
> +    qemu_irq rxovrint;
> +    qemu_irq uartint;
> +    guint watch_tag;
> +    uint32_t pclk_frq;
> +
> +    uint32_t state;
> +    uint32_t ctrl;
> +    uint32_t intstatus;
> +    uint32_t bauddiv;
> +    /* This UART has no FIFO, only a 1-character buffer for each of Tx and Rx */
> +    uint8_t txbuf;
> +    uint8_t rxbuf;
> +} CMSDKAPBUART;

This should be CamelCase.

> +
> +/**
> + * cmsdk_apb_uart_create - convenience function to create TYPE_CMSDK_APB_UART
> + * @addr: location in system memory to map registers
> + * @chr: Chardev backend to connect UART to, or NULL if no backend
> + * @pclk_frq: frequency in Hz of the PCLK clock (used for calculating baud rate)
> + */
> +static inline DeviceState *cmsdk_apb_uart_create(hwaddr addr,
> +                                                 qemu_irq txint,
> +                                                 qemu_irq rxint,
> +                                                 qemu_irq txovrint,
> +                                                 qemu_irq rxovrint,
> +                                                 qemu_irq uartint,
> +                                                 Chardev *chr,
> +                                                 uint32_t pclk_frq)
> +{
> +    DeviceState *dev;
> +    SysBusDevice *s;
> +
> +    dev = qdev_create(NULL, TYPE_CMSDK_APB_UART);
> +    s = SYS_BUS_DEVICE(dev);
> +    qdev_prop_set_chr(dev, "chardev", chr);
> +    qdev_prop_set_uint32(dev, "pclk-frq", pclk_frq);
> +    qdev_init_nofail(dev);
> +    sysbus_mmio_map(s, 0, addr);
> +    sysbus_connect_irq(s, 0, txint);
> +    sysbus_connect_irq(s, 1, rxint);
> +    sysbus_connect_irq(s, 2, txovrint);
> +    sysbus_connect_irq(s, 3, rxovrint);
> +    sysbus_connect_irq(s, 4, uartint);
> +    return dev;
> +}
> +
> +#endif
> diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
> new file mode 100644
> index 0000000..a2f55db
> --- /dev/null
> +++ b/hw/char/cmsdk-apb-uart.c
> @@ -0,0 +1,390 @@
> +/*
> + * ARM CMSDK APB UART emulation
> + *
> + * Copyright (c) 2017 Linaro Limited
> + * Written by Peter Maydell
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 or
> + *  (at your option) any later version.
> + */
> +
> +/* This is a model of the "APB UART" which is part of the Cortex-M
> + * System Design Kit (CMSDK) and documented in the Cortex-M System
> + * Design Kit Technical Reference Manual (ARM DDI0479C):
> + * https://developer.arm.com/products/system-design/system-design-kits/cortex-m-system-design-kit

I can't find the spec from this site. Is it possible to link directly
to the guides? I have found a few dead links from some of these
marketing focused site.

> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#include "hw/sysbus.h"
> +#include "hw/registerfields.h"
> +#include "chardev/char-fe.h"
> +#include "chardev/char-serial.h"
> +#include "hw/char/cmsdk-apb-uart.h"
> +
> +REG32(DATA, 0)
> +REG32(STATE, 4)
> +    FIELD(STATE, TXFULL, 0, 1)
> +    FIELD(STATE, RXFULL, 1, 1)
> +    FIELD(STATE, TXOVERRUN, 2, 1)
> +    FIELD(STATE, RXOVERRUN, 3, 1)
> +REG32(CTRL, 8)
> +    FIELD(CTRL, TX_EN, 0, 1)
> +    FIELD(CTRL, RX_EN, 1, 1)
> +    FIELD(CTRL, TX_INTEN, 2, 1)
> +    FIELD(CTRL, RX_INTEN, 3, 1)
> +    FIELD(CTRL, TXO_INTEN, 4, 1)
> +    FIELD(CTRL, RXO_INTEN, 5, 1)
> +    FIELD(CTRL, HSTEST, 6, 1)
> +REG32(INTSTATUS, 0xc)
> +    FIELD(INTSTATUS, TX, 0, 1)
> +    FIELD(INTSTATUS, RX, 1, 1)
> +    FIELD(INTSTATUS, TXO, 2, 1)
> +    FIELD(INTSTATUS, RXO, 3, 1)
> +REG32(BAUDDIV, 0x10)
> +REG32(PID4, 0xFD0)
> +REG32(PID5, 0xFD4)
> +REG32(PID6, 0xFD8)
> +REG32(PID7, 0xFDC)
> +REG32(PID0, 0xFE0)
> +REG32(PID1, 0xFE4)
> +REG32(PID2, 0xFE8)
> +REG32(PID3, 0xFEC)
> +REG32(CID0, 0xFF0)
> +REG32(CID1, 0xFF4)
> +REG32(CID2, 0xFF8)
> +REG32(CID3, 0xFFC)
> +
> +/* PID/CID values */
> +static const int uart_id[] = {
> +    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
> +    0x21, 0xb8, 0x1b, 0x00, /* PID0..PID3 */
> +    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
> +};
> +
> +static void uart_update_parameters(CMSDKAPBUART *s)
> +{
> +    QEMUSerialSetParams ssp;
> +
> +    /* This UART is always 8N1 but the baud rate is programmable.
> +     * The minimum permitted bauddiv setting is 16, so we just ignore
> +     * settings below that (usually this means the device has just
> +     * been reset and not yet programmed).
> +     */
> +    if (s->bauddiv < 16 || s->bauddiv > s->pclk_frq) {
> +        return;
> +    }

This seems like it should deserve a guest error print.

> +
> +    ssp.data_bits = 8;
> +    ssp.parity = 'N';
> +    ssp.stop_bits = 1;
> +    ssp.speed = s->pclk_frq / s->bauddiv;
> +    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
> +    trace_cmsdk_apb_uart_set_params(ssp.speed);
> +}
> +
> +static void cmsdk_apb_uart_update(CMSDKAPBUART *s)
> +{
> +    /* update outbound irqs, including handling the way the rxo and txo
> +     * interrupt status bits are just logical AND of the overrun bit in
> +     * STATE and the overrun interrupt enable bit in CTRL.
> +     */
> +    uint32_t omask = (R_INTSTATUS_RXO_MASK | R_INTSTATUS_TXO_MASK);
> +    s->intstatus &= ~omask;
> +    s->intstatus |= (s->state & (s->ctrl >> 2) & omask);
> +
> +    qemu_set_irq(s->txint, !!(s->intstatus & R_INTSTATUS_TX_MASK));
> +    qemu_set_irq(s->rxint, !!(s->intstatus & R_INTSTATUS_RX_MASK));
> +    qemu_set_irq(s->txovrint, !!(s->intstatus & R_INTSTATUS_TXO_MASK));
> +    qemu_set_irq(s->rxovrint, !!(s->intstatus & R_INTSTATUS_RXO_MASK));
> +    qemu_set_irq(s->uartint, !!(s->intstatus));
> +}
> +
> +static int uart_can_receive(void *opaque)
> +{
> +    CMSDKAPBUART *s = CMSDK_APB_UART(opaque);
> +
> +    /* We can take a char if RX is enabled and the buffer is empty */
> +    if (s->ctrl & R_CTRL_RX_EN_MASK && !(s->state & R_STATE_RXFULL_MASK)) {
> +        return 1;
> +    }
> +    return 0;
> +}
> +
> +static void uart_receive(void *opaque, const uint8_t *buf, int size)
> +{
> +    CMSDKAPBUART *s = CMSDK_APB_UART(opaque);
> +
> +    trace_cmsdk_apb_uart_receive(*buf);
> +
> +    if (!(s->ctrl & R_CTRL_RX_EN_MASK)) {
> +        /* Just drop the character on the floor */
> +        return;

Doesn't this also deserve a guest error print.

> +    }
> +
> +    if (s->state & R_STATE_RXFULL_MASK) {
> +        s->state |= R_STATE_RXOVERRUN_MASK;
> +    }
> +
> +    s->rxbuf = *buf;
> +    s->state |= R_STATE_RXFULL_MASK;
> +    if (s->ctrl & R_CTRL_RX_INTEN_MASK) {
> +        s->intstatus |= R_INTSTATUS_RX_MASK;
> +    }
> +    cmsdk_apb_uart_update(s);
> +}
> +
> +static uint64_t uart_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    CMSDKAPBUART *s = CMSDK_APB_UART(opaque);
> +    uint64_t r;
> +
> +    switch (offset) {
> +    case A_DATA:
> +        r = s->rxbuf;
> +        s->state &= ~R_STATE_RXFULL_MASK;
> +        cmsdk_apb_uart_update(s);
> +        break;
> +    case A_STATE:
> +        r = s->state;
> +        break;
> +    case A_CTRL:
> +        r = s->ctrl;
> +        break;
> +    case A_INTSTATUS:
> +        r = s->intstatus;
> +        break;
> +    case A_BAUDDIV:
> +        r = s->bauddiv;
> +        break;

You used pasrt of the register API but not the second part. This seems
like a greaet device to use the register API on.

> +    case A_PID4 ... A_CID3:
> +        r = uart_id[offset / 4 - A_PID4];

I think this is the one you already found in the cover letter.

> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "CMSDK APB UART read: bad offset %x\n", (int) offset);
> +        r = 0;
> +        break;
> +    }
> +    trace_cmsdk_apb_uart_read(offset, r, size);
> +    return r;
> +}
> +
> +/* Try to send tx data, and arrange to be called back later if
> + * we can't (ie the char backend is busy/blocking).
> + */
> +static gboolean uart_transmit(GIOChannel *chan, GIOCondition cond, void *opaque)
> +{
> +    CMSDKAPBUART *s = CMSDK_APB_UART(opaque);
> +    int ret;
> +
> +    s->watch_tag = 0;
> +
> +    if (!(s->ctrl & R_CTRL_TX_EN_MASK) || !(s->state & R_STATE_TXFULL_MASK)) {
> +        return FALSE;
> +    }
> +
> +    ret = qemu_chr_fe_write(&s->chr, &s->txbuf, 1);
> +    if (ret <= 0) {
> +        s->watch_tag = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> +                                             uart_transmit, s);
> +        if (!s->watch_tag) {
> +            /* Most common reason to be here is "no chardev backend":
> +             * just insta-drain the buffer, so the serial output
> +             * goes into a void, rather than blocking the guest.
> +             */
> +            goto buffer_drained;
> +        }
> +        /* Transmit pending */
> +        trace_cmsdk_apb_uart_tx_pending();
> +        return FALSE;
> +    }
> +
> +buffer_drained:
> +    /* Character successfully sent */
> +    trace_cmsdk_apb_uart_tx(s->txbuf);
> +    s->state &= ~R_STATE_TXFULL_MASK;
> +    /* Going from TXFULL set to clear triggers the tx interrupt */
> +    if (s->ctrl & R_CTRL_TX_INTEN_MASK) {
> +        s->intstatus |= R_INTSTATUS_TX_MASK;
> +    }
> +    cmsdk_apb_uart_update(s);
> +    return FALSE;
> +}
> +
> +static void uart_cancel_transmit(CMSDKAPBUART *s)
> +{
> +    if (s->watch_tag) {
> +        g_source_remove(s->watch_tag);
> +        s->watch_tag = 0;
> +    }
> +}
> +
> +static void uart_write(void *opaque, hwaddr offset, uint64_t value,
> +                       unsigned size)
> +{
> +    CMSDKAPBUART *s = CMSDK_APB_UART(opaque);
> +
> +    trace_cmsdk_apb_uart_write(offset, value, size);
> +
> +    switch (offset) {
> +    case A_DATA:
> +    {
> +        s->txbuf = value;
> +        if (s->state & R_STATE_TXFULL_MASK) {
> +            /* Buffer already full -- note the overrun and let the
> +             * existing pending transmit callback handle the new char.
> +             */
> +            s->state |= R_STATE_TXOVERRUN_MASK;
> +            cmsdk_apb_uart_update(s);
> +        } else {
> +            s->state |= R_STATE_TXFULL_MASK;
> +            uart_transmit(NULL, G_IO_OUT, s);
> +        }
> +        break;
> +    }

Why is this case inside braces?

Thanks,
Alistair
