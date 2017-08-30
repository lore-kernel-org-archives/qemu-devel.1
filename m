Received: from eggs.gnu.org ([2001:4830:134:3::10]:36572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dn236-00009J-C5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dn234-0002lh-HZ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:24:48 -0400
MIME-Version: 1.0
In-Reply-To: <d57d4bab-51ec-901c-7474-20dc5156f795@amsat.org>
References: <1503938283-12404-1-git-send-email-sundeep.lkml@gmail.com>
	<1503938283-12404-6-git-send-email-sundeep.lkml@gmail.com>
	<d57d4bab-51ec-901c-7474-20dc5156f795@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Wed, 30 Aug 2017 17:54:45 +0530
Message-ID: <CALHRZupSDn-a4oHqcZCjppj8NX=sZJ6Uk+xXhLfSs_W3zbJCHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

Hi Philippe,

On Wed, Aug 30, 2017 at 7:18 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi Subbaraya,
>
>
> On 08/28/2017 01:38 PM, Subbaraya Sundeep wrote:
>
>> Emulated Emcraft's Smartfusion2 System On Module starter
>> kit.
>>
>> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> ---
>>   hw/arm/Makefile.objs |  2 +-
>>   hw/arm/msf2-som.c    | 94 ++++++++++++++++++++++++++++++
>> ++++++++++++++++++++++
>>   2 files changed, 95 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/arm/msf2-som.c
>>
>> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
>> index df36a03..e81a7dc 100644
>> --- a/hw/arm/Makefile.objs
>> +++ b/hw/arm/Makefile.objs
>> @@ -19,4 +19,4 @@ obj-$(CONFIG_FSL_IMX31) +=3D fsl-imx31.o kzm.o
>>   obj-$(CONFIG_FSL_IMX6) +=3D fsl-imx6.o sabrelite.o
>>   obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_soc.o aspeed.o
>>   obj-$(CONFIG_MPS2) +=3D mps2.o
>> -obj-$(CONFIG_MSF2) +=3D msf2-soc.o
>> +obj-$(CONFIG_MSF2) +=3D msf2-soc.o msf2-som.o
>> diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
>> new file mode 100644
>> index 0000000..fd89ba9
>> --- /dev/null
>> +++ b/hw/arm/msf2-som.c
>> @@ -0,0 +1,94 @@
>> +/*
>> + * SmartFusion2 SOM starter kit(from Emcraft) emulation.
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
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/boards.h"
>> +#include "hw/arm/arm.h"
>> +#include "exec/address-spaces.h"
>> +#include "qemu/cutils.h"
>> +#include "hw/arm/msf2-soc.h"
>> +
>> +#define DDR_BASE_ADDRESS      0xA0000000
>> +#define DDR_SIZE              (64 * M_BYTE)
>> +
>> +#define M2S010_ENVM_SIZE      (256 * K_BYTE)
>> +#define M2S010_ESRAM_SIZE     (64 * K_BYTE)
>> +
>> +static void emcraft_sf2_init(MachineState *machine)
>>
>
> Since Emcraft can produce an upgraded SF2 SoC based on a different MCU, I
> prefer you rename it:
>
> static void emcraft_sf2_s2s010_init(MachineState *machine)


Ok will change.

>
>
> +{
>> +    DeviceState *dev;
>> +    DeviceState *spi_flash;
>> +    MSF2State *soc;
>> +    DriveInfo *dinfo =3D drive_get_next(IF_MTD);
>> +    qemu_irq cs_line;
>> +    SSIBus *spi_bus;
>> +    MemoryRegion *sysmem =3D get_system_memory();
>> +    MemoryRegion *ddr =3D g_new(MemoryRegion, 1);
>> +
>> +    memory_region_init_ram(ddr, NULL, "ddr-ram", DDR_SIZE,
>> +                           &error_fatal);
>> +    memory_region_add_subregion(sysmem, DDR_BASE_ADDRESS, ddr);
>> +
>> +    dev =3D qdev_create(NULL, TYPE_MSF2_SOC);
>> +    qdev_prop_set_string(dev, "part-name", "M2S010");
>> +    qdev_prop_set_uint64(dev, "eNVM-size", M2S010_ENVM_SIZE);
>> +    qdev_prop_set_uint64(dev, "eSRAM-size", M2S010_ESRAM_SIZE);
>> +
>> +    /*
>> +     * CPU clock and peripheral clocks(APB0, APB1)are configurable
>> +     * in Libero. CPU clock is divided by APB0 and APB1 divisors for
>> +     * peripherals. Emcraft's SoM kit comes with these settings by
>> default.
>> +     */
>> +    qdev_prop_set_uint32(dev, "m3clk", 142 * 1000000);
>> +    qdev_prop_set_uint32(dev, "apb0div", 2);
>> +    qdev_prop_set_uint32(dev, "apb1div", 2);
>> +
>> +    object_property_set_bool(OBJECT(dev), true, "realized",
>> &error_fatal);
>> +
>> +    soc =3D MSF2_SOC(dev);
>> +
>> +    /* Attach SPI flash to SPI0 controller */
>> +    spi_bus =3D (SSIBus *)qdev_get_child_bus(dev, "spi0");
>> +    spi_flash =3D ssi_create_slave_no_init(spi_bus, "s25sl12801");
>> +    qdev_prop_set_uint8(spi_flash, "spansion-cr2nv", 1);
>> +    if (dinfo) {
>> +        qdev_prop_set_drive(spi_flash, "drive",
>> blk_by_legacy_dinfo(dinfo),
>> +                                    &error_fatal);
>> +    }
>> +    qdev_init_nofail(spi_flash);
>> +    cs_line =3D qdev_get_gpio_in_named(spi_flash, SSI_GPIO_CS, 0);
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(&soc->spi[0]), 1, cs_line);
>> +
>> +    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
>> +                       soc->envm_size);
>> +}
>> +
>> +static void emcraft_sf2_machine_init(MachineClass *mc)
>> +{
>> +    mc->desc =3D "SmartFusion2 SOM kit from Emcraft";
>>
>
>     mc->desc =3D "SmartFusion2 SOM kit from Emcraft (M2S010)";
>
> +    mc->init =3D emcraft_sf2_init;
>>
>
>     mc->init =3D emcraft_sf2_s2s010_init;
>
> +}
>> +
>> +DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
>>
>
> Good work :)
>
With the changes:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

Thank you :)
Sundeep
