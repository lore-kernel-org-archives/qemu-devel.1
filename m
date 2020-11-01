Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC96FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 22:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C69C22282
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 22:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdY35BjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C69C22282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZLRF-00026D-AV
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 17:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZLQQ-0001Sv-94
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 17:02:10 -0500
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:39170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZLQO-0004Yt-Fm
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 17:02:09 -0500
Received: by mail-ej1-x642.google.com with SMTP id s25so2284904ejy.6
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 14:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xN6pThlJJY/1nn8Jdp2yQyY2QYEg0MLN4vCH0ynaGos=;
 b=gdY35BjRVYa8yrLc22cbA3o42sImMdAyUz7rZpxfrhrPbiCR+bwLzrDm0O65V/mayg
 lBC02Mg1OEZET6LsV1pnGhyQzqx48l1Q046oZvEjjDMVcMi2UpOv+a9xigYWtOJFRZyT
 Z6fYHwkt8Yqp12EFN/FBq5tRQuy724GxPVXPoPthgVF3DxGdukVHtHNfaf2M1pC/HDiZ
 nQR6f+wyZ4wWD5DexUh3O9MPNLdhuCVKaR1zv3kF0dNHdZMLXSzj3VBobhRLmZ6vDrgV
 BJQ2a51SpN6mGYO6QY9SB9S24VR843lOHWthCgcX8IChxir4/gwv8mQTvCCA9bEQYAVy
 5wfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xN6pThlJJY/1nn8Jdp2yQyY2QYEg0MLN4vCH0ynaGos=;
 b=jB7y3mCwIyVJFNEO5x2DkbmuylRqR9oTBd+wlDFQaS8zDOlDi4++kPW+Anah0xZR+a
 V16FJfEhXcZg/pGSu3atvqk8+iB9TcxbmavnvByzn7cIzO9rhpSmpya166jeb7nug+gJ
 q/vsklXCtAZt9JQqOy5AtXnRGycAv/uMX91JFCoqprL0J0Yq9PnwbV4cyW6vUPtuvV68
 GWv40wopv/at/exl0/pPe3b2TZ5FPKBCmqUSO5OhX7O9Dt+UiS+YQtbOjK4mIVJisQCZ
 f3EhSk41P+WEzzOghTPSPm/A/MLPPyqMJf7bFtye9IyJSgP49ml1wwWrqvRCAEDf/gPJ
 P/5Q==
X-Gm-Message-State: AOAM530hlpn1TI6Bn89m4iDfWrgUyqA5kb+0AKZcxew6pUi0jUr/6mys
 zA7r2oNQX5zMOzc0HwiRdmSG0xX6b/y/hLhwQ/e+AQ==
X-Google-Smtp-Source: ABdhPJz2kKxlgcxVXrBF+jmzcZHBYyZQK3jOAKxDKio3HnOoLrl3SehPiDck4Eiw9GqHhwIKBjG+pkJftu6HSva9P80=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr13280112ejf.56.1604268126905; 
 Sun, 01 Nov 2020 14:02:06 -0800 (PST)
MIME-Version: 1.0
References: <20201101215755.2021421-1-f4bug@amsat.org>
In-Reply-To: <20201101215755.2021421-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Nov 2020 22:01:55 +0000
Message-ID: <CAFEAcA_3Vd+VdVLx6Z=Oe_NGDdK4yUsH2e2LQAQ6Zyuhj3LNMg@mail.gmail.com>
Subject: Re: [PATCH-for-5.2 v3] util/cutils: Fix Coverity array overrun in
 freq_to_str()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: Luc Michel <luc@lmichel.fr>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 1 Nov 2020 at 21:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Fix Coverity CID 1435957:  Memory - illegal accesses (OVERRUN):
>
> >>> Overrunning array "suffixes" of 7 8-byte elements at element
>     index 7 (byte offset 63) using index "idx" (which evaluates to 7).
>
> Note, the biggest input value freq_to_str() can accept is UINT64_MAX,
> which is ~18.446 EHz, less than 1000 EHz.
>
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v3: Follow Peter's suggestion
> ---
>  util/cutils.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/util/cutils.c b/util/cutils.c
> index c395974fab4..2f869a843a5 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -891,10 +891,11 @@ char *freq_to_str(uint64_t freq_hz)
>      double freq =3D freq_hz;
>      size_t idx =3D 0;
>
> -    while (freq >=3D 1000.0 && idx < ARRAY_SIZE(suffixes)) {
> +    while (freq >=3D 1000.0) {
>          freq /=3D 1000.0;
>          idx++;
>      }
> +    assert(idx < ARRAY_SIZE(suffixes));
>
>      return g_strdup_printf("%0.3g %sHz", freq, suffixes[idx]);
>  }
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

