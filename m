Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B98C3F2CD
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40E924699
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+uXBj3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40E924699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8SiS-0002mB-Vh
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 12:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8Sho-0002Bv-6m
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:48:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8Shn-0007mG-9T
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:48:44 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8Shn-0007lv-3r
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:48:43 -0500
Received: by mail-pf1-x444.google.com with SMTP id i13so4390588pfe.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 09:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jSlNKAMXmss8EhwJSP52lcTwTCKmOg/RvpndiWjJpRE=;
 b=j+uXBj3kH31K9Dh2+SunVrj6mgli2QKyvg1WLdnKJicNr7kKxTvI9ea3MWb2NJiRyY
 nTIxE8B1ZXLMe8aU2EZHsWKPsAZVn//cPbpxCRcXXpwOt/q2kdoYdC0CJbykDyWh10lV
 BSlejWTE7cgovW5h0DQQyPYfNqTDO3fxeBRjnCjv+wruJxIHi1p4Q0QmU6naDQWS2Rxz
 qf75KeBslqMlMpMlJMsz3IN8fMNTXHmzL5Ne9lzwLSOMxYNFK9kCrdnNXq1074FoVVb0
 uWqCoAypHLMKqmM2YhSMXbnx8NlQLuz9RLkoJwVocRawsnuCjr0LsltwRKJwu+mqWPQw
 2Mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jSlNKAMXmss8EhwJSP52lcTwTCKmOg/RvpndiWjJpRE=;
 b=DVV0lP4cHzq3xkXzx3fTR0WJ38zuqckM18JLlr5jBiZ0Ti7Mhpu9YWJqIQid6Z7Pfo
 2Sg2fdqxPjoGVcElEnAs1xbXsj/lswgcGT6Jz4oOO/Tpw3y1h3kgy+SQ/mS2KzP2UX9H
 q8xrNac1ORgpv32Wz2il2/uQVbitxGfhC5D8nQcdNQTFtCHourlHzeg22r16GXwByHJJ
 EGYwev9d9ORF7jMXc1yKn58FQFL4VloeQ1CIqhzP7qjaP0+IYhho2PY8w7SeMHts1Qan
 xw62SbKBAmKS12wIr89sPCXCiH3a+3kIhhJaARpsVvgkqB8N/d2fHcdSrf/Jef5+Tz/F
 BiJg==
X-Gm-Message-State: APjAAAVYMboFoGVCcb2V8JR2s2JnELToQVMEwhF6NpDuxjXNmUceLHDk
 /rsr1BWebPSI/BNZ1yuvhFNb9A==
X-Google-Smtp-Source: APXvYqyJy+1te3U1BALuZ1xLj/fIzvExcpXrwcNG9kEo+ohNIMLoDNb/SjbWb+Bp5akfK6SyuoBa2w==
X-Received: by 2002:a63:a052:: with SMTP id u18mr15616653pgn.210.1583084921874; 
 Sun, 01 Mar 2020 09:48:41 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 y1sm14596637pgs.74.2020.03.01.09.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Mar 2020 09:48:41 -0800 (PST)
Subject: Re: [PATCH v2 3/6] hw/arm/virt: Introduce finalize_gic_version()
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200301104040.15186-1-eric.auger@redhat.com>
 <20200301104040.15186-4-eric.auger@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d887a5d4-8142-58a7-b500-c18ac3b78905@linaro.org>
Date: Sun, 1 Mar 2020 09:48:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200301104040.15186-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: maz@kernel.org, drjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/1/20 2:40 AM, Eric Auger wrote:
> Let's move the code which freezes which gic-version to
> be applied in a dedicated function. We also now set by
> default the VIRT_GIC_VERSION_NO_SET. This eventually
> turns into the legacy v2 choice in the finalize() function.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/virt.c         | 54 ++++++++++++++++++++++++++-----------------
>  include/hw/arm/virt.h |  1 +
>  2 files changed, 34 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


