Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403DDC433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BB22080D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lol0QnWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BB22080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwNIN-0003nR-Ah
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 06:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwNHk-0003Jh-5b; Fri, 17 Jul 2020 06:08:08 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:35378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwNHh-0003xT-Vg; Fri, 17 Jul 2020 06:08:07 -0400
Received: by mail-ed1-x543.google.com with SMTP id bm28so7245182edb.2;
 Fri, 17 Jul 2020 03:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fijTZ/0M2O2hcejJkCMqtBRYs7fUKVWzeZatu3C1vTQ=;
 b=lol0QnWMB+5RgxAM7B7/jJaFaH93Zj3ddA0HGLqwqcRFn+c4UWZuMTKhwCDUj+qIOq
 HzluK4ksKHxxvJvOLJk3dVlpmtWVP3kjnjHReeTo9mL+aAH1fpR4O3t5na3Q9jOH/3Ef
 aAwtJp/mqOIW1ivFSA04ZVV8wRqSxX9vK/zqEMQPpan/Ph85kyp0ahCPAh6cEHhKS6rL
 +APB2lFrjaiY51r2mnx7JdK8bAtQTQMZ8FypkWPOPN8dBZK+TJIH1tAtfPYDGUqgkhoy
 YrNZJowe5WXcWDOIToCwQoe5aqGUGIRo8pX9gRxxQkzRmEJypvQgd2KK7zssWqEFGxXn
 GC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fijTZ/0M2O2hcejJkCMqtBRYs7fUKVWzeZatu3C1vTQ=;
 b=C0qas2ZZBuhJR39xySxDIcshQm5TAuCtnLxoHCfWgrSck/zJKdwxKtbbzr1XgAjg+m
 ARq67qprU1/PmeZE5+qmACwuuYTcCzKIQ1cYjT8ZIndsBS1lRSvf7wFYRrCGMx/SfSjP
 egn/xGYaZhDSKMZRjBEkJlSapbGAhPaZXFSVEOxj+KLhdlnChFJ6z0FMHGmYqnXk6Oxm
 UKyAl7Mkj2oKh+mRMCDSPThkpB/EZqP8Kv5a1yFgAWjJ31ycC5Qb8+j+f3JADOYGsx6B
 gGJ4dl25A2/iAOMParUmv6/R3JJT72K/hs1DJAGq1KeS1rnDiYbMymgbSdKyfHLaApw2
 jPtg==
X-Gm-Message-State: AOAM533CRGAVsHz90R7rLtcDr+9PFuY4mGbfWq28McznECQ3rRG2eEts
 5pfe7remv5nF6dYy7kSJ0RVZTCli2NM=
X-Google-Smtp-Source: ABdhPJzEfsjIsYD5eqiSwZYeF2cU+kL15NplcZnDO4WWQT38Ec4ICYE+S0xkoKUxGuo6ZK7KLHVuCA==
X-Received: by 2002:a50:d0cc:: with SMTP id g12mr8644722edf.57.1594980483737; 
 Fri, 17 Jul 2020 03:08:03 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u13sm7536093ejx.3.2020.07.17.03.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 03:08:02 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.1 v2] hw/ide: Cancel pending DMA requests before
 setting as inactive
To: qemu-devel@nongnu.org
References: <20200717075317.5376-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <639c1f19-ed12-14cb-72ab-d49e63fb2741@amsat.org>
Date: Fri, 17 Jul 2020 12:08:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200717075317.5376-1-f4bug@amsat.org>
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 9:53 AM, Philippe Mathieu-Daudé wrote:
> libFuzzer found a case where requests are queued for later in the
> AIO context, but a command set the bus inactive, then when finally
> the requests are processed by the DMA it aborts because it is
> inactive:
> 
>  include/hw/ide/pci.h:59: IDEState *bmdma_active_if(BMDMAState *): Assertion `bmdma->bus->retry_unit != (uint8_t)-1' failed.
> 
> Reproducer available on the BugLink.
> 
> Fix by draining the pending DMA requests before inactivating the bus.
> 

Fixes: 8ccad811e6 ("use AIO for DMA transfers - enabled DMA for CDROMs")

> BugLink: https://bugs.launchpad.net/qemu/+bug/1887303
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> RFC because I don't have much clue about block drive and IDE,
> so block-team please be very careful while reviewing this bug.
> ---
>  hw/ide/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index d997a78e47..f7affafb0c 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -804,7 +804,7 @@ void dma_buf_commit(IDEState *s, uint32_t tx_bytes)
>  
>  void ide_set_inactive(IDEState *s, bool more)
>  {
> -    s->bus->dma->aiocb = NULL;
> +    ide_cancel_dma_sync(s);
>      ide_clear_retry(s);
>      if (s->bus->dma->ops->set_inactive) {
>          s->bus->dma->ops->set_inactive(s->bus->dma, more);
> 

