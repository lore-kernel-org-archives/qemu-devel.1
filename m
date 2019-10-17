Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BD3ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5F520820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdE3w/5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5F520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7Jr-0005Th-HF
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iL6ea-000267-Qo
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iL6eZ-0006IJ-NL
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:21:24 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iL6eZ-0006HU-Ha
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:21:23 -0400
Received: by mail-pl1-x641.google.com with SMTP id u20so1215994plq.4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0Ny8ptDe1Il4jv1PYAJAx6wDVarWEIuSVEOQY+rzNH4=;
 b=CdE3w/5o3mL7OM/9dZuwExqWvpQSBM+yG8Xoc0fiN3QAXcN3xmIsOIjd3Hp0r7g9+4
 liLuXwtiGigqGX/Rovs2P7jhnQHxnpK+6gObLQI24PxOgZNA/RZPnMPqtMSh7AoXcbbr
 8h18tGWvVtWN7DfT6r1SMlxwpmqpzSZK8RqcT4wEJu7rku2P6zfoI2zk6mDFz7svtX+u
 YSXZRkoinH+Ui4ZkQQafa+Ge+zgdbGOonqln1arzh0vWLHdiGiVW4g/gFFm5dEe9CwE3
 fDFn1uJyBLjgN5UtnLU5sWQsvZovQasQkqcnUsjs4iNF3mS7Kcz1JJO+rZGntI94koH8
 MhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Ny8ptDe1Il4jv1PYAJAx6wDVarWEIuSVEOQY+rzNH4=;
 b=deC3QRvW2lKCWl8u6pAfce6rso82EFhtkaag8FIvrb3f+9QfDAoqOcjbFdispogHeG
 XUWqnpJ07/YO7gXgDdh73HjqthdEVuxFsEPG58mbIvP+BrWpDCcswoGXsyoOUY/U/+Z3
 R+nJb1WYtqIXRol1ARQw8QnpyaE9zFkCfZ8G8GR68ENb73/y1WBSJXsUgFEcYkb7hvh3
 q1sGF3Jwt5ByFrGPB5FilUTDfyPHDICP/UyxxlmI7utVwbaFRuCMk2LdcRcwjfgVveWy
 /FHsdflRaZ27oLxzSmOJZBKH9+ILV3fMY65MilQq3BDbyiHOQwziPd9Kowh1f+5hD/Lg
 CAhw==
X-Gm-Message-State: APjAAAWis1vfbnYZ1tfyJA9pq+ouEG05rwd2Pm+Dvi4nIv+fPh/DzGFH
 aGTMxueHszkSvJp1kMZmuPXqxw==
X-Google-Smtp-Source: APXvYqy4hlXWvjGbBZECVo/PWWG1945xQy8CAPl70/xxOP4kLdm3iARVSn4RL44PBNe2KzFj/1az7g==
X-Received: by 2002:a17:902:9a44:: with SMTP id
 x4mr4333466plv.127.1571322082038; 
 Thu, 17 Oct 2019 07:21:22 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b4sm2543370pju.16.2019.10.17.07.21.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Oct 2019 07:21:21 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/timer/slavio_timer.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132351.4762-1-peter.maydell@linaro.org>
 <20191017132351.4762-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4a099f60-8a6f-2b3c-5a6b-80b86620e66f@linaro.org>
Date: Thu, 17 Oct 2019 07:21:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017132351.4762-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 6:23 AM, Peter Maydell wrote:
> Switch the slavio_timer code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/slavio_timer.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

