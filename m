Received: from eggs.gnu.org ([2001:4830:134:3::10]:43122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72D5-0004kt-8d
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72D1-0002IE-6C
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:05:31 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170506152414.8704-1-krzk@kernel.org>
	<20170506152414.8704-2-krzk@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <05f9ba66-784d-0dee-fd0b-48f0f8f15d1d@amsat.org>
Date: Sat, 6 May 2017 13:05:19 -0300
MIME-Version: 1.0
In-Reply-To: <20170506152414.8704-2-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/3] hw/arm/exynos: Move RAM
 initialization next boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hi Krzysztof,

Please modify RAM -> DRAM in subject/description so there is no 
confusion about also moving the IRAM (which is SoC specific).

With this:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

On 05/06/2017 12:24 PM, Krzysztof Kozlowski wrote:
> Before QOM-ifying the Exynos4 SoC model, move the RAM initialization
> from exynos4210.c to exynos4_boards.c because RAM is board specific,
> not SoC.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  hw/arm/exynos4210.c         | 20 +-----------------
>  hw/arm/exynos4_boards.c     | 50 ++++++++++++++++++++++++++++++++++++++-------
>  include/hw/arm/exynos4210.h |  5 +----
>  3 files changed, 45 insertions(+), 30 deletions(-)
>
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index 960f27e45a36..0da877f8db0a 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -160,13 +160,11 @@ static uint64_t exynos4210_calc_affinity(int cpu)
>      return mp_affinity;
>  }
>
> -Exynos4210State *exynos4210_init(MemoryRegion *system_mem,
> -        unsigned long ram_size)
> +Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
>  {
>      int i, n;
>      Exynos4210State *s = g_new(Exynos4210State, 1);
>      qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
> -    unsigned long mem_size;
>      DeviceState *dev;
>      SysBusDevice *busdev;
>      ObjectClass *cpu_oc;
> @@ -299,22 +297,6 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem,
>      memory_region_add_subregion(system_mem, EXYNOS4210_IRAM_BASE_ADDR,
>                                  &s->iram_mem);
>
> -    /* DRAM */
> -    mem_size = ram_size;
> -    if (mem_size > EXYNOS4210_DRAM_MAX_SIZE) {
> -        memory_region_init_ram(&s->dram1_mem, NULL, "exynos4210.dram1",
> -                mem_size - EXYNOS4210_DRAM_MAX_SIZE, &error_fatal);
> -        vmstate_register_ram_global(&s->dram1_mem);
> -        memory_region_add_subregion(system_mem, EXYNOS4210_DRAM1_BASE_ADDR,
> -                &s->dram1_mem);
> -        mem_size = EXYNOS4210_DRAM_MAX_SIZE;
> -    }
> -    memory_region_init_ram(&s->dram0_mem, NULL, "exynos4210.dram0", mem_size,
> -                           &error_fatal);
> -    vmstate_register_ram_global(&s->dram0_mem);
> -    memory_region_add_subregion(system_mem, EXYNOS4210_DRAM0_BASE_ADDR,
> -            &s->dram0_mem);
> -
>     /* PMU.
>      * The only reason of existence at the moment is that secondary CPU boot
>      * loader uses PMU INFORM5 register as a holding pen.
> diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
> index 4853c318023c..6240b26839cd 100644
> --- a/hw/arm/exynos4_boards.c
> +++ b/hw/arm/exynos4_boards.c
> @@ -22,6 +22,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
> @@ -56,6 +57,12 @@ typedef enum Exynos4BoardType {
>      EXYNOS4_NUM_OF_BOARDS
>  } Exynos4BoardType;
>
> +typedef struct Exynos4BoardState {
> +    Exynos4210State *soc;
> +    MemoryRegion dram0_mem;
> +    MemoryRegion dram1_mem;
> +} Exynos4BoardState;
> +
>  static int exynos4_board_id[EXYNOS4_NUM_OF_BOARDS] = {
>      [EXYNOS4_BOARD_NURI]     = 0xD33,
>      [EXYNOS4_BOARD_SMDKC210] = 0xB16,
> @@ -96,9 +103,34 @@ static void lan9215_init(uint32_t base, qemu_irq irq)
>      }
>  }
>
> -static Exynos4210State *exynos4_boards_init_common(MachineState *machine,
> -                                                   Exynos4BoardType board_type)
> +static void exynos4_boards_init_ram(Exynos4BoardState *s,
> +                                    MemoryRegion *system_mem,
> +                                    unsigned long ram_size)
> +{
> +    unsigned long mem_size = ram_size;
> +
> +    if (mem_size > EXYNOS4210_DRAM_MAX_SIZE) {
> +        memory_region_init_ram(&s->dram1_mem, NULL, "exynos4210.dram1",
> +                               mem_size - EXYNOS4210_DRAM_MAX_SIZE,
> +                               &error_fatal);
> +        vmstate_register_ram_global(&s->dram1_mem);
> +        memory_region_add_subregion(system_mem, EXYNOS4210_DRAM1_BASE_ADDR,
> +                                    &s->dram1_mem);
> +        mem_size = EXYNOS4210_DRAM_MAX_SIZE;
> +    }
> +
> +    memory_region_init_ram(&s->dram0_mem, NULL, "exynos4210.dram0", mem_size,
> +                           &error_fatal);
> +    vmstate_register_ram_global(&s->dram0_mem);
> +    memory_region_add_subregion(system_mem, EXYNOS4210_DRAM0_BASE_ADDR,
> +                                &s->dram0_mem);
> +}
> +
> +static Exynos4BoardState *
> +exynos4_boards_init_common(MachineState *machine,
> +                           Exynos4BoardType board_type)
>  {
> +    Exynos4BoardState *s = g_new(Exynos4BoardState, 1);
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>
>      if (smp_cpus != EXYNOS4210_NCPUS && !qtest_enabled()) {
> @@ -127,8 +159,12 @@ static Exynos4210State *exynos4_boards_init_common(MachineState *machine,
>              machine->kernel_cmdline,
>              machine->initrd_filename);
>
> -    return exynos4210_init(get_system_memory(),
> -            exynos4_board_ram_size[board_type]);
> +    exynos4_boards_init_ram(s, get_system_memory(),
> +                            exynos4_board_ram_size[board_type]);
> +
> +    s->soc = exynos4210_init(get_system_memory());
> +
> +    return s;
>  }
>
>  static void nuri_init(MachineState *machine)
> @@ -140,11 +176,11 @@ static void nuri_init(MachineState *machine)
>
>  static void smdkc210_init(MachineState *machine)
>  {
> -    Exynos4210State *s = exynos4_boards_init_common(machine,
> -                                                    EXYNOS4_BOARD_SMDKC210);
> +    Exynos4BoardState *s = exynos4_boards_init_common(machine,
> +                                                      EXYNOS4_BOARD_SMDKC210);
>
>      lan9215_init(SMDK_LAN9118_BASE_ADDR,
> -            qemu_irq_invert(s->irq_table[exynos4210_get_irq(37, 1)]));
> +            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(37, 1)]));
>      arm_load_kernel(ARM_CPU(first_cpu), &exynos4_board_binfo);
>  }
>
> diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
> index d9e08014d6ff..098a69ec73d3 100644
> --- a/include/hw/arm/exynos4210.h
> +++ b/include/hw/arm/exynos4210.h
> @@ -93,8 +93,6 @@ typedef struct Exynos4210State {
>      MemoryRegion iram_mem;
>      MemoryRegion irom_mem;
>      MemoryRegion irom_alias_mem;
> -    MemoryRegion dram0_mem;
> -    MemoryRegion dram1_mem;
>      MemoryRegion boot_secondary;
>      MemoryRegion bootreg_mem;
>      I2CBus *i2c_if[EXYNOS4210_I2C_NUMBER];
> @@ -103,8 +101,7 @@ typedef struct Exynos4210State {
>  void exynos4210_write_secondary(ARMCPU *cpu,
>          const struct arm_boot_info *info);
>
> -Exynos4210State *exynos4210_init(MemoryRegion *system_mem,
> -        unsigned long ram_size);
> +Exynos4210State *exynos4210_init(MemoryRegion *system_mem);
>
>  /* Initialize exynos4210 IRQ subsystem stub */
>  qemu_irq *exynos4210_init_irq(Exynos4210Irq *env);
>
