Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4909BECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13FB1206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGgvYl/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FB1206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIG26-0003LB-Jw
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIAhs-0003DU-P7
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 08:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIAhr-0001IZ-Nd
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 08:04:40 -0400
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941]:39035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIAhr-0001IQ-HH
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 08:04:39 -0400
Received: by mail-ua1-x941.google.com with SMTP id b14so678784uap.6
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 05:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hTUKCIiic+Ut/Wo5FppKOMLXeKxhC4oaQ4z+c7aFIGk=;
 b=zGgvYl/hYoLiNZfFIrjsY+vKXxU7FyIFBN4uIxlItak+WW3/8xoJBbrjpMxcyPRouG
 LsQ3W5mcoQ/Qh10vLjGt9CSHHP03WTzFfE/Rlg421ZYU+KLlvGjMYTOh/MbH/Vjf+3L/
 lFQqrN8vPo8yUWZ+hvQkCD4GMmp9FchlVlM2vO1XaXdb7ccHJCU8Z7W6FwYAi9et9pHR
 E89t+R3fHoV6fhIpF0l8Lr694cloIOCi35bgi0CCZW4442nt7VUvrjeMeQpI9iPUuhtL
 uvJxAceDP+hBsxuTVdhven1dZs2OmtYcUD1/cgnLhQfSDi9GXJPkjQ19G9enTzW13QCU
 2hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hTUKCIiic+Ut/Wo5FppKOMLXeKxhC4oaQ4z+c7aFIGk=;
 b=KNjz8WO83sTy95IGorf24b/P1MG1ayJ1KVIR1jnei0LyCUyURMEuwxVv7XeSEuSI++
 wwAxazOyQ2DMDm29TZW6B3zDKYaC040lOlbaEe53PptuMuii8MwiggrOK0QsrjaPIc5S
 n2UCtgMjGE+5rRFv791Ht3W/I/xUHmbKXkBPNpvMXgtVbB7b8WORERXj430VIysDoqis
 vwxGwBWjMKmpMIf4ICbTW351RnmPxZcA7fJ1ZpZEATpt84EBk7wU3DcHn7yzmahLR2al
 koM26Jfk/ijRV+RkS4MctfbTafu/ObdPh0FRcTtTq16ZiJzIXMg8RWv8lLzWrLJG0zbw
 VGiA==
X-Gm-Message-State: APjAAAVsw/b5T0IlMWBzRj2YDZnreaM2kOibQM+4SIxnNjOOmtHAolvB
 JZobN5HMK0IMfqyaaWYOV27PcA==
X-Google-Smtp-Source: APXvYqxgVLoQmD0Sj+fD8liMovUK5FdxjKkS5B6ujtQJOsJVJ1aI5kBPXX9GYBS/UAyqjVtw/euYmA==
X-Received: by 2002:ab0:714c:: with SMTP id k12mr429717uao.16.1570622678439;
 Wed, 09 Oct 2019 05:04:38 -0700 (PDT)
Received: from ?IPv6:2607:fb90:12df:9ad9:70ab:b71f:bde2:72aa?
 ([2607:fb90:12df:9ad9:70ab:b71f:bde2:72aa])
 by smtp.gmail.com with ESMTPSA id s10sm599981vkl.8.2019.10.09.05.04.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Oct 2019 05:04:37 -0700 (PDT)
Subject: Re: [PATCH v2 21/21] hw/net/lan9118.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-22-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d7f1654b-0f61-4ef8-6f83-bd5c7221a7ec@linaro.org>
Date: Tue, 8 Oct 2019 22:07:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008171740.9679-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::941
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 1:17 PM, Peter Maydell wrote:
> Switch the cmsdk-apb-watchdog code away from bottom-half based
> ptimers to the new transaction-based ptimer API.  This just requires
> adding begin/commit calls around the various places that modify the
> ptimer state, and using the new ptimer_init() function to create the
> timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/net/lan9118.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

