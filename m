Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835F2C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4326A20825
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/eNvOmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4326A20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49456 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHpo-0002lF-Cp
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41615)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZGIv-0007yf-SS
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZGIt-0001eK-RT
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:57:17 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZGIt-0001ct-L6
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:57:15 -0400
Received: by mail-ot1-x343.google.com with SMTP id c3so2119179otr.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G8Kp5dsS4Em5s2j1Fedn1hNl0iFVVRUOtdPjd5R86FQ=;
 b=y/eNvOmuaAO8ewLpsuZzQfft/m+bRT362GpTFUO/GdbOa/MidBboSgwXFiBrc6BQGB
 vefG9hcQlS6jeJBCPwsbaF1mWVu5m+JSSC5xLbuWP9L9MbW1KiClT/zry6T1TcjwMrRw
 z0nwZ0n+wIJfRkQUEwARpEYlYSq1toIeeac7f2MuFhAyD3O8CO8hIG3irpINR1W6TOoi
 NOg40KZ9H7jInJtzpirY/0fslig7U0+qYKm37b37Qz1TB6gwaSUNWItheJ2uWqbbXQc+
 S+/0Ycv3kQytNk4zVpw4ID2rKh8gcUFRiP7jsMq0s+k9BfklDzo3nEJdgpdwbpLvCVSe
 FZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G8Kp5dsS4Em5s2j1Fedn1hNl0iFVVRUOtdPjd5R86FQ=;
 b=h0JDwkQw4dvjwjN0ngDOrb5GxH0Nm7DAjPbUvrQZqYPVgy0N3F9mQuBrPSoLJEAcSD
 1elh0Ja2Z3kkj0Res9Ico9B2tc6lTzGtBbBDCJWufzeX5Qmg45PsIkqaRNeQfunTzo1O
 bq4MS2FXAyOC0e15yIq7DG+Vp7lp0UOTBUS97M6Ie38mGNzSYUL+ek3n39GFc3I2W/d7
 Hk8HYxwK7weSqhXZNAJDJ94WtgB5nOb0q4LE0piJ5dXaKgXCQnfp4BpKOh9uogP+bYc/
 qJ4BLbrYzWNcn4FA5Hqlh3Og2J6C/MhDVQ9qua1kBZo8uGlp1FztuDXCJMDkK8Dqq738
 XTAw==
X-Gm-Message-State: APjAAAUQT8neARpRCLdiF+XjwR0m7ZA7mR7ELFnAT8IoIx0jjhZ/M7cW
 fm/ZO8Q5HSTY7I6SY6rXOXPYrPs2pQVu2w==
X-Google-Smtp-Source: APXvYqyaqmOlAXLMC0d2/ITrtgw7y1B9Mwb7nM7gm+rmmcsUmjY7c88lbxaGK5M54S6wkla9BYQ6XQ==
X-Received: by 2002:a9d:5d10:: with SMTP id b16mr20430391oti.35.1559919433151; 
 Fri, 07 Jun 2019 07:57:13 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id i5sm832559otf.26.2019.06.07.07.57.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 07:57:12 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <949c7dc4-62e2-c3c9-bd5a-227b318d9e64@linaro.org>
Date: Fri, 7 Jun 2019 09:57:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 08/42] target/arm: Convert
 VRINTA/VRINTN/VRINTP/VRINTM to decodetree
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

On 6/6/19 12:45 PM, Peter Maydell wrote:
> Convert the VRINTA/VRINTN/VRINTP/VRINTM instructions to decodetree.
> Again, trans_VRINT() is temporarily left in translate.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c       | 60 +++++++++++++++++++++++-------------
>  target/arm/vfp-uncond.decode |  5 +++
>  2 files changed, 43 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


