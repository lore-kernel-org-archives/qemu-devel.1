Received: from eggs.gnu.org ([2001:4830:134:3::10]:34919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrQL-000313-8Z
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrQK-00040L-BR
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:35:49 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170602162857.6065-1-krzk@kernel.org>
	<20170602163618.6369-1-krzk@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f6e9e185-14b8-64bf-e295-803a1c0d1dae@amsat.org>
Date: Fri, 2 Jun 2017 15:35:43 -0300
MIME-Version: 1.0
In-Reply-To: <20170602163618.6369-1-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 1/9] hw/intc/exynos4210_gic: Use more
 meaningful name for local variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/02/2017 01:36 PM, Krzysztof Kozlowski wrote:
> There are to SysBusDevice variables in exynos4210_gic_realize()
> function: one for the device itself and second for arm_gic device.  Add
> a prefix "gic" to the second one so it will be easier to understand the
> code.
>
> While at it, put local uninitialized 'i' variable at the end, next to
> other uninitialized ones.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/intc/exynos4210_gic.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
> index 2a55817b7660..62acede72f62 100644
> --- a/hw/intc/exynos4210_gic.c
> +++ b/hw/intc/exynos4210_gic.c
> @@ -286,21 +286,21 @@ static void exynos4210_gic_init(Object *obj)
>      DeviceState *dev = DEVICE(obj);
>      Exynos4210GicState *s = EXYNOS4210_GIC(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> -    uint32_t i;
>      const char cpu_prefix[] = "exynos4210-gic-alias_cpu";
>      const char dist_prefix[] = "exynos4210-gic-alias_dist";
>      char cpu_alias_name[sizeof(cpu_prefix) + 3];
>      char dist_alias_name[sizeof(cpu_prefix) + 3];
> -    SysBusDevice *busdev;
> +    SysBusDevice *gicbusdev;
> +    uint32_t i;
>
>      s->gic = qdev_create(NULL, "arm_gic");
>      qdev_prop_set_uint32(s->gic, "num-cpu", s->num_cpu);
>      qdev_prop_set_uint32(s->gic, "num-irq", EXYNOS4210_GIC_NIRQ);
>      qdev_init_nofail(s->gic);
> -    busdev = SYS_BUS_DEVICE(s->gic);
> +    gicbusdev = SYS_BUS_DEVICE(s->gic);
>
>      /* Pass through outbound IRQ lines from the GIC */
> -    sysbus_pass_irq(sbd, busdev);
> +    sysbus_pass_irq(sbd, gicbusdev);
>
>      /* Pass through inbound GPIO lines to the GIC */
>      qdev_init_gpio_in(dev, exynos4210_gic_set_irq,
> @@ -316,7 +316,7 @@ static void exynos4210_gic_init(Object *obj)
>          sprintf(cpu_alias_name, "%s%x", cpu_prefix, i);
>          memory_region_init_alias(&s->cpu_alias[i], obj,
>                                   cpu_alias_name,
> -                                 sysbus_mmio_get_region(busdev, 1),
> +                                 sysbus_mmio_get_region(gicbusdev, 1),
>                                   0,
>                                   EXYNOS4210_GIC_CPU_REGION_SIZE);
>          memory_region_add_subregion(&s->cpu_container,
> @@ -326,7 +326,7 @@ static void exynos4210_gic_init(Object *obj)
>          sprintf(dist_alias_name, "%s%x", dist_prefix, i);
>          memory_region_init_alias(&s->dist_alias[i], obj,
>                                   dist_alias_name,
> -                                 sysbus_mmio_get_region(busdev, 0),
> +                                 sysbus_mmio_get_region(gicbusdev, 0),
>                                   0,
>                                   EXYNOS4210_GIC_DIST_REGION_SIZE);
>          memory_region_add_subregion(&s->dist_container,
>
