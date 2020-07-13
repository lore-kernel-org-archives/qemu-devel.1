Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82B5C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5DFE20578
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCjK4YdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DFE20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzyL-0003mU-SM
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 11:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juzxI-00038J-Dl; Mon, 13 Jul 2020 11:01:20 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:42798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juzxG-0007gq-Tw; Mon, 13 Jul 2020 11:01:20 -0400
Received: by mail-ej1-x642.google.com with SMTP id f12so17578614eja.9;
 Mon, 13 Jul 2020 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pgc1Thf1+IL9bEIM+J2nryPp4ZIrLw2LUnE1zeRprz8=;
 b=vCjK4YdGub43qWAsrv9vzzaDJHm5S4uTwgisHfsfj4Ub6PvqU/aWgnJZUtAoWP1jZc
 1RXfb0nVQpq+A09o0ZPHJBIbQNp3MGt4IaXtHjhIesg1gg4WVp5EYdUusKy9qLTw1NHD
 hVSyZaMwabN1mMl0z91vhrNtxmUcsfuoBEF11iuoIhOaPl74IPvbTGYegp9UR3DL2HNQ
 sFjosf1zd3K5R92KA0cjBuF8kERmOnz/H0MXbr3pptu7OTGtNz5BGTTQMcRXD9bnWh4a
 0erjP4MjUfYQI41nVIAJrMyWzxSzvRIC0fXG7oFsmn0TNDXZtzjwnjRjw/zwTE8KejVf
 LM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pgc1Thf1+IL9bEIM+J2nryPp4ZIrLw2LUnE1zeRprz8=;
 b=a/2cUPiruhXO64S+13j5qFArvK1F6R/u/S4PrZfTyz9BKeVs+CxunASKncd4qZgPiH
 xy8pnrYyq/Ir3+8d1jYXUB+sDLLRIMS193OJ9HjDayQfnLESS/bRElq1Jjc5gbD9wtN/
 gvV0upg30/dRxq7v6S6QoB6XFNEF2DWpqcjiKdTUlYYYbqk4nj8TJFQujweHmoxFqyeO
 AelHgzfNtT9AkCsn9R18LDpFHIt+S7OAELTQR7llpfENPfAl0essf/rq2zzTHdHVN+VY
 b+EkpAtJgjhVDEA2H9pTlzNJYwGTx8PZ9bSlYjko8Z0nsVt67pLJ1m2JEiTv1Nr6PZfw
 jn6A==
X-Gm-Message-State: AOAM530e/rA1hkIsbpY7T0i+ZWSUZzaE1San/drC3vlJXczZVW+kTUxK
 g9mif5VyE/pfXafI5V6Ip6ZLidwV5RM=
X-Google-Smtp-Source: ABdhPJz+kegf0o5xQbsraZqkDeurimOIv+UyE33rjPR7M4UD6WkwbWtlJKv6irCuS8S+0buEKQOovA==
X-Received: by 2002:a17:906:2e06:: with SMTP id n6mr218422eji.34.1594652476963; 
 Mon, 13 Jul 2020 08:01:16 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d19sm3829163ejk.47.2020.07.13.08.01.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 08:01:16 -0700 (PDT)
Subject: Re: [PATCH for-5.1] hw/arm/armsse: Assert info->num_cpus is in-bounds
 in armsse_realize()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200713143716.9881-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3f903d1c-4128-f075-3773-e435a071be99@amsat.org>
Date: Mon, 13 Jul 2020 17:01:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200713143716.9881-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

On 7/13/20 4:37 PM, Peter Maydell wrote:
> In armsse_realize() we have a loop over [0, info->num_cpus), which
> indexes into various fixed-size arrays in the ARMSSE struct.  This
> confuses Coverity, which warns that we might overrun those arrays
> (CID 1430326, 1430337, 1430371, 1430414, 1430430).  This can't
> actually happen, because the info struct is always one of the entries
> in the armsse_variants[] array and num_cpus is either 1 or 2; we also
> already assert in armsse_init() that num_cpus is not too large.
> However, adding an assert to armsse_realize() like the one in
> armsse_init() should help Coverity figure out that these code paths
> aren't possible.

Similar to commit 1db889c71f ("hw/openrisc/openrisc_sim: Add assertion
to silence GCC warning").

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/armsse.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
> index 64fcab895f7..dcbff9bd8f4 100644
> --- a/hw/arm/armsse.c
> +++ b/hw/arm/armsse.c
> @@ -452,6 +452,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    assert(info->num_cpus <= SSE_MAX_CPUS);
> +
>      /* max SRAM_ADDR_WIDTH: 24 - log2(SRAM_NUM_BANK) */
>      assert(is_power_of_2(info->sram_banks));
>      addr_width_max = 24 - ctz32(info->sram_banks);
> 


