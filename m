Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A271C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0FE2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="THUqzpLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0FE2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5urs-0006gj-K6
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uqs-0005sX-4f
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:47:50 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:33366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uqq-0004Zs-GJ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:47:49 -0400
Received: by mail-pg1-x533.google.com with SMTP id o13so1432920pgf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6jyCXEH3KtStyC/TRsaVzmnk+vwxZUBaQN/5RDvT1yw=;
 b=THUqzpLTMAAbl8EcfhkdTlevdFFLVAG+eU9OEaAW+mVD/3ZPKPLSbP0HAWWO7jfdW6
 gYihvQjOQdyXl3YXjqEysQnZDL16ZNehC6T3PiSQH6fCtdoF/Kz67vBuiiqXOckXXD/p
 haiVR6Fomnxa+KarzWIO0JJk0gCowE0Q6N3NqfiFxc82/yMaGNnef0e6oZCB11xaKW+p
 QIIb/3A5GJjJQSqQ3oGTDEHLqHiAYG4QC0te065tpLAvzUZfpMjL0gTUQJXEJFJrhXri
 qFmvcWYINe0E5qdPCYvX9NITnbahvLtS3RPjZie9J9PzdCLgM/p/RFHwuLWvYAiERA8f
 5Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6jyCXEH3KtStyC/TRsaVzmnk+vwxZUBaQN/5RDvT1yw=;
 b=Dq9mWULgFANNEX8BaDvi4/MyZBnnGI9dp+IwB4TaQEX/NZat9OGVIq2XdeMalS3c6G
 ACjpz+i5HnRXkzwx/IW1CfHV8dqO78UVnyC9gr0w0ptUE0SQMFvSB78gFyndxelVAWeN
 1/IzqvX7pPbjTmQTYujB5P2trQz0zjp2BhzGf3MsR66uin+YtfKI6f4YPKhyZkau/pL1
 Vk/rffLjC5/Z/HCOfVsMxImLSnHozmyRsy5XXhIX2GyA/uGGzi0LwtNZcpesUHSzB4Mr
 E1qsLCg3Nq7Fubnc1I2GdnXjn6AjgyBWmXx6FpZ3Ebu1FG4G20cNh1BZNQZp76T+Boj1
 giFg==
X-Gm-Message-State: AOAM532l1X/AdFQxuGgEhqdhImeR7un+b0PNuyG/8splf7cckwH7qQbr
 xTrRjBuR5ZAoaGd+/JzbIhaETA==
X-Google-Smtp-Source: ABdhPJyQlRXRQ0wJ7Fl5g9RzH54qYBK+npDR1PnkbljaWMMqMSkOYDItt1SFwsi+yRpS1mISF3n+aw==
X-Received: by 2002:a62:cfc1:: with SMTP id b184mr592065pfg.262.1597254467134; 
 Wed, 12 Aug 2020 10:47:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 27sm2766771pgk.89.2020.08.12.10.47.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 10:47:46 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 1/2] hw/core/sysbus: Fix a typo
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200806130945.21629-1-f4bug@amsat.org>
 <20200806130945.21629-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ce7d3f88-6ddd-f100-a021-75dce942b0b6@linaro.org>
Date: Wed, 12 Aug 2020 10:47:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806130945.21629-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 6:09 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/core/sysbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

