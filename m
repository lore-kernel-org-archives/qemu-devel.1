Received: from eggs.gnu.org ([2001:4830:134:3::10]:42233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1ecCZc-0006at-B7
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1ecCZb-00066Y-5w
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:57:52 -0500
Date: Thu, 18 Jan 2018 22:57:28 +0700
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180118155728.GK5516@toto>
References: <cover.1516144891.git.alistair.francis@xilinx.com>
	<63f5e8b2687502e1d6c53e190869e88d134f5f14.1516144891.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63f5e8b2687502e1d6c53e190869e88d134f5f14.1516144891.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/9] xlnx-zynqmp-pmu: Add the CPU and
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, edgar.iglesias@gmail.com, alistair23@gmail.com, qemu-arm@nongnu.org

On Tue, Jan 16, 2018 at 03:22:26PM -0800, Alistair Francis wrote:
> Connect the MicroBlaze CPU and the ROM and RAM memory regions.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
> 
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
> index ac0f78928a..c6a0b3b8a1 100644
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
> +                           machine->kernel_filename,

Hi Alistair,

I think I forgot to mention this on the chat yesterday but I think
this argument is incorrect. It should be the initrd filename, or
NULL since it may not make sense to load an initrd for the PMU.
Can you fix that up?

You can keep my R-b tag.

Cheers,
Edgar


> +                           machine->dtb,
> +                           NULL);
>  }
>  
>  static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
> -- 
> 2.14.1
> 
