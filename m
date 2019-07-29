Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B91BC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E51206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiKoKlCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E51206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs5xB-00053a-6N
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46056)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs5we-0004Kb-KG
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs5wd-0000cS-Dm
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:44:08 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs5wd-0000b3-7l
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:44:07 -0400
Received: by mail-oi1-x243.google.com with SMTP id t76so45300484oih.4
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fBRho2ZxX35dY1+0Rwc1Vnwv30CpcZZPcmmUFuHJQnQ=;
 b=aiKoKlCUEwGmwFOsEYs33dOtjSnnm1j/9i8RNv0zvcscxIgAkouoK1wqGNdvnG629j
 pKoF5kcCL1wSibLnAtnn0PotVVY4+QSpjeNUL3YKENjz08nxpr/BOExvs0I8Rz96DxZK
 yWHIE+mL2u0bXRh0C7BBSh5TQIVfqV+i6+4eatf4H06C8WX2V01q+q18hoFt2BsMZAZC
 qfYDlDyLkKOYGOyQ4K9q4xMkNGTNbjoe9z5JBT6xCOmcwpquJxN3rtmequRrAHC6ZTFk
 HlgWsLwVSQkCFXk2n7ZzQfYUYySnqIMVw2pv7lPmovRuv0jPnJKM8zwSEXyt/jFQjMiF
 +rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fBRho2ZxX35dY1+0Rwc1Vnwv30CpcZZPcmmUFuHJQnQ=;
 b=uc2SCntrQSWqCzxztzckNGCCrU5BSC1UBzT2cO1QwHnyBZ6TPCFLx+KqoMGkBfjegq
 y5/qEQZpU12tXVLMy49ELG4U4IjDM3fGBFJvIicJ+NwoNloH7y1bWyA2X+dnqXC1ZdAy
 C0fCa8kCVQLwWkVhppVNbaeTQFlCjXsiNhzR0tjzqlrsirsECIFuF2RCtJlhZKdDlKhg
 Lm5P8y18WWZya3w7qtlPPb7tv0gMpAVdFV6LKDPPjmgOrSczUS9UAfgh/xVOUcx/+s/X
 7/7sBQHa/lgd/We2O16W1HJQ9/8AQV42V4WNXJeuyEEMWQFbpvuQjn5PgvXgq0GTPsEi
 7Xig==
X-Gm-Message-State: APjAAAUan5gsXmkQnVYa07BuwZCqKN3wobl/F7wIvIgyyG7hUbJjwdIM
 xW6ToeosZlQs3yQV1bBVD2g/jnlymr7dYk4vnTXctg==
X-Google-Smtp-Source: APXvYqzjqTpQOMphl/YT/BIAuMhylLXvDBMi/BB7jSsGXWCus34qJZJ8aIe/ri3agcVT0Bd62OlgWDSzN/hehqi9I1w=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr34722294oic.170.1564407846310; 
 Mon, 29 Jul 2019 06:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-2-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 14:43:55 +0100
Message-ID: <CAFEAcA-+PfEMDE9QJZJ+_yqV0KYY6ih2yxA8c_w1bmrz7GtUkA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 01/67] decodetree: Allow !function with no
 input bits
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
> With this, we can have the function return a value from the DisasContext.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  scripts/decodetree.py             | 5 ++++-
>  tests/decode/succ_function.decode | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>  create mode 100644 tests/decode/succ_function.decode
>
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index d7a59d63ac..4259d87a95 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -195,7 +195,10 @@ class MultiField:
>      """Class representing a compound instruction field"""
>      def __init__(self, subs, mask):
>          self.subs = subs
> -        self.sign = subs[0].sign
> +        if len(subs):
> +            self.sign = subs[0].sign
> +        else:
> +            self.sign = 0
>          self.mask = mask
>
>      def __str__(self):
> diff --git a/tests/decode/succ_function.decode b/tests/decode/succ_function.decode
> new file mode 100644
> index 0000000000..632a9de252
> --- /dev/null
> +++ b/tests/decode/succ_function.decode
> @@ -0,0 +1,2 @@
> +%foo  !function=foo
> +foo   00000000000000000000000000000000 %foo
> --
> 2.17.1

Could you also update the documentation in docs/devel/decodetree.rst ?

This code change looks like it also now allows definitions
of fields that specify nothing at all (ie there's no check
that a field definition with no "unnamed_field" parts has
a !function specifier) -- what do they do, or should they
be made syntax errors ?

Is one of these functions which just returns a constant
from no input bits still a "static int func(DisasContext *s, int x)"
taking a pointless input argument, or is it now a
"static int func(DisasContext *s)" ? I guess from the fact
this code doesn't change the way a call is output that it
is the former, but would the latter be cleaner ?
(This would probably be implemented something like allowing
FunctionField to be passed a base == None instead of
allowing MultiFields with len(subs) == 0.)

thanks
-- PMM

