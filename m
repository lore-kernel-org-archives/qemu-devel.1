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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F54BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3212053B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfhIuGJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3212053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZWj-0003o9-EM
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iMZTH-0000cD-Un
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iMZTG-0004OM-H6
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:19:47 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iMZTG-0004O7-9r
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:19:46 -0400
Received: by mail-ot1-x344.google.com with SMTP id o44so11311430ota.10
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tz6w0C48MWIa2WMtQyrTIW8Jxx5xZ4x8upKdmxdEPCc=;
 b=DfhIuGJEx+vfA13FAI+Kr0BxOUsjcfZvOgUyPWuZkigj8gPhZEalxZXBA/x+e6emuc
 rOgs59mC5Ge+/sLvorLtiX0L8qAuVzhoPI9V+20I9MfDKmoPMB1HLBRkOrY5Ewvs0lfF
 CsMV7W6SfU5her6r6hJc62PsM12uQJvqpJ8SSlwXVBAZ97W2akETwHqxHl2CULSpna5p
 DWV3IMoG/CNE2QCzY4MlJZ3hoCwCZH5gmcC1BSiCfXKgtJ4JBWZJbJy14mvhXmOQMrJJ
 v9uY0BB0Lg/xP9qd0HqQ6ppAuveWyTIojQW+YORWGQl29zMQyZrjiyCMocSOaA5nMz/T
 0EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tz6w0C48MWIa2WMtQyrTIW8Jxx5xZ4x8upKdmxdEPCc=;
 b=RMMDq7P0E1unQ6kFqftdl4ZyRSZ5FefuBg40DG9ZjVbKNm4NMcIiQ0KOHBrE6owK25
 QShdjn1gYVZueyfXFPgqWSoeNwbXh9Y7j811evANRhCZdbZVizux884UgPKBBrYyK7UA
 k5b9+7Ar1AaEewzYkMLHanr06L4+VWGeCij3aqrURM2ThmbUVG27PzFql3s6zK4YFjsG
 ma+i74APIABlsDnbGPsjOcQ3h7kFsqKo1BVB9P4EhwA0WJx2SYnPs0hZ+MkDBGRu/p4E
 VJX00IDEdPn8AmH6RzrLGuWsUN68ZxZtpSd5k5CUlvXiXe2lHZ1HMUBbU2cRxL5Ilh6D
 W+kg==
X-Gm-Message-State: APjAAAVI/1bRT6iWk/kNkEN6dTnQPiiZl8Cj/pSkn6W51AzpC1LcWk+/
 UjhE2dmB+Ik6gS9i9URQDsPImMBPTB5cmXfcpmycjslkk6I=
X-Google-Smtp-Source: APXvYqy5B/+fp2AkMQJfPvSCGas9eFYhRWvfZlNsu8RTN1A3+HXPZLn2tBpGzNIYeEMNTibUlnYoA0vhzkxd2+pIJ3k=
X-Received: by 2002:a9d:3ec:: with SMTP id f99mr17836427otf.353.1571671185421; 
 Mon, 21 Oct 2019 08:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-6-philmd@redhat.com>
In-Reply-To: <20191018134754.16362-6-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 21 Oct 2019 23:19:08 +0800
Message-ID: <CAKXe6SJOgYN-FeDw8O-e7iBta+OztK4OxJJ73ESmnY+wDB6jAw@mail.gmail.com>
Subject: Re: [PATCH v2 05/20] piix4: Rename PIIX4 object to piix4-isa
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b61af105956d3602"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
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

--000000000000b61af105956d3602
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=8818=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:53=E5=86=99=E9=81=
=93=EF=BC=9A

