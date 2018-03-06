Received: from eggs.gnu.org ([2001:4830:134:3::10]:37054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etBiF-0004FH-AC
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etBiC-0004RR-5C
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:28:59 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1etBiB-0004Qe-QH
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:28:56 -0500
Received: by mail-wm0-x244.google.com with SMTP id 188so21813591wme.1
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 04:28:55 -0800 (PST)
References: <20180303143823.27055-1-richard.henderson@linaro.org>
	<20180303143823.27055-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180303143823.27055-2-richard.henderson@linaro.org>
Date: Tue, 06 Mar 2018 12:28:53 +0000
Message-ID: <87a7vltmka.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/5] linux-user: Implement aarch64
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
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> As an implementation choice, widening VL has zeroed the
> previously inaccessible portion of the sve registers.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/target_syscall.h |  3 +++
>  target/arm/cpu.h                    |  1 +
>  linux-user/syscall.c                | 27 ++++++++++++++++++++++++
>  target/arm/cpu64.c                  | 41 +++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 72 insertions(+)
>
> diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/tar=
get_syscall.h
> index 604ab99b14..205265e619 100644
> --- a/linux-user/aarch64/target_syscall.h
> +++ b/linux-user/aarch64/target_syscall.h
> @@ -19,4 +19,7 @@ struct target_pt_regs {
>  #define TARGET_MLOCKALL_MCL_CURRENT 1
>  #define TARGET_MLOCKALL_MCL_FUTURE  2
>
> +#define TARGET_PR_SVE_SET_VL  50
> +#define TARGET_PR_SVE_GET_VL  51

For some reason I thought we might get this from our copy of
linux-headers but it seems we only do that for KVM bits.

> +
>  #endif /* AARCH64_TARGET_SYSCALL_H */
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8dd6b788df..5f4566f017 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -861,6 +861,7 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f,=
 CPUState *cs,
>  #ifdef TARGET_AARCH64
>  int aarch64_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>  int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
>  #endif
>
>  target_ulong do_arm_semihosting(CPUARMState *env);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e24f43c4a2..38f40e2692 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -10670,6 +10670,33 @@ abi_long do_syscall(void *cpu_env, int num, abi_=
long arg1,
>              break;
>          }
>  #endif
> +#ifdef TARGET_AARCH64
> +        case TARGET_PR_SVE_SET_VL:
> +            /* We cannot support either PR_SVE_SET_VL_ONEXEC
> +               or PR_SVE_VL_INHERIT.  Therefore, anything above
> +               ARM_MAX_VQ results in EINVAL.  */
> +            ret =3D -TARGET_EINVAL;
> +            if (arm_feature(cpu_env, ARM_FEATURE_SVE)
> +                && arg2 >=3D 0 && arg2 <=3D ARM_MAX_VQ * 16 && !(arg2 & =
15)) {
> +                CPUARMState *env =3D cpu_env;

The kernel code splits the arg2 up into VL and flags. We don't seem to
be doing that here.

	vl =3D arg & PR_SVE_VL_LEN_MASK;
	flags =3D arg & ~vl;

I'm not sure what && !(arg2 & 15) is doing but PR_SVE_VL_LEN_MASK is
0xffff, Perhaps some defines would be useful to make it clearer.

> +                int old_vq =3D (env->vfp.zcr_el[1] & 0xf) + 1;
> +                int vq =3D MAX(arg2 / 16, 1);
> +
> +                if (vq < old_vq) {
> +                    aarch64_sve_narrow_vq(env, vq);
> +                }
> +                env->vfp.zcr_el[1] =3D vq - 1;

It seems odd not to have setting this inside cpu64.c. Won't a similar
manipulation need to be made for system mode? I'd keep all the logic
together in aarch64_sve_narrow_vq (or maybe call it aarch64_sve_set_vq
and pass it the current exception level).

> +                ret =3D vq * 16;
> +            }
> +            break;
> +        case TARGET_PR_SVE_GET_VL:
> +            ret =3D -TARGET_EINVAL;
> +            if (arm_feature(cpu_env, ARM_FEATURE_SVE)) {
> +                CPUARMState *env =3D cpu_env;
> +                ret =3D ((env->vfp.zcr_el[1] & 0xf) + 1) * 16;
> +            }
> +            break;
> +#endif /* AARCH64 */
>          case PR_GET_SECCOMP:
>          case PR_SET_SECCOMP:
>              /* Disable seccomp to prevent the target disabling syscalls =
we
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 4228713b19..74b485b382 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -366,3 +366,44 @@ static void aarch64_cpu_register_types(void)
>  }
>
>  type_init(aarch64_cpu_register_types)
> +
> +/* The manual says that when SVE is enabled and VQ is widened the
> + * implementation is allowed to zero the previously inaccessible
> + * portion of the registers.  The corollary to that is that when
> + * SVE is enabled and VQ is narrowed we are also allowed to zero
> + * the now inaccessible portion of the registers.
> + *
> + * The intent of this is that no predicate bit beyond VQ is ever set.
> + * Which means that some operations on predicate registers themselves
> + * may operate on full uint64_t or even unrolled across the maximum
> + * uint64_t[4].  Performing 4 bits of host arithmetic unconditionally
> + * may well be cheaper than conditionals to restrict the operation
> + * to the relevant portion of a uint16_t[16].
> + *
> + * TODO: Need to call this for changes to the real system registers
> + * and EL state changes.
> + */
> +void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
> +{
> +    int i, j;
> +    uint64_t pmask;
> +
> +    assert(vq >=3D 1 && vq <=3D ARM_MAX_VQ);
> +
> +    /* Zap the high bits of the zregs.  */
> +    for (i =3D 0; i < 32; i++) {
> +        memset(&env->vfp.zregs[i].d[2 * vq], 0, 16 * (ARM_MAX_VQ - vq));
> +    }
> +
> +    /* Zap the high bits of the pregs and ffr.  */
> +    pmask =3D 0;
> +    if (vq & 3) {
> +        pmask =3D ~(-1ULL << (16 * (vq & 3)));
> +    }

The kernel defines SVE_VQ_BYTES for clarity, perhaps we should do so to
here.

> +    for (j =3D vq / 4; j < ARM_MAX_VQ / 4; j++) {
> +        for (i =3D 0; i < 17; ++i) {
> +            env->vfp.pregs[i].p[j] &=3D pmask;
> +        }
> +        pmask =3D 0;
> +    }
> +}


--
Alex Benn=C3=A9e
