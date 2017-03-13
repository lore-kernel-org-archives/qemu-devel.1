Received: from eggs.gnu.org ([2001:4830:134:3::10]:36480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cnVfp-0002zB-6Z
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cnVfl-0006SC-54
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:30:29 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170313180432.7067-1-krzk@kernel.org>
	<20170313180432.7067-3-krzk@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3ec3158f-dd55-fe19-3778-b4c1cc4492dc@amsat.org>
Date: Mon, 13 Mar 2017 16:30:20 -0300
MIME-Version: 1.0
In-Reply-To: <20170313180432.7067-3-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 2/5] hw/intc/exynos4210_gic:
 Use more meaningful name for local variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>

On 03/13/2017 03:04 PM, Krzysztof Kozlowski wrote:
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
> index 222cfd6c6387..9a2254f0b13c 100644
> --- a/hw/intc/exynos4210_gic.c
> +++ b/hw/intc/exynos4210_gic.c
> @@ -297,21 +297,21 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
>      Exynos4210GicState *s = EXYNOS4210_GIC(dev);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      Object *obj = OBJECT(dev);
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
> @@ -322,7 +322,7 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
>          sprintf(cpu_alias_name, "%s%x", cpu_prefix, i);
>          memory_region_init_alias(&s->cpu_alias[i], obj,
>                                   cpu_alias_name,
> -                                 sysbus_mmio_get_region(busdev, 1),
> +                                 sysbus_mmio_get_region(gicbusdev, 1),
>                                   0,
>                                   EXYNOS4210_GIC_CPU_REGION_SIZE);
>          memory_region_add_subregion(&s->cpu_container,
> @@ -332,7 +332,7 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
>          sprintf(dist_alias_name, "%s%x", dist_prefix, i);
>          memory_region_init_alias(&s->dist_alias[i], obj,
>                                   dist_alias_name,
> -                                 sysbus_mmio_get_region(busdev, 0),
> +                                 sysbus_mmio_get_region(gicbusdev, 0),
>                                   0,
>                                   EXYNOS4210_GIC_DIST_REGION_SIZE);
>          memory_region_add_subregion(&s->dist_container,
>
