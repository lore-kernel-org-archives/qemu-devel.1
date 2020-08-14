Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0098C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614EF20774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBtClZrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614EF20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6d5Q-0000ZS-FT
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 13:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6d3w-0007CJ-6T
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:00:16 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37163)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6d3u-0004rb-CG
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:00:15 -0400
Received: by mail-pj1-x1043.google.com with SMTP id mw10so4665671pjb.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SEZRGmz5DA37H8I/I1TOST9jVFE0tezXKIjWAhPxFP4=;
 b=EBtClZrjG7uPc675BcIaduezGxAMWJ/5+7F6nqimeZchgrwRN5bV4fhVpNtTq92fuU
 OKdF8cEUzZdKkYUMm8nXs1XB9rRvK67HNpUuiZp69LLOAo8IXUjq2/5mSpVMXMNWYTMS
 zALJbyGB/+p6SCqwtBWIWNl4J0LL7Z7mU7uMMI2SebGuQ2d6yVBM5d66S/DKv+rSKZmk
 4Rh7a/g9uvOqXTnhH+OgGmn4LVB5famLvDEzdLMh/XseH4sYkKwOirHO3HwwgB9pYOTE
 KUc1Av9g68CFvyjFeA3dZ8CsyMV5OQr2s8MAdeGxqdDhSBBfN6P0izEMlRaUMs0or/0g
 VQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SEZRGmz5DA37H8I/I1TOST9jVFE0tezXKIjWAhPxFP4=;
 b=G1qlXd5yUBHeMeNOu4Iy1DYJVfACZvzJMGcIzoGNWaDHFLrgCE272BxukWih4BTIHt
 iODHI8ej3EwHpdZ74aum34NzH/Kpiv6YBkB/r16HagWmJC1Z2IQHOaxwxpozcsshwIx3
 UhXwSp0CKrkjludsEeD+IATAFi0oLCByn5iaUl/ZhF118uO2gCHnFBGPDAZmzsLbrh+x
 n8Q4oRomKJ/sytsZOQ7a0sVqb+D+bpTzOZeoFe2hBddCkqN08b6oQQT12tm0TctTs/Bv
 cj1X9hYmXFG2ZGFNxk9tTwiyXjj3bcz5GEuSYU19fc3/E4eFOICptIgd4C0ziRiru9R1
 MIfQ==
X-Gm-Message-State: AOAM530pirB8v6BznwX4juL+PfzEtzK9xyoxMYTqHQRxdcBUp8teHlQu
 R6RlzpHtZdDoPEhWgzr53VcMdA==
X-Google-Smtp-Source: ABdhPJzJVLTWERQ/VK6UZ5hRxLWe/pTv3DRGdqypJIvtsCBna2Ftehmo6BkMg6mor7tpAOUDDgH8XQ==
X-Received: by 2002:a17:902:bc82:: with SMTP id
 bb2mr2693281plb.103.1597424412889; 
 Fri, 14 Aug 2020 10:00:12 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id g8sm9987043pfo.132.2020.08.14.10.00.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 10:00:12 -0700 (PDT)
Subject: Re: [PATCH 5/7] hw/ide/atapi: Replace magic '512' value by
 BDRV_SECTOR_SIZE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-6-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <22f4a10e-c90b-7d80-bac5-4b181283d610@linaro.org>
Date: Fri, 14 Aug 2020 10:00:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814082841.27000-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 1:28 AM, Philippe Mathieu-Daudé wrote:
> Use self-explicit definitions instead of magic '512' value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/ide/atapi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
> index 17a9d635d8..14a2b0bb2f 100644
> --- a/hw/ide/atapi.c
> +++ b/hw/ide/atapi.c
> @@ -824,9 +824,9 @@ static void cmd_get_configuration(IDEState *s, uint8_t *buf)
>       *
>       *      Only a problem if the feature/profiles grow.
>       */
> -    if (max_len > 512) {
> +    if (max_len > BDRV_SECTOR_SIZE) {
>          /* XXX: assume 1 sector */
> -        max_len = 512;
> +        max_len = BDRV_SECTOR_SIZE;
>      }
>  
>      memset(buf, 0, max_len);
> @@ -1186,8 +1186,8 @@ static void cmd_read_dvd_structure(IDEState *s, uint8_t* buf)
>          }
>      }
>  
> -    memset(buf, 0, max_len > IDE_DMA_BUF_SECTORS * 512 + 4 ?
> -           IDE_DMA_BUF_SECTORS * 512 + 4 : max_len);
> +    memset(buf, 0, max_len > IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4 ?
> +           IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4 : max_len);

If you're queuing other cleanups, both of these places could usefully use MIN().


r~

