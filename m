Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7538EC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CEF320673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="usPKIRpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEF320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJzq1-0002fm-BO
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 08:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iJzpI-00026z-JY
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iJzpH-0000dX-H4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:51:52 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iJzpH-0000d3-Be
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:51:51 -0400
Received: by mail-ot1-x343.google.com with SMTP id k32so13674590otc.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 05:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gJCveQWwdmN+Z1ZK4WHcVke3NOyYamcJHyo0B2XOHio=;
 b=usPKIRpwGoPFE0NEVD4aezC2K3/qJwuUN1/H53Qa8lklS5RenDcaZpqnhWH3gkB/oy
 iY8Kr2TWTo05Dw+Zz+GKsj6i6YJ1g+PD/deZAPLRb67hpTnZqX133wR1k9FcQGRp0bS8
 jDcOuiS/FeMALdz0jR333B8yCO60HgB3PHg/9GcOzph0sEGDhFOzrWdKSMZs3+OpIdtG
 JGcuPvm1Jn6F83kHtlYWcnm0wH9TRbMtJusmhuKNPxhNkfeJppWNWur0q6nlKsCaBAOu
 DtXpXIAfzKpwUVW+Z16MNlTfLm1bYNkVtVU7DU9UtsRiNvfXvkmC8tlkUvATkcn7Flx1
 ObaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gJCveQWwdmN+Z1ZK4WHcVke3NOyYamcJHyo0B2XOHio=;
 b=Gzh/1lzVqfoojdGyAHriJ0+/05vcrSp7Hy4VpxYja5XIoyl5nlYe0V5B3ouMow8DP9
 8tGEf8g1jYDQBOCgbAdIrUmdHX/98+yA4SNeeKcD//21jg5sInwOxFVb4vTGKg6pXEIG
 EKfudpLp1EiuCPnEo3x/hFDHy6gw0MB5MYh+Oy1WiaMVUmxO7qZm8N00o3lzhr1wt1Zp
 WCUANaj8YndKPLd/vwO/mDmiyKV/SPtYIyv2Pf2azniswYc5/sFzTvMn2oWB8Dx6el0Q
 0qR1UjA8FYDkgABU/GGJU3DtTmVc+/oZ2SF62GwbvViucJksJWWD0bpL0TAELoYLyEXe
 5T8Q==
X-Gm-Message-State: APjAAAWWsUD/wRnQnd35Hxk4S8jhJn4KfTAZGYAjXHnM3ZIKBWA3cyMZ
 nQ5KjFr4g/x0DPulYKApV5sB6AYv1jsFhQ4/88abtw==
X-Google-Smtp-Source: APXvYqzXAQ065tAIbhfbcMcegTS4RRUEJhy7Cqa0Ns9B6BTdp4fo3gAuKlS25kVO0zh6F+IlKjPaT3GZl9cVgHEsXng=
X-Received: by 2002:a05:6830:ca:: with SMTP id
 x10mr22928697oto.221.1571057510375; 
 Mon, 14 Oct 2019 05:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191004025509.3012-1-david@gibson.dropbear.id.au>
In-Reply-To: <20191004025509.3012-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 13:51:39 +0100
Message-ID: <CAFEAcA9soWUfyfvV5Onyy0wP842Gq698_sZ+E1xGwkmnrLHnJg@mail.gmail.com>
Subject: Re: [PATCH] exynos4210_gic: Suppress gcc9 format-truncation warnings
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Oct 2019 at 04:10, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> exynos4210_gic_realize() prints the number of cpus into some temporary
> buffers, but it only allows 3 bytes space for it.  That's plenty - I'm
> pretty sure that existing machines will only ever set this value to 2
> (EXYNOS4210_NCPUS).  But the compiler can't really be expected to figure
> that out.
>
> Some[*] gcc9 versions therefore emit -Wformat-truncation warnings.  Fix
> that by allowing more space in the temporary buffers - these are on stack
> very briefly before being essentially strdup()ed inside the memory region
> code, so there's not much cost to doing so.
>
> [*] The bizarre thing here, is that I've long gotten these warnings
> compiling in a 32-bit x86 container as host - Fedora 30 with
> gcc-9.2.1-1.fc30.i686 - but it compiles just fine on my normal x86_64 host
> - Fedora 30 with and gcc-9.2.1-1.fc30.x86_64.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/intc/exynos4210_gic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
> index a1b699b6ba..2e5e47f9ec 100644
> --- a/hw/intc/exynos4210_gic.c
> +++ b/hw/intc/exynos4210_gic.c
> @@ -290,8 +290,8 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>      const char cpu_prefix[] = "exynos4210-gic-alias_cpu";
>      const char dist_prefix[] = "exynos4210-gic-alias_dist";
> -    char cpu_alias_name[sizeof(cpu_prefix) + 3];
> -    char dist_alias_name[sizeof(cpu_prefix) + 3];
> +    char cpu_alias_name[sizeof(cpu_prefix) + 10];
> +    char dist_alias_name[sizeof(cpu_prefix) + 10];
>      SysBusDevice *gicbusdev;
>      uint32_t i;

If we assert() that num_cpu is always <= EXYNOS4210_NCPUS
is that sufficient to clue gcc in that the buffer can't overflow?

thanks
-- PMM

