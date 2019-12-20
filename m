Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4348BC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C92206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwBpUab8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C92206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiPZ7-0002bl-4K
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 16:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iiPYM-0002AW-CC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iiPYJ-0003pO-Lg
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:11:18 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:34910)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iiPYJ-0003kA-Ec; Fri, 20 Dec 2019 16:11:15 -0500
Received: by mail-io1-xd44.google.com with SMTP id v18so10792979iol.2;
 Fri, 20 Dec 2019 13:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VvkgRQ4HhizmbLmgoQ+HomXQu31tz6OEWac2k/Z2GhI=;
 b=GwBpUab8Bvm53uyrZiKJk6wxuBXApq1m0twa1ILg2vcYXx6/q9lAPhtmUk1f6/2Dkk
 jZISrzG4WXJcsdVRfxu7rJT6jw61Gb6DV/N7YCXye753EDTE2PgPuNBQY9yLdwDVCalE
 piT7gCA5LxtWzHO55Fs6Vvyp/U6NfRr9towqGfGqQA/6HOgKY7wOqLUht08aqMoJZRkO
 fUj/H67FJvF6g2MPAF2J+lotnzproXZ6UBZNRX2GSAYUrHxXv0PDpy0PoZhAB/dH+gM4
 +u7iPjN3ap42WApqaJbuoCvUuYfuwl3oT1/h5wmHx4VJ6YfR4d7mi8NUplUkyiuz4/Pb
 GqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VvkgRQ4HhizmbLmgoQ+HomXQu31tz6OEWac2k/Z2GhI=;
 b=UiVi49+WbX1Hni2Jubh+UATVMgWFFgUOtz52UnRuGwq7Fg+nBEeHlykQdnTI4MJDha
 Ge3M//UrEwmT7WQEkVKLBAOLt5SHj9AIxRp9n+h/XgPzAJqssC8GU5eLk01RIiFyMhXG
 HQox6YRT5wjYqX3KQP7oJyvYoCBlqaujyHJc4xCix2lUnrCOtyiFzOGOSYJ+jM4Dn9o4
 DwhfW5N6lB2oZqkV7QUThsxDrY+x/6ExpH+Bqu+tP+O1PU7FBcZNKXd5tnAJ6q5gceAj
 XAvtlY+V1n8s7E6QhIojrQMl2lBpidv6H1LVNU+3wgY0oBYK7TuZiTHBqgCXCt0Pk6Jg
 GyXA==
X-Gm-Message-State: APjAAAUftwM1tAnr7NuQIA9pRwe4VYEDWozEbalq2ln1SjXLq/lCd0PL
 A1rrY8V9PmZtPi1iIZQsvF8XRizBDkphgyctisg=
X-Google-Smtp-Source: APXvYqyKR9mUFkbbOsIGGOs6h2zziu44MclJqjiqYpshiKTyVc6fYbjnkArddSUDIKn0TivfMaHXzhdhs7ElGLaY5Nc=
X-Received: by 2002:a6b:d912:: with SMTP id r18mr5454210ioc.306.1576876271643; 
 Fri, 20 Dec 2019 13:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20191219185127.24388-1-f4bug@amsat.org>
 <20191219185127.24388-12-f4bug@amsat.org>
In-Reply-To: <20191219185127.24388-12-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 20 Dec 2019 22:11:00 +0100
Message-ID: <CAPan3WqvSFbuS8FwvVTby-gsQ1pmxJf=PUET39Ftu0oiN4GV1w@mail.gmail.com>
Subject: Re: [RFC PATCH 11/13] hw/timer/allwinner: Introduce
 TYPE_AW_COMMON_PIT abstract device
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000006aff2059a291ebc"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000006aff2059a291ebc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Thu, Dec 19, 2019 at 7:51 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Extract the common code from the TYPE_AW_A10_PIT device into a new
> abstract device: TYPE_AW_COMMON_PIT, then use it as parent, so we
> inherit the same functionalities.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> At this point, the only fields we can modify are the timer_count
> and the region_size. Not enough to implement the H3 timer, since
> we need to move the WDOG register. Still some progress, so Niek
> can continue ;)
> ---
>  include/hw/timer/allwinner-a10-pit.h |  1 +
>  hw/timer/allwinner-a10-pit.c         | 50 +++++++++++++++++++++++-----
>  2 files changed, 43 insertions(+), 8 deletions(-)
>
> diff --git a/include/hw/timer/allwinner-a10-pit.h
> b/include/hw/timer/allwinner-a10-pit.h
> index 9e28c6697a..8453a62706 100644
> --- a/include/hw/timer/allwinner-a10-pit.h
> +++ b/include/hw/timer/allwinner-a10-pit.h
> @@ -4,6 +4,7 @@
>  #include "hw/ptimer.h"
>  #include "hw/sysbus.h"
>
> +#define TYPE_AW_COMMON_PIT "allwinner-timer-controller"
>  #define TYPE_AW_A10_PIT "allwinner-A10-timer"
>

