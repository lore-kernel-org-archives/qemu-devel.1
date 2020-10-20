Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D62DC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6B82222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVzpnFws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6B82222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtOu-0003Eu-RU
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUtNE-0001wf-Ah; Tue, 20 Oct 2020 11:16:29 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUtNB-00071w-N2; Tue, 20 Oct 2020 11:16:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id 13so2188091wmf.0;
 Tue, 20 Oct 2020 08:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QirgkDFAKf0YiZ/jzWHgyHK8Ijfewqi/Y+34h9qNbas=;
 b=KVzpnFws7k0bHpUs6R2+qxCP6BtIjpawCVEi9EX2gUcZlURApAZazpmwDN3cWPoF7h
 jReyW8waCCsI/zwvKGuhnm8itGb76ynSRV07CLTg6+AxPXQEI9Rp9u/XgZUtVPuW1SG6
 tZrfntKLSF5gVQQe4qF815oG6EppMi5LQVPjENtf2By9brSghd7cte4OPZeW7/QKx/ym
 7xalHlT1a+NnLNDmCat8yq0iS5hW1Qx2kLc+JNwVUW3MtyjzBBgMtPwTAEJ5KBncr5HL
 CzsIZUXDt9CKxXPiPMN866DXUnOvuEfHRrcp19I9VSsTlIdiEOZXO5IixDLXEKnc1b1i
 6AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QirgkDFAKf0YiZ/jzWHgyHK8Ijfewqi/Y+34h9qNbas=;
 b=IjbEDTY/aHlLjuDgaJDAzbz+gWu7ZWgY4kdJJizjh1g8uxAjHslYJ9wCZiVV2uNUyR
 Q9RZPbd95AbuSvmidtFrbpvw1qmSJ492FilSYxJn2+0awWdHBNCuMOR5BDgLdYqWD3+A
 RvpZnSwOQwPaq+wBfp6U6hVFBsa36iLlW4VZZnfE/TensPs8hjkgsth9NzOuNzgIX32/
 kIxd/wiZfRGd4cp/5xPx+6zpElAT5hvPAgOC98AUVJg+YFmNIfMbHnUwPf9CsDSuRYWN
 boPQRFOrTAJTB+XxTebWCsV3MQV+eD+0xC/MbFThFG5MJOeVVyvDSrdRlH9uy7fZ5dCQ
 DdFg==
X-Gm-Message-State: AOAM532gYcTeAP1uSjWhIiIWQ7eEkkq0FbPkdzBK+sXprzU6Bs1dmuMS
 nM1UGWTyw+1FImKd6UQ1Qz4=
X-Google-Smtp-Source: ABdhPJzE4y9Q6K/Jw0oKwL6/OTN47Pj5dLx+mqW7/Mt8LN7MCGlpY+Ut0iH0y7SfiH0n7545nFgUTg==
X-Received: by 2002:a1c:3d7:: with SMTP id 206mr3586090wmd.155.1603206983154; 
 Tue, 20 Oct 2020 08:16:23 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e25sm3534251wra.71.2020.10.20.08.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 08:16:22 -0700 (PDT)
Subject: Re: [PULL 22/23] hw/sd: Fix incorrect populated function switch
 status data structure
To: qemu-devel@nongnu.org
References: <20200821172916.1260954-1-f4bug@amsat.org>
 <20200821172916.1260954-23-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e378932a-1de3-83c1-834f-ae6526604cb7@amsat.org>
Date: Tue, 20 Oct 2020 17:16:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200821172916.1260954-23-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bin,

On 8/21/20 7:29 PM, Philippe Mathieu-Daudé wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> At present the function switch status data structure bit [399:376]
> are wrongly pupulated. These 3 bytes encode function switch status
> for the 6 function groups, with 4 bits per group, starting from
> function group 6 at bit 399, then followed by function group 5 at
> bit 395, and so on.
> 
> However the codes mistakenly fills in the function group 1 status
> at bit 399. This fixes the code logic.
> 
> Fixes: a1bb27b1e9 ("SD card emulation (initial implementation)")
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> Message-Id: <1598021136-49525-1-git-send-email-bmeng.cn@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/sd/sd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 7c9d956f113..805e21fc883 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -807,11 +807,12 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
>       sd->data[11] = 0x43;
>       sd->data[12] = 0x80;	/* Supported group 1 functions */
>       sd->data[13] = 0x03;
> +
>       for (i = 0; i < 6; i ++) {
>           new_func = (arg >> (i * 4)) & 0x0f;
>           if (mode && new_func != 0x0f)
>               sd->function_group[i] = new_func;
> -        sd->data[14 + (i >> 1)] = new_func << ((i * 4) & 4);
> +        sd->data[16 - (i >> 1)] |= new_func << ((i % 2) * 4);

This patch broke the orangepi machine, reproducible running
test_arm_orangepi_bionic:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg739449.html

Can you have a look?

>       }
>       memset(&sd->data[17], 0, 47);
>       stw_be_p(sd->data + 64, sd_crc16(sd->data, 64));
> 

