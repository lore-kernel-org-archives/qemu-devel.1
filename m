Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C63C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F734218A4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zisYD7qs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F734218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiiKP-0000Gy-OT
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33976)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hii5y-0002z1-HP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hii5x-0002eR-KJ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:26:58 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40559)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hii5x-0002dY-C0
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:26:57 -0400
Received: by mail-wm1-x341.google.com with SMTP id v19so3060200wmj.5
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XIdp8b9YZOIts7YvsxasQGlbEVEtg/lMz67qoCvXUXY=;
 b=zisYD7qs+C/5nNOZAYP5ytn98kwwCz3M1sawcBXWFuTq3n5QBYnrn6WKK8lzeaYoaF
 mMHiD3J1bAFDhRd4iWZVrIHnjPsaDJ1S3H6bdZ77+Awb8VvWnBPI5fTsr/KDQK+3vUVi
 /4n3/SYEQOosg3DNI+K6OzQFG3b3rDqJ/VIKj/kAFtzWu4WNDJbJCTDNtek5iuEwF0cT
 yc8GdKu7O6Nr34P9CQUP3av4XWSF/3RIDvmnd/876vjzqGH1XEjYxxieVCvv/LVUhu0a
 o6NHk3bPiE5a4tApoLOl954XIs/e3abKH4m+TiauQtau7v+d9Uh5gpMMBuo1PE7goUq5
 e+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XIdp8b9YZOIts7YvsxasQGlbEVEtg/lMz67qoCvXUXY=;
 b=SHPP25DtuSp2O5s/UTHu/1SplEzihJ5O0pikyuGGvOMTNuUKVeUuY9Vz/Q26UpiGEv
 tfUAqAUUdXdqDLRzEtS8kL7tGn/Ep2Gko3172GjM482RiBeKPX2GYhz7CXJwb9DF4lqg
 831tqldLwuWUzeHLCCfvjPaFuWlgZsuaUPKUNjAAN/nFA9CNC6jFKpOomsyqBX0pkl4b
 mOOQ5P2/L8lWxYa2DZfgOgI59hsS1ir++8WNz0Ig9h1uJUQ4EmNMZLhjRR5y/xcWmUYo
 3ISSoycNuBJoasMnDxF91LiTuf1eYHVa8DONDu3ISoccnbZ30pv4balOFFwakqS0Ot9o
 79ZQ==
X-Gm-Message-State: APjAAAX8wlmhP5vBQM0CK3E1Bt/iezJBCSoYbh+IuiHBdVnLPrpOM7qe
 p3eq+8Cr4uu17/moydOKr32DFg==
X-Google-Smtp-Source: APXvYqysQlhx3iv0914nO4KCAnLLDf+tTScVW8AIUJp46JIkE09GmetTzz5nAkYsfZhF3T/ok3BoXQ==
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr7922532wmd.87.1562171214604; 
 Wed, 03 Jul 2019 09:26:54 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id z9sm3789345wrs.14.2019.07.03.09.26.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 09:26:54 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190703155244.28166-1-alex.bennee@linaro.org>
 <20190703155244.28166-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <927219a5-a56d-bbbe-26ed-ffb8be12f006@linaro.org>
Date: Wed, 3 Jul 2019 18:26:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190703155244.28166-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v1 1/4] target/arm: handle M-profile
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 5:52 PM, Alex Bennée wrote:
> +static inline void gen_thumb_bkpt(DisasContext *s, int imm8)
> +{
> +    if (arm_dc_feature(s, ARM_FEATURE_M) &&
> +        semihosting_enabled() &&
> +#ifndef CONFIG_USER_ONLY
> +        s->current_el != 0 &&
> +#endif
> +        (imm8 == 0xab)) {

Extra parenthesis.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

