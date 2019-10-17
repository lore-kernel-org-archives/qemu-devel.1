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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D108FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0A121835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3kFa4mQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0A121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7ms-0008Cm-3G
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL73u-0001Ve-6r
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL73s-00082k-5z
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:47:34 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45971)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL73r-00082Z-W7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:47:32 -0400
Received: by mail-oi1-x241.google.com with SMTP id o205so2341704oib.12
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=EzzEwr9FQVQQWPxcF80oRuOq7A13UZrLWdbTGNDLsQI=;
 b=I3kFa4mQVyx9cakEkuuVnEjW+zknXAn5uU9pfD5J4LPFgIyxk+NCmgJMIOopPOVltV
 xrC5gfP8+w9KqfZS/YlsPhmnupxsDxZ9B3GRLiSPFmMZSBSFFj0Nb3IrBjWLKbw0T93o
 D/dDUo3dkeZDV2wVnijqzvBMeSo5gJxBgunmMGRLtdDaxlG+EpeNobWdjr1iPyYVs/ce
 JcmbguDrPS2CNM6lw+rzARYWuFGf0LqqK1qULuUzLldZc4LfmPRRlng74CB4hA262CaU
 M+nxlRE++iMVnm9D8Cq22Xj3IdZXCmMyWFZBjEmF12JNu6xoFLwpEYbMM+7HFtBYP9Ew
 +1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=EzzEwr9FQVQQWPxcF80oRuOq7A13UZrLWdbTGNDLsQI=;
 b=AggEQdwDT1uMCeALolYvOa/ud4nV9Ihs5F2BALG4spGFpIcmmlhfYt6U/yq97Zxduz
 3zFuYXbRdBpQqPD2mS1i5LeFoJnFn5PoC0iOzfe4VhBaIZfBUHeVMPLfV7YptEEVCWhV
 uxFP5pPGTtN8CK4Uh3EAl0obpjo1AtJCdruFtkr2Eay/sx5n3kPCfxPEd5e5oUS0+efO
 6ZfN4QrRBuXVR/hl5oU+VSLBeQSW/wn93DpLyzFpdXD0/K+8MAqBfUovfgRfRfg6DBXM
 BE3L4A7j2mye1/K2Rk8UJZfTM7Mua9HivrnMMF35pzFdRJKvxffFyVQb8OMyn6dTsPCu
 fnng==
X-Gm-Message-State: APjAAAX9EsMNU4d/vxLJoaLSEsZPurgE65ge9cF8qV6elvJVgaGHDXVZ
 9Z0jtslNEtaIx1XrG2gwa3EgP0E4naeJ2onQVf8=
X-Google-Smtp-Source: APXvYqwSdE8G2wWLz4cypVP6rw4ZrgSMSmoShd4nguDWg5TFoNi6YWVRbEVL2kFXt9Wlwh1muuDyL24IxtmP5S3/hQk=
X-Received: by 2002:aca:62d5:: with SMTP id w204mr3561597oib.136.1571323651309; 
 Thu, 17 Oct 2019 07:47:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 07:47:30
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-20-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-20-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 16:47:30 +0200
Message-ID: <CAL1e-=ghBWM7XP8Q8Wpe3_iz0sr7zEcXVA=ZzexCpXc_Chz13Q@mail.gmail.com>
Subject: Re: [PATCH 19/32] hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000010443805951c4c4c"
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

--00000000000010443805951c4c4c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Now that we properly refactored the piix4_create() function, let's
> move it to hw/isa/piix4.c where it belongs, so it can be reused
> on other places.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/isa/piix4.c                | 30 ++++++++++++++++++++++++++++++
>  hw/mips/gt64xxx_pci.c         |  1 +
>  hw/mips/mips_malta.c          | 28 ----------------------------
>  include/hw/i386/pc.h          |  2 --
>  include/hw/southbridge/piix.h |  6 ++++++
>  5 files changed, 37 insertions(+), 30 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>



> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 9f554747af..d90899e122 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -27,12 +27,14 @@
>  #include "qapi/error.h"
>  #include "hw/irq.h"
>  #include "hw/i386/pc.h"
> +#include "hw/southbridge/piix.h"
>  #include "hw/pci/pci.h"
>  #include "hw/isa/isa.h"
>  #include "hw/sysbus.h"
>  #include "hw/dma/i8257.h"
>  #include "hw/timer/i8254.h"
>  #include "hw/timer/mc146818rtc.h"
> +#include "hw/ide.h"
>  #include "migration/vmstate.h"
>  #include "sysemu/reset.h"
>  #include "sysemu/runstate.h"
> @@ -234,3 +236,31 @@ static void piix4_register_types(void)
>  }
>
>  type_init(piix4_register_types)
> +
> +DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
> +                          I2CBus **smbus, size_t ide_buses)
> +{
> +    size_t ide_drives =3D ide_buses * MAX_IDE_DEVS;
> +    DriveInfo **hd;
> +    PCIDevice *pci;
> +    DeviceState *dev;
> +
> +    pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
> +                                          true, TYPE_PIIX4_PCI_DEVICE);
> +    dev =3D DEVICE(pci);
> +    if (isa_bus) {
> +        *isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
> +    }
> +
> +    hd =3D g_new(DriveInfo *, ide_drives);
> +    ide_drive_get(hd, ide_drives);
> +    pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
> +    g_free(hd);
> +    pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
> +    if (smbus) {
> +        *smbus =3D piix4_pm_init(pci_bus, pci->devfn + 3, 0x1100,
> +                               isa_get_irq(NULL, 9), NULL, 0, NULL);
> +   }
> +
> +    return dev;
> +}
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index f325bd6c1c..c277398c0d 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -28,6 +28,7 @@
>  #include "hw/mips/mips.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_host.h"
> +#include "hw/southbridge/piix.h"
>  #include "migration/vmstate.h"
>  #include "hw/i386/pc.h"
>  #include "hw/irq.h"
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 0d4312840b..477a4725c0 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1210,34 +1210,6 @@ static void mips_create_cpu(MachineState *ms,
> MaltaState *s,
>      }
>  }
>
> -static DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
> -                                 I2CBus **smbus, size_t ide_buses)
> -{
> -    const size_t ide_drives =3D ide_buses * MAX_IDE_DEVS;
> -    DriveInfo **hd;
> -    PCIDevice *pci;
> -    DeviceState *dev;
> -
> -    pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
> -                                          true, TYPE_PIIX4_PCI_DEVICE);
> -    dev =3D DEVICE(pci);
> -    if (isa_bus) {
> -        *isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
> -    }
> -
> -    hd =3D g_new(DriveInfo *, ide_drives);
> -    ide_drive_get(hd, ide_drives);
> -    pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
> -    g_free(hd);
> -    pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
> -    if (smbus) {
> -        *smbus =3D piix4_pm_init(pci_bus, pci->devfn + 3, 0x1100,
> -                               isa_get_irq(NULL, 9), NULL, 0, NULL);
> -   }
> -
> -    return dev;
> -}
> -
>  static
>  void mips_malta_init(MachineState *machine)
>  {
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index c671c9fd2a..b63fc7631e 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -274,8 +274,6 @@ PCIBus *i440fx_init(const char *host_type, const char
> *pci_type,
>                      MemoryRegion *ram_memory);
>
>  PCIBus *find_i440fx(void);
> -/* piix4.c */
> -extern PCIDevice *piix4_dev;
>
>  /* pc_sysfw.c */
>  void pc_system_flash_create(PCMachineState *pcms);
> diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.=
h
> index b8ce26fec4..add352456b 100644
> --- a/include/hw/southbridge/piix.h
> +++ b/include/hw/southbridge/piix.h
> @@ -2,6 +2,7 @@
>   * QEMU PIIX South Bridge Emulation
>   *
>   * Copyright (c) 2006 Fabrice Bellard
> + * Copyright (c) 2018 Herv=C3=A9 Poussineau
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
>   * See the COPYING file in the top-level directory.
> @@ -17,4 +18,9 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t
> smb_io_base,
>                        qemu_irq sci_irq, qemu_irq smi_irq,
>                        int smm_enabled, DeviceState **piix4_pm);
>
> +extern PCIDevice *piix4_dev;
> +
> +DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
> +                          I2CBus **smbus, size_t ide_buses);
> +
>  #endif
> --
> 2.21.0
>
>
>

