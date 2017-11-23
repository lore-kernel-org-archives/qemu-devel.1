Received: from eggs.gnu.org ([2001:4830:134:3::10]:35564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHtb1-0004GT-IU
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHtax-0007rD-Br
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:39:23 -0500
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:50031)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHtax-0007ph-1p
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:39:19 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 74D72171C3F
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 16:39:17 +0100 (CET)
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-7-mdavidsaver@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <91bd16b3-d1ef-674a-39dd-8ea21b78e0f9@kaod.org>
Date: Thu, 23 Nov 2017 16:39:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171120032420.9134-7-mdavidsaver@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 06/12] i2c: add mpc8540 i2c
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

Hello, 

The model should be QOM'ified. 

On 11/20/2017 04:24 AM, Michael Davidsaver wrote:
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  hw/i2c/Makefile.objs |   1 +
>  hw/i2c/mpc8540_i2c.c | 287 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 288 insertions(+)
>  create mode 100644 hw/i2c/mpc8540_i2c.c
> 
> diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
> index 0594dea3ae..79af1dd901 100644
> --- a/hw/i2c/Makefile.objs
> +++ b/hw/i2c/Makefile.objs
> @@ -9,3 +9,4 @@ common-obj-$(CONFIG_IMX_I2C) += imx_i2c.o
>  common-obj-$(CONFIG_ASPEED_SOC) += aspeed_i2c.o
>  obj-$(CONFIG_OMAP) += omap_i2c.o
>  obj-$(CONFIG_PPC4XX) += ppc4xx_i2c.o
> +obj-$(CONFIG_E500) += mpc8540_i2c.o
> diff --git a/hw/i2c/mpc8540_i2c.c b/hw/i2c/mpc8540_i2c.c
> new file mode 100644
> index 0000000000..884052cc9b
> --- /dev/null
> +++ b/hw/i2c/mpc8540_i2c.c
> @@ -0,0 +1,287 @@
> +/*
> + * MPC8540 I2C bus interface
> + * As described in
> + * MPC8540 PowerQUICC III Integrated Host Processor Reference Manual, Rev. 1
> + * Part 2 chapter 11
> + *
> + * Copyright (c) 2015 Michael Davidsaver
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the LICENSE file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/hw.h"
> +#include "hw/registerfields.h"
> +#include "hw/i2c/i2c.h"
> +#include "hw/sysbus.h"
> +
> +/* #define DEBUG_LVL 0 */
> +
> +#ifdef DEBUG_LVL
> +#define DPRINTK(LVL, FMT, ...) do { if ((LVL) <= DEBUG_LVL) { \
> +    printf(TYPE_MPC8540_I2C " : " FMT, ## __VA_ARGS__); } } while (0)

hmm, I am not sure 'printfs' are welcomed in QEMU. 

> +#else
> +#define DPRINTK(LVL, FMT, ...) do {} while (0)
> +#endif
> +
> +#define LOG(MSK, FMT, ...) qemu_log_mask(MSK, TYPE_MPC8540_I2C \
> +    " : " FMT, ## __VA_ARGS__)
>
> +#define TYPE_MPC8540_I2C "mpc8540-i2c"
> +#define MPC8540_I2C(obj) OBJECT_CHECK(I2CState, (obj), TYPE_MPC8540_I2C)
> +
> +/* offsets relative to CCSR offset 0x3000 */
> +#define R_I2CADR (0)
> +#define R_I2CFDR (4)
> +#define R_I2CCR  (8)
> +#define R_I2CSR  (0xc)
> +#define R_I2CDR  (0x10)
> +#define R_I2CDFSRR (0x14)
> +
> +FIELD(I2CCR, MEN, 7, 1)
> +FIELD(I2CCR, MIEN, 6, 1)
> +FIELD(I2CCR, MSTA, 5, 1)
> +FIELD(I2CCR, MTX, 4, 1)
> +FIELD(I2CCR, TXAK, 3, 1)
> +FIELD(I2CCR, RSTA, 2, 1)
> +FIELD(I2CCR, BCST, 0, 1)
> +
> +FIELD(I2CSR, MCF, 7, 1)
> +FIELD(I2CSR, MAAS, 6, 1)
> +FIELD(I2CSR, MBB, 5, 1)
> +FIELD(I2CSR, MAL, 4, 1)
> +FIELD(I2CSR, BCSTM, 3, 1)
> +FIELD(I2CSR, SRW, 2, 1)
> +FIELD(I2CSR, MIF, 1, 1)
> +FIELD(I2CSR, RXAK, 0, 1)
> +
> +typedef struct I2CState {
> +    SysBusDevice parent_obj;
> +
> +    I2CBus *bus;
> +
> +    uint8_t ctrl, sts;
> +    uint8_t freq, filt;
> +    /* Reads are pipelined, this is the next data value */
> +    uint8_t dbuf;
> +
> +    qemu_irq irq;
> +
> +    MemoryRegion mmio;
> +} I2CState;

May be use MPC8540I2CState ? I would put the definition in a header file  

> +#define I2CCR(BIT) FIELD_EX32(i2c->ctrl, I2CCR, BIT)
> +#define I2CSR(BIT) FIELD_EX32(i2c->sts, I2CSR, BIT)
> +
> +#define I2CSR_SET(BIT, VAL) do {\
> +        i2c->sts = FIELD_DP32(i2c->sts, I2CSR, BIT, VAL);\
> +    } while (0)
> +
> +static
> +void mpc8540_update_irq(I2CState *i2c)
> +{
> +    int ena = i2c->ctrl & 0x40,
> +        sts = i2c->sts & 0x02,
> +        act = !!(ena && sts);

OK. why not :) Three distinct lines would be better. This is minor.

