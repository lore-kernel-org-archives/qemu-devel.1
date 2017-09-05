Received: from eggs.gnu.org ([2001:4830:134:3::10]:34454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMox-00050P-JW
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMos-0002DI-L7
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:59:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-13-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <083e75ee-a047-d3e2-4c00-356c4f24895f@amsat.org>
Date: Tue, 5 Sep 2017 19:59:42 -0300
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-13-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/20] target/arm: Make MPU_MAIR0,
 MPU_MAIR1 registers banked for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/22/2017 12:08 PM, Peter Maydell wrote:
> Make the MPU registers MPU_MAIR0 and MPU_MAIR1 banked if v8M security
> extensions are enabled.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h      | 4 ++--
>   hw/intc/armv7m_nvic.c | 8 ++++----
>   target/arm/cpu.c      | 4 ++--
>   target/arm/machine.c  | 6 ++++--
>   4 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index d0b0936..2f59828 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -545,8 +545,8 @@ typedef struct CPUARMState {
>            */
>           uint32_t *rbar;
>           uint32_t *rlar;
> -        uint32_t mair0;
> -        uint32_t mair1;
> +        uint32_t mair0[2];
> +        uint32_t mair1[2];

I'm tempted to ask:

             uint32_t mair[2][2];

>       } pmsav8;
>   
>       void *nvic;
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 3a1f02d..e98eb95 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -604,12 +604,12 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
>           if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
>               goto bad_offset;
>           }
> -        return cpu->env.pmsav8.mair0;
> +        return cpu->env.pmsav8.mair0[attrs.secure];

            return cpu->env.pmsav8.mair[0][attrs.secure];

>       case 0xdc4: /* MPU_MAIR1 */
>           if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
>               goto bad_offset;
>           }
> -        return cpu->env.pmsav8.mair1;
> +        return cpu->env.pmsav8.mair1[attrs.secure];

            return cpu->env.pmsav8.mair[1][attrs.secure];

>       default:
>       bad_offset:
>           qemu_log_mask(LOG_GUEST_ERROR, "NVIC: Bad read offset 0x%x\n", offset);
> @@ -826,7 +826,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
>           }
>           if (cpu->pmsav7_dregion) {
>               /* Register is RES0 if no MPU regions are implemented */
> -            cpu->env.pmsav8.mair0 = value;
> +            cpu->env.pmsav8.mair0[attrs.secure] = value;

                cpu->env.pmsav8.mair[0][attrs.secure] = value;

>           }
>           /* We don't need to do anything else because memory attributes
>            * only affect cacheability, and we don't implement caching.
> @@ -838,7 +838,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
>           }
>           if (cpu->pmsav7_dregion) {
>               /* Register is RES0 if no MPU regions are implemented */
> -            cpu->env.pmsav8.mair1 = value;
> +            cpu->env.pmsav8.mair1[attrs.secure] = value;

                cpu->env.pmsav8.mair[1][attrs.secure] = value;

>           }
>           /* We don't need to do anything else because memory attributes
>            * only affect cacheability, and we don't implement caching.
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index ae866be..ae8af19 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -249,8 +249,8 @@ static void arm_cpu_reset(CPUState *s)
>               }
>           }
>           env->pmsav7.rnr = 0;
> -        env->pmsav8.mair0 = 0;
> -        env->pmsav8.mair1 = 0;
> +        memset(env->pmsav8.mair0, 0, sizeof(env->pmsav8.mair0));
> +        memset(env->pmsav8.mair1, 0, sizeof(env->pmsav8.mair1));
            memset(env->pmsav8.mair, 0, sizeof(env->pmsav8.mair));

>       }
>   
>       set_flush_to_zero(1, &env->vfp.standard_fp_status);
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index cd6b6af..414a879 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -229,8 +229,8 @@ static const VMStateDescription vmstate_pmsav8 = {
>                                 vmstate_info_uint32, uint32_t),
>           VMSTATE_VARRAY_UINT32(env.pmsav8.rlar, ARMCPU, pmsav7_dregion, 0,
>                                 vmstate_info_uint32, uint32_t),
> -        VMSTATE_UINT32(env.pmsav8.mair0, ARMCPU),
> -        VMSTATE_UINT32(env.pmsav8.mair1, ARMCPU),
> +        VMSTATE_UINT32(env.pmsav8.mair0[M_REG_NS], ARMCPU),
> +        VMSTATE_UINT32(env.pmsav8.mair1[M_REG_NS], ARMCPU),

etc...

matter of taste, so:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>           VMSTATE_END_OF_LIST()
>       }
>   };
> @@ -255,6 +255,8 @@ static const VMStateDescription vmstate_m_security = {
>           VMSTATE_UINT32(env.v7m.faultmask[M_REG_S], ARMCPU),
>           VMSTATE_UINT32(env.v7m.control[M_REG_S], ARMCPU),
>           VMSTATE_UINT32(env.v7m.vecbase[M_REG_S], ARMCPU),
> +        VMSTATE_UINT32(env.pmsav8.mair0[M_REG_S], ARMCPU),
> +        VMSTATE_UINT32(env.pmsav8.mair1[M_REG_S], ARMCPU),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> 
