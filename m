Received: from eggs.gnu.org ([2001:4830:134:3::10]:43599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72FP-0006cW-V2
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72FL-0002nA-Uq
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:07:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170506152414.8704-1-krzk@kernel.org>
	<20170506152414.8704-4-krzk@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1e9c6e59-b5c6-3618-5dc1-d1c07e1196d4@amsat.org>
Date: Sat, 6 May 2017 13:07:45 -0300
MIME-Version: 1.0
In-Reply-To: <20170506152414.8704-4-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/exynos: QOM-ify the SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 05/06/2017 12:24 PM, Krzysztof Kozlowski wrote:
> Convert the Exynos4210 SoC code into a QOM model which is a preferred
> approach instead of directly initializing SoC-related devices from the
> board file.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/exynos4210.c         | 18 +++++++++++++++---
>  hw/arm/exynos4_boards.c     |  9 ++++++---
>  include/hw/arm/exynos4210.h |  8 ++++++--
>  3 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index 27a7bf28a5a9..034fc8be9d76 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -160,9 +160,10 @@ static uint64_t exynos4210_calc_affinity(int cpu)
>      return mp_affinity;
>  }
>
> -Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
> +static void exynos4210_init(Object *obj)
>  {
> -    Exynos4210State *s = g_new(Exynos4210State, 1);
> +    MemoryRegion *system_mem = get_system_memory();
> +    Exynos4210State *s = EXYNOS4210(obj);
>      qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
>      SysBusDevice *busdev;
>      ObjectClass *cpu_oc;
> @@ -402,6 +403,17 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
>
>      sysbus_create_simple(TYPE_EXYNOS4210_EHCI, EXYNOS4210_EHCI_BASE_ADDR,
>              s->irq_table[exynos4210_get_irq(28, 3)]);
> +}
> +
> +static const TypeInfo exynos4210_type_info = {
> +    .name = TYPE_EXYNOS4210,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(Exynos4210State),
> +    .instance_init = exynos4210_init,
> +};
>
> -    return s;
> +static void exynos4210_register_types(void)
> +{
> +    type_register_static(&exynos4210_type_info);
>  }
> +type_init(exynos4210_register_types)
> diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
> index 6240b26839cd..5e7c6b562ae2 100644
> --- a/hw/arm/exynos4_boards.c
> +++ b/hw/arm/exynos4_boards.c
> @@ -58,7 +58,7 @@ typedef enum Exynos4BoardType {
>  } Exynos4BoardType;
>
>  typedef struct Exynos4BoardState {
> -    Exynos4210State *soc;
> +    Exynos4210State soc;
>      MemoryRegion dram0_mem;
>      MemoryRegion dram1_mem;
>  } Exynos4BoardState;
> @@ -162,7 +162,10 @@ exynos4_boards_init_common(MachineState *machine,
>      exynos4_boards_init_ram(s, get_system_memory(),
>                              exynos4_board_ram_size[board_type]);
>
> -    s->soc = exynos4210_init(get_system_memory());
> +    object_initialize(&s->soc, sizeof(s->soc), TYPE_EXYNOS4210);
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> +                              &error_abort);
> +    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fatal);
>
>      return s;
>  }
> @@ -180,7 +183,7 @@ static void smdkc210_init(MachineState *machine)
>                                                        EXYNOS4_BOARD_SMDKC210);
>
>      lan9215_init(SMDK_LAN9118_BASE_ADDR,
> -            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(37, 1)]));
> +            qemu_irq_invert(s->soc.irq_table[exynos4210_get_irq(37, 1)]));
>      arm_load_kernel(ARM_CPU(first_cpu), &exynos4_board_binfo);
>  }
>
> diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
> index 098a69ec73d3..116eae62756b 100644
> --- a/include/hw/arm/exynos4210.h
> +++ b/include/hw/arm/exynos4210.h
> @@ -29,6 +29,10 @@
>  #include "exec/memory.h"
>  #include "target/arm/cpu-qom.h"
>
> +#define TYPE_EXYNOS4210 "exynos4210"
> +#define EXYNOS4210(obj) \
> +    OBJECT_CHECK(Exynos4210State, (obj), TYPE_EXYNOS4210)
> +
>  #define EXYNOS4210_NCPUS                    2
>
>  #define EXYNOS4210_DRAM0_BASE_ADDR          0x40000000
> @@ -85,6 +89,8 @@ typedef struct Exynos4210Irq {
>  } Exynos4210Irq;
>
>  typedef struct Exynos4210State {
> +    DeviceState parent_obj;
> +
>      ARMCPU *cpu[EXYNOS4210_NCPUS];
>      Exynos4210Irq irqs;
>      qemu_irq *irq_table;
> @@ -101,8 +107,6 @@ typedef struct Exynos4210State {
>  void exynos4210_write_secondary(ARMCPU *cpu,
>          const struct arm_boot_info *info);
>
> -Exynos4210State *exynos4210_init(MemoryRegion *system_mem);
> -
>  /* Initialize exynos4210 IRQ subsystem stub */
>  qemu_irq *exynos4210_init_irq(Exynos4210Irq *env);
>
>
