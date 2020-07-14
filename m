Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65764C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3013722510
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFsLO3OC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3013722510
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLbI-0001WL-Er
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLaH-0000bi-6k
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:07:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLaF-0004qc-Bc
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:07:00 -0400
Received: by mail-wr1-x443.google.com with SMTP id f7so21864025wrw.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=j3O91gpeK5GJJmhIVSZPjES05mMsQNR8reQiPi/rhWw=;
 b=dFsLO3OC7QE38EV4O0tIFFhMdedu5xpazLnw3uPw2rLIFbzcPqHxX0Hae9kn/ATv5K
 AMvuNHNMVE/zBCjy4dTwq7dbsh8+f0O5hpwDidl4H41sEr297hVQuoBcJR79UpVhhm9u
 jWn5/ByVl46Gy3nK43DVkfAbZWJmn0MungT2R43g45zn7ntPVI9tllD1p9yJa3AdtJH4
 adQBV/6pZhB4nrK/bvi8oDgw/prAQyluw9omLL+adWrd1nBl9t8z0Z4TTBIsg00HkaKF
 JGOBiNYv7cD2wIsfAvZHcwm8JbM97ZNzNUlTzJCcoDmne09whjphcBMWeXJYKAP5hbnq
 iWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j3O91gpeK5GJJmhIVSZPjES05mMsQNR8reQiPi/rhWw=;
 b=i9BZlvodFgFpwhKaNkVX0xqu3va/7OmbShMl+okbC7QyXH06hkiH6JJDZnuuiAi/aS
 Jq/lh3OzeNMwggPUdk/mtTxhj4JT+30YgDA21IXp81lPU6sCD5/YXW+49F1ZRQLOdo1T
 iSrQgpQrR2MTe0/KltALn2uBRQVUkPp1CBFiUD/TZM3jJgVjLW4eftM9ZznQ1Kuz/wxD
 mUdMrehJjZXeSROk2SyHMlcNDnzf9la8tctFX4ZiW5McqOeAEsm/YUUtJpeE0OCEJwXz
 MQ6bJ2R5ydSzrEwm+MYKQ9xKgw984ByaG3/c7yTmRtMLuI9qkaNbM8XVRpxnOjM8dH2J
 1bsg==
X-Gm-Message-State: AOAM531OpdmqX8oLWBDLU64NCxK+Uw4K72JD446APSnGeHUQMvIoE5nt
 WQDmkPMT98t/QZ2WwPiGj/E=
X-Google-Smtp-Source: ABdhPJzZ+L2moUZlUCPAkohfh3XU48NqGQ6i5IzJJXD+ZRHvJKaZ6Kv3FvqOTNbX/qNV/X3r13LxnA==
X-Received: by 2002:adf:8091:: with SMTP id 17mr5619281wrl.13.1594735617561;
 Tue, 14 Jul 2020 07:06:57 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id f197sm4975857wme.33.2020.07.14.07.06.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 07:06:56 -0700 (PDT)
Subject: Re: [PATCH 4/5] MAINTAINERS: Adjust MIPS maintainership (remove Paul
 Burton)
To: qemu-devel@nongnu.org
References: <20200702133701.25237-1-f4bug@amsat.org>
 <20200702133701.25237-5-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <acfcd2c4-bfec-de29-1871-20339b3992c1@amsat.org>
Date: Tue, 14 Jul 2020 16:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200702133701.25237-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Yunqiang Su <syq@debian.org>, Paul Burton <paulburton@kernel.org>,
 James Hogan <jhogan@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 3:37 PM, Philippe Mathieu-Daudé wrote:
> From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> 
> Paul Burton removed for not being present.
> 
> Aleksandar Markovic comment:
> 
>   A polite email was sent [2 days ago] to him with question
>   whether he intend to actively participate, but there was no
>   response.
> 
> Paul Burton response [*]:
> 
>   It was 2 days ago, not 2 months :)
>   I'm fine with being removed though - I no longer have access
>   to modern MIPS CPUs or Boston hardware, and wouldn't currently
>   have time to spend on them if I did.
> 
> Aleksandar Rikalo becomes the new maintainer of the Boston board.
> 
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718739.html
> 
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> Acked-by: Paul Burton <paulburton@kernel.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Message-Id: <20200701182559.28841-3-aleksandar.qemu.devel@gmail.com>
> [PMD: Split patch in 3, added Paul response]
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> This patch still requires Ack-by from Aleksandar Rikalo

I can not merge this without Aleksandar Rikalo approval,
so I'm taking it out for 5.1.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 53404a746e..64f54c553c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1099,8 +1099,7 @@ R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  S: Maintained
>  
>  Boston
> -M: Paul Burton <pburton@wavecomp.com>
> -R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> +M: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Maintained
>  F: hw/core/loader-fit.c
>  F: hw/mips/boston.c
> 

