Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71916C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 18:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE1F20640
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 18:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4JE6PGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE1F20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9CXb-0008W3-Fi
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 14:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i9CWg-00083K-Jj
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i9CWf-0003u4-BP
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:12:02 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:36740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i9CWf-0003tg-3z
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:12:01 -0400
Received: by mail-ed1-x542.google.com with SMTP id f2so23348032edw.3
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 11:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WQbStIjjJ99srxSjXdB+WUk0YWL72ABSA2i/Y1p3i2w=;
 b=G4JE6PGoEkcrK5aEBddzj6ClxfMc03D9igZyuIS9sNpbknetx1luPXxGxefEm76aO/
 jcOzfpiD0//7/v+p5gbs2jjvpBbWWK00/IBSS+RW8VWzN4NxmKEwDwD7BsGVONk2vc1g
 5t+aAFN+PvXKt0ZywI7HYOPcW8zPaa3H1ObfsYN6ugjMms553hIsR5rscsMOO4WV78YV
 P8Fib5TWyZ0LZODS6yNe+qE2ZgZFDQ02RRjtHnf2kH5TC0uX4D8W0dWIf8Ue92DpK6WO
 CdI0wzi30R0Xmzj1jFomkO14kDsm7Gnmg94MaU0KMjmnRcp0XXPslekH/4DGYBRlIWjq
 xcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WQbStIjjJ99srxSjXdB+WUk0YWL72ABSA2i/Y1p3i2w=;
 b=ftMJvxnKZ+m3qpc3rgEcp77AFGAss0wDl7v6BAXYKTMgHPaDLkSI+qOxFu7yAVqIVW
 jQjFcbRHJGRTFieZFg5PLgpsUs0E8zszF1mpyo6aLHpvqjYR6m8k6kJjo3WrHzS51JNC
 K7rKk1k1pyWCmfZyOm8zNaTYr0c/iA8kq6veaXj+g+RlR+yddOmo8G27AqLqgnJQgbWF
 NFknCOedlcT6hY9P0+nu7rmiecFhgCncexLvEri/Nv0ieKIin+Z9HjD5tiO/hl86Q9LA
 ciYDgD81z+mNc4/ESbI3khd3pTDjO1VhIlHpeTbI5ccLHHJMITI7inje12r4Eh/2k7Gc
 pLXw==
X-Gm-Message-State: APjAAAUBAuC8AehaSDDUAaTunekvSji1kGi+AaCM5AGqvugvXrZVqI7F
 7wFHbT3JicYU2CK+MReeEdlVsA==
X-Google-Smtp-Source: APXvYqy28ufVucw2m8Y2OQLFYXlvTeRkBwJ7fIewI1PGhTn6sAg8CSTSCrow1K82y+zrQv3vkwOQzg==
X-Received: by 2002:a17:906:b249:: with SMTP id
 ce9mr44210914ejb.128.1568484719665; 
 Sat, 14 Sep 2019 11:11:59 -0700 (PDT)
Received: from [192.168.44.107] ([185.81.138.21])
 by smtp.gmail.com with ESMTPSA id v22sm4525250edm.89.2019.09.14.11.11.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 14 Sep 2019 11:11:59 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190913134935.29696-1-alex.bennee@linaro.org>
 <6ef910fa-d387-faf3-4647-209beaf7886a@linaro.org> <87v9tuahdv.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <502b7594-3c01-e9fa-c63e-78a583be0c01@linaro.org>
Date: Sat, 14 Sep 2019 14:11:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87v9tuahdv.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH] tests/tcg: add float_madds test to
 multiarch
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
Cc: 1841592@bugs.launchpad.net, qemu-devel@nongnu.org, pc@us.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/19 1:59 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 9/13/19 9:49 AM, Alex Bennée wrote:
>>> +                    /* must be built with -O2 to generate fused op */
>>> +                    r = a * b + c;
>>
>> I would prefer to use fmaf() or __builtin_fmaf() here.
>>
>> Although you'll need to link with -lm just in case the
>> target doesn't support an instruction for fmaf and so
>> the builtin expands to the standard library call.
> 
> I can do that - we have other tests that link to libm.
> 
> I was expecting to see more breakage but the ppc64 tests all passed (or
> at least against the power8 David ran it on). What am I missing to hit
> the cases you know are broken?

I would *expect* the test to pass when run natively on power8 hardware.  Did it
not fail when run via qemu?  If not, then we didn't really choose the argument
sets that are affected by double rounding.

I would expect the inputs that Paul used in the original report to be
candidates.  Otherwise, we should grab some from the glibc fma test case(s).

> I've also experimented with reducing the number of iterations because if
> we want to have golden references we probably don't want to dump several
> hundred kilobytes of "golden" references into the source tree.
> 
>> I also like Paul's suggestion to use hex float constants.
> 
> Hmm I guess - look a bit weird but I guess that's lack of familiarity.
> Is is still normalised? I guess the frac shows up (without the implicit
> bit).

The implicit bit is there: 0x1.xxx.  The representation is always normalized;
you write denormal numbers by using an exponent that would require denormalization.


r~

