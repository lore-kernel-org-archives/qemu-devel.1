Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6E1C4360D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 15:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4702A208C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 15:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGV7AXzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4702A208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBhIQ-00071F-FW
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 11:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBhHg-0006QW-0R
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 11:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBhHf-00043l-3b
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 11:26:51 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBhHe-00043N-RN
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 11:26:50 -0400
Received: by mail-pf1-x441.google.com with SMTP id y5so6470228pfo.4
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=54rGvRC2DHDrzSXA4F9r+xIfJe2KBhX8HqaGRlC98Us=;
 b=WGV7AXzrPrHjbY72MWE3HQOyxMXk9Uv/QHqSWTx3J1wsWtTeXI3+i8G8Ybkm0PX5Oj
 wgA83b8J0ksXgdHT6du76U6IOfna6gOZltatny2qMiW1RT8dnGJGmIhza8hFiGQ055uZ
 dwjXc66SohjbF190q13QHPB+7WZRBjToSx77lpdgQJ11CEBbBayFl5NTh1/Y9CfEy+eT
 0mHXdPrtKgAAYpbqtxEJxu8aswq2BE5YJ888lPbhznq/+H1XTR7pHI6H+rBqKIoIsMuT
 pOXhCf18QK72sg05A5BLprWQp/WMgPxri1+hOCLMXsUSoKMbJt+5d/vaSlw0rLVZwzgq
 uwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=54rGvRC2DHDrzSXA4F9r+xIfJe2KBhX8HqaGRlC98Us=;
 b=faQiZFMiOiaH7381fooHBApnM/vij9AZiGXnWxfAprF4cbEvHazGsJ905SvC3KYwPN
 Ws8Xing1hFZnETDhBqM71LXMe9SEWxPf/H2KRNWQ1/ZzBhXQ7vMdmjVMfFuSk5jXqSwm
 GWxNltlR38NcdzmBcEmKSN+dVXqVn4vDpsTeQeJvL5PZoZFzj2rpmXMj3UGgvf4WWV6N
 rcFYG6Vm4McSdEdSvNC3lZoNY6JAFrO5ColD4RWlbR5tqxdD6hVXpgfJonFG4RUkBYk/
 8IKnz1GOCcpzqdtETFCXhD+FDVEbL7T6oYiTwJOM39x93MvJc1sFLl4IRav4bHL2pme+
 YkfA==
X-Gm-Message-State: APjAAAWH/b+hAaimzOKZ7MERkoeVfZnjLc+WL20aw5Yrx7sn6J1z3d19
 kvL2zWQoEyOkfQ+p5Qy1wKx5IA==
X-Google-Smtp-Source: APXvYqwat6KAQI6/zESyy8xzgC0+9aIyEtrZritqX18WpB85XHKLn5vrBZAEwFFxOXMI2JcenlB/mw==
X-Received: by 2002:a65:6254:: with SMTP id q20mr21209552pgv.423.1569079609657; 
 Sat, 21 Sep 2019 08:26:49 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v18sm6083361pff.32.2019.09.21.08.26.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 21 Sep 2019 08:26:48 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/boot: Use the IEC binary prefix definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20190921103405.19623-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <089a9b68-b1bf-66a4-f696-9e7e28bf6c4e@linaro.org>
Date: Sat, 21 Sep 2019 08:26:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190921103405.19623-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/19 3:34 AM, Philippe Mathieu-Daudé wrote:
> IEC binary prefixes ease code review: the unit is explicit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/arm/boot.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

