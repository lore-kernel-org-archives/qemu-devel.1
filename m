Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966E7C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EFA72074F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJxWUOvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFA72074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQcSg-0006hQ-F7
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 15:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQcQs-00051Y-Vc
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQcQr-0000OO-Nn
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:50:18 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:33333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jQcQr-0000Ls-8w
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:50:17 -0400
Received: by mail-il1-x143.google.com with SMTP id q10so9783578ile.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ebQSPI+9jbBJQaKBthSnLcxsF/z8674ck83w99sCXC0=;
 b=VJxWUOvH2AEAc/BSsejUA3/Pwk5+3E1UqzrGCI/CdUuPHOfr+HLcLMXGmx5qyqMjx6
 o+28YTZpDR5tPrIuQsd2++uzRqu56kQ8zlByoO7K9Ebd5Gw+imtcH45B0rKYkB7/pJmU
 2vptO+UUZXNuFfcmmCsarkKrirkgPeFCn76yhIUd3wGa+e0F7JEQO3MAfNpqO2DuSHyj
 70L7PRNMp+LpWEEegabmolfMQMmDTTCqgZWsbjk5zDbhJt1+hZBYlZCvj7rfXW0qTISP
 Iyr2ypGnvMu3PEyoMh7rQZjht5qwOKWQOnu0Mo0wpW4DZ27vUmsWwyEA0iQwlqo0WyX9
 TUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ebQSPI+9jbBJQaKBthSnLcxsF/z8674ck83w99sCXC0=;
 b=Pqygbj9CGUeKcY/hEdyE0i5l/xysNXHrJXGcvjqzUjRJuHGRVs0i28cMQ/GrRzdnAa
 ECXewvLeYX/E9laNJJ0ts55BhgN1I20O6dvZdot7Do8Jis8Iy9xs3AHg74W7AeUL/YjZ
 TwSndWKLDXAOhk6RISBnbwCmXvh0/P5lrYklXa6vOG5jN09VxPQhWjeYEeNYSfvLgBoZ
 ukTg+DUWoVTwWAEkdRLdUSZwkyFBGgJWcWjm5+oDV58MQhPNWV2mhRh463U9zCKzUI+m
 gSBcj4wcrQl3d9zXawaXfyS9lEZcumVYpZGNIatCfsqbuQhNlA0MPJ4iJGKa2/miLNXA
 WLAQ==
X-Gm-Message-State: AGi0Pua6yLXmoBd5EYsijnRXCb/KPnP+xjOGFowAftNsWSMCLZ1m9ZLa
 VrD2Tm792rAu9P7soN0B1IEnRYJiNYsbL9Qd4Xs=
X-Google-Smtp-Source: APiQypJmtwDoj879gZ+wpKbZgFo8qODq0FzdzOWbihgQLp/dAHjWgMivWmqdhiiylQtWmdeAhYcHYbYxJhXFwhrVUJc=
X-Received: by 2002:a92:96c6:: with SMTP id
 g189mr17099546ilh.276.1587412215930; 
 Mon, 20 Apr 2020 12:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200329001705.15966-1-pauldzim@gmail.com>
 <20200329001705.15966-5-pauldzim@gmail.com>
 <c61f354f-1768-8a53-e4e8-c8af69007e3f@amsat.org>