So for the Allwinner H3, that means we'll need another TYPE_AW_H3_PIT
definition?


>
>  #define AW_PIT_TIMER_MAX        6
> diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
> index f2ac271e80..ad409b96a1 100644
> --- a/hw/timer/allwinner-a10-pit.c
> +++ b/hw/timer/allwinner-a10-pit.c
>

Perhaps we can rename the hw/timer/allwinner-a10-pit.c to a generic name,
for example hw/timer/allwinner-pit.c ?


> @@ -54,6 +54,20 @@
>  #define AW_A10_PIT(obj) \
>      OBJECT_CHECK(AllwinnerTmrCtrlState, (obj), TYPE_AW_A10_PIT)
>
> +typedef struct AllwinnerTmrCtrlClass {
> +    /*< private >*/
> +    SysBusDeviceClass parent_class;
> +    /*< public >*/
> +
> +    size_t timer_count;
> +    size_t region_size;
> +} AllwinnerTmrCtrlClass;
> +
> +#define AW_TIMER_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(AllwinnerTmrCtrlClass, (klass),
> TYPE_AW_COMMON_PIT)
> +#define AW_TIMER_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(AllwinnerTmrCtrlClass, (obj), TYPE_AW_COMMON_PIT)
> +
>  static void a10_pit_update_irq(AllwinnerTmrCtrlState *s)
>  {
>      int i;
> @@ -303,19 +317,20 @@ static void a10_pit_timer_cb(void *opaque)
>      }
>  }
>
> -static void a10_pit_init(Object *obj)
> +static void aw_pit_instance_init(Object *obj)
>  {
>      AllwinnerTmrCtrlState *s =3D AW_A10_PIT(obj);
> +    AllwinnerTmrCtrlClass *c =3D AW_TIMER_GET_CLASS(s);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>      uint8_t i;
>
> -    s->timer_count =3D AW_A10_PIT_TIMER_NR;
> +    s->timer_count =3D c->timer_count;
>
>      for (i =3D 0; i < s->timer_count; i++) {
>          sysbus_init_irq(sbd, &s->timer[i].irq);
>      }
>      memory_region_init_io(&s->iomem, OBJECT(s), &a10_pit_ops, s,
>

I am curious how to support the different WDOG0 registers for the Allwinner
H3 while keeping
the A10 functionality also working :-) Will you give the TYPE_AW_H3_PIT
its own MemoryRegionOps with read/write?


> -                          TYPE_AW_A10_PIT, 0x400);
> +                          TYPE_AW_A10_PIT, c->region_size);
>      sysbus_init_mmio(sbd, &s->iomem);
>
>      for (i =3D 0; i < s->timer_count; i++) {
> @@ -328,26 +343,45 @@ static void a10_pit_init(Object *obj)
>      }
>  }
>
> -static void a10_pit_class_init(ObjectClass *klass, void *data)
> +static void aw_timer_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->reset =3D a10_pit_reset;
>      dc->props =3D a10_pit_properties;
> -    dc->desc =3D "allwinner a10 timer";
> +    dc->desc =3D "Allwinner Timer Controller";
>      dc->vmsd =3D &vmstate_a10_pit;
>  }
>
> +static const TypeInfo allwinner_pit_info =3D {
> +    .name =3D TYPE_AW_COMMON_PIT,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_init =3D aw_pit_instance_init,
> +    .instance_size =3D sizeof(AllwinnerTmrCtrlState),
> +    .class_init =3D aw_timer_class_init,
> +    .class_size =3D sizeof(AllwinnerTmrCtrlClass),
> +    .abstract   =3D true,
> +};
> +
> +static void a10_pit_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    AllwinnerTmrCtrlClass *atc =3D AW_TIMER_CLASS(klass);
> +
> +    dc->desc =3D "Allwinner A10 Timer Controller";
> +    atc->timer_count =3D AW_A10_PIT_TIMER_NR;
> +    atc->region_size =3D 0x400;
> +}
> +
>  static const TypeInfo a10_pit_info =3D {
>      .name =3D TYPE_AW_A10_PIT,
> -    .parent =3D TYPE_SYS_BUS_DEVICE,
> -    .instance_size =3D sizeof(AllwinnerTmrCtrlState),
> -    .instance_init =3D a10_pit_init,
> +    .parent =3D TYPE_AW_COMMON_PIT,
>      .class_init =3D a10_pit_class_init,
>  };
>
>  static void a10_register_types(void)
>  {
> +    type_register_static(&allwinner_pit_info);
>      type_register_static(&a10_pit_info);
>  }
>
> --
> 2.21.0
>
>

