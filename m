Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA136C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 20:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D3C20719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 20:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IsbDbkXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D3C20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDw52-0003fU-TH
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 16:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDw4K-0002nM-PS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDw4J-0007VN-TX
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:10:36 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36862)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDw4J-0007KY-Lt
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:10:35 -0400
Received: by mail-pl1-x644.google.com with SMTP id g2so5998534plo.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MY8MkhaDCZV5A/K6qiTfn+gJM+K/rUxU8elb3vMFzUw=;
 b=IsbDbkXVyyfep+K7aPqVt5aCvcdTj3M22CRGivPVGEmT3RYBYmRUSkUMAKDOSoBrWb
 M3BcPZi75ckrZa7mQL0siEnco9vQsyRub/WJ/+5fXmJYckwgZQvpG1OIMw0uDHNg63Es
 Cd4p1EIhzPFLFSUK/ZCK0fSXv/sntjuiFCfBD0i+hp1Yk8qt1DyGP5Hf/0zLw4Bo724n
 rQSHuoh7KDnRQEV5hf7GJwMcORrF0SpAFP5W3YMEXFMLbRlXvWwqM/MU92G34L14jCeJ
 6rCJhVW3ySuh3w/5ley49fbfMu/MXognqfrPoG692mmTcexlDH4PJwWG4k4L544TONBz
 6rEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MY8MkhaDCZV5A/K6qiTfn+gJM+K/rUxU8elb3vMFzUw=;
 b=UhuFM4MI0ueoD7X2iRViuppg7C/WOPH/44RSjTR99oypkK06QvLRVe9GkSnW1xHX99
 806biW1YVERTI35tBhHXxiYx7ge66TvnsGpQqLjUEPgThUvsJa2u0cXq/CR9966m1DvX
 fHLUZtyg7iYR4CMYwQCyIbrVqUCj0U+rlVFQDQC4DxqzrRIQFeqSFQxqd1SpLS7NQeOs
 BO+N5LLh/gAB6915FiUGzpdjwRc3SwdnQCDAAA1yPqod1i4RRLR4psuvhJiMw6WzEP2i
 ClbBCoWN8Nv6JhziGYB4YpS642Z/KAuyBAkydwyoeuhnEP8X+QS8nzu0LWdING36DdqH
 WFww==
X-Gm-Message-State: ANhLgQ0DbPmPhisSjU9+DrasaHudC7jWpFXARF0TvXNF0MLAPWI2Hpa+
 ov6OzVIQkuZ5ZqjjuxU24hBG9A==
X-Google-Smtp-Source: ADFU+vsfOpkbA5/KzKZmtYtj2u6FDMGO7fkFq2kdP+aaQsvpZBgdbHmRSI6nkzzTrUNnSe2NEzBlng==
X-Received: by 2002:a17:90a:a417:: with SMTP id
 y23mr1249051pjp.184.1584389434398; 
 Mon, 16 Mar 2020 13:10:34 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 m9sm329171pga.92.2020.03.16.13.10.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 13:10:33 -0700 (PDT)
Subject: Re: [PATCH v3 07/19] target/arm: Make cpu_register() available for
 other files
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-8-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <78359d38-4fde-7cda-a4e0-d36f1fb8d166@linaro.org>
Date: Mon, 16 Mar 2020 13:10:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316160634.3386-8-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:06 AM, Philippe Mathieu-Daudé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Make cpu_register() (renamed to arm_cpu_register()) available
> from internals.h so we can register CPUs also from other files
> in the future.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Message-ID: <20190921150420.30743-2-thuth@redhat.com>
> [PMD: Split Thomas's patch in two: set_feature (earlier), cpu_register]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/arm/cpu-qom.h |  9 ++++++++-
>  target/arm/cpu.c     | 10 ++--------
>  target/arm/cpu64.c   |  8 +-------
>  3 files changed, 11 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

