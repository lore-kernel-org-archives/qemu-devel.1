Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56B7C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648762072C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P96J4UjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648762072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLBE-0005ab-Hy
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jFLA3-0003yw-PP
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jFLA2-00080J-9C
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:10:19 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:54039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jFLA1-0007vT-Qv
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:10:18 -0400
Received: by mail-pj1-x1044.google.com with SMTP id l36so2769585pjb.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=D+i1jAFfg9AwrpQyj3ava42UGKo902FzmsPePOfKEco=;
 b=P96J4UjOLn12KzweIP0VpOFXt89+pTA40nQBIURGdE0hQ4jH8X+2kOjCCkPDdyt5pT
 d5EasbCI9GqHCCoLQqfN+Bnq6aq4szQiNw/Og/2C5TtBwLII+J3W6V+vR+0y7VanZpYx
 loY/j7LR7I5jy62J1S+hR+/8uRXZ9Ton8/vCVmh3SvO8cxrCGvh0ZtP35ZEQJF95yQy9
 +T1LH/BzvWquRxaTvzuwnsBpWZm31fOZQr6HgbYyOKw2xK5Ei16R16kf7v0u5APMAVjP
 IPziXhh5Gxara/ySbO867G8iccD+4o0EVFJ/zKHikRgl0PNFBjtw3xekSqsJN2Edtgvn
 2hTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D+i1jAFfg9AwrpQyj3ava42UGKo902FzmsPePOfKEco=;
 b=cOAyqSTCyBh2RJ8U7bfb1T4M2YssKCe2Z2mWjxt/9UEqrUcGuOM7be3llq/1NnS3jp
 qEdOBL6cPmOzwi+3vmt/YpzYcZ94KLUonScV+1PB1Y8nsM4uUl5iu8/+3b1mLP13MJrS
 a8jfGxHoO5zv7rHSjgtnO/8sGxa6Go+0UBtBPBaZsnAxYke55lj7fVkFxNdiOZBcB7lg
 E+IrALh0M7SfGo0yQGkUaP1e1zA/jKcv3n2f9iOweJLTHyvu+/X0sjQk4ZwXG0w5KguZ
 L6RNj6jINe96xEs87+4tqMTV9Sv74nJgevVMit7fltOm217tMWUNjzgzwa2YMCgz0oQS
 cudA==
X-Gm-Message-State: ANhLgQ1jhYq6z20vzwvROdlIfwpbJstYRQUIta/vhukqj/bOolnTcdc+
 vEX7WDei+5BI7RI+wOsePgK26BbOBFs=
X-Google-Smtp-Source: ADFU+vtIwaiOGabQsHkmX8rSdzRU7CC1iaa0tntmPe9Nd+3gPS5KDw3mOcLL9jLBnnINNWPKFSMTlg==
X-Received: by 2002:a17:902:a502:: with SMTP id
 s2mr9435860plq.204.1584724215547; 
 Fri, 20 Mar 2020 10:10:15 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 v1sm5242252pjy.35.2020.03.20.10.10.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 10:10:13 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] lockable: fix __COUNTER__ macro to be referenced
 properly
To: dnbrdsky@gmail.com
References: <20200319233454.1856568-1-dnbrdsky@gmail.com>
 <20200319233454.1856568-2-dnbrdsky@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <77474770-f223-a85e-bb99-461c5be97841@linaro.org>
Date: Fri, 20 Mar 2020 10:10:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319233454.1856568-2-dnbrdsky@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 4:34 PM, dnbrdsky@gmail.com wrote:
> From: Daniel Brodsky <dnbrdsky@gmail.com>
> 
> - __COUNTER__ doesn't work with ## concat
> - replaced ## with glue() macro so __COUNTER__ is evaluated
> 
> Fixes: 3284c3ddc4
> 
> Signed-off-by: Daniel Brodsky <dnbrdsky@gmail.com>
> ---
>  include/qemu/lockable.h | 2 +-
>  include/qemu/rcu.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

