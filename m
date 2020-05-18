Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D2EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 12:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC67D207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 12:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="xjlgTkjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC67D207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jafMn-0004u7-V4
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 08:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jafMA-0004TU-U3
 for qemu-devel@nongnu.org; Mon, 18 May 2020 08:58:58 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jafM8-0000Ji-KB
 for qemu-devel@nongnu.org; Mon, 18 May 2020 08:58:58 -0400
Received: by mail-wr1-x429.google.com with SMTP id 50so11704217wrc.11
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 05:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=l5iVednAFBcuDKXihAW3k7FwTZ6l5dBGeJLoBnfTIg0=;
 b=xjlgTkjCQYPJSarCJVAdoMPCYIPrIqH2z1OCxNS7qdzYa2BJebMB77EKTdV9HOCetF
 kavuFZ38g6374VV+wpVb21pVKgh2cgyFVunqYHmj0+cTTuKMrDGCh2CXRg5EyLGA65TW
 w35/aTMvcyGhfp61cnGybjECv9N4A2wCoadabcLBkh/fme2iTRCXPBU7P0ObMQKdkskF
 TQPXz7rf66IrQS7Oqddkks1XzK/aPQpnpy0h0CDG2fMVPGT3s0ODexIsNUCzeORG8WMa
 eUm4ElKA+7lfLoja+D3A+oSEXzgsvpX/k41G+enPnoFVEJiUzRu0TCqKPZbDv4bgAAUx
 xTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l5iVednAFBcuDKXihAW3k7FwTZ6l5dBGeJLoBnfTIg0=;
 b=kCFBO3bMte4/mQM1awp4UyV62jZ53rJPBVE9gHwJhe0OrPKhVT0sg68WPevmBtkn7t
 03gyMj1Fctt0Gx2N+ETPZ3g10gAkUundV9UPd73iCDZGNJDxmw8H225/AqRaPN/3+S3h
 0akB/UYPVVkSmpE6kNEc+0SzPwt6DCwO1oehPQzDKxJN1MfKCYvPh+8WCwwVxEEvQM+A
 bbTQuCRPrGt9NAtSTl+LR7bC25pbnoQr50aVL1lMVxMTJhuJrreS/muOuNJ0cySXFBuH
 VH+NaseKmmSKAhYdH6CFRAFNBnhIPpIPxfBVqWeBbUK7jUaZ6EfF2knDnsn+FRqgGY3h
 DUaw==
X-Gm-Message-State: AOAM5320JDPo8VWT4JT/CTburI508pV+/o8FuKDoREBzONtxexfVk6rH
 Otu4n9ZRX75vRThhNiEZDdbmmw==
X-Google-Smtp-Source: ABdhPJx+j6dKwWVypTwqOuAkV89sdHNTMdAr1VjWdMCgjuv8OQhMbuPVEEHHNHeWrgX7//mkWEbt6Q==
X-Received: by 2002:adf:e951:: with SMTP id m17mr20177503wrn.352.1589806734964; 
 Mon, 18 May 2020 05:58:54 -0700 (PDT)
Received: from linux.home ([2a01:cb19:867e:2100:7eef:23e0:9210:3e8])
 by smtp.gmail.com with ESMTPSA id l5sm16931258wrr.72.2020.05.18.05.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 05:58:54 -0700 (PDT)
Subject: Re: [PATCH] .mailmap: Update Fred Konrad email address
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200518103920.10699-1-f4bug@amsat.org>
From: Fred Konrad <konrad@adacore.com>
Message-ID: <165726cf-9812-5474-685c-763a53d97a4e@adacore.com>
Date: Mon, 18 May 2020 14:58:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518103920.10699-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=konrad@adacore.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I wasn't aware of this mailmap stuff.

Le 5/18/20 à 12:39 PM, Philippe Mathieu-Daudé a écrit :
> Update Fred Konrad email address to avoid emails bouncing.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   .mailmap | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 6412067bde..4c7f4b7d03 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -44,6 +44,7 @@ Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@imgte
>   Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
>   Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
>   Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
> +Frederic Konrad <konrad@adacore.com> <fred.konrad@greensocs.com>
>   James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>   Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
>   Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
> 

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