> +    DPRINTK(1, "IRQ %c ena %c sts %c\n",
> +            act ? 'X' : '_',
> +            ena ? 'X' : '_',
> +            sts ? 'X' : '_');
> +
> +    qemu_set_irq(i2c->irq, act);
> +}
> +
> +static
> +uint64_t mpc8540_i2c_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    I2CState *i2c = opaque;
> +    uint32_t val, offset = addr;

This 'offset = addr' looks useless. do you really need it ? 


> +
> +    switch (offset) {
> +    case R_I2CADR: /* ADDR */
> +        val = 0;
> +        break;
> +    case R_I2CFDR: /* Freq Div. */
> +        val = i2c->freq;
> +        break;
> +    case R_I2CCR: /* CONTROL */
> +        val = i2c->ctrl & ~0x06;
> +        break;
> +    case R_I2CSR: /* STATUS */
> +        val = i2c->sts;
> +        break;
> +    case R_I2CDR: /* DATA */
> +        /* Reads are "pipelined" and so return the previous value of the
> +         * register
> +         */
> +        val = i2c->dbuf;
> +        if (I2CCR(MEN) && I2CSR(MBB)) { /* enabled and busy */
> +            if (!i2c_bus_busy(i2c->bus) || I2CCR(MTX)) {
> +                LOG(LOG_GUEST_ERROR, "Read during addr or tx\n");
> +                i2c->dbuf = 0xff;
> +            } else {
> +                int ret = i2c_recv(i2c->bus);
> +                i2c->dbuf = (uint8_t)ret;
> +                DPRINTK(0, "READ %02x ('%c')\n", i2c->dbuf, (char)i2c->dbuf);
> +                I2CSR_SET(MIF, 1);
> +                I2CSR_SET(RXAK, 0);
> +                mpc8540_update_irq(i2c);
> +            }
> +        } else {
> +            i2c->dbuf = 0xff;
> +            LOG(LOG_GUEST_ERROR, "Read when not enabled or busy\n");
> +        }
> +        break;
> +    case R_I2CDFSRR: /* FILTER */
> +        val = i2c->filt;
> +        break;
> +    default:
> +        val = 0xff;
> +    }
> +
> +    DPRINTK(offset == 0xc ? 2 : 1, " read %08x -> %08x\n",
> +            (unsigned)offset, (unsigned)val);
> +    return val;
> +}
> +
> +static
> +void mpc8540_i2c_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> +{
> +    I2CState *i2c = opaque;
> +    uint32_t offset = addr;
> +
> +    DPRINTK(1, " write %08x <- %08x\n", (unsigned)offset, (unsigned)val);
> +
> +    switch (offset) {
> +    case R_I2CADR: /* ADDR */
> +        break;
> +    case R_I2CFDR: /* Freq Div. */
> +        i2c->freq = val & 0x3f;
> +        break;
> +    case R_I2CCR: /* CONTROL CCR */
> +        if (!FIELD_EX32(val, I2CCR, MEN)) {
> +            DPRINTK(0, "Not Enabled\n");
> +
> +        } else if (!I2CCR(MSTA) && FIELD_EX32(val, I2CCR, MSTA)) {
> +            /* MSTA 0 -> 1 is START */
> +
> +            I2CSR_SET(MBB, 1);
> +            DPRINTK(0, "START\n");
> +            i2c_end_transfer(i2c->bus); /* paranoia */
> +
> +        } else if (I2CCR(MSTA) && !FIELD_EX32(val, I2CCR, MSTA)) {
> +            /* MSTA 1 -> 0 is STOP */
> +
> +            I2CSR_SET(MBB, 0);
> +            DPRINTK(0, "STOP\n");
> +            i2c_end_transfer(i2c->bus);
> +
> +        } else if (I2CCR(MSTA) && FIELD_EX32(val, I2CCR, RSTA)) {
> +            i2c_end_transfer(i2c->bus);
> +            I2CSR_SET(MBB, 1);
> +            DPRINTK(0, "REP START\n");
> +
> +        }
> +        /* RSTA always reads zero, bit 1 unusd */
> +        val &= 0xf9;
> +        i2c->ctrl = val;
> +        mpc8540_update_irq(i2c);
> +        break;
> +    case R_I2CSR: /* STATUS CSR */
> +        /* only MAL and MIF are writable */
> +        val &= 0x12;
> +        i2c->sts &= ~0x12;
> +        i2c->sts |= val;
> +        mpc8540_update_irq(i2c);
> +        break;
> +    case R_I2CDR: /* DATA CDR */
> +        if (I2CCR(MEN) && I2CSR(MBB)) { /* enabled and busy */
> +            if (!i2c_bus_busy(i2c->bus)) {
> +                if (i2c_start_transfer(i2c->bus, val >> 1, val & 1)) {
> +                    LOG(LOG_GUEST_ERROR, "I2C no device %02x\n",
> +                        (unsigned)(val & 0xfe));
> +                } else {
> +                    DPRINTK(0, "ADDR %02x\n", (unsigned)(val & 0xfe));
> +                }
> +                I2CSR_SET(MIF, 1);
> +                I2CSR_SET(RXAK, 0);
> +
> +            } else if (I2CCR(MTX)) {
> +                DPRINTK(0, "WRITE %02x\n", (unsigned)val);
> +                i2c_send(i2c->bus, val);
> +                I2CSR_SET(MIF, 1);
> +                I2CSR_SET(RXAK, 0);
> +            } else {
> +                LOG(LOG_GUEST_ERROR, "I2CDR Write during read\n");
> +            }
> +            mpc8540_update_irq(i2c);
> +        } else {
> +            LOG(LOG_GUEST_ERROR, "I2CDR Write when not enabled or busy\n");
> +        }
> +        break;
> +    case R_I2CDFSRR: /* FILTER */
> +        val &= 0x3f;
> +        i2c->filt = val;
> +        break;
> +    }
> +
> +    DPRINTK(1, "I2CCR = %02x I2SCR = %02x\n", i2c->ctrl, i2c->sts);
> +}
> +
> +static const MemoryRegionOps i2c_ops = {
> +    .read = mpc8540_i2c_read,
> +    .write = mpc8540_i2c_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,
> +    },
> +};
> +
> +static
> +void mpc8540_i2c_reset(DeviceState *dev)
> +{
> +    I2CState *i2c = MPC8540_I2C(dev);
> +
> +    i2c->sts = 0x81; /* transfer complete and ack received */
> +}
> +
> +static int mpc8540_i2c_inst_init(SysBusDevice *dev)
> +{
> +    I2CState *i2c = MPC8540_I2C(dev);
> +
> +    i2c->bus = i2c_init_bus(&dev->parent_obj, "bus");
> +
> +    memory_region_init_io(&i2c->mmio, &dev->parent_obj.parent_obj,
> +                          &i2c_ops, i2c, TYPE_MPC8540_I2C, 0x18);
> +
> +    sysbus_init_mmio(dev, &i2c->mmio);
> +    sysbus_init_irq(dev, &i2c->irq);
> +    return 0;
> +}

This should be a realize routine.

C.


> +static void mpc8540_i2c_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
> +
> +    k->init = &mpc8540_i2c_inst_init;
> +    dc->reset = &mpc8540_i2c_reset;
> +}
> +
> +static const TypeInfo mpc8540_i2c_type = {
> +    .name = TYPE_MPC8540_I2C,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(I2CState),
> +    .class_size = sizeof(SysBusDeviceClass),
> +    .class_init = mpc8540_i2c_class_init,
> +};
> +
> +static void mpc8540_i2c_register(void)
> +{
> +    type_register_static(&mpc8540_i2c_type);
> +}
> +
> +type_init(mpc8540_i2c_register)
> 
