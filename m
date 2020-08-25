Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D60EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768BE2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRFgntni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768BE2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAdYp-0006HP-QJ
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdXc-0005JX-PL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:19:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdXZ-0006OG-Ob
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:19:27 -0400
Received: by mail-pg1-x542.google.com with SMTP id o5so7401679pgb.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=vs+PEI1fEoLIhKUp/fCWO0LnH+Tv42HxTAk/bRgdsvs=;
 b=VRFgntniwsORs6ZZ3i3U81tnmlM98eVVQKrm3cv+gL1UcJ7hAOQyeNbhWxxkBnKjVO
 h89wlH7G8ws0ZmtdNqRi/1AtVlhta8dDUnuojw2NMHwmCIiWh79Z03zt0DI1jsVKSYCQ
 mxWroI9WfL5bKhnJpyGnFI5ZqX64S5TQCoV+mQ0IGQ30RIoUg9VkyHs2cw62gDTtrguy
 sQsaBOiVOVNrgTlwfe91jQoHNwk8X3qKIUVhLHw8l5lHvtYU8eccmUiBFYMGvEkL1/qy
 WMSHL06lTv/Iq+HNBWM5Zspan348auoZnOX9y/M/4UAOJZV5DvZlv1mHRQwXAmUS3zdZ
 wIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vs+PEI1fEoLIhKUp/fCWO0LnH+Tv42HxTAk/bRgdsvs=;
 b=HUdKb+lxsHGJgJ3LgBDX1Q3LxlljSO2z1+psMLVc6IiNqlbZ94mMGdSwpICxIc8+PJ
 DnMclyZl9p8iwBuUiBle3Q5oNpq2gJC6rnhBHCvPnAZHSbUfx08ae6g5WLEkjUHMir3d
 iz54wmQmPMMa5ySnZpLRoqmGXd2bYDTOKWo9bH05WN/HE6S3APdtMfOk1Evnkkp7ba91
 XkMduqPIGmtDsL+LPijKipM8LgsNG5H6+l0IjBwbj9VtpjHYnibqEB5jSUKWIZIpiUQS
 NmUeCs5aq4NXt7ej1HJXNv2l1sBz4Aoa0+2QVPYLitPe4cw4pdVTmGUAwQXwLECLJCLx
 /lAw==
X-Gm-Message-State: AOAM532a17Dm6fSpvv+p4bI2yH1rtVdh5Zv1cGxAOwzTIVOipP7/QROC
 uxUunkLUQJ0Zr4i6w4ReT9fQ9u4zeyfQwQ==
X-Google-Smtp-Source: ABdhPJw3BKLWpqgK/J5UOmRPzZykibwJT9dVpuczy3WzUwbgqq5nzyKHA2CJ/EX+AM0HtcFQZ7caBg==
X-Received: by 2002:a63:d410:: with SMTP id a16mr7599948pgh.133.1598379563590; 
 Tue, 25 Aug 2020 11:19:23 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id b185sm16020787pfg.71.2020.08.25.11.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 11:19:22 -0700 (PDT)
Subject: Re: [PATCH 05/22] target/arm: Macroify trans functions for VFMA,
 VFMS, VFNMA, VFNMS
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <df10ae80-a135-dabc-2a4f-ca86116b895c@linaro.org>
Date: Tue, 25 Aug 2020 11:19:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
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

On 8/24/20 7:29 AM, Peter Maydell wrote:
> Macroify creation of the trans functions for single and double
> precision VFMA, VFMS, VFNMA, VFNMS. The repetition was OK for
> two sizes, but we're about to add halfprec and it will get a bit
> more than seems reasonable.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.c.inc | 50 +++++++++-------------------------
>  1 file changed, 13 insertions(+), 37 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

