Received: from eggs.gnu.org ([2001:4830:134:3::10]:40453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dI8xY-00066q-K4
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dI8xW-0000Mo-LB
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:31:24 -0400
MIME-Version: 1.0
In-Reply-To: <6c077dcf-e8a8-aae9-9023-f197007a98dc@amsat.org>
References: <1494949133-2202-1-git-send-email-sundeep.lkml@gmail.com>
	<1494949133-2202-6-git-send-email-sundeep.lkml@gmail.com>
	<6c077dcf-e8a8-aae9-9023-f197007a98dc@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Tue, 6 Jun 2017 13:01:19 +0530
Message-ID: <CALHRZuqu-oP46EF7Y8AAtAr_orJaGNDZzba9NS833DNJQ-KVQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel v5 PATCH 5/5] msf2: Add Emcraft's
 Smartfusion2 SOM kit.
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

On Wed, May 31, 2017 at 11:34 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org>
wrote:

> Hi Subbaraya,
>
>
> On 05/16/2017 12:38 PM, Subbaraya Sundeep wrote:
>
>> Emulated Emcraft's Smartfusion2 System On Module starter
>> kit.
>>
>> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> ---
>>  hw/arm/Makefile.objs |  1 +
>>  hw/arm/msf2-som.c    | 89 ++++++++++++++++++++++++++++++
>> ++++++++++++++++++++++
>>  2 files changed, 90 insertions(+)
>>  create mode 100644 hw/arm/msf2-som.c
>>
>> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
>> index c828061..4b02093 100644
>> --- a/hw/arm/Makefile.objs
>> +++ b/hw/arm/Makefile.objs
>> @@ -5,6 +5,7 @@ obj-y +=3D omap_sx1.o palm.o realview.o spitz.o stellari=
s.o
>>  obj-y +=3D tosa.o versatilepb.o vexpress.o virt.o xilinx_zynq.o z2.o
>>  obj-$(CONFIG_ACPI) +=3D virt-acpi-build.o
>>  obj-y +=3D netduino2.o
>> +obj-y +=3D msf2-som.o
>>  obj-y +=3D sysbus-fdt.o
>>
>>  obj-y +=3D armv7m.o exynos4210.o pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
>> diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
>> new file mode 100644
>> index 0000000..cd2b759
>> --- /dev/null
>> +++ b/hw/arm/msf2-som.c
>> @@ -0,0 +1,89 @@
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
>> +#include "hw/arm/msf2-soc.h"
>> +#include "hw/arm/arm.h"
>> +#include "exec/address-spaces.h"
>> +
>> +#define DDR_BASE_ADDRESS      0xA0000000
>> +#define DDR_SIZE              (64 * M_BYTE)
>> +
>> +static void emcraft_sf2_init(MachineState *machine)
>> +{
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
>> +    vmstate_register_ram_global(ddr);
>> +    memory_region_add_subregion(sysmem, DDR_BASE_ADDRESS, ddr);
>> +
>> +    dev =3D qdev_create(NULL, TYPE_MSF2_SOC);
>> +    qdev_prop_set_string(dev, "part-name", "M2S010");
>> +    qdev_prop_set_uint64(dev, "eNVM-size", M2S010_ENVM_SIZE);
>> +    qdev_prop_set_uint64(dev, "eSRAM-size", M2S010_ESRAM_SIZE);
>> +
>> +    /*
>> +     * pclk0 and pclk1 are configurable in Libero.
>> +     * Emcraft's SoM kit comes with these settings by default.
>> +     */
>> +    qdev_prop_set_uint32(dev, "pclk0", 71 * 1000000);
>> +    qdev_prop_set_uint32(dev, "pclk1", 71 * 1000000);
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
>> +    mc->init =3D emcraft_sf2_init;
>> +}
>> +
>> +DEFINE_MACHINE("smartfusion2-som", emcraft_sf2_machine_init)
>>
>
> Here I still disagree with the machine name, what do you think about
> "emcraft-sf2" or "emcraft-m2s[-fg484-som]" as described by Emcraft in the=
ir
> website (but shorter is easier to type)?
>

I missed this. I will use emcraft-sf2 for machine name.

Thanks,
Sundeep
