Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5386CA9EAE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 01:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F6D21928
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 01:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr7HrPL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F6D21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMMTF-0007Mm-F6
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 21:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iMMSV-0006pz-9f
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 21:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iMMST-0000h9-Qp
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 21:26:07 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38241)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iMMST-0000g8-LS
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 21:26:05 -0400
Received: by mail-ot1-x342.google.com with SMTP id e11so9594452otl.5
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2019 18:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bO2YErnw83aMmUMvYqh7FWJix6R/c/U/xMxZjC1Pm2E=;
 b=Rr7HrPL5fkrwZVAf+xGhqY+IpW9v5mK3nkTl0cx0d8Eq2waiLlJLVxCNZj2mxBcC6k
 fkhyTxaOmpLnZXi46wUk8BizdWSnOp7pRmBGxAyajgnFk6ikteqTKy/XfCKJJP3L0OTK
 n3nHFt9nQkCbnx/s/NBDf9WJNB8o/ap2VM5Ek3cerhiPBZ4CVIoGTh7VRI0FC8nID0Y+
 36HqYuzK3xnBdY6zb3zOqpdRIan/WH9aWJYgcaU8076owUn6u0O1xckGFJblmdTeCWPe
 l8grDu4HW6szObsx+pcra2FDMEfYFLoC5Mn5miqdvsMF5kugHGGl3R2K8GEmztOtry6v
 Ybsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bO2YErnw83aMmUMvYqh7FWJix6R/c/U/xMxZjC1Pm2E=;
 b=rfHZekuNrN6eehb+sAHWjA80R2ZMrdfbxJ17Ztob1JwHrq2e5O8cUgJMHmRxyiRhu6
 ntpJCXLI10yD3gfsrKjtm5paMniTTm49oj5Bk2yMu4R4fbWA5tz3+B59LzcV4OklF1b1
 m0y5aj2TQCrolMhApGrP2ymGmZD6qwzJ8w5t7BG8UkhEZofmpJrX759mMdJ3umY4qWyi
 RzKGog6EywlLllPncHmeObRpP7/ETDyw27psoPZhw+c2H3CtRxuaFbN0rzgBbPmPbHCF
 xs3hD7Tsrx1gTitDb/B/CKxZe1Tho3cezSTNRm8J9CZtZBjAtuBVmNM47y9X/AtCP5kG
 o8ZA==
X-Gm-Message-State: APjAAAVZrK/WKqsiRx7g0kKgcfVY6OE01vA8imjOhy34cS8/dH0dfwSa
 eumC8s75yS7/BbnfTGTFpUsZXcLjxBeQuN8Yado=
X-Google-Smtp-Source: APXvYqyH+hVNJulY3xClZobG5K49OV/GwgIf315EUTBGXs7JYYBrQQigP1UwnpW++Fn0p83oUnaqDs3ZPfJAQF5pjhE=
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr14753485otr.194.1571621162497; 
 Sun, 20 Oct 2019 18:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-3-philmd@redhat.com>
In-Reply-To: <20191018134754.16362-3-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 21 Oct 2019 09:25:26 +0800
Message-ID: <CAKXe6SKQGYj+N04An+t5sP4jVkpEpmmGGfpZxb5VAV+w3owsBw@mail.gmail.com>
Subject: Re: [PATCH v2 02/20] piix4: Add the Reset Control Register
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001cba5805956191a8"
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001cba5805956191a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=8818=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:50=E5=86=99=E9=81=
=93=EF=BC=9A

