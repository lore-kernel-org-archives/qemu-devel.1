Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC755C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894C020663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RvFKMpWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894C020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv46m-0001XI-Px
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv45v-0000h1-7f
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:26:31 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv45t-00073X-M1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:26:30 -0400
Received: by mail-pj1-x1041.google.com with SMTP id b92so328549pjc.4
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 12:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6gMLMgb1XnKjOZUtBcsoH9XsMQy9aj9Gj6h8GM4JMAg=;
 b=RvFKMpWhHFDkko0llZEMPPZUzhbDe0EJpZKgmh8BqKW5lUSaReGE2mh2EJFAA3pYCg
 BLchDP+Nzu496DBSZJCsmx8BN2u0pyoZEbqv7YBWzBuT0uDw7pGVM9JVbXfyf9kk3rxG
 DuJcB5uAWxYm4KcCokNhPKuRXU07BtcB0c5UXz/qO+LGCnR8RonL6drKL93zNGhXKhi4
 NJfmtKI7dijY0QwLr2Y38RooZV3MkZDQnne+pVyy72oNgZ6zs0bN1mD/hthx3GQLzUpT
 zimWPeV6fVrfuGCuH5c2q3B5xyUPETSa1Si0n68NSv9eM/MdaZ8jEnWAiz2em7HJG3Hz
 B0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6gMLMgb1XnKjOZUtBcsoH9XsMQy9aj9Gj6h8GM4JMAg=;
 b=B1zBR52dsBOYNQmbztcX/8Ze6oVSGlO8Dy6ih9JErsa/1km2DYZyq1ahTkQzCbTSnM
 zIGraLFdjF4ozxQ8okyaW+qtsbyRLs0x7NLi7nfnwfu74ccuqkxefAOjPs5jsTsokWQj
 XoePGA9NBnZ0zoJeQm7NseteyQnrbfS+YaW6aC04bi/5lKIfSraTcAjdQlrCvM7Ceu6y
 1yYSakpT0vcJ+aXyfLNMlDSvDdrTn+ZcRHVZnjkTNzlnjcf0uKDyChy1YoBPaNQJ5V32
 ZfxlEE6KkyybHIXtwuclYUCGITuByDXuZv7cLt8C0BitmoS8hvI0TG4oJeLs9eGe8fYz
 xhfw==
X-Gm-Message-State: AOAM532SIZNyhgXA73uulqUSdVu6FWz5souibx298QbGsyPW4lyqr5Gd
 mAdE6U/g8t7XzTlQzORf89S56Q==
X-Google-Smtp-Source: ABdhPJwda4pHm9RHPy6IYzVRoE+/wEW8mp0zJL2yRl0pXbh5jKmETCYsSBXIOgCWyPlX0bRo/DKhNQ==
X-Received: by 2002:a17:902:9a07:: with SMTP id
 v7mr959083plp.312.1594668388013; 
 Mon, 13 Jul 2020 12:26:28 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id n22sm322765pjq.25.2020.07.13.12.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 12:26:27 -0700 (PDT)
Subject: Re: [RFC PATCH 5/8] fpu/softfloat: define brain floating-point types
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org
References: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
 <20200712234521.3972-6-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1c090feb-0101-ce1a-af8e-2f7e45fd5053@linaro.org>
Date: Mon, 13 Jul 2020 12:26:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200712234521.3972-6-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: wenmeng_zhang@c-sky.com, alex.bennee@linaro.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 4:45 PM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  include/fpu/softfloat-types.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
> index 7680193ebc..8f8fdfeecf 100644
> --- a/include/fpu/softfloat-types.h
> +++ b/include/fpu/softfloat-types.h
> @@ -112,6 +112,14 @@ typedef struct {
>  #define make_float128(high_, low_) ((float128) { .high = high_, .low = low_ })
>  #define make_float128_init(high_, low_) { .high = high_, .low = low_ }
>  
> +/*
> + * Software brain floating-point types
> + */
> +typedef uint16_t bfloat16;
> +#define bfloat16_val(x) (x)
> +#define make_bfloat16(x) (x)
> +#define const_bfloat16(x) (x)

I do not like the val/make/const macros.  I've been meaning to get them everywhere.

The word "brain" is better translated as "neural-network" in english.


r~

