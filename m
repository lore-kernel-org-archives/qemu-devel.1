Return-Path: <SRS0=SBSl=35=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3935EC2BA83
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 18:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23C6207FF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 18:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mftKGZMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23C6207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0rD9-0006uD-7Y
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 13:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0rCQ-0006Rh-Ir
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 13:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0rCP-0003wA-Nx
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 13:20:54 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46758)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0rCP-0003sn-H4
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 13:20:53 -0500
Received: by mail-pg1-x542.google.com with SMTP id b35so2608816pgm.13
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2020 10:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0CSM7y2kSObdwRpjDmcGzsvrTEbJf64bugqbhJSU57s=;
 b=mftKGZMCV9iZadeEQApW5sbhpdZ4OeU+cuADmtrauMTz4ZLoMlcJwry1BTN7s/WFtT
 tkL1yq8O9Lqh/W8O3wU70JmhE+mhudpydiUVX8YEEilK9at0VLt8M18GA6a6MRm+ztbv
 4WLMglKi4IMdo7ghcvA8WB2H4Ux5qVx4SErw7HvoK1GobFpcfK155WE6EKam2fpxX4P8
 htUkTq4nJg+JD2namnqOleCB9LmcFSKfLNzDjNyvcIU1unIzRE+m8V7V7vws+uwVzQjc
 ysuydOP3RHnK6tzFX/ru0x0iNH0kwln56Zv3S/+iOMYhLgjlliW6vSdDt02Zd8WVtE+w
 491Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0CSM7y2kSObdwRpjDmcGzsvrTEbJf64bugqbhJSU57s=;
 b=D0x4xmmtPXhFEvHiSNas4/uHRKBEVMOQBr5qTBjX9zPeYJZs4LivIdA7g1h7sud4uV
 LjnLdffcryx3zzei0P4XTCvoDX7r3g0iF80KObSg9Dr8xYInZpPBzTMMlQcMKWtzipP9
 6E+q4NX61OgrY+nq5jYVfZS26C8FFArecK0Ej70qg1iBOxtTDlW4DjMYoaSRoUdYwfL3
 qWwqvwyGUJKa9Dwfraw3QfK4iGjESl3MXKFPfKcpVyDDlT6wGFXR9bRswtj/ikOf0Q+N
 AjaWguVYQzKyXU2HlSb/+QlBFycXeYjr2VGnUUiu+DNW1vPwd5BgQU5n4dVdB6L2CHGT
 QeIw==
X-Gm-Message-State: APjAAAXKkPT4xyCu0aFPwAf2Yzq9oRV2i5bX8grbsS8a5p6h30Z8+BYH
 zOxVr2EHWM0rJHv90w3Qa33unw==
X-Google-Smtp-Source: APXvYqy6qffKrCyi2nBWbvKM6GrXMkATo++83gGNxmPue/zf/rMi7Wt5cX6iS0aN7udUkbzZDn5vGA==
X-Received: by 2002:a63:e30e:: with SMTP id f14mr10754948pgh.260.1581272452364; 
 Sun, 09 Feb 2020 10:20:52 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 13sm9579207pfi.78.2020.02.09.10.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2020 10:20:51 -0800 (PST)
Subject: Re: [PATCH v1 1/5] docs/devel: document query handle lifetimes
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200207150118.23007-1-alex.bennee@linaro.org>
 <20200207150118.23007-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <43781e81-c4c5-5351-aa5f-2effa7423acb@linaro.org>
Date: Sun, 9 Feb 2020 10:20:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207150118.23007-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: robert.foley@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, peter.puhov@linaro.org,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 3:01 PM, Alex Bennée wrote:
> I forgot to document the lifetime of handles in the developer
> documentation. Do so now.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  docs/devel/tcg-plugins.rst | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

