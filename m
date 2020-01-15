Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A82C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 09:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C239207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 09:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ayE9Bfj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C239207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irfSK-0003C8-EP
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 04:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irfRg-0002m9-Oe
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irfRf-0003cD-CC
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:58:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irfRf-0003bg-5L
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:58:39 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so15104646wru.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 01:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=B9cCs+msjmd0vPajl06xvCb0m9cS797xc5LzpfvsdZI=;
 b=ayE9Bfj2SpJt0YfU4QM8i2VWCmxL2V/hPMui1vGYLlI+k54tSVt4yxCpBH+dHXza2Z
 5Uf4UGJP/So+rPsoT8AniOLce4AHBRFmswhbPK8p2n5H2vlk+2nZnGEErwBUmnsdQx94
 G5icepd8R4csClu2QC3GolHTnS2XRIqMzJhMywg94SZoVdotRbZ0No/eibGj+KRlZJJp
 psKtmTIVqm2dUZ/JhVShTZrKwdbvxtOL1CuG38kZQIsnNJwH0lnf9ojg2pKE5oVA+/OS
 TWo2BSAtGbBUljRskMD4rbXvAaAgnAoy+pBUlB0iCfhz5Av1fRZcklbOOq+JI1TlRFax
 2n9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=B9cCs+msjmd0vPajl06xvCb0m9cS797xc5LzpfvsdZI=;
 b=BnicSWY+p2v7izoSoF28KcQpQkq8yc7egmYyiWvegQJfUpRxLDEXmPMe6eYe93V+lj
 87G7dOD4NArXGyRWiMKjPOkYJy78jP/0Ys4+AuNC3GYQcsYO8fAi8ZACV2GqCrCNbBrH
 q1rpVuTDxiWh0P5DJhWHiNaE4kphNRLy90LO5UB35QtM1BWVLFdRARUR3mEYr5GGWro+
 R/E5ZKXWjIQ64CPyi/Wv/YTij1OKAheQ/hWmOLrINLM6Kcxe/tBYLpI99rB4Vhggp+j4
 LymvMAjVvWQ9GqRbIIqmEj3tZOFpwNI/S76Z0/6gpYD9K9r+u6VLbAzmu2qdUyBMz/nw
 dVQQ==
X-Gm-Message-State: APjAAAUYsSkutrtQtlwdRpEEyzdFMrleGClqgyUn1jhJc2SMk/15qA+R
 kD6wOCAaDx6aZSqH8ZOCb92ZxQ==
X-Google-Smtp-Source: APXvYqz6ZTzcgaXRlMCzhXgRn5ATmoguJkIfxiYnneFKjZkWYQOPp84LGNZj7PH1515eofy9PVtRgg==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr10868804wrn.140.1579082317881; 
 Wed, 15 Jan 2020 01:58:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b67sm23800482wmc.38.2020.01.15.01.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 01:58:36 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ECEF51FF87;
 Wed, 15 Jan 2020 09:58:35 +0000 (GMT)
References: <20200114210921.11216-1-richard.henderson@linaro.org>
 <20200114210921.11216-3-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/3] linux-user/i386: Split out gen_signal
In-reply-to: <20200114210921.11216-3-richard.henderson@linaro.org>
Date: Wed, 15 Jan 2020 09:58:35 +0000
Message-ID: <8736chm46s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, riku.voipio@iki.fi,
 laurent@vivier.eu, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This is a bit tidier than open-coding the 5 lines necessary
