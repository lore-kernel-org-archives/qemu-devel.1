Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73477C3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 07:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C44E20857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 07:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZ6OwpG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C44E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3DxL-0007GI-FN
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 02:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3Dwi-0006bg-Aq
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 02:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3Dwh-000581-2E
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 02:02:27 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3Dwg-00054E-RD
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 02:02:27 -0500
Received: by mail-pj1-x1042.google.com with SMTP id dw13so5782712pjb.4
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 23:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d8qZH3J1u7qn+lpCi+NB9EHoxUOvAytcTN2VSnBTKjQ=;
 b=mZ6OwpG1szV2VYrIqeYHNYkqgZo9ahveolviz9VJWWKv3gCQWvJcMyD7xTDIG38P33
 MxsRcV5rWgR/DKcYoYpLBhzxFPEX0o/0Oe8gG2YKZxy5MdF243Kc3nNEA511xmRYs0kP
 nXVqnuEX9ZzQenBYjLfBpunfowkQB2WA+R9t/1ygocHZ9SBrTTYCd7odjtXVrvsq7gMj
 gSuYaQUNhmC0fEr9Vi2XyoXrF1+wsDEzI0DydZ5oTJJQUZXJ10n2I7qKs9a0TmvTCjuA
 yYj8cGPsiLcuXxMocaiL0hT7tLKDqw1Q90zXB+BD1cxBmdT/r6sKNMx6gT+NWNHk/hOa
 9UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d8qZH3J1u7qn+lpCi+NB9EHoxUOvAytcTN2VSnBTKjQ=;
 b=GKFjAOxWfhqg2R+veKI/FeIpIGKVxa0uNarBE3HpJh5aD12KG5YoJS0Jgs+xVJSOeu
 bkcHHJXBVcyAlptSLYYijNxbFsKaqgZy22vmtxru6shUTvtOzpbJyc8bt2epOc0Uxxsq
 BvkHU8rqXPl2hmM3fy/qA+4oQgdGGE+aOQTYe0DNf9PAzGf2kCDwLkPcsAUh1eH5g3Jd
 MkU/yxTdz2FiTeAdt4RSRs2vxQidR0dyY59Pq+B0Q4hXeniOOCGucNkti+3eCVf+OUVZ
 qFmVb0KQhiZwZJXckXXM1VJhSw3s6Xj1XK1Wb7X5cMZ04HmG/xiQsKjaDU9cK33sLY+J
 fD/A==
X-Gm-Message-State: APjAAAXq/qr/dtVmHYtr683KfIiFwYBOQZFb788VHKqr0BD+CuX4zGWN
 0jDjadtqSygD1Hq+ixTA1pr/vWm+RvE=
X-Google-Smtp-Source: APXvYqx/GCwuN9qYguItwHBu4yIGePDjvX50IAVXvUsYRJQ1pCcaI/X5oS/GpiEEpODt/uD6QoIg4Q==
X-Received: by 2002:a17:902:401:: with SMTP id
 1mr10570433ple.177.1581836544925; 
 Sat, 15 Feb 2020 23:02:24 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 x65sm12875549pfb.171.2020.02.15.23.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2020 23:02:24 -0800 (PST)
Subject: Re: [PATCH v2 1/2] target/arm: Fix select for aa64_va_parameters_both
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200211194228.16907-1-richard.henderson@linaro.org>
 <20200211194228.16907-2-richard.henderson@linaro.org>
 <CAFEAcA9Lq2tbsGqpSYWU=g1OYfu_TeXv5nuyBayJwapdLLKP9w@mail.gmail.com>
 <CAFEAcA8ed6mzXSKVGMKDEVm0zz4VS63RCwCwbedj_c4N4BCpPw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a7a28b7f-2e7f-19a1-f39a-d3a6074db7c6@linaro.org>
Date: Sat, 15 Feb 2020 23:02:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ed6mzXSKVGMKDEVm0zz4VS63RCwCwbedj_c4N4BCpPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 5:25 AM, Peter Maydell wrote:
> On Thu, 13 Feb 2020 at 13:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Tue, 11 Feb 2020 at 19:42, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> Select should always be 0 for a regime with one range.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> This change makes sense, and matches what aa32_va_parameters() does,
>> but I think we need to update some of the callsites.
>>
>> (1) In get_phys_addr_lpae() we have the check:
>>
>>         if (-top_bits != param.select || (param.select && !ttbr1_valid)) {
>>
>> where ttbr1_valid is the return value of (effectively)
>>  aarch64 ? regime_has_2_ranges() : (el != 2);
>> but I think it's no longer possible to get here with param.select == 1
>> and !ttbr1_valid, so this becomes a dead check.
> 
> ...or should the code instead be checking literal pointer bit 55
> against ttbr1_valid now ?

No, I think the first expression now covers everything, as you suggested in the
first reply.


r~

