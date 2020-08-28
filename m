Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CD8C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B9C20714
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eO7oHpLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B9C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnWR-00035K-Vj
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnVm-0002VC-FF
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:10:22 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnVk-0004ny-5i
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:10:22 -0400
Received: by mail-pj1-x1044.google.com with SMTP id kx11so240744pjb.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 16:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=/86uaWpsV2+7UNCKhxmdHU1qRp7rlhVnoPARlh3Gjdo=;
 b=eO7oHpLcuMdHMEjlP31TjcTTTulRCvcxTh71WSeszU9EFrRSaW4U2kVjLwWVXSX3x0
 0ZnBuhBkOBQfzZYluGEpheOS+8BwwGP6OdraH/Y7L9wSKHN0TC0Wm5h62YsHlZglkwPx
 MrBrtXPafhmQsjFVMZ8Wn6t4dJ9YJjGyBJJgtAzoeOOlabu3E2sm0tOU0lgfmMVtmFcX
 r4CAwWhqHm8Y/vZZuDe1rCsdMGX0sth44HB9VdHS08gY3QGhrqBwAxN8+PtIxLZbJgrn
 mFuZYY6ALGhR0NrkNVAE75h7uUynR6HF1/V/TL6js5fmj6VDux2XTlQoomxfwiuhu6Jr
 xOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/86uaWpsV2+7UNCKhxmdHU1qRp7rlhVnoPARlh3Gjdo=;
 b=opXNm2+t3g1Pauy+kqgwFeucY9imEEgbLxs3iJeLGo+ynPekI7wDFv9kDGY7K9j7g3
 1MzFvSiIxor+JZ5dX+VhdXgnP145B5/7lYkx5Kq6FZAT/Dxk9TF16an1ST+XJz1qPg0E
 z+9qKmDP5jKTmOZTIP/QQzkKDGljYrYWOYl0K1GRjctyEL+ToGruTRcqGLPFrbCWcsgf
 GQlLYrJh49pPGWtoay1YoQlqogr6HAX0U2EiX6L/LeFo6f9229D9UrumJ7ug1jlHZQQc
 oRzHFwtv3nYI9/qA5otUQg4FP4Qtqsd37f6X912O6LUwKx9TV9jknIhUybscfH/yPPNE
 E8nQ==
X-Gm-Message-State: AOAM530cUrqMTjs6/2agHziXJ8wT9vuzcFUcaD09r6TzZATN3NM8zW7Y
 86+uoE1pMbWWaXK/bKv05vmIE2VRx2HEZw==
X-Google-Smtp-Source: ABdhPJzw1GnTmD6UJg8gX/0CuDZoKc09Rha3e2nwabrtrie0WuRaHJ0NeEjG4Rzn2ADWDIX1g6EmKQ==
X-Received: by 2002:a17:90a:5aa2:: with SMTP id
 n31mr1011341pji.33.1598656218313; 
 Fri, 28 Aug 2020 16:10:18 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a13sm500030pgn.17.2020.08.28.16.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 16:10:17 -0700 (PDT)
Subject: Re: [PATCH v2 38/45] target/arm: Implement fp16 for Neon VCVT
 fixed-point
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-39-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e73adcfe-598f-5792-a901-1f5ed79838d1@linaro.org>
Date: Fri, 28 Aug 2020 16:10:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-39-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/28/20 11:33 AM, Peter Maydell wrote:
> Implement fp16 for the Neon VCVT insns which convert between
> float and fixed-point.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h             | 5 +++++
>  target/arm/neon-dp.decode       | 8 +++++++-
>  target/arm/vec_helper.c         | 4 ++++
>  target/arm/translate-neon.c.inc | 5 +++++
>  4 files changed, 21 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


