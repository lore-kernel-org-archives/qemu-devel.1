Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7009C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 22:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7215421741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 22:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak3TJckp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7215421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0BvS-0006PG-BY
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 17:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j0BuQ-0005Oq-1H
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 17:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j0BuN-0003Mb-Up
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 17:15:33 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:35154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j0BuN-0003J6-O1; Fri, 07 Feb 2020 17:15:31 -0500
Received: by mail-io1-xd42.google.com with SMTP id h8so1245957iob.2;
 Fri, 07 Feb 2020 14:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tJ+5VKOz5AWPmoP1ROx9Anc4rl6uCmO8gTn/cYButMM=;
 b=Ak3TJckprBUgEzs6TOJSsouTFVgzxbjnBPpuCYxXwwgd3/toFFBC5FltslziPkMhPB
 UWGgbXBCUDsfli9tiznB2GuvWwNcc9z9eAlXfOARtZZccPk+h3245tFkfubphnu/APyG
 yAD0bZZmPjSFIDvcveUYKyidhjBQCZDRaViBXrJx3w5rsoqDsuE3h6lmmnO4Wfze+1SI
 HPyvTH4WTkZDtiIT1P9l5e4KkqDlawtVByZUOIycbrbGqqL+A/MJ8u//ltJktNdZIMih
 ihbxrDMda7Jlwl+7Eh46L04da/SX/Uk8nL1bPgyj9nPwXEa/ANjOXYbTPgnQnYVTOmj6
 gNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tJ+5VKOz5AWPmoP1ROx9Anc4rl6uCmO8gTn/cYButMM=;
 b=hC/Z6hF+qz8zLtNU/7JR81bgXp8hObO8OC6gEEGlmM9YNPM/FYsdbZ8sIXwftOgT0+
 PfUPzNZhQnKIwBn8iZ8d9oB4nQMt701TamSoG4O+9dZRUKjk0FXtT0b4/2UGLlIpecTY
 r6zVHmhYXzTMgeGfUT1G0AZC8vDVNoTdHDS7wW2fOLPBI912JHYbJ1BGH2WmHmwEo2uk
 fylbHh25zlzKi1xmgEv6wED02msPAZ34ud/oIs76Sln+BnKlQ4bSimnSBPeLZqaciyfx
 L2zrJxnDssBs/1/KueEBAkRO7JP04Xb3pjztTZKLfVPjxMlRhBoy8ls9iChTwdEfkSWN
 Y/cw==
X-Gm-Message-State: APjAAAW9MnDEWDy4QkNfc5cQDjO2WAjujPXY+9QNRWHsp9irOyB3fo50
 iE7yoiv80UqPcvkXWkIz6/sc038WhkLallhIcZM=
X-Google-Smtp-Source: APXvYqydts+8dnL88rQH9Duf2fdNJx9g/iCHgkrX2UnPbIstRvB6yZr+d1UDFGiyJ3aMyaSGZWb5Y1AKx7sXhFYxRaA=
X-Received: by 2002:a02:8817:: with SMTP id r23mr605010jai.120.1581113730722; 
 Fri, 07 Feb 2020 14:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20200207174548.9087-1-linux@roeck-us.net>
 <CAPan3WqT8gUmpjboD460CVP2imYftMHtRQ+rcmvEiDXnLN+3=A@mail.gmail.com>
 <20200207213419.GA7154@roeck-us.net>
In-Reply-To: <20200207213419.GA7154@roeck-us.net>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 7 Feb 2020 23:15:18 +0100
Message-ID: <CAPan3Wo2fkuWDEmK8JY+j0xHYRNw+UMLAfTSOtdu1vvb7ktxqg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm: ast2600: Wire up EHCI controllers
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: multipart/alternative; boundary="00000000000044ee1e059e03bacf"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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

--00000000000044ee1e059e03bacf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2020, 22:34 Guenter Roeck <linux@roeck-us.net> wrote:

