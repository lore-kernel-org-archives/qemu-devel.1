Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FFCC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 01:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524462071B
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 01:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JUvsYgDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524462071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI0Bg-00058e-G9
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 21:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jI0B4-0004he-QX
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 21:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jI0B3-0001Bi-DG
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 21:22:22 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:52539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jI0B2-00019K-JG
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 21:22:20 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ng8so4625322pjb.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 18:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2TlLyEH2A+QfFtg9d3bF2BayoW/Zi+n6Kd8kL9ZuE6g=;
 b=JUvsYgDpUIFHVFxNJajyTfHmTY+p5e+wgHzj3SQCB7QB+VHPE2UAs2SlHd2LErBUKL
 w1isXSeLETKHUxhaVgxeYHSNfz1v9/PO4cNNqzbSX8CusWbBilWexQ2aHBaiKBEEuoSk
 tdCFNpBgNYmvq+uZmWQEHaJJEVdcNnHiZXt0dZsV76gaYVwA5wL3aW9ZRC7jhyq9n1OS
 x5A5NFg8Toa4EcHtrURvLmZjml0y/4kjhGfOdCMnjLdI1EjXIvLRECMMEqbgnnS8nbYj
 0GQdqpLnbjLxVCVfBmDDKgqaiDTUajiMnOtYRNEg9OARF6juLevl7k13ndDUpfgAHXbr
 2kOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2TlLyEH2A+QfFtg9d3bF2BayoW/Zi+n6Kd8kL9ZuE6g=;
 b=EHH3aem/o9QBcDsO2f591RVQxIDLTVf368Yhnqo+dBEzLPAjjByeb4EDQl7pz7K5F4
 z9tgkEohzujtX5cIpuUN0iu21nHrU/0uxcdzzN5sNAMfqO3+HpmOVH7LPU2iJBzEDDg8
 pKd0qTwtBZB0WPsna0SKwwYQPeLTujSWQXieaqjgPMDDqS82Pu+eNJe82wsJxaJfNOBT
 5PlLvAYUwpnchW6KSWEJ1ctlXW8LsxTB6JkvM3QSdQDGZIa7eJd/dO9POViAU51yMh/j
 wk9pfguPH5T4xpQdg7bODqX/kEpZiJSut7RlpliWldR7x7aHTBPrgVJD+zvxck2TUcua
 IMXA==
X-Gm-Message-State: ANhLgQ1KQuJBm3AG6Zat13wrO8Ns6EEiyrDWxudEbBlR9lRcuddNpOmA
 u1GGwYoacr3eMBgxABy6z7SNTg==
X-Google-Smtp-Source: ADFU+vvgtKCTi9lBXGkWhBCzE04OzsY0sYcZgvYajn5YI/b+nC4qZXmOcYqYnlDwVwzQBLqB1Ig54g==
X-Received: by 2002:a17:90a:b943:: with SMTP id
 f3mr2251757pjw.171.1585358539218; 
 Fri, 27 Mar 2020 18:22:19 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id l1sm4673530pje.9.2020.03.27.18.22.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 18:22:18 -0700 (PDT)
Subject: Re: [PATCH v6 25/61] target/riscv: vector single-width averaging add
 and subtract
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-26-zhiwei_liu@c-sky.com>
 <0cdf21fd-b1f1-36bf-f156-5a673199fa1f@c-sky.com>
 <5c2f0b77-32fa-76bd-0b0e-4ca91d87f3b6@linaro.org>
 <f50a4a63-c5cf-4322-9663-98fb15dde715@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ce13869a-141f-cc4d-8f1e-6a3742197654@linaro.org>
Date: Fri, 27 Mar 2020 18:22:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f50a4a63-c5cf-4322-9663-98fb15dde715@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 6:07 PM, LIU Zhiwei wrote:
> 
> 
> On 2020/3/28 8:32, Richard Henderson wrote:
>> On 3/18/20 8:46 PM, LIU Zhiwei wrote:
>>> +static inline int32_t asub32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
>>> +{
>>> +    int64_t res = (int64_t)a - b;
>>> +    uint8_t round = get_round(vxrm, res, 1);
>>> +
>>> +    return (res >> 1) + round;
>>> +}
>>> +
>>>
>>> I find a corner case here.  As the spec said in Section 13.2
>>>
>>>   "There can be no overflow in the result".
>>>
>>> If the a is 0x7fffffff,  b is 0x80000000, and the round mode is round to up(rnu),
>>> then the result is (0x7fffffff - 0x80000000 + 1) >> 1, equals 0x80000000,
>>> according the v0.7.1
>> That's why we used int64_t as the intermediate type:
>>
>>   0x000000007fffffff - 0xffffffff80000000 + 1
>> = 0x000000007fffffff + 0x0000000080000000 + 1
>> = 0x00000000ffffffff + 1
>> = 0x0000000100000000
>>
>> Shift that right by 1 and you do indeed get 0x80000000.
>> There's no saturation involved.
> 
> The minuend 0x7fffffff is INT32_MAX, and the subtrahend 0x80000000 is INT32_MIN.
> 
> The difference between the minuend  and the subtrahend should be a positive
> number. But the result here is 0x80000000.
> 
> So it is overflow.  However, according to the spec, it should not overflow.

Unless I'm missing something, the spec is wrong about "there can be no
overflow", the above being a counter-example.

Do you have hardware to compare against?  Perhaps it is in fact "overflow is
ignored", as the 0.8 spec says for vasubu?

I wouldn't add saturation, because the spec says nothing about saturation, and
does mention truncation, at least for vasubu.


r~

