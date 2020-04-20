Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C333EC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E79120782
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgNpiHtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E79120782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQc7i-0007sy-Jg
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 15:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQc6U-0006ZL-R0
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQc6N-000359-Jg
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:29:14 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:37071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jQc6N-000334-5v
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:29:07 -0400
Received: by mail-io1-xd43.google.com with SMTP id u11so12427501iow.4
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LO+cgbWhIsazGmEuLy5F6qD9PU/fq4zFUziPM4DeTlQ=;
 b=vgNpiHtJk3GuaKpLQHj+UDSgmTl58Y/MtVUvzkVilLF5da+MrHSEnoe0ZFzbuCpqa5
 l8TnE2hO7bKTXOFDftFhMh50P8S7csiqU+ABi6PrYCVCmS12sXMCHmWQbyrMxZGJIcy+
 FX/1y5lEM8PdhsOq3RFQmZsseC7z/syiaOrVTL9YdSHTuh1GtawnRcvoh/i3oePl4vsH
 jyRe8F4uFq9ihr+gZ/JPisSBwne/IwEWCuFe2DALn78SZFoYco3Pwpehp/fwtWqhWY/y
 l4dDgvsXTpVKu+61QEj2J7iddqqsOG9Mj+eD+qEqmS3Kf8ixZFx5p6qyVqjQNUk9TdlQ
 CPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LO+cgbWhIsazGmEuLy5F6qD9PU/fq4zFUziPM4DeTlQ=;
 b=UWhNXUKkguFfiOjuVOHC0+ZO0IjFGu2GXNIWOh2Y+83dP8KJoCo0jKgXJHtE0NzhoI
 VJPLX2QutZH76iqqP1C3ShN9RP+9RalkfIKhVHqnmaxvBlAkxb8xkh0Q3rCIZzGYLTXp
 TSVWlDTfnUwI4nB7fB4CAl2f6kJraYndsKmzY98BBncr/Esr0+hPY1JqFweTSjop0mrr
 f72HHShJ7449UtWAmdYkRXmO5kwZPyl3lsOWv9paSV0M+5AIc19CXWjS1Cs5uHQcZjAX
 eSPnmHpDS8da44sMiMO/qjFgtzmgaj+IuV//6tV80h7hLLcdBTcAfW5FTnUeEUcJwb/J
 YqwA==
X-Gm-Message-State: AGi0PuZPTe0yCtWZbFdBVAC7ZOduicyyb2laif3M9lnfLpxxcMlk7Nbt
 L0RReQ+lXSHbTW6Nmw3UwLnNtCJujrOH7qxsd7Y=
X-Google-Smtp-Source: APiQypJ37e9xPSGxoYP+RuM+llubwTwZvAITARaZwHCtmh8WDbaSyR4rkFJFJI/wZIOa8AJ18FZsJyG+5akMavsgqVw=
X-Received: by 2002:a6b:2b91:: with SMTP id r139mr17330076ior.61.1587410945271; 
 Mon, 20 Apr 2020 12:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200329001705.15966-1-pauldzim@gmail.com>
 <20200329001705.15966-5-pauldzim@gmail.com>
 <2a1d3776-0a6b-360e-0c71-9b48fda8dd98@amsat.org>
In-Reply-To: <2a1d3776-0a6b-360e-0c71-9b48fda8dd98@amsat.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Mon, 20 Apr 2020 12:28:38 -0700
Message-ID: <CADBGO7_P1JeHsF1BOThCvBGJ-X=7mdgJNtLC13RsZ1cxWRsVHA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dwc-hsotg USB host controller emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000816d6405a3bde969"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d43
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

--000000000000816d6405a3bde969
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

As the label says, these are the host FIFOs. The controller has a
mode where DMA is not used, and instead the driver reads the data
directly from the FIFOs. I have not implemented this feature yet,
but as I recall one of the BSDs uses this in their driver, so I
plan to implement this in the future.

Thanks,
Paul


On Mon, Apr 20, 2020 at 12:25 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

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
> [...]
> > +static void dwc2_hreg2_write(void *ptr, hwaddr addr, uint64_t val,
> > +                             unsigned size)
> > +{
> > +    uint64_t orig =3D val;
> > +
> > +    /* TODO - implement FIFOs to support slave mode */
> > +    val &=3D 0xffffffff;
> > +    trace_usb_dwc2_hreg2_write(addr, addr >> 12, orig, 0, val);
> > +}
> > +
> [...]
>  +
> > +static const MemoryRegionOps dwc2_mmio_hreg2_ops =3D {
> > +    .read =3D dwc2_hreg2_read,
> > +    .write =3D dwc2_hreg2_write,
> > +    .valid.min_access_size =3D 4,
> > +    .valid.max_access_size =3D 4,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +};
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
> > +
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
> [...]
> What is this region used for? 64KB of packet buffer sram? I'm wondering
> if this shouldn't be created with a memory_region_init_ram() call actuall=
y.
>
>

--000000000000816d6405a3bde969
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hi Philippe,</div><div class=3D"gmail_default" style=3D"font-f=
amily:monospace,monospace"><br></div><div class=3D"gmail_default" style=3D"=
font-family:monospace,monospace">As the label says, these are the host FIFO=
s. The controller has a</div><div class=3D"gmail_default" style=3D"font-fam=
ily:monospace,monospace">mode where DMA is not used, and instead the driver=
 reads the data</div><div class=3D"gmail_default" style=3D"font-family:mono=
space,monospace">directly from the FIFOs. I have not implemented this featu=
re yet,</div><div class=3D"gmail_default" style=3D"font-family:monospace,mo=
nospace">but as I recall one of the BSDs uses this in their driver, so I</d=
iv><div class=3D"gmail_default" style=3D"font-family:monospace,monospace">p=
lan to implement this in the future.</div><div class=3D"gmail_default" styl=
e=3D"font-family:monospace,monospace"><br></div><div class=3D"gmail_default=
" style=3D"font-family:monospace,monospace">Thanks,</div><div class=3D"gmai=
l_default" style=3D"font-family:monospace,monospace">Paul</div><div class=
=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On M=
on, Apr 20, 2020 at 12:25 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mai=
lto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 3/29/20 1:17 AM, Paul Zimmerman wrot=
e:<br>
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
[...]<br>
&gt; +static void dwc2_hreg2_write(void *ptr, hwaddr addr, uint64_t val,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint64_t orig =3D val;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* TODO - implement FIFOs to support slave mode */<br>
&gt; +=C2=A0 =C2=A0 val &amp;=3D 0xffffffff;<br>
&gt; +=C2=A0 =C2=A0 trace_usb_dwc2_hreg2_write(addr, addr &gt;&gt; 12, orig=
, 0, val);<br>
&gt; +}<br>
&gt; +<br>
[...]<br>
=C2=A0+<br>
&gt; +static const MemoryRegionOps dwc2_mmio_hreg2_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D dwc2_hreg2_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D dwc2_hreg2_write,<br>
&gt; +=C2=A0 =C2=A0 .valid.min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 .valid.max_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
&gt; +};<br>
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
[...]<br>
What is this region used for? 64KB of packet buffer sram? I&#39;m wondering=
<br>
if this shouldn&#39;t be created with a memory_region_init_ram() call actua=
lly.<br>
<br>
</blockquote></div>

--000000000000816d6405a3bde969--

