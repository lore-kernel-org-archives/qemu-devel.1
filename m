Received: from eggs.gnu.org ([2001:4830:134:3::10]:34713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb7cJ-0007ku-1H
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb7cH-0003ph-IA
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:23:39 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb7cH-0003pL-7h
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:23:37 -0500
Received: by mail-wr0-x231.google.com with SMTP id k90so40802360wrc.3
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 07:23:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170206153113.27729-21-alex.bennee@linaro.org>
References: <20170206153113.27729-1-alex.bennee@linaro.org>
	<20170206153113.27729-21-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 15:23:15 +0000
Message-ID: <CAFEAcA9YEo2+_9jc4V_aEds_tQV-f5pU+W49zUs1Ls0JOiQTLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 20/23] target-arm/powerctl: defer cpu
 reset work to CPU context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 6 February 2017 at 15:31, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> When switching a new vCPU on we want to complete a bunch of the setup
> work before we start scheduling the vCPU thread. To do this cleanly we
> defer vCPU setup to async work which will run the vCPUs execution
> context as the thread is woken up. The scheduling of the work will kick
> the vCPU awake.
>
> This avoids potential races in MTTCG system emulation.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

> @@ -77,7 +159,7 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uin=
t64_t context_id,
>      }
>
>      target_cpu =3D ARM_CPU(target_cpu_state);
> -    if (!target_cpu->powered_off) {
> +    if (!atomic_mb_read(&target_cpu->powered_off)) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "[ARM]%s: CPU %" PRId64 " is already on\n",
>                        __func__, cpuid);

> +    /*
> +     * If another CPU has powered the target on we are in the state
> +     * ON_PENDING and additional attempts to power on the CPU should
> +     * fail (see 6.6 Implementation CPU_ON/CPU_OFF races in the PSCI
> +     * spec)
> +     */
> +    if (atomic_cmpxchg(&target_cpu->powering_on, false, true)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "[ARM]%s: CPU %" PRId64 " is already powering on\n=
",
> +                      __func__, cpuid);
> +        return QEMU_ARM_POWERCTL_ON_PENDING;
>      }

I find this too hard to reason about :-(  We store the current
CPU state in not one but two CPU structure fields, and then
we check and manipulate it not by doing "take lock; access
and update; drop lock" but by doing successive atomic
operations on the various different flags. This seems unnecessarily
tricky, and the patch doesn't provide any documentation about
what's going on and what the constraints are to avoid races.

>
> -    /* Start the new CPU at the requested address */
> -    cpu_set_pc(target_cpu_state, entry);
> +    /* To avoid racing with a CPU we are just kicking off we do the
> +     * final bit of preparation for the work in the target CPUs
> +     * context.
> +     */
> +    info =3D g_new(struct cpu_on_info, 1);
> +    info->entry =3D entry;
> +    info->context_id =3D context_id;
> +    info->target_el =3D target_el;
> +    info->target_aa64 =3D target_aa64;
>
> -    qemu_cpu_kick(target_cpu_state);
> +    async_run_on_cpu(target_cpu_state, arm_set_cpu_on_async_work,
> +                     RUN_ON_CPU_HOST_PTR(info));
>
>      /* We are good to go */
>      return QEMU_ARM_POWERCTL_RET_SUCCESS;
>  }

> @@ -221,8 +284,9 @@ int arm_reset_cpu(uint64_t cpuid)
>          return QEMU_ARM_POWERCTL_IS_OFF;
>      }
>
> -    /* Reset the cpu */
> -    cpu_reset(target_cpu_state);
> +    /* Queue work to run under the target vCPUs context */
> +    async_run_on_cpu(target_cpu_state, arm_reset_cpu_async_work,
> +                     RUN_ON_CPU_NULL);

The imx6 datasheet says that the RST bit in the SCR register
is set by the guest to trigger a reset, and then the bit
remains set until the reset has finished (at which point it
self-clears). At the moment the imx6_src.c code does this:

        if (EXTRACT(change_mask, CORE0_RST)) {
            arm_reset_cpu(0);
            clear_bit(CORE0_RST_SHIFT, &current_value);
        }

ie it assumes that arm_reset_cpu() is synchronous.

PS: if the code does an arm_set_cpu_on() and then
arm_reset_cpu() do we do the two lots of async work
in the right order?

>      return QEMU_ARM_POWERCTL_RET_SUCCESS;
>  }
> diff --git a/target/arm/arm-powerctl.h b/target/arm/arm-powerctl.h
> index 98ee04989b..04353923c0 100644
> --- a/target/arm/arm-powerctl.h
> +++ b/target/arm/arm-powerctl.h
> @@ -17,6 +17,7 @@
>  #define QEMU_ARM_POWERCTL_INVALID_PARAM QEMU_PSCI_RET_INVALID_PARAMS
>  #define QEMU_ARM_POWERCTL_ALREADY_ON QEMU_PSCI_RET_ALREADY_ON
>  #define QEMU_ARM_POWERCTL_IS_OFF QEMU_PSCI_RET_DENIED
> +#define QEMU_ARM_POWERCTL_ON_PENDING QEMU_PSCI_RET_ON_PENDING
>
>  /*
>   * arm_get_cpu_by_id:
> @@ -43,6 +44,7 @@ CPUState *arm_get_cpu_by_id(uint64_t cpuid);
>   * Returns: QEMU_ARM_POWERCTL_RET_SUCCESS on success.
>   * QEMU_ARM_POWERCTL_INVALID_PARAM if bad parameters are provided.
>   * QEMU_ARM_POWERCTL_ALREADY_ON if the CPU was already started.
> + * QEMU_ARM_POWERCTL_ON_PENDING if the CPU is still powering up
>   */
>  int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
>                     uint32_t target_el, bool target_aa64);
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 39bff86daf..b8f82d5d20 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -582,8 +582,16 @@ struct ARMCPU {
>
>      /* Should CPU start in PSCI powered-off state? */
>      bool start_powered_off;
> -    /* CPU currently in PSCI powered-off state */
> +    /* CPU PSCI state.
> +     *
> +     * For TCG these can be cross-vCPU accesses and should be done
> +     * atomically to avoid races.
> +     *
> +     *  - powered_off indicates the vCPU state
> +     *  - powering_on true if the vCPU has had a CPU_ON but not yet up
> +     */
>      bool powered_off;
> +    bool powering_on;  /* PSCI ON_PENDING */
>      /* CPU has virtualization extension */
>      bool has_el2;
>      /* CPU has security extension */
> --
> 2.11.0
>

thanks
-- PMM