In-Reply-To: <c61f354f-1768-8a53-e4e8-c8af69007e3f@amsat.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Mon, 20 Apr 2020 12:49:49 -0700
Message-ID: <CADBGO79CS4qwx6WYi-M-9pNYRj2xmX-YBmQbSbF120anYNQcTg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dwc-hsotg USB host controller emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000003e26e905a3be3509"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=pauldzim@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003e26e905a3be3509
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Mon, Apr 20, 2020 at 12:16 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi Paul,
>
> On 3/29/20 1:17 AM, Paul Zimmerman wrote:
> > Add the dwc-hsotg (dwc2) USB host controller emulation code.
> > Based on hw/usb/hcd-ehci.c and hw/usb/hcd-ohci.c.
> >
> > Note that to use this with the dwc-otg driver in the Raspbian
> > kernel, you must pass the option "dwc_otg.fiq_fsm_enable=3D0" on
> > the kernel command line.
> >
> > Emulation of slave mode and of descriptor-DMA mode has not been
> > implemented yet. These modes are seldom used.
> >
> > I have used some on-line sources of information while developing
> > this emulation, including:
> >
> > http://www.capital-micro.com/PDF/CME-M7_Family_User_Guide_EN.pdf
> > has a pretty complete description of the controller starting on
> > page 370.
> >
> >
> https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/tree/docs/DataShee=
ts/RT3050_5x_V2.0_081408_0902.pdf
> > has a description of the controller registers starting on page
> > 130.
> >
> > Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
> > ---
> >  hw/usb/hcd-dwc2.c   | 1301 +++++++++++++++++++++++++++++++++++++++++++
> >  hw/usb/trace-events |   47 ++
> >  2 files changed, 1348 insertions(+)
> >  create mode 100644 hw/usb/hcd-dwc2.c
> >
> > diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
> [...]
> > +static void dwc2_init(DWC2State *s, DeviceState *dev)
> > +{
> > +    s->usb_frame_time =3D NANOSECONDS_PER_SECOND / 1000;          /*
> 1000000 */
> > +    if (NANOSECONDS_PER_SECOND >=3D USB_HZ_FS) {
> > +        s->usb_bit_time =3D NANOSECONDS_PER_SECOND / USB_HZ_FS;   /* 8=
3.3
> */
> > +    } else {
> > +        s->usb_bit_time =3D 1;
> > +    }
> > +
> > +    s->fi =3D 11999;
>
> What is this magic number?
>

This is the USB frame interval, in bit times I believe. It's actually
12000-1. Not sure of the reason for the -1, I lifted this code directly
from the hcd-ohci driver and it seems to work ;) The hcd-ohci driver
actually has this value in hex (0x2edf), I changed it to decimal because
I thought it was clearer. I can make a #define for this if you think
that would be better.

