Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422F9C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC16F206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXx/p/NN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC16F206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGiNz-00017E-0e
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 08:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGiNC-0000BN-Pl; Fri, 11 Sep 2020 08:41:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGiNA-0002Ip-O0; Fri, 11 Sep 2020 08:41:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id z4so11364565wrr.4;
 Fri, 11 Sep 2020 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L3+lHWWQBfI9TrJ1QhzOGr7sjc/cWOsGv5fzZ8wpOhw=;
 b=qXx/p/NNmjOfCYJE5/A5qmA3U/MmTkVVtq/4yIofMrbFU9L/tBmTG4V9vj3dem7T4F
 oS8ZhakXLBJFw8ASyRUi129HpuW7E6PrrMCFnYzpeWfEcn5Qz+nqv41UEThcJXf6/3ZT
 WKgtqb0Gc9EC9k/tka+Okiaj8IEdzVnI9wGwK7+HSqDgEtu570W6jgIwRrp/ztAonIrn
 PvoFr1FC/mgMjVP7teBsslIHremh6RldUPK3HXyT5hwvOEIu7AHDiJUb7VI+Rfe3xg9p
 F/l15zI9CmoGM5Hz9/P5RlujXNuXV/2bBUpU+94109XhX5xgjPfnBZAPEBcRPy16ARHE
 BFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L3+lHWWQBfI9TrJ1QhzOGr7sjc/cWOsGv5fzZ8wpOhw=;
 b=Jpi/ORqK1AO44VWFzx1fViAnyJIwvkAjFxyshKEnWQlwJxoS63y6AQ7i6+SmqJ/voK
 ULDhxxsYBrWgcTE0DeKORE6vm3+YtfJ9GQpKqeEg56hA2HzO5b/mhwtJiXrwAZ55Xv8O
 UX9LEPB6AEfhsCuJjQgVLZakAxH81bdPISOXQ0BfGe9zeoMpqdQNf1tJuAcR/8vrtRcE
 i+D3lzSp/RPdptB0LE0evktJTaj6LNxNMi5rod0d2/bjt29FEhUV6+c8dY7JHb6HRW5O
 KI13uBrCOfviNmkrvlzhw04Rdv7UWBXomlsD65ZF0f8Y81TVMazBgk9IFXERCWinIUNJ
 hc9w==
X-Gm-Message-State: AOAM533sEQ2KMIcMB8y3Obvz4jFcER52CVCZqz5megOyG+KTmowb5tGh
 XXqgf0qb4NtoZJ2MwIIsnao=
X-Google-Smtp-Source: ABdhPJzCXKeJ9xFaqX5TDlcx90oiPI3o1gbsItuKdXDNmmpfapLIBD7gGLRkxO3rDnvnOKZlrWuI6g==
X-Received: by 2002:adf:e304:: with SMTP id b4mr1840414wrj.141.1599828106272; 
 Fri, 11 Sep 2020 05:41:46 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id c145sm4077554wmd.7.2020.09.11.05.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 05:41:45 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/pxa2xx: Add missing fallthrough comment
To: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200911121844.404434-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7d4d07bd-e397-7d20-fb8d-6c7bd85cb850@amsat.org>
Date: Fri, 11 Sep 2020 14:41:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911121844.404434-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-2.469,
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
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/20 2:18 PM, Thomas Huth wrote:
> Let's make this file compilable with -Werror=implicit-fallthrough :
> Looking at the code, it seems like the fallthrough is intended here,
> so we should add the corresponding "/* fallthrough */" comment here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/pxa2xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index 76975d17a4..c1f45b2adf 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -443,7 +443,7 @@ static void pxa2xx_mm_write(void *opaque, hwaddr addr,
>              s->mm_regs[addr >> 2] = value;
>              break;
>          }
> -
> +        /* fallthrough */
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
> 

I keep rebasing this one from Stefan, not sure why never upstreamed :/
https://repo.or.cz/qemu/ar7.git/blobdiff/2a9c928409..5ebb514633:/hw/arm/pxa2xx.c

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


