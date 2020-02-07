Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C155C35247
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 00:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D2F2064C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 00:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtHiJbVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D2F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izrVO-00065D-6c
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 19:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izrUg-0005QP-Rn
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 19:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izrUf-00043y-EH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 19:27:38 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izrUf-00043W-5C
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 19:27:37 -0500
Received: by mail-wm1-x343.google.com with SMTP id a5so826699wmb.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 16:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Wtvtrt+SLCtvqf+PjMj5EU6d8kN8+5NHA0pM2+MU93o=;
 b=PtHiJbVuITKCuVLcisCUgBfkSJiuAryRPHg+sGjbaZG5xN8QqJXfWo1QEjbi8B2Skl
 Oy/89Y2RHCE0ilcFw6H/nHQpQ3vWCp6n20ApIxqqaa3Fz/vcCP9omI5UxQ7D2U4VHL8S
 mrZBB15PsNlXRTXZu49QBaO7P7cbThZggqSyPwuFBWjEabWQ1o6ILWM54gam8Nf1XydK
 dXcjrpFESwrORzal9ztoVybZWdxkIC79zTWo4VOh+SvjfZIcVbzJYfL52si1EbyqEhg+
 ZtnIrzAy/sHZhpj4jLVW3+sd13KTHZAQEVuKqxeXQuX7UrFOy2MfkDDMvRBI/eo4X4N/
 WoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wtvtrt+SLCtvqf+PjMj5EU6d8kN8+5NHA0pM2+MU93o=;
 b=JLqL3JKf15YmMeuseWfKStxhUUGLJ5dxojlxKeewYOKqIHpXiFTvZG7UTIQHEn74S6
 AYTPuqiSI6JTeqoG4N+M5KcyzgLDfJKtY4qoCfP7+A4xrUdKXcSFs/7Fq0FjoiukJY/d
 Pm2/qEXcY8eeJ6b0LGV+fNKUPt7FY9sRztgrMHY8MQJAera8Y/mKAHjAx/yrgYM9BV0j
 367V/Ldvn0Pe45TF2iXWBAIraaR89yc4+PEcyKXkBdYOBviqpCiz2EOxkCXxNzRLmF7v
 OWw75/XvfbfL/vctVbrqJIRTriclzn5clKFcyM3LWX8U0Tdcnl59rLZxtVT2feTT9LKc
 /tJg==
X-Gm-Message-State: APjAAAUI/+ptO/zjkOA3ZYfT5yo1afsjQpBRBaAu9EKUBiyWvA0M13oW
 CeintfHEWxsiNtKuvvbJGYAONw==
X-Google-Smtp-Source: APXvYqyu/FauFpZF/HqZwxq8Td7eyVo3m0sc8P45bnCzaLDoGOxYRRfaQz/v1v/Ay5hJqnuCUp8GSw==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr492159wmb.162.1581035255842; 
 Thu, 06 Feb 2020 16:27:35 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id e17sm1271063wma.12.2020.02.06.16.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 16:27:34 -0800 (PST)
Subject: Re: [PATCH] Add support for a helper with 7 arguments
To: Taylor Simpson <tsimpson@quicinc.com>, Richard Henderson
 <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
 <09def3cf-6833-ccf5-457e-1755a7fd0e04@twiddle.net>
 <640ffa37-a70b-dfa9-55ef-cde5c7f0dfcb@twiddle.net>
 <BYAPR02MB48863BDFCB4CB26717467579DE1D0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <3614849d-12a5-fa43-fb10-801e9648b40e@twiddle.net>
 <BYAPR02MB48864A309572E1347920CAF0DE1D0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <34caf794-85b7-c177-7951-d821ace5caa9@linaro.org>
Date: Fri, 7 Feb 2020 00:27:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB48864A309572E1347920CAF0DE1D0@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 5:52 PM, Taylor Simpson wrote:
> 
> 
>> -----Original Message-----
>> From: Richard Henderson <rth7680@gmail.com> On Behalf Of Richard
>> Henderson
>> Sent: Thursday, February 6, 2020 9:35 AM
>> To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Subject: Re: [PATCH] Add support for a helper with 7 arguments
>>
>>
>> I think this is quite ugly.  I know you've been talking about auto-generating
>> everything but we ought to do better than this.
>>
>> You should be passing values not regnos if you can possibly do so.  You
>> should
>> be passing full virtual addresses not N separate components of an address.
>> Predicates should be evaluated earlier so that the helper isn't even called if
>> it's false.
> 
> We are passing values, not reg numbers.  The generator doesn't know anything about the semantics of the instruction...

And this, I claim, is wrong.

If you can generate C for the operation out of line, then you can interpret it
inline as well.  Or, make a reasonable decision about what bit to be out of
line and what bit to be a helper.

> It only knows which operands are read, written, or both.  So, there's no way
> to combine the 3 operands into a single effective address until we are
> inside the helper.  Also, there's no way to know if the instruction is
> predicated or if it just has a predicate as an operand.  Also, there are
> instructions where the predicate is used in the false sense.
There certainly is a way to know what the effective address is.  From the
pseudo-code that I browsed today, "EA = foo" is a big clue.

There certainly is a way to know if the instruction is predicated.  From the
pseudo-code that I browsed today,

  if (pred) {
    operation;
  } else {
    NOP;
  }

is the clue, vs

  Rd = mux(Pu, Rs, Rt).

Of course there are insns where !Pd is used; that doesn't change anything.

>> Combine that with 3.3.1 Packet execution semantics, "dual stores, new-value
>> stores, and slot1 store with slot0 loads have non-parallel execution
>> semantics", and you need no special helper at all:
>>
>> andt0, pv, 1
>> brcondit0, 0, over
>>
>> shlit0, ru, u2
>> addt0, t0, rs
>> qemu_strt, t0, mmu_idx, MO_UB
>>  over:
>>
> 
> We can't actually do the store here.  We have to record it in a side data structure in the env and perform the store when the packet commits.

I think that we can do the store immediately -- I give specifics above.  Do you
have a counter-example?  Admittedly I'm new to browsing the architecture, but I
don't see a legal packet for which you can't just Store Now.

> Currently, there are a total of 35 instructions that need a helper with 7 arguments.  32 of them are predicated stores, but there are also 3 vscatter instructions.  For example,
>     if (Qs4) vscatter(Rt32, Mu2, Vv32.w).w = Vw32

Ok, vscatter is indeed complex.  But I still count 6 operands.  Is it the
"slot" one that you're concerned is the 7th?  I don't see that as strictly
necessary, since this can only be in slot 0.


r~

