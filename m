Received: from eggs.gnu.org ([2001:4830:134:3::10]:39176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1chK2y-00068x-Q3
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1chK2x-00079V-Ul
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:52:48 -0500
References: <1487850673-26455-1-git-send-email-vijay.kilari@gmail.com>
	<1487850673-26455-5-git-send-email-vijay.kilari@gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <57dac6a6-6ac5-91c7-6dd2-dfb1b9fa1f7c@redhat.com>
Date: Fri, 24 Feb 2017 18:52:37 +0100
MIME-Version: 1.0
In-Reply-To: <1487850673-26455-5-git-send-email-vijay.kilari@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 4/5] target-arm: Add GICv3CPUState in
 CPUARMState struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vijay.kilari@gmail.com, qemu-arm@nongnu.org, peter.maydell@linaro.org, christoffer.dall@linaro.org
Cc: p.fedin@samsung.com, marc.zyngier@arm.com, qemu-devel@nongnu.org, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Hi,
On 23/02/2017 12:51, vijay.kilari@gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> 
> Add gicv3state void pointer to CPUARMState struct
> to store GICv3CPUState.
> 
> In case of usecase like CPU reset, we need to reset
> GICv3CPUState of the CPU. In such scenario, this pointer
> becomes handy.
> 
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  hw/intc/arm_gicv3_common.c | 2 ++
>  hw/intc/arm_gicv3_cpuif.c  | 8 ++++++++
>  hw/intc/gicv3_internal.h   | 2 ++
>  target/arm/cpu.h           | 2 ++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 5b0e456..c6493d6 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -252,6 +252,8 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
>  
>          s->cpu[i].cpu = cpu;
>          s->cpu[i].gic = s;
> +        /* Store GICv3CPUState in CPUARMState gicv3state pointer */
> +        gicv3_set_gicv3state(cpu, &s->cpu[i]);
>  
>          /* Pre-construct the GICR_TYPER:
>           * For our implementation:
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index c25ee03..7849783 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -18,6 +18,14 @@
>  #include "gicv3_internal.h"
>  #include "cpu.h"
>  
> +void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s)
> +{
> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
> +    CPUARMState *env = &arm_cpu->env;
> +
> +    env->gicv3state = (void *)s;
> +};
> +
>  static GICv3CPUState *icc_cs_from_env(CPUARMState *env)
>  {
>      /* Given the CPU, find the right GICv3CPUState struct.
> diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
> index 457118e..05303a5 100644
> --- a/hw/intc/gicv3_internal.h
> +++ b/hw/intc/gicv3_internal.h
> @@ -408,4 +408,6 @@ static inline void gicv3_cache_all_target_cpustates(GICv3State *s)
>      }
>  }
>  
> +void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s);
> +
>  #endif /* QEMU_ARM_GICV3_INTERNAL_H */
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 0956a54..d2eb7bf 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -517,6 +517,8 @@ typedef struct CPUARMState {
>  
>      void *nvic;
>      const struct arm_boot_info *boot_info;
> +    /* Store GICv3CPUState to access from this struct */
> +    void *gicv3state;
>  } CPUARMState;
>  
>  /**
> 
