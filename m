Received: from eggs.gnu.org ([2001:4830:134:3::10]:39070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgagz-0003Zt-C1
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgagy-0004QM-94
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:27:05 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:36331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgagy-0004QD-3P
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:27:04 -0500
Received: by mail-wm0-x22f.google.com with SMTP id v77so4877454wmv.1
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 09:27:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170222162507.25987-1-alex.bennee@linaro.org>
References: <20170222162507.25987-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Feb 2017 17:26:42 +0000
Message-ID: <CAFEAcA8VQAE9_THkm45SS5YoO8cAnf60bCJ4iTaoH+6aL-Qo3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hmp: add PC information for ARM vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 22 February 2017 at 16:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  cpus.c           |  6 ++++++
>  hmp.c            |  3 +++
>  qapi-schema.json | 14 +++++++++++++-
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/cpus.c b/cpus.c
> index 559a0805bc..dc8dbfb0f0 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1869,6 +1869,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
>  #elif defined(TARGET_TRICORE)
>          TriCoreCPU *tricore_cpu =3D TRICORE_CPU(cpu);
>          CPUTriCoreState *env =3D &tricore_cpu->env;
> +#elif defined(TARGET_AARCH64)
> +        ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> +        CPUARMState *env =3D &arm_cpu->env;
>  #endif
>
>          cpu_synchronize_state(cpu);
> @@ -1896,6 +1899,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
>  #elif defined(TARGET_TRICORE)
>          info->value->arch =3D CPU_INFO_ARCH_TRICORE;
>          info->value->u.tricore.PC =3D env->PC;
> +#elif defined(TARGET_AARCH64)
> +        info->value->arch =3D CPU_INFO_ARCH_ARM;
> +        info->value->u.arm.pc =3D env->pc;
>  #else
>          info->value->arch =3D CPU_INFO_ARCH_OTHER;
>  #endif

My standard reaction when I see patches adding another
arm to a target-ifdef ladder like this is to ask whether
we can refactor this so that the target-specific
code lives in target/$ARCH instead...

thanks
-- PMM
