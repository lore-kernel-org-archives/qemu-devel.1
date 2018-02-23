Received: from eggs.gnu.org ([2001:4830:134:3::10]:51225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epGiC-0002vX-Vj
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epGi9-0004Pc-Os
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:00:45 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epGi9-0004OJ-Gc
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:00:41 -0500
Received: by mail-wm0-x243.google.com with SMTP id x7so3516083wmc.0
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:00:41 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180217182323.25885-2-richard.henderson@linaro.org>
Date: Fri, 23 Feb 2018 17:00:38 +0000
Message-ID: <877er3abex.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 01/67] target/arm: Enable SVE
 for aarch64-linux-user
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

> Enable ARM_FEATURE_SVE for the generic "any" cpu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c   | 7 +++++++
>  target/arm/cpu64.c | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 1b3ae62db6..10843994c3 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -150,6 +150,13 @@ static void arm_cpu_reset(CPUState *s)
>          env->cp15.sctlr_el[1] |=3D SCTLR_UCT | SCTLR_UCI | SCTLR_DZE;
>          /* and to the FP/Neon instructions */
>          env->cp15.cpacr_el1 =3D deposit64(env->cp15.cpacr_el1, 20, 2, 3);
> +        /* and to the SVE instructions */
> +        env->cp15.cpacr_el1 =3D deposit64(env->cp15.cpacr_el1, 16, 2, 3);
> +        env->cp15.cptr_el[3] |=3D CPTR_EZ;
> +        /* with maximum vector length */
> +        env->vfp.zcr_el[1] =3D ARM_MAX_VQ - 1;
> +        env->vfp.zcr_el[2] =3D ARM_MAX_VQ - 1;
> +        env->vfp.zcr_el[3] =3D ARM_MAX_VQ - 1;
>  #else

I notice this is linux-user only but what happens if you specify a
specific CPU in linux-user mode, do we still end up running SVE specific
initialisation?

It seems to me that we should be seeing feature guarded reset stuff in here.

>          /* Reset into the highest available EL */
>          if (arm_feature(env, ARM_FEATURE_EL3)) {
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index efc519b49b..36ef9e9d9d 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -231,6 +231,7 @@ static void aarch64_any_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
>      set_feature(&cpu->env, ARM_FEATURE_CRC);
>      set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
> +    set_feature(&cpu->env, ARM_FEATURE_SVE);
>      cpu->ctr =3D 0x80038003; /* 32 byte I and D cacheline size, VIPT ica=
che */
>      cpu->dcz_blocksize =3D 7; /*  512 bytes */
>  }


--
Alex Benn=C3=A9e
