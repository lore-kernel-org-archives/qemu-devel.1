Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338D4C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 08:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81B12087E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 08:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xy4ltRxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81B12087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzG8p-0003kR-OD
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 04:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzG7a-0002qL-OY
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 04:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzG7Z-00008X-Bt
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 04:01:02 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzG7Z-000084-3R
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 04:01:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id g67so415980wme.1
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uAq1Bx1yrrzxmeBiVdlALOq5Ppa6afiV/vkrW+o0MHU=;
 b=Xy4ltRxkppA6zUGvqITpuq13qtcQNAtsWomUZFhO/NLhfq1TG4cc7w4ZKIOtPrBo+n
 CbdTg5HniBIFKzdeakjn7zAB1MB9kdbRYNxd5JGTaHpl4URFyokLWha3hqmHAtbMgfim
 /Ow23YwgF9C4zNJT7h65qknACN+aXoA0PDV2nQVQDbLdubIkMo/BBhu3QV3BFTnOYWzx
 NkUxEukQ0Z3LUN0NkMtViZgjSymLiT8ddmlcIRD2zmXJTRHzsAwhfOSPhUbFlvN8t8Uv
 vfK6Ur8b7+2OaY8soNxRKoWSifrxtvXMYhDXDtZgdF2xS2DdCQamik2PZsEGQeykSs2v
 hjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uAq1Bx1yrrzxmeBiVdlALOq5Ppa6afiV/vkrW+o0MHU=;
 b=JyoPouR8fil+dA6QEXpJsOPuTwdk5ybJ4kvwU6FMXq/SDNavNRV1Rk6nRa9bKQjHn9
 dncxB6gQpKVmsUrAnbl20O1z81afcxN3HfjcQqzIC5crddDOO+Jj5m5j6ic3KbiULPfT
 12ZXVKHKxJSZUd2dHErFPLX1NN/Z1pBuYcxTcqXlJ+Lp+eDRot5rAanTazL5D5jVRPrD
 XDUUunXWM2w1h/8zjTtTf1abvWHG7GkXjx80n95pQgE3CRjloEfk+HO44kSNtSmszwok
 ksnN089i/UVWNk9lnJDDl+du9H2+/Swk0qWagxpbQitOuM9Lh3rbIJVipFAzK3AK/Ten
 x4tg==
X-Gm-Message-State: APjAAAWdE/4PcLJ7/IL5o4BlmrIsWGml8YdkxoYII7VjdlWGdXxyCnD+
 9bCwj54WtEWWztJjfubX3cEm9/uFsw4=
X-Google-Smtp-Source: APXvYqyrg1qHi6+/MtKOYtw6oWhds7QoW4eaR0CjFin4u6CiSVhte6YgT7P7ZFOhK8CF1YBSM08bPw==
X-Received: by 2002:a05:600c:40f:: with SMTP id
 q15mr15054237wmb.88.1566115259662; 
 Sun, 18 Aug 2019 01:00:59 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id z8sm10680213wru.13.2019.08.18.01.00.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Aug 2019 01:00:58 -0700 (PDT)
To: "Paul A. Clarke" <pc@us.ibm.com>, david@gibson.dropbear.id.au
References: <1565983669-6886-1-git-send-email-pc@us.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <130a4cea-e747-1a20-4ef3-8f777ae44493@linaro.org>
Date: Sun, 18 Aug 2019 09:00:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565983669-6886-1-git-send-email-pc@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] ppc: Three floating point fixes
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/16/19 8:27 PM, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
> 
> - target/ppc/fpu_helper.c:
>   - helper_todouble() was not properly converting INFINITY from 32 bit
>   float to 64 bit double.
>   - helper_todouble() was not properly converting any denormalized
>   32 bit float to 64 bit double.

These two would seem to be my fault:
Fixes: 86c0cab11aa (target/ppc: Use non-arithmetic conversions for fp load/store)

> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 5611cf0..82b5425 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -62,13 +62,14 @@ uint64_t helper_todouble(uint32_t arg)
>          ret  = (uint64_t)extract32(arg, 30, 2) << 62;
>          ret |= ((extract32(arg, 30, 1) ^ 1) * (uint64_t)7) << 59;
>          ret |= (uint64_t)extract32(arg, 0, 30) << 29;
> +        ret |= (0x7ffULL * (extract32(arg, 23, 8) == 0xff)) << 52;

Since the overwrites bits set two lines above,
I think this would be better as

    if (likely(abs_arg >= 0x00800000)) {
        /* Normalized operand, or Inf or NaN.  */
        if (unlikely(extract32(arg, 23, 8) == 0xff)) {
            /* Inf or NaN.  */
            ...
        } else {
            /* Normalized operand.  */


>      } else {
>          /* Zero or Denormalized operand.  */
>          ret = (uint64_t)extract32(arg, 31, 1) << 63;
>          if (unlikely(abs_arg != 0)) {
>              /* Denormalized operand.  */
>              int shift = clz32(abs_arg) - 9;
> -            int exp = -126 - shift + 1023;
> +            int exp = -127 - shift + 1023;
>              ret |= (uint64_t)exp << 52;
>              ret |= abs_arg << (shift + 29);

Hmm.  The manual says -126, but it also shifts the fraction by a different
amount, such that the implicit bit is 1.

What I also don't see here is where the most significant bit is removed from
the fraction, a-la "FRT[5:63] = frac[1:52]" in the manual.

The soft-float code from which this was probably copied did this by shifting
the fraction such that the msb overlaps the exponent, biasing the exponent by
-1, and then using an add instead of an or to simultaneously remove the bias,
swallow the msb, and include the lower bits unchanged.

So it looks like this should be

    /*
     * Shift fraction so that the msb is in the implicit bit position.
     * Thus shift is in the range [1:23].
     */
    int shift = clz32(abs_arg) - 8;
    /*
     * The first 3 terms compute the float64 exponent.  We then bias
     * this result by -1 so that we can swallow the implicit bit below.
     */
    int exp = -126 - shift + 1023 - 1;
    ret |= (uint64_t)exp << 52;
    ret += (uint64_t)abs_arg << (52 - 23 + shift);

Hmm.  I see another bug in the existing code whereby abs_arg is not cast before
shifting.  This truncation is probably how you're seeing correct results with
your patch, for denormals containing only one bit set, e.g. FLT_TRUE_MIN.

It would be good to test other denormals, like 0x00055555.


> @@ -2871,10 +2872,14 @@ void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode,
>  
>  uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
>  {
> +    uint64_t result;
> +
>      float_status tstat = env->fp_status;
>      set_float_exception_flags(0, &tstat);
>  
> -    return (uint64_t)float64_to_float32(xb, &tstat) << 32;
> +    result = (uint64_t)float64_to_float32(xb, &tstat);
> +    /* hardware replicates result to both words of the doubleword result.  */
> +    return (result << 32) | result;
>  }

This definitely should be a separate patch.  The comment should include some
language about this behaviour being required by a future ISA revision.


r~

