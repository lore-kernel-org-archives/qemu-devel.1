Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43B6C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 06:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95ADD2087E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 06:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BaQWdve/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95ADD2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzEbs-0002u7-OR
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 02:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzEbA-0002OU-8J
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 02:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzEb9-0001Hd-3X
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 02:23:28 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzEb8-0001HA-Sc
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 02:23:27 -0400
Received: by mail-wr1-x442.google.com with SMTP id k2so5401886wrq.2
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2019 23:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GgmdOZ8wyLcjx83w+lOaDNmfBK84m7wWuH+PGL8yXz8=;
 b=BaQWdve/rqUr7A87Lvj5CX5+HGZBwNaurPldYNzByL41kmcudD9m79B3QGrgt4u2XV
 z/aQnjudxxpVppn6GWNOdjdaH3UEDiRl/RuLEOh+srxnii7ix888fBcb+OpVmdZLvSz7
 cP0Slc4+Le+dQy8zfLxy+SWk+g2D6KfQEKly4GiLHCmRncaA70anXW2ed0uWFgtJgYZ3
 Fla37tUpQTr+QHGTl+7wGg+Wi30Rj767h3C67XOvxSTgM1RO1WLQc25zoCiqs2bDV9dl
 Q8OLYfz/9VtJ6/5QogyoC0b+kpJKTbFdgiRqoAWp5tuXrPC0RmL4m3aDOH4BiudukD8p
 L5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GgmdOZ8wyLcjx83w+lOaDNmfBK84m7wWuH+PGL8yXz8=;
 b=iV286/n8a7JFnxAZH3PUDGj6fPgoMMCUWapIxfVXWUg9uDVB1sRExt5cbMqVSsUL0A
 J3uoKUV+WHubl/j4apUcsEPR+HNmblXUH/fgukIXIwo+ggBQPnX0LjLjRtzu5XxmFdsZ
 YCx2kOhlKNuftUCspJkt23+9bpFU4Qz1J64+e791SCpnjWM3Yw7MvoPLNIjBsyzpebJq
 Y1p2hG9JETwdKrZ5Sf3AGV92vHsrAUx/GEO4dqNU4/w89j0h/3Nc3c8bl/MnH2gXCvtb
 AYuJq1F7STHbYF+oO2pbo0dXTWp2vhSCtAds/hr+dA0nNzPTIePE6ZREVN0Xogtmres5
 zl7w==
X-Gm-Message-State: APjAAAUJT2LXp+bmv0UzmmeJYxpEnrw6cMKNqApvQ1TAunUMhqprSjI5
 uInkwUzH27+IfeJ/e1r/BTHWnT8LDzU=
X-Google-Smtp-Source: APXvYqycRAD/tPCBCp7QFkzyfk4da+CQI4RqHJikiqk9YUNpn56nLVGmvT1k4FPxqzLY+rN2hHXXBA==
X-Received: by 2002:a5d:670d:: with SMTP id o13mr18676953wru.289.1566109405307; 
 Sat, 17 Aug 2019 23:23:25 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id p13sm12246829wrw.90.2019.08.17.23.23.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 17 Aug 2019 23:23:24 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190816125802.25877-1-peter.maydell@linaro.org>
 <20190816125802.25877-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b7f30ef1-322e-e77c-29f7-84bf4370817f@linaro.org>
Date: Sun, 18 Aug 2019 07:23:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816125802.25877-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Take exceptions on ATS
 instructions when needed
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

On 8/16/19 1:58 PM, Peter Maydell wrote:
> The translation table walk for an ATS instruction can result in
> various faults.  In general these are just reported back via the
> PAR_EL1 fault status fields, but in some cases the architecture
> requires that the fault is turned into an exception:
>  * synchronous stage 2 faults of any kind during AT S1E0* and
>    AT S1E1* instructions executed from NS EL1 fault to EL2 or EL3
>  * synchronous external aborts are taken as Data Abort exceptions
> 
> (This is documented in the v8A Arm ARM DDI0487A.e D5.2.11 and
> G5.13.4.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 107 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 92 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


