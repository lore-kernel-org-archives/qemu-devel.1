Received: from eggs.gnu.org ([2001:4830:134:3::10]:55511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dasjW-0003YI-0r
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 20:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dasjR-0004Qr-7O
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 20:02:22 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1501153150-19984-1-git-send-email-peter.maydell@linaro.org>
	<1501153150-19984-5-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <241902a8-5942-9ae5-8ac8-41cf08da08ae@amsat.org>
Date: Thu, 27 Jul 2017 21:02:12 -0300
MIME-Version: 1.0
In-Reply-To: <1501153150-19984-5-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.10 4/5] target/arm: Move
 PMSAv7 reset into arm_cpu_reset() so M profile MPUs get reset
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

On 07/27/2017 07:59 AM, Peter Maydell wrote:
> When the PMSAv7 implementation was originally added it was for R profile
> CPUs only, and reset was handled using the cpreg .resetfn hooks.
> Unfortunately for M profile cores this doesn't work, because they do
> not register any cpregs. Move the reset handling into arm_cpu_reset(),
> where it will work for both R profile and M profile cores.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/arm/cpu.c    | 14 ++++++++++++++
>   target/arm/helper.c | 28 ++++++++++++----------------
>   2 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 96d1f84..05c038b 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -232,6 +232,20 @@ static void arm_cpu_reset(CPUState *s)
>   
>       env->vfp.xregs[ARM_VFP_FPEXC] = 0;
>   #endif
> +
> +    if (arm_feature(env, ARM_FEATURE_PMSA) &&
> +        arm_feature(env, ARM_FEATURE_V7)) {
> +        if (cpu->pmsav7_dregion > 0) {
> +            memset(env->pmsav7.drbar, 0,
> +                   sizeof(*env->pmsav7.drbar) * cpu->pmsav7_dregion);
> +            memset(env->pmsav7.drsr, 0,
> +                   sizeof(*env->pmsav7.drsr) * cpu->pmsav7_dregion);
> +            memset(env->pmsav7.dracr, 0,
> +                   sizeof(*env->pmsav7.dracr) * cpu->pmsav7_dregion);
> +        }
> +        env->pmsav7.rnr = 0;
> +    }
> +
>       set_flush_to_zero(1, &env->vfp.standard_fp_status);
>       set_flush_inputs_to_zero(1, &env->vfp.standard_fp_status);
>       set_default_nan_mode(1, &env->vfp.standard_fp_status);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 63187de..a9247e9 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2404,18 +2404,6 @@ static void pmsav7_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       *u32p = value;
>   }
>   
> -static void pmsav7_reset(CPUARMState *env, const ARMCPRegInfo *ri)
> -{
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> -    uint32_t *u32p = *(uint32_t **)raw_ptr(env, ri);
> -
> -    if (!u32p) {
> -        return;
> -    }
> -
> -    memset(u32p, 0, sizeof(*u32p) * cpu->pmsav7_dregion);
> -}
> -
>   static void pmsav7_rgnr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                 uint64_t value)
>   {
> @@ -2433,22 +2421,30 @@ static void pmsav7_rgnr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>   }
>   
>   static const ARMCPRegInfo pmsav7_cp_reginfo[] = {
> +    /* Reset for all these registers is handled in arm_cpu_reset(),
> +     * because the PMSAv7 is also used by M-profile CPUs, which do
> +     * not register cpregs but still need the state to be reset.
> +     */
>       { .name = "DRBAR", .cp = 15, .crn = 6, .opc1 = 0, .crm = 1, .opc2 = 0,
>         .access = PL1_RW, .type = ARM_CP_NO_RAW,
>         .fieldoffset = offsetof(CPUARMState, pmsav7.drbar),
> -      .readfn = pmsav7_read, .writefn = pmsav7_write, .resetfn = pmsav7_reset },
> +      .readfn = pmsav7_read, .writefn = pmsav7_write,
> +      .resetfn = arm_cp_reset_ignore },
>       { .name = "DRSR", .cp = 15, .crn = 6, .opc1 = 0, .crm = 1, .opc2 = 2,
>         .access = PL1_RW, .type = ARM_CP_NO_RAW,
>         .fieldoffset = offsetof(CPUARMState, pmsav7.drsr),
> -      .readfn = pmsav7_read, .writefn = pmsav7_write, .resetfn = pmsav7_reset },
> +      .readfn = pmsav7_read, .writefn = pmsav7_write,
> +      .resetfn = arm_cp_reset_ignore },
>       { .name = "DRACR", .cp = 15, .crn = 6, .opc1 = 0, .crm = 1, .opc2 = 4,
>         .access = PL1_RW, .type = ARM_CP_NO_RAW,
>         .fieldoffset = offsetof(CPUARMState, pmsav7.dracr),
> -      .readfn = pmsav7_read, .writefn = pmsav7_write, .resetfn = pmsav7_reset },
> +      .readfn = pmsav7_read, .writefn = pmsav7_write,
> +      .resetfn = arm_cp_reset_ignore },
>       { .name = "RGNR", .cp = 15, .crn = 6, .opc1 = 0, .crm = 2, .opc2 = 0,
>         .access = PL1_RW,
>         .fieldoffset = offsetof(CPUARMState, pmsav7.rnr),
> -      .writefn = pmsav7_rgnr_write },
> +      .writefn = pmsav7_rgnr_write,
> +      .resetfn = arm_cp_reset_ignore },
>       REGINFO_SENTINEL
>   };
>   
> 
