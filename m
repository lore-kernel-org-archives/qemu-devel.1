Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCE9C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1372067D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNBfaetb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1372067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6FnE-0006sw-6g
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 11:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i6FmS-0006Pa-8K
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i6FmR-0000g8-1E
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:04:07 -0400
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c]:40834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i6FmP-0000Y3-42
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:04:06 -0400
Received: by mail-io1-xd2c.google.com with SMTP id h144so13382605iof.7
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aezTh+2CCztN2KsEUXj5ct2ukC2L7Qso7Ma/IlDFJRA=;
 b=WNBfaetbpfibF80OVg0BoN+AcNHsA+nlVfxbxWyqMa5ogLZrU7Vep4fYHs5Q9MwUTq
 OjPmCcUpNg4w7je54Mgecvf7S7zXP0qTplIzogLpnS5oC4H2V7UnAPgcYkGSaBxuqWVB
 IzALlazfYZ2kvg6qrHoCJHxQ+ag9IFkwJJCL3xgWRG2VSibTrLKpPp4W9I2kfnv7zheJ
 3ZgXkhD2LMBZUw8vtPLMV/qnPxJnNwMbHqMqonU+BGs5HKgVW5IbDj1F8zHI4/ix04bg
 V0LsftPcz6WmfGwIskAexMoLVgnk9YQ6hCibfOU3vvWpTYdg+rbSaWN9v8FjYGvCY8xs
 OxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aezTh+2CCztN2KsEUXj5ct2ukC2L7Qso7Ma/IlDFJRA=;
 b=ggRLBWUO5GwQBkUXUHjfx+lagCs+Dba6oykaZV59/i5K9AxLh8AC9Doe3EODc/QUNS
 7qZdx0wHer1W2BnAB13z7xd4nJa3bqM+LdzjbEb0TXV3EZ8w0W/OxFO9++y0/wXPB1wm
 WlS0g1E63avb9GjUwERRtuRc6qXuQPVirfZvkR8mhWx5JtVeP8Q5848NzdPiXVqQysxU
 M39HAP8gbjDb8fdGRX49/QpXa1EsbsGMMOw/nIa4RH7EhfYnAghG8UJWU5nS1eAibx7E
 5RwgWKm3QkPLa2CcBhcJPe8alFUVxaSwPqHHqeXR+1VrGJ9myzbnxVftKmYjZqoZdbWD
 xRIw==
X-Gm-Message-State: APjAAAXprvzArtLs1ezrEMma+wakrHuDE8DaJkRXzVS6V+q/xtjwI9k4
 YsFwtedYn01E7mKFYSpx6uVG0w==
X-Google-Smtp-Source: APXvYqxbaMRE1pVk5h1QF31v12zpAAGmEUF4Igl3s2wOlSy6jC0EfE+SWPJH3Gq9GqucYVMM3i8Viw==
X-Received: by 2002:a05:6638:155:: with SMTP id
 y21mr10521182jao.112.1567782242626; 
 Fri, 06 Sep 2019 08:04:02 -0700 (PDT)
Received: from ?IPv6:2607:fea8:a260:81:78cf:74ad:c2b2:73ef?
 ([2607:fea8:a260:81:78cf:74ad:c2b2:73ef])
 by smtp.gmail.com with ESMTPSA id l8sm3800042ioh.85.2019.09.06.08.04.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Sep 2019 08:04:01 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
References: <20190906124706.19145-1-alex.bennee@linaro.org>
 <20190906124706.19145-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fd822874-4ffc-3417-d0ca-b82316de53b5@linaro.org>
Date: Fri, 6 Sep 2019 11:03:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906124706.19145-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2c
Subject: Re: [Qemu-devel] [PATCH v3 1/4] target/arm: handle M-profile
 semihosting at translate time
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 8:47 AM, Alex Bennée wrote:
> +    if (arm_dc_feature(s, ARM_FEATURE_M) &&
> +        semihosting_enabled() &&
> +#ifndef CONFIG_USER_ONLY
> +        s->current_el != 0 &&
> +#endif

This last should be !IS_USER(s), no ifdef.


r~

