Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86B2C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621DB2077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5sesb5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621DB2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icXOz-0001ix-8Z
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 11:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1icXFW-000566-Rq
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1icXFV-00047r-5H
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:11:34 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1icXFU-00046f-A2; Wed, 04 Dec 2019 11:11:32 -0500
Received: by mail-oi1-x242.google.com with SMTP id i1so3261594oie.8;
 Wed, 04 Dec 2019 08:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=5t/1v78hE6NyJ3o2GpUTU1gSeku0E4UCR1wVphzXSp8=;
 b=f5sesb5YnQ/z44M/W65klN3FzjaV2vupsX7HXvjF42WsFP2WRlxPtBurWsKdCXz5gQ
 VUZXTfBX4GTKlJT2h7zDnng7XrbfCXp1euLhsD02j4nMongOw4oGOEp8hG+Jed4iszW9
 6wkclceNxBackjQq4kw/0FQ5UUox7MpnPWWevcRan+xdrRXA49FzHqXTDOQzD294aZa3
 +62A1m3HX32X3M11aU9G0WMal4nD06/lDh2+V5MFCcOx+PBm2thi3Gq8+6pqOF7yu13+
 V0HN704Muph5q2grlhjLvJhCg6pWC9M6yd6l4aza11FhVZm4pxbWjkNLX4mLRTi7fdF6
 jcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=5t/1v78hE6NyJ3o2GpUTU1gSeku0E4UCR1wVphzXSp8=;
 b=N7bVXmk6+WJw9okT6sz+vNfQaBZbAbO/8/BKTEtXjpeTxhFmtOGUQzD4rF+cxwL2eA
 Vku7c/y4agwCejTwWR4YJLcKUZmnujZU2n7HKIviE9UZ8HnV7VGYq+t+3b7KVm7avXAj
 p9vTMIrg3NCQTonHUaCzWL5j1q3LCKLdf2z38YviXH0eKCGpXXzvJgN0CcbwWRWuw4fM
 fMXo8xDrv1VpN3ziVVE8PH+htLGDKv81dJjRGNK+LiBaxahajJ361LkdgUqBwcREgaJg
 6kROSC8UCPaMrGQ1F6H2muOBiyQx7LWbG5rd8nwvrgeGkA7ORx9FgAZXqDz6vrtgGB1Q
 rsPw==
X-Gm-Message-State: APjAAAUuv+ThB9HlzpYP/joMM/xVapnP/fl3/sOOBREItgveXYeuy3g2
 teSnN2lKL2tA7OPiUm/HJ9+FHVSh1cM3aoss1GI=
X-Google-Smtp-Source: APXvYqxUZ+jAdcGPjbecPw/g/WVBwmdylJiyeCZdznfJTk6fYWitEvneN5+muUyYDSY3GCoYDgamylautUTMMnrXFVw=
X-Received: by 2002:aca:bd85:: with SMTP id n127mr3267748oif.136.1575475889777; 
 Wed, 04 Dec 2019 08:11:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Wed, 4 Dec 2019 08:11:29 -0800 (PST)
In-Reply-To: <20191202210947.3603-5-nieklinnenbank@gmail.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-5-nieklinnenbank@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 4 Dec 2019 17:11:29 +0100
Message-ID: <CAL1e-=gVMXsWKAdo8c8QtjAYeK6p0AyTmi_a-sFHL2x4wGq6Vg@mail.gmail.com>
Subject: Re: [PATCH 04/10] arm: allwinner-h3: add USB host controller
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c332150598e3106d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "b.galvani@gmail.com" <b.galvani@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c332150598e3106d
Content-Type: text/plain; charset="UTF-8"

On Monday, December 2, 2019, Niek Linnenbank <nieklinnenbank@gmail.com>
wrote:

> The Allwinner H3 System on Chip contains multiple USB 2.0 bus
> connections which provide software access using the Enhanced
> Host Controller Interface (EHCI) and Open Host Controller
> Interface (OHCI) interfaces. This commit adds support for
> both interfaces in the Allwinner H3 System on Chip.
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---


Niek, hi!

I would like to clarify a detail here:

The spec of the SoC enumerates (in 8.5.2.4. USB Host Register List) a
number of registers for reading various USB-related states, but also for
setting some of USB features.

Does this series cover these registers, and interaction with them? If yes,
how and where? If not, do you think it is not necessary at all? Or perhaps
that it is a non-crucial limitation of this series?

Thanks in advance, and congrats for your, it seems, first submission!

Aleksandar


 hw/arm/allwinner-h3.c    | 20 ++++++++++++++++++++
