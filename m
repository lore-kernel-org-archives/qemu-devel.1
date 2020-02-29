Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A257C3F2D2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B7C2468A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYvFY6tU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B7C2468A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7rDW-0002ux-9O
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 20:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7rCq-0002Mt-Qo
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7rCp-0004QE-Ne
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:46:16 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7rCp-0004Pr-Hp
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:46:15 -0500
Received: by mail-pj1-x1042.google.com with SMTP id i11so1929540pju.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 17:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x6sDG0IIcZ7Zp+I9XshOaZdugtDBlhBVQlWxzodIvJY=;
 b=JYvFY6tUbRo1mduhB+HaeIsC6aqV/p+Py3QzITkob39jl1IgHAKiYM6rZe1XN6s7yE
 tspfHitO/ZOuWI1o3aOL6KSz8r6lmjBkZ4/vVGTbpavfQGoqwvY/aoYuAwsp3CF44VzN
 py9sExty9Re3T6SwoH4VyHG5C9e8MdocayWDAUFxRb+DIYZzRQG5f+zV26VjZU5+QI0l
 he40IJaVwRu4UOZBDeVYvwFAXn7v4d4pp8gpP6aLYsjxVX35yai4XNXRybMkqVxrC9nk
 HqXUoKc2mUGJeycvldpeNn465ABxytM8LB2dVhheRPzIX8wAg3Q1iZNtyDKzSFIKrhcy
 4tdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x6sDG0IIcZ7Zp+I9XshOaZdugtDBlhBVQlWxzodIvJY=;
 b=r+66DMvOKBjcmYqSjv7gYrDb8aMc9RqPe4ksngQBkRzZJncgN5GFZMRAVyFvEdRReV
 CObP9B8fNBoJfUvjiMJWqYGChl+3qsn4YHvCi9oUxqhsX/FX7rEaLCm1SEU6ddOQA30Y
 jK5z49W+sJGa8Vp2YsfYtXDUnRA+W77HzXN6C8/EeZqh1yhZ595E+UWcvselYwfFWa71
 UkBt+LO/uQN5jdEnThS9s81HcazJ4jOTbmMcqCR2XzNts2yrsUxpd+GHaiRTKW4SD7nU
 tudA3K3ONKo6Q2JYLA0Fv/ZlS8hGnylZkyXbaXSWIt5D47NeIbNZm2g9HObCzU9GaP40
 4tCQ==
X-Gm-Message-State: APjAAAVap8FdgO1wwQeVpH/OcFnABZ3qy3LAvZZWIIMUujCHrNWkMUCG
 6vAwYNcTVbVg22d3fh4NgdyBrQ==
X-Google-Smtp-Source: APXvYqxghoUbsegNcobl5kP/3Mnlm2cEGTLCU8IAjtUK2G0TTzd1j5vj/13IqXhnWHwW4VCSahp9Aw==
X-Received: by 2002:a17:902:343:: with SMTP id
 61mr6821238pld.332.1582940774421; 
 Fri, 28 Feb 2020 17:46:14 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 3sm12481617pfi.13.2020.02.28.17.46.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 17:46:13 -0800 (PST)
Subject: Re: [PATCH v2 0/4] Clean-up codegen cache size
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200228192415.19867-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5b8a3ffb-4ae1-b842-7eb2-e60defa2dd53@linaro.org>
Date: Fri, 28 Feb 2020 17:46:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228192415.19867-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/28/20 11:24 AM, Alex Bennée wrote:
> Hi,
> 
> A few tweaks to the final commit so we are a little less greedy for
> translation buffer, especially for the CONFIG_USER case. Otherwise
> I've applied the review tags.
> 
> Alex Bennée (4):
>   accel/tcg: use units.h for defining code gen buffer sizes
>   accel/tcg: remove link between guest ram and TCG cache size
>   accel/tcg: only USE_STATIC_CODE_GEN_BUFFER on 32 bit hosts
>   accel/tcg: increase default code gen buffer size for 64 bit
> 
>  accel/tcg/translate-all.c | 61 +++++++++++++++++++++++----------------
>  1 file changed, 36 insertions(+), 25 deletions(-)

Applied to tcg-next.


r~

