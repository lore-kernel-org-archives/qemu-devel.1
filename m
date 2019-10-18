Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B51CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED5021897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5joDb6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED5021897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLOiJ-0000Hf-1v
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 05:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLOe3-0004S2-VH
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLOe2-0007hc-HJ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:34:03 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLOe1-0007gz-Qe
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:34:01 -0400
Received: by mail-ot1-x342.google.com with SMTP id z6so4431675otb.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 02:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=8kmGKBvA+pMQPbeVneluAYIicVpDPfuuiN2lYzvLGFY=;
 b=W5joDb6Rjcl2602j/Rjoiuwtu4mxydfJjiGCU9G08MoH2kOVU8N1joNJ0VEKOzm0Ni
 Fy0bW93fVZ0tsQ2kT6cjnTGbCTBSf/9QhHJlhWompWQCLbux2saYsa0tsnt4d5OLowGk
 IeEjUbzm783DNHpqIXLqXL9FgoAc/HXTKZm5E9tu7RvFIHW0QqtYui6gy1RbuZmgFqkm
 iXIoSySM+Q+TJOBf50OrPXtZpMw6b1FS2jZcuMviQf5MdG7swbWgNVr6URSx3ZDAULMo
 VxOeE3xAWgeiI3sM7ZZEB4TE28syIYtYeQ7QBGAqo/vXSrDTIkBcqFGc9pfRW9uNkPMv
 seGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=8kmGKBvA+pMQPbeVneluAYIicVpDPfuuiN2lYzvLGFY=;
 b=baZpgPaFvIc+KgGOPbzgcmwdlM2FDJGoN1jJHUypV8rg8ZBFTNlz8cPGEbUOv16I+k
 SO5OWBeZxZSSNVRom/pEaFGfQy0SpOAfKI+AXp9On6eO4Iqjlv+g8D8hrdw4aVFYFzcY
 E0l7O4d1kXotBKzi4cx9B+QKk/aZh3pBOVn82cs23xy6J+3edYSD3dzNtmWvpqKUx6hQ
 wxlK4/kEqV4nI+g2zTAleMo8NvYxQTjMXpMJBGiHeC/mI6/RyqZiMyi2RCwfOVFUsUyW
 Rp1poV5NNBnNpZaCIqsYo+ZncstJG7lesmM8ahKPp1bY7IrIFENX6YgUlotYGIWdPC+t
 jbaw==
X-Gm-Message-State: APjAAAVkqCvKQuVHU26IKRVwZ3j/ZGILts74e/DuqTYJHlFqyoKG+3ST
 9P5KTteCjlj4tiKQs/L3QWmpn/KehceNU531hjo=
X-Google-Smtp-Source: APXvYqyEuy4kvkbgBNCF1zQARF+H+MSyf/x3b0H3+IF5IOlbgKSSw5h6llJaNaTRCvCxy8pVlEw8pzwRvTjBSqDBtvs=
X-Received: by 2002:a05:6830:1d8f:: with SMTP id
 y15mr6448632oti.121.1571391240977; 
 Fri, 18 Oct 2019 02:34:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 18 Oct 2019 02:34:00
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-32-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-32-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 18 Oct 2019 11:34:00 +0200
Message-ID: <CAL1e-=j78xuEhqdHaXn9StE=3M4VBx+yimosTMP6VtgCo0GuGw@mail.gmail.com>
Subject: Re: [PATCH 31/32] hw/pci-host: Rename incorrectly named 'piix' as
 'i440fx'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b8c01d05952c080b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
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

--000000000000b8c01d05952c080b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> We moved all the PIIX3 southbridge code out of hw/pci-host/piix.c,
> it now only contains i440FX northbridge code.
> Rename it to match the chipset modelled.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS                      | 2 +-
>  hw/i386/Kconfig                  | 2 +-
>  hw/pci-host/Kconfig              | 2 +-
>  hw/pci-host/Makefile.objs        | 2 +-
>  hw/pci-host/{piix.c =3D> i440fx.c} | 0
>  5 files changed, 4 insertions(+), 4 deletions(-)
>  rename hw/pci-host/{piix.c =3D> i440fx.c} (100%)
>
>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4845f47d93..1bc9959b8a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1225,7 +1225,7 @@ M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>  S: Supported
>  F: include/hw/i386/
>  F: hw/i386/
> -F: hw/pci-host/piix.c
> +F: hw/pci-host/i440fx.c
>  F: hw/pci-host/q35.c
>  F: hw/pci-host/pam.c
>  F: include/hw/pci-host/i440fx.h
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 589d75e26a..cfe94aede7 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -60,7 +60,7 @@ config I440FX
>      select PC_PCI
>      select PC_ACPI
>      select ACPI_SMBUS
> -    select PCI_PIIX
> +    select PCI_I440FX
>      select PIIX3
>      select IDE_PIIX
>      select DIMM
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index 397043b289..b0aa8351c4 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -28,7 +28,7 @@ config PCI_SABRE
>      select PCI
>      bool
>
> -config PCI_PIIX
> +config PCI_I440FX
>      bool
>      select PCI
>      select PAM
> diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
> index a9cd3e022d..efd752b766 100644
> --- a/hw/pci-host/Makefile.objs
> +++ b/hw/pci-host/Makefile.objs
> @@ -13,7 +13,7 @@ common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o
>
>  common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
>  common-obj-$(CONFIG_FULONG) +=3D bonito.o
> -common-obj-$(CONFIG_PCI_PIIX) +=3D piix.o
> +common-obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
>  common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
>  common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gpex.o
>  common-obj-$(CONFIG_PCI_EXPRESS_XILINX) +=3D xilinx-pcie.o
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/i440fx.c
> similarity index 100%
> rename from hw/pci-host/piix.c
> rename to hw/pci-host/i440fx.c
> --
> 2.21.0
>
>
>

