Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED8DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E6C20866
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3rVmKfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E6C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiO3p-0008OK-PJ
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 14:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiO2e-0007BJ-Nm
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiO2d-0004u0-0K
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:34:28 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiO2X-0004oo-Ng
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:34:22 -0500
Received: by mail-wm1-x343.google.com with SMTP id b19so10048112wmj.4
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 11:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1+Fyrpgyn4o483aZF85BFApQbLRX1uVVQknzm60k+lk=;
 b=L3rVmKfBPRZEoEs4gwi36KL2n+Owd4m+vgF6hXISz5HKGYS5eAdDL0vwyXLQMJRLvz
 t4ykgkyqP9A2p979yKus4YnkjkkAchq/X8RboHwV3K8rRc59qsvWo/bNKxhxlSw3kpOj
 V0yW8FkiclsyGhUWP5U1UdK3WAnOjeiledXKwjNTr4HwtVE4Ynlx8h0ArPx/vAg4MJ7z
 NrPOsl+sq5vcOceC72/96A5vP712rBNtQKqyXGwsSKE0IUhrJM+wLZgrlBx673q6VW7b
 LZ9Q+b+uDrv/jpHYRF4RSW+StWyoXdc3zQTrLPOtQ1Lv1AveMNwKtNvSeMLvkGpzYPoj
 xs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1+Fyrpgyn4o483aZF85BFApQbLRX1uVVQknzm60k+lk=;
 b=MMzTWnVAiGyseZKg4BxInaRLj8GxTf6/GJL42E8biFcUf6nLN7lb3Rz3Eh83paafG9
 OBHAxVQmxZmhy6+amvlP3qNMQuNTI9+0eojyrTN2gx3oCKtAp+QmsVxVxV8Mv/ErWh0k
 agv0B/iaMXAyPVex1MsESh0mauXKU68N1CF/7V3+w+MkHKLZWQK+w1Izum2fnXjHlO3N
 zs+57lWQmjYRkhNaxxgO3jmzju818UCuBMJLeH13oQn/XUvAKnXIa/V0KWW0FPMVwYZE
 oS6hIoWjAZTBqrIDRkBvuZobRe+9ViNGlL+VItTq2j/YVIa3FITABw6jL8ihHtWcEJiy
 j88A==
X-Gm-Message-State: APjAAAV+QC5lArFLSUpX0LvElMkItklcB4vrBspH9ha8VLtXBgLaohRh
 E8Z+k1SGmTAHy2sOsHT1/2xq1cYr6Ac=
X-Google-Smtp-Source: APXvYqxcsmuGHLFQyvrPM3bGcL0Wxid5asQfCSAj6q7632ax9SUr0z/KZJBUClwQD0Q4yQCeBazSfg==
X-Received: by 2002:a1c:8086:: with SMTP id b128mr18305165wmd.80.1576870458024; 
 Fri, 20 Dec 2019 11:34:18 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m21sm10241381wmi.27.2019.12.20.11.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 11:34:16 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 479F71FF87;
 Fri, 20 Dec 2019 19:34:16 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-24-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 23/28] target/m68k: Use cpu_*_mmuidx_ra instead of
 MMU_MODE{0, 1}_SUFFIX
