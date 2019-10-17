Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B352DECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2BB20869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GMWG+EeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2BB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL81q-0002p5-B6
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iL78x-0007vI-Ry
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iL78w-0001IR-Re
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:52:47 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iL78w-0001IF-Le
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:52:46 -0400
Received: by mail-pf1-x442.google.com with SMTP id y72so1800055pfb.12
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2g9Gkkx01b2Qn2fktb6Obf7Wpjq/5ywBNmJmc9D4Phg=;
 b=GMWG+EeXlJXGj0jbVac22yoVXojlLaaiZK8oBjVFIUUYR+fvh383lHvnR//M7Tb5eT
 NkbBadzGMiwbDozmSp1eOUFWiykkFcxGNRrAZOwpeiE9Dp/+xuMhUs0sOAqKlqQnAWu2
 fVAXAZijK2+lVJY78xSMIHvEwKvLowHFWEMuwz7rI0igT+d5BomHXQQbpRxy53E7TBkH
 +ykw8Wp6myNnkogMQ3D2xH6jvUBrTJW0ISU/U6cE3S/rJ7A9IFobIYo7b89JXUgafxAg
 hcKT3QODYQvVnlUT9MbY0deTloGHjTTvtIh3SuVABBIfeK7xRnxCtPE9MvGFzuv7Mjr5
 vL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2g9Gkkx01b2Qn2fktb6Obf7Wpjq/5ywBNmJmc9D4Phg=;
 b=ZOMDPBGLW0kpvqY6CMzGOgC5ihaaDNFObWl8zM2tlBWeRWyZOGHkKgvp3rduQL6wLi
 NcryQZpY+ilgAke0wC1/ateZPiT61ygcSXhbnM1u0+j0otfk5Qxbhz89ZuN3ajbzuwWH
 kZU91CAxgwmTg/oMCNdURJALi9M2rGoURWpOxxR//RvbfDJHMEBHnEMRri/KtZ1As784
 xHFAE9jlnTdHpOZBYhmYUHWavV0ULvj7DQxO2vUHkkX9KjLKLtCVn14LaW6h8Bg1OA3m
 qk5zQhcDdhQhcCkWMGf0m/8GR49e0O/gLbh7ro1Wl/WqBwP6DohgXu3vYypefcED30js
 1+ng==
X-Gm-Message-State: APjAAAXkTDSKVryIHcw1Z3/KpSSMuXa4gPOsRxPC42PxxiI3JbcyImT0
 JFtc1ED/iMgoa2WHK/PNsjw97Q==
X-Google-Smtp-Source: APXvYqwf2SHn8Au2sGFVbhWSWNb3FVKu6QfV/LxmpJH4xG/hA1WGkbdQMlP52OKlloYHu6qHe6rLQQ==
X-Received: by 2002:a63:6486:: with SMTP id y128mr2964321pgb.412.1571323965480; 
 Thu, 17 Oct 2019 07:52:45 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i1sm3185238pfg.2.2019.10.17.07.52.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Oct 2019 07:52:44 -0700 (PDT)
Subject: Re: [PATCH 4/8] hw/watchdog/milkymist-sysctl.c: Switch to
 transaction-based ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <52c3941d-0166-c7da-8f47-967674ca6086@linaro.org>
Date: Thu, 17 Oct 2019 07:52:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017132905.5604-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 6:29 AM, Peter Maydell wrote:
> Switch the milkymist-sysctl code away from bottom-half based
> ptimers to the new transaction-based ptimer API.  This just requires
> adding begin/commit calls around the various places that modify the
> ptimer state, and using the new ptimer_init() function to create the
> timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/milkymist-sysctl.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