--000000000000b8c01d05952c080b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"ma=
ilto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;<br>
<br>
We moved all the PIIX3 southbridge code out of hw/pci-host/piix.c,<br>
it now only contains i440FX northbridge code.<br>
Rename it to match the chipset modelled.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0hw/i386/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 2 +-<br>
=C2=A0hw/pci-host/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 2 +-<br>
=C2=A0hw/pci-host/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0hw/pci-host/{piix.c =3D&gt; i440fx.c} | 0<br>
=C2=A05 files changed, 4 insertions(+), 4 deletions(-)<br>
=C2=A0rename hw/pci-host/{piix.c =3D&gt; i440fx.c} (100%)<br>
<br></blockquote><div><br></div><div><br></div><div><span style=3D"color:rg=
b(34,34,34);font-size:14px;line-height:22.1200008392334px">Reviewed-by: Ale=
ksandar Markovic &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" targe=
t=3D"_blank" style=3D"font-size:14px;line-height:22.1200008392334px">amarko=
vic@wavecomp.com</a><span style=3D"color:rgb(34,34,34);font-size:14px;line-=
height:22.1200008392334px">&gt;</span><br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 4845f47d93..1bc9959b8a 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -1225,7 +1225,7 @@ M: Marcel Apfelbaum &lt;<a href=3D"mailto:marcel.apfe=
lbaum@gmail.com">marcel.apfelbaum@gmail.com</a>&gt;<br>
=C2=A0S: Supported<br>
=C2=A0F: include/hw/i386/<br>
=C2=A0F: hw/i386/<br>
-F: hw/pci-host/piix.c<br>
+F: hw/pci-host/i440fx.c<br>
=C2=A0F: hw/pci-host/q35.c<br>
=C2=A0F: hw/pci-host/pam.c<br>
=C2=A0F: include/hw/pci-host/i440fx.h<br>
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig<br>
index 589d75e26a..cfe94aede7 100644<br>
--- a/hw/i386/Kconfig<br>
+++ b/hw/i386/Kconfig<br>
@@ -60,7 +60,7 @@ config I440FX<br>
=C2=A0 =C2=A0 =C2=A0select PC_PCI<br>
=C2=A0 =C2=A0 =C2=A0select PC_ACPI<br>
=C2=A0 =C2=A0 =C2=A0select ACPI_SMBUS<br>
-=C2=A0 =C2=A0 select PCI_PIIX<br>
+=C2=A0 =C2=A0 select PCI_I440FX<br>
=C2=A0 =C2=A0 =C2=A0select PIIX3<br>
=C2=A0 =C2=A0 =C2=A0select IDE_PIIX<br>
=C2=A0 =C2=A0 =C2=A0select DIMM<br>
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig<br>
index 397043b289..b0aa8351c4 100644<br>
--- a/hw/pci-host/Kconfig<br>
+++ b/hw/pci-host/Kconfig<br>
@@ -28,7 +28,7 @@ config PCI_SABRE<br>
=C2=A0 =C2=A0 =C2=A0select PCI<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
<br>
-config PCI_PIIX<br>
+config PCI_I440FX<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
=C2=A0 =C2=A0 =C2=A0select PCI<br>
=C2=A0 =C2=A0 =C2=A0select PAM<br>
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs<br>
index a9cd3e022d..efd752b766 100644<br>
--- a/hw/pci-host/Makefile.objs<br>
+++ b/hw/pci-host/Makefile.objs<br>
@@ -13,7 +13,7 @@ common-obj-$(CONFIG_VERSATILE_<wbr>PCI) +=3D versatile.o<=
br>
<br>
=C2=A0common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o<br>
=C2=A0common-obj-$(CONFIG_FULONG) +=3D bonito.o<br>
-common-obj-$(CONFIG_PCI_PIIX) +=3D piix.o<br>
+common-obj-$(CONFIG_PCI_<wbr>I440FX) +=3D i440fx.o<br>
=C2=A0common-obj-$(CONFIG_PCI_<wbr>EXPRESS_Q35) +=3D q35.o<br>
=C2=A0common-obj-$(CONFIG_PCI_<wbr>EXPRESS_GENERIC_BRIDGE) +=3D gpex.o<br>
=C2=A0common-obj-$(CONFIG_PCI_<wbr>EXPRESS_XILINX) +=3D xilinx-pcie.o<br>
diff --git a/hw/pci-host/piix.c b/hw/pci-host/i440fx.c<br>
similarity index 100%<br>
rename from hw/pci-host/piix.c<br>
rename to hw/pci-host/i440fx.c<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000b8c01d05952c080b--

