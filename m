Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E56AC4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 19:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E9920BED
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 19:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXJXp9yF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E9920BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWPWX-0007EB-Sq
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 15:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWPVR-00066D-PH; Sat, 24 Oct 2020 15:47:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWPVQ-0007QF-5X; Sat, 24 Oct 2020 15:47:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id d3so6743790wma.4;
 Sat, 24 Oct 2020 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2/kQp2YzXy+Np5zPJwesLTWPn4x5iwOyn75TK3gZk8Q=;
 b=VXJXp9yFuuiH55HjvGJo1IS07VGXqG24MRemKViVJsbwi16oU9MQtrxNbAvOrl9G58
 ja8I5AYns1XO0mrFZFEfZwHb27v6gkilhsLbGPXaYspVeZpYR6Md9gw2ADZ0mmnYtkVF
 jbmW3spq0K7XuZ4NO++1XwlWPnEwxLSQ/jw87vBLNo9s8s/8qdOCjlQKG1grl6syUji6
 7ZaaTfqHzdGj1BX2OTmc29lVkGVdUCgiFa0Ps/vH0+emwtg9uB5yvIMIODFi31085vY8
 HdKWuHOSRAeUOu8bKx58EfwZF2HNcUqT5fdtZiFLbeF/Hnyq+my+6nfQzauCsv3wud5q
 fcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2/kQp2YzXy+Np5zPJwesLTWPn4x5iwOyn75TK3gZk8Q=;
 b=DY+6wsK3/OHYPdO4TIk7fnd1UUzNusI+5fB92IEptO59bGI67hk7/qsXJAfnpEs87s
 Cj82Kg2ZwKt9WxyqMtSbz7AosD9LQv85CEBdWrJoZM507TXgnWrdI/lnxBBmshJWIwCH
 KpRxbR4Ly38Hio0dP8eAv4HM87BUzrlBehFSUz1uRnLTf6PBosQKQlXJKo3dFAB1UPr7
 FbBh8E+qLSa6/0hrhXG/sp9sYoqCMwu6y8BsqxGSVHGGenmyQ8KWKEhJARO65CFk5pAE
 fpYkczhj7KdZMMAT2+e72N+Arn9kPGi4QoM3pZUxPXT7fHHI4ofcHX6enT6AhgobNRIV
 CunQ==
X-Gm-Message-State: AOAM530lDwCjFD5EqaTpdRM30khXM9yROkAfTkJBS1AwyM1mKl2cxeux
 +enbhiIPiDMmvxo4o+RPsvc=
X-Google-Smtp-Source: ABdhPJwASzxoi3tjpSOaYCSOg3bTN5a7pqdyIK+Nl7lulI0rSSJJii7wcS6LudoghFIX/a84dFUJZA==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr8141411wmf.67.1603568830029; 
 Sat, 24 Oct 2020 12:47:10 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id o186sm12232050wmb.12.2020.10.24.12.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 12:47:09 -0700 (PDT)
Subject: Re: [PATCH] hw/sd: Zero out function selection fields before being
 populated
To: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20201024014954.21330-1-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3e9a68c0-09d3-84a2-0be3-86049e9968c2@amsat.org>
Date: Sat, 24 Oct 2020 21:47:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201024014954.21330-1-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/20 3:49 AM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> The function selection fields (399:376) should be zeroed out to
> prevent leftover from being or'ed into the switch function status
> data structure.
> 
> This fixes the boot failure as seen in the acceptance testing on
> the orangepi target.
> 
> Fixes: b638627c723a ("hw/sd: Fix incorrect populated function switch status data structure")
> Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
> 
>   hw/sd/sd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index c3febed243..bd10ec8fc4 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -824,6 +824,7 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
>       sd->data[12] = 0x80;	/* Supported group 1 functions */
>       sd->data[13] = 0x03;
>   
> +    memset(&sd->data[14], 0, 3);

This is indeed the simpler fix. Thanks for looking at
it so quickly!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>       for (i = 0; i < 6; i ++) {
>           new_func = (arg >> (i * 4)) & 0x0f;
>           if (mode && new_func != 0x0f)
> 

