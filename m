Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84806C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D91F21019
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eg6/hD2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D91F21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Cxe-0005WZ-EG
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1CvV-0004LC-Iu
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1CvU-0007HA-Bz
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:00:37 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1CvU-0007Gu-5x
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:00:36 -0400
Received: by mail-oi1-x241.google.com with SMTP id g128so7550877oib.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3wECWcWTBB75jo4+e2zcF8qaISQpSOHbaWaV2xm/QlQ=;
 b=eg6/hD2AtxS1XYMgIockhzsAtlBFgcsyRwesMJJC1Mx4TJdUm9lufJmtUzu6hBbAuQ
 cXHo/N/iRVKcT7y5L3/xEgvZgpi4pmWLJnc2xriDzSf612z63f7ZuR8bC7wq472reI6j
 OXDvB8g0Z0KlQ0U/Y4y3Rmw5iwn9K7+AW3nxJnded9JsWHjnFnxRnfQ50+/hYhLJKHXr
 Wd0dRIM/TxPoLZjCAlRjg95aaj93Ce1J2Iog5FFAgpxEBXjSvhQarklN0mmYzUk7/VSM
 lI1I0d8OnqJs1QGQAdb15gy4t9CfT4MyWMPuYUvyFDBypm2W+EjjXFObzSTbI2pti+Rx
 BKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3wECWcWTBB75jo4+e2zcF8qaISQpSOHbaWaV2xm/QlQ=;
 b=GGutMfIG37xYayPH2zm5tl8We60gVvCbihq3oHoqz2zxJ4Lst1faWA/xhm4fSf8s1a
 2/Ksr5yTHwS/D72T5TdPljEbcUa1r1A7uKS25kWxT6mKEcYHjA4ykYvPYiyFEzDziob/
 6DueAYguEgsMxTMx/R/EZITvhbqpJktvlyqXbDbneFCHl/+RECK8KrETixSfbTJBp4le
 5cS80+ghzB2ruQYaN0fRdRyoDpAsNR2dlodr4aTr6Z6PVQ2UEgKAuyzpCrydE8rgcFsb
 sqQJJO9lC3Lz64TdyOQgyUzzVI+AmfYhP4AKhLw78jtFfWYtE3U4Q+SRfxdofrZqghdf
 OXzw==
X-Gm-Message-State: APjAAAVDtQc39F6jZJYvemwq07HuGTLhBq2VUTS3xTcV41fUSyIav4s3
 4R3exXEw5KN8IwgFe/jDOrO+lY7cTK+vdudIRz2v5Q==
X-Google-Smtp-Source: APXvYqwZkEZ6QuK3m4ixices39zmR51vWaX4oa1w54MZDW8t5TW4FR8gEeOyR931lB8+WG7O779qWSpkAxyH0TGRm/M=
X-Received: by 2002:aca:50cb:: with SMTP id e194mr3667916oib.48.1566579635251; 
 Fri, 23 Aug 2019 10:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-26-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 18:00:24 +0100
Message-ID: <CAFEAcA-gsP30Be2wZi-UeUUjond05A3HuFKN3znz60WmPPnCxA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2 25/68] target/arm: Convert Signed
 multiply, signed and unsigned divide
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 463 ++++++++++++++++++-----------------------
>  target/arm/a32.decode  |  22 ++
>  target/arm/t32.decode  |  18 ++
>  3 files changed, 247 insertions(+), 256 deletions(-)
>

> +static bool op_smmla(DisasContext *s, arg_rrrr *a, bool round, bool sub)
> +{
> +    TCGv_i32 t1, t2;
> +
> +    if (s->thumb
> +        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
> +        : !ENABLE_ARCH_6) {
> +        return false;
> +    }
> +
> +    t1 = load_reg(s, a->rn);
> +    t2 = load_reg(s, a->rm);
> +    tcg_gen_muls2_i32(t2, t1, t1, t2);
> +
> +    if (a->ra != 15) {
> +        TCGv_i32 t3 = load_reg(s, a->ra);
> +        if (sub) {
> +            tcg_gen_sub_i32(t1, t1, t3);
> +        } else {
> +            tcg_gen_add_i32(t1, t1, t3);
> +        }
> +        tcg_temp_free_i32(t3);
> +    }
> +    if (round) {
> +        tcg_gen_shri_i32(t2, t2, 31);
> +        tcg_gen_add_i32(t1, t1, t2);

Can we keep the comment the old decoder had for this case?


> +    }
> +    tcg_temp_free_i32(t2);
> +    store_reg(s, a->rd, t1);
> +    return true;
> +}
> +

This one:

> -                if (insn & (1 << 4)) {
> -                    /*
> -                     * Adding 0x80000000 to the 64-bit quantity
> -                     * means that we have carry in to the high
> -                     * word when the low word has the high bit set.
> -                     */
> -                    tcg_gen_shri_i32(tmp2, tmp2, 31);
> -                    tcg_gen_add_i32(tmp, tmp, tmp2);
> -                }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

