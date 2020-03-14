Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5448BC2BB1D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 01:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F0EB2074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 01:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtLXhXyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0EB2074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCvOg-0001uu-8m
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 21:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCvO0-0001Pg-Na
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCvNz-0000jL-KW
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:14:44 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCvNy-0000cJ-Tx
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:14:43 -0400
Received: by mail-pg1-x542.google.com with SMTP id t3so6024037pgn.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 18:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kj10wAiQN54knhz52NrqN83UQ+U53gbi2GtsyNThp0Y=;
 b=AtLXhXyxcZsr3QfREdZN0rqFiDGgBpj2EvZK1JUR6eIcapYl+dBk6xPNB1zYayrJBH
 3xk52gwiaZhJV/kfQHMzUQ0wkxjHzrw0ZfQBKVoZcHXBcxbgCLOIH3FqTSvydgpt9InA
 TQ1VvGChTt9Pnh8m4pgzfHnGkW+krlDaxKm2RLnj/kcyVKnXOGPXemiJv5AiPLrgGZPi
 kIkNJ9dsIGRBgbOat6dzOAFsVKqsz+LaIPYYr5b/vXgN3WVHFDhOJFrsAJ3uMQFWzOw1
 MjFPS0Y8U3f/3YFpFHihoLDM6AXdqcmQTWdzzteAIP2xerhPkLI5YDL4MuTd4W4DuURC
 Kgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kj10wAiQN54knhz52NrqN83UQ+U53gbi2GtsyNThp0Y=;
 b=ALWh+dNrYdRp38EU6R+dPORjnWMMeMzT7bTpPs6ahzTqpZOHg0P9KVaoxvSlAaqHMq
 Q3KgzkktT3dqljo3hRI9QcGfJXChG01D2wFB5JJhMpbXN/MlfVcd9RsiKnKyyo+gfjkQ
 +xgokg6yKS+GoymkhaFLDNFI23tj8q22HN5jZNCxC8cDnXvpTnqJBTvF8O0rIRFF3+xD
 gIr0PS+IE0aTZaoWnPNF1A+tcFvCcj/kiS9dYGv2B5fzEu7WPPUbpNoYsWx3aKKInL2Y
 O6gwLc8OJuBv89ocdkGUGTb9oqCGzLpLzjqwN9hLqcKWDHYTqMSEh0ncmbojiC/GgXF+
 lcVw==
X-Gm-Message-State: ANhLgQ2E9GzSvSlwbopwakp2xydUV6UDz5GgGsQF9qVnM9j7pi33CKZM
 wbYy6hhVbYNgBkjvwgRCLe6Ojg==
X-Google-Smtp-Source: ADFU+vsDdHZqotyCkdEg1zqRU4GbRJC5oIow62gJK6qYjLxO1Rv9FDs/PX6wVFq1Sa7zgYrv8kc/Mg==
X-Received: by 2002:a62:68c2:: with SMTP id d185mr4594351pfc.16.1584148481235; 
 Fri, 13 Mar 2020 18:14:41 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 ci14sm2124730pjb.37.2020.03.13.18.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 18:14:40 -0700 (PDT)
Subject: Re: [PATCH v5 04/60] target/riscv: add vector configure instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-5-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <13770c17-b7cc-eee0-205d-e04544a23312@linaro.org>
Date: Fri, 13 Mar 2020 18:14:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-5-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl * a)
> +{
> +    TCGv s1, s2, dst;
> +    s2 = tcg_temp_new();
> +    dst = tcg_temp_new();
> +
> +    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
> +    if (a->rs1 == 0) {
> +        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
> +        s1 = tcg_const_tl(RV_VLEN_MAX);
> +    } else {
> +        s1 = tcg_temp_new();
> +        gen_get_gpr(s1, a->rs1);
> +    }
> +    gen_get_gpr(s2, a->rs2);
> +    gen_helper_vsetvl(dst, cpu_env, s1, s2);
> +    gen_set_gpr(a->rd, dst);
> +    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
> +    exit_tb(ctx);

You can use lookup_and_goto_ptr here.  But either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


