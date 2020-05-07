Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F3AC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28E5208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zy9nAa67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28E5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWlM6-0004FY-VR
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 14:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWlLA-0003mu-UL
 for qemu-devel@nongnu.org; Thu, 07 May 2020 14:33:48 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWlL9-0004Ha-Dn
 for qemu-devel@nongnu.org; Thu, 07 May 2020 14:33:48 -0400
Received: by mail-pl1-x642.google.com with SMTP id s10so2413407plr.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=WNQuWrTJgn1E99CUdPU8uTiSHAMzxw6zlAlfFRqeu1A=;
 b=Zy9nAa67KL0DTkQsZR8a6I9T7ep0Du6Me1EOn7ZjRc29AoRils029bFELO/K74x0T8
 57LlA1ES3XrT3dIyHG0DXzqUiezUIWM+iDpNR1XMSlDYghR6ZModJBsJfrN1C44iUHfe
 4XDgqD7E48tM68yFN9AZyK/ykAUH8N7T8FNSPrb0SRyrWgaNBPH1gF5e9yoo0VhkGQey
 x69KFuOuY0VkCAFl7n41TddEUEqLnKEkrnm0dYnZFci75WFhg4P5RLUZeOVoZacyNG5Z
 KCzEonyjGKFYPZkjJ9Jux5UCi0BUSWGtXEoHkz+b9K38+wTCpGDJ1fFEMRHAQj7SD8Lt
 G3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WNQuWrTJgn1E99CUdPU8uTiSHAMzxw6zlAlfFRqeu1A=;
 b=jy0vt3+rWUbbqqCmCCqrKsQDwU/ubtQjuDmabHjTjrjHIKObaIlG/+qmTJnDRtTH59
 1Qr6+29k2qlFh8FdBcTgJ0BtYM2I/mN5tV1QiYDOXr4t8JaldWsS/ZOGrJP/4Vy0zIxp
 59oWpBB/v7RE0yAL8FIwFHBIZzP5+h842O2qzRXjnohEYvRYBdXc+sXe3JQrizFxF6Sv
 2XZ0VKWhnDBQi9aDaJBWtXZ1Bn6pFjZsd1oOL6pMYz9yQCdUD9jZr14hujCCZIsA+7Vb
 /rjnsDOv5+r3JpWMSLkDTy37iUZ6TRbz1at4K8wEnp7WpyI8OIL9bT3uAhG/g0NaPrxY
 ySMQ==
X-Gm-Message-State: AGi0PuYThtCm46RhkFYq964TBAZ400Ny54w2LinKU/8kcn0brSCH+ZNv
 HLVwbw9CSrT1gTb/uhD2eWRgTQ==
X-Google-Smtp-Source: APiQypL21A+mG3mwUH5o7d0l5eIKHor4kM+jHpvYjosEmQK45N1I1FxTfiMcaArbxYNQtg1RFKLeWA==
X-Received: by 2002:a17:90a:210b:: with SMTP id
 a11mr1541696pje.31.1588876425245; 
 Thu, 07 May 2020 11:33:45 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b5sm5616603pfb.190.2020.05.07.11.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 11:33:44 -0700 (PDT)
Subject: Re: [PATCH] linux-user/sparc64: Translate flushw opcode
To: LemonBoy <thatlemon@gmail.com>, qemu-devel@nongnu.org, laurent@vivier.eu
References: <894ec93e-05dd-2110-a0c2-e0afa2fa6fd5@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <27e075a8-0ef8-cf17-8153-0bd9354bb744@linaro.org>
Date: Thu, 7 May 2020 11:33:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <894ec93e-05dd-2110-a0c2-e0afa2fa6fd5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 4/10/20 2:14 PM, LemonBoy wrote:
> From 11d0cfe58d12e0f191b435ade88622cfceb2098a Mon Sep 17 00:00:00 2001
> From: LemonBoy <thatlemon@gmail.com>
> Date: Fri, 10 Apr 2020 22:55:26 +0200
> Subject: [PATCH] linux-user/sparc64: Translate flushw opcode
> 
> The ifdef logic should unconditionally compile in the `xop == 0x2b` case
> when targeting sparc64.
> 
> Fix the handling of window spill traps by keeping cansave into account
> when calculating the new CWP.

This is two separate fixes and should be two separate patches.

>  bsd-user/main.c             | 4 +++-
>  linux-user/sparc/cpu_loop.c | 4 +++-

First patch,

>  target/sparc/translate.c    | 2 ++
>  3 files changed, 8 insertions(+), 2 deletions(-)

Second patch.

> +    /* cansave is zero if the spill trap handler is triggered by `save` and */
> +    /* nonzero if triggered by a `flushw` */

Format the comment like so:

    /*
     * cansave is zero...
     * nonzero if ...
     */

> +    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave - 2));

But this does match the implementation in sparc_cpu_do_interrupt, so the change
is good.

> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 9416a551cf..1a4efd4ed6 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -3663,6 +3663,8 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
>  #endif
>                  gen_store_gpr(dc, rd, cpu_tmp0);
>                  break;
> +#endif
> +#if defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY)
>              } else if (xop == 0x2b) { /* rdtbr / V9 flushw */
>  #ifdef TARGET_SPARC64
>                  gen_helper_flushw(cpu_env);

Look ok here too.


r~