--00000000000010443805951c4c4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"ma=
ilto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;<br>
<br>
Now that we properly refactored the piix4_create() function, let&#39;s<br>
move it to hw/isa/piix4.c where it belongs, so it can be reused<br>
on other places.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/isa/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 30 ++++++++++++++++++++++++++++++<br>
=C2=A0hw/mips/gt64xxx_pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br=
>
=C2=A0hw/mips/mips_malta.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 28 ---------=
-------------------<br>
=C2=A0include/hw/i386/pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 --<b=
r>
=C2=A0include/hw/southbridge/piix.h |=C2=A0 6 ++++++<br>
=C2=A05 files changed, 37 insertions(+), 30 deletions(-)<br>
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
index 9f554747af..d90899e122 100644<br>
--- a/hw/isa/piix4.c<br>
+++ b/hw/isa/piix4.c<br>
@@ -27,12 +27,14 @@<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/i386/pc.h&quot;<br>
+#include &quot;hw/southbridge/piix.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci.h&quot;<br>
=C2=A0#include &quot;hw/isa/isa.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;hw/dma/i8257.h&quot;<br>
=C2=A0#include &quot;hw/timer/i8254.h&quot;<br>
=C2=A0#include &quot;hw/timer/mc146818rtc.h&quot;<br>
+#include &quot;hw/ide.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;sysemu/reset.h&quot;<br>
=C2=A0#include &quot;sysemu/runstate.h&quot;<br>
@@ -234,3 +236,31 @@ static void piix4_register_types(void)<br>
=C2=A0}<br>
<br>
=C2=A0type_init(piix4_register_<wbr>types)<br>
+<br>
+DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 I2CBus **smbus, size_t ide_buses)<br>
+{<br>
+=C2=A0 =C2=A0 size_t ide_drives =3D ide_buses * MAX_IDE_DEVS;<br>
+=C2=A0 =C2=A0 DriveInfo **hd;<br>
+=C2=A0 =C2=A0 PCIDevice *pci;<br>
+=C2=A0 =C2=A0 DeviceState *dev;<br>
+<br>
+=C2=A0 =C2=A0 pci =3D pci_create_simple_<wbr>multifunction(pci_bus, PCI_DE=
VFN(10, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t=
rue, TYPE_PIIX4_PCI_DEVICE);<br>
+=C2=A0 =C2=A0 dev =3D DEVICE(pci);<br>
+=C2=A0 =C2=A0 if (isa_bus) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *isa_bus =3D ISA_BUS(qdev_get_child_bus(<wbr>d=
ev, &quot;isa.0&quot;));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 hd =3D g_new(DriveInfo *, ide_drives);<br>
+=C2=A0 =C2=A0 ide_drive_get(hd, ide_drives);<br>
+=C2=A0 =C2=A0 pci_piix4_ide_init(pci_bus, hd, pci-&gt;devfn + 1);<br>
+=C2=A0 =C2=A0 g_free(hd);<br>
+=C2=A0 =C2=A0 pci_create_simple(pci_bus, pci-&gt;devfn + 2, &quot;piix4-us=
b-uhci&quot;);<br>
+=C2=A0 =C2=A0 if (smbus) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *smbus =3D piix4_pm_init(pci_bus, pci-&gt;devf=
n + 3, 0x1100,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isa_get_irq(NULL, 9), NULL, 0, NULL);=
<br>
+=C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 return dev;<br>
+}<br>
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c<br>
index f325bd6c1c..c277398c0d 100644<br>
--- a/hw/mips/gt64xxx_pci.c<br>
+++ b/hw/mips/gt64xxx_pci.c<br>
@@ -28,6 +28,7 @@<br>
=C2=A0#include &quot;hw/mips/mips.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci_host.h&quot;<br>
+#include &quot;hw/southbridge/piix.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;hw/i386/pc.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c<br>
index 0d4312840b..477a4725c0 100644<br>
--- a/hw/mips/mips_malta.c<br>
+++ b/hw/mips/mips_malta.c<br>
@@ -1210,34 +1210,6 @@ static void mips_create_cpu(MachineState *ms, MaltaS=
tate *s,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I2CBus **smbus, size_t ide_bus=
es)<br>
-{<br>
-=C2=A0 =C2=A0 const size_t ide_drives =3D ide_buses * MAX_IDE_DEVS;<br>
-=C2=A0 =C2=A0 DriveInfo **hd;<br>
-=C2=A0 =C2=A0 PCIDevice *pci;<br>
-=C2=A0 =C2=A0 DeviceState *dev;<br>
-<br>
-=C2=A0 =C2=A0 pci =3D pci_create_simple_<wbr>multifunction(pci_bus, PCI_DE=
VFN(10, 0),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t=
rue, TYPE_PIIX4_PCI_DEVICE);<br>
-=C2=A0 =C2=A0 dev =3D DEVICE(pci);<br>
-=C2=A0 =C2=A0 if (isa_bus) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *isa_bus =3D ISA_BUS(qdev_get_child_bus(<wbr>d=
ev, &quot;isa.0&quot;));<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 hd =3D g_new(DriveInfo *, ide_drives);<br>
-=C2=A0 =C2=A0 ide_drive_get(hd, ide_drives);<br>
-=C2=A0 =C2=A0 pci_piix4_ide_init(pci_bus, hd, pci-&gt;devfn + 1);<br>
-=C2=A0 =C2=A0 g_free(hd);<br>
-=C2=A0 =C2=A0 pci_create_simple(pci_bus, pci-&gt;devfn + 2, &quot;piix4-us=
b-uhci&quot;);<br>
-=C2=A0 =C2=A0 if (smbus) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *smbus =3D piix4_pm_init(pci_bus, pci-&gt;devf=
n + 3, 0x1100,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isa_get_irq(NULL, 9), NULL, 0, NULL);=
<br>
-=C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 return dev;<br>
-}<br>
-<br>
=C2=A0static<br>
=C2=A0void mips_malta_init(MachineState *machine)<br>
=C2=A0{<br>
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h<br>
index c671c9fd2a..b63fc7631e 100644<br>
--- a/include/hw/i386/pc.h<br>
+++ b/include/hw/i386/pc.h<br>
@@ -274,8 +274,6 @@ PCIBus *i440fx_init(const char *host_type, const char *=
pci_type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0MemoryRegion *ram_memory);<br>
<br>
=C2=A0PCIBus *find_i440fx(void);<br>
-/* piix4.c */<br>
-extern PCIDevice *piix4_dev;<br>
<br>
=C2=A0/* pc_sysfw.c */<br>
=C2=A0void pc_system_flash_create(<wbr>PCMachineState *pcms);<br>
diff --git a/include/hw/southbridge/piix.<wbr>h b/include/hw/southbridge/pi=
ix.<wbr>h<br>
index b8ce26fec4..add352456b 100644<br>
--- a/include/hw/southbridge/piix.<wbr>h<br>
+++ b/include/hw/southbridge/piix.<wbr>h<br>
@@ -2,6 +2,7 @@<br>
=C2=A0 * QEMU PIIX South Bridge Emulation<br>
=C2=A0 *<br>
=C2=A0 * Copyright (c) 2006 Fabrice Bellard<br>
+ * Copyright (c) 2018 Herv=C3=A9 Poussineau<br>
=C2=A0 *<br>
=C2=A0 * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
=C2=A0 * See the COPYING file in the top-level directory.<br>
@@ -17,4 +18,9 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t sm=
b_io_base,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0qemu_irq sci_irq, qemu_irq smi_irq,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int smm_enabled, DeviceState **piix4_pm);<br>
<br>
+extern PCIDevice *piix4_dev;<br>
+<br>
+DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 I2CBus **smbus, size_t ide_buses);<br>
+<br>
=C2=A0#endif<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--00000000000010443805951c4c4c--

