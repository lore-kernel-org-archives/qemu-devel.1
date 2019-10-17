Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FC2ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9E120872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wfn6Eo9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9E120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52019 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8KP-0002ic-S6
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL7Kh-0006uP-5n
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL7Kf-0007Q5-T8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:04:55 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL7Kf-0007PN-O8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:04:53 -0400
Received: by mail-ot1-x341.google.com with SMTP id s22so2167060otr.6
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=wgS1jZcaqCcTvqEqC1BFmC8o0+RAXXj+6+uXMhe+m4I=;
 b=Wfn6Eo9qEcoIAhHMXxaGgOyKgnhEy8bbF7dLomzjnralh2tU7f/y+hPQgalan9MFG/
 u8RKQs/EqGAA6Z1WN/gJslR3K+4S3lorUHGJcotu7lOn5A6nQ3o6gP860p9QGBQpMyT7
 0+gzo++eeXOO2YpTkOdNIJJGP15HJf1YdVmTEh03Ox+371SDHt3g2AqfcGgRYWZraYdw
 9Muon29iUyz3i2ilKz/d2DK2YnxViMfaBxA/XQorLYlQFU/eKc0l8kgSM5QbezkFvMhK
 eo91s8e/VJJ9eKClmCvwmBTd16dJKASjO/MZCKoQV7d1Lj0HdQShdF8LYbZ5+hwgqGeR
 6G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=wgS1jZcaqCcTvqEqC1BFmC8o0+RAXXj+6+uXMhe+m4I=;
 b=BI6F27SfA7dDHJVOZxerZd/3xNWGzVTUAgUMmHH3/XfGxoSeNjx1odZIxpCT6icXTK
 RdK+7yZNH2wVxa31x//uvvQPTIXNFK/CKV9Z1Kr5XfDc48NY5GKQc/bNC/yebzgsSv59
 IqdXAc3a4H79IXuX7MFsT3lzYW60geBsGvvvunu3f8aQv21Mw99Em1EMysw/C2rIwgHQ
 iZPLRc+GCpbzWqzs9Zqcv8Qe9/h+c9jAJkvDPpd0Im+ECEbO4U3eOhKfaZM9UEWnAE+2
 rLvBuX/noEcXGdiB/iZtt7hrIJZJVR8mjNeqd2izTLpGzegRvKNmqz8MIFyuqf4lWeZA
 wDvw==
X-Gm-Message-State: APjAAAUUo1c0jWiORpiCpeO+bJ35bC6lbAHFVbEIksdLUdruPTkwfRdP
 8o4XC7gjtuQqfvSi7hIvzQp/t45e1cjIp6QH2Y4=
X-Google-Smtp-Source: APXvYqz+Ot+eP9DDaUereiJdSkpixNdxEtY72cJZ4QvOUjW2227rdptjzmw0HshxvBPDz2sRPjjkAvrgP/IEiBqC5Rk=
X-Received: by 2002:a9d:684c:: with SMTP id c12mr3523017oto.341.1571324693100; 
 Thu, 17 Oct 2019 08:04:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 08:04:51
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-9-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-9-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 17:04:51 +0200
Message-ID: <CAL1e-=gMhtdJYDrb1fPDr65DUngsPf4-sLDYwU6rY0oS3LnGUg@mail.gmail.com>
Subject: Re: [PATCH 08/32] piix4: rename some variables in realize function
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000028bded05951c8a5d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000028bded05951c8a5d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>
> PIIX4 structure is now 's'
> PCI device is now 'pci_dev'
> DeviceState is now 'dev'
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Message-Id: <20171216090228.28505-6-hpoussin@reactos.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/isa/piix4.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>



> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 3294056cd5..4202243e41 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -88,16 +88,17 @@ static const VMStateDescription vmstate_piix4 =3D {
>      }
>  };
>
> -static void piix4_realize(PCIDevice *dev, Error **errp)
> +static void piix4_realize(PCIDevice *pci_dev, Error **errp)
>  {
> -    PIIX4State *d =3D PIIX4_PCI_DEVICE(dev);
> +    DeviceState *dev =3D DEVICE(pci_dev);
> +    PIIX4State *s =3D DO_UPCAST(PIIX4State, dev, pci_dev);
>
> -    if (!isa_bus_new(DEVICE(d), pci_address_space(dev),
> -                     pci_address_space_io(dev), errp)) {
> +    if (!isa_bus_new(dev, pci_address_space(pci_dev),
> +                     pci_address_space_io(pci_dev), errp)) {
>          return;
>      }
> -    piix4_dev =3D &d->dev;
> -    qemu_register_reset(piix4_reset, d);
> +    piix4_dev =3D pci_dev;
> +    qemu_register_reset(piix4_reset, s);
>  }
>
>  int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
> --
> 2.21.0
>
>
>

--00000000000028bded05951c8a5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">From: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:h=
poussin@reactos.org">hpoussin@reactos.org</a>&gt;<br>
<br>
PIIX4 structure is now &#39;s&#39;<br>
PCI device is now &#39;pci_dev&#39;<br>
DeviceState is now &#39;dev&#39;<br>
<br>
Acked-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redh=
at.com</a>&gt;<br>
Acked-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini=
@redhat.com</a>&gt;<br>
Signed-off-by: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos=
.org">hpoussin@reactos.org</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20171216090228.28505-6-hpoussin@reactos.o=
rg">20171216090228.28505-6-hpoussin@reactos.org</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/isa/piix4.c | 13 +++++++------<br>
=C2=A01 file changed, 7 insertions(+), 6 deletions(-)<br>
<br></blockquote><div><br></div><div><div id=3D"cvcmsg_16dbfeb33c93ed97" cl=
ass=3D"yh  " style=3D"border-top-left-radius:0px;border-top-right-radius:0p=
x;margin-bottom:11px;overflow:visible"><div class=3D"Vh" id=3D"cvcfullmsg_1=
6dbfeb33c93ed97"><div id=3D"cvcmsgbod_16dbfeb33c93ed97" class=3D"aj"><div c=
lass=3D"Ni"><div class=3D"ni pi " dir=3D"ltr"><p dir=3D"ltr">Reviewed-by: A=
leksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com" target=3D"=
_blank">amarkovic@wavecomp.com</a>&gt;</p><div style=3D"clear:both"></div><=
/div><div style=3D"clear:both"></div><div><div class=3D"M j T b hc Aj S" ta=
bindex=3D"0"><div class=3D"V j hf"></div></div></div><div style=3D"clear:bo=
th"></div></div></div></div></div><div id=3D"cvcmsg_16dbfecd588da1f7" class=
=3D"yh" style=3D"margin-bottom:11px"><div class=3D"Vh" id=3D"cvcfullmsg_16d=
bfecd588da1f7"><div class=3D"M j Zi Mi  " tabindex=3D"0"><div id=3D"cvcrepl=
y_16dbfecd588da1f7" class=3D"M j T b hc xh S  " tabindex=3D"0"><div class=
=3D"V j td"></div></div></div></div></div></div><div><br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c<br>
index 3294056cd5..4202243e41 100644<br>
--- a/hw/isa/piix4.c<br>
+++ b/hw/isa/piix4.c<br>
@@ -88,16 +88,17 @@ static const VMStateDescription vmstate_piix4 =3D {<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
<br>
-static void piix4_realize(PCIDevice *dev, Error **errp)<br>
+static void piix4_realize(PCIDevice *pci_dev, Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 PIIX4State *d =3D PIIX4_PCI_DEVICE(dev);<br>
+=C2=A0 =C2=A0 DeviceState *dev =3D DEVICE(pci_dev);<br>
+=C2=A0 =C2=A0 PIIX4State *s =3D DO_UPCAST(PIIX4State, dev, pci_dev);<br>
<br>
-=C2=A0 =C2=A0 if (!isa_bus_new(DEVICE(d), pci_address_space(dev),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pci_address_space_io(dev), errp)) {<br>
+=C2=A0 =C2=A0 if (!isa_bus_new(dev, pci_address_space(pci_dev),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pci_address_space_io(pci_dev), errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 piix4_dev =3D &amp;d-&gt;dev;<br>
-=C2=A0 =C2=A0 qemu_register_reset(piix4_<wbr>reset, d);<br>
+=C2=A0 =C2=A0 piix4_dev =3D pci_dev;<br>
+=C2=A0 =C2=A0 qemu_register_reset(piix4_<wbr>reset, s);<br>
=C2=A0}<br>
<br>
=C2=A0int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--00000000000028bded05951c8a5d--

