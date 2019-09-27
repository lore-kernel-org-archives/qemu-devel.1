Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A46CC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D989D20872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hFzusvMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D989D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDuWM-0004UK-VE
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDtsc-0000r0-32
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDtsa-0001Bi-He
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:18:05 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDtsa-00018p-95
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:18:04 -0400
Received: by mail-pl1-x641.google.com with SMTP id q15so1338936pll.11
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WaKlHwN6AqVppHDJ4vJZkUgMDGH2LCWLKbZCrao4cnU=;
 b=hFzusvMXfQdv1yaKkQAS3LqMkGGYIaWaqgyvxOsD0Bq1OiKp7dq0NKcy4Y6sCiZ3jC
 MecGg8VYw6lX9Ym8ZuVX8ElhkwogLsjEz9zSAwUKorybsUmAUlwqhABbCkkCk9VeF6Bh
 DeJvqVhMAscCdDYYqGYSbyhngoXt/s09D5NhaKPIpBgrclJWWZY39G6ZOjTMBIrCXFDd
 vRzqqwzxqEbX9DeLKNYhFQCRtYLVaqdOjeolclL63+XcLi7FybRa4xE+YSg2c+EWIEA6
 jHnWZNLc6rgii0jATCNIzq/0FZnBLlobbe/ec7q0GJs87zzqFDLQkwXOxt+jYALVmbMd
 BjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WaKlHwN6AqVppHDJ4vJZkUgMDGH2LCWLKbZCrao4cnU=;
 b=sgtv7DnI+AGtDIslyOQa3eWcF9PIc4GyZKg/sz488qncsrToXsI4vXIfxMm/Uirw5e
 cDO5gzbXDT3BH6m5rZnR6B0zeiUVyWGZjyQyhUhRNQNZ1IVPRjpiFW8FmZDr9a560wY4
 R3t0UvA7N22BQ+33z4lqJEkthGj5EkoNKPBsaMdA4kM0D7aDCgxTiW/YzT6UNPcJhf7D
 4jDdNyHJAj/KucKaP+rWPgQme3Bv4JS/IsKZdpW9gDlHMzZjhNAmttQbA3DttlP0OTk8
 0oaYPEZ7HSk3013MI94mrboMHJbsm+5gvbK7VI2a9Nj7+wAMQzTbV++Z0d9kPzKofSY5
 IbVQ==
X-Gm-Message-State: APjAAAWmkestAcOWYYKJCCZwzZDEGqs8FNbT6j6aAXLFfxROWCsVD95Q
 tevcHwrGnR937bw+kWJc4YyW3w==
X-Google-Smtp-Source: APXvYqwjYT215IKpuqQC+//94/o7+lpq13j4k2OLz/3VUZjrAh1VQJww7HyIOuaZUXfboweTDbSiYQ==
X-Received: by 2002:a17:902:a611:: with SMTP id
 u17mr3127759plq.4.1569604682461; 
 Fri, 27 Sep 2019 10:18:02 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.118])
 by smtp.gmail.com with ESMTPSA id q88sm6431515pjq.9.2019.09.27.10.18.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Sep 2019 10:18:01 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] target/riscv: Print CPU and privledge in disas
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <ab8f108eceb973aaee565bb1fe347fcf8c788f5b.1569545120.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <960d9622-8241-efe7-cee6-1d4a1307fbc0@linaro.org>
Date: Fri, 27 Sep 2019 10:17:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ab8f108eceb973aaee565bb1fe347fcf8c788f5b.1569545120.git.alistair.francis@wdc.com>
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
Cc: alistair23@gmail.com, palmer@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/19 5:45 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/translate.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index adeddb85f6..537af0003e 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -810,7 +810,14 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>  
>  static void riscv_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
>  {
> +#ifndef CONFIG_USER_ONLY
> +    RISCVCPU *rvcpu = RISCV_CPU(cpu);
> +    CPURISCVState *env = &rvcpu->env;
> +#endif
>      qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
> +#ifndef CONFIG_USER_ONLY
> +    qemu_log("CPU: %d; priv: "TARGET_FMT_ld"\n", cpu->cpu_index, env->priv);
> +#endif
>      log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
>  }

I'm curious about the motivation here.

In particular, what difference does it make what cpu the TB is generated for?
It would seem like the more relevant place to look for this is with -d cpu or
-d exec where the TB is actually executed, which could well be multiple cpus.

As for env->priv... is there really anything in the input assembly that depends
on the privilege?  Or conversely, why priv and not all of the other bits that
are in tb_flags?  And are you placing that here in -d in_asm because are always
also using either -d op or -d op_opt, and it somehow looks better to have this
at the top?


r~

