Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCB4C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78FF7207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXa2Hmdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FF7207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGj3w-0007sI-NC
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGj3L-0007N3-4X
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGj3K-0007Ne-4i
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:53:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49703)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGj3K-0007NW-1X
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585054385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=So1uRdUbBgE6MXcsrCTCnt6i7+RDqSHznSh4dy94gDg=;
 b=LXa2HmdyQoknBw/1ZZakGu0H1bqX+RZOzbPcQ2aVBM3TlUEFXBBr4AKX9Mewf93I+X+2QT
 54x/e/3+Kw2oik4nVo0uWp7SMujdbdTA2xdehlX6GucG6PauuuJm8ghy7nys2m20xWVbvI
 nnCfqx2xDvHbNMZiEYqgt+6ogLxZn2k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-vtUqm4jIN6qrVcZNyqkf2A-1; Tue, 24 Mar 2020 08:53:03 -0400
X-MC-Unique: vtUqm4jIN6qrVcZNyqkf2A-1
Received: by mail-ed1-f70.google.com with SMTP id b12so11760744edy.7
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 05:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fs39/dnePH5M146xoQrUj96QduyvGI/j/GZD6HFso4U=;
 b=nnqcPvYwv28WaDzlvea0I8n4Vd4v12wcUuMh5piLhSlW4yZ67tlwpvwSczGmp9dJ61
 OJttnz+5VPJjn082W2sPPIf274GhdfjGZa7lQTajXUZsvfywfu+R0BVIaaqxFlTiIo3W
 PaQQcUcZ01wsM+pVPLIdi3pKnM8zANXQplgwpUrj9u9gifjV0keW504oo0RNnAmfD3qA
 twTHkF3J25Vb3c0AuJTykfcG/zmWgVOBuPdLc4n95uAdRBcd6E9u9fFvO7aR73kUThm8
 qBaNY12Y3/BY64gp8x+qDburdzUYzmjx7JERhOxxTGdss3K3tRFk9xh2tX/vq0GIAQKE
 /Pug==
X-Gm-Message-State: ANhLgQ3ukF8ChDtHc6L+EJr+BbtDd6uqlPzuZa17stfDNK9pzGPvXkiu
 UgpwPZiPuJKLlg+6IjQVCJBwZeYxteplPJGyGHlBkzIyhRtP93b+y6k8sUHdCRn3wWiucemGnd1
 ZpJCkN/KmpKCRyvc=
X-Received: by 2002:a05:6402:889:: with SMTP id
 e9mr26605779edy.204.1585054382332; 
 Tue, 24 Mar 2020 05:53:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsiSsmv8dQrOWqQELFbdGJloXQWAFr3+Na7k2mMdsUdG9/U//n/tAwaAMf5UDeY1+2bzQyTow==
X-Received: by 2002:a05:6402:889:: with SMTP id
 e9mr26605763edy.204.1585054382104; 
 Tue, 24 Mar 2020 05:53:02 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id b11sm589582edj.20.2020.03.24.05.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 05:53:01 -0700 (PDT)
Subject: Re: [PATCH v2 5/8] hw/arm/fsl-imx6: Connect watchdog interrupts
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200322211919.11335-1-linux@roeck-us.net>
 <20200322211919.11335-6-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <56f5387f-5528-b602-2bd0-9e2d95749893@redhat.com>
Date: Tue, 24 Mar 2020 13:53:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200322211919.11335-6-linux@roeck-us.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/22/20 10:19 PM, Guenter Roeck wrote:
> With this patch applied, the watchdog in the sabrelite emulation
> is fully operational, including pretimeout support.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: No change
>=20
>   hw/arm/fsl-imx6.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>=20
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index 13f1bf23a6..f58c85aa8c 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -433,11 +433,20 @@ static void fsl_imx6_realize(DeviceState *dev, Erro=
r **errp)
>               FSL_IMX6_WDOG1_ADDR,
>               FSL_IMX6_WDOG2_ADDR,
>           };
> +        static const int FSL_IMX6_WDOGn_IRQ[FSL_IMX6_NUM_WDTS] =3D {
> +            FSL_IMX6_WDOG1_IRQ,
> +            FSL_IMX6_WDOG2_IRQ,
> +        };
>  =20
> +        object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-s=
upport",
> +                                 &error_abort);
>           object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
>                                    &error_abort);
>  =20
>           sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX6_WDOGn_A=
DDR[i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
> +                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
> +                                            FSL_IMX6_WDOGn_IRQ[i]));
>       }
>  =20
>       /* ROM memory */
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


