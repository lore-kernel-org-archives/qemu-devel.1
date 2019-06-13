Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07471C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6EF208CA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kEPXs6oT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6EF208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbXPu-0002tv-1M
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 17:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49202)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXGU-0003P1-Fz
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXGT-00005q-I6
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:28:10 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbXGT-0008Vf-8m
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:28:09 -0400
Received: by mail-pl1-x642.google.com with SMTP id f97so71716plb.5
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0FqpSDYk79nLPry2Kvx4HZjRltzbXBxJNX5WUd6cLnE=;
 b=kEPXs6oTrjJ0zkxpGKN6WmmQN9FzOdZBBa0g64RHb/VYSZuasVogx7FhFEumGgKFyP
 5w66WfMplMTlfQxJh/WQ/ccnGfkRG+dZRsF9ZIufTqIpyV/taAq4tnjlNTOyJmJupE3P
 18PQxW+3FvULItUPCsRywdBIhkcYpbQ6jQsYfOkNLUC4JyAvbD//DbXWRytwnisWAz9i
 Zyj5yWwyV5uGTSQANrWmouY/9kJp06Cwh0Sr3wJoBdp6UyZYkT3qFzI8uBUF1jNjYAOk
 Ms9xYn3Y2Rd7T7nYdhfzyoRezhb0+VTJnDS5Vfk9MTjqSBUA3rPuMBLAzyIoiGiqpBpB
 gsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0FqpSDYk79nLPry2Kvx4HZjRltzbXBxJNX5WUd6cLnE=;
 b=LbSxOFOGcTDTQNAH5oI7I7wQOzX1piVpEO1gJR3AWSDcuVHTzi055dtvMWMACdB41M
 KMiyKm00JTGi+D9EMd2VmfNlWKsOOFhJb9sVzXCh6iFVcUQBPQzx6eWTjYY1iWfDqGru
 vji3wCQvG5xRxHhpp/geRICGnlol8d2ctXdutrVf6FClIzNDuyaoVS1emSH+KVZveI/x
 gDLwH0O6ZmHc5ctVCg5klVMYyn472yJimlTER17uzgBHF9mVpj+w8Eoc+NvaIuL1fExr
 wpRVxpsxDyel01NXLJcmHs07FAHkmShuGXcGQBgn5c/oaVJqIYXB2wLlA9wQWNakjaIi
 mKrQ==
X-Gm-Message-State: APjAAAU+kyuIB+WxUll5jlUhqqTjXZGoOY4FUgBnukcybWL3M9OKAyyQ
 LM1AJ2cUpgA7PZK7PPR2pfYUzB0JdFM=
X-Google-Smtp-Source: APXvYqy35loYCx4uyBWv4yyRIggKJLxPVT8iBs/DdzY2U7OOLpQMKK0YuoLO4vOwjlZUzbpglMbdMw==
X-Received: by 2002:a17:902:4181:: with SMTP id
 f1mr86631309pld.22.1560461287938; 
 Thu, 13 Jun 2019 14:28:07 -0700 (PDT)
Received: from [10.10.150.239] ([149.199.65.200])
 by smtp.gmail.com with ESMTPSA id j7sm561130pfa.184.2019.06.13.14.28.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 14:28:07 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190613163917.28589-1-peter.maydell@linaro.org>
 <20190613163917.28589-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <013f1b9b-990d-98b1-5cd5-42ed47dbb4ba@linaro.org>
Date: Thu, 13 Jun 2019 14:28:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613163917.28589-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH 07/12] target/arm: Stop using cpu_F0s for
 NEON_2RM_VRECPE_F and NEON_2RM_VRSQRTE_F
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

On 6/13/19 9:39 AM, Peter Maydell wrote:
> Stop using cpu_F0s for NEON_2RM_VRECPE_F and NEON_2RM_VRSQRTE_F.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


