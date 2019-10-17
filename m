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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F567FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD47721835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnLIZGf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD47721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL89x-0006Fy-Ok
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL7LR-0007wY-EJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL7LP-0007pD-Sj
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:05:41 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL7LP-0007op-IS
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:05:39 -0400
Received: by mail-ot1-x342.google.com with SMTP id 41so2146422oti.12
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=7LaYtff+/Kv18UTa0H5mwJqrAwMfKjyjGBjo3y9guK8=;
 b=hnLIZGf9Dq0UjT8iQADDZhHiB/dTLe+xNZ0M0PCVmPtXB0M7+h6taH/reUqIqD06H1
 QomSxUvW2hlCmRDTMB3RZ9W7qfpYqSuvEQP+RqweQFP7A8n6mJxPjaL1VSBmf4iQXkyw
 o8pxkJX9icbbQJERT+uk/wSZBN6zKIREbgk8Q71//ymdgZS1Sh8Jy4/996SkbzkP/NKG
 WWBf4tY0eP3XCL1dOEOB36L0ClTvK3F9KyZLY5TCrtaMhh1RoUnCniZl/9nv1D5MVs+2
 b70dWIRhyTm6wIz0ORTAGFb9pfFT7EEknYNgPa8imJrQqH3mKHkr8SQ6V0/iaza7vokg
 VzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=7LaYtff+/Kv18UTa0H5mwJqrAwMfKjyjGBjo3y9guK8=;
 b=ImaXm2ycxpEi++WzLqO+dmJJfLV6BF0hVhruNVR0S3n8URD4nfp3g8n9NvVPG+D0x+
 AugRKpenXeL8DM/vG2HCPgXDZgl3EKi31iKm/nylRSRsKFt7iDNy/pP/8i35Uc6xMEr4
 niCe7FLSMehtQqNW746nkmQ/yKO40MyvvTW92HoKHicdflwZFjnTfcU6gReX64EgUK1H
 wBMEH1g0EtEFNobbxdkobvRMtlPAUQgw8BkyxlAB063NV0lkAdugSVmeHtWtX4Vz0sww
 MGCaOIU3zZN0ohBkOT5KXYTnCTrrvOxhcuXrMeW62lZht63w0qxFxY3Ab9yiBbyCBpNl
 oojA==
X-Gm-Message-State: APjAAAUhBPBG3U8R/8zFiu5gjS15OAedKa/jVbORzSfwdNDZ+S2/NC04
 +ONYyc8PEHfJRevFQ8mMO0AXdycHjSGkUQSQj0w=
X-Google-Smtp-Source: APXvYqw+ceKkhpC+kRj5EkQDhwPRisBC8MFzHPsh+ib7vBZ7LB6XkyVQ1KCb7w7u5pI7mDXPxrKh6Im+jAjz8xlJQzE=
X-Received: by 2002:a05:6830:1d8f:: with SMTP id
 y15mr3255659oti.121.1571324738696; 
 Thu, 17 Oct 2019 08:05:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 08:05:37
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-10-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-10-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 17:05:37 +0200
Message-ID: <CAL1e-=hSzG5F7hjsRgo_y6M0aCoJ0Uj6vR86nWkf=aQ2S3Yz7w@mail.gmail.com>
Subject: Re: [PATCH 09/32] piix4: add Reset Control Register
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e079fd05951c8c13"
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

--000000000000e079fd05951c8c13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>
> The RCR I/O port (0xcf9) is used to generate a hard reset or a soft reset=
.
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Message-Id: <20171216090228.28505-7-hpoussin@reactos.org>
> [PMD: rebased, updated includes]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/isa/piix4.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>



> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 4202243e41..6e2d9b9774 100644
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
> @@ -29,11 +30,16 @@
>  #include "hw/sysbus.h"
>  #include "migration/vmstate.h"
>  #include "sysemu/reset.h"
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
> @@ -88,6 +94,34 @@ static const VMStateDescription vmstate_piix4 =3D {
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
> +    s->rcr =3D val & 2; /* keep System Reset type only */
> +}
> +
> +static uint64_t piix4_rcr_read(void *opaque, hwaddr addr, unsigned int
> len)
> +{
> +    PIIX4State *s =3D opaque;
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
>  static void piix4_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      DeviceState *dev =3D DEVICE(pci_dev);
> @@ -97,6 +131,12 @@ static void piix4_realize(PCIDevice *pci_dev, Error
> **errp)
>                       pci_address_space_io(pci_dev), errp)) {
>          return;
>      }
> +
> +    memory_region_init_io(&s->rcr_mem, OBJECT(dev), &piix4_rcr_ops, s,
> +                          "reset-control", 1);
> +    memory_region_add_subregion_overlap(pci_address_space_io(pci_dev),
> 0xcf9,
> +                                        &s->rcr_mem, 1);
> +
>      piix4_dev =3D pci_dev;
>      qemu_register_reset(piix4_reset, s);
>  }
> --
> 2.21.0
>
>
>

--000000000000e079fd05951c8c13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">From: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:h=
poussin@reactos.org">hpoussin@reactos.org</a>&gt;<br>
<br>
The RCR I/O port (0xcf9) is used to generate a hard reset or a soft reset.<=
br>
<br>
Acked-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redh=
at.com</a>&gt;<br>
Acked-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini=
@redhat.com</a>&gt;<br>
Signed-off-by: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos=
.org">hpoussin@reactos.org</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20171216090228.28505-7-hpoussin@reactos.o=
rg">20171216090228.28505-7-hpoussin@reactos.org</a>&gt;<br>
[PMD: rebased, updated includes]<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/isa/piix4.c | 40 ++++++++++++++++++++++++++++++<wbr>++++++++++<br>
=C2=A01 file changed, 40 insertions(+)<br>
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
index 4202243e41..6e2d9b9774 100644<br>
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
@@ -29,11 +30,16 @@<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;sysemu/reset.h&quot;<br>
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
@@ -88,6 +94,34 @@ static const VMStateDescription vmstate_piix4 =3D {<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_system_reset_request(<wbr>SHUTDOWN_CAUSE_=
GUEST_RESET);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 s-&gt;rcr =3D val &amp; 2; /* keep System Reset type only */=
<br>
+}<br>
+<br>
+static uint64_t piix4_rcr_read(void *opaque, hwaddr addr, unsigned int len=
)<br>
+{<br>
+=C2=A0 =C2=A0 PIIX4State *s =3D opaque;<br>
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
=C2=A0static void piix4_realize(PCIDevice *pci_dev, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceState *dev =3D DEVICE(pci_dev);<br>
@@ -97,6 +131,12 @@ static void piix4_realize(PCIDevice *pci_dev, Error **e=
rrp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pci_address_space_io(pci_dev), errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;rcr_<wbr>mem, OBJECT(dev), =
&amp;piix4_rcr_ops, s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;reset-control&quot;, 1);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion_<wbr>overlap(pci_address_space_i=
o(<wbr>pci_dev), 0xcf9,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&=
gt;rcr_mem, 1);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0piix4_dev =3D pci_dev;<br>
=C2=A0 =C2=A0 =C2=A0qemu_register_reset(piix4_<wbr>reset, s);<br>
=C2=A0}<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000e079fd05951c8c13--

