Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572B2C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237F72075C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JgO8vcLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237F72075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84Ai-00034K-Nf
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i83z7-0000pS-GY
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i83z6-0000FE-6w
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:52:41 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:46858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i83z6-0000Ex-0s
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:52:40 -0400
Received: by mail-qk1-x744.google.com with SMTP id 201so21033335qkd.13
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/kyy8UD4w+Pujj9TKKrzFqBWybV685fp7Xz2FOXrSqA=;
 b=JgO8vcLduhAIHkzMVFKdWGESMERIS2+4F7QhbhUW9T3ykoba+072i5voOV9IVy8PVV
 wCb2QcNFEeEoTYPyZ8E1QnKxGa6200AzA9OFQAWYh1NS+3GBsZL4zh/cQzG1ItzZtoFl
 W4lcawrXYgwmUCCzUJ0NAGQYV5xG1UUhyCYMM0YS9fN7sSsMfz2tGPIUhj3m9FbRQ+5U
 prvhu60xrS/KLkzp1kOoclkqafM5/+xFJ1RGCOtPSoqJvQl8HnglwW1dn40pImulz2QR
 +mrRHsunk0kBIi2ZZkTmDXr/UOvUjzeKzEc5mPYhvaGRNgz3Omw3ZLRbpGIOZEvYL7Bw
 5nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/kyy8UD4w+Pujj9TKKrzFqBWybV685fp7Xz2FOXrSqA=;
 b=Eob7wdUbak8K4p3tdGrr7SkDPzKfi53M3ZPqiNBJK5q5uyn7jS5y8T/L+dUstM1wmX
 PJeZzAik4j6+dbVCXUX26uek5QSJPhD1HLLw5Bfxhx3eKgKPoIooqLc/kzW89N43wXkl
 eY5GoG+R0wX2Mxxe5KCbub+OgZj00ad1gPjySgPBg47dLmT0R22nO0rIKLbTWG99KGXo
 tlt77KVtru6GLQIb5pOpTom4YwirPKZPqHikSjFo5aUsJIzjNbugoe2oqLq3xEXxHVXB
 VXdkF8TdmouWzeiZlDmvRcvT+/qPXezJ74xVjA5oj4NJcaMIzRpIAoo4qOEjL+6f8E59
 4Atg==
X-Gm-Message-State: APjAAAUrfKxqF2PyZr3VCl8BtYlJL7Epe6KKXBI8xl6FOh6KFtRHOwdK
 x2dNYYd76NgNrkSbjZvcFBVhpQ==
X-Google-Smtp-Source: APXvYqxEaNNf8tvPXcKAEHrt0PlEn1ROXL8AHsUiyRrrHaxXFi7IPjGb3RsZVN2w4WhVhiMUHJxKDA==
X-Received: by 2002:a37:86c4:: with SMTP id
 i187mr35575643qkd.464.1568213559226; 
 Wed, 11 Sep 2019 07:52:39 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id t32sm11208141qtb.64.2019.09.11.07.52.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 07:52:38 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7788b1b6-fbf0-3370-5563-1da4f7124999@linaro.org>
Date: Wed, 11 Sep 2019 10:52:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [PATCH v2 04/28] s390x/tcg: MVCL: Process max 2k
 bytes at a time
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
> Process max 2k bytes at a time, writing back registers between the
> accesses. The instruction is interruptible.
>     "For operands longer than 2K bytes, access exceptions are not
>     recognized for locations more than 2K bytes beyond the current location
>     being processed."
> 
> MVCL handling is quite different than MVCLE/MVCLU handling, so split up
> the handlers.
> 
> We'll deal with fast_memmove() and fast_memset() not probing
> reads/writes properly later. Also, we'll defer interrupt handling, as
> that will require more thought, add a TODO for that.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 44 +++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 2361ed6d54..2e22c183bd 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -799,19 +799,51 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
>      uint64_t srclen = env->regs[r2 + 1] & 0xffffff;
>      uint64_t src = get_address(env, r2);
>      uint8_t pad = env->regs[r2 + 1] >> 24;
> -    uint32_t cc;
> +    uint32_t cc, cur_len;
>  
>      if (is_destructive_overlap(env, dest, src, MIN(srclen, destlen))) {
>          cc = 3;
> +    } else if (srclen == destlen) {
> +        cc = 0;
> +    } else if (destlen < srclen) {
> +        cc = 1;
>      } else {
> -        cc = do_mvcl(env, &dest, &destlen, &src, &srclen, pad, 1, ra);
> +        cc = 2;
>      }
>  
> -    env->regs[r1 + 1] = deposit64(env->regs[r1 + 1], 0, 24, destlen);
> -    env->regs[r2 + 1] = deposit64(env->regs[r2 + 1], 0, 24, srclen);
> -    set_address_zero(env, r1, dest);
> -    set_address_zero(env, r2, src);
> +    /* We might have to zero-out some bits even if there was no action. */
> +    if (unlikely(!destlen || cc == 3)) {
> +        set_address_zero(env, r2, src);
> +        set_address_zero(env, r1, dest);
> +        return cc;
> +    } else if (!srclen) {
> +        set_address_zero(env, r2, src);
> +    }
>  
> +    /*
> +     * Only perform one type of type of operation (move/pad) in one step.
> +     * Process up to 2k bytes.
> +     */
> +    while (destlen) {
> +        cur_len = MIN(destlen, 2048);

The language in the PoP is horribly written, and thus confusing.  I can't
believe it really means what it appears to say, about access exceptions not
being recognized.

The code within Hercules breaks the action at every 2k address boundary -- for
both src and dest.  That's the only way that actually makes sense to me, as
otherwise we end up allowing userspace to read/write into a page without
permission.  Which is a security hole.


r~