> On Fri, Feb 07, 2020 at 10:25:01PM +0100, Niek Linnenbank wrote:
> > Hi Guenter,
> >
> > On Fri, Feb 7, 2020 at 6:46 PM Guenter Roeck <linux@roeck-us.net> wrote=
:
> >
> > > Initialize EHCI controllers on AST2600 using the existing
> > > TYPE_PLATFORM_EHCI. After this change, booting ast2600-evb
> > > into Linux successfully instantiates a USB interface after
> > > the necessary changes are made to its devicetree files.
> > >
> > > ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> > > ehci-platform: EHCI generic platform driver
> > > ehci-platform 1e6a3000.usb: EHCI Host Controller
> > > ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus
> number 1
> > > ehci-platform 1e6a3000.usb: irq 25, io mem 0x1e6a3000
> > > ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
> > > usb usb1: Manufacturer: Linux 5.5.0-09825-ga0802f2d0ef5-dirty ehci_hc=
d
> > > usb 1-1: new high-speed USB device number 2 using ehci-platform
> > >
> > > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > > v2: Rebased to master (to fix context conflict)
> > >     Added Reviewed-by: tag
> > >
> > >  hw/arm/aspeed_ast2600.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> > > index 90cf1c755d..446b44d31c 100644
> > > --- a/hw/arm/aspeed_ast2600.c
> > > +++ b/hw/arm/aspeed_ast2600.c
> > > @@ -31,6 +31,8 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D=
 {
> > >      [ASPEED_FMC]       =3D 0x1E620000,
> > >      [ASPEED_SPI1]      =3D 0x1E630000,
> > >      [ASPEED_SPI2]      =3D 0x1E641000,
> > > +    [ASPEED_EHCI1]     =3D 0x1E6A1000,
> > > +    [ASPEED_EHCI2]     =3D 0x1E6A3000,
> > >      [ASPEED_MII1]      =3D 0x1E650000,
> > >      [ASPEED_MII2]      =3D 0x1E650008,
> > >      [ASPEED_MII3]      =3D 0x1E650010,
> > > @@ -79,6 +81,8 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {
> > >      [ASPEED_ADC]       =3D 78,
> > >      [ASPEED_XDMA]      =3D 6,
> > >      [ASPEED_SDHCI]     =3D 43,
> > > +    [ASPEED_EHCI1]     =3D 5,
> > > +    [ASPEED_EHCI2]     =3D 9,
> > >      [ASPEED_EMMC]      =3D 15,
> > >      [ASPEED_GPIO]      =3D 40,
> > >      [ASPEED_GPIO_1_8V] =3D 11,
> > > @@ -166,6 +170,11 @@ static void aspeed_soc_ast2600_init(Object *obj)
> > >                                sizeof(s->spi[i]), typename);
> > >      }
> > >
> > > +    for (i =3D 0; i < sc->ehcis_num; i++) {
> > > +        sysbus_init_child_obj(obj, "ehci[*]", OBJECT(&s->ehci[i]),
> > > +                              sizeof(s->ehci[i]), TYPE_PLATFORM_EHCI=
);
> > > +    }
> > > +
> > >      snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
> > >      sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc),
> sizeof(s->sdmc),
> > >                            typename);
> > > @@ -416,6 +425,19 @@ static void aspeed_soc_ast2600_realize(DeviceSta=
te
> > > *dev, Error **errp)
> > >                          s->spi[i].ctrl->flash_window_base);
> > >      }
> > >
> > > +    /* EHCI */
> > > +    for (i =3D 0; i < sc->ehcis_num; i++) {
> > > +        object_property_set_bool(OBJECT(&s->ehci[i]), true,
> "realized",
> > > &err);
> > > +        if (err) {
> > > +            error_propagate(errp, err);
> > > +            return;
> > > +        }
> > >
> >
> > Would it make sense to directly use error_fatal in the call to
> > object_property_set_bool?
> > That way you can avoid the additional code for propagating the error.
> >
>
> The code matches the pattern used in the rest of the function.
> Given that, I would be hesitant to change it for this one case.
>

I see. There are some uses of error_fatal already in the function, but
improving that might be something for another patch I guess.

>
> >
> > > +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
> > > +                        sc->memmap[ASPEED_EHCI1 + i]);
> > > +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
> > > +                           aspeed_soc_get_irq(s, ASPEED_EHCI1 + i));
> > > +    }
> > > +
> > >      /* SDMC - SDRAM Memory Controller */
> > >      object_property_set_bool(OBJECT(&s->sdmc), true, "realized",
> &err);
> > >      if (err) {
> > > @@ -534,6 +556,7 @@ static void
> aspeed_soc_ast2600_class_init(ObjectClass
> > > *oc, void *data)
> > >      sc->silicon_rev  =3D AST2600_A0_SILICON_REV;
> > >      sc->sram_size    =3D 0x10000;
> > >      sc->spis_num     =3D 2;
> > > +    sc->ehcis_num    =3D 2;
> > >
> >
> > Since this field is only set once here, does it need to be part of the
> > class state?
> >
>
> The same applies to spis_num, wdts_num, and macs_num.
> AspeedSoCClass is defined for all ast2X00 SoCs, and
> the same mechanism is used for all of them. I don't see
> the benefit of deviating from a common mechanism.
>

Ignore my comment here, i did not see this patch was part of previous work
done for the other AST socs as well.

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

>
> Guenter
>

--00000000000044ee1e059e03bacf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Feb 7, 2020, 22:34 Guenter Roeck &lt;<a href=
=3D"mailto:linux@roeck-us.net">linux@roeck-us.net</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">On Fri, Feb 07, 2020 at 10:25:01PM +0100, Nie=
k Linnenbank wrote:<br>
&gt; Hi Guenter,<br>
&gt; <br>
&gt; On Fri, Feb 7, 2020 at 6:46 PM Guenter Roeck &lt;<a href=3D"mailto:lin=
ux@roeck-us.net" target=3D"_blank" rel=3D"noreferrer">linux@roeck-us.net</a=
>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Initialize EHCI controllers on AST2600 using the existing<br>
&gt; &gt; TYPE_PLATFORM_EHCI. After this change, booting ast2600-evb<br>
&gt; &gt; into Linux successfully instantiates a USB interface after<br>
&gt; &gt; the necessary changes are made to its devicetree files.<br>
&gt; &gt;<br>
&gt; &gt; ehci_hcd: USB 2.0 &#39;Enhanced&#39; Host Controller (EHCI) Drive=
r<br>
&gt; &gt; ehci-platform: EHCI generic platform driver<br>
&gt; &gt; ehci-platform 1e6a3000.usb: EHCI Host Controller<br>
&gt; &gt; ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus =
number 1<br>
&gt; &gt; ehci-platform 1e6a3000.usb: irq 25, io mem 0x1e6a3000<br>
&gt; &gt; ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00<br>
&gt; &gt; usb usb1: Manufacturer: Linux 5.5.0-09825-ga0802f2d0ef5-dirty ehc=
i_hcd<br>
&gt; &gt; usb 1-1: new high-speed USB device number 2 using ehci-platform<b=
r>
&gt; &gt;<br>
&gt; &gt; Reviewed-by: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kaod=
.org" target=3D"_blank" rel=3D"noreferrer">clg@kaod.org</a>&gt;<br>
&gt; &gt; Signed-off-by: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us=
.net" target=3D"_blank" rel=3D"noreferrer">linux@roeck-us.net</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; v2: Rebased to master (to fix context conflict)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Added Reviewed-by: tag<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 hw/arm/aspeed_ast2600.c | 23 +++++++++++++++++++++++<br>
&gt; &gt;=C2=A0 1 file changed, 23 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c<br=
>
&gt; &gt; index 90cf1c755d..446b44d31c 100644<br>
&gt; &gt; --- a/hw/arm/aspeed_ast2600.c<br>
&gt; &gt; +++ b/hw/arm/aspeed_ast2600.c<br>
&gt; &gt; @@ -31,6 +31,8 @@ static const hwaddr aspeed_soc_ast2600_memmap[]=
 =3D {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [ASPEED_FMC]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x=
1E620000,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [ASPEED_SPI1]=C2=A0 =C2=A0 =C2=A0 =3D 0x1E630=
000,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [ASPEED_SPI2]=C2=A0 =C2=A0 =C2=A0 =3D 0x1E641=
000,<br>
&gt; &gt; +=C2=A0 =C2=A0 [ASPEED_EHCI1]=C2=A0 =C2=A0 =C2=A0=3D 0x1E6A1000,<=
br>
&gt; &gt; +=C2=A0 =C2=A0 [ASPEED_EHCI2]=C2=A0 =C2=A0 =C2=A0=3D 0x1E6A3000,<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [ASPEED_MII1]=C2=A0 =C2=A0 =C2=A0 =3D 0x1E650=
000,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [ASPEED_MII2]=C2=A0 =C2=A0 =C2=A0 =3D 0x1E650=
008,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [ASPEED_MII3]=C2=A0 =C2=A0 =C2=A0 =3D 0x1E650=
010,<br>
&gt; &gt; @@ -79,6 +81,8 @@ static const int aspeed_soc_ast2600_irqmap[] =
=3D {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [ASPEED_ADC]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 78=
,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [ASPEED_XDMA]=C2=A0 =C2=A0 =C2=A0 =3D 6,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [ASPEED_SDHCI]=C2=A0 =C2=A0 =C2=A0=3D 43,<br>
&gt; &gt; +=C2=A0 =C2=A0 [ASPEED_EHCI1]=C2=A0 =C2=A0 =C2=A0=3D 5,<br>
&gt; &gt; +=C2=A0 =C2=A0 [ASPEED_EHCI2]=C2=A0 =C2=A0 =C2=A0=3D 9,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [ASPEED_EMMC]=C2=A0 =C2=A0 =C2=A0 =3D 15,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [ASPEED_GPIO]=C2=A0 =C2=A0 =C2=A0 =3D 40,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [ASPEED_GPIO_1_8V] =3D 11,<br>
&gt; &gt; @@ -166,6 +170,11 @@ static void aspeed_soc_ast2600_init(Object *=
obj)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(s-&gt;spi[i]), typenam=
e);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; sc-&gt;ehcis_num; i++) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;ehc=
i[*]&quot;, OBJECT(&amp;s-&gt;ehci[i]),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(s-&gt;ehci[i]), TYPE_PLATF=
ORM_EHCI);<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 snprintf(typename, sizeof(typename), &quot;as=
peed.sdmc-%s&quot;, socname);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;sdmc&quot;, =
OBJECT(&amp;s-&gt;sdmc), sizeof(s-&gt;sdmc),<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typename);<br>
&gt; &gt; @@ -416,6 +425,19 @@ static void aspeed_soc_ast2600_realize(Devic=
eState<br>
&gt; &gt; *dev, Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;spi[i].ctrl-&gt;flash_window_base);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 /* EHCI */<br>
&gt; &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; sc-&gt;ehcis_num; i++) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp=
;s-&gt;ehci[i]), true, &quot;realized&quot;,<br>
&gt; &gt; &amp;err);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, =
err);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; <br>
&gt; Would it make sense to directly use error_fatal in the call to<br>
&gt; object_property_set_bool?<br>
&gt; That way you can avoid the additional code for propagating the error.<=
br>
&gt; <br>
<br>
The code matches the pattern used in the rest of the function.<br>
Given that, I would be hesitant to change it for this one case.<br></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I see. There=
 are some uses of error_fatal already in the function, but improving that m=
