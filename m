Received: from eggs.gnu.org ([2001:4830:134:3::10]:40737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmu0w-0003zF-0p
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmu0u-0001eb-MF
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:50:02 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503938283-12404-1-git-send-email-sundeep.lkml@gmail.com>
	<1503938283-12404-6-git-send-email-sundeep.lkml@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d57d4bab-51ec-901c-7474-20dc5156f795@amsat.org>
Date: Tue, 29 Aug 2017 22:48:59 -0300
MIME-Version: 1.0
In-Reply-To: <1503938283-12404-6-git-send-email-sundeep.lkml@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu devel v7 PATCH 5/5] msf2: Add Emcraft's
 Smartfusion2 SOM kit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, crosthwaite.peter@gmail.com, alistair23@gmail.com

Hi Subbaraya,

On 08/28/2017 01:38 PM, Subbaraya Sundeep wrote:
> Emulated Emcraft's Smartfusion2 System On Module starter
> kit.
> 
> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> ---
>   hw/arm/Makefile.objs |  2 +-
>   hw/arm/msf2-som.c    | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 95 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/msf2-som.c
> 
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index df36a03..e81a7dc 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -19,4 +19,4 @@ obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
>   obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
>   obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
>   obj-$(CONFIG_MPS2) += mps2.o
> -obj-$(CONFIG_MSF2) += msf2-soc.o
> +obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
> diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
> new file mode 100644
> index 0000000..fd89ba9
> --- /dev/null
> +++ b/hw/arm/msf2-som.c
> @@ -0,0 +1,94 @@
> +/*
> + * SmartFusion2 SOM starter kit(from Emcraft) emulation.
> + *
> + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
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
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/arm/arm.h"
> +#include "exec/address-spaces.h"
> +#include "qemu/cutils.h"
> +#include "hw/arm/msf2-soc.h"
> +
> +#define DDR_BASE_ADDRESS      0xA0000000
> +#define DDR_SIZE              (64 * M_BYTE)
> +
> +#define M2S010_ENVM_SIZE      (256 * K_BYTE)
> +#define M2S010_ESRAM_SIZE     (64 * K_BYTE)
> +
> +static void emcraft_sf2_init(MachineState *machine)

Since Emcraft can produce an upgraded SF2 SoC based on a different MCU, 
I prefer you rename it:

static void emcraft_sf2_s2s010_init(MachineState *machine)

> +{
> +    DeviceState *dev;
> +    DeviceState *spi_flash;
> +    MSF2State *soc;
> +    DriveInfo *dinfo = drive_get_next(IF_MTD);
> +    qemu_irq cs_line;
> +    SSIBus *spi_bus;
> +    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *ddr = g_new(MemoryRegion, 1);
> +
> +    memory_region_init_ram(ddr, NULL, "ddr-ram", DDR_SIZE,
> +                           &error_fatal);
> +    memory_region_add_subregion(sysmem, DDR_BASE_ADDRESS, ddr);
> +
> +    dev = qdev_create(NULL, TYPE_MSF2_SOC);
> +    qdev_prop_set_string(dev, "part-name", "M2S010");
> +    qdev_prop_set_uint64(dev, "eNVM-size", M2S010_ENVM_SIZE);
> +    qdev_prop_set_uint64(dev, "eSRAM-size", M2S010_ESRAM_SIZE);
> +
> +    /*
> +     * CPU clock and peripheral clocks(APB0, APB1)are configurable
> +     * in Libero. CPU clock is divided by APB0 and APB1 divisors for
> +     * peripherals. Emcraft's SoM kit comes with these settings by default.
> +     */
> +    qdev_prop_set_uint32(dev, "m3clk", 142 * 1000000);
> +    qdev_prop_set_uint32(dev, "apb0div", 2);
> +    qdev_prop_set_uint32(dev, "apb1div", 2);
> +
> +    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
> +
> +    soc = MSF2_SOC(dev);
> +
> +    /* Attach SPI flash to SPI0 controller */
> +    spi_bus = (SSIBus *)qdev_get_child_bus(dev, "spi0");
> +    spi_flash = ssi_create_slave_no_init(spi_bus, "s25sl12801");
> +    qdev_prop_set_uint8(spi_flash, "spansion-cr2nv", 1);
> +    if (dinfo) {
> +        qdev_prop_set_drive(spi_flash, "drive", blk_by_legacy_dinfo(dinfo),
> +                                    &error_fatal);
> +    }
> +    qdev_init_nofail(spi_flash);
> +    cs_line = qdev_get_gpio_in_named(spi_flash, SSI_GPIO_CS, 0);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&soc->spi[0]), 1, cs_line);
> +
> +    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> +                       soc->envm_size);
> +}
> +
> +static void emcraft_sf2_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "SmartFusion2 SOM kit from Emcraft";

     mc->desc = "SmartFusion2 SOM kit from Emcraft (M2S010)";

> +    mc->init = emcraft_sf2_init;

     mc->init = emcraft_sf2_s2s010_init;

> +}
> +
> +DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)

Good work :)

With the changes:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
