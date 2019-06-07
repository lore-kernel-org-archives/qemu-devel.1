Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFD2C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C0320684
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnJWy/4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C0320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50992 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZEfW-0005Pa-4Z
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59808)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZEbl-0001sz-TR
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZEbj-0005rH-Ta
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:08:37 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZEbj-0005kf-OS
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:08:35 -0400
Received: by mail-ot1-x341.google.com with SMTP id b7so1740766otl.11
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2qhxN0j+xO3lc84ZYBjXCiQz9G1pupLf4Ynwz1mbak4=;
 b=UnJWy/4ejfPADeYBhmSV0XpxJNytKBuMhf/gg428v3/wIIq5ge1P3tlJZPue2xy6ky
 8+Iqp2/gitKB8jAjWTHr9ehU3dMb1xLLdxgYpJlaCIf0KjBvT4D+cYBQzQAJcIenZloj
 5GVaQUKRBWtF4gkei6haVcZbh+eSn4ztevGBylizfyrfjFlP/xw8xRGbIdHsQzpZj2FU
 y8LbIE0Lisclruvtl3VAjhENwTArKX87eCP3GYzJqP7dhYLmSwTbL432sJL5gkzPpJNd
 OnM2/7/LdaLxA25Fi0zNCDyqvhPnLZchUV0sCt53wCSYCIYm7UqBX3zxseUu/zkecBmI
 eEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2qhxN0j+xO3lc84ZYBjXCiQz9G1pupLf4Ynwz1mbak4=;
 b=DhGKCgcV7BXWjDd65KVMWnAsViDAjq3SzwR3mU4phf/yuyxxBr0AlzzOfvPeHnLkok
 yevx43+tc8WQhw4K4GkU56yu6Qh2f6xltMYpReGXUnbzRt0mUoFP6uhFnytSc+JoWi0M
 NAcXfUFN+trQAmhZb9BF4IflxZf26Hm2rVFBO038DaicPmn+2ZBx9QmGCm6vTF22Sxln
 SlicAL/kYRjWhCDTdnxMzXxXnNwtXxDHY/IQXYY2VWj619qnutPPysfzpzNStavUxbA+
 9BfZlbDdERmg/54maRnuqa9PsEQUFndCo+5BxZdLJdMXrFh5FemwEtDdxHVM5wkB/kUE
 NGEg==
X-Gm-Message-State: APjAAAUxyOYz1rp8HMjbzaKN9N6ZghGtD8h8ZPXOTphCBuAnKTESkvsh
 hhGpyyxr8yn6OUbnRJ/16gq97yTlNHk4+OMuFs4hbg==
X-Google-Smtp-Source: APXvYqwEhHxVCLzpOU7x9AV6Agz13NJjiql8thz8Op4cw0cdF8F5sakr6hofGup1WgjBwl3pyZTES6cnHvLERz5IgQM=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr19619591otk.232.1559912913469; 
 Fri, 07 Jun 2019 06:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190524124248.28394-1-peter.maydell@linaro.org>
 <20190524124248.28394-3-peter.maydell@linaro.org>
In-Reply-To: <20190524124248.28394-3-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 14:08:22 +0100
Message-ID: <CAFEAcA9bBNov=qUEtgkBdhAyj1E=sPALKpJcYyEkSmFO7VgHDg@mail.gmail.com>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/intc/arm_gicv3:
 GICD_TYPER.SecurityExtn is RAZ if GICD_CTLR.DS == 1
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for code review, please?

thanks
-- PMM

On Fri, 24 May 2019 at 13:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The GICv3 specification says that the GICD_TYPER.SecurityExtn bit
> is RAZ if GICD_CTLR.DS is 1. We were incorrectly making it RAZ
> if the security extension is unsupported. "Security extension
> unsupported" always implies GICD_CTLR.DS == 1, but the guest can
> also set DS on a GIC which does support the security extension.
> Fix the condition to correctly check the GICD_CTLR.DS bit.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv3_dist.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
> index e6fe4905fd3..b65f56f9035 100644
> --- a/hw/intc/arm_gicv3_dist.c
> +++ b/hw/intc/arm_gicv3_dist.c
> @@ -378,8 +378,14 @@ static MemTxResult gicd_readl(GICv3State *s, hwaddr offset,
>           * ITLinesNumber == (num external irqs / 32) - 1
>           */
>          int itlinesnumber = ((s->num_irq - GIC_INTERNAL) / 32) - 1;
> +        /*
> +         * SecurityExtn must be RAZ if GICD_CTLR.DS == 1, and
> +         * "security extensions not supported" always implies DS == 1,
> +         * so we only need to check the DS bit.
> +         */
> +        bool sec_extn = !(s->gicd_ctlr & GICD_CTLR_DS);
>
> -        *data = (1 << 25) | (1 << 24) | (s->security_extn << 10) |
> +        *data = (1 << 25) | (1 << 24) | (sec_extn << 10) |
>              (0xf << 19) | itlinesnumber;
>          return MEMTX_OK;
>      }
> --
> 2.20.1
>

