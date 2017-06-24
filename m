Received: from eggs.gnu.org ([2001:4830:134:3::10]:33947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dOfid-0005HI-PZ
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 03:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dOfia-0000Nu-CU
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 03:42:59 -0400
MIME-Version: 1.0
In-Reply-To: <88198632-0a9c-0768-dd1e-3ecf2472e2be@amsat.org>
References: <1494949133-2202-1-git-send-email-sundeep.lkml@gmail.com>
	<1494949133-2202-4-git-send-email-sundeep.lkml@gmail.com>
	<88198632-0a9c-0768-dd1e-3ecf2472e2be@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Sat, 24 Jun 2017 13:12:53 +0530
Message-ID: <CALHRZuokB2CzMhv-0f1LegdcAwq2gWEzr53WdFrJc3RPRVqx1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel v5 PATCH 3/5] msf2: Add Smartfusion2
 SPI controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

Hi Philippe,

On Tue, May 30, 2017 at 6:45 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

>
>
> On 05/16/2017 12:38 PM, Subbaraya Sundeep wrote:
>
>> Modelled Microsemi's Smartfusion2 SPI controller.
>>
>> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> ---
>>  hw/ssi/Makefile.objs     |   1 +
>>  hw/ssi/mss-spi.c         | 378 ++++++++++++++++++++++++++++++
>> +++++++++++++++++
>>  include/hw/ssi/mss-spi.h | 104 +++++++++++++
>>  3 files changed, 483 insertions(+)
>>  create mode 100644 hw/ssi/mss-spi.c
>>  create mode 100644 include/hw/ssi/mss-spi.h
>>
>> diff --git a/hw/ssi/Makefile.objs b/hw/ssi/Makefile.objs
>> index 487add2..f5bcc65 100644
>> --- a/hw/ssi/Makefile.objs
>> +++ b/hw/ssi/Makefile.objs
>> @@ -4,6 +4,7 @@ common-obj-$(CONFIG_XILINX_SPI) +=3D xilinx_spi.o
>>  common-obj-$(CONFIG_XILINX_SPIPS) +=3D xilinx_spips.o
>>  common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_smc.o
>>  common-obj-$(CONFIG_STM32F2XX_SPI) +=3D stm32f2xx_spi.o
>> +common-obj-$(CONFIG_MSF2) +=3D mss-spi.o
>>
>>  obj-$(CONFIG_OMAP) +=3D omap_spi.o
>>  obj-$(CONFIG_IMX) +=3D imx_spi.o
>> diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
>> new file mode 100644
>> index 0000000..0b88ec9
>> --- /dev/null
>> +++ b/hw/ssi/mss-spi.c
>> @@ -0,0 +1,378 @@
>> +/*
>> + * Block model of SPI controller present in
>> + * Microsemi's SmartFusion2 and SmartFusion SoCs.
>> + *
>> + * Copyright (C) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtainin=
g
>> a copy
>> + * of this software and associated documentation files (the "Software")=
,
>> to deal
>> + * in the Software without restriction, including without limitation th=
e
>> rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
>> sell
>> + * copies of the Software, and to permit persons to whom the Software i=
s
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
>> +#include "hw/ssi/mss-spi.h"
>> +
>> +#ifndef MSS_SPI_ERR_DEBUG
>> +#define MSS_SPI_ERR_DEBUG   0
>> +#endif
>> +
>> +#define DB_PRINT_L(lvl, fmt, args...) do { \
>> +    if (MSS_SPI_ERR_DEBUG >=3D lvl) { \
>> +        qemu_log("%s: " fmt, __func__, ## args); \
>>
>
> Since you use newline in all your calls, you could move it here:
>
>     qemu_log("%s: " fmt "\n", __func__, ## args);
>
> Ok

> +    } \
>> +} while (0);
>> +
>> +#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
>> +
>> +static void txfifo_reset(MSSSpiState *s)
>> +{
>> +    fifo32_reset(&s->tx_fifo);
>> +
>> +    s->regs[R_SPI_STATUS] &=3D ~S_TXFIFOFUL;
>> +    s->regs[R_SPI_STATUS] |=3D S_TXFIFOEMP;
>> +}
>> +
>> +static void rxfifo_reset(MSSSpiState *s)
>> +{
>> +    fifo32_reset(&s->rx_fifo);
>> +
>> +    s->regs[R_SPI_STATUS] &=3D ~S_RXFIFOFUL;
>> +    s->regs[R_SPI_STATUS] |=3D S_RXFIFOEMP;
>> +}
>> +
>> +static void set_fifodepth(MSSSpiState *s)
>> +{
>> +    int size =3D s->regs[R_SPI_DFSIZE] & FRAMESZ_MASK;
>>
>
> This size is unsigned, isn't it?


Yes will change it.

>
>
> +
>> +    if (0 <=3D size && size <=3D 8) {
>>
>
> So "if (size <=3D 8)"
>
> +        s->fifo_depth =3D 32;
>> +    }
>> +    if (9 <=3D size && size <=3D 16) {
>>
>
> "else if (size <=3D 16)"
>
> +        s->fifo_depth =3D 16;
>> +    }
>> +    if (17 <=3D size && size <=3D 32) {
>>
>
> else if
>
> +        s->fifo_depth =3D 8;
>> +    }
>>
>
> else
>
> s->fifo_depth =3D 4;
>
> ?
>
> Ok will change it.

> +}
>> +
>> +static void mss_spi_do_reset(MSSSpiState *s)
>> +{
>> +    memset(s->regs, 0, sizeof s->regs);
>> +    s->regs[R_SPI_CONTROL] =3D 0x80000102;
>> +    s->regs[R_SPI_DFSIZE] =3D 0x4;
>> +    s->regs[R_SPI_STATUS] =3D 0x2440;
>>
>
> " =3D S_SSEL | S_TXFIFOEMP | S_RXFIFOEMP;"


OK.

>
>
> +    s->regs[R_SPI_CLKGEN] =3D 0x7;
>> +    s->regs[R_SPI_RIS] =3D 0x0;
>> +
>> +    s->fifo_depth =3D 4;
>>
>
> Resetting R_SPI_DFSIZE to 4, shouldn't fifo_depth be 32?


FIFO depth is 4 by default and  it varies based on BIGFIFO bit in control
register and frame size.

>
>
> +    s->frame_count =3D 1;
>> +    s->enabled =3D false;
>> +
>> +    rxfifo_reset(s);
>> +    txfifo_reset(s);
>> +}
>> +
>> +static void update_mis(MSSSpiState *s)
>> +{
>> +    uint32_t reg =3D s->regs[R_SPI_CONTROL];
>> +    uint32_t tmp;
>> +
>> +    /*
>> +     * form the Control register interrupt enable bits
>> +     * same as RIS, MIS and Interrupt clear registers for simplicity
>> +     */
>> +    tmp =3D ((reg & C_INTRXOVRFLO) >> 4) | ((reg & C_INTRXDATA) >> 3) |
>> +           ((reg & C_INTTXDATA) >> 5);
>> +    s->regs[R_SPI_MIS] |=3D tmp & s->regs[R_SPI_RIS];
>> +}
>> +
>> +static void spi_update_irq(MSSSpiState *s)
>> +{
>> +    int irq;
>> +
>> +    update_mis(s);
>> +    irq =3D !!(s->regs[R_SPI_MIS]);
>> +
>> +    qemu_set_irq(s->irq, irq);
>> +}
>> +
>> +static void mss_spi_reset(DeviceState *d)
>> +{
>> +    mss_spi_do_reset(MSS_SPI(d));
>> +}
>> +
>> +static uint64_t
>> +spi_read(void *opaque, hwaddr addr, unsigned int size)
>> +{
>> +    MSSSpiState *s =3D opaque;
>> +    uint32_t ret =3D 0;
>> +
>> +    addr >>=3D 2;
>> +    switch (addr) {
>> +    case R_SPI_RX:
>> +        s->regs[R_SPI_STATUS] &=3D ~S_RXFIFOFUL;
>> +        s->regs[R_SPI_STATUS] &=3D ~RXCHOVRF;
>> +        ret =3D fifo32_pop(&s->rx_fifo);
>> +        if (fifo32_is_empty(&s->rx_fifo)) {
>> +            s->regs[R_SPI_STATUS] |=3D S_RXFIFOEMP;
>> +        }
>> +        break;
>> +
>> +    case R_SPI_MIS:
>> +        update_mis(s);
>> +        ret =3D s->regs[R_SPI_MIS];
>> +        break;
>> +
>> +    default:
>> +        if (addr < ARRAY_SIZE(s->regs)) {
>> +            ret =3D s->regs[addr];
>> +        } else {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                         "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func_=
_,
>> +                         addr * 4);
>> +        }
>> +        break;
>> +    }
>> +
>> +    DB_PRINT("addr=3D0x%" HWADDR_PRIx " =3D 0x%" PRIx32 "\n", addr * 4,=
 ret);
