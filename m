Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0008CC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3663522261
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlWKXcMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3663522261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQuMP-0000AE-7U
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 11:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQuL9-0007Bp-Oy
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:29:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQuL6-0005vW-OS
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:29:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id f21so10219757wml.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zGSnkxFwUCC85DbHw70Gn9uGnGE12ESGX+8RM8MsmJs=;
 b=XlWKXcMwLq0o0piPYPknkJw5QgXJd8s65D67Zadv3LBqRC7St4CriLbMlqqo6LxJlS
 EBGPAlkp1ZukLlz3jYJ+b+6WuJXgT2o3y7LN3YFh9hpTxBLIVvll8o/w1exm336SdgEl
 oRI0uUfYedvzxUGo44dDuliDjjYDhPPVkb37pzhHCOrmrH+tHTDJOGUtTtVK3zZFJOul
 EjOl/aRgGqzBtzWyWA8aG2f9fqrnzfh3sw0ERIEKNUpGTNNqg4ZKxdaRUCwYcSt8gU26
 +mLMASlanLFE/eMSdAn2MULQQIRVC9yKDPORHzNFQnsxH90IyGQDc9VIh4y1+r4FpI9K
 nKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zGSnkxFwUCC85DbHw70Gn9uGnGE12ESGX+8RM8MsmJs=;
 b=i7Rr3QoYYH9sZnLAzcnkK2OoVvJVJQ0n0W5HmKxUGQGKJkyl762yQpxT3vLAJ9jfhc
 doZmuyIupP1TiC5ya5i9tJi0ETdIIkv8C8APzhJjCtOLGMrV3Iwkakyx0MLmAPJIYX81
 YXPOBKMXQUj7miEkjUuVupRPJmUP/uM+lOWzKqLvcG1GMvTYdm+G4Dn+RbSuClwa6fad
 jtRSmen5yySAwAcvIsc56DB30N9MhWV+Dwr7QJqbGPiXu2Dtue+GWmotCwdx2D0QSwvE
 RUlLojRH/2NZn03yaKEk75BNlQzsAxjKMEllLSEcgUddfZ09y8FQFONWfExn0T6KLnaU
 yubA==
X-Gm-Message-State: AOAM531QgKkGlhwxx66eUjei5wS9u4dQM6Q3fklacOFDEiwdhiWqQFne
 g5UgLiZIZt56monjcaKoN+U=
X-Google-Smtp-Source: ABdhPJyOU2MijNV7Kcub7BzmvdWknMkRjjdN0S99Efv2oTF5wKfUEer3fl+dxr3m3qrFIArGzZCG5g==
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr15438548wmz.114.1602257386938; 
 Fri, 09 Oct 2020 08:29:46 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id w5sm12482153wmg.42.2020.10.09.08.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 08:29:46 -0700 (PDT)
Subject: Re: [PATCH V13 9/9] docs/system: Update MIPS machine documentation
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
 <1602059975-10115-10-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a4b8cb9d-d4ed-0acc-e40f-d4914a8adb51@amsat.org>
Date: Fri, 9 Oct 2020 17:29:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602059975-10115-10-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.208,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Huacai,

On 10/7/20 10:39 AM, Huacai Chen wrote:
> Add Loongson-3A CPU models and Loongson-3 based machine description.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   docs/system/cpu-models-mips.rst.inc | 10 ++++++++--
>   docs/system/target-mips.rst         | 10 ++++++++++
>   2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/system/cpu-models-mips.rst.inc b/docs/system/cpu-models-mips.rst.inc
> index 499b5b6..02cc4bb 100644
> --- a/docs/system/cpu-models-mips.rst.inc
> +++ b/docs/system/cpu-models-mips.rst.inc
> @@ -48,11 +48,17 @@ across all desired hosts.
>   ``I6400``
>       MIPS64 Processor (Release 6, 2014)
>   
> +``Loongson-2E``
> +    MIPS64 Processor (Loongson 2, 2006)
> +
>   ``Loongson-2F``
>       MIPS64 Processor (Loongson 2, 2008)
>   
> -``Loongson-2E``
> -    MIPS64 Processor (Loongson 2, 2006)
> +``Loongson-3A1000``
> +    MIPS64 Processor (Loongson 3, 2010)
> +
> +``Loongson-3A4000``
> +    MIPS64 Processor (Loongson 3, 2018)
>   
>   ``mips64dspr2``
>       MIPS64 Processor (Release 2, 2006)
> diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
> index cd2a931..1f86ccb 100644
> --- a/docs/system/target-mips.rst
> +++ b/docs/system/target-mips.rst
> @@ -84,6 +84,16 @@ The Fuloong 2E emulation supports:
>   
>   -  RTL8139D as a network card chipset
>   
> +The Loongson-3 virtual platform emulation supports:
> +
> +-  Loongson 3A CPU
> +
> +-  LIOINTC as interrupt controller
> +
> +-  GPEX and virtio as variable devices

What do you mean by "as variable devices"?

> +
> +-  Both KVM and TCG supported
> +
>   The mipssim pseudo board emulation provides an environment similar to
>   what the proprietary MIPS emulator uses for running Linux. It supports:
>   
> 

