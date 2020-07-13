Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D33EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB5120674
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2hB/NHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB5120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3XA-0004vc-I8
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3W4-0003mQ-Gt; Mon, 13 Jul 2020 14:49:28 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:41703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3W2-0000Nn-KI; Mon, 13 Jul 2020 14:49:28 -0400
Received: by mail-ed1-x544.google.com with SMTP id e22so14636314edq.8;
 Mon, 13 Jul 2020 11:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oX70awUWKprDcJFxffgyZel8GWHrYSnz2x5dJilE2QI=;
 b=c2hB/NHXW40ckMHTi8oJ6uSxt/Lgoc93MyMOQlwkdS4FSIvtuArS2UFF4rA4aIT27n
 JnPpk4m/ySRAyHRgPbPGq+Ihm4QG1berQteQ+9y3UHFxVL87fCNPox6ObSgj6J8SA1z9
 t5ZummJv2B3Biw4CLeFKwaxcWh6diGfUba8wEhJhwvDtlNyLbgRxY9ZmHKTLJ3FgiAjz
 3LscKM6+jzAyD48m7Vr5Dr9TsMjsz16Dv5En7R6M/aLtkzr7vlaZlMAP5CnTbwmCnqfy
 dDVX5vM8GCo0pf62MbG3m1cfOXzalg+eOm0452INj9qHUgEhaeryMB7GViXobn6gQGQq
 Znaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=oX70awUWKprDcJFxffgyZel8GWHrYSnz2x5dJilE2QI=;
 b=DY3jUI3UeTEL9i/WRzGmCkNnH8KRxqFahKuRQk8dI0eNE87JNCiG4YpYLrd/0S0gmC
 5+nKxTw7VBHpd8wXvl4J+jrFM4dB8OttsXFu6V9R7Yz8EGjDybaN87+0BPBahuTLTLJX
 RPWgwXSA4EmaH+kPAle/RPr9HHX9RFZ/aJDDdqnFcplNDVxJZhviSVHUXASERWG2H6L9
 se7YSO31zTuZXeJcEOhnvoisvuF/eUcWvnSjVkr2e8a5bkQ4LAzPkW4f6J/sniLverd2
 Wc1UHQ5c8HIsNxu5WiOuJ1qTw4qg9on9HQsRNzBnsC9fMiGCV4Xp7ju6iuycFxU0wEMn
 YavA==
X-Gm-Message-State: AOAM5329yqtaKY0o4YlUS50GUT1WBSf3qFe/HFX+iUp0uQqoqMBAF6AZ
 g1d1BmO6qyLmhE8r3VAKr6Kye5zESEM=
X-Google-Smtp-Source: ABdhPJx2xRZDJ0n//30cO4kJl76fNLMRjKrOIP0xNfqJ7zvN8aIiTKyQM4coAXOC4x0dGm7iRZOUbQ==
X-Received: by 2002:aa7:cd18:: with SMTP id b24mr808358edw.3.1594666164259;
 Mon, 13 Jul 2020 11:49:24 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id s23sm10635048ejz.53.2020.07.13.11.49.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 11:49:23 -0700 (PDT)
Subject: Re: [PATCH for-5.1 3/4] docs/system: Briefly document gumstix boards
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200713175746.5936-1-peter.maydell@linaro.org>
 <20200713175746.5936-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <39582402-ed4f-7c61-37db-67faea3e14fe@amsat.org>
Date: Mon, 13 Jul 2020 20:49:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200713175746.5936-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
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
> Add skeletal documentation of the gumstix boards
> ('connex' and 'verdex').
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/system/arm/gumstix.rst | 21 +++++++++++++++++++++
>  docs/system/target-arm.rst  |  1 +
>  MAINTAINERS                 |  1 +
>  3 files changed, 23 insertions(+)
>  create mode 100644 docs/system/arm/gumstix.rst
> 
> diff --git a/docs/system/arm/gumstix.rst b/docs/system/arm/gumstix.rst
> new file mode 100644
> index 00000000000..805e0f8d5df
> --- /dev/null
> +++ b/docs/system/arm/gumstix.rst
> @@ -0,0 +1,21 @@
> +Gumstix Connex and Verdex (``connex``, ``verdex``)
> +==================================================
> +
> +These machines model the Gumstix Connex and Verdex boards.
> +The Connex has a PXA255 CPU and the Verdex has a PXA270.
> +
> +Implemented devices:
> +
> + * Flash

Maybe "NOR flash"?

> + * SMC91C111 ethernet
> + * Interrupt controller

Most of the peripherals are controllers =)
This sounds better then raw 'interrupts'.

> + * DMA
> + * Timer
> + * GPIO
> + * MMC/SD card
> + * FIR

'Fast Infra-Red communications port'?

> + * LCDC

'LCD controller'

> + * SSP

I think only SPI is implemented.

Maybe: 'Synchronous Serial Ports (SPI)'

> + * PC Card sockets

'PCMCIA interface'?

> + * I2C
> + * I2S
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 376c18f0b17..163ab915592 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -84,6 +84,7 @@ undocumented; you can get a complete list by running
>     arm/aspeed
>     arm/digic
>     arm/musicpal
> +   arm/gumstix
>     arm/nseries
>     arm/orangepi
>     arm/palm
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 048b2d41729..286b076da89 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -650,6 +650,7 @@ R: Philippe Mathieu-Daudé <f4bug@amsat.org>
>  L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/arm/gumstix.c
> +F: docs/system/arm/gumstix.rst

Feel free to take better descriptions or as it:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>  i.MX25 PDK
>  M: Peter Maydell <peter.maydell@linaro.org>
> 


