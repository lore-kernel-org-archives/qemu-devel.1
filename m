Received: from eggs.gnu.org ([2001:4830:134:3::10]:33945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cjTvp-0007dw-Iu
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:50:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cjTvo-00059f-Hy
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:50:21 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8F013ggLmx9hhg+z4ODq3YkU7vfAygjk+QF7dBV6WW5g@mail.gmail.com>
References: <20170301182618.22395-1-krzk@kernel.org>
	<20170301182618.22395-2-krzk@kernel.org>
	<CAFEAcA8F013ggLmx9hhg+z4ODq3YkU7vfAygjk+QF7dBV6WW5g@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 2 Mar 2017 18:50:10 +0200
Message-ID: <CAJKOXPe3ecS82Vn8F9otAEprNjnp1q55ZfVwAhy=jXPOPZLLXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/5] hw/intc/exynos4210_gic: Fix GIC memory
 mappings for secondary CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhao@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>

On Thu, Mar 2, 2017 at 6:37 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 1 March 2017 at 18:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> Recent Linux kernel (tested next-20170224) was complaining about missing
>> GIC mask and was unable to bring up secondary CPU:
>>
>>     [    0.000000] NR_IRQS:16 nr_irqs:16 16
>>     [    0.000000] GIC CPU mask not found - kernel will fail to boot.
>>     ...
>>     [    0.400492] smp: Bringing up secondary CPUs ...
>>     [    1.413184] CPU1: failed to boot: -110
>>     [    1.423981] smp: Brought up 1 node, 1 CPU
>>
>> In its instance_init() call, the Exynos GIC driver was setting GIC
>> memory mappings for each CPU, from 1 up to "num-cpu" property.  The
>> Exynos4210 machine init call on the other hand, first created Exynos GIC
>> device and then set the "num-cpu" property which was too late.  The init
>> already happened with default "num-cpu" value of 1 thus GIC mappings
>> were created only for the first CPU.
>>
>> Split the Exynos GIC init code into realize function so the code will
>> see updated "num-cpu" property.  This fixes the warning and brings
>> second CPU:
>>     [    0.435780] CPU1: thread -1, cpu 1, socket 9, mpidr 80000901
>>     [    0.451838] smp: Brought up 1 node, 2 CPUs
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>
>> But please read cover letter!
>>
>> ---
>>  hw/intc/exynos4210_gic.c | 24 +++++++++++++++---------
>>  1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
>> index 2a55817b7660..5986e54d39c9 100644
>> --- a/hw/intc/exynos4210_gic.c
>> +++ b/hw/intc/exynos4210_gic.c
>> @@ -283,9 +283,19 @@ static void exynos4210_gic_set_irq(void *opaque, int irq, int level)
>>
>>  static void exynos4210_gic_init(Object *obj)
>>  {
>> -    DeviceState *dev = DEVICE(obj);
>>      Exynos4210GicState *s = EXYNOS4210_GIC(obj);
>> -    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>> +
>> +    memory_region_init(&s->cpu_container, obj, "exynos4210-cpu-container",
>> +            EXYNOS4210_EXT_GIC_CPU_REGION_SIZE);
>> +    memory_region_init(&s->dist_container, obj, "exynos4210-dist-container",
>> +            EXYNOS4210_EXT_GIC_DIST_REGION_SIZE);
>> +
>> +}
>> +
>> +static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
>> +{
>> +    Exynos4210GicState *s = EXYNOS4210_GIC(dev);
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>>      uint32_t i;
>>      const char cpu_prefix[] = "exynos4210-gic-alias_cpu";
>>      const char dist_prefix[] = "exynos4210-gic-alias_dist";
>> @@ -306,15 +316,10 @@ static void exynos4210_gic_init(Object *obj)
>>      qdev_init_gpio_in(dev, exynos4210_gic_set_irq,
>>                        EXYNOS4210_GIC_NIRQ - 32);
>>
>> -    memory_region_init(&s->cpu_container, obj, "exynos4210-cpu-container",
>> -            EXYNOS4210_EXT_GIC_CPU_REGION_SIZE);
>> -    memory_region_init(&s->dist_container, obj, "exynos4210-dist-container",
>> -            EXYNOS4210_EXT_GIC_DIST_REGION_SIZE);
>> -
>>      for (i = 0; i < s->num_cpu; i++) {
>>          /* Map CPU interface per SMP Core */
>>          sprintf(cpu_alias_name, "%s%x", cpu_prefix, i);
>> -        memory_region_init_alias(&s->cpu_alias[i], obj,
>> +        memory_region_init_alias(&s->cpu_alias[i], OBJECT(s),
>>                                   cpu_alias_name,
>>                                   sysbus_mmio_get_region(busdev, 1),
>>                                   0,
>> @@ -324,7 +329,7 @@ static void exynos4210_gic_init(Object *obj)
>>
>>          /* Map Distributor per SMP Core */
>>          sprintf(dist_alias_name, "%s%x", dist_prefix, i);
>> -        memory_region_init_alias(&s->dist_alias[i], obj,
>> +        memory_region_init_alias(&s->dist_alias[i], OBJECT(s),
>>                                   dist_alias_name,
>>                                   sysbus_mmio_get_region(busdev, 0),
>>                                   0,
>
> Slightly better to define
>   Object *obj = OBJECT(dev);
> at the start of the realize function rather than doing the dynamic
> cast twice every time round the loop.
>
>> @@ -346,6 +351,7 @@ static void exynos4210_gic_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>
>> +    dc->realize = exynos4210_gic_realize;
>>      dc->props = exynos4210_gic_properties;
>>  }
>
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Sure, I'll re-spin with the cast and reviewed-by tags.

What about the issue I mentioned in the cover letter? Fixing the GIC
caused the recent Linux kernel to behave worst...

Best regards,
Krzysztof
