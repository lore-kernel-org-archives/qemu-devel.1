Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDBEC4CEC7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92047214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fb6p11NP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92047214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8lMV-0000iY-NW
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8lEu-0002Ji-6s
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8lEp-00050c-BN
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:03:52 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34723)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8lEp-0004zv-5R
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:03:47 -0400
Received: by mail-ot1-x344.google.com with SMTP id z26so20087594oto.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=y1PYvy0144WUIYCXJJMTyvF8+rozDqGNJlGXaeIisEc=;
 b=fb6p11NPh5mWtzjQs2vBqmSP6KX9Hy1N/HimzQSQafwvfOUpkn7kCt8Gk7sC569B4P
 w6xZKaNq/4anuQCf0EbX0kZU++vFskl1HHjIfeiPEyV08KqV55edbXGJpl0L0EhfBQZG
 c7iBtQXJVe+U86HIPCZUtoOMtFxVu8xvcrrv0H1/VHEIaoX+5dxKaJPD6dNAh4ZbKYAv
 sWQZo7/3YopDVPWh6IjSyMgCPunBT8wwKAw69tfnmLvwmf8c47E6/LoTDN5efsqGvyI8
 SdYq3Ypgw7gUTnDenwePAPMrFKuWyP0yX2h53yu9Kx50YQ39cBBfcP21Q8Fot9zs1sT9
 yx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=y1PYvy0144WUIYCXJJMTyvF8+rozDqGNJlGXaeIisEc=;
 b=LOW2sJCAmP/9G8zcSE2y4x5xac/rzYr43BJuS+VjPQmaqtz1/U/e8sr2/ZcfPjpH6m
 ZqsByNe5iyJiZ3dyQW6d6tCPJMcDFe7nJZmOL4MpqGvzBd0Mzl6WH5+gzIfIndu6Z6Ox
 3jK3liepPb6U0kJNmCWIEHBrZ4LdXYtYzvCieDNVQDPxq7ab7RtT1XXKKdp/jx+6gC1E
 GsDXIubcU2Nk+d5bdjShufdlj8bf14nTVVQ5ZDS6Q9VL/68LqMEijr89DvTieUM6RsHp
 IyMbnK2iZq3X8N9F95UU7bop+qmXailWVY6nRNWq76mCSkK8jFc2C/euKQ5ORMUP3qTG
 DtWw==
X-Gm-Message-State: APjAAAW9WLqV2XKbMZjRsUqNM3JvNBtHF8ycFWoM4iJCj8bP1ubtPQ5Y
 I7CRqnbm+SQeq+h6XFx0amJs8c0bQNmZKS2OQCYuEA==
X-Google-Smtp-Source: APXvYqwdQgTeKuiN+BXAJk2rNn49tfppI+2ONnyrFknvlwcSSxH+WxyzSnu3aDsaKU8+JhX6yognRJjEGPsqMkcZHB8=
X-Received: by 2002:a9d:68d6:: with SMTP id i22mr31993177oto.232.1568379826481; 
 Fri, 13 Sep 2019 06:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190911164959.11003-1-alex.bennee@linaro.org>
 <20190911164959.11003-3-alex.bennee@linaro.org>
In-Reply-To: <20190911164959.11003-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2019 14:03:35 +0100
Message-ID: <CAFEAcA8NsdpEMOH1MFDta0LUswyqSDHCgtOh6g5k3+EU0FVuHA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v5 2/5] target/arm: handle M-profile
 semihosting at translate time
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
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 at 17:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> We do this for other semihosting calls so we might as well do it for
> M-profile as well.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v2
>   - update for change to gen_exception_internal_insn API
> v3
>   - update for decode tree
> v4
>   - use !IS_USER
> ---

> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 34bb280e3da..6689acc911e 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8424,7 +8424,13 @@ static bool trans_BKPT(DisasContext *s, arg_BKPT *=
a)
>      if (!ENABLE_ARCH_5) {
>          return false;
>      }
> -    gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
> +    if (arm_dc_feature(s, ARM_FEATURE_M) &&
> +        semihosting_enabled() && !IS_USER(s) &&
> +        (a->imm =3D=3D 0xab)) {
> +        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
> +    } else {
> +        gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
> +    }
>      return true;
>  }

This is still disabling semihosting for the linux-user-mode
build for M-profile, isn't it ?

thanks
-- PMM