> From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>
> The RCR I/O port (0xcf9) is used to generate a hard reset or a soft reset=
.
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Message-Id: <20171216090228.28505-7-hpoussin@reactos.org>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> [PMD: rebased, updated includes]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/isa/piix4.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 890d999abf..d0b18e0586 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -2,6 +2,7 @@
>   * QEMU PIIX4 PCI Bridge Emulation
>   *
>   * Copyright (c) 2006 Fabrice Bellard
> + * Copyright (c) 2018 Herv=C3=A9 Poussineau
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining
> a copy
>   * of this software and associated documentation files (the "Software"),
> to deal
> @@ -28,11 +29,17 @@
>  #include "hw/isa/isa.h"
>  #include "hw/sysbus.h"
>  #include "migration/vmstate.h"
> +#include "sysemu/reset.h"
> +#include "sysemu/runstate.h"
>
>  PCIDevice *piix4_dev;
>
>  typedef struct PIIX4State {
>      PCIDevice dev;
> +
> +    /* Reset Control Register */
> +    MemoryRegion rcr_mem;
> +    uint8_t rcr;
>  } PIIX4State;
>
>  #define TYPE_PIIX4_PCI_DEVICE "PIIX4"
> @@ -87,15 +94,51 @@ static const VMStateDescription vmstate_piix4 =3D {
>      }
>  };
>
> +static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,
> +                            unsigned int len)
> +{
> +    PIIX4State *s =3D opaque;
> +
> +    if (val & 4) {
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        return;
> +    }
> +
> +    s->rcr =3D val & 2; /* keep System Reset type only */
> +}
> +
> +static uint64_t piix4_rcr_read(void *opaque, hwaddr addr, unsigned int
> len)
> +{
> +    PIIX4State *s =3D opaque;
> +
> +    return s->rcr;
> +}
> +
> +static const MemoryRegionOps piix4_rcr_ops =3D {
> +    .read =3D piix4_rcr_read,
> +    .write =3D piix4_rcr_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 1,
> +    },
> +};
> +
>  static void piix4_realize(PCIDevice *dev, Error **errp)
>  {
> -    PIIX4State *d =3D PIIX4_PCI_DEVICE(dev);
> +    PIIX4State *s =3D PIIX4_PCI_DEVICE(dev);
>
> -    if (!isa_bus_new(DEVICE(d), pci_address_space(dev),
> +    if (!isa_bus_new(DEVICE(dev), pci_address_space(dev),
>                       pci_address_space_io(dev), errp)) {
>          return;
>      }
> -    piix4_dev =3D &d->dev;
> +
> +    memory_region_init_io(&s->rcr_mem, OBJECT(dev), &piix4_rcr_ops, s,
> +                          "reset-control", 1);
> +    memory_region_add_subregion_overlap(pci_address_space_io(dev), 0xcf9=
,
>


Can we use 'RCR_IOPORT' instead of constant value here? Also don't see this
change
in later patches of this seirals.
Anyway

Reviewed-by: Li Qiang <liq3ea@gmail.com>

Thanks,
Li Qiang


> +                                        &s->rcr_mem, 1);
> +
> +    piix4_dev =3D dev;
>  }
>
>  int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
> --
> 2.21.0
>
>
>

--0000000000001cba5805956191a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=8818=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:50=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">From: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos.or=
g" target=3D"_blank">hpoussin@reactos.org</a>&gt;<br>
<br>
The RCR I/O port (0xcf9) is used to generate a hard reset or a soft reset.<=
br>
<br>
Acked-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a>&gt;<br>
Acked-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=
=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
Signed-off-by: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos=
.org" target=3D"_blank">hpoussin@reactos.org</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20171216090228.28505-7-hpoussin@reactos.o=
rg" target=3D"_blank">20171216090228.28505-7-hpoussin@reactos.org</a>&gt;<b=
r>
Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.c=
om" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
[PMD: rebased, updated includes]<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/isa/piix4.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---=
<br>
=C2=A01 file changed, 46 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c<br>
index 890d999abf..d0b18e0586 100644<br>
--- a/hw/isa/piix4.c<br>
+++ b/hw/isa/piix4.c<br>
@@ -2,6 +2,7 @@<br>
=C2=A0 * QEMU PIIX4 PCI Bridge Emulation<br>
=C2=A0 *<br>
=C2=A0 * Copyright (c) 2006 Fabrice Bellard<br>
+ * Copyright (c) 2018 Herv=C3=A9 Poussineau<br>
=C2=A0 *<br>
=C2=A0 * Permission is hereby granted, free of charge, to any person obtain=
ing a copy<br>
=C2=A0 * of this software and associated documentation files (the &quot;Sof=
tware&quot;), to deal<br>
@@ -28,11 +29,17 @@<br>
=C2=A0#include &quot;hw/isa/isa.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
+#include &quot;sysemu/reset.h&quot;<br>
+#include &quot;sysemu/runstate.h&quot;<br>
<br>
=C2=A0PCIDevice *piix4_dev;<br>
<br>
=C2=A0typedef struct PIIX4State {<br>
=C2=A0 =C2=A0 =C2=A0PCIDevice dev;<br>
+<br>
+=C2=A0 =C2=A0 /* Reset Control Register */<br>
+=C2=A0 =C2=A0 MemoryRegion rcr_mem;<br>
+=C2=A0 =C2=A0 uint8_t rcr;<br>
=C2=A0} PIIX4State;<br>
<br>
=C2=A0#define TYPE_PIIX4_PCI_DEVICE &quot;PIIX4&quot;<br>
@@ -87,15 +94,51 @@ static const VMStateDescription vmstate_piix4 =3D {<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
<br>
+static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int len)<br>
+{<br>
+=C2=A0 =C2=A0 PIIX4State *s =3D opaque;<br>
+<br>
+=C2=A0 =C2=A0 if (val &amp; 4) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST=
_RESET);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;rcr =3D val &amp; 2; /* keep System Reset type only */=
<br>
+}<br>
+<br>
+static uint64_t piix4_rcr_read(void *opaque, hwaddr addr, unsigned int len=
)<br>
+{<br>
+=C2=A0 =C2=A0 PIIX4State *s =3D opaque;<br>
+<br>
+=C2=A0 =C2=A0 return s-&gt;rcr;<br>
+}<br>
+<br>
+static const MemoryRegionOps piix4_rcr_ops =3D {<br>
+=C2=A0 =C2=A0 .read =3D piix4_rcr_read,<br>
+=C2=A0 =C2=A0 .write =3D piix4_rcr_write,<br>
+=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
+=C2=A0 =C2=A0 .impl =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 1,<br>
+=C2=A0 =C2=A0 },<br>
+};<br>
+<br>
=C2=A0static void piix4_realize(PCIDevice *dev, Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 PIIX4State *d =3D PIIX4_PCI_DEVICE(dev);<br>
+=C2=A0 =C2=A0 PIIX4State *s =3D PIIX4_PCI_DEVICE(dev);<br>
<br>
-=C2=A0 =C2=A0 if (!isa_bus_new(DEVICE(d), pci_address_space(dev),<br>
+=C2=A0 =C2=A0 if (!isa_bus_new(DEVICE(dev), pci_address_space(dev),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pci_address_space_io(dev), errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 piix4_dev =3D &amp;d-&gt;dev;<br>
+<br>
+=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;rcr_mem, OBJECT(dev), &amp;=
piix4_rcr_ops, s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;reset-control&quot;, 1);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion_overlap(pci_address_space_io(dev=
), 0xcf9,<br></blockquote><div><br></div><div><br></div><div>Can we use &#3=
9;RCR_IOPORT&#39; instead of constant value here? Also don&#39;t see this c=
hange</div><div>in later patches of this seirals.</div><div>Anyway</div><di=
v><br></div><div>Reviewed-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@gmail.c=
om">liq3ea@gmail.com</a>&gt;<br></div><div><br></div><div>Thanks,</div><div=
>Li Qiang</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&=
gt;rcr_mem, 1);<br>
+<br>
+=C2=A0 =C2=A0 piix4_dev =3D dev;<br>
=C2=A0}<br>
<br>
=C2=A0int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote></div></div>

--0000000000001cba5805956191a8--

