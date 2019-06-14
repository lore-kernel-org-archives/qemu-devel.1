Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4B1C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 21:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1EFC2183E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 21:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="go3lzCxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1EFC2183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbu2X-0001eL-La
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 17:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45870)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbu0z-00014J-O0
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 17:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbu0y-0004BP-Q7
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 17:45:41 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbu0w-0003zM-PH
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 17:45:40 -0400
Received: by mail-pl1-x642.google.com with SMTP id k8so541700plt.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 14:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ThzpBAVx5EEvdVUYsfYMRxq9rB+36Nya6f3VN3f26ig=;
 b=go3lzCxJZpNJXUsoLsm82LmKeVffmAiN6wX5+qbvKPJ2TwAzEwmv2k0bE/oqgWyhhA
 Ap9+XS3nXOZTYxlZ1QL0npPO0xhBxbA1AUg80n2YjTJWBggLv+IPfCG6AUYRy7Dqc1Gw
 XHIDLBtuRM6BX2VB6TyYKcCdAAvq5XRpyHFQGWrVZLYnQzr/bu4cMNzwJ8VDCpP9mLSe
 /2bIGtC9SsHQEHX8PVc/zeAmKH3P+Fbaj2kmGCQfTCjZqQNBwKJAGw19voGSyZ2vzwxg
 bR1ZxDNUNTGgx4s+dPZum72TEaZlTJkwjz/TyppN8NPRc8kprk1dcgJFIBeunZdwkPef
 BUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ThzpBAVx5EEvdVUYsfYMRxq9rB+36Nya6f3VN3f26ig=;
 b=ImeiE5NMeytlaYlLqWTBLLFYyej5wQWiGk9Jeh5vyTtwUzOHciAzjukvO+XcN6BHGT
 bxhsi9U5q73UTSA0Hu+KrYMkeYCSibLjbLIMp1sI5hzun5JPJXZ9O5nj0gYeINPmIXJT
 4Xmec3W7kSerfTIet7hjYCSssSyvJL+6H5YZRRX1CjNr7UauQdsZqhEyvBm36xtgdwi4
 oLLIr+24FRJksRjhlxygdtj2GKGoE+PzDN8JPPGuuY4UIUSpgU8Pgu7PLwHBEIT4egeC
 EbjjNri1b0PfjDrdIjSQwgbFez7LXBClMzn8lIyOqFaoYzBvsfX+ck/EULfDlk7/yOT4
 3R3A==
X-Gm-Message-State: APjAAAXDct0D+/aJOZQI091JMTXMCIilSwp1B/dpo7YxOfl4Nqj35U0I
 bNwyvgW7lcj4MJ64JbxbmyjK/hWCF2o=
X-Google-Smtp-Source: APXvYqzzQTAQNK25Ha9N6QbTYxceUXcVa7evKQB5t8aAg1izNwlx5yUoYFxoZFBoiRmspBcJO+xkuA==
X-Received: by 2002:a17:902:6903:: with SMTP id
 j3mr20259253plk.247.1560548724361; 
 Fri, 14 Jun 2019 14:45:24 -0700 (PDT)
Received: from [10.1.2.220] (50-247-96-158-static.hfc.comcastbusiness.net.
 [50.247.96.158])
 by smtp.gmail.com with ESMTPSA id x8sm4139973pfa.46.2019.06.14.14.45.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 14:45:23 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190614104457.24703-1-peter.maydell@linaro.org>
 <20190614104457.24703-3-peter.maydell@linaro.org>
 <ab0b9cf8-98d2-1901-a8f7-259d6426f833@linaro.org>
 <CAFEAcA8CkvThgBXrSJw=O4BWBBDi0yXcF1T8fgytB53AshExXQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fa026ac6-905d-a9d0-3759-81d0e7182348@linaro.org>
Date: Fri, 14 Jun 2019 14:45:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8CkvThgBXrSJw=O4BWBBDi0yXcF1T8fgytB53AshExXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Only implement doubles if
 the FPU supports them
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

On 6/14/19 10:52 AM, Peter Maydell wrote:
> On Fri, 14 Jun 2019 at 18:21, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 6/14/19 3:44 AM, Peter Maydell wrote:
>>> @@ -173,6 +173,11 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
>>>          ((a->vm | a->vn | a->vd) & 0x10)) {
>>>          return false;
>>>      }
>>> +
>>> +    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
>>> +        return false;
>>> +    }
>>
>> Would it be cleaner to define something like
>>
>> static bool vfp_dp_enabled(DisasContext *s, int regmask)
>> {
>>     if (!dc_isar_feature(aa32_fpdp, s)) {
>>         /* All double-precision disabled.  */
>>         return false;
>>     }
>>     if (!dc_isar_feature(aa32_fp_d32, s) && (regmask & 0x10)) {
>>         /* D16-D31 do not exist.  */
>>         return false;
>>     }
>>     return true;
>> }
>>
>> Then use
>>
>>     if (dp && !vfp_dp_enabled(s, a->vm | a->vn | a->vd))
>>
>> ?
> 
> It would be less code, but I don't think the "are we using
> a register than doesn't exist" and the "do we have dp support"
> checks are really related, and splitting the "OR the register
> numbers together" from the "test the top bit" makes that
> part look rather less clear I think.

Fair enough.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

