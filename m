Received: from eggs.gnu.org ([2001:4830:134:3::10]:36940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1d63s4-0003Ul-LG
	for qemu-devel@nongnu.org; Wed, 03 May 2017 19:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1d63s2-0001vF-V2
	for qemu-devel@nongnu.org; Wed, 03 May 2017 19:39:48 -0400
MIME-Version: 1.0
In-Reply-To: <1493398313-6673-4-git-send-email-sundeep.lkml@gmail.com>
References: <1493398313-6673-1-git-send-email-sundeep.lkml@gmail.com>
	<1493398313-6673-4-git-send-email-sundeep.lkml@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 May 2017 16:39:14 -0700
Message-ID: <CAKmqyKN04cG=KJXrR=gDjCqtVM4yzw2abs-aRoUGEpoLzbx3RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-devel RFC v3 3/5] msf2: Add Smartfusion2 SPI
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

(_On Fri, Apr 28, 2017 at 9:51 AM, Subbaraya Sundeep
<sundeep.lkml@gmail.com> wrote:
> Modelled Microsemi's Smartfusion2 SPI controller.
>
> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> ---
> Hi Peter and Alistair,
>
> I created two SPI controllers as per SoC spec
> in hw/arm/msf2_soc.c. I am assuming there has to be two
> busses spi0 and spi1 one for each controller. In board file
> (hw/arm/msf2_som.c) attached SPI flash to SPI0 controller.
> I am not able to understand(from hw/ssi/xilinx_spips.c)
> how to create two busses in hw/ssi/msf2_spi.c.
> Please help me here. Below is the output of info qtree:
>
> (qemu) info qtree
> bus: main-system-bus
>   type System
>   dev: msf2-soc, id ""
>     cpu-model = "cortex-m3"
>   dev: msf2-spi, id ""
>     gpio-out "sysbus-irq" 2
>     mmio 0000000040011000/0000000000000040
>     bus: spi0
>       type SSI
>   dev: msf2-spi, id ""
>     gpio-out "sysbus-irq" 2
>     mmio 0000000040001000/0000000000000040
>     bus: spi0
>       type SSI
>       dev: s25sl12801, id ""
>         gpio-in "ssi-gpio-cs" 1
>         nonvolatile-cfg = 36863 (0x8fff)
>         spansion-cr1nv = 0 (0x0)
>         spansion-cr2nv = 1 (0x1)
>         spansion-cr3nv = 2 (0x2)
>         spansion-cr4nv = 16 (0x10)
>         drive = "mtd0"

Hey Sundeep,

This looks like you have created two SPI devices with one bus each.
What you want (I think) is one SPI device with two busses.

>
> Thanks,
> Sundeep
>
>  hw/ssi/Makefile.objs      |   1 +
>  hw/ssi/msf2_spi.c         | 373 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ssi/msf2_spi.h | 102 +++++++++++++
>  3 files changed, 476 insertions(+)
>  create mode 100644 hw/ssi/msf2_spi.c
>  create mode 100644 include/hw/ssi/msf2_spi.h
>
> diff --git a/hw/ssi/Makefile.objs b/hw/ssi/Makefile.objs
> index 487add2..86445d7 100644
> --- a/hw/ssi/Makefile.objs
> +++ b/hw/ssi/Makefile.objs
> @@ -4,6 +4,7 @@ common-obj-$(CONFIG_XILINX_SPI) += xilinx_spi.o
>  common-obj-$(CONFIG_XILINX_SPIPS) += xilinx_spips.o
>  common-obj-$(CONFIG_ASPEED_SOC) += aspeed_smc.o
>  common-obj-$(CONFIG_STM32F2XX_SPI) += stm32f2xx_spi.o
> +common-obj-$(CONFIG_MSF2) += msf2_spi.o
>
>  obj-$(CONFIG_OMAP) += omap_spi.o
>  obj-$(CONFIG_IMX) += imx_spi.o
> diff --git a/hw/ssi/msf2_spi.c b/hw/ssi/msf2_spi.c
> new file mode 100644
> index 0000000..e7ffa21
> --- /dev/null
> +++ b/hw/ssi/msf2_spi.c
> @@ -0,0 +1,373 @@
> +/*
> + * SPI controller model of Microsemi SmartFusion2.
> + *
> + * Copyright (C) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/ssi/msf2_spi.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/log.h"
> +
> +#ifndef MSF2_SPI_ERR_DEBUG
> +#define MSF2_SPI_ERR_DEBUG   0
> +#endif
> +
> +#define DB_PRINT_L(lvl, fmt, args...) do { \
> +    if (MSF2_SPI_ERR_DEBUG >= lvl) { \
> +        qemu_log("%s: " fmt, __func__, ## args); \
> +    } \
> +} while (0);
> +
> +#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
> +
> +static void txfifo_reset(MSF2SpiState *s)
> +{
> +    fifo32_reset(&s->tx_fifo);
> +
> +    s->regs[R_SPI_STATUS] &= ~S_TXFIFOFUL;
> +    s->regs[R_SPI_STATUS] |= S_TXFIFOEMP;
> +}
> +
> +static void rxfifo_reset(MSF2SpiState *s)
> +{
> +    fifo32_reset(&s->rx_fifo);
> +
> +    s->regs[R_SPI_STATUS] &= ~S_RXFIFOFUL;
> +    s->regs[R_SPI_STATUS] |= S_RXFIFOEMP;
> +}
> +
> +static void set_fifodepth(MSF2SpiState *s)
> +{
> +    int size = s->regs[R_SPI_DFSIZE] & FRAMESZ_MASK;
> +
> +    if (0 <= size && size <= 8) {
> +        s->fifo_depth = 32;
> +    }
> +    if (9 <= size && size <= 16) {
> +        s->fifo_depth = 16;
> +    }
> +    if (17 <= size && size <= 32) {
> +        s->fifo_depth = 8;
> +    }
> +}
> +
> +static void msf2_spi_do_reset(MSF2SpiState *s)
> +{
> +    memset(s->regs, 0, sizeof s->regs);
> +    s->regs[R_SPI_CONTROL] = 0x80000102;
> +    s->regs[R_SPI_DFSIZE] = 0x4;
> +    s->regs[R_SPI_STATUS] = 0x2440;
> +    s->regs[R_SPI_CLKGEN] = 0x7;
> +    s->regs[R_SPI_STAT8] = 0x7;
> +    s->regs[R_SPI_RIS] = 0x0;
> +
> +    s->fifo_depth = 4;
> +    s->frame_count = 1;
> +    s->enabled = false;
> +
> +    rxfifo_reset(s);
> +    txfifo_reset(s);
> +}
> +
> +static void update_mis(MSF2SpiState *s)
> +{
> +    uint32_t reg = s->regs[R_SPI_CONTROL];
> +    uint32_t tmp;
> +
> +    /*
> +     * form the Control register interrupt enable bits
> +     * same as RIS, MIS and Interrupt clear registers for simplicity
> +     */
> +    tmp = ((reg & C_INTRXOVRFLO) >> 4) | ((reg & C_INTRXDATA) >> 3) |
> +           ((reg & C_INTTXDATA) >> 5);
> +    s->regs[R_SPI_MIS] |= tmp & s->regs[R_SPI_RIS];
> +}
> +
> +static void spi_update_irq(MSF2SpiState *s)
> +{
> +    int irq;
> +
> +    update_mis(s);
> +    irq = !!(s->regs[R_SPI_MIS]);
> +
> +    qemu_set_irq(s->irq, irq);
> +}
> +
> +static void msf2_spi_reset(DeviceState *d)
> +{
> +    msf2_spi_do_reset(MSF2_SPI(d));
> +}
> +
> +static uint64_t
> +spi_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    MSF2SpiState *s = opaque;
> +    uint32_t r = 0;
> +
> +    addr >>= 2;
> +    switch (addr) {
> +    case R_SPI_RX:
> +        s->regs[R_SPI_STATUS] &= ~S_RXFIFOFUL;
> +        s->regs[R_SPI_STATUS] &= ~RXCHOVRF;
> +        r = fifo32_pop(&s->rx_fifo);
> +        if (fifo32_is_empty(&s->rx_fifo)) {
> +            s->regs[R_SPI_STATUS] |= S_RXFIFOEMP;
> +        }
> +        break;
> +
> +    case R_SPI_MIS:
> +        update_mis(s);
> +        r = s->regs[R_SPI_MIS];
> +        break;
> +
> +    default:
> +        if (addr < ARRAY_SIZE(s->regs)) {
> +            r = s->regs[addr];
> +        }
> +        break;
> +    }
> +
> +    DB_PRINT("addr=" TARGET_FMT_plx " = %x\n", addr * 4, r);
> +    spi_update_irq(s);
> +    return r;
> +}
> +
> +static void assert_cs(MSF2SpiState *s)
> +{
> +    qemu_set_irq(s->cs_line, 0);
> +}
> +
> +static void deassert_cs(MSF2SpiState *s)
> +{
> +    qemu_set_irq(s->cs_line, 1);
> +}
> +
> +static void spi_flush_txfifo(MSF2SpiState *s)
> +{
> +    uint32_t tx;
> +    uint32_t rx;
> +    bool sps = !!(s->regs[R_SPI_CONTROL] & C_SPS);
> +
> +    /*
> +     * Chip Select(CS) is automatically controlled by this controller.
> +     * If SPS bit is set in Control register then CS is asserted
> +     * until all the frames set in frame count of Control register are
> +     * transferred. If SPS is not set then CS pulses between frames.
> +     * Note that Slave Select register specifies which of the CS line
> +     * has to be controlled automatically by controller. Bits SS[7:1] are for
> +     * masters in FPGA fabric since we model only Microcontroller subsystem
> +     * of Smartfusion2 we control only one CS(SS[0]) line.
> +     */
> +    while (!fifo32_is_empty(&s->tx_fifo) && s->frame_count) {
> +        assert_cs(s);
> +
> +        s->regs[R_SPI_STATUS] &= ~TXDONE;
> +        s->regs[R_SPI_STATUS] &= ~RXRDY;
> +
> +        tx = fifo32_pop(&s->tx_fifo);
> +        DB_PRINT("data tx:%x\n", tx);
> +        rx = ssi_transfer(s->spi, tx);
> +        DB_PRINT("data rx:%x\n", rx);
> +
> +        if (fifo32_num_used(&s->rx_fifo) == s->fifo_depth) {
> +            s->regs[R_SPI_STATUS] |= RXCHOVRF;
> +            s->regs[R_SPI_RIS] |= RXCHOVRF;
> +        } else {
> +            fifo32_push(&s->rx_fifo, rx);
> +            s->regs[R_SPI_STATUS] &= ~S_RXFIFOEMP;
> +            if (fifo32_num_used(&s->rx_fifo) == (s->fifo_depth - 1)) {
> +                s->regs[R_SPI_STATUS] |= S_RXFIFOFULNXT;
> +            }
> +            if (fifo32_num_used(&s->rx_fifo) == s->fifo_depth) {
> +                s->regs[R_SPI_STATUS] |= S_RXFIFOFUL;
> +            }
> +        }
> +        s->frame_count--;
> +        if (!sps) {
> +            deassert_cs(s);
> +            assert_cs(s);
> +        }
> +    }
> +
> +    if (!sps) {
> +        deassert_cs(s);
> +    }
> +
> +    if (!s->frame_count) {
> +        s->frame_count = (s->regs[R_SPI_CONTROL] & FMCOUNT_MASK) >>
> +                            FMCOUNT_SHIFT;
> +        if (sps) {
> +            deassert_cs(s);
> +        }
> +        s->regs[R_SPI_RIS] |= TXDONE;
> +        s->regs[R_SPI_RIS] |= RXRDY;
> +        s->regs[R_SPI_STATUS] |= TXDONE;
> +        s->regs[R_SPI_STATUS] |= RXRDY;
> +   }
> +}
> +
> +static void spi_write(void *opaque, hwaddr addr,
> +            uint64_t val64, unsigned int size)
> +{
> +    MSF2SpiState *s = opaque;
> +    uint32_t value = val64;
> +
> +    DB_PRINT("addr=" TARGET_FMT_plx " = %x\n", addr, value);
> +    addr >>= 2;
> +
> +    switch (addr) {
> +    case R_SPI_TX:
> +        /* adding to already full FIFO */
> +        if (fifo32_num_used(&s->tx_fifo) == s->fifo_depth) {
> +            break;
> +        }
> +        s->regs[R_SPI_STATUS] &= ~S_TXFIFOEMP;
> +        fifo32_push(&s->tx_fifo, value);
> +        if (fifo32_num_used(&s->tx_fifo) == (s->fifo_depth - 1)) {
> +            s->regs[R_SPI_STATUS] |= S_TXFIFOFULNXT;
> +        }
> +        if (fifo32_num_used(&s->tx_fifo) == s->fifo_depth) {
> +            s->regs[R_SPI_STATUS] |= S_TXFIFOFUL;
> +        }
> +        if (s->enabled) {
> +            spi_flush_txfifo(s);
> +        }
> +        break;
> +
> +    case R_SPI_CONTROL:
> +        s->regs[R_SPI_CONTROL] = value;
> +        if (value & C_BIGFIFO) {
> +            set_fifodepth(s);
> +        } else {
> +            s->fifo_depth = 4;
> +        }
> +        if (value & C_ENABLE) {
> +            s->enabled = true;
> +        } else {
> +            s->enabled = false;
> +        }
> +        s->frame_count = (value & FMCOUNT_MASK) >> FMCOUNT_SHIFT;
> +        if (value & C_RESET) {
> +            msf2_spi_do_reset(s);
> +        }
> +        break;
> +
> +    case R_SPI_DFSIZE:
> +        if (s->enabled) {
> +            break;
> +        }
> +        s->regs[R_SPI_DFSIZE] = value;
> +        break;
> +
> +    case R_SPI_INTCLR:
> +        s->regs[R_SPI_INTCLR] = value;
> +        if (value & TXDONE) {
> +            s->regs[R_SPI_RIS] &= ~TXDONE;
> +        }
> +        if (value & RXRDY) {
> +            s->regs[R_SPI_RIS] &= ~RXRDY;
> +        }
> +        if (value & RXCHOVRF) {
> +            s->regs[R_SPI_RIS] &= ~RXCHOVRF;
> +        }
> +        break;
> +
> +    case R_SPI_MIS:
> +    case R_SPI_STATUS:
> +    case R_SPI_RIS:
> +        break;
> +
> +    default:
> +        if (addr < ARRAY_SIZE(s->regs)) {
> +            s->regs[addr] = value;
> +        }
> +        break;
> +    }
> +
> +    spi_update_irq(s);
> +}
> +
> +static const MemoryRegionOps spi_ops = {
> +    .read = spi_read,
> +    .write = spi_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4
> +    }
> +};
> +
> +static void msf2_spi_realize(DeviceState *dev, Error **errp)
> +{
> +    MSF2SpiState *s = MSF2_SPI(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    DB_PRINT("\n");
> +
> +    s->spi = ssi_create_bus(dev, "spi0");

You want to create a seperate spi bus "spi1" here as well.

Then the parent can call qdev_get_child_bus() to get the bus. In the
ZynqMP example we have to make an alias to pass it from the SoC to the
board.

Thanks,

Alistair

> +
> +    sysbus_init_irq(sbd, &s->irq);
> +    ssi_auto_connect_slaves(dev, &s->cs_line, s->spi);
> +    sysbus_init_irq(sbd, &s->cs_line);
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), &spi_ops, s,
> +                          TYPE_MSF2_SPI, R_SPI_MAX * 4);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +
> +    fifo32_create(&s->tx_fifo, FIFO_CAPACITY);
> +    fifo32_create(&s->rx_fifo, FIFO_CAPACITY);
> +}
