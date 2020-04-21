Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6114C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A182D206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxnMnN27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A182D206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQpHQ-0001fH-Mb
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jQpGA-0000d0-3H
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jQpG9-0004HN-Mp
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:32:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jQpG7-00044K-TP; Tue, 21 Apr 2020 05:32:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id b11so15634645wrs.6;
 Tue, 21 Apr 2020 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tM2HtUby3bIsD7k5c7KsJzsRHUn3HdC9wyJ4JHdhygM=;
 b=LxnMnN27VzdA3CEZwF6F28UH+Y40Qt3JdzAnLBakLVq5O13kUyZPn/fVjzJ6LxFJ3/
 MCA240W2FRnt9BWMGbpXjP/nvlB/lGSepvGEzSFya4p9cVLItosNerjQ1BuJUB+y0LMo
 Wgov0EE/bmQmWCTKfNe90rEWbSiOoEGYNQl2TrTaWuTMGH9CT4GNvzaVJLPxYmoly/Pa
 UxOAxuimAa/tpgdjlXl0Ef97f22jDh/cvTROBYVVB5qfeDGGvnJCUM7FaBnlc42IJPi5
 lmCQNcSOfvotiiPgXvUYqBi7Rg/Sh9bmxD5PxoE7UOzyTgkGAjTQ2ZckBPWNr5wutsjD
 y5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tM2HtUby3bIsD7k5c7KsJzsRHUn3HdC9wyJ4JHdhygM=;
 b=etGy8IYCs2Cd2oMf1cn1caUvxM9Aq7v/Uf+u6YZz5rqxj1zckAildwlLg3NVDS75J1
 8C1rmFGM7fTBpz7DL1iLAx7sXKAmtBA9XHh4zG7tulkPUGG8VE9SHGWl2m424VBdP6Dk
 Uk5TJeUwiFlHHDVMOVYBEtSbdaAQ5m6jVpcfuJK70xtRq+KehLKbunxSUSHmLv31v+Vx
 NjVMmSDT+TBRr0rSA2K+KTOk+Oti9pZbYMys2siPFRlsZVd1243Ca80EN7mwrSIukJBE
 Wi/qjrEdaoPySWRfdeYu665w4Ir7gLEApqAA8VKjCq+eQFx2UUR4By6Xz7fqeCfmvPTF
 AQdQ==
X-Gm-Message-State: AGi0PubK7hRczmUnejPuYcnmQh2LFvYRewPUrQzLziocPu5qY2+jgb26
 GaK8ezjevfz1vJoiC8qiVB4Nj59JcUBkKuuBLRc=
X-Google-Smtp-Source: APiQypIyAHmiq/ST4ONwJvsXcJbz0Qc4tIWbHEnj+kol3au0zrzFKUXlDeEqhDcPu5g1h7acXyim+tpVJcdUrBd/khg=
X-Received: by 2002:a5d:4843:: with SMTP id n3mr22717151wrs.7.1587461521640;
 Tue, 21 Apr 2020 02:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200420212206.12776-1-peter.maydell@linaro.org>
 <20200420212206.12776-4-peter.maydell@linaro.org>
In-Reply-To: <20200420212206.12776-4-peter.maydell@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 21 Apr 2020 11:31:44 +0200
Message-ID: <CAHiYmc6zqMve7J2nMqRD=nZXLMaVN+8kYB7_LtAf_4BNYu+Wug@mail.gmail.com>
Subject: Re: [PATCH 3/4] linux-user/arm: Handle invalid arm-specific syscalls
 correctly
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: omerg681@gmail.com, qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=BE=D0=BD, 20. =D0=B0=D0=BF=D1=80 2020. =D1=83 23:25 Peter Maydell=
 <peter.maydell@linaro.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> The kernel has different handling for syscalls with invalid
> numbers that are in the "arm-specific" range 0x9f0000 and up:
>  * 0x9f0000..0x9f07ff return -ENOSYS if not implemented
>  * other out of range syscalls cause a SIGILL
> (see the kernel's arch/arm/kernel/traps.c:arm_syscall())
>
> Implement this distinction. (Note that our code doesn't look
> quite like the kernel's, because we have removed the
> 0x900000 prefix by this point, whereas the kernel retains
> it in arm_syscall().)
>

Hmm, I suspect other targets could have a similar problem.

I am definitely going to take a look at the mips target, but did
you Peter have a chance to take a more global look whether
this problem is actually widespread?

Regards,
Aleksandar


> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/arm/cpu_loop.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index 025887d6b86..f042108b0be 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -332,10 +332,32 @@ void cpu_loop(CPUARMState *env)
>                              env->regs[0] =3D cpu_get_tls(env);
>                              break;
>                          default:
> -                            qemu_log_mask(LOG_UNIMP,
> -                                          "qemu: Unsupported ARM syscall=
: 0x%x\n",
> -                                          n);
> -                            env->regs[0] =3D -TARGET_ENOSYS;
> +                            if (n < 0xf0800) {
> +                                /*
> +                                 * Syscalls 0xf0000..0xf07ff (or 0x9f000=
0..
> +                                 * 0x9f07ff in OABI numbering) are defin=
ed
> +                                 * to return -ENOSYS rather than raising
> +                                 * SIGILL. Note that we have already
> +                                 * removed the 0x900000 prefix.
> +                                 */
> +                                qemu_log_mask(LOG_UNIMP,
> +                                    "qemu: Unsupported ARM syscall: 0x%x=
\n",
> +                                              n);
> +                                env->regs[0] =3D -TARGET_ENOSYS;
> +                            } else {
> +                                /* Otherwise SIGILL */
> +                                info.si_signo =3D TARGET_SIGILL;
> +                                info.si_errno =3D 0;
> +                                info.si_code =3D TARGET_ILL_ILLTRP;
> +                                info._sifields._sigfault._addr =3D env->=
regs[15];
> +                                if (env->thumb) {
> +                                    info._sifields._sigfault._addr -=3D =
2;
> +                                } else {
> +                                    info._sifields._sigfault._addr -=3D =
2;
> +                                }
> +                                queue_signal(env, info.si_signo,
> +                                             QEMU_SI_FAULT, &info);
> +                            }
>                              break;
>                          }
>                      } else {
> --
> 2.20.1
>
>