> From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>
> Other piix4 parts are already named piix4-ide and piix4-usb-uhci.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Message-Id: <20171216090228.28505-15-hpoussin@reactos.org>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> [PMD: rebased]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>


Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/isa/piix4.c       | 1 -
>  hw/mips/mips_malta.c | 2 +-
>  include/hw/isa/isa.h | 2 ++
>  3 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 9c37c85ae2..ac9383a658 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -45,7 +45,6 @@ typedef struct PIIX4State {
>      uint8_t rcr;
>  } PIIX4State;
>
> -#define TYPE_PIIX4_PCI_DEVICE "PIIX4"
>  #define PIIX4_PCI_DEVICE(obj) \
>      OBJECT_CHECK(PIIX4State, (obj), TYPE_PIIX4_PCI_DEVICE)
>
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 7d25ab6c23..e499b7a6bb 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1414,7 +1414,7 @@ void mips_malta_init(MachineState *machine)
>      ide_drive_get(hd, ARRAY_SIZE(hd));
>
>      pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
> -                                          true, "PIIX4");
> +                                          true, TYPE_PIIX4_PCI_DEVICE);
>      dev =3D DEVICE(pci);
>      isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
>      piix4_devfn =3D pci->devfn;
> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
> index 018ada4f6f..79f703fd6c 100644
> --- a/include/hw/isa/isa.h
> +++ b/include/hw/isa/isa.h
> @@ -147,4 +147,6 @@ static inline ISABus *isa_bus_from_device(ISADevice *=
d)
>      return ISA_BUS(qdev_get_parent_bus(DEVICE(d)));
>  }
>
> +#define TYPE_PIIX4_PCI_DEVICE "piix4-isa"
> +
>  #endif
> --
> 2.21.0
>
>
>

--000000000000b61af105956d3602
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=8818=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:53=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">From: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos.or=
g" target=3D"_blank">hpoussin@reactos.org</a>&gt;<br>
<br>
Other piix4 parts are already named piix4-ide and piix4-usb-uhci.<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.=
org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
Acked-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a>&gt;<br>
Acked-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=
=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
Signed-off-by: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos=
.org" target=3D"_blank">hpoussin@reactos.org</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20171216090228.28505-15-hpoussin@reactos.=
org" target=3D"_blank">20171216090228.28505-15-hpoussin@reactos.org</a>&gt;=
<br>
Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.c=
om" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
[PMD: rebased]<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div><br></div><div>Reviewed-by: Li Qiang &lt;<a href=3D"mailto:li=
q3ea@gmail.com">liq3ea@gmail.com</a>&gt;<br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/isa/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0hw/mips/mips_malta.c | 2 +-<br>
=C2=A0include/hw/isa/isa.h | 2 ++<br>
=C2=A03 files changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c<br>
index 9c37c85ae2..ac9383a658 100644<br>
--- a/hw/isa/piix4.c<br>
+++ b/hw/isa/piix4.c<br>
@@ -45,7 +45,6 @@ typedef struct PIIX4State {<br>
=C2=A0 =C2=A0 =C2=A0uint8_t rcr;<br>
=C2=A0} PIIX4State;<br>
<br>
-#define TYPE_PIIX4_PCI_DEVICE &quot;PIIX4&quot;<br>
=C2=A0#define PIIX4_PCI_DEVICE(obj) \<br>
=C2=A0 =C2=A0 =C2=A0OBJECT_CHECK(PIIX4State, (obj), TYPE_PIIX4_PCI_DEVICE)<=
br>
<br>
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c<br>
index 7d25ab6c23..e499b7a6bb 100644<br>
--- a/hw/mips/mips_malta.c<br>
+++ b/hw/mips/mips_malta.c<br>
@@ -1414,7 +1414,7 @@ void mips_malta_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0ide_drive_get(hd, ARRAY_SIZE(hd));<br>
<br>
=C2=A0 =C2=A0 =C2=A0pci =3D pci_create_simple_multifunction(pci_bus, PCI_DE=
VFN(10, 0),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t=
rue, &quot;PIIX4&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t=
rue, TYPE_PIIX4_PCI_DEVICE);<br>
=C2=A0 =C2=A0 =C2=A0dev =3D DEVICE(pci);<br>
=C2=A0 =C2=A0 =C2=A0isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, &quot;isa.0=
&quot;));<br>
=C2=A0 =C2=A0 =C2=A0piix4_devfn =3D pci-&gt;devfn;<br>
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h<br>
index 018ada4f6f..79f703fd6c 100644<br>
--- a/include/hw/isa/isa.h<br>
+++ b/include/hw/isa/isa.h<br>
@@ -147,4 +147,6 @@ static inline ISABus *isa_bus_from_device(ISADevice *d)=
<br>
=C2=A0 =C2=A0 =C2=A0return ISA_BUS(qdev_get_parent_bus(DEVICE(d)));<br>
=C2=A0}<br>
<br>
+#define TYPE_PIIX4_PCI_DEVICE &quot;piix4-isa&quot;<br>
+<br>
=C2=A0#endif<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote></div></div>

--000000000000b61af105956d3602--

