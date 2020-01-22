Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86830C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 19:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C45217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 19:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ah7dei+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C45217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuLe9-0004WL-EV
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 14:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuLd3-0003nz-4l
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 14:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuLd2-0003lY-1A
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 14:25:28 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuLd1-0003k4-O9
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 14:25:27 -0500
Received: by mail-pj1-x1041.google.com with SMTP id l35so377862pje.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 11:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dLLhwhf2bGoDdETTzh/LsbMlfpbCN8urf5vSnY0fHDo=;
 b=ah7dei+sYH7kEfPYnLubp6s5Co6ulJ8LGF2FHSgjWS1oruucwDkSQB3R6oSzJIDg19
 VqlLLxHlXkI360qTrmB4vuLpjY6CUUbrnaB1CMThw+ctxRVFMKw5tMT9PIcyRKmSKEK2
 oIzHejg1hjAP4WlUECY32TfAbXenzJO4YIxoD/xjsU1hIWp0DPJCNswOlZfjWwB3zOEm
 ay+BMstUq2TyhU0IXsvmo+HwhOWMtZv9U+NePZsrmNIyRXQc6yKSe2qYwDdKBlVZlTTq
 /Nbu8j3lU47d8BQTV3AvR0VNMYajPg0KS/quLsmVZ4be6MAfg4z8+02mC0a3L2/bkNMo
 KKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dLLhwhf2bGoDdETTzh/LsbMlfpbCN8urf5vSnY0fHDo=;
 b=Hwte9eveRni7iPyby4TdN30LbbUnuciDqkBnTg1d8j4vqvpQLObWqY+DpSx5rJsW8D
 CsIwI2qe0nxXjrvUasvpIXaT05COXP0U043XUxQN1Nzt4zvnR2jVQow06X0hVlYcLxdd
 LW8Pc/iDikI/asK7EfpYAUI8RSkuzdci2PYwsvbb/vjYP2HXam/mkzeQ9BNnSdPTqjBU
 HjFsffmvaQNufY4tAu4BMh7w++Q4AEJPfJfwAm3gvZcsrAoeVb1elUUa1HrH7QkjL3TF
 eGBXhT4vP14NwruYCaFQGEQezAUwtDkcd1+GCY4VirwzjwJjfeQKCaHezZajMHv8Auvq
 Gs3A==
X-Gm-Message-State: APjAAAUipYzK/r/TfTzokiE85zHCG7fQzstXm4usyQzTwB6U4DG6/PbL
 F4fY/LCpjZhuA7+pbhqTrd/BTA==
X-Google-Smtp-Source: APXvYqxaBuVU9zve4sFLswNtBi3tXwLKvBSG1FfaPtjTmEU5RQ/c4o5f1d2qagjZevRtmWy04m6Axw==
X-Received: by 2002:a17:90a:222c:: with SMTP id c41mr72143pje.35.1579721126433; 
 Wed, 22 Jan 2020 11:25:26 -0800 (PST)
Received: from ?IPv6:2607:fb90:580:a104:4475:e6b8:8600:af4a?
 ([2607:fb90:580:a104:4475:e6b8:8600:af4a])
 by smtp.gmail.com with ESMTPSA id i66sm48870284pfg.85.2020.01.22.11.25.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 11:25:25 -0800 (PST)
Subject: Re: [PATCH] Makefile: List the sphinx documentation in 'make help'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200122172137.7282-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <733f67b5-e4d2-6d3e-6407-7d73801de3f6@linaro.org>
Date: Wed, 22 Jan 2020 09:25:19 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122172137.7282-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 7:21 AM, Philippe Mathieu-Daudé wrote:
> In commit 5f71eac06e1 we started to support the rST documentation.
> List the build target we need to call to generate the rST files in
> the 'make help' output.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

