Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6FCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7452D22464
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQbcJ2mL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7452D22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvKOs-0003uX-NL
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 08:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvKO7-00030z-JE; Tue, 14 Jul 2020 08:50:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvKO5-0002c0-V2; Tue, 14 Jul 2020 08:50:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id a6so21367797wrm.4;
 Tue, 14 Jul 2020 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vALQ1m+bUY9Sp/cTJvM6kKrtcYIuPyGdKuJajqc86pU=;
 b=CQbcJ2mLGE1+FuZlWdQj/p+SO54rqpQUvIYjD3AZx98P146jV8EaNY+Fg9juJDzZwG
 NII8F8PcgvBe9ViyvwJr8ftwfPgmqhTIgbMw/8fYxCW6mIr4IfCQ9yLgTVBguddpAfAv
 KXQ+QvJO4DWK2pIpl492a0dTIArlVi4ZilvKoe9jqVu6VzOq42s5TyWdUvtLK6MZJDzJ
 A1FQzNDW0f391+Oy8kERWxNM/AS9f2cGhIbd5GbZEC1XTSt5zsmpBEY9tJJ5z+ISjCz8
 y9sc00ZZ+gScjj4wnfwPqgIwwwMaCM8e1kB0xrhAczR4bK1yKsFtTOZEH5QJyOPwWS/7
 WkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vALQ1m+bUY9Sp/cTJvM6kKrtcYIuPyGdKuJajqc86pU=;
 b=Hycd4moFaHyrvSiUgkNmx9afd9ZN1aaE4BBTNF8a5dAZEF+Sv46/WHnmR7wWZ367mc
 61DXB1ww2C5t4l3b/eX2hHJrCQ+NL8UGr6YloxXXUErAZcvT9n7l2L5ZOAJimjt4UPH8
 0tCLAiMTKTYopD7xLOHwyxPnNRtjcTwFeBPRO0ZLbNSDTVRJ/gpkAYhwgvZSaNafRPom
 g9bn+N2MbkbHjnXGh0dnpIg5H2pg4wY1fOz0J6t2P/eHeqjPmPQkEgLsz+oyk3u/nGhr
 Mdkxg5o17MH2NKuqtkK6yuwIEG66olRy+ls888VuPBAiF/CGlIwig6q40roQB8KVMzeo
 phFQ==
X-Gm-Message-State: AOAM532C1ibIcbG4Dr9TTTRup3/2AGm3+cMFKzPddehwS9fIFDs+RL4h
 LTyck94H8czqC5RoDTvG9h98pWAd4ss=
X-Google-Smtp-Source: ABdhPJxZ7JnDg1/bmNY/M0lByYGnLhv7fKqUXmUfY9p2CwC0XHWx/V9raHfbXDii82Y6bw09YF5fqQ==
X-Received: by 2002:adf:f083:: with SMTP id n3mr5245376wro.297.1594731019718; 
 Tue, 14 Jul 2020 05:50:19 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id p8sm28473992wrq.29.2020.07.14.05.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 05:50:19 -0700 (PDT)
Subject: Re: [PATCH for-5.1 2/4] docs/system: Briefly document collie board
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200713175746.5936-1-peter.maydell@linaro.org>
 <20200713175746.5936-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <45cdd3d6-38fa-9846-34fa-890c7ccb61ec@amsat.org>
Date: Tue, 14 Jul 2020 14:50:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200713175746.5936-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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

On 7/13/20 7:57 PM, Peter Maydell wrote:
> Add skeletal documentation of the collie board.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/system/arm/collie.rst | 16 ++++++++++++++++
>  docs/system/target-arm.rst |  1 +
>  MAINTAINERS                |  1 +
>  3 files changed, 18 insertions(+)
>  create mode 100644 docs/system/arm/collie.rst
> 
> diff --git a/docs/system/arm/collie.rst b/docs/system/arm/collie.rst
> new file mode 100644
> index 00000000000..9f8dbcad25d
> --- /dev/null
> +++ b/docs/system/arm/collie.rst
> @@ -0,0 +1,16 @@
> +Sharp Zaurus SL-5500 (``collie``)
> +=================================
> +
> +This machine is a model of the Sharp Zaurus SL-5500, which is
> +based on the StrongARM SA1110.
> +
> +Implemented devices:
> +
> + * Flash

Maybe "NOR flash".

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> + * Interrupt controller
> + * Timer
> + * RTC
> + * GPIO
> + * Peripheral Pin Controller (PPC)
> + * UARTs
> + * Synchronous Serial Ports (SSP)
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 8fa51a22817..376c18f0b17 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -88,6 +88,7 @@ undocumented; you can get a complete list by running
>     arm/orangepi
>     arm/palm
>     arm/xscale
> +   arm/collie
>     arm/sx1
>     arm/stellaris
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0f578040b99..048b2d41729 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -845,6 +845,7 @@ L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/arm/collie.c
>  F: hw/arm/strongarm*
> +F: docs/system/arm/collie.rst
>  
>  Stellaris
>  M: Peter Maydell <peter.maydell@linaro.org>
> 


