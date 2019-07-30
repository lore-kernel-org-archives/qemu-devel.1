Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB5CC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 01:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B14C20679
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 01:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjCVgN5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B14C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsGzA-0003ik-Ha
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 21:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39224)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsGyX-0003Jl-Ki
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 21:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsGyW-0004RX-JL
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 21:30:49 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsGyW-0004O0-Bn
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 21:30:48 -0400
Received: by mail-pl1-x644.google.com with SMTP id b7so28243985pls.6
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 18:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ABulo+v5LIO2Y5kgYHTgh6ICRf6L1QUWNDuHmcYVHL8=;
 b=MjCVgN5Wl1FCYMAhzVQ64xPccC6MUVsS/A7vYDyeb7nGOvz1KrKFYCLE2I/Ffs4a2w
 vDJYSNfjawUY/34IDMorgm/XBy9nApfaqFy2a6YuBb+euxh0Op/jDmemkVRX7NH3P6Z3
 QzZ/Pm6voD7p2dDfed1t+BXUDUDQmoNEFYx8KsO0zXtG3mSi6Qm0EBtLu63+sF88v0RT
 MpDZlNqsdfkg153zGvnPNAZ7fH05LiAxaYohzZ88wNZX4x2kWVrb1zdt9A3Yf2mGOx7I
 fe4Qok+wzSBCyDzd1B+83r5iBSKSqrQ8yr5Sl46b54DS++FyOxuNCXUx/jj29rha5LdY
 LWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ABulo+v5LIO2Y5kgYHTgh6ICRf6L1QUWNDuHmcYVHL8=;
 b=NyvFL6u5bI598k85i/7uOJPXYhb/vwYZVtswR7hwftrZpI2kM7YODSgPOHZGCYayqD
 kYVZsLJpkPg1Fbg8WhpvX4k72IT7qUk0LUENjDzG5vz4/Q01omfswkDNeJ8vLYkA5++e
 r/zSGK0SaVaY8fWbgXhj7asq0hm0Ybxh4SF//SG1q205Rmybu50RkMRek6CAT46cJigb
 JlN9gpJnE5H3oXpN7Y9K8OzT15p/ulECP/V1u441fIU+SU1X81Jq9Ii8wIe8YH3LiBjr
 gXcOUt6DWJiH+lXU3PFKl6r/oclhJBpvNCVIGpogWKtCIn1Ue2GZjqQzA9dyMb8HYxGr
 PU/g==
X-Gm-Message-State: APjAAAUU4NMckRD8qw+Q4FoNA2DKaJXB5ZkH5kD5om3ikrKEcAds1qlX
 Oo32wElEEiFbgfPJH4t06BQD8A==
X-Google-Smtp-Source: APXvYqx6wEoY0AFWBGDMZbvaVAeHiliMAg1EucMwjquuIMAdZXt3xiYFJeTb3RyqVczeAD2i2rBrVw==
X-Received: by 2002:a17:902:1004:: with SMTP id
 b4mr114708536pla.325.1564450245021; 
 Mon, 29 Jul 2019 18:30:45 -0700 (PDT)
Received: from [192.168.101.105] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id j15sm92874681pfn.150.2019.07.29.18.30.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 18:30:44 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-2-richard.henderson@linaro.org>
 <CAFEAcA-+PfEMDE9QJZJ+_yqV0KYY6ih2yxA8c_w1bmrz7GtUkA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4962c208-04d6-65e8-556d-b1805f4e4ebf@linaro.org>
Date: Mon, 29 Jul 2019 18:30:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-+PfEMDE9QJZJ+_yqV0KYY6ih2yxA8c_w1bmrz7GtUkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/19 6:43 AM, Peter Maydell wrote:
> On Fri, 26 Jul 2019 at 18:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> With this, we can have the function return a value from the DisasContext.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  scripts/decodetree.py             | 5 ++++-
>>  tests/decode/succ_function.decode | 2 ++
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>  create mode 100644 tests/decode/succ_function.decode
>>
>> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
>> index d7a59d63ac..4259d87a95 100755
>> --- a/scripts/decodetree.py
>> +++ b/scripts/decodetree.py
>> @@ -195,7 +195,10 @@ class MultiField:
>>      """Class representing a compound instruction field"""
>>      def __init__(self, subs, mask):
>>          self.subs = subs
>> -        self.sign = subs[0].sign
>> +        if len(subs):
>> +            self.sign = subs[0].sign
>> +        else:
>> +            self.sign = 0
>>          self.mask = mask
>>
>>      def __str__(self):
>> diff --git a/tests/decode/succ_function.decode b/tests/decode/succ_function.decode
>> new file mode 100644
>> index 0000000000..632a9de252
>> --- /dev/null
>> +++ b/tests/decode/succ_function.decode
>> @@ -0,0 +1,2 @@
>> +%foo  !function=foo
>> +foo   00000000000000000000000000000000 %foo
>> --
>> 2.17.1
> 
> Could you also update the documentation in docs/devel/decodetree.rst ?
> 
> This code change looks like it also now allows definitions
> of fields that specify nothing at all (ie there's no check
> that a field definition with no "unnamed_field" parts has
> a !function specifier) -- what do they do, or should they
> be made syntax errors ?

Ah good point.  Should be syntax errors.

> Is one of these functions which just returns a constant
> from no input bits still a "static int func(DisasContext *s, int x)"
> taking a pointless input argument, or is it now a
> "static int func(DisasContext *s)" ? I guess from the fact
> this code doesn't change the way a call is output that it
> is the former, but would the latter be cleaner ?

Right on both counts.  Because of how the loop in MultiField is set up, x will
always be given 0.  I'll see about cleaning this up.

In the meantime, fyi, this is used for setting the S bit for thumb1 insns,
where S=0 iff the insn is within an IT block.


r~

