Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDE9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7233121D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksh5nXr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7233121D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWar-0000Ru-3Y
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLWNx-0003C1-Jk
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLWNv-0008Lb-O0
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:49:57 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLWNv-0008L9-J5
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:49:55 -0400
Received: by mail-oi1-x244.google.com with SMTP id w144so5930110oia.6
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=t9JSSZ7mwTT1oJwnIM2VnYSftc3uh2yp3vWCQW+otEU=;
 b=ksh5nXr5KIJwWCMOaTGnQX6dpDR6/F3hwjB8zeNgUG6GY7KMwaHU0vnrUoe1dqTlNl
 RYSiK3mOys6DlgBT4SFdgoUyY7J8ZG1/BxqWlq4KrP4rLKNQ2xxV8ktAsDw6Pi4QMIUu
 xDnWTR/jjhf18Z5rJM5juClezN3a3e0A2ugGcWUu/yfXt0TjyUip2HYXEFdeJp+XzT7U
 ebcK0PjJfxBO8ji2wzfAjtojZaKlfWw8JsUXenJVxE3QKvgl4b6Q2DS9s31JO+oM/Z4A
 GAe9ZD+bzJyBpcjgvrLdhZu0ypWstH1DS5s+tK9rprAimHgrvghSomVpsvbGul7EAXP5
 oFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=t9JSSZ7mwTT1oJwnIM2VnYSftc3uh2yp3vWCQW+otEU=;
 b=WhpKBhLqKpd0nEIqvCAmN0GJvLbZQiYZvwmnBxD+51FymqxPpMUZLCkg8sItr6A2O2
 t2soVgLRXE5sqG5Ftk5h8xRcWnBRSleFJ2D/PNkZ8CIssmiO7QRrzHAxO3xkg7s5/1Wy
 kvgtugXKoWJLyIjzh1Jx1CFxc3QRzg3VofzdvmBzPX0Ca0irZoBeBNnwN6FiEjiGv6L+
 TLK7S1VmSmQhJCESSxue2Zbv7V6aVDufkYcud/Egp/9DLxjQIRPfwN8lcRpNryBXbZO6
 TapJufqHHAmh93YgYkURBUCPJR0YgTVyIJueEXwH0NFWD4Oou40esrUIFUt1X11YWGz5
 ECSA==
X-Gm-Message-State: APjAAAW2n7YN9LWXonwxYSpKCwwsrcYHY1yGISFVjS+D/kVJUTNDzwds
 BgP088vreIWZpiX3urLjYS7OG1wIIGRrnlqYIog7/g==
X-Google-Smtp-Source: APXvYqwqk9zb8w6DRZAWMkx7/NqxMqMy8YOtW/ptQsjv6Guy/j/8zRBANqpyoIW0Jcs0Lm1l/B6cNrz89AfkBPY9it0=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr8652601oik.146.1571420994719; 
 Fri, 18 Oct 2019 10:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-6-marcandre.lureau@redhat.com>
In-Reply-To: <20191018154212.13458-6-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 18:49:43 +0100
Message-ID: <CAFEAcA9dqtx8P1K3+ZiVYeM1i-UOeJmYRb2Yq91GNnj-QHe7rQ@mail.gmail.com>
Subject: Re: [PATCH 05/14] dp8393x: replace PROP_PTR with PROP_LINK
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Fri, 18 Oct 2019 at 16:42, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/mips/mips_jazz.c | 3 ++-
>  hw/net/dp8393x.c    | 7 +++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 8d010a0b6e..878925a963 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -284,7 +284,8 @@ static void mips_jazz_init(MachineState *machine,
>              dev =3D qdev_create(NULL, "dp8393x");
>              qdev_set_nic_properties(dev, nd);
>              qdev_prop_set_uint8(dev, "it_shift", 2);
> -            qdev_prop_set_ptr(dev, "dma_mr", rc4030_dma_mr);
> +            object_property_set_link(OBJECT(dev), OBJECT(rc4030_dma_mr),
> +                                     "dma_mr", &error_abort);
>              qdev_init_nofail(dev);
>              sysbus =3D SYS_BUS_DEVICE(dev);
>              sysbus_mmio_map(sysbus, 0, 0x80001000);
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index a5678e11fa..946c7a8f64 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -173,7 +173,7 @@ typedef struct dp8393xState {
>      int loopback_packet;
>
>      /* Memory access */
> -    void *dma_mr;
> +    MemoryRegion *dma_mr;
>      AddressSpace as;
>  } dp8393xState;
>
> @@ -922,7 +922,8 @@ static const VMStateDescription vmstate_dp8393x =3D {
>
>  static Property dp8393x_properties[] =3D {
>      DEFINE_NIC_PROPERTIES(dp8393xState, conf),
> -    DEFINE_PROP_PTR("dma_mr", dp8393xState, dma_mr),
> +    DEFINE_PROP_LINK("dma_mr", dp8393xState, dma_mr,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>      DEFINE_PROP_UINT8("it_shift", dp8393xState, it_shift, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };

Link property is the correct way to pass a MemoryRegion to
a device for DMA purposes, so this is a good cleanup.

> @@ -936,8 +937,6 @@ static void dp8393x_class_init(ObjectClass *klass, vo=
id *data)
>      dc->reset =3D dp8393x_reset;
>      dc->vmsd =3D &vmstate_dp8393x;
>      dc->props =3D dp8393x_properties;
> -    /* Reason: dma_mr property can't be set */
> -    dc->user_creatable =3D false;
>  }

Sidenote: as a sysbus device, this remains non-usercreatable
even though we can drop the specific flag here.


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

