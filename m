Received: from eggs.gnu.org ([2001:4830:134:3::10]:39190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gIYcV-0003jZ-7M
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gIYcR-0002CB-Uu
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:32:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gIYcR-0002Bu-HU
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:32:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id f1-v6so1159746wmg.1
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 05:32:07 -0700 (PDT)
References: <20181102102025.3546-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181102102025.3546-1-richard.henderson@linaro.org>
Date: Fri, 02 Nov 2018 12:32:04 +0000
Message-ID: <87muqr64or.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Conditionalize some asserts
 on aarch32 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> When populating id registers from kvm, on a host that doesn't support
> aarch32 mode at all, neither arm_div nor jazelle will be supported either.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> v2: Test aa64pfr.el0 >=3D 2; rename to isar_feature_aa64_aa32.
>     Pull out realizefn test to no_aa32 bool; use it for jazelle as well.
>
> Alex, can you give this a test please?

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
>
> r~
>
> ---
>  target/arm/cpu.h |  5 +++++
>  target/arm/cpu.c | 15 +++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 895f9909d8..5c2c77c31d 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3300,6 +3300,11 @@ static inline bool isar_feature_aa64_fp16(const AR=
MISARegisters *id)
>      return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) =3D=3D 1;
>  }
>
> +static inline bool isar_feature_aa64_aa32(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL0) >=3D 2;
> +}
> +
>  static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
>  {
>      return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) !=3D 0;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index e08a2d2d79..d4dc0bc225 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -774,6 +774,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error=
 **errp)
>      CPUARMState *env =3D &cpu->env;
>      int pagebits;
>      Error *local_err =3D NULL;
> +    bool no_aa32 =3D false;
>
>      /* If we needed to query the host kernel for the CPU features
>       * then it's possible that might have failed in the initfn, but
> @@ -820,6 +821,16 @@ static void arm_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
>              set_feature(env, ARM_FEATURE_V7VE);
>          }
>      }
> +
> +    /*
> +     * There exist AArch64 cpus without AArch32 support.  When KVM
> +     * queries ID_ISAR0_EL1 on such a host, the value is UNKNOWN.
> +     * Similarly, we cannot check ID_AA64PFR0 without AArch64 support.
> +     */
> +    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> +        no_aa32 =3D !cpu_isar_feature(aa64_aa32, cpu);
> +    }
> +
>      if (arm_feature(env, ARM_FEATURE_V7VE)) {
>          /* v7 Virtualization Extensions. In real hardware this implies
>           * EL2 and also the presence of the Security Extensions.
> @@ -829,7 +840,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error=
 **errp)
>           * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
>           * Security Extensions is ARM_FEATURE_EL3.
>           */
> -        assert(cpu_isar_feature(arm_div, cpu));
> +        assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
>          set_feature(env, ARM_FEATURE_LPAE);
>          set_feature(env, ARM_FEATURE_V7);
>      }
> @@ -855,7 +866,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error=
 **errp)
>      if (arm_feature(env, ARM_FEATURE_V6)) {
>          set_feature(env, ARM_FEATURE_V5);
>          if (!arm_feature(env, ARM_FEATURE_M)) {
> -            assert(cpu_isar_feature(jazelle, cpu));
> +            assert(no_aa32 || cpu_isar_feature(jazelle, cpu));
>              set_feature(env, ARM_FEATURE_AUXCR);
>          }
>      }


--
Alex Benn=C3=A9e
