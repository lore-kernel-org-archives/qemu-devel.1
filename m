Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08086C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FE02082F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCtkP7sc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FE02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1afF-0003OI-0k
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1ae1-0002Nk-UJ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:52:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1ae0-0006Cy-Sz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:52:25 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1ae0-00069n-62
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:52:24 -0500
Received: by mail-pf1-x443.google.com with SMTP id i6so5942821pfc.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CbZNzgjrGSjXcMZsbGNkGs/yDru9vx/NqV/8iaU0Se4=;
 b=vCtkP7scs1q1XB2DJNx2RGaUQPUxvxilT5wdGsSOc9iG5jQ+mFcemvIXyBgGAXzb70
 tOanwnHlN+pHNtgVuVanZ8+pDfJFGkOMdv01mp2jV9hkuCH0LtLq1U5Rjns6qTFA9yC2
 1ci7P6/BX4scm7uVS44EI7Scwal/SwF/GjGMCVQxMFusCEQEFVM7v9ZpD46JZZqabjEb
 z8VR1Cf4fg5z7uE1i+wfZNLpQ2RM8KVk103+9Xnq/lowFPLO63oVepJ65lGl/jXYUwMR
 aHw7W4Oh+ImBnxFt2VgrJ1G4tzEDWp5m0QIGVPGxJLsoM+nesLICTh8IwC4K65CXzj9a
 +/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CbZNzgjrGSjXcMZsbGNkGs/yDru9vx/NqV/8iaU0Se4=;
 b=ZexuN967FIVw+2yVSW8luXO+tExZOEagMPw1NuV3AKaIO1CXi/TeShLcij4khJE5TS
 oXhfCUdjVmJy8BD08KNcHSVUC1/RAKbFUtKUBT/8WOPPrp9bT3I6lFwFk0WW66PnTlkF
 TyTKMdpSv2fcQwrWkYFHEVKiZqc6RKlWXxFj39t/SY5cA8DaYNGzcZTA3+addY6SQeyt
 pqrkaeYdQ15iKBGSHNQPG/hSOL1oYJYN10tA1QNZqXpm2WijSRmzkFDn9Z37GEIBm6RC
 c/we6QSWQ8nB4r2t2l5uazOe0VIPKPA6wfaSyjQjAh6OJddsidcFwXvscFvx2Kv+zXgA
 ZLng==
X-Gm-Message-State: APjAAAV1/SnHIkTGO5UAnTWK2NimaSJl+9IY6w+S/kfOFT1c9thU6sV3
 rmuluF2lZPMaqUNV+5/jlO79Cg==
X-Google-Smtp-Source: APXvYqwa6BCt3r63/SOJBBqDI7rJDR3zFavMQrztXhPo5HqkwZBgiBlzGOPzvLb77yTkTp4rg32mSg==
X-Received: by 2002:a63:1503:: with SMTP id v3mr4491495pgl.295.1581447141585; 
 Tue, 11 Feb 2020 10:52:21 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 144sm5479098pfc.45.2020.02.11.10.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 10:52:20 -0800 (PST)
Subject: Re: [PATCH 12/13] target/arm: Correct definition of PMCRDP
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5e32fd9a-e872-93ff-b3e0-0e8fff5faa4c@linaro.org>
Date: Tue, 11 Feb 2020 10:52:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 9:37 AM, Peter Maydell wrote:
> The PMCR_EL0.DP bit is bit 5, which is 0x20, not 0x10.  0x10 is 'X'.
> Correct our #define of PMCRDP and add the missing PMCRX.
> 
> We do have the correct behaviour for handling the DP bit being
> set, so this fixes a guest-visible bug.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

