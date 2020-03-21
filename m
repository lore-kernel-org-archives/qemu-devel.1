Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B2CC4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 17:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D30B20724
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 17:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyYg7nDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D30B20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFhlO-0002VT-9V
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 13:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jFhkl-00025P-QI
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 13:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jFhkk-0004wg-7V
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 13:17:43 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:38610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jFhkk-0004wS-1c
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 13:17:42 -0400
Received: by mail-io1-xd42.google.com with SMTP id m15so4479166iob.5
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KbQldffzCEJ4E2mNJ0T7zxHDa8S/Y/TEGNYQZXxKz/g=;
 b=gyYg7nDNFPpTC3Ozw7QTLcdW7Eg1R+ROvzkd7k3aTPyhAtwRY3uKSL+2elQ+UduqaW
 aUvOzfC1DMacRGCyEUsaIAF1eIDFECmdLZP2SmTrCcXGdiLQqkfsWx52nXT92fApM3ML
 trjZR5R4swTJhiy0L7PEF+4IES59aRZ9bPW9SJFjQ4eKQJWx5l8W0LgA+YhhyEIXmvw5
 SG7eupbglEah7d1DvsJ9kj51jA3rBz84chLZdgY7Q9pMl5L3eRvCBxKsBt3yGhunnOmm
 FwcT+SoXWC7W2pDIooEolR1HlwLMu6dAKA6bjtinzvfFPKfgsC9oMjIxuZRiRoaB7ENV
 ibhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KbQldffzCEJ4E2mNJ0T7zxHDa8S/Y/TEGNYQZXxKz/g=;
 b=PQIJjnNX/ba6/h5IEdpHTOQk/M239AAoWB+oe80d6edXLk9bFMT7Z0fRWU6e2r2xm8
 oxlVaFIRM7iXkB4r7hdobXcmiR46nuOpEugM3cVf3eXV7CZEdm2err1ro61OleoFUDnr
 VZCd+azvqHWXxtQ5d+oeeJWMly1/UU5HRzvoRDRBEpP+n6dpwo3NmVCx0hGU8eOFDDIB
 EdmHfGiSO/8WUVRWSJEm4r/7XOEnNCBFd8ASjP89v0LClhQYD9aZzll5/0+mR0Qyhb60
 1H9uKBAW8ThCKO6tve1VxlzeYJxjhWpURCsgMPcLAURkl+UrceKALOe3ZCUA0wPWbemM
 m6Yg==
X-Gm-Message-State: ANhLgQ1E4eesT6HXqqUjUdvXJfdTRUnRxVT0iAAjFZyiJoiLDU9QV2cy
 CpZwuPAQx/zYmtmI3DhBlI70mvOluhfrOHc2MMs=
X-Google-Smtp-Source: ADFU+vscqQGr6xL/R/Mw/vFrWuMXaF6YgMvLwQMSkB8b+tNWL9+wzBxHiRe3sp1sB/yg2NVw5wFXdkSA4CgbNFWslZU=
X-Received: by 2002:a6b:5103:: with SMTP id f3mr12557514iob.181.1584811060560; 
 Sat, 21 Mar 2020 10:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200312164459.25924-1-peter.maydell@linaro.org>
 <20200312164459.25924-22-peter.maydell@linaro.org>
 <CAFEAcA-F85aJ4yigDdEMd4=kAEaPV+f4zn9cuyhyoO-xhEcAng@mail.gmail.com>
In-Reply-To: <CAFEAcA-F85aJ4yigDdEMd4=kAEaPV+f4zn9cuyhyoO-xhEcAng@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sat, 21 Mar 2020 18:17:29 +0100
Message-ID: <CAPan3WrW=YwnjiGnhQ1Wdyj7jwcsLXiVy0eQv-K_LhRfAZvyQg@mail.gmail.com>
Subject: Re: [PULL 21/36] hw/arm/allwinner-h3: add Boot ROM support
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004d051105a160944f"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004d051105a160944f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,


On Fri, Mar 20, 2020 at 1:08 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Thu, 12 Mar 2020 at 16:45, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > From: Niek Linnenbank <nieklinnenbank@gmail.com>
> >
> > A real Allwinner H3 SoC contains a Boot ROM which is the
> > first code that runs right after the SoC is powered on.
> > The Boot ROM is responsible for loading user code (e.g. a bootloader)
> > from any of the supported external devices and writing the downloaded
> > code to internal SRAM. After loading the SoC begins executing the code
> > written to SRAM.
> >
> > This commits adds emulation of the Boot ROM firmware setup functionalit=
y
> > by loading user code from SD card in the A1 SRAM. While the A1 SRAM is
> > 64KiB, we limit the size to 32KiB because the real H3 Boot ROM also
> rejects
> > sizes larger than 32KiB. For reference, this behaviour is documented
> > by the Linux Sunxi project wiki at:
> >
> >   https://linux-sunxi.org/BROM#U-Boot_SPL_limitations
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Message-id: 20200311221854.30370-11-nieklinnenbank@gmail.com
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Hi; Coverity (CID 1421882) points out a possible NULL
> pointer dereference in this change:
>
> > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> > index d65bbf8a2fe..b8ebcb08b76 100644
> > --- a/hw/arm/orangepi.c
> > +++ b/hw/arm/orangepi.c
> > @@ -97,6 +97,11 @@ static void orangepi_init(MachineState *machine)
> >      memory_region_add_subregion(get_system_memory(),
> h3->memmap[AW_H3_SDRAM],
> >                                  machine->ram);
> >
> > +    /* Load target kernel or start using BootROM */
> > +    if (!machine->kernel_filename && blk_is_available(blk)) {
> > +        /* Use Boot ROM to copy data from SD card to SRAM */
> > +        allwinner_h3_bootrom_setup(h3, blk);
> > +    }
>
> blk_is_available() assumes its argument is non-NULL, but
> earlier in the function we set up blk with:
>    b=EF=BB=BF=EF=BB=BF=EF=BB=BF=EF=BB=BF=EF=BB=BF=EF=BB=BF=EF=BB=BFlk =3D=
 di ? blk_by_legacy_dinfo(di) : NULL;
