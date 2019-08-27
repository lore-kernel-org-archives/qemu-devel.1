Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149E0C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D7A206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGWEMIXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D7A206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2e4F-0000LO-RS
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 12:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2e1y-0006rs-Ks
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2e1x-00041q-7n
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:09:14 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2e1x-00041M-3T
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:09:13 -0400
Received: by mail-ot1-x342.google.com with SMTP id e12so19176450otp.10
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WXplowyUpocu+OrbQx46F/GL5CgBCu++9nmAgG1PNWE=;
 b=MGWEMIXkG6mwbfOa6A6VEDYKZ1Co9c5ly89GCsLfE2crlWRLTBZ2Z38eeLDWufPUsb
 s0QYXX5qgS5rKUEjr+DH5p8RdNTpxmC1cEdZgIAkmwLrRfyNlN1SKq9pBgikmew8BAsG
 Mvbl66WmHIW83l6W8q5pATPY6gB2sItJmRopWi4xrDxlYLpK1/20aB6ltWFnc4V7b/9l
 CdJZJf++nCEA+2XJs6RwzuwrgAzDwvCHYol8SMItKfRm/RXJenyybnKhxCh5mZoD7zx6
 KVP0YnQvnArp8fYN22XpvaGxfYbGfkeVBWJlTZYepWKsoGTVG6MYj1Em3rMiuLpPmPS+
 P6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WXplowyUpocu+OrbQx46F/GL5CgBCu++9nmAgG1PNWE=;
 b=Y9RsuX4cSmD+rEw4ECFjwbsb6fNkEODC7uVrX97Pz14SbSCBLYx0nqvUhrps5s9Pke
 KN0iKkm1zbJeO3nfrAzZ4yM8OiM//tG0n/EMOE6vrQ2xfPZJQ/LBmX1kvb7+CJPizhDm
 cjgzlquC7iwtXWg3ND8cM/6pzcTxklAl79hsuGzMLcg2SYI7qc6eps3zrX/K5T6d9noV
 B9I8uZr1VgqJafA2KWqUis5ZQlc+7sM992ax2XgRd2mkVCTd5Vz36ZBnKDP5w+PjD2pz
 Dlo4f5jrWl6sSE3TezXvgI9S5auG2cQqtTBbmNUWZLMCcebnTm85voWr0k4usfqMM1NF
 ii/A==
X-Gm-Message-State: APjAAAV4HUxBB4q5uwEbwPnYpkTPEOw6Gqj50UaJinSAjMr2JS3zYOQq
 Q7SSbf7Jt6XP6acfKysWgZYZxfI6Jd5hdKAM3PLfUYgKu10=
X-Google-Smtp-Source: APXvYqwJUYfdNnLUekHX77BImwlIT3a8MTfhotVHHGbPzkJoF3Vdm0flfmuR20CRkLnnT9oyIR03Ieebjsa80N/tgdE=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr9698539oti.135.1566922151050; 
 Tue, 27 Aug 2019 09:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190809054341.24728-1-andrew@aj.id.au>
In-Reply-To: <20190809054341.24728-1-andrew@aj.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 17:08:59 +0100
Message-ID: <CAFEAcA9dEKLneH5GJJsX84LTW_p9qBrGmr6yMxAYcNo-2EzHZg@mail.gmail.com>
To: Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2] target-arm: Make the counter tick
 relative to cntfrq
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
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Aug 2019 at 06:43, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The use of GTIMER_SCALE assumes the clock feeding the generic timer is
> 62.5MHz for all platforms. This is untrue in general, for example the
> ASPEED AST2600 feeds the counter with either an 800 or 1200MHz clock,
> and CNTFRQ is configured appropriately by u-boot.
>
> To cope with these values we need to take care of the quantization
> caused by the clock scaling in terms of nanoseconds per clock by
> calculating an effective frequency such that NANOSECONDS_PER_SECOND is
> an integer multiple of the effective frequency. Failing to account for
> the quantisation leads to sticky behaviour in the VM as the guest timer
> subsystems account for the difference between delay time and the counter
> value.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> v2:
> 1. Removed the user-mode change that broke v1
> 2. Rearranged the implementation as a consequence of 1.
>
>  target/arm/helper.c | 51 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b74c23a9bc08..166a54daf278 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2277,6 +2277,34 @@ static const ARMCPRegInfo v6k_cp_reginfo[] = {
>
>  #ifndef CONFIG_USER_ONLY
>
> +static void gt_recalc_timer(ARMCPU *cpu, int timeridx);
> +static void gt_cntfrq_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                            uint64_t value)
> +{
> +    uint64_t scale;
> +    ARMCPU *cpu;
> +    int i;
> +
> +    raw_write(env, ri, value);
> +
> +    /* Fix up the timer scaling */
> +    cpu = env_archcpu(env);
> +    scale = MAX(1, NANOSECONDS_PER_SECOND / value);
> +    for (i = 0; i < NUM_GTIMERS; i++) {
> +        if (!cpu->gt_timer[i]) {
> +            continue;
> +        }
> +
> +        cpu->gt_timer[i]->scale = scale;

Reaching into the internals of a QEMUTimer and changing
the 'scale' value seems like a bad idea. If QEMUTimer doesn't
have a facility for changing the frequency and we need one
then we should add one at that API layer.

Also, this isn't how the hardware works, I'm pretty sure.
In hardware the timers tick at whatever frequency they're
set up to tick, and CNTFRQ is just a reads-as-written register
that firmware can fill in with an appropriate value that it's
determined from somewhere for the benefit of other software.

If on ASPEED SoCs the timer frequency is different, then we
should model that by having CPU properties for timer frequency
and having the SoC set those properties, I think.

> +        gt_recalc_timer(cpu, i);
> +    }
> +}

thanks
-- PMM

