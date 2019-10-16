Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE28EFA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 889D620854
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcybWTzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889D620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKlO4-0008IJ-Ms
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 11:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKlNM-0007qc-LI
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKlNL-00037s-El
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:38:12 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:33973)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKlNL-00036r-3o
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:38:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id k7so11463604pll.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 08:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PNeWVWNAm1CyVxjwAUsnRWvRgpzNcWmfSgpPuM0VEwA=;
 b=BcybWTzZkLMV2z77MFAeH7Lcizxt7z0rmVrbrK8X+a/mXWn2UO+4GdzCfL+7cMwj37
 5jS1hoYIIODrTwPr3ZYTKZ415WCIivWUIN1ZJ3FT/rrvTCFakTR9BYLw100DnNHnXUL5
 WkcyQb/gmzZ/qpYwAfvCX3VJQVHIMMa4KBn3rwx95/1/3nXvKRz5vlhhv5wHtT+Z3mMN
 GyJ3TrAxa7HzVo7xF88sx9YUYKC7MeKUEdR0sKK6u3g+Li82R7JbSrIKvesOK40uXhL/
 9+WG6b0PYdySOuE1dGl865nM70n8yxXW4vwK0Wv/HqnbkY5ntOvK/Z3wYMdvw8oxINfB
 cggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PNeWVWNAm1CyVxjwAUsnRWvRgpzNcWmfSgpPuM0VEwA=;
 b=fNFhWCFix7TWafn2D8z7/z2gLCmPagaBZYax0Wki4CVJf6TBIcbrJrwsgspm6BCR1U
 pPSQtgwckEsPOWmsYdxpDXJ7L0c2mf7hb0Ku4EUrISNg7EGyd1R25nOkho4Ax/Z2HfIh
 0SCCg5WbfJ6jY7xMezNxZF24crER1fBEsPMjqu4JZkQzyF4M3UE8Il0Y33DGye8FOsYe
 RLEQCStS/OMMoo5L2OIRs3i52JsjIW2kAExG86dqbwfh2i7CIPwvWmEqVooBGwK63qbm
 9+rEz9qfinwmn+VKhHRGWKBJKAoyw8MwClB6tzz5KKl/gq/qHeZ5T9Ek+HmABsey6i1/
 LKtg==
X-Gm-Message-State: APjAAAWrjAFyVlfkn05QdCOYSFoq0JUERjyNqxJvv6V7mlpPRj3qSWUq
 w5uZFrOmmLJX4kQtQYaW9Pl1kg==
X-Google-Smtp-Source: APXvYqwJkL1zhREAmZN36AUJpfcGYfIHpDdbow8JZjviGiXIo4bHGRsp7X2ZJDfhNVLaQ9LWJ9/x0A==
X-Received: by 2002:a17:902:b703:: with SMTP id
 d3mr43593631pls.194.1571240289736; 
 Wed, 16 Oct 2019 08:38:09 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a21sm28291508pfi.0.2019.10.16.08.38.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Oct 2019 08:38:08 -0700 (PDT)
Subject: Re: [PATCH] Added hardfloat conversion from float32 to float64
To: Matus Kysel <mkysel@tachyum.com>, qemu-devel@nongnu.org
References: <20191016073240.12473-1-mkysel@tachyum.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <34960708-32a9-53d6-a719-fa98b8be517c@linaro.org>
Date: Wed, 16 Oct 2019 08:38:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016073240.12473-1-mkysel@tachyum.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 12:32 AM, Matus Kysel wrote:
> +float64 float32_to_float64(float32 a, float_status *status)
> +{
> +    if (unlikely(!float32_is_normal(a))) {
> +        return soft_float32_to_float64(a, status);
> +    } else if (float32_is_zero(a)) {
> +        return float64_set_sign(float64_zero, float32_is_neg(a));
> +    } else {
> +        double r = *(float *)&a;
> +        return *(float64 *)&r;
> +    }
> +}

This is a good idea, since there are no issues with inexact or rounding when
converting in this direction.

Please use union_float{32,64} instead of casting.

Your special case for 0 won't fire, since it is already filtered by
!float32_is_normal.

So I think this could be written as

    if (likely(float32_is_normal(a))) {
        union_float32 uf;
        union_float64 ud;

        uf.s = a;
        ud.h = uf.h;
        return ud.s;
    } else if (float32_is_zero(a)) {
        return float64_set_sign(float64_zero, float32_is_neg(a));
    } else {
        return soft_float32_to_float64(a);
    }


r~

