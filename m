Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76102C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4762177B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WkU4s9Vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4762177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2z9h-0006XZ-IB
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 11:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2z8z-0005zq-4Y
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:46:25 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2z8u-0001Pu-Ar
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:46:24 -0400
Received: by mail-pj1-x1041.google.com with SMTP id c6so2343224pje.1
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=b/Xca15rvh3n0v8MEiQabMTRXvyQ9jQTCuAzEkAyiX8=;
 b=WkU4s9Vj8WvMb4rSSwR+IUnr2wcVowSXwsS5E0+T/WxzTmOIBy8GoM+qx2FyGWzM4+
 zNJwPh/W2ixzGmve8erMEAD9OKwC0NDDy5TjtJ6OPBmnBSZwpoJgfELahvagHJGtyrR2
 Hg/VctIAJHYei87wdYsJ/qqF2/ttK0XtAl6J6k+VxJyE6kNn433V7fe+Zjh3DTuN1LBU
 lBddsQc67mSaZDvaU3grDnTVpbAcUTdRsW+ZgG8gYr9FHwDShntae38PvmAfu2/Qeb6R
 RzdHEeQZHwA3MuV88nAOGhfhM3Lql3EFippKKI3O+WAmw0tx7loMwbFW7WuzDT1+SVk/
 Qugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b/Xca15rvh3n0v8MEiQabMTRXvyQ9jQTCuAzEkAyiX8=;
 b=HPjvYIIijnGIHpmZqqMQGYuEEvGH1IGad42aRIpiSVwmMHgZjzsdOxFRxfrxtT85KY
 3+u8fO108ETlUjvpu1Nv7wn/isQhf1oQ0DeS67zKlhkKrSV/crl6oEWxq0K5LOo45Ifp
 Wa1WKDVZQVZSRHG2WwFhoRoj6rTVAmcosb6Y4rB0ID5FYpFkXv+2f5OKDjFq7mY6GDkD
 0yx0MsKeU9v9K9NTrFqZADstqSSJDT+E3cgeQ/ML9jEtxarH6YWLp9yGYilgO4W7TI2G
 r4/ZBhDsAf7ZnWpiMH0DKUvHbU45sPfi+MmlQSScX6JKBhbyAvDfCRaiz29bmjRg+euC
 djow==
X-Gm-Message-State: AOAM532M9UzTmpuC8RjtRHxCsN3ANil9qKx00e1H4b7JyBcGf2RSsYM1
 plFByUsgi6soW23Gl/9fi5R+WQ==
X-Google-Smtp-Source: ABdhPJxlZ0RLGjXAOfXZnkEAIQIvORNAszpvfwzUZtbPqOIlcIzla7PG9+0s483k1S3y6QzJn+iPHg==
X-Received: by 2002:a17:90a:d583:: with SMTP id
 v3mr5045280pju.33.1596555978715; 
 Tue, 04 Aug 2020 08:46:18 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id u40sm3299456pjb.39.2020.08.04.08.46.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 08:46:17 -0700 (PDT)
Subject: Re: [PATCH v2] target/arm: Fix decode of LDRA[AB] instructions
To: Peter Collingbourne <pcc@google.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20200804002849.30268-1-pcc@google.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8d966244-acaa-5f69-5148-414fb63871d8@linaro.org>
Date: Tue, 4 Aug 2020 08:46:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804002849.30268-1-pcc@google.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/3/20 5:28 PM, Peter Collingbourne wrote:
> These instructions use zero as the discriminator, not SP.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> ---
> v2:
> - fixed commit message

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

