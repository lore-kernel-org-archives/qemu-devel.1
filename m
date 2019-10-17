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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D51FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C34821835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DM1Q7iKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C34821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7ut-00023z-AX
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL74s-0002hZ-UC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL74r-0008H5-Hr
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:48:34 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45440)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL74r-0008Gp-Ct
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:48:33 -0400
Received: by mail-ot1-x344.google.com with SMTP id 41so2091028oti.12
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=BZXCpUhCfREGP5Y5KkAXoKF3LwyNMJ+QHt0WBiLCltg=;
 b=DM1Q7iKuNZzLcB9ccnA0BEgRoM0jR0JeBYu/RzjrNvLEVJwMDPOPigJI+cdh+rmUQ+
 uOKjuweWXQu4CoHoIa401FbZaI/L4IBYYOzdQinEHqW5Y6wA3yKN+SNrY92F19slIX/w
 ozzdo1VH42qrWXz0OJJe4oowNNJRnEnsEF3V6CCr1UnvcpPIsT9bRLTvyp8iTOZf+z7n
 u1RWk8OVERQdTBRSUCqU434UIQo4GqtSZdOaGDegv2u52Zt9XiP19h1pulR0F3HSEozX
 8tbJQzjcADbpE2ZEPhLIOIEzVDt6aX2P42RuyNk6CTyVh3gP0NFjf0pSRHv3/5XOgt7v
 QM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=BZXCpUhCfREGP5Y5KkAXoKF3LwyNMJ+QHt0WBiLCltg=;
 b=CdspXezJ0+bk4+Rd0pu+n3isLgGTeFUpFv1O1TR5moUvqp/5ZnL1nQbVldqG9fpeZO
 lSF4AdOfDUYpEYE1rGnu/ehu8umFymhxNnhtZxUwJNbG2ClgkJl6s6+th5si11hTcUlx
 r7rgSdKbg58m7dbq+s/al8ZenWGBMZQgyhXyLiIQ0WO59TTuiaANLEq5ktemGUS7QbiN
 yGzhBqkNxWJ3b49zkKjq5AfymXvEGrqthCXvjH0xeiG/d8KsjwywMjSxPtYVusi9Iq/T
 ePaf5bjESr4FcCGbzhEoXVDGmH+qhMNaXYG3ub2M+Wfo48XhgzdY9ZmG2Ad3U9cr0xRp
 7s+A==
X-Gm-Message-State: APjAAAVOH9+rB7VJMROIQnpX/E8qR/CuaF3D6viNwgFgSUKNiLOUJXh9
 rLM1cgnykdueGgLEB5ywlazNVpRlTnwvRK5OJ/k=
X-Google-Smtp-Source: APXvYqxMK/K/YzvdlRI8mVs2l2zzJzC7DdEch6aYxQvfdnwiXmrxc5nb5dJg+6YuO8cex9dM1ylTiHKHI+A4RyJWauo=
X-Received: by 2002:a9d:5914:: with SMTP id t20mr3311879oth.306.1571323712558; 
 Thu, 17 Oct 2019 07:48:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 07:48:32
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-13-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-13-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 16:48:32 +0200
Message-ID: <CAL1e-=h4AAo13+J8z2rfq6VeTgqE=ZekMRigJZ7eGAYdRCGSWA@mail.gmail.com>
Subject: Re: [PATCH 12/32] piix4: rename PIIX4 object to piix4-isa
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b6d98905951c4f3a"
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

--000000000000b6d98905951c4f3a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>
> Other piix4 parts are already named piix4-ide and piix4-usb-uhci.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Message-Id: <20171216090228.28505-15-hpoussin@reactos.org>
> [PMD: rebased]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/isa/piix4.c       | 1 -
>  hw/mips/mips_malta.c | 2 +-
>  include/hw/isa/isa.h | 2 ++
>  3 files changed, 3 insertions(+), 2 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 1cfc51335a..c3a2bd0d70 100644
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

--000000000000b6d98905951c4f3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">From: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:h=
poussin@reactos.org">hpoussin@reactos.org</a>&gt;<br>
<br>
Other piix4 parts are already named piix4-ide and piix4-usb-uhci.<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.=
org">f4bug@amsat.org</a>&gt;<br>
Acked-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redh=
at.com</a>&gt;<br>
Acked-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini=
@redhat.com</a>&gt;<br>
Signed-off-by: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos=
.org">hpoussin@reactos.org</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20171216090228.28505-15-hpoussin@reactos.=
org">20171216090228.28505-15-hpoussin@reactos.org</a>&gt;<br>
[PMD: rebased]<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/isa/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0hw/mips/mips_malta.c | 2 +-<br>
=C2=A0include/hw/isa/isa.h | 2 ++<br>
=C2=A03 files changed, 3 insertions(+), 2 deletions(-)<br>
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
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c<br>
index 1cfc51335a..c3a2bd0d70 100644<br>
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
=C2=A0 =C2=A0 =C2=A0pci =3D pci_create_simple_<wbr>multifunction(pci_bus, P=
CI_DEVFN(10, 0),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t=
rue, &quot;PIIX4&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t=
rue, TYPE_PIIX4_PCI_DEVICE);<br>
=C2=A0 =C2=A0 =C2=A0dev =3D DEVICE(pci);<br>
=C2=A0 =C2=A0 =C2=A0isa_bus =3D ISA_BUS(qdev_get_child_bus(<wbr>dev, &quot;=
isa.0&quot;));<br>
=C2=A0 =C2=A0 =C2=A0piix4_devfn =3D pci-&gt;devfn;<br>
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h<br>
index 018ada4f6f..79f703fd6c 100644<br>
--- a/include/hw/isa/isa.h<br>
+++ b/include/hw/isa/isa.h<br>
@@ -147,4 +147,6 @@ static inline ISABus *isa_bus_from_device(ISADevice *d)=
<br>
=C2=A0 =C2=A0 =C2=A0return ISA_BUS(qdev_get_parent_bus(<wbr>DEVICE(d)));<br=
>
=C2=A0}<br>
<br>
+#define TYPE_PIIX4_PCI_DEVICE &quot;piix4-isa&quot;<br>
+<br>
=C2=A0#endif<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000b6d98905951c4f3a--

