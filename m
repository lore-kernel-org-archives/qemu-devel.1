Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4F1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 01:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87687206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 01:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SyaKvsH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87687206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAkgM-0004JJ-Ov
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 21:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAkfR-0003er-Ke
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 21:56:01 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAkfP-0004Ut-PU
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 21:56:01 -0400
Received: by mail-pg1-x544.google.com with SMTP id m34so235819pgl.11
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 18:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SqBE+QZImkJx1UoFXECqB/7eAHYVhEBVAhpya8pPFMM=;
 b=SyaKvsH+6AJts4QkVuqlgT4TAD/t4+Th5wEwXmw+8vNekelEundWu1pgMYz4q8He4A
 ahL1zaosB3J3ClvUYQ1soTiuBfMl9LRVBFZ5wVhN0UkZbnaZMOv//qXlzVb6Z3oq/dYE
 hkyNAdrtlFxU6AjKiIEt8m6RqX5wcVilIvwITAm9vHjZYZ/EPCEFSaTzLD127Vi4Lf3L
 TNWMELpnjEkdB0l7CnInYt5eNp2dKk+WYB01FmbY78EZdkqhIR7OXGamKE/6pimEbmGy
 xQxV9rG327gxod3P0+hf9ev6FGhwrPRbAH2wnQLZ2ILQBHEdcNCKWmBtzRb+XOwnyPo7
 yJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SqBE+QZImkJx1UoFXECqB/7eAHYVhEBVAhpya8pPFMM=;
 b=PAppDQdcsjW7IqnAn10rmrV1tnKkujMfNYqTFKbuPRRr/1UnvXyzuZzBapAQSK/sWF
 7cFmziUvyuSDsybN+ea+Egg+xumCg4uEDjgBiJhwU9gNp6luwohpJ1q2bRj2AaLGe7Pr
 8n2h+QWr9lBTVx8sf6C3VsisjD25+BQU5rKEmPaien/RT0jFmAoOuFqhg3bkfZSbpwbW
 wFEhmtGqGWslhTy3LfefPonWwK6g8jHn/RJ5Pz7GDHMnlOeCiUYrbiALOzGPV5QiFuBL
 K/jlDfx4QALW9ng2XJZYEDuKtEB8nG6IrKQwRxRHOxyvxILEP5XMxbblA+n1vGlwTo2W
 T9Gw==
X-Gm-Message-State: AOAM533ezNU1wzZ/IQThjKOtZjH6dppw8hxsl1+xOAyZ5F0jeyM4qlK0
 j0LQF30ojxTPnHlCQCi0nSdiMg==
X-Google-Smtp-Source: ABdhPJwI/c+HZVnjari29WEi42g4D+nWiJB5EPsl0OCFHkev1Mwlq4fcOIyMoI3fxou+GwI2tByczg==
X-Received: by 2002:a62:1714:: with SMTP id 20mr10241698pfx.133.1598406957460; 
 Tue, 25 Aug 2020 18:55:57 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id my8sm314614pjb.11.2020.08.25.18.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 18:55:56 -0700 (PDT)
Subject: Re: [RFC PATCH v3 01/34] Hexagon Update MAINTAINERS file
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-2-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5adcae40-fe71-2e14-5e18-c64388755bd9@linaro.org>
Date: Tue, 25 Aug 2020 18:55:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-2-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> Add Taylor Simpson as the Hexagon target maintainer
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

