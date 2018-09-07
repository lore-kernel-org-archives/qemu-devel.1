Received: from eggs.gnu.org ([2001:4830:134:3::10]:52257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyPwP-0004XH-7Y
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyPwN-00065a-SS
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:13:29 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180831103816.13479-1-clg@kaod.org>
	<20180831103816.13479-4-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <12321eb0-2e27-2f3a-4533-a90c3e27fcc0@amsat.org>
Date: Fri, 7 Sep 2018 20:13:01 -0300
MIME-Version: 1.0
In-Reply-To: <20180831103816.13479-4-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 03/11] hw/arm/aspeed: Add an
 Aspeed machine class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>

On 8/31/18 7:38 AM, Cédric Le Goater wrote:
> The code looks better, it removes duplicated lines and it will ease
> the introduction of common properties for the Aspeed machines.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Nice cleanup :)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/arm/aspeed.h |  46 +++++++++
>  hw/arm/aspeed.c         | 212 +++++++++++++---------------------------
>  2 files changed, 116 insertions(+), 142 deletions(-)
>  create mode 100644 include/hw/arm/aspeed.h
> 
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> new file mode 100644
> index 000000000000..2b77f8d2b3c8
> --- /dev/null
> +++ b/include/hw/arm/aspeed.h
> @@ -0,0 +1,46 @@
> +/*
> + * Aspeed Machines
> + *
> + * Copyright 2018 IBM Corp.
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +#ifndef _ARM_ASPEED_H
> +#define _ARM_ASPEED_H
> +
> +#include "hw/boards.h"
> +
> +typedef struct AspeedBoardState AspeedBoardState;
> +
> +typedef struct AspeedBoardConfig {
> +    const char *name;
> +    const char *desc;
> +    const char *soc_name;
> +    uint32_t hw_strap1;
> +    const char *fmc_model;
> +    const char *spi_model;
> +    uint32_t num_cs;
> +    void (*i2c_init)(AspeedBoardState *bmc);
> +} AspeedBoardConfig;
> +
> +#define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
> +#define ASPEED_MACHINE(obj) \
> +    OBJECT_CHECK(AspeedMachine, (obj), TYPE_ASPEED_MACHINE)
> +
> +typedef struct AspeedMachine {
> +    MachineState parent_obj;
> +} AspeedMachine;
> +
> +#define ASPEED_MACHINE_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(AspeedMachineClass, (klass), TYPE_ASPEED_MACHINE)
> +#define ASPEED_MACHINE_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(AspeedMachineClass, (obj), TYPE_ASPEED_MACHINE)
> +
> +typedef struct AspeedMachineClass {
> +    MachineClass parent_obj;
> +    const AspeedBoardConfig *board;
> +} AspeedMachineClass;
> +
> +
> +#endif
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index f2d64e45511a..6b33ecd5aa43 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -15,6 +15,7 @@
>  #include "cpu.h"
>  #include "exec/address-spaces.h"
>  #include "hw/arm/arm.h"
> +#include "hw/arm/aspeed.h"
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/boards.h"
>  #include "hw/i2c/smbus.h"
> @@ -34,22 +35,6 @@ typedef struct AspeedBoardState {
>      MemoryRegion max_ram;
>  } AspeedBoardState;
>  
> -typedef struct AspeedBoardConfig {
> -    const char *soc_name;
> -    uint32_t hw_strap1;
> -    const char *fmc_model;
> -    const char *spi_model;
> -    uint32_t num_cs;
> -    void (*i2c_init)(AspeedBoardState *bmc);
> -} AspeedBoardConfig;
> -
> -enum {
> -    PALMETTO_BMC,
> -    AST2500_EVB,
> -    ROMULUS_BMC,
> -    WITHERSPOON_BMC,
> -};
> -
>  /* Palmetto hardware value: 0x120CE416 */
>  #define PALMETTO_BMC_HW_STRAP1 (                                        \
>          SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_256MB) |               \
> @@ -88,46 +73,6 @@ enum {
>  /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
>  #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
>  
> -static void palmetto_bmc_i2c_init(AspeedBoardState *bmc);
> -static void ast2500_evb_i2c_init(AspeedBoardState *bmc);
> -static void romulus_bmc_i2c_init(AspeedBoardState *bmc);
> -static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc);
> -
> -static const AspeedBoardConfig aspeed_boards[] = {
> -    [PALMETTO_BMC] = {
> -        .soc_name  = "ast2400-a1",
> -        .hw_strap1 = PALMETTO_BMC_HW_STRAP1,
> -        .fmc_model = "n25q256a",
> -        .spi_model = "mx25l25635e",
> -        .num_cs    = 1,
> -        .i2c_init  = palmetto_bmc_i2c_init,
> -    },
> -    [AST2500_EVB]  = {
> -        .soc_name  = "ast2500-a1",
> -        .hw_strap1 = AST2500_EVB_HW_STRAP1,
> -        .fmc_model = "w25q256",
> -        .spi_model = "mx25l25635e",
> -        .num_cs    = 1,
> -        .i2c_init  = ast2500_evb_i2c_init,
> -    },
> -    [ROMULUS_BMC]  = {
> -        .soc_name  = "ast2500-a1",
> -        .hw_strap1 = ROMULUS_BMC_HW_STRAP1,
> -        .fmc_model = "n25q256a",
> -        .spi_model = "mx66l1g45g",
> -        .num_cs    = 2,
> -        .i2c_init  = romulus_bmc_i2c_init,
> -    },
> -    [WITHERSPOON_BMC]  = {
> -        .soc_name  = "ast2500-a1",
> -        .hw_strap1 = WITHERSPOON_BMC_HW_STRAP1,
> -        .fmc_model = "mx25l25635e",
> -        .spi_model = "mx66l1g45g",
> -        .num_cs    = 2,
> -        .i2c_init  = witherspoon_bmc_i2c_init,
> -    },
> -};
> -
>  /*
>   * The max ram region is for firmwares that scan the address space
>   * with load/store to guess how much RAM the SoC has.
> @@ -313,30 +258,6 @@ static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
>      object_property_set_int(OBJECT(dev), 110000, "temperature3", &error_abort);
>  }
>  
> -static void palmetto_bmc_init(MachineState *machine)
> -{
> -    aspeed_board_init(machine, &aspeed_boards[PALMETTO_BMC]);
> -}
> -
> -static void palmetto_bmc_class_init(ObjectClass *oc, void *data)
> -{
> -    MachineClass *mc = MACHINE_CLASS(oc);
> -
> -    mc->desc = "OpenPOWER Palmetto BMC (ARM926EJ-S)";
> -    mc->init = palmetto_bmc_init;
> -    mc->max_cpus = 1;
> -    mc->no_sdcard = 1;
> -    mc->no_floppy = 1;
> -    mc->no_cdrom = 1;
> -    mc->no_parallel = 1;
> -}
> -
> -static const TypeInfo palmetto_bmc_type = {
> -    .name = MACHINE_TYPE_NAME("palmetto-bmc"),
> -    .parent = TYPE_MACHINE,
> -    .class_init = palmetto_bmc_class_init,
> -};
> -
>  static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
>  {
>      AspeedSoCState *soc = &bmc->soc;
> @@ -353,30 +274,6 @@ static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
>  }
>  
> -static void ast2500_evb_init(MachineState *machine)
> -{
> -    aspeed_board_init(machine, &aspeed_boards[AST2500_EVB]);
> -}
> -
> -static void ast2500_evb_class_init(ObjectClass *oc, void *data)
> -{
> -    MachineClass *mc = MACHINE_CLASS(oc);
> -
> -    mc->desc = "Aspeed AST2500 EVB (ARM1176)";
> -    mc->init = ast2500_evb_init;
> -    mc->max_cpus = 1;
> -    mc->no_sdcard = 1;
> -    mc->no_floppy = 1;
> -    mc->no_cdrom = 1;
> -    mc->no_parallel = 1;
> -}
> -
> -static const TypeInfo ast2500_evb_type = {
> -    .name = MACHINE_TYPE_NAME("ast2500-evb"),
> -    .parent = TYPE_MACHINE,
> -    .class_init = ast2500_evb_class_init,
> -};
> -
>  static void romulus_bmc_i2c_init(AspeedBoardState *bmc)
>  {
>      AspeedSoCState *soc = &bmc->soc;
> @@ -386,30 +283,6 @@ static void romulus_bmc_i2c_init(AspeedBoardState *bmc)
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
>  }
>  
> -static void romulus_bmc_init(MachineState *machine)
> -{
> -    aspeed_board_init(machine, &aspeed_boards[ROMULUS_BMC]);
> -}
> -
> -static void romulus_bmc_class_init(ObjectClass *oc, void *data)
> -{
> -    MachineClass *mc = MACHINE_CLASS(oc);
> -
> -    mc->desc = "OpenPOWER Romulus BMC (ARM1176)";
> -    mc->init = romulus_bmc_init;
> -    mc->max_cpus = 1;
> -    mc->no_sdcard = 1;
> -    mc->no_floppy = 1;
> -    mc->no_cdrom = 1;
> -    mc->no_parallel = 1;
> -}
> -
> -static const TypeInfo romulus_bmc_type = {
> -    .name = MACHINE_TYPE_NAME("romulus-bmc"),
> -    .parent = TYPE_MACHINE,
> -    .class_init = romulus_bmc_class_init,
> -};
> -
>  static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
>  {
>      AspeedSoCState *soc = &bmc->soc;
> @@ -433,36 +306,91 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
>                       0x60);
>  }
>  
> -static void witherspoon_bmc_init(MachineState *machine)
> +static void aspeed_machine_init(MachineState *machine)
>  {
> -    aspeed_board_init(machine, &aspeed_boards[WITHERSPOON_BMC]);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(machine);
> +
> +    aspeed_board_init(machine, amc->board);
>  }
>  
> -static void witherspoon_bmc_class_init(ObjectClass *oc, void *data)
> +static void aspeed_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +    const AspeedBoardConfig *board = data;
>  
> -    mc->desc = "OpenPOWER Witherspoon BMC (ARM1176)";
> -    mc->init = witherspoon_bmc_init;
> +    mc->desc = board->desc;
> +    mc->init = aspeed_machine_init;
>      mc->max_cpus = 1;
>      mc->no_sdcard = 1;
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
>      mc->no_parallel = 1;
> +    amc->board = board;
>  }
>  
> -static const TypeInfo witherspoon_bmc_type = {
> -    .name = MACHINE_TYPE_NAME("witherspoon-bmc"),
> +static const TypeInfo aspeed_machine_type = {
> +    .name = TYPE_ASPEED_MACHINE,
>      .parent = TYPE_MACHINE,
> -    .class_init = witherspoon_bmc_class_init,
> +    .instance_size = sizeof(AspeedMachine),
> +    .class_size = sizeof(AspeedMachineClass),
> +    .abstract = true,
> +};
> +
> +static const AspeedBoardConfig aspeed_boards[] = {
> +    {
> +        .name      = MACHINE_TYPE_NAME("palmetto-bmc"),
> +        .desc      = "OpenPOWER Palmetto BMC (ARM926EJ-S)",
> +        .soc_name  = "ast2400-a1",
> +        .hw_strap1 = PALMETTO_BMC_HW_STRAP1,
> +        .fmc_model = "n25q256a",
> +        .spi_model = "mx25l25635e",
> +        .num_cs    = 1,
> +        .i2c_init  = palmetto_bmc_i2c_init,
> +    }, {
> +        .name      = MACHINE_TYPE_NAME("ast2500-evb"),
> +        .desc      = "Aspeed AST2500 EVB (ARM1176)",
> +        .soc_name  = "ast2500-a1",
> +        .hw_strap1 = AST2500_EVB_HW_STRAP1,
> +        .fmc_model = "w25q256",
> +        .spi_model = "mx25l25635e",
> +        .num_cs    = 1,
> +        .i2c_init  = ast2500_evb_i2c_init,
> +    }, {
> +        .name      = MACHINE_TYPE_NAME("romulus-bmc"),
> +        .desc      = "OpenPOWER Romulus BMC (ARM1176)",
> +        .soc_name  = "ast2500-a1",
> +        .hw_strap1 = ROMULUS_BMC_HW_STRAP1,
> +        .fmc_model = "n25q256a",
> +        .spi_model = "mx66l1g45g",
> +        .num_cs    = 2,
> +        .i2c_init  = romulus_bmc_i2c_init,
> +    }, {
> +        .name      = MACHINE_TYPE_NAME("witherspoon-bmc"),
> +        .desc      = "OpenPOWER Witherspoon BMC (ARM1176)",
> +        .soc_name  = "ast2500-a1",
> +        .hw_strap1 = WITHERSPOON_BMC_HW_STRAP1,
> +        .fmc_model = "mx25l25635e",
> +        .spi_model = "mx66l1g45g",
> +        .num_cs    = 2,
> +        .i2c_init  = witherspoon_bmc_i2c_init,
> +    },
>  };
>  
> -static void aspeed_machine_init(void)
> +static void aspeed_machine_types(void)
>  {
> -    type_register_static(&palmetto_bmc_type);
> -    type_register_static(&ast2500_evb_type);
> -    type_register_static(&romulus_bmc_type);
> -    type_register_static(&witherspoon_bmc_type);
> +    int i;
> +
> +    type_register_static(&aspeed_machine_type);
> +    for (i = 0; i < ARRAY_SIZE(aspeed_boards); ++i) {
> +        TypeInfo ti = {
> +            .name       = aspeed_boards[i].name,
> +            .parent     = TYPE_ASPEED_MACHINE,
> +            .class_init = aspeed_machine_class_init,
> +            .class_data = (void *)&aspeed_boards[i],
> +        };
> +        type_register(&ti);
> +    }
>  }
>  
> -type_init(aspeed_machine_init)
> +type_init(aspeed_machine_types)
> 
