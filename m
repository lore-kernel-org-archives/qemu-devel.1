Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10E3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C83F2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTzkrXqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C83F2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqJyo-0002jT-SQ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 13:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqJyF-0002IR-VX
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:23:00 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqJyE-00051Y-Dw
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:22:59 -0400
Received: by mail-ej1-x641.google.com with SMTP id rk21so21465628ejb.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=px2LApLUHNe96CU4eLI5VISZQwl+k0L+AWIkt+8y98Q=;
 b=YTzkrXqvOurQLfODWhHUNcQ9QngoTa0N2E+cS9QSZfvGyQXhuhk6jHlRLni9n7Utkj
 I7Gx6k/EAHr0tLGhvW5X38TwSid4apuEObHWV3GkWokhIqcMVtqAr814wx6lwUmQdDAh
 c7+wxfFFVbOPFapGl7kvnouTcP73zxvdOtnCepI7fIJ2un69VuhVIFT/6J7KhMulcldS
 odYqxwzhP0spoRSqFlizxRfPK4S3eN4SpHdHs8bnF+y8Xx/iUK1uoNIp3F7HbiQ+AME2
 850NMITR06NmtYdlHn5+552khweq5WF+Q1B1mQY+71WldCZbo3AE+RaM8Zmi7m3P5zub
 xiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=px2LApLUHNe96CU4eLI5VISZQwl+k0L+AWIkt+8y98Q=;
 b=jWoy+UEM3uASTqhzoJvW/+xtuoYnKjBhDjrfOaXpp9GOwgGK+lixFlQ9OmRp4Ce0A8
 d842tA2uZhZjxcRhRFGdhwmlRKVVojy4w2Kq+Ftb7ItK7GdKB+arFGOnfI7REc7At/QI
 tnPTrO/BqGg1DDEfhlGOh9rFjsqv3Cl+dvrmpfqKwdZWEWTzmkxVFTeBNPNqPp199jdg
 L3puQvJ7yP7tPX+zxQdhPmOleyTmwmOAtR4mzPZIBTj60T9QNnXgJcVSCZ9eublGEvAe
 OmL4DVcwQ/I1Tjt1T0ZQAuMQAXarxpWREt6Lscvy9Kj29oA/uq6bfgx+og/hsJgD4b7c
 /L0A==
X-Gm-Message-State: AOAM531KdUvDgxHv5U/CUU8JHrTFSfnSy1QbKDV0oqSn9ja7GQ+0hbTK
 eUjHPw5ogJWX4W0xwvE+ass=
X-Google-Smtp-Source: ABdhPJxuoC2XVvlZiQiDFkxu9j3ejzl5uK3fNc+aPn5bomd/rJPXJWxGp4fGy3Hxa9/cEw94xEMTxw==
X-Received: by 2002:a17:906:a055:: with SMTP id
 bg21mr14836239ejb.516.1593537777071; 
 Tue, 30 Jun 2020 10:22:57 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id n2sm3530565edq.73.2020.06.30.10.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 10:22:56 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] target/mips: Remove identical if/else branches
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200630164653.24880-1-aleksandar.qemu.devel@gmail.com>
 <20200630164653.24880-2-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6310afed-4750-394f-bc89-ddbda0d41447@amsat.org>
Date: Tue, 30 Jun 2020 19:22:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630164653.24880-2-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 6:46 PM, Aleksandar Markovic wrote:
> Remove the segment:
> 
>       if (other_tc == other->current_tc) {
>           tccause = other->CP0_Cause;
>       } else {
>           tccause = other->CP0_Cause;
>       }
> 
> Original contributor can't remember what was his intention.
> 
> Bug: 1885718

The format documented in the wiki is:

Fixes: 5a25ce9487 ("mips: Hook in more reg accesses via mttr/mftr")
Buglink: https://bugs.launchpad.net/qemu/+bug/1885718

See:
https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message

> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>  target/mips/cp0_helper.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
> index bbf12e4a97..de64add038 100644
> --- a/target/mips/cp0_helper.c
> +++ b/target/mips/cp0_helper.c
> @@ -375,16 +375,9 @@ target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
>  target_ulong helper_mftc0_cause(CPUMIPSState *env)
>  {
>      int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
> -    int32_t tccause;
>      CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
>  
> -    if (other_tc == other->current_tc) {
> -        tccause = other->CP0_Cause;
> -    } else {
> -        tccause = other->CP0_Cause;
> -    }
> -
> -    return tccause;
> +    return other->CP0_Cause;
>  }
>  
>  target_ulong helper_mftc0_status(CPUMIPSState *env)
> 