--=20
Niek Linnenbank

--00000000000006aff2059a291ebc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,<br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 19, 2019 at 7:51 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Extract the common code from the TYPE_AW_A10_PIT device into a new<br>
abstract device: TYPE_AW_COMMON_PIT, then use it as parent, so we<br>
inherit the same functionalities.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
At this point, the only fields we can modify are the timer_count<br>
and the region_size. Not enough to implement the H3 timer, since<br>
we need to move the WDOG register. Still some progress, so Niek<br>
can continue ;)<br>
---<br>
=C2=A0include/hw/timer/allwinner-a10-pit.h |=C2=A0 1 +<br>
=C2=A0hw/timer/allwinner-a10-pit.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 50 ++=
+++++++++++++++++++++-----<br>
=C2=A02 files changed, 43 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwin=
ner-a10-pit.h<br>
index 9e28c6697a..8453a62706 100644<br>
--- a/include/hw/timer/allwinner-a10-pit.h<br>
+++ b/include/hw/timer/allwinner-a10-pit.h<br>
@@ -4,6 +4,7 @@<br>
=C2=A0#include &quot;hw/ptimer.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
<br>
+#define TYPE_AW_COMMON_PIT &quot;allwinner-timer-controller&quot;<br>
=C2=A0#define TYPE_AW_A10_PIT &quot;allwinner-A10-timer&quot;<br></blockquo=
te><div><br></div><div>So for the Allwinner H3, that means we&#39;ll need a=
nother TYPE_AW_H3_PIT definition?<br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0#define AW_PIT_TIMER_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 6<br>
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c<br=
>
index f2ac271e80..ad409b96a1 100644<br>
--- a/hw/timer/allwinner-a10-pit.c<br>
+++ b/hw/timer/allwinner-a10-pit.c<br></blockquote><div><br></div><div>Perh=
aps we can rename the hw/timer/allwinner-a10-pit.c to a generic name, for e=
xample hw/timer/allwinner-pit.c ?<br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
@@ -54,6 +54,20 @@<br>
=C2=A0#define AW_A10_PIT(obj) \<br>
=C2=A0 =C2=A0 =C2=A0OBJECT_CHECK(AllwinnerTmrCtrlState, (obj), TYPE_AW_A10_=
PIT)<br>
<br>
+typedef struct AllwinnerTmrCtrlClass {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 SysBusDeviceClass parent_class;<br>
+=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
+<br>
+=C2=A0 =C2=A0 size_t timer_count;<br>
+=C2=A0 =C2=A0 size_t region_size;<br>
+} AllwinnerTmrCtrlClass;<br>
+<br>
+#define AW_TIMER_CLASS(klass) \<br>
+=C2=A0 =C2=A0 =C2=A0OBJECT_CLASS_CHECK(AllwinnerTmrCtrlClass, (klass), TYP=
E_AW_COMMON_PIT)<br>
+#define AW_TIMER_GET_CLASS(obj) \<br>
+=C2=A0 =C2=A0 =C2=A0OBJECT_GET_CLASS(AllwinnerTmrCtrlClass, (obj), TYPE_AW=
_COMMON_PIT)<br>
+<br>
=C2=A0static void a10_pit_update_irq(AllwinnerTmrCtrlState *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
@@ -303,19 +317,20 @@ static void a10_pit_timer_cb(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void a10_pit_init(Object *obj)<br>
+static void aw_pit_instance_init(Object *obj)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0AllwinnerTmrCtrlState *s =3D AW_A10_PIT(obj);<br>
+=C2=A0 =C2=A0 AllwinnerTmrCtrlClass *c =3D AW_TIMER_GET_CLASS(s);<br>
=C2=A0 =C2=A0 =C2=A0SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);<br>
=C2=A0 =C2=A0 =C2=A0uint8_t i;<br>
<br>
-=C2=A0 =C2=A0 s-&gt;timer_count =3D AW_A10_PIT_TIMER_NR;<br>
+=C2=A0 =C2=A0 s-&gt;timer_count =3D c-&gt;timer_count;<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; s-&gt;timer_count; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_irq(sbd, &amp;s-&gt;timer[i].=
irq);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_io(&amp;s-&gt;iomem, OBJECT(s), &amp=
;a10_pit_ops, s,<br></blockquote><div><br></div><div>I am curious how to su=
pport the different WDOG0 registers for the Allwinner H3 while keeping</div=
><div>the A10 functionality also working :-) Will you give the TYPE_AW_H3_P=
IT=C2=A0 its own MemoryRegionOps with read/write?<br></div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TYPE_AW_A10_PIT, 0x400);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TYPE_AW_A10_PIT, c-&gt;region_size);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_init_mmio(sbd, &amp;s-&gt;iomem);<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; s-&gt;timer_count; i++) {<br>
@@ -328,26 +343,45 @@ static void a10_pit_init(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void a10_pit_class_init(ObjectClass *klass, void *data)<br>
+static void aw_timer_class_init(ObjectClass *klass, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;reset =3D a10_pit_reset;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;props =3D a10_pit_properties;<br>
-=C2=A0 =C2=A0 dc-&gt;desc =3D &quot;allwinner a10 timer&quot;;<br>
+=C2=A0 =C2=A0 dc-&gt;desc =3D &quot;Allwinner Timer Controller&quot;;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;vmsd =3D &amp;vmstate_a10_pit;<br>
=C2=A0}<br>
<br>
+static const TypeInfo allwinner_pit_info =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_AW_COMMON_PIT,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_SYS_BUS_DEVICE,<br>
+=C2=A0 =C2=A0 .instance_init =3D aw_pit_instance_init,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(AllwinnerTmrCtrlState),<br>
+=C2=A0 =C2=A0 .class_init =3D aw_timer_class_init,<br>
+=C2=A0 =C2=A0 .class_size =3D sizeof(AllwinnerTmrCtrlClass),<br>
+=C2=A0 =C2=A0 .abstract=C2=A0 =C2=A0=3D true,<br>
+};<br>
+<br>
+static void a10_pit_class_init(ObjectClass *klass, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+=C2=A0 =C2=A0 AllwinnerTmrCtrlClass *atc =3D AW_TIMER_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 dc-&gt;desc =3D &quot;Allwinner A10 Timer Controller&quot;;<=
br>
+=C2=A0 =C2=A0 atc-&gt;timer_count =3D AW_A10_PIT_TIMER_NR;<br>
+=C2=A0 =C2=A0 atc-&gt;region_size =3D 0x400;<br>
+}<br>
+<br>
=C2=A0static const TypeInfo a10_pit_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name =3D TYPE_AW_A10_PIT,<br>
-=C2=A0 =C2=A0 .parent =3D TYPE_SYS_BUS_DEVICE,<br>
-=C2=A0 =C2=A0 .instance_size =3D sizeof(AllwinnerTmrCtrlState),<br>
-=C2=A0 =C2=A0 .instance_init =3D a10_pit_init,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_AW_COMMON_PIT,<br>
=C2=A0 =C2=A0 =C2=A0.class_init =3D a10_pit_class_init,<br>
=C2=A0};<br>
<br>
=C2=A0static void a10_register_types(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;allwinner_pit_info);<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;a10_pit_info);<br>
=C2=A0}<br>
<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000006aff2059a291ebc--

