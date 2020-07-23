Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB8AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 08:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466472071A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 08:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHLv0EtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466472071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyWwp-00022R-Fx
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 04:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyWwB-0001bW-Hq
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 04:50:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyWwA-0004XT-0S
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 04:50:47 -0400
Received: by mail-wm1-x343.google.com with SMTP id 9so4208210wmj.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BvfC+f5nlI7rJ/qL+FbEQUN76O/kuU6QWSgbreOTPgk=;
 b=vHLv0EtIlhsfTmplhi/QZQNoLN+CR3kJDHbiYdVXnrdylbLfTuvMH71Dh/2oXd8fG+
 bVNtp/gdsJ4JYvFSbE+jGmWR7El3F/BOE+8xRb1O/F033C7TwQENUFJrbMKcuN0LR4K/
 Ul1LoT3H877Htq/jBqSDXx4rOiw10qe20fDpLhI1a0zWnJpdbz+dZi/8YTD1yrhyxtYp
 rAiq/lK8dA8Nid25NEmEmNI/mEl+hTzg/njGCiitllmpGbXL/PdvCQbz2/7otHiF5Hr/
 i8rwQZQWrAKW6Rs/+zRu0VENxS9aWGE5Me82h+oVgEzb2q3IPcjwVecK3J1R3SCEBtVI
 e3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BvfC+f5nlI7rJ/qL+FbEQUN76O/kuU6QWSgbreOTPgk=;
 b=F8g2LnTXYzMz+152hHLmpr8QVPUsuxp0tR67bBwYeCIOxg4IzwccPsqFzq0yhVgzNG
 ezKmXJKfeBZQgHPmCSXXdYVv5aAYBy4bfcwsoXbi+LLLB/1fU+A32XZRCiLH79Dpvcc5
 FDiVuqI5JQtHUa2llVqoDPL3UJg08DdEGU9GeGAI2ZUE1tniUQ1U0Jjzz72uVlhWApGH
 vm+aM5TS0sG0AaN0mJb43iFVJ1p4fl1i1d3tIOUJoI4XNP/Nc7afj45raeiKuR04nWAU
 Lc3Tnzn+gpanVEA9ecBvkmcCz0AdjN7FmWgV12oQ9QZl2DTi3kb9DZ67g/HAQhaw5Ldr
 PkFA==
X-Gm-Message-State: AOAM5334sknDKV769DehYP9Dnw7cATQy9vUKJo20d8m10dNlDgDgFe7v
 7HOYDXMZHKn5safATxgMHTo=
X-Google-Smtp-Source: ABdhPJyCVbXPxH7q5LncYIdwRJEahJwDZNC3javZQ+s7lAHzQB2koUqFIBHq6xQfN3en0Kv3TOzP3g==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr1361625wmb.150.1595494244352; 
 Thu, 23 Jul 2020 01:50:44 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id p29sm2746976wmi.43.2020.07.23.01.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 01:50:43 -0700 (PDT)
Subject: Re: [PATCH for-5.1] sd/milkymist-memcard: Fix format string
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Michael Walle <michael@walle.cc>
References: <20200722204054.1400555-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <24ed28ed-0a88-925e-71e8-985cf70798b5@amsat.org>
Date: Thu, 23 Jul 2020 10:50:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200722204054.1400555-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 10:40 PM, Stefan Weil wrote:

Fixes: b98e8d1230 ("sd/milkymist-memcard: Plug minor memory leak in
realize")

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  hw/sd/milkymist-memcard.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index afdb8aa0c0..11f61294fc 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -281,7 +281,7 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
>      carddev = qdev_new(TYPE_SD_CARD);
>      qdev_prop_set_drive(carddev, "drive", blk);
>      if (!qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err)) {
> -        error_propagate_prepend(errp, err, "failed to init SD card: %s");
> +        error_propagate_prepend(errp, err, "failed to init SD card");

Oops... b98e8d1230 was to fix 3d0369ba49 ("hw/sd/milkymist-memcard:
expose a SDBus and connect the SDCard to it").

>          return;
>      }
>      s->enabled = blk && blk_is_inserted(blk);
> 


