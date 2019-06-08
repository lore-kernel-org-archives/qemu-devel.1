Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F332AC28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5AFD2166E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWFGlibN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AFD2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60248 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZhRZ-0004fL-2j
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 15:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38766)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh3Y-00011G-No
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh3V-0000g2-LG
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:31:12 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZh3V-0000NM-9C
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:31:09 -0400
Received: by mail-ot1-x342.google.com with SMTP id l15so4903906otn.9
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 12:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=D0T3yZRfPk4lDB6Edil8u0QZXzCrtgAdNUf1qcTJrrs=;
 b=lWFGlibNiT1FQDAJLOu3Y4C+B5GlF8yYTQ5njyJL/t8ejuDKfgCHX2q5pQTB4AJUKq
 iXVgSibXTzG4g0hzfK+GJGnrC6zxlBmGAbZLAZKjrp+eW4avAxY/L+7um3qVAJbMRWye
 CUnjY/hlLN4suUGqPZZPT+mfU2eBvhgsSezWnSu10tyKW7z4giGwAO9iVXLc3KEwbRGF
 M28xdeayLf4mUUVQJI0g8dN++uKwfyEBzQel8VTkfEUSY+ws8Mu/t/ETM4HoGIziTKko
 CD8kkg96LuINIHmF3rgfFJQ6FZA2zNUkNZCDLa9+W9Y0ocXDCZ0ch954mSFKSVj2S/8X
 FSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D0T3yZRfPk4lDB6Edil8u0QZXzCrtgAdNUf1qcTJrrs=;
 b=r4zwRFnZhnomDyOOI1r7Imsu0+67njpK697Zz7px8AJKKe2xIhpAiAo4XfRjDGyReB
 2GY+zfUBQLU/pPCs1Xje4yPkRPu36dbSntqX3G6C50Na39S1+OR5kwFK1gYJdcHr32Kc
 dpKt9tPtVdVtUmbXAaJ61/2n0vz2h1fOMJ6N6JhF5CIFx5DEzbKafb6GbktameKcIgll
 ZUQu0uFypY2C6xXKVUDpqgVd8G2BIdo7TfTCYs08qgrQ38Ou+UWxewOUOoVHXoa/H+L8
 a9VwqWo+obdjzb0LXIowH0RjDetfeBZqZjoJC6HnVNdojYLi05bZq5S6sTm01yuq8nXw
 2org==
X-Gm-Message-State: APjAAAWQTO+gMZCWPWiQ4sMv+abmvkuwskBkSFd8EQjoj02bVC70P4Cx
 PCvGYVwxrRrDVyJVz0bLNRdkkKfUI0U97g==
X-Google-Smtp-Source: APXvYqx/1EIHKAg5DY4jroNKr/bM6Ie8qrBhVvjNkOMUS3oh8ElIYv6B8tYQ3yHokjEaWohCHCUNOg==
X-Received: by 2002:a9d:3ee:: with SMTP id f101mr23327411otf.311.1560022242263; 
 Sat, 08 Jun 2019 12:30:42 -0700 (PDT)
Received: from [10.219.49.199] ([187.217.230.84])
 by smtp.gmail.com with ESMTPSA id l31sm2221430otc.30.2019.06.08.12.30.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 12:30:41 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-39-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <84935bd5-4efd-e704-ffa1-8deb2d44092a@linaro.org>
Date: Sat, 8 Jun 2019 14:15:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-39-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 38/42] target/arm: Convert integer-to-float
 insns to decodetree
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

On 6/6/19 12:46 PM, Peter Maydell wrote:
> Convert the VCVT integer-to-float instructions to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 58 ++++++++++++++++++++++++++++++++++
>  target/arm/translate.c         | 12 +------
>  target/arm/vfp.decode          |  6 ++++
>  3 files changed, 65 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