> to initialize the target_siginfo_t.  In addition, this zeros
> the remaining bytes of the target_siginfo_t, rather than
> passing in garbage.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  linux-user/i386/cpu_loop.c | 93 ++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 60 deletions(-)
>
> diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
> index 024b6f4d58..e217cca5ee 100644
> --- a/linux-user/i386/cpu_loop.c
> +++ b/linux-user/i386/cpu_loop.c
> @@ -81,13 +81,23 @@ static void set_idt(int n, unsigned int dpl)
>  }
>  #endif
>=20=20
> +static void gen_signal(CPUX86State *env, int sig, int code, abi_ptr addr)
> +{
> +    target_siginfo_t info =3D {
> +        .si_signo =3D sig,
> +        .si_code =3D code,
> +        ._sifields._sigfault._addr =3D addr
> +    };
> +
> +    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +}
> +
>  void cpu_loop(CPUX86State *env)
>  {
>      CPUState *cs =3D env_cpu(env);
>      int trapnr;
>      abi_ulong pc;
>      abi_ulong ret;
> -    target_siginfo_t info;
>=20=20
>      for(;;) {
>          cpu_exec_start(cs);
> @@ -134,70 +144,45 @@ void cpu_loop(CPUX86State *env)
>  #endif
>          case EXCP0B_NOSEG:
>          case EXCP0C_STACK:
> -            info.si_signo =3D TARGET_SIGBUS;
> -            info.si_errno =3D 0;
> -            info.si_code =3D TARGET_SI_KERNEL;
> -            info._sifields._sigfault._addr =3D 0;
> -            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +            gen_signal(env, TARGET_SIGBUS, TARGET_SI_KERNEL, 0);
>              break;
>          case EXCP0D_GPF:
>              /* XXX: potential problem if ABI32 */
>  #ifndef TARGET_X86_64
>              if (env->eflags & VM_MASK) {
>                  handle_vm86_fault(env);
> -            } else
> -#endif
> -            {
> -                info.si_signo =3D TARGET_SIGSEGV;
> -                info.si_errno =3D 0;
> -                info.si_code =3D TARGET_SI_KERNEL;
> -                info._sifields._sigfault._addr =3D 0;
> -                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +                break;
>              }
> +#endif
> +            gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
>              break;
>          case EXCP0E_PAGE:
> -            info.si_signo =3D TARGET_SIGSEGV;
> -            info.si_errno =3D 0;
> -            if (!(env->error_code & 1))
> -                info.si_code =3D TARGET_SEGV_MAPERR;
> -            else
> -                info.si_code =3D TARGET_SEGV_ACCERR;
> -            info._sifields._sigfault._addr =3D env->cr[2];
> -            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +            gen_signal(env, TARGET_SIGSEGV,
> +                       (env->error_code & 1 ?
> +                        TARGET_SEGV_ACCERR : TARGET_SEGV_MAPERR),
> +                       env->cr[2]);
>              break;
>          case EXCP00_DIVZ:
>  #ifndef TARGET_X86_64
>              if (env->eflags & VM_MASK) {
>                  handle_vm86_trap(env, trapnr);
> -            } else
> -#endif
> -            {
> -                /* division by zero */
> -                info.si_signo =3D TARGET_SIGFPE;
> -                info.si_errno =3D 0;
> -                info.si_code =3D TARGET_FPE_INTDIV;
> -                info._sifields._sigfault._addr =3D env->eip;
> -                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +                break;
>              }
> +#endif
> +            gen_signal(env, TARGET_SIGFPE, TARGET_FPE_INTDIV, env->eip);
>              break;
>          case EXCP01_DB:
>          case EXCP03_INT3:
>  #ifndef TARGET_X86_64
>              if (env->eflags & VM_MASK) {
>                  handle_vm86_trap(env, trapnr);
> -            } else
> +                break;
> +            }
>  #endif
> -            {
> -                info.si_signo =3D TARGET_SIGTRAP;
> -                info.si_errno =3D 0;
> -                if (trapnr =3D=3D EXCP01_DB) {
> -                    info.si_code =3D TARGET_TRAP_BRKPT;
> -                    info._sifields._sigfault._addr =3D env->eip;
> -                } else {
> -                    info.si_code =3D TARGET_SI_KERNEL;
> -                    info._sifields._sigfault._addr =3D 0;
> -                }
> -                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +            if (trapnr =3D=3D EXCP01_DB) {
> +                gen_signal(env, TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->=
eip);
> +            } else {
> +                gen_signal(env, TARGET_SIGTRAP, TARGET_SI_KERNEL, 0);
>              }
>              break;
>          case EXCP04_INTO:
> @@ -205,31 +190,19 @@ void cpu_loop(CPUX86State *env)
>  #ifndef TARGET_X86_64
>              if (env->eflags & VM_MASK) {
>                  handle_vm86_trap(env, trapnr);
> -            } else
> -#endif
> -            {
> -                info.si_signo =3D TARGET_SIGSEGV;
> -                info.si_errno =3D 0;
> -                info.si_code =3D TARGET_SI_KERNEL;
> -                info._sifields._sigfault._addr =3D 0;
> -                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +                break;
>              }
> +#endif
> +            gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
>              break;
>          case EXCP06_ILLOP:
> -            info.si_signo =3D TARGET_SIGILL;
> -            info.si_errno =3D 0;
> -            info.si_code =3D TARGET_ILL_ILLOPN;
> -            info._sifields._sigfault._addr =3D env->eip;
> -            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +            gen_signal(env, TARGET_SIGILL, TARGET_ILL_ILLOPN, env->eip);
>              break;
>          case EXCP_INTERRUPT:
>              /* just indicate that signals should be handled asap */
>              break;
>          case EXCP_DEBUG:
> -            info.si_signo =3D TARGET_SIGTRAP;
> -            info.si_errno =3D 0;
> -            info.si_code =3D TARGET_TRAP_BRKPT;
> -            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +            gen_signal(env, TARGET_SIGTRAP, TARGET_TRAP_BRKPT, 0);
>              break;
>          case EXCP_ATOMIC:
>              cpu_exec_step_atomic(cs);


--=20
Alex Benn=C3=A9e

