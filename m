Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D6C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 23:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2831217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 23:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0V6xPuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2831217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK9za-0000nf-V5
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 19:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK9yq-0000NM-GY
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 19:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK9yp-0004hU-80
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 19:42:24 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK9yp-0004gj-1O
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 19:42:23 -0400
Received: by mail-pl1-x642.google.com with SMTP id s17so8660454plp.6
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 16:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iEAL1E7kY6g62wrWhyvbiz9iiq61+yi3XRC5V97zXSM=;
 b=h0V6xPuDe8W/6C8BIENsuP8Mvkntd/BGEIMIzgn+e8M8RH8p2EDVE0SenMvKse/XLX
 TzoA6VPhMl8VVfv3ZXWSUmd/9pQzSi9e7AWH3l4VUs1MXwg87ywwwGJwM16kmyrxJqG/
 7L/VUd4SQR/WTHWUbeknyZQ/s2n24ZlR9QTB7FRLqD970u5JUYLzTSCnrFQN0HdA8tV1
 elaZdHlIta2eVBO1hUmMULTRxMgA55+tbk912GiwrWjhyUEO8Ud3dFOw2HJeHEoGVsGR
 wZXmh6pdjqHCiLvaf2tLBfLLS3lNmPXy4H+c6AT8/KcXrH7zTZuFOiutNKTaxiEOzg/U
 q1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iEAL1E7kY6g62wrWhyvbiz9iiq61+yi3XRC5V97zXSM=;
 b=XBh3d8YJlIJZa2r+gFlPdsk0tMIzR5IqZsz86jrTnpMtXPgz3EgeR5sCYFLsLeaZAM
 2n0zm5+j0HhXU3x1kfUjTjEtP+6T6I4Jdo1lowl5swa4jkcHkERo1p3ILFrzV+7+yqK3
 7nNfG6pkuQ7tnE+oKqbR72lHjPoSM2ZYJ9A4uNUmcD/shPkXw/5TY/CguhkthVwlho5f
 8V/SqSechWGWj7mKUV6GEdKVYjW7nuXSfxMOnx3YsI9zUB/izijtrS6p+X48zfUBb4qg
 qfjRny9pPlGIbq1udKK/iqd2ElHwZcPwJI5qoXcogBPJ3Lq0uu700ld3RlU7tpyT3BhJ
 pT7g==
X-Gm-Message-State: APjAAAXREyUhzu6km0DOOqgSCIpJTKrcoi1AHcFUZnC4whm8WlcdwrLo
 J++tadt5lTckLkihx3hkM2e8yQ==
X-Google-Smtp-Source: APXvYqwi4q9swptTKxYTV8aTek1hH5AedkBvIh3a1xFd0wOdjUqFelLYbihWmMNyVsgCw/BupSBblg==
X-Received: by 2002:a17:902:6b88:: with SMTP id
 p8mr30783361plk.251.1571096541440; 
 Mon, 14 Oct 2019 16:42:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b3sm17601720pfd.125.2019.10.14.16.42.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 16:42:20 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Fix sign-extension for SMLAL*
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20190912183058.17947-1-richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <eec68864-79ae-3f05-0903-0d0b1c0cbdaa@linaro.org>
Date: Mon, 14 Oct 2019 16:42:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190912183058.17947-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.

On 9/12/19 11:30 AM, Richard Henderson wrote:
> The 32-bit product should be sign-extended, not zero-extended.
> 
> Fixes: ea96b374641b
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 34bb280e3d..fd2f0e3048 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8045,7 +8045,9 @@ static bool op_smlaxxx(DisasContext *s, arg_rrrr *a,
>      case 2:
>          tl = load_reg(s, a->ra);
>          th = load_reg(s, a->rd);
> -        t1 = tcg_const_i32(0);
> +        /* Sign-extend the 32-bit product to 64 bits.  */
> +        t1 = tcg_temp_new_i32();
> +        tcg_gen_sari_i32(t1, t0, 31);
>          tcg_gen_add2_i32(tl, th, tl, th, t0, t1);
>          tcg_temp_free_i32(t0);
>          tcg_temp_free_i32(t1);
> 


