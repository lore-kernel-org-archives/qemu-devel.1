Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3775AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F320420737
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDUust6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F320420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDqsq-0002Xd-23
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDqs7-0001hA-KD
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:09:55 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDqs5-0005zR-Db
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:09:55 -0400
Received: by mail-pg1-x542.google.com with SMTP id w186so2368859pgb.8
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=F7Thb7UTALsRhFRnKDC3P2vu20+JHSs+vbqgjS2Op+Y=;
 b=MDUust6cxbNhHkktVy1DnX4Bs6KDHdk3CGvcadV0A1swOYCZby3JXx0ofUlnQHYSoS
 hzyJwFKk+4xefn5udOuWoETeUoVraa9rIcXsKyNikIRw3nZUlNoD/wRyn07+3WP7bL8A
 ODcmiD/Xd1OIeIdF0N+4V5ncDWZ2isaoqJOFJRH14+O4FhY3a0zSLMEFL9aamVPAvSQr
 cQw2yxgEBSwpJkWICVS29U9YZvwE1ppT7lZOSjWabKGv05qdXz+pmTeNXVuPaDj2nCAJ
 Uh5yqsW3t/WowbFnls/3OLwLB44xfxaNLeI73Chl95ICGehnFuV4Ff+imr7db4JrJ9GT
 na/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F7Thb7UTALsRhFRnKDC3P2vu20+JHSs+vbqgjS2Op+Y=;
 b=W+eM8EmU7Hay9Yz4hJ0y5/ILRGlmkgUQA4NAymr0+PRjSEUM5zcMw6obf6mTk83lqT
 sTyguNatPLM3dGdyonKpHd2kPKChcS9DBI+KcBWhffc5yrSx/S1u83/LsQ0K0Hc7Wvc5
 xZyL3ILjue1Al8JozjoiIL5j6CGURYLwbNXNCntBwnFatN08uGEB0WOpzH1k3ho690zX
 35LIgNFiIKWQ6S8dm5kAJCya7DFLB5qAFzrI5lFO80xRrDkIz7JCSWFLbSGlm+Q/EDs6
 +/Sz/axb5Hu+iblGP04sGdW/G6czWZwrUTbyKfvIyl6rm0rOklRk34Kc6rWMaS2hy7Ui
 u24A==
X-Gm-Message-State: AOAM533BOaVBLO1UqOIfmgxEgx05myt7LgS45AdaUg5ePxpM5r6TxppI
 fUvjuWjzY+MeZEVpI0ni4D/XJnr9acNY0w==
X-Google-Smtp-Source: ABdhPJzu1AM8uLiUt2CaHRB+8k19auxy+SBAqSjkeXwKLAwGH8DKO4ac166JhTvrfnEkTNMxLKxbYw==
X-Received: by 2002:a63:9d02:: with SMTP id i2mr3238711pgd.378.1599145791155; 
 Thu, 03 Sep 2020 08:09:51 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id u15sm2944336pjx.50.2020.09.03.08.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 08:09:50 -0700 (PDT)
Subject: Re: [PATCH 6/7] hw/display/artist: Fix artist screen resolution
To: Helge Deller <deller@gmx.de>
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-7-deller@gmx.de>
 <65284ae3-f0fe-336e-a205-0494abb20f08@linaro.org>
 <20200902214819.GA2424@ls3530.fritz.box>
 <45bf91fd-4e7f-7379-18a2-cdada67a3f6d@linaro.org>
 <20200903060936.GC8548@ls3530.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <53381e05-2116-547c-98d3-4d184a533a9f@linaro.org>
Date: Thu, 3 Sep 2020 08:09:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903060936.GC8548@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 11:09 PM, Helge Deller wrote:
> New patch #3/3:
> 
> From 476aeb9b832ae172a9d6a28aa9e43300dedd419b Mon Sep 17 00:00:00 2001
> Subject: [PATCH] hw/display/artist: Allow screen size up to 2048 lines
> 
> Adjust the ADDR_TO_Y() macro to extract 11 bits, which allows userspace
> to address screen sizes up to 2048 lines (instead of 1024 before).
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/hw/display/artist.c b/hw/display/artist.c
> index 16d85c65f8..955296d3d8 100644
> --- a/hw/display/artist.c
> +++ b/hw/display/artist.c
> @@ -193,7 +193,7 @@ static const char *artist_reg_name(uint64_t addr)
>  #undef REG_NAME
> 
>  /* artist has a fixed line length of 2048 bytes. */
> -#define ADDR_TO_Y(addr) extract32(addr, 11, 10)
> +#define ADDR_TO_Y(addr) extract32(addr, 11, 11)
>  #define ADDR_TO_X(addr) extract32(addr, 0, 11)
> 
>  static int16_t artist_get_x(uint32_t reg)
> 

Thanks.  All 3 can have a
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

