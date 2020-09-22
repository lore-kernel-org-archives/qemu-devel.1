Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F93C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE27207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYAZPFSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE27207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKgCC-00075s-5E
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKg0m-0003C5-4S
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:59:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKg0k-0002EL-7n
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:59:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id k18so2859246wmj.5
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=V4PKWGxdCikE2cEpazgaaZ5EWO+nPTPifEdAzFNQJ5A=;
 b=LYAZPFSKS/0nLyh53uTTIKWrh4kGivTrTjxLrOxIj85uc+WzhTRdz9G3BZLFjhpbFM
 gqkHuven8gxggcGQ5MEw9CNkmKPO+RVrtTM263t+p1e5fC0VsIFel84vP8fBHdjnJO2d
 pAYjmi9/i9lcSNj78vRLc4D14WSlGkR3pYZcrVZJ7wrkHhJqPWVekzwet2jV6gr+VWhu
 SY5rPS6K3eEsQKYbdp6h1KsnG+GyvuT0QKMg6E2YX07OzKOraMmcGw1CU1thgHbWQ3Nb
 w+SqxAkCTcdYnb1BettyKilI0ignmiERitAamTm/c1JIocJaN8fzaEYP6g7yuFwS4fsG
 +s8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=V4PKWGxdCikE2cEpazgaaZ5EWO+nPTPifEdAzFNQJ5A=;
 b=gyMBP/tSy4rdYpPWKweWeidDqU5l5nswgyWMxscsDxjAkChkOI5T2Q2rv9MNvzAM4R
 3E2GpFf6XL8bOXaWphdBuIluC7GQqR8UxxPEjxEHKRCLqwsqtS4hkNLSudRafbdIrg+Y
 nG7Ir3KwkDGvsPZqF1OUJmFdC7q1+zW0yaMVpJ0PHyrHzLOL98apZAmV6oADA/Fpu+Vk
 OHo66bembWYxKGRCmW3OdM55f0znIoIEWFpLdbA6sNwLWNELmWCOu8jT/Jo2nlfa5QG9
 rCGRzfB7RM/tG+C1pnBIbKvgY8JiKcC7D0H39vy3ESyQL8UOgB2AmYZQ4NQqwNBG2pX+
 fCgA==
X-Gm-Message-State: AOAM530UE4bHV2eH1YTXTW+bSpnfkkcCexcjbvNC5y4kC2pzx4Iomo+h
 55FgGEBlutG1bfR7jz7YgHUFEw==
X-Google-Smtp-Source: ABdhPJxA0GuoxGTh1b2PY+Yc2hMxPvm54GpX/9guuaOMO29eIhT8LeiaBmbNYGOq5mMRHAoVn8+YNA==
X-Received: by 2002:a05:600c:245:: with SMTP id 5mr379760wmj.33.1600772336805; 
 Tue, 22 Sep 2020 03:58:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l18sm25881200wrp.84.2020.09.22.03.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 03:58:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 147641FF7E;
 Tue, 22 Sep 2020 11:58:55 +0100 (BST)
References: <20200921174118.39352-1-richard.henderson@linaro.org>
 <20200921174118.39352-11-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 10/11] disas: Enable capstone disassembly for s390x
In-reply-to: <20200921174118.39352-11-richard.henderson@linaro.org>
Date: Tue, 22 Sep 2020 11:58:54 +0100
Message-ID: <87pn6em61d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Enable s390x, aka SYSZ, in the git submodule build.
> Set the capstone parameters for both s390x host and guest.
>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  disas.c            |  3 +++
>  target/s390x/cpu.c |  4 ++++
>  meson.build        | 11 +++++++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/disas.c b/disas.c
> index e27dea2c19..c4cd305190 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -201,6 +201,9 @@ static void initialize_debug_host(CPUDebug *s)
>      s->info.print_insn =3D print_insn_m68k;
>  #elif defined(__s390__)
>      s->info.print_insn =3D print_insn_s390;
> +    s->info.cap_arch =3D CS_ARCH_SYSZ;
> +    s->info.cap_insn_unit =3D 2;
> +    s->info.cap_insn_split =3D 6;
>  #elif defined(__hppa__)
>      s->info.print_insn =3D print_insn_hppa;
>  #endif
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 749cd548f0..2a96692691 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -44,6 +44,7 @@
>  #include "sysemu/tcg.h"
>  #endif
>  #include "fpu/softfloat-helpers.h"
> +#include "disas/capstone.h"
>=20=20
>  #define CR0_RESET       0xE0UL
>  #define CR14_RESET      0xC2000000UL;
> @@ -182,6 +183,9 @@ static void s390_cpu_disas_set_info(CPUState *cpu, di=
sassemble_info *info)
>  {
>      info->mach =3D bfd_mach_s390_64;
>      info->print_insn =3D print_insn_s390;
> +    info->cap_arch =3D CS_ARCH_SYSZ;
> +    info->cap_insn_unit =3D 2;
> +    info->cap_insn_split =3D 6;
>  }
>=20=20
>  static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
> diff --git a/meson.build b/meson.build
> index f06e3a1b65..d9f021837b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -670,6 +670,17 @@ if capstone_opt =3D=3D 'internal'
>      )
>    endif
>=20=20
> +  if 'CONFIG_S390_DIS' in config_all_disas
> +    capstone_data.set('CAPSTONE_HAS_SYSZ', '1')
> +    capstone_files +=3D files(
> +      'capstone/arch/SystemZ/SystemZDisassembler.c',
> +      'capstone/arch/SystemZ/SystemZInstPrinter.c',
> +      'capstone/arch/SystemZ/SystemZMapping.c',
> +      'capstone/arch/SystemZ/SystemZModule.c',
> +      'capstone/arch/SystemZ/SystemZMCTargetDesc.c'
> +    )
> +  endif
> +
>    if 'CONFIG_I386_DIS' in config_all_disas
>      capstone_data.set('CAPSTONE_HAS_X86', 1)
>      capstone_files +=3D files(


--=20
Alex Benn=C3=A9e

