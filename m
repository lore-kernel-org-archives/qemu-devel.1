Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C20DCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DBC222C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHM/13WJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DBC222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTK4-0001so-Rv
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLTIM-0000Dc-Q4
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLTIL-0002jQ-IN
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:31:58 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLTIL-0002im-8K
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:31:57 -0400
Received: by mail-pl1-x642.google.com with SMTP id d22so2944616pll.7
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=B90KVt3jBppnWmU62RN/VdEMzjr3PF5TC8yDKeKv6q8=;
 b=pHM/13WJuOtRzI2+FNWXWDzFVbsG/+6v4bfrD/EbLdeWeNbeHDqBnCngr4ERgTYDUY
 1JajSoaKMWDT1F8993D8vUhHUl8HlFu8OwqEeXoNTFE8/lUyQSbGYeNrZty/EFpiGqU+
 nNAr6ftvDLqp/eLKrX0q/bkuYB4CokvcHl1Rrfym+4sW+4FYuHIBdroxR0Cdma9AX3LB
 56jaqYaZ5PZ+c1hNf5cMImmv+pnXT+fvw3RQzGoipJks3uOjoktzwtZNTguF7LF76/hP
 utUZH0qY4eX2JMPIs6o2x7QdfYKgZBb9UgMFWgJDmDRVZpcdI4gjuvK9aCIfbX+ELn8k
 GhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B90KVt3jBppnWmU62RN/VdEMzjr3PF5TC8yDKeKv6q8=;
 b=kllUxWKOZr4zhatRpn0f5QmgmeHltW3vuEx8CBnQlQcTybqDiHhQvArO7BksfWlGik
 b8EduVBK0YcD3VcpDgf4BCoc57x1yPsLhFs6z16M6/IjPKd90aQHdmlCoe/gB3qleBoc
 k1SP/9pe1b2rc8YjoIA9+M5zihXd4go2JQ0e4Kgx1r2UWFhOxVcB29pr6Bmuubx9qMoT
 qG/3CmxC8wB4w9YUuZ20mtTZGvqSkP6LQ2z51HU0cB2XD7qRIDIarAKObGoSlKodeOQ2
 gniZiJQPYQYKpeArM4boGXLRlhVoBt3pkD5/47RRgm/saxcOyDqdaK/ralhyzML9ulJR
 +FVQ==
X-Gm-Message-State: APjAAAWOTeZEjJt5h2XgUjYnC5i/7OoWtzeo1ZaHxuxw9DlPKpl/0Zxp
 BeNo8spzIXR/D/9b7wZQVrbGxw==
X-Google-Smtp-Source: APXvYqx02359Skj7druvT5XYT6CRLUe3njy3RZ+oNJ41g5ZjrJ4OyukplXqBh1yhigIwYeL/Of7tRg==
X-Received: by 2002:a17:902:b70f:: with SMTP id
 d15mr10306833pls.210.1571409114650; 
 Fri, 18 Oct 2019 07:31:54 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t11sm5927106pjy.10.2019.10.18.07.31.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Oct 2019 07:31:53 -0700 (PDT)
Subject: Re: [PATCH v7 19/20] target/arm: Rebuild hflags for M-profile.
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
 <20191017185110.539-20-richard.henderson@linaro.org>
 <CAFEAcA9oJ0P-g87caLKyT1mS2k7YhtNXAOhSgXuMy0bCGwX0WA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <aa753ee9-40ce-d6c8-801f-eda74d76fd3d@linaro.org>
Date: Fri, 18 Oct 2019 07:31:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9oJ0P-g87caLKyT1mS2k7YhtNXAOhSgXuMy0bCGwX0WA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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

On 10/18/19 5:25 AM, Peter Maydell wrote:
> On Thu, 17 Oct 2019 at 19:51, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Continue setting, but not relying upon, env->hflags.
>>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v7: Add rebuilds for v7m_msr and nvic_writel to v7m.ccr.
>> ---
>>  hw/intc/armv7m_nvic.c  | 1 +
>>  target/arm/m_helper.c  | 6 ++++++
>>  target/arm/translate.c | 5 ++++-
>>  3 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
>> index 8e93e51e81..a3993e7b72 100644
>> --- a/hw/intc/armv7m_nvic.c
>> +++ b/hw/intc/armv7m_nvic.c
>> @@ -1604,6 +1604,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
>>          }
>>
>>          cpu->env.v7m.ccr[attrs.secure] = value;
>> +        arm_rebuild_hflags(&cpu->env);
>>          break;
>>      case 0xd24: /* System Handler Control and State (SHCSR) */
>>          if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> 
> This seems fragile -- we have to remember to add in
> a call to arm_rebuild_hflags() for every individual
> case of a memory-mapped system register that we choose
> to cache in tb flags. It doesn't seem consistent with
> the choice for A-profile to rebuild hflags for pretty
> much any sysreg write. Maybe it would be better to just
> always rebuild hflags at the end of nvic_sysreg_write() ?

I thought about that, but there were too many returns out of the middle.  I
suppose a wrapper function would take care of that.


r~


