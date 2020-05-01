Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D933C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 04:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676B920836
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 04:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uhC4H83S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676B920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUN5A-0003g9-JX
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 00:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUN4I-0002vk-Jq
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUN4H-0007kc-Ly
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:14:30 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUN4H-0007hx-6a
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:14:29 -0400
Received: by mail-pj1-x1042.google.com with SMTP id hi11so1882419pjb.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 21:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=yIR2wTWAisCdXRI939a1h78Nt3JYWA/jxRybsJBIBFk=;
 b=uhC4H83SEZk6mJURCrpIaR+mF1WpvyICNUEEotyO0droQ2ODCDS3YajgGFbDdkUiag
 sQg/90vpTnb0IiZXEFSZzC3sKKKhYLSiUHxYtDWXI1eYSGE/LemRswJ2Gt/8bsikXVsF
 KeFlBMJN2GFEY1Mc4Y90iwWETS456cOna8gKua5PFI7Mh9PBRRoHYumu2vXADsdRx+V8
 UUmEJGJqb8o5qAomqgX4Tp2ZtRuaqx80VrKA9B+HnHXjA/W3zBRWx+msp5VntkWFJWlg
 /7v+mYp//kjvX7uKbNkgZZkL+5qBciYYBkcYKxUr+Fe4t5twj5d2Y1ITqeZgON0YyfaW
 uy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yIR2wTWAisCdXRI939a1h78Nt3JYWA/jxRybsJBIBFk=;
 b=oQm9b4hrBH+JtiPxHXyUy1zveLegWqgFeWkpvYDnJkZFwNUt12WREZvIZhwjV0htwa
 lmhmeCG2VVtqguaiQG1+VKnIiOVNBG/HO8GEN1JPRonSlxRoQ9BApv1MYH/lZVNAZxZ7
 YYUoRgZxTsornPRQqDS65ATu0haILpkDDlJx5tybq2Ar7DJn4gW5oX5t8i+XjWcIF+AJ
 nTyVeMXg1XA+HuYWaPMyG4zbjZK/sotTDuVG2DIJzq9svVUG7JZKBhHD3FR4Aljg5rsE
 XGxaOaOIh8v5zuqJya4W4LeYoqv2OxlMvTiXo7AmggrpcAZJEDAMeiGohbAsHPUp7H1o
 TvZQ==
X-Gm-Message-State: AGi0PubTWtrLtoR6yRYs8Hb6F3GKW56LCpn0N7o/bOr3gx940Zy7RdgR
 CN88LEnLC2hLRMFA03Ctiy87UcXwvqg=
X-Google-Smtp-Source: APiQypIx5S4DEyy3qWIOzPJSNsxCw8jM3tJCKSOU+5jsyKxZhaPDDcbVrDINw/sPJnVHdfkFK8y5OA==
X-Received: by 2002:a17:90a:2b8f:: with SMTP id
 u15mr2555910pjd.137.1588306466388; 
 Thu, 30 Apr 2020 21:14:26 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j13sm1003345pje.1.2020.04.30.21.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 21:14:25 -0700 (PDT)
Subject: Re: [PATCH 36/36] target/arm: Convert NEON VFMA, VFMS 3-reg-same
 insns to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-37-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <08b16323-2901-9624-d538-ae64ee089c33@linaro.org>
Date: Thu, 30 Apr 2020 21:14:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-37-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1042
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

On 4/30/20 11:10 AM, Peter Maydell wrote:
> Convert the Neon floating point VFMA and VFMS insn to decodetree.
> These are the last insns in the 3-reg-same group so we can
> remove all the support/loop code from the old decoder.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c |  41 ++++++++
>  target/arm/translate.c          | 176 +-------------------------------
>  target/arm/neon-dp.decode       |   3 +
>  3 files changed, 46 insertions(+), 174 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

