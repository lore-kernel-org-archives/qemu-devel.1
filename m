Received: from eggs.gnu.org ([2001:4830:134:3::10]:41164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dUwEr-0002TJ-4s
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dUwEk-0004TH-3e
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:34:09 -0400
MIME-Version: 1.0
In-Reply-To: <1499771839-32518-2-git-send-email-peter.maydell@linaro.org>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<1499771839-32518-2-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Jul 2017 16:33:19 +0200
Message-ID: <CAKmqyKMO4GQB1Cgy5rZw8pJawO_kWFZ7PiLGzWPch5CqkOKp=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/7] hw/arm/mps2: Implement skeleton
 mps2-an385 and mps2-an511 board models
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
> Model the ARM MPS2/MPS2+ FPGA based development board.
>
> The MPS2 and MPS2+ dev boards are FPGA based (the 2+ has a bigger
> FPGA but is otherwise the same as the 2). Since the CPU itself
> and most of the devices are in the FPGA, the details of the board
> as seen by the guest depend significantly on the FPGA image.
>
> We model the following FPGA images:
>  "mps2_an385" -- Cortex-M3 as documented in ARM Application Note AN385
>  "mps2_an511" -- Cortex-M3 'DesignStart' as documented in AN511
>
> They are fairly similar but differ in the details for some
> peripherals.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/Makefile.objs            |   1 +
>  hw/arm/mps2.c                   | 273 ++++++++++++++++++++++++++++++++++++++++
>  default-configs/arm-softmmu.mak |   1 +
>  3 files changed, 275 insertions(+)
>  create mode 100644 hw/arm/mps2.c
>
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 4c5c4ee..a2e56ec 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -18,3 +18,4 @@ obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
>  obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
>  obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
>  obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
> +obj-$(CONFIG_MPS2) += mps2.o

Is this file name possibly too generic? Should it be arm-mps2 instead.

I don't see any other boards with the same name from a Google search,
but it just seems a bit vague having a three letter acronym.

> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
> new file mode 100644
> index 0000000..28838bc
> --- /dev/null
> +++ b/hw/arm/mps2.c
> @@ -0,0 +1,273 @@
> +/*
> + * ARM V2M MPS2 board emulation.
> + *
> + * Copyright (c) 2017 Linaro Limited
> + * Written by Peter Maydell
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 or
> + *  (at your option) any later version.
> + */
> +
> +/* The MPS2 and MPS2+ dev boards are FPGA based (the 2+ has a bigger
> + * FPGA but is otherwise the same as the 2). Since the CPU itself
> + * and most of the devices are in the FPGA, the details of the board
> + * as seen by the guest depend significantly on the FPGA image.
> + * We model the following FPGA images:
> + *  "mps2_an385" -- Cortex-M3 as documented in ARM Application Note AN385
> + *  "mps2_an511" -- Cortex-M3 'DesignStart' as documented in AN511
> + *
> + * Links to the TRM for the board itself and to the various Application
> + * Notes which document the FPGA images can be found here:
> + *   https://developer.arm.com/products/system-design/development-boards/cortex-m-prototyping-system
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "hw/arm/arm.h"
> +#include "hw/arm/armv7m.h"
> +#include "hw/boards.h"
> +#include "exec/address-spaces.h"
> +#include "hw/misc/unimp.h"
> +
> +typedef enum MPS2FPGAType {
> +    FPGA_AN385,
> +    FPGA_AN511,
> +} MPS2FPGAType;
> +
> +typedef struct {
> +    MachineClass parent;
> +    MPS2FPGAType fpga_type;
> +    const char *cpu_model;
> +} MPS2MachineClass;
> +
> +typedef struct {
> +    MachineState parent;
> +
> +    ARMv7MState armv7m;
> +    MemoryRegion psram;
> +    MemoryRegion ssram1;
> +    MemoryRegion ssram1_m;
> +    MemoryRegion ssram23;
> +    MemoryRegion ssram23_m;
> +    MemoryRegion blockram;
> +    MemoryRegion blockram_m1;
> +    MemoryRegion blockram_m2;
> +    MemoryRegion blockram_m3;
> +    MemoryRegion sram;
> +} MPS2MachineState;
> +
> +#define TYPE_MPS2_MACHINE "mps2"

This public name seems too common as well. I am just worried it'll
conflict with something one day.

> +#define TYPE_MPS2_AN385_MACHINE MACHINE_TYPE_NAME("mps2-an385")
> +#define TYPE_MPS2_AN511_MACHINE MACHINE_TYPE_NAME("mps2-an511")
> +
> +#define MPS2_MACHINE(obj)                                       \
> +    OBJECT_CHECK(MPS2MachineState, obj, TYPE_MPS2_MACHINE)
> +#define MPS2_MACHINE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(MPS2MachineClass, obj, TYPE_MPS2_MACHINE)
> +#define MPS2_MACHINE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(MPS2MachineClass, klass, TYPE_MPS2_MACHINE)
> +
> +/* Main SYSCLK frequency in Hz */
> +#define SYSCLK_FRQ 25000000
> +
> +/* Initialize the auxiliary RAM region @mr and map it into
> + * the memory map at @base.
> + */
> +static void make_ram(MemoryRegion *mr, const char *name,
> +                     hwaddr base, hwaddr size)
> +{
> +    memory_region_init_ram(mr, NULL, name, size, &error_fatal);
> +    vmstate_register_ram_global(mr);
> +    memory_region_add_subregion(get_system_memory(), base, mr);
> +}
> +
> +/* Create an alias of an entire original MemoryRegion @orig
> + * located at @base in the memory map.
> + */
> +static void make_ram_alias(MemoryRegion *mr, const char *name,
> +                           MemoryRegion *orig, hwaddr base)
> +{
> +    memory_region_init_alias(mr, NULL, name, orig, 0,
> +                             memory_region_size(orig));
> +    memory_region_add_subregion(get_system_memory(), base, mr);
> +}
> +
> +static void mps2_common_init(MachineState *machine)
> +{
> +    MPS2MachineState *mms = MPS2_MACHINE(machine);
> +    MPS2MachineClass *mmc = MPS2_MACHINE_GET_CLASS(machine);
> +
> +    if (!machine->cpu_model) {
> +        machine->cpu_model = mmc->cpu_model;
> +    }
> +
> +    if (strcmp(machine->cpu_model, mmc->cpu_model) != 0) {
> +        error_report("This board can only be used with CPU %s", mmc->cpu_model);
> +        exit(1);
> +    }
> +
> +    MemoryRegion *system_memory = get_system_memory();
> +
> +    DeviceState *armv7m;

These should be at the top of the function.

> +
> +    /* The FPGA images have an odd combination of different RAMs,
> +     * because in hardware they are different implementations and
> +     * connected to different buses, giving varying performance/size
> +     * tradeoffs. For QEMU they're all just RAM, though. We arbitrarily
> +     * call the 16MB our "system memory", as it's the largest lump.
> +     *
> +     * Common to both boards:
> +     *  0x21000000..0x21ffffff : PSRAM (16MB)
> +     * AN385 only:
> +     *  0x00000000 .. 0x003fffff : ZBT SSRAM1
> +     *  0x00400000 .. 0x007fffff : mirror of ZBT SSRAM1
> +     *  0x20000000 .. 0x203fffff : ZBT SSRAM 2&3
> +     *  0x20400000 .. 0x207fffff : mirror of ZBT SSRAM 2&3
> +     *  0x01000000 .. 0x01003fff : block RAM (16K)
> +     *  0x01004000 .. 0x01007fff : mirror of above
> +     *  0x01008000 .. 0x0100bfff : mirror of above
> +     *  0x0100c000 .. 0x0100ffff : mirror of above
> +     * AN511 only:
> +     *  0x00000000 .. 0x0003ffff : FPGA block RAM
> +     *  0x00400000 .. 0x007fffff : ZBT SSRAM1
> +     *  0x20000000 .. 0x2001ffff : SRAM
> +     *  0x20400000 .. 0x207fffff : ZBT SSRAM 2&3
> +     *
> +     * The AN385 has a feature where the lowest 16K can be mapped
> +     * either to the bottom of the ZBT SSRAM1 or to the block RAM.
> +     * This is of no use for QEMU so we don't implement it (as if
> +     * zbt_boot_ctrl is always zero).
> +     */
> +    memory_region_allocate_system_memory(&mms->psram,
> +                                         NULL, "mps.ram", 0x1000000);
> +    memory_region_add_subregion(system_memory, 0x21000000, &mms->psram);
> +
> +    switch (mmc->fpga_type) {
> +    case FPGA_AN385:
> +        make_ram(&mms->ssram1, "mps.ssram1", 0x0, 0x400000);
> +        make_ram_alias(&mms->ssram1_m, "mps.ssram1_m", &mms->ssram1, 0x400000);
> +        make_ram(&mms->ssram23, "mps.ssram23", 0x20000000, 0x400000);
> +        make_ram_alias(&mms->ssram23_m, "mps.ssram23_m",
> +                       &mms->ssram23, 0x20400000);
> +        make_ram(&mms->blockram, "mps.blockram", 0x01000000, 0x4000);
> +        make_ram_alias(&mms->blockram_m1, "mps.blockram_m1",
> +                       &mms->blockram, 0x01004000);
> +        make_ram_alias(&mms->blockram_m2, "mps.blockram_m2",
> +                       &mms->blockram, 0x01008000);
> +        make_ram_alias(&mms->blockram_m3, "mps.blockram_m3",
> +                       &mms->blockram, 0x0100c000);
> +        break;
> +    case FPGA_AN511:
> +        make_ram(&mms->blockram, "mps.blockram", 0x0, 0x40000);
> +        make_ram(&mms->ssram1, "mps.ssram1", 0x00400000, 0x00800000);
> +        make_ram(&mms->sram, "mps.sram", 0x20000000, 0x20000);
> +        make_ram(&mms->ssram23, "mps.ssram23", 0x20400000, 0x400000);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    object_initialize(&mms->armv7m, sizeof(mms->armv7m), TYPE_ARMV7M);
> +    armv7m = DEVICE(&mms->armv7m);
> +    qdev_set_parent_bus(armv7m, sysbus_get_default());
> +    switch (mmc->fpga_type) {
> +    case FPGA_AN385:
> +        qdev_prop_set_uint32(armv7m, "num-irq", 32);
> +        break;
> +    case FPGA_AN511:
> +        qdev_prop_set_uint32(armv7m, "num-irq", 64);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    qdev_prop_set_string(armv7m, "cpu-model", machine->cpu_model);
> +    object_property_set_link(OBJECT(&mms->armv7m), OBJECT(system_memory),
> +                             "memory", &error_abort);
> +    object_property_set_bool(OBJECT(&mms->armv7m), true, "realized",
> +                             &error_fatal);
> +
> +    create_unimplemented_device("zbtsmram mirror", 0x00400000, 0x00400000);
> +    create_unimplemented_device("RESERVED 1", 0x00800000, 0x00800000);
> +    create_unimplemented_device("Block RAM", 0x01000000, 0x00010000);
> +    create_unimplemented_device("RESERVED 2", 0x01010000, 0x1EFF0000);
> +    create_unimplemented_device("RESERVED 3", 0x20800000, 0x00800000);
> +    create_unimplemented_device("PSRAM", 0x21000000, 0x01000000);
> +    /* These three ranges all cover multiple devices; we may implement
> +     * some of them below (in which case the real device takes precedence
> +     * over the unimplemented-region mapping).
> +     */
> +    create_unimplemented_device("CMSDK APB peripheral region @0x40000000",
> +                                0x40000000, 0x00010000);
> +    create_unimplemented_device("CMSDK peripheral region @0x40010000",
> +                                0x40010000, 0x00010000);
> +    create_unimplemented_device("Extra peripheral region @0x40020000",
> +                                0x40020000, 0x00010000);
> +    create_unimplemented_device("RESERVED 4", 0x40030000, 0x001D0000);
> +    create_unimplemented_device("Ethernet", 0x40200000, 0x00100000);
> +    create_unimplemented_device("VGA", 0x41000000, 0x0200000);

I did not know this was an option, this is pretty cool.

Besides the name I think this patch looks good.

Thanks,
Alistair
