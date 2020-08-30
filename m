Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83253C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 01:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437922075B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 01:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PecPpWSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437922075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCCcE-0006Bs-Ek
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 21:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCCbT-0005J3-7p
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 21:57:55 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCCbR-0007ob-Ew
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 21:57:54 -0400
Received: by mail-pg1-x541.google.com with SMTP id l191so2355419pgd.5
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 18:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=779pfCYpx7jF6I9326Cb+3otTDHwxq0clqMd1vsKIw8=;
 b=PecPpWSnGP5TFyL+CJJ4CS6GPmGzkT0agrirQiz8s5hvC8jPozHCeX44JHezwleZkV
 LacrU61QvXkTovfrticfQqkayx7u+VVkQAW7qFJb3hpQH/baHqzDSsbrUfPVbYbiL6IO
 hMzB0G63nEClYYxgzL/RviWn4o+fzWw5y5IyQBcj5SCvuOeSx0j4c3dueoSqtXmbH+3B
 nfE70NsfD8gxwCjVBu7Ab6mxF5iBsoDkyhuKaqrISI7X/S2ih8Z8E3SVgLUkeHYp5mmZ
 tF8R9rvn3KyNA9HaYR8eWSvlIYLKLgGle9jIwm/89Ps/Tn3TrxwIK5yPBnUHO1FrmlpQ
 1M9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=779pfCYpx7jF6I9326Cb+3otTDHwxq0clqMd1vsKIw8=;
 b=i4LOzLHYDVlzFYuwccgYkB4r+bzXnAil+afiEtHobQiHTqXcL6zavD7uxlWWvPTc/6
 NKv9vkOd5qSENOHac1W/eLeQvswBp9cukl+0EWZdUVZ1Brfm4sA2WTrMe/hlX7HGHORx
 OtDbtF85hfDufYhPjQXzvUHKeZY/ip7ukYRrqhcu8n9yy4K2PccRPyrCbpcjrSvEowua
 d7mCz57WfwXidCF5Xx8UVnjxzFrHOFu3e17CwHeX83Ce+Xo55vgLqPatz5Z6mR0pAGzx
 xOrNnKju/tj8TdPecxTlzSY/zmJM1H1GISZB7B6q3vgqNwkc14XGX8ZQNQYpD5vX9WnA
 M1Gw==
X-Gm-Message-State: AOAM532WTXz4ZNjtPtmBAvfTxgk1ilcwmCheVwaEO4oPp7vX3ooHY5d7
 65t41SQloB8c0nlilDfhPDs0kQ==
X-Google-Smtp-Source: ABdhPJzVOjTs2+dMBHWrAV/Vzcpl3BqCPHapzm0L0pSFGPG/s89dAJmBRA8IZlzHxMEmkEC7NtPxcw==
X-Received: by 2002:aa7:85d4:: with SMTP id z20mr4675435pfn.106.1598752672024; 
 Sat, 29 Aug 2020 18:57:52 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q10sm4026579pfn.206.2020.08.29.18.57.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 18:57:51 -0700 (PDT)
Subject: Re: [RFC v4 70/70] target/riscv: gdb: support vector registers for
 rv32
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-71-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e767767b-fd50-3263-fb5e-b366df009595@linaro.org>
Date: Sat, 29 Aug 2020 18:57:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-71-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: Greentime Hu <greentime.hu@sifive.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> From: Greentime Hu <greentime.hu@sifive.com>
> 
> This patch adds vector support for rv32 gdb. It allows gdb client to access
> vector registers correctly.
> 
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  gdb-xml/riscv-32bit-csr.xml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/gdb-xml/riscv-32bit-csr.xml b/gdb-xml/riscv-32bit-csr.xml
> index 3d2031da7dc..bb98b927995 100644
> --- a/gdb-xml/riscv-32bit-csr.xml
> +++ b/gdb-xml/riscv-32bit-csr.xml
> @@ -248,4 +248,11 @@
>    <reg name="mucounteren" bitsize="32"/>
>    <reg name="mscounteren" bitsize="32"/>
>    <reg name="mhcounteren" bitsize="32"/>
> +  <reg name="vstart" bitsize="32" group="vector"/>
> +  <reg name="vxsat" bitsize="32" group="vector"/>
> +  <reg name="vxrm" bitsize="32" group="vector"/>
> +  <reg name="vcsr" bitsize="32" group="vector"/>
> +  <reg name="vl" bitsize="32" group="vector"/>
> +  <reg name="vtype" bitsize="32" group="vector"/>
> +  <reg name="vlenb" bitsize="32" group="vector"/>
>  </feature>
> 

As per comments in the previous patch, needs squashing.


r~

