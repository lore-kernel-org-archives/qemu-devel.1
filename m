Received: from eggs.gnu.org ([2001:4830:134:3::10]:44313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emJde-0001gU-4D
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emJdc-0002d3-Qy
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:31:50 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emJdc-0002ck-LC
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:31:48 -0500
Received: by mail-oi0-x241.google.com with SMTP id l124so6827535oib.0
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 05:31:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180211205848.4568-8-richard.henderson@linaro.org>
References: <20180211205848.4568-1-richard.henderson@linaro.org>
	<20180211205848.4568-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 13:31:27 +0000
Message-ID: <CAFEAcA-m7AKPrSuCwRcgfMnYyN+90+6Bt5pY22=WOFH7avJXVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 7/7] linux-user: Implement aarch64
 PR_SVE_SET/GET_VL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 11 February 2018 at 20:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
> As an implementation choice, widening VL has zeroed the
> previously inaccessible portion of the sve registers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h     |  2 ++
>  linux-user/syscall.c | 20 +++++++++++++++++
>  target/arm/cpu64.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 51a3e16275..8e1016cfd6 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -842,6 +842,8 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>  #ifdef TARGET_AARCH64
>  int aarch64_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>  int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +unsigned aarch64_get_sve_vlen(CPUARMState *env);
> +unsigned aarch64_set_sve_vlen(CPUARMState *env, unsigned vlen);
>  #endif
>
>  target_ulong do_arm_semihosting(CPUARMState *env);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 82b35a6bdf..4840bf502f 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -10659,6 +10659,26 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              break;
>          }
>  #endif
> +#ifdef TARGET_AARCH64
> +        case 50: /* PR_SVE_SET_VL */

Could you put an
#ifndef PR_SVE_SET_VL
#define PR_SVE_SET_VL 50
#endif
(ditto for PR_SVE_GET_VL) in somewhere suitable rather than using
hard-coded constants, please?

> +            /* We cannot support either PR_SVE_SET_VL_ONEXEC
> +               or PR_SVE_VL_INHERIT.  Therefore, anything above
> +               ARM_MAX_VQ results in EINVAL.  */
> +            if (!arm_feature(cpu_env, ARM_FEATURE_SVE)
> +                || arg2 > ARM_MAX_VQ * 16 || arg2 & 15) {
> +                ret = -TARGET_EINVAL;
> +            } else {
> +                ret = aarch64_set_sve_vlen(cpu_env, arg2);
> +            }
> +            break;
> +        case 51: /* PR_SVE_GET_VL */
> +            if (arm_feature(cpu_env, ARM_FEATURE_SVE)) {
> +                ret = aarch64_get_sve_vlen(cpu_env);
> +            } else {
> +                ret = -TARGET_EINVAL;
> +            }

Seems a bit odd to write the if() with the working case first for one
of these and with the error case first for the other.

> +            break;
> +#endif /* AARCH64 */
>          case PR_GET_SECCOMP:
>          case PR_SET_SECCOMP:
>              /* Disable seccomp to prevent the target disabling syscalls we
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 1c330adc28..6dee78f006 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -363,3 +363,64 @@ static void aarch64_cpu_register_types(void)
>  }
>
>  type_init(aarch64_cpu_register_types)
> +
> +/* Return the current cumulative SVE VLEN.  */
> +unsigned aarch64_get_sve_vlen(CPUARMState *env)
> +{
> +    return ((env->vfp.zcr_el[1] & 0xf) + 1) * 16;

If this is supposed to also work for system-emulation mode it needs
to look at zcr_el[2] and [3]. If it's user-emulation mode only I
think we should #ifdef it and add a comment so that's clear.
Similarly with _set_. In fact if it's user-emulation only then it
probably belongs in linux-user/arm/ ?

> +}
> +
> +/* Set the cumulative ZCR.EL to VLEN, or the nearest supported value.
> +   Return the new value.  */
> +unsigned aarch64_set_sve_vlen(CPUARMState *env, unsigned vl)
> +{
> +    unsigned vq = vl / 16;
> +    unsigned old_vq = (env->vfp.zcr_el[1] & 0xf) + 1;
> +
> +    if (vq < 1) {
> +        vq = 1;
> +    } else if (vq > ARM_MAX_VQ) {
> +        vq = ARM_MAX_VQ;
> +    }
> +    env->vfp.zcr_el[1] = vq - 1;
> +
> +    /* The manual sez that when SVE is enabled and VL is widened the

"says". "sez" will probably get picked up and fixed next time somebody
runs a spellcheck over the codebase, so we might as well save them the
work.

> +     * implementation is allowed to zero the previously inaccessible
> +     * portion of the registers.  The corollary to that is that when
> +     * SVE is enabled and VL is narrowed we are also allowed to zero
> +     * the now inaccessible portion of the registers.
> +     *
> +     * The intent of this is that no predicate bit beyond VL is ever set.
> +     * Which means that some operations on predicate registers themselves
> +     * may operate on full uint64_t or even unrolled across the maximum
> +     * uint64_t[4].  Performing 4 bits of host arithmetic unconditionally
> +     * may well be cheaper than conditionals to restrict to the operation

"restrict the operation" ?

> +     * to the relevant portion of a uint16_t[16].
> +     *
> +     * ??? Need to move this somewhere else, so that it applies to
> +     * changes to the real system registers and EL state changes.
> +     */
> +    if (vq < old_vq) {
> +        unsigned i, j;
> +        uint64_t pmask;
> +
> +        /* Zap the high bits of the zregs.  */
> +        for (i = 0; i < 32; i++) {
> +            memset(&env->vfp.zregs[i].d[2 * vq], 0, 16 * (ARM_MAX_VQ - vq));
> +        }
> +
> +        /* Zap the high bits of the pregs and ffr.  */
> +        pmask = 0;
> +        if (vq & 3) {
> +            pmask = ~(-1ULL << (16 * (vq & 3)));
> +        }
> +        for (j = vq / 4; j < ARM_MAX_VQ / 4; j++) {
> +            for (i = 0; i < 17; ++i) {
> +                env->vfp.pregs[i].p[j] &= pmask;
> +            }
> +            pmask = 0;
> +        }
> +    }
> +
> +    return vq * 16;
> +}
> --
> 2.14.3

thanks
-- PMM
