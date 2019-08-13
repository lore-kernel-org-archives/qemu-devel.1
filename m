Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B83EC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 04:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3392063F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 04:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KKViyl3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3392063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxOkR-00055v-Db
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 00:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41293)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxOjt-0004ED-Dw
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxOjs-0002Yg-JP
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:48:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxOjs-0002YJ-DR
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:48:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id g17so106469887wrr.5
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 21:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SEkOs61qT0lqab5WvYGvcUFw0EYRKVTQ5K0Cf/Dwr7c=;
 b=KKViyl3hdU/BP3eZtHHgT03ejtK8uCsfN67An5Sr1ifpvhy+jJg/rFM2tXB69vUNTh
 nwkqTwsmt0Q3eXbCOeZDuOWGyuljbNaE2AXpQcDWmjAj+jzsCsd6LZe86Vt7Xb6v4Orc
 L+PMa2xZCvDBBRZiItglu6kAD31TYctAenrmlFtrFHOy/ZbmdwNRnMcfPFt1O+g5Fl8Y
 xdko1XZ71H90i0Vu/5ZOOcXI88uaQLi93zAugLqg2LglGSPrwUh0DsBLj5nLpys+yZj5
 +aUGrKfT4JZRqhFJCEthS35k+5ProDWY9yh239lX/rp7lb4pyL4X2kuVBBCyNtn1aYQE
 x8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SEkOs61qT0lqab5WvYGvcUFw0EYRKVTQ5K0Cf/Dwr7c=;
 b=gNJ+RibQ2YWrnRGJMKx06HRQBBgvZxAWo4FBCP9Bw8A7ltE06wuSYCeR4gZ7bWiWi2
 r2tV1zzm0kx2kmuxXu6pyYHIZApXldA3rE9L5BliMhmHW7AOhQJtTkx2lHJt5yNZQT9w
 G9IH96jJAQhnkfq3oTu8xVDJRt32I0f82ZXjQNYi3UYht4TfRlppiKaVGe1z7VLAtIYt
 fTNLGjKi4fOXoTWUxAdSKE3OZetWBQK67n67nHO1xk7Rm598A2BsMRZ/eG0FhDIm2E8A
 8zWgV8lEkSduVWOByc0B9D0f+r4Fv2Si/7KiE3b+/3XXYRgPrMU8B/W1LAJ2sHcNZTiK
 LNdg==
X-Gm-Message-State: APjAAAWujbuC11JL+XTidZKowDm7GpA3Z/HOjCquIcLpuJGXSJYsRraE
 uTQk+s+VvMTSQGWsBx9nEf9DXXMPOPxQnA==
X-Google-Smtp-Source: APXvYqzeTdN54duRgxD8Y4Kmty+L11NCBoTGFL0ue3Ah+pWpzWh4ToaUoVN/VTCwE2vRnyuyaGGyPg==
X-Received: by 2002:a5d:66c8:: with SMTP id k8mr1951961wrw.7.1565671731115;
 Mon, 12 Aug 2019 21:48:51 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id m6sm16405529wrq.95.2019.08.12.21.48.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 21:48:50 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190810041255.6820-1-jan.bobek@gmail.com>
 <20190810041255.6820-6-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2c6ebedf-fd1d-f0d2-65e1-c676683da737@linaro.org>
Date: Tue, 13 Aug 2019 05:48:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810041255.6820-6-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [RFC PATCH v2 05/39] target/i386: use prefix from
 DisasContext
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/19 5:12 AM, Jan Bobek wrote:
> Reduce scope of the local variable prefixes to enforce use of prefix
> from DisasContext instead.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  target/i386/translate.c | 113 ++++++++++++++++++++--------------------
>  1 file changed, 57 insertions(+), 56 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