ight be something for another patch I guess.</div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; <br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;=
s-&gt;ehci[i]), 0,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 sc-&gt;memmap[ASPEED_EHCI1 + i]);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&a=
mp;s-&gt;ehci[i]), 0,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed_soc_get_irq(s, ASPEED_EHCI1 + i));=
<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* SDMC - SDRAM Memory Controller */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&gt;sd=
mc), true, &quot;realized&quot;, &amp;err);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (err) {<br>
&gt; &gt; @@ -534,6 +556,7 @@ static void aspeed_soc_ast2600_class_init(Obj=
ectClass<br>
&gt; &gt; *oc, void *data)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 sc-&gt;silicon_rev=C2=A0 =3D AST2600_A0_SILIC=
ON_REV;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 sc-&gt;sram_size=C2=A0 =C2=A0 =3D 0x10000;<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 sc-&gt;spis_num=C2=A0 =C2=A0 =C2=A0=3D 2;<br>
&gt; &gt; +=C2=A0 =C2=A0 sc-&gt;ehcis_num=C2=A0 =C2=A0 =3D 2;<br>
&gt; &gt;<br>
&gt; <br>
&gt; Since this field is only set once here, does it need to be part of the=
<br>
&gt; class state?<br>
&gt; <br>
<br>
The same applies to spis_num, wdts_num, and macs_num.<br>
AspeedSoCClass is defined for all ast2X00 SoCs, and<br>
the same mechanism is used for all of them. I don&#39;t see<br>
the benefit of deviating from a common mechanism.<br></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Ignore my comment here, i =
did not see this patch was part of previous work done for the other AST soc=
s as well.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-by: =
Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenb=
ank@gmail.com</a>&gt;</div><div dir=3D"auto"><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
<br>
Guenter<br>
</blockquote></div></div></div>

--00000000000044ee1e059e03bacf--

