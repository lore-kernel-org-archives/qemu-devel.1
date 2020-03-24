Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAD7C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11132207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IleU1f1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11132207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGj4u-0000OR-9R
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGj3a-0007Zb-Sb
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGj3Z-0007Rb-LN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:53:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25651)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGj3Z-0007RT-I0
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585054401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+2NZ7DxN165nxt3Ld/2Dj1pHpLBcwyWWYgmoYn3tmrM=;
 b=IleU1f1iMbjcYuX40Z9AVILrjJU9275Qu0lR0HrxTxnsaOwx3tIhfCNoRlo/XlhqkOM6z6
 Z910yhcYJ+YleeQqd7zKNLhpnlet/bAc7urXIULQP8CrzMD2IO+5jJNky+BMuLfJfiY7o5
 J1s0v6Uw6u3hDb6nDtLIFn6tESJ0j4g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-CBVKkJN0OZqhnL_06Cn7Mw-1; Tue, 24 Mar 2020 08:53:19 -0400
X-MC-Unique: CBVKkJN0OZqhnL_06Cn7Mw-1
Received: by mail-ed1-f71.google.com with SMTP id b9so13670222edj.10
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 05:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iC7C9ezAbcbwQKTXyZO5oD6og3EO/2IfuRgori7ynII=;
 b=s+Cx0BdH7Di1134x7SbKsvtE5evID7ahqvqYdU8yswo0dtgpvpPPtJUs20SsSXBlRp
 xmp2SFyl9tKaXRsUHIVb8tU7lAX4CSR+3tdhqbW6ZfaP19IqtpMSqNJicGnKnLCvjtz6
 KXlGp8i/DqNXNla+2lwScfSH7BNZFhkrnSB6Vvz/yWU9Qc633ehN4mdod2wCfbW1XDPl
 xdTqALvAQrPxDQeeLLmFu3m7VhBKbv7krtaTJc5Xh0dUuT+qCih6QDC1AUgxteJoYTe5
 hQvnJ6YLMlQPvAlDwxfAVQM0WcmcBXAyI9MaWtVnnIqfjZ+PyK2rxtACFfiu2VxVpJxh
 iZCg==
X-Gm-Message-State: ANhLgQ0nw3qh2v4lpSXm+gwcS9K8YZUn4K2TZ2V5DEVIQrgCF40mfsBI
 tV0fffHRNzr6OCRE8CavbhISrwSA01Dat8yHjl1Y/fMfJFt/DlyD0zASv67JWD3kbFX6cfWc4pB
 hcvKCDCfluqXphOk=
X-Received: by 2002:a17:906:6987:: with SMTP id
 i7mr24261124ejr.12.1585054398273; 
 Tue, 24 Mar 2020 05:53:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsV6zuOSDCXlMKxsDYfJFAwKYMzwON7f615hKKeyRTyCsZ938GlnhWE459DxNrNWtkc7QooWg==
X-Received: by 2002:a17:906:6987:: with SMTP id
 i7mr24261104ejr.12.1585054397971; 
 Tue, 24 Mar 2020 05:53:17 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id m21sm1287117edb.90.2020.03.24.05.53.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 05:53:17 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] hw/arm/fsl-imx6ul: Connect watchdog interrupts
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200322211919.11335-1-linux@roeck-us.net>
 <20200322211919.11335-7-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9088952f-b594-9495-17c2-a33bab7655b2@redhat.com>
Date: Tue, 24 Mar 2020 13:53:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200322211919.11335-7-linux@roeck-us.net>
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
> With this commit, the watchdog on mcimx6ul-evk is fully operational,
> including pretimeout support.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: No change
>=20
>   hw/arm/fsl-imx6ul.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>=20
> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> index 56dfd7cecc..3ecb212da6 100644
> --- a/hw/arm/fsl-imx6ul.c
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -531,12 +531,22 @@ static void fsl_imx6ul_realize(DeviceState *dev, Er=
ror **errp)
>               FSL_IMX6UL_WDOG2_ADDR,
>               FSL_IMX6UL_WDOG3_ADDR,
>           };
> +        static const int FSL_IMX6UL_WDOGn_IRQ[FSL_IMX6UL_NUM_WDTS] =3D {
> +            FSL_IMX6UL_WDOG1_IRQ,
> +            FSL_IMX6UL_WDOG2_IRQ,
> +            FSL_IMX6UL_WDOG3_IRQ,
> +        };
>  =20
> +        object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-s=
upport",
> +                                 &error_abort);
>           object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
>                                    &error_abort);
>  =20
>           sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
>                           FSL_IMX6UL_WDOGn_ADDR[i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
> +                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
> +                                            FSL_IMX6UL_WDOGn_IRQ[i]));
>       }
>  =20
>       /*
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