In-reply-to: <20191216221158.29572-24-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 19:34:16 +0000
Message-ID: <87eewybxl3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The generated *_user functions are unused.  The *_kernel functions
> have a couple of users in op_helper.c; use *_mmuidx_ra instead,
> with MMU_KERNEL_IDX.
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
> v2: Use *_mmuidx_ra directly, without intermediate macros.
> ---
>  target/m68k/cpu.h       |  2 --
>  target/m68k/op_helper.c | 77 +++++++++++++++++++++++++----------------
>  2 files changed, 47 insertions(+), 32 deletions(-)
>
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 20de3c379a..89af14e899 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -516,8 +516,6 @@ enum {
>  #define cpu_list m68k_cpu_list
>=20=20
>  /* MMU modes definitions */
> -#define MMU_MODE0_SUFFIX _kernel
> -#define MMU_MODE1_SUFFIX _user
>  #define MMU_KERNEL_IDX 0
>  #define MMU_USER_IDX 1
>  static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index bc4f845e3f..202498deb5 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -42,8 +42,8 @@ static void cf_rte(CPUM68KState *env)
>      uint32_t fmt;
>=20=20
>      sp =3D env->aregs[7];
> -    fmt =3D cpu_ldl_kernel(env, sp);
> -    env->pc =3D cpu_ldl_kernel(env, sp + 4);
> +    fmt =3D cpu_ldl_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
> +    env->pc =3D cpu_ldl_mmuidx_ra(env, sp + 4, MMU_KERNEL_IDX, 0);
>      sp |=3D (fmt >> 28) & 3;
>      env->aregs[7] =3D sp + 8;
>=20=20
> @@ -58,13 +58,13 @@ static void m68k_rte(CPUM68KState *env)
>=20=20
>      sp =3D env->aregs[7];
>  throwaway:
> -    sr =3D cpu_lduw_kernel(env, sp);
> +    sr =3D cpu_lduw_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
>      sp +=3D 2;
> -    env->pc =3D cpu_ldl_kernel(env, sp);
> +    env->pc =3D cpu_ldl_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
>      sp +=3D 4;
>      if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
>          /*  all except 68000 */
> -        fmt =3D cpu_lduw_kernel(env, sp);
> +        fmt =3D cpu_lduw_mmuidx_ra(env, sp, MMU_KERNEL_IDX, 0);
>          sp +=3D 2;
>          switch (fmt >> 12) {
>          case 0:
> @@ -260,12 +260,12 @@ static void cf_interrupt_all(CPUM68KState *env, int=
 is_hw)
>      /* ??? This could cause MMU faults.  */
>      sp &=3D ~3;
>      sp -=3D 4;
> -    cpu_stl_kernel(env, sp, retaddr);
> +    cpu_stl_mmuidx_ra(env, sp, retaddr, MMU_KERNEL_IDX, 0);
>      sp -=3D 4;
> -    cpu_stl_kernel(env, sp, fmt);
> +    cpu_stl_mmuidx_ra(env, sp, fmt, MMU_KERNEL_IDX, 0);
>      env->aregs[7] =3D sp;
>      /* Jump to vector.  */
> -    env->pc =3D cpu_ldl_kernel(env, env->vbr + vector);
> +    env->pc =3D cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX=
, 0);
>  }
>=20=20
>  static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
> @@ -278,23 +278,24 @@ static inline void do_stack_frame(CPUM68KState *env=
, uint32_t *sp,
>          switch (format) {
>          case 4:
>              *sp -=3D 4;
> -            cpu_stl_kernel(env, *sp, env->pc);
> +            cpu_stl_mmuidx_ra(env, *sp, env->pc, MMU_KERNEL_IDX, 0);
>              *sp -=3D 4;
> -            cpu_stl_kernel(env, *sp, addr);
> +            cpu_stl_mmuidx_ra(env, *sp, addr, MMU_KERNEL_IDX, 0);
>              break;
>          case 3:
>          case 2:
>              *sp -=3D 4;
> -            cpu_stl_kernel(env, *sp, addr);
> +            cpu_stl_mmuidx_ra(env, *sp, addr, MMU_KERNEL_IDX, 0);
>              break;
>          }
>          *sp -=3D 2;
> -        cpu_stw_kernel(env, *sp, (format << 12) + (cs->exception_index <=
< 2));
> +        cpu_stw_mmuidx_ra(env, *sp, (format << 12) + (cs->exception_inde=
x << 2),
> +                          MMU_KERNEL_IDX, 0);
>      }
>      *sp -=3D 4;
> -    cpu_stl_kernel(env, *sp, retaddr);
> +    cpu_stl_mmuidx_ra(env, *sp, retaddr, MMU_KERNEL_IDX, 0);
>      *sp -=3D 2;
> -    cpu_stw_kernel(env, *sp, sr);
> +    cpu_stw_mmuidx_ra(env, *sp, sr, MMU_KERNEL_IDX, 0);
>  }
>=20=20
>  static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
> @@ -353,36 +354,52 @@ static void m68k_interrupt_all(CPUM68KState *env, i=
nt is_hw)
>              cpu_abort(cs, "DOUBLE MMU FAULT\n");
>          }
>          env->mmu.fault =3D true;
> +        /* push data 3 */
>          sp -=3D 4;
> -        cpu_stl_kernel(env, sp, 0); /* push data 3 */
> +        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        /* push data 2 */
>          sp -=3D 4;
> -        cpu_stl_kernel(env, sp, 0); /* push data 2 */
> +        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        /* push data 1 */
>          sp -=3D 4;
> -        cpu_stl_kernel(env, sp, 0); /* push data 1 */
> +        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        /* write back 1 / push data 0 */
>          sp -=3D 4;
> -        cpu_stl_kernel(env, sp, 0); /* write back 1 / push data 0 */
> +        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        /* write back 1 address */
>          sp -=3D 4;
> -        cpu_stl_kernel(env, sp, 0); /* write back 1 address */
> +        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        /* write back 2 data */
>          sp -=3D 4;
> -        cpu_stl_kernel(env, sp, 0); /* write back 2 data */
> +        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        /* write back 2 address */
>          sp -=3D 4;
> -        cpu_stl_kernel(env, sp, 0); /* write back 2 address */
> +        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        /* write back 3 data */
>          sp -=3D 4;
> -        cpu_stl_kernel(env, sp, 0); /* write back 3 data */
> +        cpu_stl_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        /* write back 3 address */
>          sp -=3D 4;
> -        cpu_stl_kernel(env, sp, env->mmu.ar); /* write back 3 address */
> +        cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> +        /* fault address */
>          sp -=3D 4;
> -        cpu_stl_kernel(env, sp, env->mmu.ar); /* fault address */
> +        cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> +        /* write back 1 status */
>          sp -=3D 2;
> -        cpu_stw_kernel(env, sp, 0); /* write back 1 status */
> +        cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        /* write back 2 status */
>          sp -=3D 2;
> -        cpu_stw_kernel(env, sp, 0); /* write back 2 status */
> +        cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        /* write back 3 status */
>          sp -=3D 2;
> -        cpu_stw_kernel(env, sp, 0); /* write back 3 status */
> +        cpu_stw_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> +        /* special status word */
>          sp -=3D 2;
> -        cpu_stw_kernel(env, sp, env->mmu.ssw); /* special status word */
> +        cpu_stw_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX, 0);
> +        /* effective address */
>          sp -=3D 4;
> -        cpu_stl_kernel(env, sp, env->mmu.ar); /* effective address */
> +        cpu_stl_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> +
>          do_stack_frame(env, &sp, 7, oldsr, 0, retaddr);
>          env->mmu.fault =3D false;
>          if (qemu_loglevel_mask(CPU_LOG_INT)) {
> @@ -414,7 +431,7 @@ static void m68k_interrupt_all(CPUM68KState *env, int=
 is_hw)
>=20=20
>      env->aregs[7] =3D sp;
>      /* Jump to vector.  */
> -    env->pc =3D cpu_ldl_kernel(env, env->vbr + vector);
> +    env->pc =3D cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX=
, 0);
>  }
>=20=20
>  static void do_interrupt_all(CPUM68KState *env, int is_hw)


--=20
Alex Benn=C3=A9e

