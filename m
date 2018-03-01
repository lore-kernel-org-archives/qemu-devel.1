Received: from eggs.gnu.org ([2001:4830:134:3::10]:41613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1erS7S-0006zY-6J
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1erS7N-0002I6-8Q
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:35:50 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1516650109.git.alistair.francis@xilinx.com>
	<3a974495bbab40c66cf3f1edc9fbfcee31f3a178.1516650109.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <44924025-264f-c7a4-c1ce-7c6f0cdd9bb0@amsat.org>
Date: Thu, 1 Mar 2018 14:35:35 -0300
MIME-Version: 1.0
In-Reply-To: <3a974495bbab40c66cf3f1edc9fbfcee31f3a178.1516650109.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 3/9] xlnx-zynqmp-pmu: Add the CPU and
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair23@gmail.com, qemu-arm@nongnu.org

Hi Alistair, Edgar,

On 01/22/2018 04:43 PM, Alistair Francis wrote:
> Connect the MicroBlaze CPU and the ROM and RAM memory regions.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
> 
> V6:
>  - Pass initrd instead of kernel to microblaze_load_kernel()
> V4:
>  - Remove the ZCU102 name
> V2:
>  - Fix the pmu-cpu name
>  - Use err and errp for CPU realise instead of error_fatal
> 
>  hw/microblaze/xlnx-zynqmp-pmu.c | 70 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 68 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index ac0f78928a..145837b372 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -18,8 +18,11 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
> +#include "exec/address-spaces.h"
>  #include "hw/boards.h"
> +#include "hw/qdev-properties.h"
>  #include "cpu.h"
> +#include "boot.h"
>  
>  /* Define the PMU device */
>  
> @@ -27,21 +30,56 @@
>  #define XLNX_ZYNQMP_PMU_SOC(obj) OBJECT_CHECK(XlnxZynqMPPMUSoCState, (obj), \
>                                                TYPE_XLNX_ZYNQMP_PMU_SOC)
>  
> +#define XLNX_ZYNQMP_PMU_ROM_SIZE    0x8000
> +#define XLNX_ZYNQMP_PMU_ROM_ADDR    0xFFD00000
> +#define XLNX_ZYNQMP_PMU_RAM_ADDR    0xFFDC0000
> +
>  typedef struct XlnxZynqMPPMUSoCState {
>      /*< private >*/
>      DeviceState parent_obj;
>  
>      /*< public >*/
> +    MicroBlazeCPU cpu;
>  }  XlnxZynqMPPMUSoCState;
>  
>  static void xlnx_zynqmp_pmu_soc_init(Object *obj)
>  {
> +    XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(obj);
>  
> +    object_initialize(&s->cpu, sizeof(s->cpu),
> +                      TYPE_MICROBLAZE_CPU);
> +    object_property_add_child(obj, "pmu-cpu", OBJECT(&s->cpu),
> +                              &error_abort);
>  }
>  
>  static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
>  {
> -
> +    XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(dev);
> +    Error *err = NULL;
> +
> +    object_property_set_uint(OBJECT(&s->cpu), XLNX_ZYNQMP_PMU_ROM_ADDR,
> +                             "base-vectors", &error_abort);
> +    object_property_set_bool(OBJECT(&s->cpu), true, "use-stack-protection",
> +                             &error_abort);
> +    object_property_set_uint(OBJECT(&s->cpu), 0, "use-fpu", &error_abort);
> +    object_property_set_uint(OBJECT(&s->cpu), 0, "use-hw-mul", &error_abort);
> +    object_property_set_bool(OBJECT(&s->cpu), true, "use-barrel",
> +                             &error_abort);
> +    object_property_set_bool(OBJECT(&s->cpu), true, "use-msr-instr",
> +                             &error_abort);
> +    object_property_set_bool(OBJECT(&s->cpu), true, "use-pcmp-instr",
> +                             &error_abort);
> +    object_property_set_bool(OBJECT(&s->cpu), false, "use-mmu", &error_abort);
> +    object_property_set_bool(OBJECT(&s->cpu), true, "endianness",
> +                             &error_abort);
> +    object_property_set_str(OBJECT(&s->cpu), "8.40.b", "version",
> +                            &error_abort);
> +    object_property_set_uint(OBJECT(&s->cpu), 0, "pvr", &error_abort);
> +    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>  }
>  
>  static void xlnx_zynqmp_pmu_soc_class_init(ObjectClass *oc, void *data)
> @@ -70,7 +108,35 @@ type_init(xlnx_zynqmp_pmu_soc_register_types)
>  
>  static void xlnx_zynqmp_pmu_init(MachineState *machine)
>  {
> -
> +    XlnxZynqMPPMUSoCState *pmu = g_new0(XlnxZynqMPPMUSoCState, 1);
> +    MemoryRegion *address_space_mem = get_system_memory();
> +    MemoryRegion *pmu_rom = g_new(MemoryRegion, 1);
> +    MemoryRegion *pmu_ram = g_new(MemoryRegion, 1);
> +
> +    /* Create the ROM */
> +    memory_region_init_rom(pmu_rom, NULL, "xlnx-zynqmp-pmu.rom",
> +                           XLNX_ZYNQMP_PMU_ROM_SIZE, &error_fatal);
> +    memory_region_add_subregion(address_space_mem, XLNX_ZYNQMP_PMU_ROM_ADDR,
> +                                pmu_rom);
> +
> +    /* Create the RAM */

A bit late, but we maybe want a check such:

       if (machine->ram_size > 128 * K_BYTE) {
           warn_report("shrinking RAM to 128kB");
           machine->ram_size = 128 * K_BYTE;
       }

> +    memory_region_init_ram(pmu_ram, NULL, "xlnx-zynqmp-pmu.ram",
> +                           machine->ram_size, &error_fatal);
> +    memory_region_add_subregion(address_space_mem, XLNX_ZYNQMP_PMU_RAM_ADDR,
> +                                pmu_ram);
> +
> +    /* Create the PMU device */
> +    object_initialize(pmu, sizeof(XlnxZynqMPPMUSoCState), TYPE_XLNX_ZYNQMP_PMU_SOC);
> +    object_property_add_child(OBJECT(machine), "pmu", OBJECT(pmu),
> +                              &error_abort);
> +    object_property_set_bool(OBJECT(pmu), true, "realized", &error_fatal);
> +
> +    /* Load the kernel */
> +    microblaze_load_kernel(&pmu->cpu, XLNX_ZYNQMP_PMU_RAM_ADDR,
> +                           machine->ram_size,
> +                           machine->initrd_filename,
> +                           machine->dtb,
> +                           NULL);
>  }
>  
>  static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
> 

and here:

       mc->default_ram_size = 128 * K_BYTE,

Regards,

Phil.
