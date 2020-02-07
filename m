Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BA9C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 21:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A173222D9
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 21:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SU3J4FW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A173222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0B8V-0001pi-Ma
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 16:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j0B7k-00088D-IH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j0B7i-00072E-JW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:25:16 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:40364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j0B7i-0006tM-CZ; Fri, 07 Feb 2020 16:25:14 -0500
Received: by mail-il1-x143.google.com with SMTP id i7so777757ilr.7;
 Fri, 07 Feb 2020 13:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A8lKmCY6SFqSVVWqSP6h8fkZEJPKv4/jszApgkOiKCQ=;
 b=SU3J4FW4Dt7j2oi6lt9v3aRx6gyHM1TFY6E6xJ7N3FPdDIHlvHljHg9HNtqNRiNIhb
 yEYAg6jn2kvmSJb6bPXBwZ4VizInlwKlk61oafFe3YyjHGc+ZxmM1wG2P5pRdq/pMO+R
 N3Mm9xnlKUc2a8a7AN1Gmool4m1BiHkAQSJa/j6b6+7km2jfsePW8m9iJDt4oHMzOvvo
 +C3OHZJZZwtRfkrDgGN3YuUo4/t3IrVSJpXBejpYBiZjtHkckaUOjN9LN3Y3MDod60vd
 Z4XnTlU/DJRr/sj+ASAN8Z3znZs9eMeSwwejJUYMMvZn6S3jndLfsXwvxLFrzNPxh427
 E1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A8lKmCY6SFqSVVWqSP6h8fkZEJPKv4/jszApgkOiKCQ=;
 b=Oh+hbIc0HeVgXwonNBZ4W56Ur6ssv41vKjoHdppt2Ms846lZKaf5nx+y+Qti+HbfPG
 7Sn3L5amfO6xPF7AfRghEXMzuWcoIOSs3JXko424rXTqndPmjkddcwe1eMEa9XDP7oly
 9xcUnmmFPYyvpL6r51PoKX8lusEJ1uWBRsODbs/usJhECibKGjvWPzatrnMaUfsyBH1E
 I+xN2mzSmYBhOb48y2VhoeTUyEEkNt8wIt1oCQbs+mr7IX14BiaZlfwU1bTBT+w8iPFk
 zvVj3k64hWAVfED54mIZ6/OhAHDEpBtdRxNJtSHB4vAb/4AlgsgXZuDzmUuwX9YM2ZSX
 XY0Q==
X-Gm-Message-State: APjAAAVLyIGRoXVqraHGnnBg9Kp6KADWU/dOmy6C/n2lVH8x2ZdrAo6q
 TX+sOMvlEt8IkDcVN1zPjnitLOy00t/IrobmuYg=
X-Google-Smtp-Source: APXvYqwEBlcJdhFs1gO0N88PX/BODrm2O+IZLaLZAdI8W+eVeCqHn7V0SNCexrAAYSl9ZIhvRFU1gIqBtkXX5wvmbuw=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr1431259ilq.306.1581110713038; 
 Fri, 07 Feb 2020 13:25:13 -0800 (PST)
MIME-Version: 1.0
References: <20200207174548.9087-1-linux@roeck-us.net>
In-Reply-To: <20200207174548.9087-1-linux@roeck-us.net>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 7 Feb 2020 22:25:01 +0100
Message-ID: <CAPan3WqT8gUmpjboD460CVP2imYftMHtRQ+rcmvEiDXnLN+3=A@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm: ast2600: Wire up EHCI controllers
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: multipart/alternative; boundary="00000000000066bd72059e03061b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000066bd72059e03061b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Fri, Feb 7, 2020 at 6:46 PM Guenter Roeck <linux@roeck-us.net> wrote:

