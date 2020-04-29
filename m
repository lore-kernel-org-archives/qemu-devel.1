Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D267C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4972072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpnGuceE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4972072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTg43-000111-Al
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jTg24-0007fk-EA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jTg23-00066a-Qn
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:17:20 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:44570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jTg23-00066D-Dg; Wed, 29 Apr 2020 02:17:19 -0400
Received: by mail-il1-x141.google.com with SMTP id s10so1288801iln.11;
 Tue, 28 Apr 2020 23:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iSIbzNzDUoU2tb+jAkvnU1+YMosV9gs5oQXAMlCd7EU=;
 b=rpnGuceESD1r1pGomRxn30x7zVyMDexrwTnuxxqPP45hS5Y8J1mN0eEi30T68/fWGX
 RP3l8NYRH16MD464hV69j2XKmJaR9/+kVKHvqbfc57PRfRhrWGXlQT+p1IDIWd8rmfCn
 Hi9b9a+dw26GYu9VGBq2l+PsaBY+UgFNm1Rt27Yi1btwuU0sWGVBHb4h3xo3ZrBFIwBE
 hhbcFYLgYu2HnrHzQDwrdZMw2L+yUfuy/CeeRmYXZDnLDLDfOm/EBeF5GWrcSjFYusVs
 9f48xi9Os6mB3Qm06y7KBOi+EofBnmlq1W94kvnc52IYcppKMYiHv86c6eBGk9Oj9fIu
 g8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iSIbzNzDUoU2tb+jAkvnU1+YMosV9gs5oQXAMlCd7EU=;
 b=JezPMPsQJEHUw7/YTIcsMhAeKcVwQgSej7kRSWWKBiLMbHlBMi6Tz12VlSjXWF/P0M
 XE7e/lxe8KbqQ8ooFFoYW0Y1aQBlyFZLdrF0ZX9FT7OgleXPYCnOo5G8s6qfkwNLtElo
 ZnPZq4KYBVHo38ar5HRkTJGWWhLA/JgqRy6UKiqj0M62+uyyJx3KSpeUYL/Xswn/A7gK
 /ibf5kUKgGYH3gd+DDbkRVPVzm/Paiy6XV3GVWaa3Dymy79xLP+v6GQily6NbBm0xFMD
 SWtZSn+YkMeAn0rOOZeYiKIy0ak8wwTXvJUrHnFVHiWjYaQ0ePVnN/diYhobbr8/bSMy
 Utgw==
X-Gm-Message-State: AGi0PubtUFpvxPLPmHxCX1F35LgUJLsj2nC/LyeZ47S+4Jz6qIaPzWA9
 Eiztmx/oaUWxcUyaCNpmCrRuxfvfjlKb5T0mM68RVDtZvfY=
X-Google-Smtp-Source: APiQypJVT6ml1Z8yKbB7GcGmsnmAxuaLW7dpC6iNXx4doII6zACkBbZTk5GuEzCuvyT1u5r22/bM3VjQbFpGtVVYh6s=
X-Received: by 2002:a92:3dca:: with SMTP id k71mr11134521ilf.22.1588141037809; 
 Tue, 28 Apr 2020 23:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200428172634.29707-1-f4bug@amsat.org>
In-Reply-To: <20200428172634.29707-1-f4bug@amsat.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Wed, 29 Apr 2020 08:17:06 +0200
Message-ID: <CABoDooMniYBAJPCkSjBwgRAQNpt_7P6PwnpoZKrdHBaEQQ0mGw@mail.gmail.com>
Subject: Re: [PATCH v3] target/arm: Use correct variable for setting 'max'
 cpu's MIDR_EL1
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=laurent.desnogues@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 28, 2020 at 7:26 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> MIDR_EL1 a 64-bit system register with the top 32-bit being RES0.
>
> This fixes when compiling with -Werror=3Dconversion:
>
>   target/arm/cpu64.c: In function =E2=80=98aarch64_max_initfn=E2=80=99:
>   target/arm/cpu64.c:628:21: error: conversion from =E2=80=98uint64_t=E2=
=80=99 {aka =E2=80=98long unsigned int=E2=80=99} to =E2=80=98uint32_t=E2=80=
=99 {aka =E2=80=98unsigned int=E2=80=99} may change value [-Werror=3Dconver=
sion]
>     628 |         cpu->midr =3D t;
>         |                     ^
>
> Suggested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
> Since v2: Do not use RESERVED bits.
> Since v1: Follow Laurent and Peter suggestion.
> ---
>  target/arm/cpu.h | 2 +-
>  target/arm/cpu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8b9f2961ba..592fb217d6 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -894,7 +894,7 @@ struct ARMCPU {
>          uint64_t id_aa64dfr0;
>          uint64_t id_aa64dfr1;
>      } isar;
> -    uint32_t midr;
> +    uint64_t midr;
>      uint32_t revidr;
>      uint32_t reset_fpsid;
>      uint32_t ctr;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index a79f233b17..7ff80894b6 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2757,7 +2757,7 @@ static const ARMCPUInfo arm_cpus[] =3D {
>  static Property arm_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("start-powered-off", ARMCPU, start_powered_off, fal=
se),
>      DEFINE_PROP_UINT32("psci-conduit", ARMCPU, psci_conduit, 0),
> -    DEFINE_PROP_UINT32("midr", ARMCPU, midr, 0),
> +    DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
>      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
>                          mp_affinity, ARM64_AFFINITY_INVALID),
>      DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID=
),
> --
> 2.21.1
>

