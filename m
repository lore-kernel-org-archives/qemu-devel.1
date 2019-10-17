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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0DBFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288502089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPBRNTmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288502089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7ua-0001c5-NJ
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL71o-0007db-I0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL71n-0007IQ-3r
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:45:24 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL71m-0007Hz-Ug
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:45:23 -0400
Received: by mail-oi1-x241.google.com with SMTP id t84so2340270oih.10
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=NVOIQm4H/O0Cx5VJa3R22BQF2d1DAtNSsVKXlEKnY1o=;
 b=IPBRNTmt1Tgx1L2hARo2oYLM8u5khR4Zw3KmCLU3i4xVkScVO2orpzAe2+p2vVGD94
 n6JmwpAe8G7SuKvmIWX4T/io377hyec3VdgEwpormFgGgjnuIVJW0mCls2AmX7z0CZkB
 LXn4VIbhT7y7S5rNmofuHK6iNukXM79WYQQt4N++BrlQ/9NdAxZpIr41oCvHqWANh8YA
 QPphVSfVA/sPS0jZTOSKbZNMp6srZ6GM7uAYIEoQCnyUdWfwrHEASxaemkki5UuI67jr
 6Lu2SEew4GZTvcgYDX1SyHnMYE6en7WyldX7Dk6KooT6oI6r3XNef/427aKhKMHHtLYy
 /aoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=NVOIQm4H/O0Cx5VJa3R22BQF2d1DAtNSsVKXlEKnY1o=;
 b=tLNyKQt/gpC54DQL5SIu4TrN59Y7h8xFufJ2I6qoUBObz43Uol9RAYCAmM/y99Xteb
 9Xnt3QT/Iks/+vPjF3xi438Gcj1CrG0li8+7bZcS+jEghYzkAaI+Ldpzw1NDcPTyBk0F
 HyLsBxxHCbFbgm/RFoBa3IEK52Y2FvnmQtPs/Q32f/IIV4rKfn2yzb5LZaeIG/jd0pFQ
 XXjtcqtqxeB/5YikqqtF+s2Wkw++zNpjmD6tm1Ac/JQZBxMaIpliZ0hH6cW5wo/ZVWvp
 SJKnWiY/eFX9wpfoTEWXMtdxtVgVK1c93lkKjxzn0NVmIFCzZDQjBANN53sMyzrPLKco
 gvcA==
X-Gm-Message-State: APjAAAXjPmjVA2YjF4AISHNZpM4YuUVyKOxfZed63rtWfQVk5H9/0Iw3
 FbYpgTCw5WrjKfe2YsImMzeQeiBjyM725ISiCu4=
X-Google-Smtp-Source: APXvYqxxPmqsoiYCMSa9/sz4vxEvLCM1pfKYNicVq8B751PVe8aOK0zLkgvBQELFeXhyUSAv+IQ58H0JDp/WyDdwHSE=
X-Received: by 2002:aca:62d5:: with SMTP id w204mr3552201oib.136.1571323522344; 
 Thu, 17 Oct 2019 07:45:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 07:45:21
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-18-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-18-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 16:45:21 +0200
Message-ID: <CAL1e-=hQ2jG-CwR9bWb1YprNfL4MviWh6xn08oh0ucpEDjRm4A@mail.gmail.com>
Subject: Re: [PATCH 17/32] hw/mips/mips_malta: Create IDE hard drive array
 dynamically
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000606b4005951c4431"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

--000000000000606b4005951c4431
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> In the next commit we'll refactor the PIIX4 code out of
> mips_malta_init(). As a preliminary step, add the 'ide_drives'
> variable and create the drive array dynamically.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/mips/mips_malta.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 528c34a1c3..774bb810f6 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1235,7 +1235,8 @@ void mips_malta_init(MachineState *machine)
>      int piix4_devfn;
>      I2CBus *smbus;
>      DriveInfo *dinfo;
> -    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> +    const size_t ide_drives =3D MAX_IDE_BUS * MAX_IDE_DEVS;
> +    DriveInfo **hd;
>      int fl_idx =3D 0;
>      int be;
>
> @@ -1406,7 +1407,8 @@ void mips_malta_init(MachineState *machine)
>      pci_bus =3D gt64120_register(s->i8259);
>
>      /* Southbridge */
> -    ide_drive_get(hd, ARRAY_SIZE(hd));
> +    hd =3D g_new(DriveInfo *, ide_drives);
> +    ide_drive_get(hd, ide_drives);
>
>      pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
>                                            true, TYPE_PIIX4_PCI_DEVICE);
> @@ -1421,6 +1423,7 @@ void mips_malta_init(MachineState *machine)
>      }
>
>      pci_piix4_ide_init(pci_bus, hd, piix4_devfn + 1);
> +    g_free(hd);
>      pci_create_simple(pci_bus, piix4_devfn + 2, "piix4-usb-uhci");
>      smbus =3D piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
>                            isa_get_irq(NULL, 9), NULL, 0, NULL);
> --
> 2.21.0
>
>
>

--000000000000606b4005951c4431
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">In the next commit we&#39;ll refactor the PIIX4 cod=
e out of<br>
mips_malta_init(). As a preliminary step, add the &#39;ide_drives&#39;<br>
variable and create the drive array dynamically.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/mips/mips_malta.c | 7 +++++--<br>
=C2=A01 file changed, 5 insertions(+), 2 deletions(-)<br>
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
=3D"V j td"></div></div></div></div></div></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c<br>
index 528c34a1c3..774bb810f6 100644<br>
--- a/hw/mips/mips_malta.c<br>
+++ b/hw/mips/mips_malta.c<br>
@@ -1235,7 +1235,8 @@ void mips_malta_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0int piix4_devfn;<br>
=C2=A0 =C2=A0 =C2=A0I2CBus *smbus;<br>
=C2=A0 =C2=A0 =C2=A0DriveInfo *dinfo;<br>
-=C2=A0 =C2=A0 DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];<br>
+=C2=A0 =C2=A0 const size_t ide_drives =3D MAX_IDE_BUS * MAX_IDE_DEVS;<br>
+=C2=A0 =C2=A0 DriveInfo **hd;<br>
=C2=A0 =C2=A0 =C2=A0int fl_idx =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int be;<br>
<br>
@@ -1406,7 +1407,8 @@ void mips_malta_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0pci_bus =3D gt64120_register(s-&gt;i8259);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Southbridge */<br>
-=C2=A0 =C2=A0 ide_drive_get(hd, ARRAY_SIZE(hd));<br>
+=C2=A0 =C2=A0 hd =3D g_new(DriveInfo *, ide_drives);<br>
+=C2=A0 =C2=A0 ide_drive_get(hd, ide_drives);<br>
<br>
=C2=A0 =C2=A0 =C2=A0pci =3D pci_create_simple_<wbr>multifunction(pci_bus, P=
CI_DEVFN(10, 0),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0true, TYPE_PIIX4_PCI_DEVICE);<br>
@@ -1421,6 +1423,7 @@ void mips_malta_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0pci_piix4_ide_init(pci_bus, hd, piix4_devfn + 1);<br>
+=C2=A0 =C2=A0 g_free(hd);<br>
=C2=A0 =C2=A0 =C2=A0pci_create_simple(pci_bus, piix4_devfn + 2, &quot;piix4=
-usb-uhci&quot;);<br>
=C2=A0 =C2=A0 =C2=A0smbus =3D piix4_pm_init(pci_bus, piix4_devfn + 3, 0x110=
0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0isa_get_irq(NULL, 9), NULL, 0, NULL);<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000606b4005951c4431--