>> +    spi_update_irq(s);
>> +    return ret;
>> +}
>> +
>> +static void assert_cs(MSSSpiState *s)
>> +{
>> +    qemu_set_irq(s->cs_line, 0);
>> +}
>> +
>> +static void deassert_cs(MSSSpiState *s)
>> +{
>> +    qemu_set_irq(s->cs_line, 1);
>> +}
>> +
>> +static void spi_flush_txfifo(MSSSpiState *s)
>> +{
>> +    uint32_t tx;
>> +    uint32_t rx;
>> +    bool sps =3D !!(s->regs[R_SPI_CONTROL] & C_SPS);
>> +
>> +    /*
>> +     * Chip Select(CS) is automatically controlled by this controller.
>> +     * If SPS bit is set in Control register then CS is asserted
>> +     * until all the frames set in frame count of Control register are
>> +     * transferred. If SPS is not set then CS pulses between frames.
>> +     * Note that Slave Select register specifies which of the CS line
>> +     * has to be controlled automatically by controller. Bits SS[7:1]
>> are for
>> +     * masters in FPGA fabric since we model only Microcontroller
>> subsystem
>> +     * of Smartfusion2 we control only one CS(SS[0]) line.
>> +     */
>> +    while (!fifo32_is_empty(&s->tx_fifo) && s->frame_count) {
>> +        assert_cs(s);
>> +
>> +        s->regs[R_SPI_STATUS] &=3D ~TXDONE;
>> +        s->regs[R_SPI_STATUS] &=3D ~RXRDY;
>>
>
> You can simplify as "&=3D ~(S_TXDONE | S_RXRDY);"


Ok.

>
>
> +
>> +        tx =3D fifo32_pop(&s->tx_fifo);
>> +        DB_PRINT("data tx:0x%" PRIx32 "\n", tx);
>> +        rx =3D ssi_transfer(s->spi, tx);
>> +        DB_PRINT("data rx:0x%" PRIx32 "\n", rx);
>> +
>> +        if (fifo32_num_used(&s->rx_fifo) =3D=3D s->fifo_depth) {
>> +            s->regs[R_SPI_STATUS] |=3D RXCHOVRF;
>> +            s->regs[R_SPI_RIS] |=3D RXCHOVRF;
>> +        } else {
>> +            fifo32_push(&s->rx_fifo, rx);
>> +            s->regs[R_SPI_STATUS] &=3D ~S_RXFIFOEMP;
>> +            if (fifo32_num_used(&s->rx_fifo) =3D=3D (s->fifo_depth - 1)=
) {
>> +                s->regs[R_SPI_STATUS] |=3D S_RXFIFOFULNXT;
>> +            }
>> +            if (fifo32_num_used(&s->rx_fifo) =3D=3D s->fifo_depth) {
>> +                s->regs[R_SPI_STATUS] |=3D S_RXFIFOFUL;
>> +            }
>> +        }
>> +        s->frame_count--;
>> +        if (!sps) {
>> +            deassert_cs(s);
>> +            assert_cs(s);
>> +        }
>> +    }
>> +
>> +    if (!sps) {
>> +        deassert_cs(s);
>> +    }
>> +
>> +    if (!s->frame_count) {
>> +        s->frame_count =3D (s->regs[R_SPI_CONTROL] & FMCOUNT_MASK) >>
>> +                            FMCOUNT_SHIFT;
>> +        if (sps) {
>> +            deassert_cs(s);
>> +        }
>> +        s->regs[R_SPI_RIS] |=3D TXDONE;
>> +        s->regs[R_SPI_RIS] |=3D RXRDY;
>>
>
> Same, "|=3D S_TXDONE | S_RXDRY;"


Ok.

>
>
> +        s->regs[R_SPI_STATUS] |=3D TXDONE;
>> +        s->regs[R_SPI_STATUS] |=3D RXRDY;
>> +   }
>> +}
>> +
>> +static void spi_write(void *opaque, hwaddr addr,
>> +            uint64_t val64, unsigned int size)
>> +{
>> +    MSSSpiState *s =3D opaque;
>> +    uint32_t value =3D val64;
>> +
>> +    DB_PRINT("addr=3D0x%" HWADDR_PRIx " =3D0x%" PRIx32 "\n", addr, valu=
e);
>> +    addr >>=3D 2;
>> +
>> +    switch (addr) {
>> +    case R_SPI_TX:
>> +        /* adding to already full FIFO */
>> +        if (fifo32_num_used(&s->tx_fifo) =3D=3D s->fifo_depth) {
>> +            break;
>> +        }
>> +        s->regs[R_SPI_STATUS] &=3D ~S_TXFIFOEMP;
>> +        fifo32_push(&s->tx_fifo, value);
>> +        if (fifo32_num_used(&s->tx_fifo) =3D=3D (s->fifo_depth - 1)) {
>> +            s->regs[R_SPI_STATUS] |=3D S_TXFIFOFULNXT;
>> +        }
>> +        if (fifo32_num_used(&s->tx_fifo) =3D=3D s->fifo_depth) {
>> +            s->regs[R_SPI_STATUS] |=3D S_TXFIFOFUL;
>> +        }
>> +        if (s->enabled) {
>> +            spi_flush_txfifo(s);
>> +        }
>> +        break;
>> +
>> +    case R_SPI_CONTROL:
>> +        s->regs[R_SPI_CONTROL] =3D value;
>> +        if (value & C_BIGFIFO) {
>> +            set_fifodepth(s);
>> +        } else {
>> +            s->fifo_depth =3D 4;
>> +        }
>> +        if (value & C_ENABLE) {
>> +            s->enabled =3D true;
>> +        } else {
>> +            s->enabled =3D false;
>> +        }
>>
>
> "s->enabled =3D value & C_ENABLE;" ?


Ok.

>
>
> +        s->frame_count =3D (value & FMCOUNT_MASK) >> FMCOUNT_SHIFT;
>> +        if (value & C_RESET) {
>> +            mss_spi_do_reset(s);
>> +        }
>> +        break;
>> +
>> +    case R_SPI_DFSIZE:
>> +        if (s->enabled) {
>> +            break;
>> +        }
>> +        s->regs[R_SPI_DFSIZE] =3D value;
>> +        break;
>> +
>> +    case R_SPI_INTCLR:
>> +        s->regs[R_SPI_INTCLR] =3D value;
>> +        if (value & TXDONE) {
>> +            s->regs[R_SPI_RIS] &=3D ~TXDONE;
>> +        }
>> +        if (value & RXRDY) {
>> +            s->regs[R_SPI_RIS] &=3D ~RXRDY;
>> +        }
>> +        if (value & RXCHOVRF) {
>> +            s->regs[R_SPI_RIS] &=3D ~RXCHOVRF;
>> +        }
>> +        break;
>> +
>> +    case R_SPI_MIS:
>> +    case R_SPI_STATUS:
>> +    case R_SPI_RIS:
>> +        break;
>>
>
> Those registers are read-only right? Maybe you should LOG_GUEST_ERROR her=
e
> too?


Ok.

>
>
> +
>> +    default:
>> +        if (addr < ARRAY_SIZE(s->regs)) {
>> +            s->regs[addr] =3D value;
>> +        } else {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                         "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func_=
_,
>> +                         addr * 4);
>> +        }
>> +        break;
>> +    }
>> +
>> +    spi_update_irq(s);
>> +}
>> +
>> +static const MemoryRegionOps spi_ops =3D {
>> +    .read =3D spi_read,
>> +    .write =3D spi_write,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +    .valid =3D {
>> +        .min_access_size =3D 1,
>> +        .max_access_size =3D 4
>> +    }
>> +};
>> +
>> +static void mss_spi_realize(DeviceState *dev, Error **errp)
>> +{
>> +    MSSSpiState *s =3D MSS_SPI(dev);
>> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>> +
>> +    DB_PRINT("\n");
>> +
>> +    s->spi =3D ssi_create_bus(dev, "spi0");
>>
>
> "0" is the Linux representation?


Yeah will remove 0.

>
>
> +
>> +    sysbus_init_irq(sbd, &s->irq);
>> +    ssi_auto_connect_slaves(dev, &s->cs_line, s->spi);
>> +    sysbus_init_irq(sbd, &s->cs_line);
>> +
>> +    memory_region_init_io(&s->mmio, OBJECT(s), &spi_ops, s,
>> +                          TYPE_MSS_SPI, R_SPI_MAX * 4);
>> +    sysbus_init_mmio(sbd, &s->mmio);
>> +
>> +    fifo32_create(&s->tx_fifo, FIFO_CAPACITY);
>> +    fifo32_create(&s->rx_fifo, FIFO_CAPACITY);
>> +}
>> +
>> +static const VMStateDescription vmstate_mss_spi =3D {
>> +    .name =3D TYPE_MSS_SPI,
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_FIFO32(tx_fifo, MSSSpiState),
>> +        VMSTATE_FIFO32(rx_fifo, MSSSpiState),
>> +        VMSTATE_UINT32_ARRAY(regs, MSSSpiState, R_SPI_MAX),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void mss_spi_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->realize =3D mss_spi_realize;
>> +    dc->reset =3D mss_spi_reset;
>> +    dc->vmsd =3D &vmstate_mss_spi;
>> +}
>> +
>> +static const TypeInfo mss_spi_info =3D {
>> +    .name           =3D TYPE_MSS_SPI,
>> +    .parent         =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size  =3D sizeof(MSSSpiState),
>> +    .class_init     =3D mss_spi_class_init,
>> +};
>> +
>> +static void mss_spi_register_types(void)
>> +{
>> +    type_register_static(&mss_spi_info);
>> +}
>> +
>> +type_init(mss_spi_register_types)
>> diff --git a/include/hw/ssi/mss-spi.h b/include/hw/ssi/mss-spi.h
>> new file mode 100644
>> index 0000000..091307a
>> --- /dev/null
>> +++ b/include/hw/ssi/mss-spi.h
>> @@ -0,0 +1,104 @@
>> +/*
>> + * Microsemi SmartFusion2 SPI
>> + *
>> + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtainin=
g
>> a copy
>> + * of this software and associated documentation files (the "Software")=
,
>> to deal
>> + * in the Software without restriction, including without limitation th=
e
>> rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
>> sell
>> + * copies of the Software, and to permit persons to whom the Software i=
s
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
>> +#ifndef HW_MSS_SPI_H
>> +#define HW_MSS_SPI_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/hw.h"
>> +#include "hw/ssi/ssi.h"
>> +#include "qemu/fifo32.h"
>> +#include "sysemu/sysemu.h"
>> +#include "qemu/log.h"
>> +
>> +#define FIFO_CAPACITY     32
>> +#define FIFO_CAPACITY     32
>> +
>> +#define R_SPI_CONTROL         0
>> +#define R_SPI_DFSIZE          1
>> +#define R_SPI_STATUS          2
>> +#define R_SPI_INTCLR          3
>> +#define R_SPI_RX              4
>> +#define R_SPI_TX              5
>> +#define R_SPI_CLKGEN          6
>> +#define R_SPI_SS              7
>> +#define R_SPI_MIS             8
>> +#define R_SPI_RIS             9
>> +#define R_SPI_MAX             16
>> +
>> +#define S_RXFIFOFUL       (1 << 4)
>> +#define S_RXFIFOFULNXT    (1 << 5)
>> +#define S_RXFIFOEMP       (1 << 6)
>> +#define S_RXFIFOEMPNXT    (1 << 7)
>> +#define S_TXFIFOFUL       (1 << 8)
>> +#define S_TXFIFOFULNXT    (1 << 9)
>> +#define S_TXFIFOEMP       (1 << 10)
>> +#define S_TXFIFOEMPNXT    (1 << 11)
>> +#define S_FRAMESTART      (1 << 12)
>> +#define S_SSEL            (1 << 13)
>> +#define S_ACTIVE          (1 << 14)
>> +
>> +#define C_ENABLE          (1 << 0)
>> +#define C_MODE            (1 << 1)
>> +#define C_INTRXDATA       (1 << 4)
>> +#define C_INTTXDATA       (1 << 5)
>> +#define C_INTRXOVRFLO     (1 << 6)
>> +#define C_SPS             (1 << 26)
>> +#define C_BIGFIFO         (1 << 29)
>> +#define C_RESET           (1 << 31)
>> +
>> +#define FRAMESZ_MASK      0x1F
>> +#define FMCOUNT_MASK      0x00FFFF00
>> +#define FMCOUNT_SHIFT     8
>> +
>>
>
> Try to keep the previous definitions in the C source, since there are not
> useful outside of it. Except R_SPI_MAX I think you can move all of them.
>
> OK

> +#define TXDONE            (1 << 0)
>> +#define RXRDY             (1 << 1)
>> +#define RXCHOVRF          (1 << 2)
>> +
>>
>
> These last 3 seems to be S_TXDONE, S_RXRDY, S_RXCHOVRF.
>
>
> Ok

Thanks,
Sundeep

>
> +#define TYPE_MSS_SPI   "mss-spi"
>> +#define MSS_SPI(obj)   OBJECT_CHECK(MSSSpiState, (obj), TYPE_MSS_SPI)
>> +
>> +typedef struct MSSSpiState {
>> +    SysBusDevice parent_obj;
>> +
>> +    MemoryRegion mmio;
>> +
>> +    qemu_irq irq;
>> +
>> +    qemu_irq cs_line;
>> +
>> +    SSIBus *spi;
>> +
>> +    Fifo32 rx_fifo;
>> +    Fifo32 tx_fifo;
>> +
>> +    int fifo_depth;
>> +    uint32_t frame_count;
>> +    bool enabled;
>> +
>> +    uint32_t regs[R_SPI_MAX];
>> +} MSSSpiState;
>> +
>> +#endif /* HW_MSS_SPI_H */
>>
>>
> Regards,
>
> Phil.
>
