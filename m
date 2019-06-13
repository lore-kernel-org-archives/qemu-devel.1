Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88777C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486DF21537
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMKLnW4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486DF21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbXKJ-0006S9-HH
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 17:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48767)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXFM-0001k6-VP
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXFM-0007v3-2O
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:27:00 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbXFL-0007ui-TQ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:27:00 -0400
Received: by mail-pf1-x441.google.com with SMTP id m30so48427pff.8
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 14:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u/MeMwjBxlkKgVf/YPlRl5EN/MDgjaYvWIQ6rwKk89E=;
 b=BMKLnW4/4hCKscGNVnrN8eTIiAKlGTD8Jb7I1Gw3iGA4hQmaEYRgWGuQQ2g57I+Lq6
 CC8uk0ewyw56WD/meJJfCBvSJayCSBSS5l5Dc54noFXLfxwnbOGM75HQbgGeSIDwjAMf
 pyfSdza6JxICzf1cAFfVfjD0/QiLLsLYOtR9yiXvPM0TCqdqoBgaVCSny8Rt13m/ryeh
 d/1u/ihxASKRSmElKHsOKDrbTO0niB87bjf0HlmdEdKbkQTBpks60/Lv1S57tdEOd/vL
 iyT+aLGMxqLpdJxKGTgKUxvqB5JksIWXlTRS9Oo3Fe/AbVUF69I4OMFBq897sW+DDuV/
 VQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u/MeMwjBxlkKgVf/YPlRl5EN/MDgjaYvWIQ6rwKk89E=;
 b=GxeZE5o20hbqaQ1ucSSxMog+h/hu/ME5TCOsEZ5EPloFmig43+1/7ubiH3xMueGxCe
 U5d+mYGLI3jIK8yS09VZ1dAT3ApCpi5/+9rwDB9C5AvRT0hSUPbJFBEdvPD497dfc0mA
 ckjVLsbpC4aR+xfN8Cp2fR4XNrFv7vRg9aVnMpG33Ge0Tzh2YDV8dhab/bD4JHoMIrJt
 UWUlAOnmMo6Bb73auqKH4mLhEzVHKOVFO6RhGpJ0IzrSnobUK4N69o1QJm8qwN8Ca7mD
 BI3cploYJGo3ta7v5LXVq55PzNMqcAud1bT2ou9Dwmbf4yRoGhG35ahYCSvXIWyAazTv
 oRCg==
X-Gm-Message-State: APjAAAW1IjlAYD0iXDe8NM17xlfcz9kUqy4EHkZ6FURQEJNaUOOPqMFl
 hfqzmYTef1q+zxgwOmkl851SG+uUZ9A=
X-Google-Smtp-Source: APXvYqyrGrfBpE4s5qFefheqyN1VZ72cealzqOUgcq1voBkd9a3p91hV0S78XaCvByLMwR23MIjUhg==
X-Received: by 2002:a17:90a:a00d:: with SMTP id
 q13mr7484491pjp.80.1560461218772; 
 Thu, 13 Jun 2019 14:26:58 -0700 (PDT)
Received: from [10.10.150.239] ([149.199.65.200])
 by smtp.gmail.com with ESMTPSA id k11sm562702pfi.168.2019.06.13.14.26.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 14:26:57 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190613163917.28589-1-peter.maydell@linaro.org>
 <20190613163917.28589-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d2c4799f-9659-e818-ca96-6a4065f19ae0@linaro.org>
Date: Thu, 13 Jun 2019 14:26:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613163917.28589-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 05/12] target/arm: Stop using cpu_F0s for
 NEON_2RM_VRINT*
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

On 6/13/19 9:39 AM, Peter Maydell wrote:
> Switch NEON_2RM_VRINT* away from using cpu_F0s.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


