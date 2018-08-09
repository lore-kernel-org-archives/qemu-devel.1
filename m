Received: from eggs.gnu.org ([2001:4830:134:3::10]:46060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnify-0007gU-NZ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnifs-0007RF-KB
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:00:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fnifs-0007Qf-AH
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:00:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id h9-v6so4785791wro.3
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 04:00:12 -0700 (PDT)
References: <20180809034033.10579-1-richard.henderson@linaro.org>
	<20180809034033.10579-12-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180809034033.10579-12-richard.henderson@linaro.org>
Date: Thu, 09 Aug 2018 12:00:09 +0100
Message-ID: <87ftznpzye.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/11] target/arm: Add sve-max-vq cpu
 property to -cpu max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-stable@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> This allows the default (and maximum) vector length to be set
> from the command-line.  Which is extraordinarily helpful in
> debuging problems depending on vector length without having to
> bake knowledge of PR_SET_SVE_VL into every guest binary.
>
> Cc: qemu-stable@nongnu.org (3.0.1)
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  target/arm/cpu.h     |  3 +++
>  linux-user/syscall.c | 19 +++++++++++++------
>  target/arm/cpu.c     |  6 +++---
>  target/arm/cpu64.c   | 29 +++++++++++++++++++++++++++++
>  target/arm/helper.c  |  7 +++++--
>  5 files changed, 53 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e310ffc29d..9526ed27cb 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -857,6 +857,9 @@ struct ARMCPU {
>
>      /* Used to synchronize KVM and QEMU in-kernel device levels */
>      uint8_t device_irq_level;
> +
> +    /* Used to set the maximum vector length the cpu will support.  */
> +    uint32_t sve_max_vq;
>  };
>
>  static inline ARMCPU *arm_env_get_cpu(CPUARMState *env)
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index dfc851cc35..5a4af76c03 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -10848,15 +10848,22 @@ abi_long do_syscall(void *cpu_env, int num, abi=
_long arg1,
>  #endif
>  #ifdef TARGET_AARCH64
>          case TARGET_PR_SVE_SET_VL:
> -            /* We cannot support either PR_SVE_SET_VL_ONEXEC
> -               or PR_SVE_VL_INHERIT.  Therefore, anything above
> -               ARM_MAX_VQ results in EINVAL.  */
> +            /*
> +             * We cannot support either PR_SVE_SET_VL_ONEXEC or
> +             * PR_SVE_VL_INHERIT.  Note the kernel definition
> +             * of sve_vl_valid allows for VQ=3D512, i.e. VL=3D8192,
> +             * even though the current architectural maximum is VQ=3D16.
> +             */
>              ret =3D -TARGET_EINVAL;
>              if (arm_feature(cpu_env, ARM_FEATURE_SVE)
> -                && arg2 >=3D 0 && arg2 <=3D ARM_MAX_VQ * 16 && !(arg2 & =
15)) {
> +                && arg2 >=3D 0 && arg2 <=3D 512 * 16 && !(arg2 & 15)) {
>                  CPUARMState *env =3D cpu_env;
> -                int old_vq =3D (env->vfp.zcr_el[1] & 0xf) + 1;
> -                int vq =3D MAX(arg2 / 16, 1);
> +                ARMCPU *cpu =3D arm_env_get_cpu(env);
> +                uint32_t vq, old_vq;
> +
> +                old_vq =3D (env->vfp.zcr_el[1] & 0xf) + 1;
> +                vq =3D MAX(arg2 / 16, 1);
> +                vq =3D MIN(vq, cpu->sve_max_vq);
>
>                  if (vq < old_vq) {
>                      aarch64_sve_narrow_vq(env, vq);
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 64a8005a4b..b25898ed4c 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -168,9 +168,9 @@ static void arm_cpu_reset(CPUState *s)
>          env->cp15.cpacr_el1 =3D deposit64(env->cp15.cpacr_el1, 16, 2, 3);
>          env->cp15.cptr_el[3] |=3D CPTR_EZ;
>          /* with maximum vector length */
> -        env->vfp.zcr_el[1] =3D ARM_MAX_VQ - 1;
> -        env->vfp.zcr_el[2] =3D ARM_MAX_VQ - 1;
> -        env->vfp.zcr_el[3] =3D ARM_MAX_VQ - 1;
> +        env->vfp.zcr_el[1] =3D cpu->sve_max_vq - 1;
> +        env->vfp.zcr_el[2] =3D env->vfp.zcr_el[1];
> +        env->vfp.zcr_el[3] =3D env->vfp.zcr_el[1];
>  #else
>          /* Reset into the highest available EL */
>          if (arm_feature(env, ARM_FEATURE_EL3)) {
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index d0581d59d8..800bff780e 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -29,6 +29,7 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/kvm.h"
>  #include "kvm_arm.h"
> +#include "qapi/visitor.h"
>
>  static inline void set_feature(CPUARMState *env, int feature)
>  {
> @@ -217,6 +218,29 @@ static void aarch64_a53_initfn(Object *obj)
>      define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
>  }
>
> +static void cpu_max_get_sve_vq(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(obj);
> +    visit_type_uint32(v, name, &cpu->sve_max_vq, errp);
> +}
> +
> +static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(obj);
> +    Error *err =3D NULL;
> +
> +    visit_type_uint32(v, name, &cpu->sve_max_vq, &err);
> +
> +    if (!err && (cpu->sve_max_vq =3D=3D 0 || cpu->sve_max_vq > ARM_MAX_V=
Q)) {
> +        error_setg(&err, "unsupported SVE vector length");
> +        error_append_hint(&err, "Valid sve-max-vq in range [1-%d]\n",
> +                          ARM_MAX_VQ);
> +    }
> +    error_propagate(errp, err);
> +}
> +
>  /* -cpu max: if KVM is enabled, like -cpu host (best possible with this =
host);
>   * otherwise, a CPU with as many features enabled as our emulation suppo=
rts.
>   * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
> @@ -253,6 +277,10 @@ static void aarch64_max_initfn(Object *obj)
>          cpu->ctr =3D 0x80038003; /* 32 byte I and D cacheline size, VIPT=
 icache */
>          cpu->dcz_blocksize =3D 7; /*  512 bytes */
>  #endif
> +
> +        cpu->sve_max_vq =3D ARM_MAX_VQ;
> +        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve=
_vq,
> +                            cpu_max_set_sve_vq, NULL, NULL, &error_fatal=
);
>      }
>  }
>
> @@ -405,6 +433,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned=
 vq)
>      uint64_t pmask;
>
>      assert(vq >=3D 1 && vq <=3D ARM_MAX_VQ);
> +    assert(vq <=3D arm_env_get_cpu(env)->sve_max_vq);
>
>      /* Zap the high bits of the zregs.  */
>      for (i =3D 0; i < 32; i++) {
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 66afb08ee0..c24c66d43e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -12408,9 +12408,12 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targ=
et_ulong *pc,
>              zcr_len =3D 0;
>          } else {
>              int current_el =3D arm_current_el(env);
> +            ARMCPU *cpu =3D arm_env_get_cpu(env);
>
> -            zcr_len =3D env->vfp.zcr_el[current_el <=3D 1 ? 1 : current_=
el];
> -            zcr_len &=3D 0xf;
> +            zcr_len =3D cpu->sve_max_vq - 1;
> +            if (current_el <=3D 1) {
> +                zcr_len =3D MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el=
[1]);
> +            }
>              if (current_el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
>                  zcr_len =3D MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el=
[2]);
>              }


--
Alex Benn=C3=A9e