>  hw/usb/hcd-ehci-sysbus.c | 17 +++++++++++++++++
>  hw/usb/hcd-ehci.h        |  1 +
>  3 files changed, 38 insertions(+)
>
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index 5566e979ec..afeb49c0ac 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -26,6 +26,7 @@
>  #include "hw/sysbus.h"
>  #include "hw/arm/allwinner-h3.h"
>  #include "hw/misc/unimp.h"
> +#include "hw/usb/hcd-ehci.h"
>  #include "sysemu/sysemu.h"
>
>  static void aw_h3_init(Object *obj)
> @@ -183,6 +184,25 @@ static void aw_h3_realize(DeviceState *dev, Error
> **errp)
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, AW_H3_CCU_BASE);
>
> +    /* Universal Serial Bus */
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,
> +                         s->irq[AW_H3_GIC_SPI_EHCI0]);
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI1_BASE,
> +                         s->irq[AW_H3_GIC_SPI_EHCI1]);
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI2_BASE,
> +                         s->irq[AW_H3_GIC_SPI_EHCI2]);
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI3_BASE,
> +                         s->irq[AW_H3_GIC_SPI_EHCI3]);
> +
> +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI0_BASE,
> +                         s->irq[AW_H3_GIC_SPI_OHCI0]);
> +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI1_BASE,
> +                         s->irq[AW_H3_GIC_SPI_OHCI1]);
> +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI2_BASE,
> +                         s->irq[AW_H3_GIC_SPI_OHCI2]);
> +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI3_BASE,
> +                         s->irq[AW_H3_GIC_SPI_OHCI3]);
> +
>      /* UART */
>      if (serial_hd(0)) {
>          serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2,
> diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
> index 020211fd10..174c3446ef 100644
> --- a/hw/usb/hcd-ehci-sysbus.c
> +++ b/hw/usb/hcd-ehci-sysbus.c
> @@ -145,6 +145,22 @@ static const TypeInfo ehci_exynos4210_type_info = {
>      .class_init    = ehci_exynos4210_class_init,
>  };
>
> +static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)
> +{
> +    SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    sec->capsbase = 0x0;
> +    sec->opregbase = 0x10;
> +    set_bit(DEVICE_CATEGORY_USB, dc->categories);
> +}
> +
> +static const TypeInfo ehci_aw_h3_type_info = {
> +    .name          = TYPE_AW_H3_EHCI,
> +    .parent        = TYPE_SYS_BUS_EHCI,
> +    .class_init    = ehci_aw_h3_class_init,
> +};
> +
>  static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
>  {
>      SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
> @@ -267,6 +283,7 @@ static void ehci_sysbus_register_types(void)
>      type_register_static(&ehci_platform_type_info);
>      type_register_static(&ehci_xlnx_type_info);
>      type_register_static(&ehci_exynos4210_type_info);
> +    type_register_static(&ehci_aw_h3_type_info);
>      type_register_static(&ehci_tegra2_type_info);
>      type_register_static(&ehci_ppc4xx_type_info);
>      type_register_static(&ehci_fusbh200_type_info);
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 0298238f0b..edb59311c4 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -342,6 +342,7 @@ typedef struct EHCIPCIState {
>  #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
>  #define TYPE_PLATFORM_EHCI "platform-ehci-usb"
>  #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
> +#define TYPE_AW_H3_EHCI "aw-h3-ehci-usb"
>  #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
>  #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
>  #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
> --
> 2.17.1
>
>
>

--000000000000c332150598e3106d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, December 2, 2019, Niek Linnenbank &lt;<a href=3D"mailto:=
nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">The Allwinner H3 System on Chip contains multiple =
USB 2.0 bus<br>
connections which provide software access using the Enhanced<br>
Host Controller Interface (EHCI) and Open Host Controller<br>
Interface (OHCI) interfaces. This commit adds support for<br>
both interfaces in the Allwinner H3 System on Chip.<br>
<br>
Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.c=
om">nieklinnenbank@gmail.com</a>&gt;<br>
---</blockquote><div><br></div><div>Niek, hi!</div><div><br></div><div>I wo=
uld like to clarify a detail here:</div><div><br></div><div>The spec of the=
 SoC enumerates (in 8.5.2.4. USB Host Register List) a number of registers =
for reading various USB-related states, but also for setting some of USB fe=
atures.</div><div>=C2=A0</div><div>Does this series cover these registers, =
and interaction with them? If yes, how and where? If not, do you think it i=
s not necessary at all? Or perhaps that it is a non-crucial limitation of t=
his series?</div><div><br></div><div>Thanks in advance, and congrats for yo=
ur, it seems, first submission!</div><div><br></div><div>Aleksandar</div><d=
iv><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 | 20 ++++++++++++++++++++<br>
=C2=A0hw/usb/hcd-ehci-sysbus.c | 17 +++++++++++++++++<br>
=C2=A0hw/usb/hcd-ehci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A03 files changed, 38 insertions(+)<br>
<br>
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
index 5566e979ec..afeb49c0ac 100644<br>
--- a/hw/arm/allwinner-h3.c<br>
+++ b/hw/arm/allwinner-h3.c<br>
@@ -26,6 +26,7 @@<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;hw/arm/allwinner-h3.h&quot;<br>
=C2=A0#include &quot;hw/misc/unimp.h&quot;<br>
+#include &quot;hw/usb/hcd-ehci.h&quot;<br>
=C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
<br>
=C2=A0static void aw_h3_init(Object *obj)<br>
@@ -183,6 +184,25 @@ static void aw_h3_realize(DeviceState *dev, Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_<wbr>DEVICE(&amp;s-&gt;ccu), 0,=
 AW_H3_CCU_BASE);<br>
<br>
+=C2=A0 =C2=A0 /* Universal Serial Bus */<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_<wbr>H3_EHCI, AW_H3_EHCI0_BASE,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_EHCI0]);<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_<wbr>H3_EHCI, AW_H3_EHCI1_BASE,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_EHCI1]);<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_<wbr>H3_EHCI, AW_H3_EHCI2_BASE,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_EHCI2]);<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_<wbr>H3_EHCI, AW_H3_EHCI3_BASE,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_EHCI3]);<br>
+<br>
+=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-<wbr>ohci&quot;, AW_H3_OHC=
I0_BASE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_OHCI0]);<br>
+=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-<wbr>ohci&quot;, AW_H3_OHC=
I1_BASE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_OHCI1]);<br>
+=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-<wbr>ohci&quot;, AW_H3_OHC=
I2_BASE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_OHCI2]);<br>
+=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-<wbr>ohci&quot;, AW_H3_OHC=
I3_BASE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_OHCI3]);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* UART */<br>
=C2=A0 =C2=A0 =C2=A0if (serial_hd(0)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial_mm_init(get_system_<wbr>memory(), =
AW_H3_UART0_REG_BASE, 2,<br>
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c<br>
index 020211fd10..174c3446ef 100644<br>
--- a/hw/usb/hcd-ehci-sysbus.c<br>
+++ b/hw/usb/hcd-ehci-sysbus.c<br>
@@ -145,6 +145,22 @@ static const TypeInfo ehci_exynos4210_type_info =3D {<=
br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D ehci_exynos4210_class_init=
,<br>
=C2=A0};<br>
<br>
+static void ehci_aw_h3_class_init(<wbr>ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 sec-&gt;capsbase =3D 0x0;<br>
+=C2=A0 =C2=A0 sec-&gt;opregbase =3D 0x10;<br>
+=C2=A0 =C2=A0 set_bit(DEVICE_CATEGORY_USB, dc-&gt;categories);<br>
+}<br>
+<br>
+static const TypeInfo ehci_aw_h3_type_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_H3_EHCI,=
<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_EHCI,<br=
>
+=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D ehci_aw_h3_class_init,<br>
+};<br>
+<br>
=C2=A0static void ehci_tegra2_class_init(<wbr>ObjectClass *oc, void *data)<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);<br>
@@ -267,6 +283,7 @@ static void ehci_sysbus_register_types(<wbr>void)<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_<wbr>platform_type_info)=
;<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_<wbr>xlnx_type_info);<br=
>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_<wbr>exynos4210_type_inf=
o);<br>
+=C2=A0 =C2=A0 type_register_static(&amp;ehci_aw_<wbr>h3_type_info);<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_<wbr>tegra2_type_info);<=
br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_<wbr>ppc4xx_type_info);<=
br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_<wbr>fusbh200_type_info)=
;<br>
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h<br>
index 0298238f0b..edb59311c4 100644<br>
--- a/hw/usb/hcd-ehci.h<br>
+++ b/hw/usb/hcd-ehci.h<br>
@@ -342,6 +342,7 @@ typedef struct EHCIPCIState {<br>
=C2=A0#define TYPE_SYS_BUS_EHCI &quot;sysbus-ehci-usb&quot;<br>
=C2=A0#define TYPE_PLATFORM_EHCI &quot;platform-ehci-usb&quot;<br>
=C2=A0#define TYPE_EXYNOS4210_EHCI &quot;exynos4210-ehci-usb&quot;<br>
+#define TYPE_AW_H3_EHCI &quot;aw-h3-ehci-usb&quot;<br>
=C2=A0#define TYPE_TEGRA2_EHCI &quot;tegra2-ehci-usb&quot;<br>
=C2=A0#define TYPE_PPC4xx_EHCI &quot;ppc4xx-ehci-usb&quot;<br>
=C2=A0#define TYPE_FUSBH200_EHCI &quot;fusbh200-ehci-usb&quot;<br>
-- <br>
2.17.1<br>
<br>
<br>
</blockquote>

--000000000000c332150598e3106d--

