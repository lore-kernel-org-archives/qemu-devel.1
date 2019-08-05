Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBE9C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 21:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB14B20B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 21:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDZra1vX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB14B20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hukIr-0008AB-3G
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 17:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37383)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rth7680@gmail.com>) id 1hukIC-0007g2-Pa
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 17:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1hukIB-0004xi-Jk
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 17:13:20 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1hukIB-0004xF-D9
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 17:13:19 -0400
Received: by mail-pg1-x542.google.com with SMTP id n190so5232648pgn.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YGJwjfcIoUMQVqXZ28SsGMaPJIadDJUuWacndeukgrI=;
 b=LDZra1vXFIIlA1gjBJADWE6PJGxl4hhDDu3Gp20wpUv4BPOoMLgQeerq85YVUXqSY7
 hpy0ztrXUs4RvOth7z2YjHP/6f9ASA5mkz4FWwJMjKhxBYtOHjfk9rHt0FflUzTWWxqn
 V0X2o1TZ+mgpqotI5ZfIVQa1aRp7uYfGkemsaZVCZRPOFvCvjxEY7yV0/EG0bD+Rj9fo
 3KAhrRBAVETgmTzweFJ7POdk1BfPjY4XAabdDIsF74TEBHMRWciv2YQAtEfdOeqAzLEP
 IvuLN4o0UNUCkELRy4lU3mXKNq+5GuqFzD/ZlbEUs+PicN1iBcUPhw8oZyzxf9xBfGu6
 0+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=YGJwjfcIoUMQVqXZ28SsGMaPJIadDJUuWacndeukgrI=;
 b=n6pF1a4w55uc9HmvpBU4c8C68zWMYeBoToqz95E1n6GHr9r3KQjRuXh2/axfk/iltI
 B2AfqGvsrF3Y/JbJt5SQqg5P/2dI3SpBvb915EI+svrDG99gUbvAhRmbZoPGGGn9nFi4
 E/RUg3sW84JEjSyuXVSvcHoVbCnQMFY+BdusLSsRTJGA3Iwdvx3HTH+OVU8SRz8Hw1K+
 4TJO+OgX4m1Xww7haUJGS91vRlzl+3skm4G+6BD1nkaKWKH+qLlbD9wEvcaMGnnxzRvd
 yXbAfZS1dOxMz6/pqvPJSLOmP2WSioyKJ+yTaB3Yrxp+z03vV8SUVF6AVsN/fpKXp++R
 rdrQ==
X-Gm-Message-State: APjAAAVVH3pVwHnOf52j8RL4R+lMIp/tBJOh8T/41LDyyYM9fr6DRQuY
 T21YM3syDa10Kti+VlGXWb8=
X-Google-Smtp-Source: APXvYqwkCGhfXLRPacoV10d2xX0299J6HcplYKuJFOfAoXlCALTTm+11h4DVCXk35nCx/9pOBEK68w==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr50251786pgf.340.1565039597313; 
 Mon, 05 Aug 2019 14:13:17 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.googlemail.com with ESMTPSA id
 201sm102181901pfz.24.2019.08.05.14.13.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 14:13:16 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190805180332.10185-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFBBBMBAgArAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
 cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
 Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
 eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
 LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
 Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVuQENBFGuLC8BCACyEx3x
 94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
 86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
 I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
 VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
 +PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAGJASUEGAECAA8CGwwF
 AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
 Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
 prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
 /E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
 jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
 VcROBqvtH3ecaIL9iw==
Message-ID: <d788f3ff-6814-117d-942d-7870b6201f30@twiddle.net>
Date: Mon, 5 Aug 2019 14:13:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805180332.10185-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH] target/i386: Return 'indefinite integer
 value' for invalid SSE fp->int conversions
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/19 11:03 AM, Peter Maydell wrote:
> The x86 architecture requires that all conversions from floating
> point to integer which raise the 'invalid' exception (infinities of
> both signs, NaN, and all values which don't fit in the destination
> integer) return what the x86 spec calls the "indefinite integer
> value", which is 0x8000_0000 for 32-bits or 0x8000_0000_0000_0000 for
> 64-bits.  The softfloat functions return the more usual behaviour of
> positive overflows returning the maximum value that fits in the
> destination integer format and negative overflows returning the
> minimum value that fits.
> 
> Wrap the softfloat functions in x86-specific versions which
> detect the 'invalid' condition and return the indefinite integer.
> 
> Note that we don't use these wrappers for the 3DNow! pf2id and pf2iw
> instructions, which do return the minimum value that fits in
> an int32 if the input float is a large negative number.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1815423
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I've tested that this fixes the LP:1815423 test case. If anybody
> has an x86 VM image to hand that has node.js installed it would
> also be useful to test the operations in
> https://bugs.launchpad.net/qemu/+bug/1832281
> (I don't have such a VM.)
> 
> The other approach here would be to make the softfloat functions be
> flexible enough to allow this behaviour -- from my reading of IEEE754
> I think the exact returned result for 'invalid' inputs for float to
> int conversions is not specified.
> 
>  target/i386/ops_sse.h | 88 +++++++++++++++++++++++++++++--------------
>  1 file changed, 60 insertions(+), 28 deletions(-)

I guess this is exactly what we already do in fpu_helper.c.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

