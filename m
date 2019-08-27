Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2734C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 11:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EDE8206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 11:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xT84hsEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDE8206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ZMh-0002yZ-M6
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 07:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2ZLq-0002Tk-Ra
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2ZLp-00058R-MK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:09:26 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45947)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2ZLp-00057v-H3
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:09:25 -0400
Received: by mail-ot1-x344.google.com with SMTP id m24so18238561otp.12
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 04:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LeMzQgNf/OFH4Ox57veRSB6RlgcFp3uG3eThzkArQn8=;
 b=xT84hsEb5XIdgmOW4p5PKCcmJQEieSEmHF3ysMCR/hbpS3+DxlgwgKJsP04d1Z7+ww
 BBS+td7Vcxe7VnoijkR/MyEQfrU0OC3W4JiknRFwPAGIkQ2RLgFtK9cdFgTiKEfByaOm
 zReulYfllRCrUShAoVmH7BxrcElQGEYNNfIfBjOJYFVq4F6YiAHVJIWpYgB40mONtnfu
 tgx4pLHZg9Fu3yAzIEvC2L6CmOIzxHLdzGZtGMj4vQRlmkV031LZhtHl/TUVMstsU/nI
 HeyICR1imQrEEkeABvdmMClO7Vw8euRtZv/tH6qCMXFDgmx+1wvb2YaghB4O+lzJHmlr
 qWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LeMzQgNf/OFH4Ox57veRSB6RlgcFp3uG3eThzkArQn8=;
 b=IXOdfTSyDustEyWRd6/qjV+nS5MGKHxok0qv5wX68BzWvWId/Y4/e7SCGGVhFXz64x
 TCqRsVGbDekzegAsxcp3JigWx2dPy4Absk3FD0JUelUsV4FVOMc6ogaJmOYUeZX0aWcp
 d2uV7oIjKJsG7KvLC9f0LuV1qBgMhM7VJ0JvKD3XARtA0c4Sfn9epO34Um9m8ET0TEKl
 uPm7chfS546nTsUr+nh2tLp442KcGsbP7JpToIRkJEv9cSz4wmLwF11xGCU3nUbtwTm/
 UZIbM4GatxFCtPtF94xQLvCSqT9U06Bpi5Q8nIC0Q6Pnb4OAxNiRwFxLBeYfeQQeoh71
 ly6w==
X-Gm-Message-State: APjAAAUs2O2AnI/+Zcq+s4voEUZidb7kNfIzpp54XBXrZb6MjYB+KloX
 4JNObcfHXehj5Znx5bOrfKx1WzeOiHRn2qzUFZuk/Q==
X-Google-Smtp-Source: APXvYqz7Cf2WiaKQpTXAFzBynEFPDge1IRVZreOouTdd3DurZjbiOit8ldP5kTyv6xOhkBIXwLxgrtXMLcv/KU6yS9s=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr1164705otf.97.1566904164697; 
 Tue, 27 Aug 2019 04:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-42-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-42-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 12:09:13 +0100
Message-ID: <CAFEAcA-D0+mv7P0_56_vLzWOeFPPan79LpFpg+=R-KhCkf2TJQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 41/68] target/arm: Convert TT
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
>  target/arm/translate.c | 87 +++++++++++++-----------------------------
>  target/arm/t32.decode  |  5 ++-
>  2 files changed, 31 insertions(+), 61 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 9a8864e8ff..d1078ca1ec 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8454,6 +8454,30 @@ static bool trans_SG(DisasContext *s, arg_SG *a)
>      return true;
>  }
>
> +static bool trans_TT(DisasContext *s, arg_TT *a)
> +{
> +    TCGv_i32 addr, tmp;
> +
> +    if (!arm_dc_feature(s, ARM_FEATURE_M) ||
> +        !arm_dc_feature(s, ARM_FEATURE_V8)) {
> +        return false;
> +    }
> +    if (a->rd == 13 || a->rd == 15 || a->rn == 15) {
> +        /* We UNDEF for these UNPREDICTABLE cases */
> +        return false;
> +    }
> +    if (a->A && !s->v8m_secure) {
> +        return false;
> +    }
> +
> +    addr = load_reg(s, a->rn);
> +    tmp = tcg_const_i32((a->A << 1) | a->T);
> +    gen_helper_v7m_tt(tmp, cpu_env, addr, tmp);
> +    tcg_temp_free_i32(addr);
> +    store_reg(s, a->rd, tmp);
> +    return true;
> +}

> diff --git a/target/arm/t32.decode b/target/arm/t32.decode
> index ce46650446..bb875f77b0 100644
> --- a/target/arm/t32.decode
> +++ b/target/arm/t32.decode
> @@ -506,7 +506,10 @@ STRD_ri_t32      1110 1001 .110 .... .... .... ........    @ldstd_ri8 w=1 p=1
>  @ldrex_d         .... .... .... rn:4 rt:4 rt2:4 .... .... \
>                   &ldrex imm=0
>
> -STREX            1110 1000 0100 .... .... .... .... ....      @strex_i
> +{
> +  TT             1110 1000 0100 rn:4 1111 rd:4 A:1 T:1 000000
> +  STREX          1110 1000 0100 .... .... .... .... ....      @strex_i
> +}

This patch turns out to have a bug -- there are cases in
trans_TT which are supposed to UNDEF. We return 'false' in
those cases, which means we fall through to trans_STREX(),
which doesn't have any checks in it to make them actually
UNDEF, so we end up generating code for some kind of STREX.
(Interestingly, I wrote the notes in the other email I
sent earlier about returning false vs unallocated_encoding+true
before I found and diagnosed the cause of this bug.)

thanks
-- PMM

