Received: from eggs.gnu.org ([2001:4830:134:3::10]:40983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cdall@linaro.org>) id 1dYVuo-0004gK-Eg
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cdall@linaro.org>) id 1dYVul-0007Fx-AN
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:16:14 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:38850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cdall@linaro.org>) id 1dYVul-0007Eb-38
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:16:11 -0400
Received: by mail-wm0-x22f.google.com with SMTP id w191so11175978wmw.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 04:16:09 -0700 (PDT)
Date: Fri, 21 Jul 2017 13:16:07 +0200
From: Christoffer Dall <cdall@linaro.org>
Message-ID: <20170721111607.GA16350@cbox>
References: <1500471597-2517-1-git-send-email-drjones@redhat.com>
	<1500471597-2517-2-git-send-email-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500471597-2517-2-git-send-email-drjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hw/arm/virt: add pmu interrupt state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, agraf@suse.de

On Wed, Jul 19, 2017 at 09:39:54AM -0400, Andrew Jones wrote:
> Mimicking gicv3-maintenance-interrupt, add the PMU's interrupt to
> CPU state.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/virt.c    | 3 +++
>  target/arm/cpu.c | 2 ++
>  target/arm/cpu.h | 2 ++
>  3 files changed, 7 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 31739d75a3e0..ea26f0c473c2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -610,6 +610,9 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>          qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
>                                      qdev_get_gpio_in(gicdev, ppibase
>                                                       + ARCH_GICV3_MAINT_IRQ));
> +        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> +                                    qdev_get_gpio_in(gicdev, ppibase
> +                                                     + VIRTUAL_PMU_IRQ));

I know Peter reviewed this, but isn't it a bit strange to create the
pmu-interrupt when creating the gic (as this isn't an output from the
GIC like the maintenance interrupt is) ?

Thanks,
-Christoffer

>  
>          sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
>          sysbus_connect_irq(gicbusdev, i + smp_cpus,
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 96d1f840301f..fd82c7944840 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -499,6 +499,8 @@ static void arm_cpu_initfn(Object *obj)
>  
>      qdev_init_gpio_out_named(DEVICE(cpu), &cpu->gicv3_maintenance_interrupt,
>                               "gicv3-maintenance-interrupt", 1);
> +    qdev_init_gpio_out_named(DEVICE(cpu), &cpu->pmu_interrupt,
> +                             "pmu-interrupt", 1);
>  #endif
>  
>      /* DTB consumers generally don't in fact care what the 'compatible'
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 102c58afac52..8d91166eb97b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -584,6 +584,8 @@ struct ARMCPU {
>      qemu_irq gt_timer_outputs[NUM_GTIMERS];
>      /* GPIO output for GICv3 maintenance interrupt signal */
>      qemu_irq gicv3_maintenance_interrupt;
> +    /* GPIO output for the PMU interrupt */
> +    qemu_irq pmu_interrupt;
>  
>      /* MemoryRegion to use for secure physical accesses */
>      MemoryRegion *secure_memory;
> -- 
> 1.8.3.1
> 