> Initialize EHCI controllers on AST2600 using the existing
> TYPE_PLATFORM_EHCI. After this change, booting ast2600-evb
> into Linux successfully instantiates a USB interface after
> the necessary changes are made to its devicetree files.
>
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-platform: EHCI generic platform driver
> ehci-platform 1e6a3000.usb: EHCI Host Controller
> ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number 1
> ehci-platform 1e6a3000.usb: irq 25, io mem 0x1e6a3000
> ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
> usb usb1: Manufacturer: Linux 5.5.0-09825-ga0802f2d0ef5-dirty ehci_hcd
> usb 1-1: new high-speed USB device number 2 using ehci-platform
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Rebased to master (to fix context conflict)
>     Added Reviewed-by: tag
>
>  hw/arm/aspeed_ast2600.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 90cf1c755d..446b44d31c 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -31,6 +31,8 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {
>      [ASPEED_FMC]       =3D 0x1E620000,
>      [ASPEED_SPI1]      =3D 0x1E630000,
>      [ASPEED_SPI2]      =3D 0x1E641000,
> +    [ASPEED_EHCI1]     =3D 0x1E6A1000,
> +    [ASPEED_EHCI2]     =3D 0x1E6A3000,
>      [ASPEED_MII1]      =3D 0x1E650000,
>      [ASPEED_MII2]      =3D 0x1E650008,
>      [ASPEED_MII3]      =3D 0x1E650010,
> @@ -79,6 +81,8 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {
>      [ASPEED_ADC]       =3D 78,
>      [ASPEED_XDMA]      =3D 6,
>      [ASPEED_SDHCI]     =3D 43,
> +    [ASPEED_EHCI1]     =3D 5,
> +    [ASPEED_EHCI2]     =3D 9,
>      [ASPEED_EMMC]      =3D 15,
>      [ASPEED_GPIO]      =3D 40,
>      [ASPEED_GPIO_1_8V] =3D 11,
> @@ -166,6 +170,11 @@ static void aspeed_soc_ast2600_init(Object *obj)
>                                sizeof(s->spi[i]), typename);
>      }
>
> +    for (i =3D 0; i < sc->ehcis_num; i++) {
> +        sysbus_init_child_obj(obj, "ehci[*]", OBJECT(&s->ehci[i]),
> +                              sizeof(s->ehci[i]), TYPE_PLATFORM_EHCI);
> +    }
> +
>      snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
>      sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdmc)=
,
>                            typename);
> @@ -416,6 +425,19 @@ static void aspeed_soc_ast2600_realize(DeviceState
> *dev, Error **errp)
>                          s->spi[i].ctrl->flash_window_base);
>      }
>
> +    /* EHCI */
> +    for (i =3D 0; i < sc->ehcis_num; i++) {
> +        object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized",
> &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>

Would it make sense to directly use error_fatal in the call to
object_property_set_bool?
That way you can avoid the additional code for propagating the error.


> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
> +                        sc->memmap[ASPEED_EHCI1 + i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
> +                           aspeed_soc_get_irq(s, ASPEED_EHCI1 + i));
> +    }
> +
>      /* SDMC - SDRAM Memory Controller */
>      object_property_set_bool(OBJECT(&s->sdmc), true, "realized", &err);
>      if (err) {
> @@ -534,6 +556,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass
> *oc, void *data)
>      sc->silicon_rev  =3D AST2600_A0_SILICON_REV;
>      sc->sram_size    =3D 0x10000;
>      sc->spis_num     =3D 2;
> +    sc->ehcis_num    =3D 2;
>

Since this field is only set once here, does it need to be part of the
class state?


>      sc->wdts_num     =3D 4;
>      sc->macs_num     =3D 4;
>      sc->irqmap       =3D aspeed_soc_ast2600_irqmap;
> --
> 2.17.1
>
>
>
Rest looks good to me.

Regards,
Niek


--=20
Niek Linnenbank

--00000000000066bd72059e03061b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Guenter,<br></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 7, 2020 at 6:46 PM Guenter=
 Roeck &lt;<a href=3D"mailto:linux@roeck-us.net">linux@roeck-us.net</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Initiali=
