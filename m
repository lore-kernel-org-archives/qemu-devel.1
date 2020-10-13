Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8AAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4389F20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAAjOCxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4389F20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSTZZ-0001xu-79
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 19:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSTYs-0001Wq-Su
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:18:30 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:47056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSTYq-0004yj-Vf
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:18:30 -0400
Received: by mail-pl1-x642.google.com with SMTP id d6so727092plo.13
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0UhB42EgcPF3PNvUEouAPch1hc+0e3TQRcOTu3sxKYY=;
 b=hAAjOCxk3gBmrHQxkCRSQr0YtWtIso94JwKImbiqexe8x2NHhTMko5TYkie6w7VJeV
 b8HymYtmyLRVDxDGhjMpjlMuQpVvRzOxV3BWkMK1yCACT/hiSdT2L/1hjVx3zRZRcNzs
 EWmGKP4lrEE6SZRZWpQYyP9GcZq3+Kq/FAWHiT9pKLHtSZf97T8AYMBk5jb3eCAHpQwg
 g9JHq0gG6YCKZ4+9xmssbYDzBK4yRgul1L9kJx+zzIsuVFlmfnTtf1NvVgKgVh37ZMst
 W6c1637/hMIP46YLpD25dX5qc6AgswhEZPBq2TJmgohantbnRpoiaQOpXh3AUhcHEBKo
 vvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0UhB42EgcPF3PNvUEouAPch1hc+0e3TQRcOTu3sxKYY=;
 b=QuKwev4yMZQU2uJrGGVuciWIcnlvTXGcU4riIU324Gu9xDHTZJerfxwKopS6UaLOB6
 tcveM8r1ZONvzQDjTHz1tMFspTTzgJjyAw6AavMoQos5sY+vKltYrBpWPwOnaaXNpQDm
 n3t0WRM2LuMiBEB+1fSC8OEO12RrHYagxal5ysGZ3CR/vJ142CgLsXxlcCRl7YOPY1qX
 Hioe2+EnQ64OMjyEOmPFo/dH7jGA8SFoJEXdPNQ9hqkpYhAHQgSRW/fKvrEpNvVNB/zI
 ah/RDGkzFjpL0529J/0Z0uu1SNAszGlYxYe442pjd+xqp2y2Vp9wVQdvuXp4E3H06emI
 PdOQ==
X-Gm-Message-State: AOAM533cwiHIDIjbDP+s1JKqoYnTGMuwRVV42d/Y8wY0Q4T5avG5XwOX
 Hq/xZbW/o/7E1VWrEzWVVZIAZw==
X-Google-Smtp-Source: ABdhPJy9MVMbMDY3VcgU+dxocxckytx0P2Iin96J5y9O8s3tHzkYWgHGRlBSHE+JVtoznn9wnRmmmw==
X-Received: by 2002:a17:902:6847:b029:d3:d44c:3c7b with SMTP id
 f7-20020a1709026847b02900d3d44c3c7bmr1606665pln.53.1602631107265; 
 Tue, 13 Oct 2020 16:18:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 3sm794524pfv.92.2020.10.13.16.18.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 16:18:26 -0700 (PDT)
Subject: Re: [PATCH] accel/tcg: Add CPU_LOG_EXEC tracing for cpu_io_recompile()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201013122658.4620-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bb8c6347-e127-941a-c9b6-fd01cdb09afb@linaro.org>
Date: Tue, 13 Oct 2020 16:18:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013122658.4620-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 5:26 AM, Peter Maydell wrote:
> When using -icount, it's useful for the CPU_LOG_EXEC logging
> to include information about when cpu_io_recompile() was
> called, because it alerts the reader of the log that the
> tracing of a previous TB execution may not actually
> correspond to an actually executed instruction. For instance
> if you're using -icount and also -singlestep then a guest
> instruction that makes an IO access appears in two
> "Trace" lines, once in a TB that triggers the cpu_io_recompile()
> and then again in the TB that actually executes.
> 
> (This is a similar reason to why the "Stopped execution of
> TB chain before..." logging in cpu_tb_exec() is helpful
> when trying to track execution flow in the logs.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Thanks, queued to tcg-next.


r~

> ---
>  accel/tcg/translate-all.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index d76097296df..4572b4901fb 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -2267,6 +2267,10 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>          tb_destroy(tb);
>      }
>  
> +    qemu_log_mask_and_addr(CPU_LOG_EXEC, tb->pc,
> +                           "cpu_io_recompile: rewound execution of TB to "
> +                           TARGET_FMT_lx "\n", tb->pc);
> +
>      /* TODO: If env->pc != tb->pc (i.e. the faulting instruction was not
>       * the first in the TB) then we end up generating a whole new TB and
>       *  repeating the fault, which is horribly inefficient.
> 