> +
> > +    memory_region_init(&s->mem, OBJECT(dev), "dwc2", DWC2_MMIO_SIZE);
> > +    memory_region_init_io(&s->mem_glbreg, OBJECT(dev),
> &dwc2_mmio_glbreg_ops, s,
> > +                          "global", 0x70);
> > +    memory_region_init_io(&s->mem_fszreg, OBJECT(dev),
> &dwc2_mmio_fszreg_ops, s,
> > +                          "hptxfsiz", 0x4);
> > +    memory_region_init_io(&s->mem_hreg0, OBJECT(dev),
> &dwc2_mmio_hreg0_ops, s,
> > +                          "host", 0x44);
> > +    memory_region_init_io(&s->mem_hreg1, OBJECT(dev),
> &dwc2_mmio_hreg1_ops, s,
> > +                          "host channels", 0x20 * NB_CHAN);
> > +    memory_region_init_io(&s->mem_pcgreg, OBJECT(dev),
> &dwc2_mmio_pcgreg_ops, s,
> > +                          "power/clock", 0x8);
> > +    memory_region_init_io(&s->mem_hreg2, OBJECT(dev),
> &dwc2_mmio_hreg2_ops, s,
> > +                          "host fifos", NB_CHAN * 0x1000);
> > +
> > +    memory_region_add_subregion(&s->mem, s->glbregbase, &s->mem_glbreg=
);
> > +    memory_region_add_subregion(&s->mem, s->fszregbase, &s->mem_fszreg=
);
> > +    memory_region_add_subregion(&s->mem, s->hreg0base, &s->mem_hreg0);
> > +    memory_region_add_subregion(&s->mem, s->hreg1base, &s->mem_hreg1);
> > +    memory_region_add_subregion(&s->mem, s->pcgregbase, &s->mem_pcgreg=
);
> > +    memory_region_add_subregion(&s->mem, s->hreg2base, &s->mem_hreg2);
> > +
> > +    s->eof_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                dwc2_frame_boundary, s);
> > +}
> > +
> > +static void dwc2_sysbus_reset(DeviceState *dev)
> > +{
> > +    SysBusDevice *d =3D SYS_BUS_DEVICE(dev);
> > +    DWC2State *s =3D DWC2_USB(d);
> > +
> > +    dwc2_reset(s);
> > +}
> > +
> > +static void dwc2_sysbus_realize(DeviceState *dev, Error **errp)
> > +{
> > +    SysBusDevice *d =3D SYS_BUS_DEVICE(dev);
> > +    DWC2State *s =3D DWC2_USB(dev);
> > +
> > +    s->glbregbase =3D 0;
> > +    s->fszregbase =3D 0x0100;
> > +    s->hreg0base =3D 0x0400;
> > +    s->hreg1base =3D 0x0500;
> > +    s->pcgregbase =3D 0x0e00;
> > +    s->hreg2base =3D 0x1000;
>
> No need to use variable for the constant base addresses, use them
> directly in as argument to memory_region_add_subregion().
>

These values are also used in the register read/write functions,
that's why they are in variables.

Since you don't reuse each block, and blocks cover very few registers,
> have you considered using a pair of MRs instead? One of 4KB and the
> other 64KB. hreg2 is the only one particularly different.
>

Because this controller has so many registers, I use arrays
in the DWC2State struct to hold them instead of addressing
them individually. If I only used two MRs, those arrays would
either need be a lot bigger, or the read/write functions would
need some special logic to address the correct array. I thought
the current method was the most straightforward.

Thanks,
Paul

--0000000000003e26e905a3be3509
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace">Hi Philippe,<br></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 20, 2020 at=
 12:16 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org=
">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Hi Paul,<br>
<br>
On 3/29/20 1:17 AM, Paul Zimmerman wrote:<br>
&gt; Add the dwc-hsotg (dwc2) USB host controller emulation code.<br>
&gt; Based on hw/usb/hcd-ehci.c and hw/usb/hcd-ohci.c.<br>
&gt; <br>
&gt; Note that to use this with the dwc-otg driver in the Raspbian<br>
&gt; kernel, you must pass the option &quot;dwc_otg.fiq_fsm_enable=3D0&quot=
; on<br>
&gt; the kernel command line.<br>
&gt; <br>
&gt; Emulation of slave mode and of descriptor-DMA mode has not been<br>
&gt; implemented yet. These modes are seldom used.<br>
&gt; <br>
&gt; I have used some on-line sources of information while developing<br>
&gt; this emulation, including:<br>
&gt; <br>
&gt; <a href=3D"http://www.capital-micro.com/PDF/CME-M7_Family_User_Guide_E=
N.pdf" rel=3D"noreferrer" target=3D"_blank">http://www.capital-micro.com/PD=
F/CME-M7_Family_User_Guide_EN.pdf</a><br>
&gt; has a pretty complete description of the controller starting on<br>
&gt; page 370.<br>
&gt; <br>
&gt; <a href=3D"https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/tree=
/docs/DataSheets/RT3050_5x_V2.0_081408_0902.pdf" rel=3D"noreferrer" target=
=3D"_blank">https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/tree/doc=
s/DataSheets/RT3050_5x_V2.0_081408_0902.pdf</a><br>
&gt; has a description of the controller registers starting on page<br>
&gt; 130.<br>
&gt; <br>
&gt; Signed-off-by: Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com=
" target=3D"_blank">pauldzim@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/usb/hcd-dwc2.c=C2=A0 =C2=A0| 1301 +++++++++++++++++++++++++++=
++++++++++++++++<br>
&gt;=C2=A0 hw/usb/trace-events |=C2=A0 =C2=A047 ++<br>
&gt;=C2=A0 2 files changed, 1348 insertions(+)<br>
&gt;=C2=A0 create mode 100644 hw/usb/hcd-dwc2.c<br>
&gt; <br>
&gt; diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c<br>
[...]<br>
&gt; +static void dwc2_init(DWC2State *s, DeviceState *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 s-&gt;usb_frame_time =3D NANOSECONDS_PER_SECOND / 1000;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 1000000 */<br>
&gt; +=C2=A0 =C2=A0 if (NANOSECONDS_PER_SECOND &gt;=3D USB_HZ_FS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;usb_bit_time =3D NANOSECONDS_PER_SE=
COND / USB_HZ_FS;=C2=A0 =C2=A0/* 83.3 */<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;usb_bit_time =3D 1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;fi =3D 11999;<br>
<br>
What is this magic number?<br></blockquote><div><br></div><div style=3D"fon=
t-family:monospace,monospace" class=3D"gmail_default">This is the USB frame=
 interval, in bit times I believe. It&#39;s actually</div><div style=3D"fon=
t-family:monospace,monospace" class=3D"gmail_default">12000-1. Not sure of =
the reason for the -1, I lifted this code directly<br></div><div style=3D"f=
ont-family:monospace,monospace" class=3D"gmail_default">from the hcd-ohci d=
river and it seems to work ;) The hcd-ohci driver</div><div style=3D"font-f=
amily:monospace,monospace" class=3D"gmail_default">actually has this value =
in hex (0x2edf), I changed it to decimal because</div><div style=3D"font-fa=
mily:monospace,monospace" class=3D"gmail_default">I thought it was clearer.=
 I can make a #define for this if you think</div><div style=3D"font-family:=
monospace,monospace" class=3D"gmail_default">that would be better.<br></div=
><div style=3D"font-family:monospace,monospace" class=3D"gmail_default"><br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_init(&amp;s-&gt;mem, OBJECT(dev), &quot;d=
wc2&quot;, DWC2_MMIO_SIZE);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;mem_glbreg, OBJECT(dev=
), &amp;dwc2_mmio_glbreg_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;global&quot;, 0x70);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;mem_fszreg, OBJECT(dev=
), &amp;dwc2_mmio_fszreg_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;hptxfsiz&quot;, 0x4);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;mem_hreg0, OBJECT(dev)=
, &amp;dwc2_mmio_hreg0_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;host&quot;, 0x44);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;mem_hreg1, OBJECT(dev)=
, &amp;dwc2_mmio_hreg1_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;host channels&quot;, 0x20 * NB_CHAN);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;mem_pcgreg, OBJECT(dev=
), &amp;dwc2_mmio_pcgreg_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;power/clock&quot;, 0x8);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;mem_hreg2, OBJECT(dev)=
, &amp;dwc2_mmio_hreg2_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;host fifos&quot;, NB_CHAN * 0x1000);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(&amp;s-&gt;mem, s-&gt;glbre=
gbase, &amp;s-&gt;mem_glbreg);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(&amp;s-&gt;mem, s-&gt;fszre=
gbase, &amp;s-&gt;mem_fszreg);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(&amp;s-&gt;mem, s-&gt;hreg0=
base, &amp;s-&gt;mem_hreg0);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(&amp;s-&gt;mem, s-&gt;hreg1=
base, &amp;s-&gt;mem_hreg1);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(&amp;s-&gt;mem, s-&gt;pcgre=
gbase, &amp;s-&gt;mem_pcgreg);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(&amp;s-&gt;mem, s-&gt;hreg2=
base, &amp;s-&gt;mem_hreg2);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;eof_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dwc2_frame_boundary, s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void dwc2_sysbus_reset(DeviceState *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *d =3D SYS_BUS_DEVICE(dev);<br>
&gt; +=C2=A0 =C2=A0 DWC2State *s =3D DWC2_USB(d);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dwc2_reset(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void dwc2_sysbus_realize(DeviceState *dev, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *d =3D SYS_BUS_DEVICE(dev);<br>
&gt; +=C2=A0 =C2=A0 DWC2State *s =3D DWC2_USB(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;glbregbase =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;fszregbase =3D 0x0100;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;hreg0base =3D 0x0400;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;hreg1base =3D 0x0500;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;pcgregbase =3D 0x0e00;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;hreg2base =3D 0x1000;<br>
<br>
No need to use variable for the constant base addresses, use them<br>
directly in as argument to memory_region_add_subregion().<br></blockquote><=
div><br></div><div style=3D"font-family:monospace,monospace" class=3D"gmail=
_default">These values are also used in the register read/write functions,<=
/div><div style=3D"font-family:monospace,monospace" class=3D"gmail_default"=
>that&#39;s why they are in variables.</div><div style=3D"font-family:monos=
pace,monospace" class=3D"gmail_default"><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
Since you don&#39;t reuse each block, and blocks cover very few registers,<=
br>
have you considered using a pair of MRs instead? One of 4KB and the<br>
other 64KB. hreg2 is the only one particularly different.<br></blockquote><=
div><br></div><div style=3D"font-family:monospace,monospace" class=3D"gmail=
_default">Because this controller has so many registers, I use arrays</div>=
<div style=3D"font-family:monospace,monospace" class=3D"gmail_default">in t=
he DWC2State struct to hold them instead of addressing</div><div style=3D"f=
ont-family:monospace,monospace" class=3D"gmail_default">them individually. =
If I only used two MRs, those arrays would</div><div style=3D"font-family:m=
onospace,monospace" class=3D"gmail_default">either need be a lot bigger, or=
 the read/write functions would</div><div style=3D"font-family:monospace,mo=
nospace" class=3D"gmail_default">need some special logic to address the cor=
rect array. I thought</div><div style=3D"font-family:monospace,monospace" c=
lass=3D"gmail_default">the current method was the most straightforward.</di=
v><div style=3D"font-family:monospace,monospace" class=3D"gmail_default"><b=
r></div><div style=3D"font-family:monospace,monospace" class=3D"gmail_defau=
lt">Thanks,</div><div style=3D"font-family:monospace,monospace" class=3D"gm=
ail_default">Paul<br></div><br></div></div>

--0000000000003e26e905a3be3509--

