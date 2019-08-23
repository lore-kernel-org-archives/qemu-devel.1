Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFECC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326BB21019
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="klvlTQWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326BB21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1D2t-0000W2-8I
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1D10-0007mo-4X
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1D0y-0001OY-38
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:06:18 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1D0x-0001OH-UA
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:06:16 -0400
Received: by mail-pf1-x442.google.com with SMTP id 196so6832993pfz.8
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Av1de8GypH+iOd7tkgsnHvHf9EbjlZtvOdu6hX2j9jE=;
 b=klvlTQWR8Zk4K5d3NjDq4M+jfgTSidCKXrUUK2KxLoxRPuLw7q9N2f5ZDB2XTGGpDv
 iYCZ0VNElEULeHyUa/BzGgchwcHBXJHlEQPUO7K/RDEUvZ651rlnqM9iBaFPPR0aC+Jt
 tqmr5l92Ob9Qu+pHlN2p+txfZDMd9FrXs1z4pbYUqFxSbiLt5TnXxYOmIFYgcr8OxPRO
 YCHoBhxOb88UPPVS72BZ6PFrxd9v4+bDz9jnAaQ85TxKPJ1M4Gg7iPMB+38N3bKk7s9m
 GRrh0RAB12K18aOuGnl+1D860U9rydrqv27WP1cfSaiCCCnNghB41sX2sttA8DnHdyzF
 XOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Av1de8GypH+iOd7tkgsnHvHf9EbjlZtvOdu6hX2j9jE=;
 b=oxNEpowMkrvqMtqp4TfnzRcAbQRhoE0MltzijLRY43asYlgyzic+8tIvwK38fZC1O2
 TBRmp7Quy1VeB3pzhYx4X+aqsjPtBZOaWP7F2XXMgpkOovi/P5SzWihkVGbLmF+Srilu
 JbZaojH8CDFqOfLBJHNzxGc1gQvFWUa/Xpnet6QK1e2JecXYTm4WJssTtCWTxc/KIp0n
 YhJCxyCuJZv4wWWHVG6zmQUMSI+W5L1/LnvZnrX3Zw8fU//mI78oz0CcQ16uU4I8E8nU
 Ybzk0lh9/b0Rn7tNPDv/a9Bv/ThbkWcMDgImqOx4/F9oacBtlL22Bypnqx+7q5rks1CS
 6jWw==
X-Gm-Message-State: APjAAAUq0RC1d5Hq6xnzcP7b8Ke/77smIqc83Not9I+Q46toOQHlKQSq
 1NZ0Rt++/ovtLWt39GcHXfw1Jg==
X-Google-Smtp-Source: APXvYqxxFD7G3UBtlaxR1gzkn+wx+PH7IS44fleQjQXfhDtlC8sn/JcUT/BOikDWvzDiJiBeKmfdYw==
X-Received: by 2002:a63:5920:: with SMTP id n32mr4698006pgb.352.1566579974926; 
 Fri, 23 Aug 2019 10:06:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u1sm2485506pgi.28.2019.08.23.10.06.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 10:06:14 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190823135811.13883-1-philmd@redhat.com>
 <20190823135811.13883-3-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f1e4cd47-1693-15d3-5ef5-e23c1a160c8f@linaro.org>
Date: Fri, 23 Aug 2019 10:06:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823135811.13883-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 2/4] target/arm: Restrict R and M profiles
 to TCG
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 6:58 AM, Philippe Mathieu-Daudé wrote:
> @@ -2544,7 +2546,6 @@ static const ARMCPUInfo arm_cpus[] = {
>      { .name = "arm1176",     .initfn = arm1176_initfn },
>      { .name = "arm11mpcore", .initfn = arm11mpcore_initfn },
>      { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
> -#endif
>                               .class_init = arm_v7m_class_init },
>      { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
>                               .class_init = arm_v7m_class_init },
> @@ -2554,6 +2555,7 @@ static const ARMCPUInfo arm_cpus[] = {
>                               .class_init = arm_v7m_class_init },
>      { .name = "cortex-r5",   .initfn = cortex_r5_initfn },
>      { .name = "cortex-r5f",  .initfn = cortex_r5f_initfn },
> +#endif
>      { .name = "cortex-a7",   .initfn = cortex_a7_initfn },
>      { .name = "cortex-a8",   .initfn = cortex_a8_initfn },
>      { .name = "cortex-a9",   .initfn = cortex_a9_initfn },

Ah, patch 1 fixed here.  I think these should be squashed.


r~

