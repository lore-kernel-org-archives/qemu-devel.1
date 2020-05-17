Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06603C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 13:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C404B2075F
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 13:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al3q4cJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C404B2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaJ7u-0004Vu-VJ
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 09:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaJ74-0003o0-D4
 for qemu-devel@nongnu.org; Sun, 17 May 2020 09:13:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaJ71-0007NS-QD
 for qemu-devel@nongnu.org; Sun, 17 May 2020 09:13:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id e16so8631817wra.7
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/p8/WlCIXf6Dh2/rL+7jLLZzifWwq/7nJ17YDmkEI4o=;
 b=Al3q4cJV4hMdjQ7oQ+xLyI05Xz45P1YuUN3xldjrx6P9sBj9bKM+qL1jbmMmVZ4z6e
 2+QxL1Euzr7F/nSobgGmP0qsNEzg3Y/lfaLJJO/L168mxvS2P3Uey91lxfGgW92Djbkw
 xpduXQqsJok8ucJVVzJipdOtpQH+WeTgQmYuqPHlaiHvYV/8Yxly8uRPuk8Srd7nEwmf
 HJp+MD9diouzu42r5M88rI6iQGvpAfLOFauiDXI8hcANgGMDcTaly25fHK/fGSoBW5vg
 bsyy3NGBLonFYl+Mwbh4P28zAN0/f2h5rjI/zLCe6MThHGPcJAuGrh0lzImPu9Z8FnYq
 rwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/p8/WlCIXf6Dh2/rL+7jLLZzifWwq/7nJ17YDmkEI4o=;
 b=dvuGBBv3p0mMR+k6qzw5JUP/nHKnYDksXxcy1pVLZDLaRttpHL9kkuTDgrQBw6QC2y
 BYFlwnf9yPrt3ThB3GILENufAKi/tSN+3ZTqOysznvtE10JvRnby85Br4/VrQp5A3/7G
 V8HBqxVEYCPT6rd+w7SKK1mWvUYuY2UTwGTWCHRdKBkVeTyO8fRfnSaYUUByUaa/x5hR
 79IrPNDFRLwt84AagLZFlqgqiiZOGT+oOnTPLWjzOPOm0b4BimV5Gbmm9D71m1kpYLi2
 9D0LA3A+QCLZAWvfOjewN9pRLQq4zdDxeugRZnx0pFZ8RlIVzjqlf9//BwibW7X6A2Mt
 5uHw==
X-Gm-Message-State: AOAM533gjC2UPKfEGZKRvj7YDq+jzdU2tZkGY/iARGJ0on2wddoNzpc7
 IBM1hrGrPXw3CmGTCSFnoF4=
X-Google-Smtp-Source: ABdhPJwed/G6bvnhnPA2gbhVN+x5ehMRGqXBatyprmAKUvT2Gd9K1tH0zq0OhXZX1RThh8TrALZEIA==
X-Received: by 2002:adf:f446:: with SMTP id f6mr14088452wrp.75.1589721229802; 
 Sun, 17 May 2020 06:13:49 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id f5sm12168137wrp.70.2020.05.17.06.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2020 06:13:47 -0700 (PDT)
Subject: Re: [PATCH v4 18/19] MAINTAINERS: Change Aleksandar Rikalo's email
 address
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
 <20200517092357.1469-19-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1aedc6fc-712c-ee30-d3f7-48b9b326a848@amsat.org>
Date: Sun, 17 May 2020 15:13:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200517092357.1469-19-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: aleksandar.rikalo@syrmia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/20 11:23 AM, Aleksandar Markovic wrote:
> Aleksandar Rikalo wants to use a different email address from
> now on.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>   .mailmap    |  3 ++-
>   MAINTAINERS | 12 ++++++------
>   2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 6412067bde..e3628c7a66 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -42,7 +42,8 @@ Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu
>   Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@mips.com>
>   Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@imgtec.com>
>   Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
> -Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
> +Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
> +Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
>   Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
>   James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>   Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f84e3ae2c..8d5562c5c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -212,7 +212,7 @@ F: disas/microblaze.c
>   MIPS TCG CPUs
>   M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>   R: Aurelien Jarno <aurelien@aurel32.net>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>   S: Maintained
>   F: target/mips/
>   F: default-configs/*mips*
> @@ -1041,7 +1041,7 @@ MIPS Machines
>   -------------
>   Jazz
>   M: Hervé Poussineau <hpoussin@reactos.org>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>   S: Maintained
>   F: hw/mips/mips_jazz.c
>   F: hw/display/jazz_led.c
> @@ -1062,7 +1062,7 @@ F: tests/acceptance/machine_mips_malta.py
>   
>   Mipssim
>   M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>   S: Odd Fixes
>   F: hw/mips/mips_mipssim.c
>   F: hw/net/mipsnet.c
> @@ -1070,7 +1070,7 @@ F: hw/net/mipsnet.c
>   R4000
>   M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>   R: Aurelien Jarno <aurelien@aurel32.net>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>   S: Obsolete
>   F: hw/mips/mips_r4k.c
>   
> @@ -1085,7 +1085,7 @@ F: include/hw/isa/vt82c686.h
>   
>   Boston
>   M: Paul Burton <pburton@wavecomp.com>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>   S: Maintained
>   F: hw/core/loader-fit.c
>   F: hw/mips/boston.c
> @@ -2582,7 +2582,7 @@ F: disas/i386.c
>   MIPS TCG target
>   M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>   R: Aurelien Jarno <aurelien@aurel32.net>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>   S: Maintained
>   F: tcg/mips/
>   
> 

