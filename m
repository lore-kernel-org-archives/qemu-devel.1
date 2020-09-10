Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD11C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEA320C09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJTYsVLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEA320C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQE7-0003NT-Kl
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGQDX-0002y2-3A
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:18:39 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGQDV-0008DO-9E
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:18:38 -0400
Received: by mail-pf1-x444.google.com with SMTP id n14so5009281pff.6
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=Ltf1nRZ6Q2rWZdbcDFta6yhHAut3n+UyDzDSpN/RTnA=;
 b=tJTYsVLbZAjk5vuTvs1SsKtt19XBumO05jHfrpca6cYMFJKV0SZG1FzoiKfAn/6oOY
 0C1Tj3c17JCrH5Fyo+TfoH2ga+za87pYhiU4AMUygN7+lpCDXyBKCWhT5vboZobGbeZf
 +qpKxG7RoP/CRVfEhJ5qMmXgw+ezRJ9wilq+FwWAzSf2GnurID6XTBjoSrApa6EgVMBx
 7wLo6DkxkG1YocghX8Z7J45n1gS3xuSRKraxrxuJ6X3QuwF6XP5lbzjJq4MGIOObFktN
 m06jilpPpR7AJ9XOvSkjPh2171h4EuAuo47tZuLfQ7GL69GSQsZGYpvEk2shncVzh7ch
 ZsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ltf1nRZ6Q2rWZdbcDFta6yhHAut3n+UyDzDSpN/RTnA=;
 b=WbNfuLGbVixU/UH1RnQBoeBeTGlbK/fVPZvW9xnWI3a4sPd2wvfJwCPbKoR7q8luI7
 AR9Frj+D3sh5vYBcoiarTzlImgimWiWPuDstfGOsO+Y5vuoWCnnZUaB7nhB8rSejF0m0
 B6D9+QS4ni1LyyKhqu0PS4NeDi8YdvUfGRxscV0vU8H8mkwpfBtTLf7KbtotPgugo4VI
 GMtNFH7ufxE3pYCKWpM0UzOxLQ3WzosvTFYLMd6AMzseG/Aw0+Z8vZQWcLKNjJGZYAOJ
 sT2gB4zhUlU3PYyyAmQFww88OsugKuvWEDWyI3eSXbi5C/QfXynVXfKCxgwEss4YHNSn
 ssAg==
X-Gm-Message-State: AOAM531oGqB2oC+75M2OLci/F2+9LJF9PzHBvWvvtih50bCAxEdWjfrA
 Z1M9uCsmjIBhAdDArJJamTJSw6Cvw5e60Q==
X-Google-Smtp-Source: ABdhPJwuaW5RdFhUIONMKpCYh5sgxedOejjIoT9HRuNBydugWQnx3ZWW2RJ7L5GIy851Ed2CpFJEDw==
X-Received: by 2002:a63:4810:: with SMTP id v16mr5486831pga.374.1599758315112; 
 Thu, 10 Sep 2020 10:18:35 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x3sm2580860pjf.42.2020.09.10.10.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 10:18:34 -0700 (PDT)
Subject: Re: [PATCH 1/1] accel/tcg: Fix computing is_write for mips
To: Kele Huang <kele.hwang@gmail.com>, qemu-devel@nongnu.org
References: <503406> <20200910074342.20421-1-kele.hwang@gmail.com>
 <20200910074342.20421-2-kele.hwang@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7da49458-f8d7-d05a-457a-450ccda28040@linaro.org>
Date: Thu, 10 Sep 2020 10:18:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910074342.20421-2-kele.hwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.576,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 12:43 AM, Kele Huang wrote:
> Detect mips store instructions SWXC1 and SDXC1 for MIPS64 since
> MIPS64r1, and MIPS32 since MIPS32r2.
> 
> Signed-off-by: Kele Huang <kele.hwang@gmail.com>
> ---
>  accel/tcg/user-exec.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index bb039eb32d..e69b4d8780 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -712,6 +712,27 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>  
>      /* XXX: compute is_write */
>      is_write = 0;
> +
> +    /*
> +     * Detect store instructions. Required in all versions of MIPS64
> +     * since MIPS64r1. Not available in MIPS32r1. Required by MIPS32r2
> +     * and subsequent versions of MIPS32.
> +     */
> +    switch ((insn >> 3) & 0x7) {
> +        case 0x1:
> +            switch (insn & 0x7) {
> +            case 0x0: /* SWXC1 */
> +            case 0x1: /* SDXC1 */
> +                is_write = 1;
> +                break;
> +            default:
> +                break;
> +            }
> +            break;
> +        default:
> +            break;


You should detect all of the store instructions, not just the coprocessor ones.
 Compare, for example, the Sparc version around line 485.

Once done, you can also remove that /* XXX */ comment just above, which
indicates that there is work that needs doing.


r~