ze EHCI controllers on AST2600 using the existing<br>
TYPE_PLATFORM_EHCI. After this change, booting ast2600-evb<br>
into Linux successfully instantiates a USB interface after<br>
the necessary changes are made to its devicetree files.<br>
<br>
ehci_hcd: USB 2.0 &#39;Enhanced&#39; Host Controller (EHCI) Driver<br>
ehci-platform: EHCI generic platform driver<br>
ehci-platform 1e6a3000.usb: EHCI Host Controller<br>
ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number 1<b=
r>
ehci-platform 1e6a3000.usb: irq 25, io mem 0x1e6a3000<br>
ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00<br>
usb usb1: Manufacturer: Linux 5.5.0-09825-ga0802f2d0ef5-dirty ehci_hcd<br>
usb 1-1: new high-speed USB device number 2 using ehci-platform<br>
<br>
Reviewed-by: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kaod.org" targ=
et=3D"_blank">clg@kaod.org</a>&gt;<br>
Signed-off-by: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net" targ=
et=3D"_blank">linux@roeck-us.net</a>&gt;<br>
---<br>
v2: Rebased to master (to fix context conflict)<br>
=C2=A0 =C2=A0 Added Reviewed-by: tag<br>
<br>
=C2=A0hw/arm/aspeed_ast2600.c | 23 +++++++++++++++++++++++<br>
=C2=A01 file changed, 23 insertions(+)<br>
<br>
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c<br>
index 90cf1c755d..446b44d31c 100644<br>
--- a/hw/arm/aspeed_ast2600.c<br>
+++ b/hw/arm/aspeed_ast2600.c<br>
@@ -31,6 +31,8 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0[ASPEED_FMC]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x1E620000,<=
br>
=C2=A0 =C2=A0 =C2=A0[ASPEED_SPI1]=C2=A0 =C2=A0 =C2=A0 =3D 0x1E630000,<br>
=C2=A0 =C2=A0 =C2=A0[ASPEED_SPI2]=C2=A0 =C2=A0 =C2=A0 =3D 0x1E641000,<br>
+=C2=A0 =C2=A0 [ASPEED_EHCI1]=C2=A0 =C2=A0 =C2=A0=3D 0x1E6A1000,<br>
+=C2=A0 =C2=A0 [ASPEED_EHCI2]=C2=A0 =C2=A0 =C2=A0=3D 0x1E6A3000,<br>
=C2=A0 =C2=A0 =C2=A0[ASPEED_MII1]=C2=A0 =C2=A0 =C2=A0 =3D 0x1E650000,<br>
=C2=A0 =C2=A0 =C2=A0[ASPEED_MII2]=C2=A0 =C2=A0 =C2=A0 =3D 0x1E650008,<br>
=C2=A0 =C2=A0 =C2=A0[ASPEED_MII3]=C2=A0 =C2=A0 =C2=A0 =3D 0x1E650010,<br>
@@ -79,6 +81,8 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0[ASPEED_ADC]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 78,<br>
=C2=A0 =C2=A0 =C2=A0[ASPEED_XDMA]=C2=A0 =C2=A0 =C2=A0 =3D 6,<br>
=C2=A0 =C2=A0 =C2=A0[ASPEED_SDHCI]=C2=A0 =C2=A0 =C2=A0=3D 43,<br>
+=C2=A0 =C2=A0 [ASPEED_EHCI1]=C2=A0 =C2=A0 =C2=A0=3D 5,<br>
+=C2=A0 =C2=A0 [ASPEED_EHCI2]=C2=A0 =C2=A0 =C2=A0=3D 9,<br>
=C2=A0 =C2=A0 =C2=A0[ASPEED_EMMC]=C2=A0 =C2=A0 =C2=A0 =3D 15,<br>
=C2=A0 =C2=A0 =C2=A0[ASPEED_GPIO]=C2=A0 =C2=A0 =C2=A0 =3D 40,<br>
=C2=A0 =C2=A0 =C2=A0[ASPEED_GPIO_1_8V] =3D 11,<br>
@@ -166,6 +170,11 @@ static void aspeed_soc_ast2600_init(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(s-&gt;spi[i]), typename);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; sc-&gt;ehcis_num; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;ehci[*]&quot;=
, OBJECT(&amp;s-&gt;ehci[i]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(s-&gt;ehci[i]), TYPE_PLATFORM_EHCI);=
<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0snprintf(typename, sizeof(typename), &quot;aspeed.sdmc-=
%s&quot;, socname);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_init_child_obj(obj, &quot;sdmc&quot;, OBJECT(&am=
p;s-&gt;sdmc), sizeof(s-&gt;sdmc),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0typename);<br>
@@ -416,6 +425,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;spi[i].ctrl-&gt;flash_window_base);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 /* EHCI */<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; sc-&gt;ehcis_num; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&gt;ehc=
i[i]), true, &quot;realized&quot;, &amp;err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Would it=
 make sense to directly use error_fatal in the call to object_property_set_=
bool?</div><div>That way you can avoid the additional code for propagating =
the error.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;ehci=
[i]), 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sc-&gt;memmap[ASPEED_EHCI1 + i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;e=
hci[i]), 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0aspeed_soc_get_irq(s, ASPEED_EHCI1 + i));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* SDMC - SDRAM Memory Controller */<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_bool(OBJECT(&amp;s-&gt;sdmc), true,=
 &quot;realized&quot;, &amp;err);<br>
=C2=A0 =C2=A0 =C2=A0if (err) {<br>
@@ -534,6 +556,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *=
oc, void *data)<br>
=C2=A0 =C2=A0 =C2=A0sc-&gt;silicon_rev=C2=A0 =3D AST2600_A0_SILICON_REV;<br=
>
=C2=A0 =C2=A0 =C2=A0sc-&gt;sram_size=C2=A0 =C2=A0 =3D 0x10000;<br>
=C2=A0 =C2=A0 =C2=A0sc-&gt;spis_num=C2=A0 =C2=A0 =C2=A0=3D 2;<br>
+=C2=A0 =C2=A0 sc-&gt;ehcis_num=C2=A0 =C2=A0 =3D 2;<br></blockquote><div><b=
r></div><div>Since this field is only set once here, does it need to be par=
t of the class state? <br></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0sc-&gt;wdts_num=C2=A0 =C2=A0 =C2=A0=3D 4;<br>
=C2=A0 =C2=A0 =C2=A0sc-&gt;macs_num=C2=A0 =C2=A0 =C2=A0=3D 4;<br>
=C2=A0 =C2=A0 =C2=A0sc-&gt;irqmap=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D aspeed_soc_=
ast2600_irqmap;<br>
-- <br>
2.17.1<br>
<br>
<br>
</blockquote></div><div><br></div><div>Rest looks good to me.</div><div><br=
></div><div>Regards,</div><div>Niek<br></div><div><br></div><br>-- <br><div=
 dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Niek Linnenban=
k<br><br></div></div></div></div>

--00000000000066bd72059e03061b--