>
> so it can be NULL here.
>
>
Right, indeed.


> Could you send a patch to fix this, please? Probably
>
just adding '&& blk' in the middle of the condition
> is sufficient.
>

Sure, I'll make a small patch for this, and also the other one you reported
for the SDRAM controller.

By the way, I do not have the coverity tool unfortunately. So I can't
really check myself
if any of the other Allwinner H3 files also have warnings that can be
fixed..
But if coverity finds more, just let me know, and I'll look into it.

Regards,
Niek



>
> thanks
> -- PMM
>


--=20
Niek Linnenbank

--0000000000004d051105a160944f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Peter,</div><div><br></div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri=
, Mar 20, 2020 at 1:08 PM Peter Maydell &lt;<a href=3D"mailto:peter.maydell=
@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Thu, 12 Mar 2020 at 16:45, Peter Ma=
ydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">pet=
er.maydell@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" =
target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt;<br>
&gt; A real Allwinner H3 SoC contains a Boot ROM which is the<br>
&gt; first code that runs right after the SoC is powered on.<br>
&gt; The Boot ROM is responsible for loading user code (e.g. a bootloader)<=
br>
&gt; from any of the supported external devices and writing the downloaded<=
br>
&gt; code to internal SRAM. After loading the SoC begins executing the code=
<br>
&gt; written to SRAM.<br>
&gt;<br>
&gt; This commits adds emulation of the Boot ROM firmware setup functionali=
ty<br>
&gt; by loading user code from SD card in the A1 SRAM. While the A1 SRAM is=
<br>
&gt; 64KiB, we limit the size to 32KiB because the real H3 Boot ROM also re=
jects<br>
&gt; sizes larger than 32KiB. For reference, this behaviour is documented<b=
r>
&gt; by the Linux Sunxi project wiki at:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://linux-sunxi.org/BROM#U-Boot_SPL_limitat=
ions" rel=3D"noreferrer" target=3D"_blank">https://linux-sunxi.org/BROM#U-B=
oot_SPL_limitations</a><br>
&gt;<br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro=
.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
&gt; Message-id: <a href=3D"mailto:20200311221854.30370-11-nieklinnenbank@g=
mail.com" target=3D"_blank">20200311221854.30370-11-nieklinnenbank@gmail.co=
m</a><br>
&gt; Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
<br>
Hi; Coverity (CID 1421882) points out a possible NULL<br>
pointer dereference in this change:<br>
<br>
&gt; diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
&gt; index d65bbf8a2fe..b8ebcb08b76 100644<br>
&gt; --- a/hw/arm/orangepi.c<br>
&gt; +++ b/hw/arm/orangepi.c<br>
&gt; @@ -97,6 +97,11 @@ static void orangepi_init(MachineState *machine)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), h=
3-&gt;memmap[AW_H3_SDRAM],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 machine-&gt;ram);<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 /* Load target kernel or start using BootROM */<br>
&gt; +=C2=A0 =C2=A0 if (!machine-&gt;kernel_filename &amp;&amp; blk_is_avai=
lable(blk)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Use Boot ROM to copy data from SD card=
 to SRAM */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_h3_bootrom_setup(h3, blk);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
blk_is_available() assumes its argument is non-NULL, but<br>
earlier in the function we set up blk with:<br>
=C2=A0 =C2=A0b=EF=BB=BF=EF=BB=BF=EF=BB=BF=EF=BB=BF=EF=BB=BF=EF=BB=BF=EF=BB=
=BFlk =3D di ? blk_by_legacy_dinfo(di) : NULL;<br>
<br>
so it can be NULL here.<br>
<br></blockquote><div><br></div><div>Right, indeed.<br></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
Could you send a patch to fix this, please? Probably <br></blockquote><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
just adding &#39;&amp;&amp; blk&#39; in the middle of the condition<br>
is sufficient.<br></blockquote><div><br></div><div>Sure, I&#39;ll make a sm=
all patch for this, and also the other one you reported for the SDRAM contr=
oller.</div><div><br></div><div>By the way, I do not have the coverity tool=
 unfortunately. So I can&#39;t really check myself</div><div> if any of the=
 other Allwinner H3 files also have warnings that can be fixed..</div><div>=
But if coverity finds more, just let me know, and I&#39;ll look into it.<br=
></div><div><br></div><div>Regards,</div><div>Niek<br></div><div><br></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000004d051105a160944f--

