Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FD7C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A044216F4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELodW9gF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A044216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huf3L-0005nf-BP
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52627)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hueyj-0005Yf-Fk
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hueyi-00026m-CK
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:32:53 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hueyi-00024w-56
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:32:52 -0400
Received: by mail-ot1-x344.google.com with SMTP id r6so85658584oti.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C47760llTQhFiFECzG/hHMnHdPDdskoYWYgyfiJ9SNM=;
 b=ELodW9gFZU3d712pkkQwovv6skxckzqUERsy3MSAOaAJrbDYPfaxQWw9gCutEzdQp0
 GuWFu5Nuj+Hr52U7blOubmIhP5LmlsGnLJZ8Qiw+HgQLTBvpksDKTFr73sFXY5fKtqSg
 KhRasCfxXjvqe/xfjkdO45GKFxdlDPvFoy6Zd3/O6hA7PDzFgBt28M+qP98HxMVBdp44
 MHaCmcf4ElqgOYe61hN9B16WImxxv0LK7z2j+U6nIxCHNefUtMTi/Fm+5J2bmUergS0L
 e5FUhAb8geCIhJAJZB0GqJ9ttX/8po2YRZ6JI+VTIFjTQChMSlBTXeiYDVejN2TLaKB8
 LEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C47760llTQhFiFECzG/hHMnHdPDdskoYWYgyfiJ9SNM=;
 b=UWNSlcEiHtET11tQcQEMljdKWFfChm5KzhDEjeHzx1Xm1nnygvoKHuVU3MYJ2VgnLM
 FUAbZpC23nQMWVVrLvK5jK7Z2DOBRnAFOK3oMVC3KGq9dhdBEEoYN7XL7OVST4Twwjg4
 Z1gk2XQ1pBdBJBXq+KaKc8sEOvj1KPKi1A26SQD1fSdycbQ/R2ti5MeN3bdNDKvmuTup
 slbXzjb8Krxcbb3RnVaSBbrHjpTT1yHNjx6GbfY5ugrgLztqdj1G79PkEVzu7Min/N0n
 2woG1zi3gR28VOaAsdKchCd9CBBheIu2Gtx/xJxRG6DdLTmIyyXuIZ7PX9fwcF1LVUYj
 Qxsw==
X-Gm-Message-State: APjAAAU1rM95T6+HZ+ue/laVfNHVyZ2PXC3GxcF2hS8MBEcDvq74mt9U
 z1mvVjDJSvrkfd4wasrPEAfEArW1zHzw6Gm8lAsy8g==
X-Google-Smtp-Source: APXvYqxpL3y8rk+3NLBRz1ZXsAHKP9hcAHXNkakja1PYpbiDeND35UT9w4AGe+7eJEf+qdnJSzG0R2eC83BfuIPvzac=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr55921980oti.91.1565019171245; 
 Mon, 05 Aug 2019 08:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-15-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Aug 2019 16:32:40 +0100
Message-ID: <CAFEAcA8OC+Rru_qHU+1gQqmzmTY_8F+gtqZ5TyWoQAf60gUD1g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 14/67] target/arm: Convert multiply and
 multiply accumulate
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 18:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 214 ++++++++++++++++++++++++-----------------
>  target/arm/a32.decode  |  17 ++++
>  target/arm/t32.decode  |  19 ++++
>  3 files changed, 163 insertions(+), 87 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index ee7d53dfa5..354a52d36c 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7376,21 +7376,6 @@ static void gen_storeq_reg(DisasContext *s, int rlow, int rhigh, TCGv_i64 val)
>      store_reg(s, rhigh, tmp);
>  }
>
> -/* load a 32-bit value from a register and perform a 64-bit accumulate.  */
> -static void gen_addq_lo(DisasContext *s, TCGv_i64 val, int rlow)
> -{
> -    TCGv_i64 tmp;
> -    TCGv_i32 tmp2;
> -
> -    /* Load value and extend to 64 bits.  */
> -    tmp = tcg_temp_new_i64();
> -    tmp2 = load_reg(s, rlow);
> -    tcg_gen_extu_i32_i64(tmp, tmp2);
> -    tcg_temp_free_i32(tmp2);
> -    tcg_gen_add_i64(val, val, tmp);
> -    tcg_temp_free_i64(tmp);
> -}
> -

> +static bool trans_UMAAL(DisasContext *s, arg_UMAAL *a)
> +{
> +    TCGv_i32 t0, t1, t2, zero;
> +
> +    if (s->thumb
> +        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
> +        : !ENABLE_ARCH_6) {
> +        return false;
> +    }
> +
> +    t0 = load_reg(s, a->rm);
> +    t1 = load_reg(s, a->rn);
> +    tcg_gen_mulu2_i32(t0, t1, t0, t1);
> +    zero = tcg_const_i32(0);
> +    t2 = load_reg(s, a->ra);
> +    tcg_gen_add2_i32(t0, t1, t0, t1, t2, zero);
> +    tcg_temp_free_i32(t2);
> +    t2 = load_reg(s, a->rd);
> +    tcg_gen_add2_i32(t0, t1, t0, t1, t2, zero);
> +    tcg_temp_free_i32(t2);
> +    tcg_temp_free_i32(zero);
> +    store_reg(s, a->ra, t0);
> +    store_reg(s, a->rd, t1);
> +    return true;
> +

Is using mulu2/add2/add2 like this really generating better
code than the mulu_i64_i32 and 2 64-bit adds that we had before?
If we're going to change how we're generating code it would be
nice to at least mention it in the commit message...


> @@ -10292,13 +10337,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>                      }
>                  }
>                  if (op & 4) {
> -                    /* umaal */
> -                    if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
> -                        tcg_temp_free_i64(tmp64);
> -                        goto illegal_op;
> -                    }
> -                    gen_addq_lo(s, tmp64, rs);
> -                    gen_addq_lo(s, tmp64, rd);
> +                    /* umaal, in decodetree */
> +                    goto illegal_op;
>                  } else if (op & 0x40) {
>                      /* 64-bit accumulate.  */
>                      gen_addq(s, tmp64, rs, rd);

This doesn't seem to remove all of the Thumb insns we implement
in the decode tree from the legacy decoder.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

