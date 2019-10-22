Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988F9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C232184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMctjm9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C232184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxkI-0000QG-NG
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMx4o-0001NE-Ja
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMx4n-0003A9-A2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:32:06 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMx4n-00039h-3C
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:32:05 -0400
Received: by mail-il1-x144.google.com with SMTP id o16so7946997ilq.9
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RXMHFBShVmiszzOvNW17FM5H8iVamBoj76040flZLAo=;
 b=oMctjm9SIIbHaWX55nm4tLFuSOKeqkHVaA54WQWXrI/vaVBeFyzHudjnV0IwNGFCUa
 EG9sTJ5877Qnw8xFrJjTp6bY810f2cyAP1gLKCzoBpyKZulbye31KRKcbEenNRh0loWI
 cKXFdxRpeIdhZAWAspB+tRJhkYu9FOhZXs61nMJS7S0ePH0Us/RLggmlaTvPIQONKZBk
 lJNx04Su8OtYbdBwnLB72V5TzvNPPSc1+V907fbuAScShyoh1UV+M7nuOoRkYj0JBGxP
 9a7bnZvS4F65KxPCGLy7/jC1DvPoRwwEutMusYZcZiOePJYOS19vbPJTq3XVeXaxCHB8
 K0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RXMHFBShVmiszzOvNW17FM5H8iVamBoj76040flZLAo=;
 b=QrOOAAs5zKaFII2r4r82oRYr4qnmh5RaBa+eNsvdkk5+skCwWQ5Z9OaObIZ9qq8eCS
 CuulKhGZ7jPu8vOYCoUvDAoH4C1DzUlqjRR2Qo1ze3kMZ0cRYuK1Cs3vXevSoMPy5Ytd
 IiUfvw+sw+iaxbw6OI04x132bWRKnr9rv56/By4MeK+e6OwF13xk6zMh8jh0zj4iLVFq
 5Y0R+/Q9TZ54XzrIvY1lHC5oVOdTRmVIcahmR/9a8ry8O2XP2jvY4U43J5xKfssFm3T1
 ifGCHbs4h6imfFA52SAh2JDB/ZBLMK3PTgw+gciK+0JB6UCwe39jpn+4Fib5mEXUOS8h
 8T7Q==
X-Gm-Message-State: APjAAAU34VyUlhN+XMVMT/IqXN/ImTQ9Fd3DwAS/w80uRGJrw/MDUzVJ
 DZryzlqs6sD5h2wi+hyn3dFPgNkc4uGNtLtkxTqJvg==
X-Google-Smtp-Source: APXvYqyA749qz9+ZDeXSYDNML5A7eWwdWokymhMnl0XK3KG3Pd4Xogwv/q8/LQiYUoYoGQzWZeQExVYU0OA9ReyY47U=
X-Received: by 2002:a92:dac4:: with SMTP id o4mr34780227ilq.137.1571761924033; 
 Tue, 22 Oct 2019 09:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
 <20191022162137.27161-11-marcandre.lureau@redhat.com>
In-Reply-To: <20191022162137.27161-11-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 17:31:51 +0100
Message-ID: <CAFEAcA-5DkdB-iUHBRONB0SHO6rYmU7ZzdojJd5iZbQdLHswTQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/28] serial: add "base" property
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Oct 2019 at 17:23, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/serial.c         | 3 +++
>  include/hw/char/serial.h | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 0ae52ec60c..4748a2b023 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -990,6 +990,7 @@ SerialState *serial_init(int base, qemu_irq irq, int =
baudbase,
>      qdev_connect_gpio_out_named(dev, "serial-irq", 0, irq);
>      qdev_prop_set_uint32(dev, "baudbase", baudbase);
>      qdev_prop_set_chr(dev, "chardev", chr);
> +    qdev_prop_set_uint64(dev, "base", base);
>      serial_realize_core(s, &error_fatal);
>      qdev_set_legacy_instance_id(dev, base, 2);
>      qdev_init_nofail(dev);
> @@ -1003,6 +1004,7 @@ SerialState *serial_init(int base, qemu_irq irq, in=
t baudbase,
>  static Property serial_properties[] =3D {
>      DEFINE_PROP_CHR("chardev", SerialState, chr),
>      DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
> +    DEFINE_PROP_UINT64("base", SerialState, base, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> @@ -1083,6 +1085,7 @@ SerialState *serial_mm_init(MemoryRegion *address_s=
pace,
>      qdev_prop_set_uint32(dev, "baudbase", baudbase);
>      qdev_prop_set_chr(dev, "chardev", chr);
>      qdev_prop_set_uint8(dev, "regshift", regshift);
> +    qdev_prop_set_uint64(dev, "base", base);
>
>      serial_realize_core(s, &error_fatal);
>      qdev_set_legacy_instance_id(DEVICE(s), base, 2);
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index ecbd3f1b40..6e9c9768ed 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -77,6 +77,7 @@ typedef struct SerialState {
>
>      QEMUTimer *modem_status_poll;
>      MemoryRegion io;
> +    uint64_t base;
>  } SerialState;

Devices shouldn't have properties to set their MMIO base
address -- instead the memory-mapped serial device should
be a child of TYPE_SYSBUS_DEVICE, and should provide
a sysbus mmio region, which users of the device can
map at the address they want to map the registers.

thanks
-- PMM

