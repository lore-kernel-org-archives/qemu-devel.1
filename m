Received: from eggs.gnu.org ([2001:4830:134:3::10]:47340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebJ7z-0006kk-Ex
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebJ7w-0003rF-AY
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:45:39 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-9-andrew.smirnov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ebab631b-7d14-dd9a-8e81-e76830bfda02@amsat.org>
Date: Tue, 16 Jan 2018 01:45:32 -0300
MIME-Version: 1.0
In-Reply-To: <20180116013709.13830-9-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 08/14] i.MX: Add implementation of i.MX7
 GPR IP block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, yurovsky@gmail.com

On 01/15/2018 10:37 PM, Andrey Smirnov wrote:
> Add minimal code needed to allow upstream Linux guest to boot.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/misc/Makefile.objs      |   1 +
>  hw/misc/imx7_gpr.c         | 119 +++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/misc/imx7_gpr.h |  28 +++++++++++
>  3 files changed, 148 insertions(+)
>  create mode 100644 hw/misc/imx7_gpr.c
>  create mode 100644 include/hw/misc/imx7_gpr.h
> 
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 019886912c..fce426eb75 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -36,6 +36,7 @@ obj-$(CONFIG_IMX) += imx6_src.o
>  obj-$(CONFIG_IMX) += imx7_ccm.o
>  obj-$(CONFIG_IMX) += imx2_wdt.o
>  obj-$(CONFIG_IMX) += imx7_snvs.o
> +obj-$(CONFIG_IMX) += imx7_gpr.o
>  obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
>  obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
>  obj-$(CONFIG_MAINSTONE) += mst_fpga.o
> diff --git a/hw/misc/imx7_gpr.c b/hw/misc/imx7_gpr.c
> new file mode 100644
> index 0000000000..9e8ccea9e8
> --- /dev/null
> +++ b/hw/misc/imx7_gpr.c
> @@ -0,0 +1,119 @@
> +/*
> + * Copyright (c) 2017, Impinj, Inc.
> + *
> + * i.MX7 GPR IP block emulation code
> + *
> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * Bare minimum emulation code needed to support being able to shut
> + * down linux guest gracefully.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/misc/imx7_gpr.h"
> +#include "qemu/log.h"
> +#include "sysemu/sysemu.h"
> +
> +enum IMX7GPRRegisters {
> +    IOMUXC_GPR0  = 0x00,
> +    IOMUXC_GPR1  = 0x04,
> +    IOMUXC_GPR2  = 0x08,
> +    IOMUXC_GPR3  = 0x0c,
> +    IOMUXC_GPR4  = 0x10,
> +    IOMUXC_GPR5  = 0x14,
> +    IOMUXC_GPR6  = 0x18,
> +    IOMUXC_GPR7  = 0x1c,
> +    IOMUXC_GPR8  = 0x20,
> +    IOMUXC_GPR9  = 0x24,
> +    IOMUXC_GPR10 = 0x28,
> +    IOMUXC_GPR11 = 0x2c,
> +    IOMUXC_GPR12 = 0x30,
> +    IOMUXC_GPR13 = 0x34,
> +    IOMUXC_GPR14 = 0x38,
> +    IOMUXC_GPR15 = 0x3c,
> +    IOMUXC_GPR16 = 0x40,
> +    IOMUXC_GPR17 = 0x44,
> +    IOMUXC_GPR18 = 0x48,
> +    IOMUXC_GPR19 = 0x4c,
> +    IOMUXC_GPR20 = 0x50,
> +    IOMUXC_GPR21 = 0x54,
> +    IOMUXC_GPR22 = 0x58,
> +};
> +
> +#define IMX7D_GPR1_IRQ_MASK                 BIT(12)
> +#define IMX7D_GPR1_ENET1_TX_CLK_SEL_MASK    BIT(13)
> +#define IMX7D_GPR1_ENET2_TX_CLK_SEL_MASK    BIT(14)
> +#define IMX7D_GPR1_ENET_TX_CLK_SEL_MASK     (0x3 << 13)
> +#define IMX7D_GPR1_ENET1_CLK_DIR_MASK       BIT(17)
> +#define IMX7D_GPR1_ENET2_CLK_DIR_MASK       BIT(18)
> +#define IMX7D_GPR1_ENET_CLK_DIR_MASK        (0x3 << 17)
> +
> +#define IMX7D_GPR5_CSI_MUX_CONTROL_MIPI     BIT(4)
> +#define IMX7D_GPR12_PCIE_PHY_REFCLK_SEL     BIT(5)
> +#define IMX7D_GPR22_PCIE_PHY_PLL_LOCKED     BIT(31)
> +
> +
> +static uint64_t imx7_gpr_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    if (offset == IOMUXC_GPR22) {
> +        return IMX7D_GPR22_PCIE_PHY_PLL_LOCKED;
> +    }
> +
> +    return 0;
> +}
> +
> +static void imx7_gpr_write(void *opaque, hwaddr offset,
> +                           uint64_t v, unsigned size)
> +{

If you ever respin, please add a trace point here (just copy/paste from
another file from the same directory), and in the read() function.

Linux will evolve and use more registers from this device (and the other
devices you are modelling), and a Linux driver busy loop is likely to
hang QEMU. A trace event will ease your board next user soon :)

That said,

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +}
> +
> +static const struct MemoryRegionOps imx7_gpr_ops = {
> +    .read = imx7_gpr_read,
> +    .write = imx7_gpr_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        /*
> +         * Our device would not work correctly if the guest was doing
> +         * unaligned access. This might not be a limitation on the
> +         * real device but in practice there is no reason for a guest
> +         * to access this device unaligned.
> +         */
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static void imx7_gpr_init(Object *obj)
> +{
> +    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
> +    IMX7GPRState *s = IMX7_GPR(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &imx7_gpr_ops, s,
> +                          TYPE_IMX7_GPR, 64 * 1024);
> +    sysbus_init_mmio(sd, &s->mmio);
> +}
> +
> +static void imx7_gpr_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc  = "i.MX7 General Purpose Registers Module";
> +}
> +
> +static const TypeInfo imx7_gpr_info = {
> +    .name          = TYPE_IMX7_GPR,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(IMX7GPRState),
> +    .instance_init = imx7_gpr_init,
> +    .class_init    = imx7_gpr_class_init,
> +};
> +
> +static void imx7_gpr_register_type(void)
> +{
> +    type_register_static(&imx7_gpr_info);
> +}
> +type_init(imx7_gpr_register_type)
> diff --git a/include/hw/misc/imx7_gpr.h b/include/hw/misc/imx7_gpr.h
> new file mode 100644
> index 0000000000..e19373d274
> --- /dev/null
> +++ b/include/hw/misc/imx7_gpr.h
> @@ -0,0 +1,28 @@
> +/*
> + * Copyright (c) 2017, Impinj, Inc.
> + *
> + * i.MX7 GPR IP block emulation code
> + *
> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef IMX7_GPR_H
> +#define IMX7_GPR_H
> +
> +#include "qemu/bitops.h"
> +#include "hw/sysbus.h"
> +
> +#define TYPE_IMX7_GPR "imx7.gpr"
> +#define IMX7_GPR(obj) OBJECT_CHECK(IMX7GPRState, (obj), TYPE_IMX7_GPR)
> +
> +typedef struct IMX7GPRState {
> +    /* <private> */
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +} IMX7GPRState;
> +
> +#endif /* IMX7_GPR_H */
> 
