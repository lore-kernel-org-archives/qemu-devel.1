Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA10C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9912089F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mksa4JkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9912089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i842L-0004HM-RC
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i83mz-0004PL-8R
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i83my-0002GY-63
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:40:09 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:42201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i83my-0002GQ-28
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:40:08 -0400
Received: by mail-qk1-x741.google.com with SMTP id f13so21007755qkm.9
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6UA0w3xHwOhEXiwC/FmcE57kDH+qNBvckyCZerQii6c=;
 b=mksa4JkGnTB4p4BwvIY4k4jsCI3B/lBcGGy8fNXmKMgorgV6ShzJ8MBTBl7OhuBs97
 2z2oUfUYudAanLjk/HN/ubKtejFcN+kIW1L6RWwMb3TYB/VMOak56rZ0FniuePwCdYbh
 tu0I1kiejCOdZhVJDyJeu+d03i2wvQZu9ihqBKexYGLBtgZH7f2zwGldgHeSrQfQNkJe
 cNx9AseBB4FjKlBEfwm3Tjs9pvC/3+XxDlsAcBTBOb1C5xZD2lCOQkT+la0HLAKyCy9c
 LMetwUXjqWNQIMPLCbCsSJa2GIBTYqhmIJ2zQzfi7Aa6YFknLCnNCZupqtrBz1QvZJac
 /iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6UA0w3xHwOhEXiwC/FmcE57kDH+qNBvckyCZerQii6c=;
 b=D/eJHoqyU/TFbMI/zrlD0Zb92+jvcbnqhInvWKvXICTjtgCxQkeTLLG40A/AkWflYw
 4d2HWr/WyOTwtgj8U8toLvglYG8rH9V8W6WX/pwA3/moE90rnCCHrAc/tDe52o1mZyr8
 /NrIH5NwlR4GwTWSuRu1TIQ7YJmiiPWdfwhTLTk+MZpM5VRMYvnt713Ta75oafNtyFD0
 JBDavp/TpNQrGW1YntG3p151Se4N2fn16JOoNMKXNJwDfAx8k15B9JCcuh+yW/s8UOy3
 HV6PwZY+71Bhp+2batEZMJQOgP9PZInJF5po2w2ZOwQdawaPkw2QqvpJKYJ+nmgv16wE
 zjiQ==
X-Gm-Message-State: APjAAAXQyv7Xd+UZT4Ye2hbsixl6J1k8GTKKpl7BXD/tzZ7yXUVFooAh
 ich2TZ3wgRORnU2OHEEn0EGj4Q==
X-Google-Smtp-Source: APXvYqwBrUrOD/UC6Og+jPvuv7L2AybF7aVVopUwrPFa2stHS6diuUG4kjGt++0cDAmW0yiqQjfTPw==
X-Received: by 2002:a37:dc04:: with SMTP id v4mr29947392qki.51.1568212807500; 
 Wed, 11 Sep 2019 07:40:07 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id c204sm596790qkb.90.2019.09.11.07.40.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 07:40:06 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <28507e0d-f7b3-74e6-43df-95a53a162e12@linaro.org>
Date: Wed, 11 Sep 2019 10:40:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: Re: [Qemu-devel] [PATCH v2 02/28] s390x/tcg: MVCL: Zero out unused
 bits of address
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
> We have to zero out unused bits in 24 and 31-bit addressing mode.
> Provide a new helper.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 39ee9b3175..3152bdafe2 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -469,6 +469,26 @@ static inline uint64_t get_address(CPUS390XState *env, int reg)
>      return wrap_address(env, env->regs[reg]);
>  }
>  
> +/*
> + * Store the address to the given register, zeroing out unused leftmost
> + * bits in bit positions 32-63 (24-bit and 31-bit mode only).
> + */
> +static inline void set_address_zero(CPUS390XState *env, int reg,
> +                                    uint64_t address)
> +{
> +    if (env->psw.mask & PSW_MASK_64) {
> +        env->regs[reg] = address;
> +    } else {
> +        if (!(env->psw.mask & PSW_MASK_32)) {
> +            address &= 0x00ffffff;
> +            env->regs[reg] = deposit64(env->regs[reg], 0, 32, address);
> +        } else {
> +            address &= 0x7fffffff;
> +            env->regs[reg] = deposit64(env->regs[reg], 0, 32, address);
> +        }

You could perhaps sink the deposit and store line into the outer else.


r~

