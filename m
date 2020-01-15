Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45076C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 07:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1222187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 07:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCoIOvjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1222187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ird1O-0003IX-62
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 02:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ird0O-0002lM-5w
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 02:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ird0J-0002Ew-7U
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 02:22:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49025
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ird0G-0002DG-G3
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 02:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579072931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5X1Ls7FkZQ5ZVQt/ZR6ozYcVbygQ1zdqYllxnpH8tw=;
 b=cCoIOvjvaD9aVr3/IVBjRjX4nSMHgY5z/4RFbwVbkxnFADXNuoXW1yzkvRaHW+b6dYkxtK
 jY+SKXWk6svjVRBB3KpmM8M68ZsIW8qwhJzEvp6v8W+CSD1sgUwREwXyui17u/K56eO971
 3vJEy9Ch0sXE74QmWwWgw+EiSSiYl0A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-0NTmplKfN0arFQOolyzIPA-1; Wed, 15 Jan 2020 02:22:09 -0500
Received: by mail-wr1-f69.google.com with SMTP id w6so7584697wrm.16
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 23:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iuNVXl5FVPjhSqeEWEu8uYVNO2CkZcZXOa9fdayKWHk=;
 b=dPBi6+670BbbRJhVZv1LCjhI8bvRi8MgjoAK6rXsomDi1IrJZzsUbVB7E1kedYKVct
 FAAM6gG49YSu0JNSQ858GAgyS49Vc6LjS4k09pgbqsLCelfC7lx0NXe+pGHiS2pcjdbh
 chMWltEjW9/nRqPaZ9YdC1OLnXygQHNKULHr/QAi5bhccPvmyVWV50Lc+1GbtQ/xX858
 rZVgyPhKY8fSKVLiIkLOC7G6Utd3PBV1pq8iwmisGeZ33VMxD5pUe7EO0fRW8tUBUEGd
 ZzaSMcOWYpTF5j7CBvAqAIBw9u1cOTvtrKZ23ehTTZvD3RzZgUV9vr+kJRoazg6QbJOc
 hbsQ==
X-Gm-Message-State: APjAAAVb8y7RGAx59qwsHPwhBexDHq2id4D5L18gsoeLI+54lhdxXJeF
 mJUfB9m5j/56TrAyadnqr32x3e3xVLOOa6kTizDUPac/RR2a5UXabqKQuftJ01ZXPBZuL+0qAqE
 g+bW3qK0PU3NJPl0=
X-Received: by 2002:a1c:740b:: with SMTP id p11mr33596706wmc.78.1579072928797; 
 Tue, 14 Jan 2020 23:22:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFWSf2Lz5VrSx5LDoaIKVScmAj0iil1oxYCsoAxu/2h9YaKnEOIx+V4nEldfPQvPmkkXMv3Q==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr33596683wmc.78.1579072928551; 
 Tue, 14 Jan 2020 23:22:08 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id i16sm23230821wmb.36.2020.01.14.23.22.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 23:22:08 -0800 (PST)
Subject: Re: [PATCH 2/3] linux-user/i386: Split out gen_signal
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200114210921.11216-1-richard.henderson@linaro.org>
 <20200114210921.11216-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fce9afbb-71ea-cf46-f14b-d4a3911fa4b5@redhat.com>
