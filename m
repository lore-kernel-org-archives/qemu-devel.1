Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A39BECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97FA2064A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AKG5dUtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97FA2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHTAU-0002ls-VR
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 09:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHT8J-0001XJ-AA
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHT8I-00064P-5D
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:33:03 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:35218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHT8I-000641-0c
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:33:02 -0400
Received: by mail-yw1-xc41.google.com with SMTP id r134so5119910ywg.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MRdGrjnVYud8BhclSAqXUKtTaj5FCsVWoMT+pyhJ+f8=;
 b=AKG5dUtqX0Zp3RIxHMsLr6tPTlxxWBrqKXscThB8dd29dMTv9qlKnKAIiRcN3qNu1d
 P8sVPsjkAkqooBnMuJap5cZBr09ZtD44YyLaa2wuxO5JTwWWNT+ND+z7WrsuMMkthTnF
 LsWQhoOt9sKf/lbgECyusm8+aZJre5Kvhr/KrmnuvHSCLWRkIpx0D5iCUoNZlql8a5ij
 6LbeoHmlrJOxIWb7GR1baN/1i79k4WlUeEf1fYuCuReoeUWm0RjLB5LVR8yyRssUprN6
 sGFRch+gXzRLuNZw4PBe2UH1LpOKD3sRGyFmLvrinmbZhzaYKGZGf8zF+ux2cpqRfIa2
 qw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MRdGrjnVYud8BhclSAqXUKtTaj5FCsVWoMT+pyhJ+f8=;
 b=W0E+VI7fQ4v3wi6YVxnRIcI0e5V/EqOgVn5MTagXLkrJUlsBjZo097IvQjWKCzikQt
 9WeGp6mAauhAm4mn1zwrrpdrcftzG2jili9QKhg6tetYwGFJN2EZudMCyLMm5HGWRIkk
 Cii9id2RgG73IgUhIkdcXEKs4tw2lcBZlhM6DxWUqTNeLzEEYOpgVrJ13/QnWOZOUZO4
 AcKqN/INSfSFrMKW5cBTWjncpqZdvCO5Un4qEWeqyyXJdzo44D1FJ0vHionHALKRtFfK
 G8vZBWvn1G90L7bkz7szVfO63d7YRlIbm7gZGHKh3vlMscVobnHWe7R7DWdv1C7qM2g1
 cxsA==
X-Gm-Message-State: APjAAAUfYzkk2dPNPDzeNbrr7QDCennMMBNxR/taLnf3wli4erB5H9Wh
 8rJa0ctn0Lpbb/CsNQ4PpUNMhw==
X-Google-Smtp-Source: APXvYqwu9n0wonkVpch/vmC15VxlpqJE4RoL3G5My73AwX9brn1Fl7U0I0r9d1dg6zQ+a6iWNf4/CQ==
X-Received: by 2002:a81:2781:: with SMTP id n123mr19481084ywn.3.1570455180539; 
 Mon, 07 Oct 2019 06:33:00 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id n11sm3713909ywh.82.2019.10.07.06.32.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Oct 2019 06:32:59 -0700 (PDT)
Subject: Re: [RFC 4/4] hw/timer/arm_timer.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191004114848.16831-1-peter.maydell@linaro.org>
 <20191004114848.16831-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6b596f9e-5dfe-1118-69a6-692cd83be98b@linaro.org>
Date: Mon, 7 Oct 2019 09:32:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004114848.16831-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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

On 10/4/19 4:48 AM, Peter Maydell wrote:
> Switch the arm_timer.c code away from bottom-half based ptimers
> to the new transaction-based ptimer API. This just requires
> adding begin/commit calls around the various arms of
> arm_timer_write() that modify the ptimer state, and using the
> new ptimer_init() function to create the timer.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1777777
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/arm_timer.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


