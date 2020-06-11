Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D70C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4F7206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iRh0zZDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4F7206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPNs-00025u-Uz
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 11:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjPMf-0000I5-3h
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:43:37 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34458)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjPMa-0002rY-7r
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:43:36 -0400
Received: by mail-pl1-x644.google.com with SMTP id n9so2475752plk.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=dmGgdjzoHZYYsa1vZ/PrK/4qatxUWFsIxvydmMFCb7Y=;
 b=iRh0zZDnVkdHPJfxM7rcBnocuOVbde5YLDG4rN0mhWAW/PiwSVVcOfpdoatxMsLZjB
 O709gmXpjYCKxiKlgJsCkxrDkV5qo82gnxj9Ca+UX05PJC26rk6DBmNa7g74DOxgXEC6
 hsDSgvK3M1tnm/mPi+5adfLTjtUekE/hEQAghuUmDoVhchE+Hb9SXh/Wj8oXkn+7SyjD
 jGpiLhkq+04Q74JOg6lpaYNSsyxbN1gJ5cMRx5uMowDTyNmqnYR/Eo/xPnLyw/gNVxxP
 Ol1aL/b+8XtsbUB8ektVGSOzSA1Ie7fOp8XRDzTrazGz3nLuL71q8PqYZUMJasp/Uigy
 jXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dmGgdjzoHZYYsa1vZ/PrK/4qatxUWFsIxvydmMFCb7Y=;
 b=tiJ2xtWDh0bRN+VgpuSXcZ5RMeuyukrDsDUjSfzf57Q8PHB1v5KITY3DFrgsEZLaJK
 sWkp0ft9+Fa5P8z31w8gz0uvQgwSFxK1zR4FfkS7o86ELkLb1ps4xgHuSZIf/arjMNCn
 UApK33g1fv2plPiVYEYl5+jzGicTUEFdOfYqv2aLmZ3GpM9Bji7NVAyRcZSWAQ28HX4v
 p1lL40qHyglLrxXelFYZLiNFyIY9DnBv01KmKrFD7eI3CjNqIa81wj2NyoWLGEIX7Js5
 mLgtt6RPscMXErFE6RfdBdF6mu6h/qt30Q3XkwHz1uEhnilkYmez9yEmHioL+BGysFPD
 AdmA==
X-Gm-Message-State: AOAM533Y2Vw7ma1e+bVsGJx7l2Y0coGdwH+HO8Du3oFpLMKytDAej2wP
 llSmPvHSUD3RQC42EYXr8twtA9mlkL0=
X-Google-Smtp-Source: ABdhPJwmYT7oLBYKbyjsmOxnJ4r1pBS+ks+aJ0tvmrreFM2vqfBRIQy24/97S5u+zJFcAlXqryW0rA==
X-Received: by 2002:a17:90b:4306:: with SMTP id
 ih6mr7911085pjb.62.1591890204349; 
 Thu, 11 Jun 2020 08:43:24 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id r7sm2424010pgu.51.2020.06.11.08.43.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 08:43:23 -0700 (PDT)
Subject: Re: [PATCH 02/10] target/arm: Add missing TCG temp free in
 do_2shift_env_64()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200611144529.8873-1-peter.maydell@linaro.org>
 <20200611144529.8873-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d32b36c2-6662-91b1-5b18-ff7a56386cd8@linaro.org>
Date: Thu, 11 Jun 2020 08:43:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611144529.8873-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 7:45 AM, Peter Maydell wrote:
> In commit 37bfce81b10450071 we accidentally introduced a leak of a TCG
> temporary in do_2shift_env_64(); free it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> My test setup wasn't looking for temporary-leak warnings (they are
> not as easy to get at as they used to be because they only appear
> if you enable qemu_log tracing for some other purpose). This is the
> only one that snuck through, though.
> ---
>  target/arm/translate-neon.inc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
> index 7c4888a80c9..f2c241a87e9 100644
> --- a/target/arm/translate-neon.inc.c
> +++ b/target/arm/translate-neon.inc.c
> @@ -1329,6 +1329,7 @@ static bool do_2shift_env_64(DisasContext *s, arg_2reg_shift *a,
>          neon_load_reg64(tmp, a->vm + pass);
>          fn(tmp, cpu_env, tmp, constimm);
>          neon_store_reg64(tmp, a->vd + pass);
> +        tcg_temp_free_i64(tmp);

Huh.  I thought all the a32 stores magically freed their inputs.  I guess
that's just the general-purpose registers.  Anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