Date: Wed, 15 Jan 2020 08:22:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114210921.11216-3-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: 0NTmplKfN0arFQOolyzIPA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pbonzini@redhat.com, riku.voipio@iki.fi, laurent@vivier.eu,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 10:09 PM, Richard Henderson wrote:
> This is a bit tidier than open-coding the 5 lines necessary
> to initialize the target_siginfo_t.  In addition, this zeros
> the remaining bytes of the target_siginfo_t, rather than
> passing in garbage.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/i386/cpu_loop.c | 93 ++++++++++++++------------------------
>   1 file changed, 33 insertions(+), 60 deletions(-)
>=20
> diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
> index 024b6f4d58..e217cca5ee 100644
> --- a/linux-user/i386/cpu_loop.c
> +++ b/linux-user/i386/cpu_loop.c
> @@ -81,13 +81,23 @@ static void set_idt(int n, unsigned int dpl)
>   }
>   #endif
>  =20
> +static void gen_signal(CPUX86State *env, int sig, int code, abi_ptr addr=
)
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
>   void cpu_loop(CPUX86State *env)
>   {
>       CPUState *cs =3D env_cpu(env);
>       int trapnr;
>       abi_ulong pc;
>       abi_ulong ret;
> -    target_siginfo_t info;
>  =20
>       for(;;) {
>           cpu_exec_start(cs);
> @@ -134,70 +144,45 @@ void cpu_loop(CPUX86State *env)
>   #endif
>           case EXCP0B_NOSEG:
>           case EXCP0C_STACK:
> -            info.si_signo =3D TARGET_SIGBUS;
> -            info.si_errno =3D 0;
> -            info.si_code =3D TARGET_SI_KERNEL;
> -            info._sifields._sigfault._addr =3D 0;
> -            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +            gen_signal(env, TARGET_SIGBUS, TARGET_SI_KERNEL, 0);
>               break;
>           case EXCP0D_GPF:
>               /* XXX: potential problem if ABI32 */
>   #ifndef TARGET_X86_64
>               if (env->eflags & VM_MASK) {
>                   handle_vm86_fault(env);
> -            } else
> -#endif
> -            {
> -                info.si_signo =3D TARGET_SIGSEGV;
> -                info.si_errno =3D 0;
> -                info.si_code =3D TARGET_SI_KERNEL;
> -                info._sifields._sigfault._addr =3D 0;
> -                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +                break;
>               }
> +#endif
> +            gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
>               break;
>           case EXCP0E_PAGE:
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
>               break;
>           case EXCP00_DIVZ:
>   #ifndef TARGET_X86_64
>               if (env->eflags & VM_MASK) {
>                   handle_vm86_trap(env, trapnr);
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
>               }
> +#endif
> +            gen_signal(env, TARGET_SIGFPE, TARGET_FPE_INTDIV, env->eip);
>               break;
>           case EXCP01_DB:
>           case EXCP03_INT3:
>   #ifndef TARGET_X86_64
>               if (env->eflags & VM_MASK) {
>                   handle_vm86_trap(env, trapnr);
> -            } else
> +                break;
> +            }
>   #endif
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
>               }
>               break;
>           case EXCP04_INTO:
> @@ -205,31 +190,19 @@ void cpu_loop(CPUX86State *env)
>   #ifndef TARGET_X86_64
>               if (env->eflags & VM_MASK) {
>                   handle_vm86_trap(env, trapnr);
> -            } else
> -#endif
> -            {
> -                info.si_signo =3D TARGET_SIGSEGV;
> -                info.si_errno =3D 0;
> -                info.si_code =3D TARGET_SI_KERNEL;
> -                info._sifields._sigfault._addr =3D 0;
> -                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +                break;
>               }
> +#endif
> +            gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
>               break;
>           case EXCP06_ILLOP:
> -            info.si_signo =3D TARGET_SIGILL;
> -            info.si_errno =3D 0;
> -            info.si_code =3D TARGET_ILL_ILLOPN;
> -            info._sifields._sigfault._addr =3D env->eip;
> -            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +            gen_signal(env, TARGET_SIGILL, TARGET_ILL_ILLOPN, env->eip);
>               break;
>           case EXCP_INTERRUPT:
>               /* just indicate that signals should be handled asap */
>               break;
>           case EXCP_DEBUG:
> -            info.si_signo =3D TARGET_SIGTRAP;
> -            info.si_errno =3D 0;
> -            info.si_code =3D TARGET_TRAP_BRKPT;
> -            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +            gen_signal(env, TARGET_SIGTRAP, TARGET_TRAP_BRKPT, 0);
>               break;
>           case EXCP_ATOMIC:
>               cpu_exec_step_atomic(cs);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


