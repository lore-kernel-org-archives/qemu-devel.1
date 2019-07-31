Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A36C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 19:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47FE8206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 19:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkqzoX8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FE8206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hstyV-0004Xg-KX
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 15:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35519)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsty4-00048t-52
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsty3-0001FX-4V
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:08:56 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsty2-0001Et-Rg
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:08:55 -0400
Received: by mail-pf1-x444.google.com with SMTP id p184so32388698pfp.7
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KGMEoo09+epscJol3Xt5DarPsjETJBFoOFbgMCBu7Ec=;
 b=GkqzoX8W3lvTAyKYwZ1EXiy6PPyzZmlEVWVGVSEu4l0keQ6z1rgFS0koghfu4QVbpL
 eeBuq9wyKCl6Pf2dVr/N2lD+PYxNeACMEsthoCGaSUUCcvliWpg/9N+AwXlL/HZ7O+JE
 HXHV/OH7l3XaIDHmfvAGZR3S7gH54HNGLSHvyKZYA0NyNLAtyBZnGsftlmgSBxMg/zzm
 5W7no1LHwRzEroARshKEn5HsD4IYZJrjSCkQETGhxZCc46k/1DiLTXZtFMkYsQWVyeWi
 k7Jja/Dhw39C4hIOIy95EhMdp7/eMYKGnhxUewss1iO9Dq2lbA8nDZPinUfsiqcTtIA0
 UV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KGMEoo09+epscJol3Xt5DarPsjETJBFoOFbgMCBu7Ec=;
 b=VzyhYTavFchSistUENePelO5tz9XumCTUhKCTmJeV7uprhs2jOSXd2RrB/5bz8zipV
 j7AAuEhBApLaM0ZI/ZjRuzG3ZLxIxSmQ3V3bTxZlSAxvLX1o/5wfuW48M665FK4xYpZv
 b0ey7Wb7PmRp3H7pbJGxKna2nwmUzcT27gMEwhAqLN2+pPBN+P1hGzMCnW/utVd5zG4d
 AZ1ESwIbV2dTuvhfrHSDxl1YXa7v/Rjh+p8EeYHL4LmrIP15vlEFgJ8797Zx71aWe8e5
 2T4yUHY5xSmP9O77gIdAD9/3MsA5jYsblnFYrNx9TIBtI+Uj7nTtlv5ilR1VlntKa79y
 Iiog==
X-Gm-Message-State: APjAAAWrWnYrh9YK3mZ9oq1/1vPFXZ5YJR3iJfGlUYmjR5o1fGfxxKC8
 B0t4u05hgJD48HMOgnLOI7svgw==
X-Google-Smtp-Source: APXvYqwKV/f3LrvcIA2dHJkUk4UwRrF7t3BFFWRfI8K8XAyex+d+PJF5uX8oU/w2chcNw1QbCWh5wg==
X-Received: by 2002:a63:e907:: with SMTP id i7mr113356340pgh.84.1564600133204; 
 Wed, 31 Jul 2019 12:08:53 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e124sm113720719pfh.181.2019.07.31.12.08.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 12:08:52 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-6-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a31e0c68-c679-1afc-cd18-43da1d002621@linaro.org>
Date: Wed, 31 Jul 2019 12:08:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731175702.4916-6-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [RFC PATCH v1 05/22] target/i386: introduce
 gen_ld_modrm_* helpers
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 10:56 AM, Jan Bobek wrote:
> These help with decoding/loading ModR/M vector operands; the operand's
> register offset is returned, which is suitable for use with gvec
> infrastructure.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  target/i386/translate.c | 47 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 9e22eca2dc..7548677e1f 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -3040,6 +3040,53 @@ static const struct SSEOpHelper_eppi sse_op_table7[256] = {
>      [0xdf] = AESNI_OP(aeskeygenassist),
>  };
>  
> +static inline void gen_ld_modrm_PqQq(CPUX86State *env, DisasContext *s, int modrm,
> +                                     uint32_t* dofs, uint32_t* aofs)

s/uint32_t* /uint32_t */

Drop the inlines; let the compiler choose.


> +{
> +    const int mod = (modrm >> 6) & 3;
> +    const int reg = (modrm >> 3) & 7; /* no REX_R */
> +    *dofs = offsetof(CPUX86State, fpregs[reg].mmx);
> +
> +    if(mod == 3) {

s/if(/if (/

Both of these errors should be caught by ./scripts/checkpatch.pl.

> +        gen_ldo_env_A0(s, *aofs); /* FIXME this needs to load 32 bytes for YMM 

Better as "TODO", since this isn't broken and in need of fixing, since we do
not yet support AVX.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

