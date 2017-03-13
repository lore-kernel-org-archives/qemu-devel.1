Received: from eggs.gnu.org ([2001:4830:134:3::10]:36956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cnVi4-0004Rw-7V
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cnVi0-0007Lm-6Y
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:32:48 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170313180432.7067-1-krzk@kernel.org>
	<20170313180432.7067-2-krzk@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cf23c2b4-c4c1-bb46-626e-a54851b25cbb@amsat.org>
Date: Mon, 13 Mar 2017 16:32:40 -0300
MIME-Version: 1.0
In-Reply-To: <20170313180432.7067-2-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 1/5] hw/intc/exynos4210_gic:
 Fix GIC memory mappings for secondary CPU
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
> Recent Linux kernel (tested next-20170224) was complaining about missing
> GIC mask and was unable to bring up secondary CPU:
>
>     [    0.000000] NR_IRQS:16 nr_irqs:16 16
>     [    0.000000] GIC CPU mask not found - kernel will fail to boot.
>     ...
>     [    0.400492] smp: Bringing up secondary CPUs ...
>     [    1.413184] CPU1: failed to boot: -110
>     [    1.423981] smp: Brought up 1 node, 1 CPU
>
> In its instance_init() call, the Exynos GIC driver was setting GIC
> memory mappings for each CPU, from 1 up to "num-cpu" property.  The
> Exynos4210 machine init call on the other hand, first created Exynos GIC
> device and then set the "num-cpu" property which was too late.  The init
> already happened with default "num-cpu" value of 1 thus GIC mappings
> were created only for the first CPU.
>
> Split the Exynos GIC init code into realize function so the code will
> see updated "num-cpu" property.  This fixes the warning and brings
> second CPU:
>     [    0.435780] CPU1: thread -1, cpu 1, socket 9, mpidr 80000901
>     [    0.451838] smp: Brought up 1 node, 2 CPUs
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/intc/exynos4210_gic.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
> index 2a55817b7660..222cfd6c6387 100644
> --- a/hw/intc/exynos4210_gic.c
> +++ b/hw/intc/exynos4210_gic.c
> @@ -283,9 +283,20 @@ static void exynos4210_gic_set_irq(void *opaque, int irq, int level)
>
>  static void exynos4210_gic_init(Object *obj)
>  {
> -    DeviceState *dev = DEVICE(obj);
>      Exynos4210GicState *s = EXYNOS4210_GIC(obj);
> -    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init(&s->cpu_container, obj, "exynos4210-cpu-container",
> +            EXYNOS4210_EXT_GIC_CPU_REGION_SIZE);
> +    memory_region_init(&s->dist_container, obj, "exynos4210-dist-container",
> +            EXYNOS4210_EXT_GIC_DIST_REGION_SIZE);
> +
> +}
> +
> +static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
> +{
> +    Exynos4210GicState *s = EXYNOS4210_GIC(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    Object *obj = OBJECT(dev);
>      uint32_t i;
>      const char cpu_prefix[] = "exynos4210-gic-alias_cpu";
>      const char dist_prefix[] = "exynos4210-gic-alias_dist";
> @@ -306,11 +317,6 @@ static void exynos4210_gic_init(Object *obj)
>      qdev_init_gpio_in(dev, exynos4210_gic_set_irq,
>                        EXYNOS4210_GIC_NIRQ - 32);
>
> -    memory_region_init(&s->cpu_container, obj, "exynos4210-cpu-container",
> -            EXYNOS4210_EXT_GIC_CPU_REGION_SIZE);
> -    memory_region_init(&s->dist_container, obj, "exynos4210-dist-container",
> -            EXYNOS4210_EXT_GIC_DIST_REGION_SIZE);
> -
>      for (i = 0; i < s->num_cpu; i++) {
>          /* Map CPU interface per SMP Core */
>          sprintf(cpu_alias_name, "%s%x", cpu_prefix, i);
> @@ -346,6 +352,7 @@ static void exynos4210_gic_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>
> +    dc->realize = exynos4210_gic_realize;
>      dc->props = exynos4210_gic_properties;
>  }
>
>
