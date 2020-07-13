Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E799C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375192064B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgyTMuUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375192064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvro-0007Rq-HY
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juvqe-0006Tr-NA
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:38:12 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:40784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juvqd-00012s-Am
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:38:12 -0400
Received: by mail-ed1-x543.google.com with SMTP id b15so12986753edy.7
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 03:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XBcABSM1TSxOwgjtta8CB2tnBJCLCrbFTiLwhbBA8uw=;
 b=mgyTMuUYpMthMjaVjY2hKCJG5DbzglRwkWRK562Qoh959FS2KQYqGgOMqIgq1wJbjk
 9DoGDZZWiEVh4sz6XzTA6cJo+TmKEBTdZVYVp/gl1R3caUg3u35AsQe4+c+Br88/dPYm
 fFOpuaZO7bdYbtvEAuCwkwTT6Z1cJCTOmfq1lTrMu5zDFv103pegAZeXm7Ozt+Q21svG
 zsh0Rq5Wuzbs4csUkmo0yWAd4egFunwrWKqpQx+9vzQSTnqfOawxx8d49Qo19AG0GVK9
 G+fcFI8XVv87tEYEsUY3u/wA9cbwlSNKS6LsXgZvt8Nln2nthWU+H14f3QDusKIwrerw
 R7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XBcABSM1TSxOwgjtta8CB2tnBJCLCrbFTiLwhbBA8uw=;
 b=gA8TivVyl4+/cktn5Eg447W8eYT3UMceemDedcHYQqdcxPOIJ04qFqkqSvPxpI7ysO
 yw0Qhx1S/D4LqWttCd1xd+WaThKbh2aTJPm4ElNmjnUvPpEcUgEQAdRF7/cekfhg7CzB
 d/94qC3MXCuCLa8cDdPOOX5GwTDicoAM3hDVglgmBaftwZ1sbYAWIBeW0mKGAK1l4/39
 Yv4P1MLGGk1QI0k1aVRR28vVZg+J94m1IeTxoxcckWLTWE6sdGtYKbjp3zqShNcistnZ
 ABukmSF8ryeo9Jg7c0pxO7Kx1qj26RgAV13dlC6KvyGvJER/dWHtk7teuieI8IyQw7uM
 Wn9Q==
X-Gm-Message-State: AOAM531tTyOmW17GZFNRaBiF1C6iv/MyeG7CL/cMlwsepRh8Zyn6yMBE
 bD7F1fapOdxhZFTCTLa8sZ4=
X-Google-Smtp-Source: ABdhPJxzndJ8rZo36297UcisvYUy0Tz7rjDaXODLXtqL9cfEyMgdIwKKy9zYP0d6zF23O3r8M95sSw==
X-Received: by 2002:aa7:d283:: with SMTP id w3mr71744016edq.76.1594636689947; 
 Mon, 13 Jul 2020 03:38:09 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id b98sm11644812edf.24.2020.07.13.03.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 03:38:09 -0700 (PDT)
Subject: Re: [PATCH 02/12] target/ppc: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594631025-36219-1-git-send-email-wang.yi59@zte.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e475c4e0-527a-8778-8812-e2994d333830@amsat.org>
Date: Mon, 13 Jul 2020 12:38:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1594631025-36219-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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
Cc: xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 11:03 AM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous breaks, as there is a "return" before them.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org> 

I hadn't reviewed this patch, but now I did (you can strip the space
at the end of the line).

> ---
>  target/ppc/misc_helper.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index 55b68d1..e43a3b4 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -234,25 +234,20 @@ target_ulong helper_clcs(CPUPPCState *env, uint32_t arg)
>      case 0x0CUL:
>          /* Instruction cache line size */
>          return env->icache_line_size;
> -        break;
>      case 0x0DUL:
>          /* Data cache line size */
>          return env->dcache_line_size;
> -        break;
>      case 0x0EUL:
>          /* Minimum cache line size */
>          return (env->icache_line_size < env->dcache_line_size) ?
>              env->icache_line_size : env->dcache_line_size;
> -        break;
>      case 0x0FUL:
>          /* Maximum cache line size */
>          return (env->icache_line_size > env->dcache_line_size) ?
>              env->icache_line_size : env->dcache_line_size;
> -        break;
>      default:
>          /* Undefined */
>          return 0;
> -        break;
>      }
>  }
>  
> 


