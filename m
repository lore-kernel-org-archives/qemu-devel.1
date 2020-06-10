Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AECBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E15F2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZnkFpIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E15F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj9aZ-000712-Fg
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj9Ze-0006Cq-1Q
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 18:51:58 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37131)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj9Zc-0008Im-DQ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 18:51:57 -0400
Received: by mail-wm1-x343.google.com with SMTP id y20so3305517wmi.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V+Xwr3frJpxbSF06uR71UDMmbu+ptSq1xkQqdOjPEqM=;
 b=WZnkFpIQss8M4Ef+3CPlOR2T6+epsimjOQ3JBcVed2u8uuvscggiaAm36hhjm0j40a
 HY8+BJuuo5YJf9YgepiPbvp7pHOSUmtU2Z5In+yBjHGlcaxwY+Vxp4XbOmFvtV1CcXg0
 ycdNOAMQyqTJXMoRzw2L3tVdG9gJ2LPF04zqzi3EIoK8i2dalPmax7wubRWcipJDK9Fr
 FZ49nyY89skgcQ81Ay1KY2TbvNz6tTfPaaifxATZz0guXU01uNSBma2TBjr86HA6eFFL
 /QlL8OnYZb6eRSFGU5n2hH2Y5iNi+sAHFy7qjUkMLOW0SYvLVxGN/yaUSPloXJXbDZw3
 d4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V+Xwr3frJpxbSF06uR71UDMmbu+ptSq1xkQqdOjPEqM=;
 b=Ps+Hxi9MisxNc66GkBbP45w31BThb4io+hNUmikwqP4bt26JdvZAVSJP3XdbO4VfPa
 iuV5y+bvwqkrNmmO899xSIv4BIc7Bh0f/fwbH5injc7EPTk5MAwht2k5/O4MB1M+FbBL
 9PWw+PUqRKx98lG8u9+jPvWwrS9LtkBoiBHWDtPha8R2XfVLc29m3XrT4l+Q/vcoMfHb
 oIXQi0INi6lp1fs+AfI5wMheLeL1HH5mWxyQAhYqat+23AgiQDSs0I7rgYj1+/fEUNZj
 i4YgIWGI5D5oc9ji5fY9TW0Ydv2EUpqRCL1HTirROaH0SsOWSyjIBqofIROHiB6t9klU
 1TYA==
X-Gm-Message-State: AOAM531tILgRDzXfnEewe2dSf/6YqqvjNfSvhuo9ngTXyXk0Bj/I0TPU
 r5nhgqQScoG4nPC7Adzs/q4=
X-Google-Smtp-Source: ABdhPJzDyUMchZYJ1LFttqSo5umeVu689qJVU4SEKd19doOs4ggRJ7GFn+jtDeXXN0ZEej8uAW/eLw==
X-Received: by 2002:a1c:188:: with SMTP id 130mr5263024wmb.93.1591829508228;
 Wed, 10 Jun 2020 15:51:48 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a126sm1340409wme.28.2020.06.10.15.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2020 15:51:47 -0700 (PDT)
Subject: Re: [PATCH 1/1] MAINTAINERS: Adjust sh4 maintainership
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200610221743.24627-1-aleksandar.qemu.devel@gmail.com>
 <20200610221743.24627-2-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3b784117-49ef-fbec-e8ad-df49ca0e892a@amsat.org>
Date: Thu, 11 Jun 2020 00:51:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200610221743.24627-2-aleksandar.qemu.devel@gmail.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Michael Rolnik <mrolnik@gmail.com>, Magnus Damm <magnus.damm@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 12:17 AM, Aleksandar Markovic wrote:
> This patch transfers sh4 sections to Yoshinori Sato, who is best
> positioned in the community to assume their maintainership.

https://www.mail-archive.com/qemu-devel@nongnu.org/msg708235.html

"BTW, you also dictate there Yoshimoto that to do and
 what not to do. Why?"

I suppose you meant Yoshinori? Again I'm didn't want to appear
as dictating, I spend hours trying to raise the quality of the
RX hardware model to be sure it'd be merged. You can not say
otherwise, see the latest series posted:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg708317.html

We can not say likewise with the AVR port you almost killed,
asking changes then disappearing, letting other contributors
stuck.

> He is
> the maintainer of the related target rx.
> 
> Further adjustments, reorganizations, and improvements of sh4
> sections are left to the future maintainer to be devised and
> executed, as he deems suitable.
> 
> Aurealien and Magnus are deleted from some sections from the

Typo 'Aurelien'.

> MAINTAINERS file with this patch. However, they will not be
> deleted from QEMU Hall of Fame, where their names will always
> be carved in stone as QEMU pioneers and granddadies.

Typo 'granddaddies'.

> 
> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> Acked-by: Magnus Damm <magnus.damm@gmail.com>
> Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6e7890ce82..7ddb6db38c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -296,7 +296,7 @@ F: tests/tcg/s390x/
>  L: qemu-s390x@nongnu.org
>  
>  SH4 TCG CPUs
> -M: Aurelien Jarno <aurelien@aurel32.net>
> +M: Yoshinori Sato <ysato@users.sourceforge.jp>
>  S: Odd Fixes

'Maintained'? See:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg710928.html

>  F: target/sh4/
>  F: hw/sh4/
> @@ -1251,14 +1251,14 @@ F: include/hw/riscv/opentitan.h
>  SH4 Machines
>  ------------
>  R2D
> -M: Magnus Damm <magnus.damm@gmail.com>
> +M: Yoshinori Sato <ysato@users.sourceforge.jp>
>  S: Maintained
>  F: hw/sh4/r2d.c
>  F: hw/intc/sh_intc.c
>  F: hw/timer/sh_timer.c
>  
>  Shix
> -M: Magnus Damm <magnus.damm@gmail.com>
> +M: Yoshinori Sato <ysato@users.sourceforge.jp>
>  S: Odd Fixes

Ditto 'Maintained'?

Whichever status Yoshinori like:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  F: hw/sh4/shix.c
>  
> 


