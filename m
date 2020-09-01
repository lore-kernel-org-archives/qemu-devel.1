Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D966C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62F6206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeIJp9Nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62F6206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6vH-0007bJ-M8
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6sW-0002JN-D8; Tue, 01 Sep 2020 10:03:16 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6sT-0002f1-Oc; Tue, 01 Sep 2020 10:03:15 -0400
Received: by mail-wm1-x343.google.com with SMTP id w2so1283949wmi.1;
 Tue, 01 Sep 2020 07:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TYzlQOkKzknQjFfFF2SBSjGT1uEfM2EXSsHRm3rxuSk=;
 b=BeIJp9NdxBYYJQCvwlv/SLXbcIJ9ZoJ4lGE/cw1kcLp1hXSL8wrP/gncFBtdRgbASa
 1/EokM6pWBUUkGzm/zgnyqhteG3SCnvnlu7S5EL01AKEKeUS+xmL22kbZ06ow8ewVyG4
 ZzRXQhg01vh11hMFj+Gh9jqQSE0GLzg0YqwTP6kXycGaKmU2a5B1ajmGe4WPmuRrd7+g
 OY3ph6kvDjMk4qZB2K3B2TMwbEdc1m7dTlpmBd7ZOFon9TaLveZkQ5kBdVbShDP4unzY
 NPHJObkoEmfCP2d9cse+I75lB++7LXkKIorb06dTgEO0fX/Bh0aLPkcZ9ipi3GgOAzRX
 gt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TYzlQOkKzknQjFfFF2SBSjGT1uEfM2EXSsHRm3rxuSk=;
 b=PN0WhTAZuejyAuD4u3P9yHskTNhodaV7VvIqdUibcQWNxYi8Lj/OngU+QkygNbU/mu
 4opCCUrQxGcAhmgc+Pc/BSIBFSIEz0UmyemDQ4YM/zWpuhrUcwuzijDFtFYxGIOLXNtJ
 5qWs7rlpFImhQ2Qw0gy9taWDDM2eocpAQhavv0LcI/4COyOgg+gHBNEi22sBrvblmdNI
 0O3BKhKIiyeR6HrGRi7T1WolWm8ksU239Y4bBZxSMxQB51pFLequAgycZ3rhwD0kWnh5
 9YCzcObGxwsGP4p7dS7QIn5J62XVNcQZfuhVo1+V4eRjsM+k3o8zM50DSxo6oyiHfZvJ
 AIGA==
X-Gm-Message-State: AOAM531amr0+rMWMmFRXvtsXsOCwK89v639B9BGzONnkpzvtdQgP1eS2
 SQEFhffrC10hNUcLs3obC+g=
X-Google-Smtp-Source: ABdhPJxMCrMWjzefsG5+mvgSmt89YSjfhDDiM+49GSLQY3e8ai3L+kQfZwUQ9MS7FIv075kQJyydwQ==
X-Received: by 2002:a1c:1b8f:: with SMTP id b137mr2047345wmb.151.1598968983223; 
 Tue, 01 Sep 2020 07:03:03 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id v6sm2359837wrt.90.2020.09.01.07.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 07:03:02 -0700 (PDT)
Subject: Re: [PATCH 3/3] hw/sd/sdhci: Fix DMA Transfer Block Size field
To: qemu-devel@nongnu.org
References: <20200901140127.111454-1-f4bug@amsat.org>
 <20200901140127.111454-4-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ea02b3c2-96d8-a2a1-dbf0-832bc06df503@amsat.org>
Date: Tue, 1 Sep 2020 16:03:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901140127.111454-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 1892960@bugs.launchpad.net, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>, bugs-syssec@rub.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 4:01 PM, Philippe Mathieu-Daudé wrote:
> The 'Transfer Block Size' field is 12-bit wide.
> 
> See section '2.2.2. Block Size Register (Offset 004h)' in datasheet.
> 
> Cc: qemu-stable@nongnu.org
> Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1892960
> Fixes: d7dfca0807a ("hw/sdhci: introduce standard SD host controller")
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Cc: 1892960@bugs.launchpad.net
> ---
>  hw/sd/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 60f083b84c1..beb7b7ea092 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1104,7 +1104,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>          break;
>      case SDHC_BLKSIZE:
>          if (!TRANSFERRING_DATA(s->prnsts)) {
> -            MASKED_WRITE(s->blksize, mask, value);
> +            MASKED_WRITE(s->blksize, mask, extract32(s->blksize, 0, 12));

Beh change unstaged, sorry, will repost.

>              MASKED_WRITE(s->blkcnt, mask >> 16, value >> 16);
>          }
>  
> 


