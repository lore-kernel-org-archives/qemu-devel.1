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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9804FCA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA14222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGGpiPn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA14222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLOLv-0006pd-Cw
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 05:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLOLC-0006Q8-3d
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLOLA-0007EP-OU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:14:34 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLOLA-0007E8-JN
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:14:32 -0400
Received: by mail-oi1-x242.google.com with SMTP id k20so4632366oih.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 02:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=P5siBUFI5iZMtiZieqJjBBSJeQKA4aa2rYGk1Uryo30=;
 b=vGGpiPn3K5IcIS6zPguDDmG3J1LWJDbzfqTn/Q5Xo1PyAyjtie+B2SbjTKOiAsjwvz
 ABeDQ6lD67FEdT5sKDBhlnQRtg73WHpNleAlcrkQpDmEmdgPzl1ZpSzO3DOZbFSFvOiC
 LF+j9JoHXCc5fLw/QaFXDRSV/wcZKhstNDxR6ijEtj7jUv3QTu3Vo4i7Zm6O9S060Fv7
 uWvhcK0yr7X4fFjcYA8m+B8W3mqWRoEmAhUBp9x7C024TjcHmyyPDSKd9OuUctH5uKDl
 Xpu8IPKA2Qq1ZxIB3wHXpWAvk3Q6GkZXZorJ0Ih5HR0FXFHmFuK+pJwv8DeHf/9OuXgv
 s/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=P5siBUFI5iZMtiZieqJjBBSJeQKA4aa2rYGk1Uryo30=;
 b=eOvvilTPp7MjgjHNR1VAEQO6lKMOVbfqMDkHsf2VUCQcw54+5oMQTMnlqPyTeOdrDl
 UKrucP6AclsORdIkxCERzG4arQbaGo2DAOb1iEWmo/Y/fl2CiFmcIEweg8POZZFjo5jN
 Uh5j7tIbQBJzFp8cf5r8uj+frzOpHOpbr5UxGYqKPLr8E3Y8LIX0RFdoSiap4ptEQQcz
 x8a1bNyKtiD1d88Z26MoJMB7x6naJh2RwnKis98eAEBVPatiUF7uK4bQpUnYYo8M+1cC
 AuDVgJIGYwxsQMyWOaGGRnjX1p910dmL7q2KLr9CQ/mE3Mk54RFR3DKHrw4xyxWcmJYt
 mXLw==
X-Gm-Message-State: APjAAAWaXvrC4n8eNsReN787WeTbqdRUscXm0aFnovrpHwhrYoDfabh6
 xqR4/cZh4v3R+4FEPacf1izRTjjvndfMkSMpHJg=
X-Google-Smtp-Source: APXvYqweA1ISXOChYbXDU6YJ0gWI3xlkWzXDwhaWlC7LhH/QEHgzq2p/193RI5+7aHz/7gq2+EKJUjRHlKouyJtwgTM=
X-Received: by 2002:aca:4d12:: with SMTP id a18mr6804354oib.79.1571390071889; 
 Fri, 18 Oct 2019 02:14:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 18 Oct 2019 02:14:31
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-26-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-26-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 18 Oct 2019 11:14:31 +0200
Message-ID: <CAL1e-=iWxE1GKw5dUWrx1knvr+M4sY1tV2d1uRBHPa01c3jLzg@mail.gmail.com>
Subject: Re: [PATCH 25/32] hw/pci-host/piix: Extract piix3_create()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000009e44005952bc33f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

--00000000000009e44005952bc33f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> Extract the PIIX3 creation code from the i440fx_init() function.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/pci-host/piix.c | 51 ++++++++++++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 20 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 2f4cbcbfe9..3292703de7 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -331,6 +331,36 @@ static void i440fx_realize(PCIDevice *dev, Error
> **errp)
>      }
>  }
>
> +static PIIX3State *piix3_create(PCIBus *pci_bus, ISABus **isa_bus)
> +{
> +    PIIX3State *piix3;
> +    PCIDevice *pci_dev;
> +
> +    /*
> +     * Xen supports additional interrupt routes from the PCI devices to
> +     * the IOAPIC: the four pins of each PCI device on the bus are also
> +     * connected to the IOAPIC directly.
> +     * These additional routes can be discovered through ACPI.
> +     */
> +    if (xen_enabled()) {
> +        pci_dev =3D pci_create_simple_multifunction(pci_bus, -1, true,
> +                                                  TYPE_PIIX3_XEN_DEVICE)=
;
> +        piix3 =3D PIIX3_PCI_DEVICE(pci_dev);
> +        pci_bus_irqs(pci_bus, xen_piix3_set_irq, xen_pci_slot_get_pirq,
> +                     piix3, XEN_PIIX_NUM_PIRQS);
> +    } else {
> +        pci_dev =3D pci_create_simple_multifunction(pci_bus, -1, true,
> +                                                  TYPE_PIIX3_DEVICE);
> +        piix3 =3D PIIX3_PCI_DEVICE(pci_dev);
> +        pci_bus_irqs(pci_bus, piix3_set_irq, pci_slot_get_pirq,
> +                     piix3, PIIX_NUM_PIRQS);
> +        pci_bus_set_route_irq_fn(pci_bus, piix3_route_intx_pin_to_irq);
> +    }
> +    *isa_bus =3D ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
> +
> +    return piix3;
> +}
> +
>  PCIBus *i440fx_init(const char *host_type, const char *pci_type,
>                      PCII440FXState **pi440fx_state,
>                      int *piix3_devfn,
> @@ -400,27 +430,8 @@ PCIBus *i440fx_init(const char *host_type, const cha=
r
> *pci_type,
>                   PAM_EXPAN_SIZE);
>      }
>
> -    /* Xen supports additional interrupt routes from the PCI devices to
> -     * the IOAPIC: the four pins of each PCI device on the bus are also
> -     * connected to the IOAPIC directly.
> -     * These additional routes can be discovered through ACPI. */
> -    if (xen_enabled()) {
> -        PCIDevice *pci_dev =3D pci_create_simple_multifunction(b,
> -                             -1, true, TYPE_PIIX3_XEN_DEVICE);
> -        piix3 =3D PIIX3_PCI_DEVICE(pci_dev);
> -        pci_bus_irqs(b, xen_piix3_set_irq, xen_pci_slot_get_pirq,
> -                piix3, XEN_PIIX_NUM_PIRQS);
> -    } else {
> -        PCIDevice *pci_dev =3D pci_create_simple_multifunction(b,
> -                             -1, true, TYPE_PIIX3_DEVICE);
> -        piix3 =3D PIIX3_PCI_DEVICE(pci_dev);
> -        pci_bus_irqs(b, piix3_set_irq, pci_slot_get_pirq, piix3,
> -                PIIX_NUM_PIRQS);
> -        pci_bus_set_route_irq_fn(b, piix3_route_intx_pin_to_irq);
> -    }
> +    piix3 =3D piix3_create(b, isa_bus);
>      piix3->pic =3D pic;
> -    *isa_bus =3D ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
> -
>      *piix3_devfn =3D piix3->dev.devfn;
>
>      ram_size =3D ram_size / 8 / 1024 / 1024;
> --
> 2.21.0
>
>
>

--00000000000009e44005952bc33f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">Extract the PIIX3 creation code from the i440fx_ini=
t() function.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/pci-host/piix.c | 51 ++++++++++++++++++++++++++++--<wbr>----------=
------<br>
=C2=A01 file changed, 31 insertions(+), 20 deletions(-)<br>
<br></blockquote><div><br></div><div id=3D"cvcmsg_16dda40b83dfdaa3" class=
=3D"yh  " style=3D"border-top-left-radius:0px;border-top-right-radius:0px;c=
olor:rgb(34,34,34);font-size:14px;margin-bottom:11px;overflow:visible"><div=
 class=3D"Vh" id=3D"cvcfullmsg_16dda40b83dfdaa3"><div id=3D"cvcmsgbod_16dda=
40b83dfdaa3" class=3D"aj"><div class=3D"Ni"><div class=3D"ni pi " dir=3D"lt=
r"><div><div style=3D"border-top-left-radius:0px;border-top-right-radius:0p=
x;margin-bottom:11px;overflow:visible"><div dir=3D"ltr"><p dir=3D"ltr">Revi=
ewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com" =
target=3D"_blank">amarkovic@wavecomp.com</a>&gt;</p><div style=3D"clear:bot=
h"></div></div><div style=3D"clear:both"></div><div><div></div></div><div s=
tyle=3D"clear:both"></div></div><div style=3D"margin-bottom:11px"><div></di=
v></div></div><div style=3D"clear:both"></div></div><div style=3D"clear:bot=
h"></div><div><div class=3D"M j T b hc Aj S" tabindex=3D"0"><div class=3D"V=
 j hf"></div></div></div><div style=3D"clear:both"></div></div></div></div>=
</div><div id=3D"cvcmsg_16dda40c47482bd5" class=3D"yh wj" style=3D"color:rg=
b(34,34,34);font-size:14px;height:70px;margin-bottom:0px;overflow:hidden"><=
div class=3D"Vh" id=3D"cvcfullmsg_16dda40c47482bd5"><div class=3D"M j Zi Mi=
  " tabindex=3D"0"></div></div></div><div>=C2=A0<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c<br>
index 2f4cbcbfe9..3292703de7 100644<br>
--- a/hw/pci-host/piix.c<br>
+++ b/hw/pci-host/piix.c<br>
@@ -331,6 +331,36 @@ static void i440fx_realize(PCIDevice *dev, Error **err=
p)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static PIIX3State *piix3_create(PCIBus *pci_bus, ISABus **isa_bus)<br>
+{<br>
+=C2=A0 =C2=A0 PIIX3State *piix3;<br>
+=C2=A0 =C2=A0 PCIDevice *pci_dev;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Xen supports additional interrupt routes from the PC=
I devices to<br>
+=C2=A0 =C2=A0 =C2=A0* the IOAPIC: the four pins of each PCI device on the =
bus are also<br>
+=C2=A0 =C2=A0 =C2=A0* connected to the IOAPIC directly.<br>
+=C2=A0 =C2=A0 =C2=A0* These additional routes can be discovered through AC=
PI.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (xen_enabled()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_dev =3D pci_create_simple_<wbr>multifuncti=
on(pci_bus, -1, true,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_PIIX3_XEN_DEVICE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 piix3 =3D PIIX3_PCI_DEVICE(pci_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_bus_irqs(pci_bus, xen_piix3_set_irq, xen_p=
ci_slot_get_pirq,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0piix3, XEN_PIIX_NUM_PIRQS);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_dev =3D pci_create_simple_<wbr>multifuncti=
on(pci_bus, -1, true,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_PIIX3_DEVICE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 piix3 =3D PIIX3_PCI_DEVICE(pci_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_bus_irqs(pci_bus, piix3_set_irq, pci_slot_=
get_pirq,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0piix3, PIIX_NUM_PIRQS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_bus_set_route_irq_fn(pci_<wbr>bus, piix3_r=
oute_intx_pin_to_irq);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 *isa_bus =3D ISA_BUS(qdev_get_child_bus(<wbr>DEVICE(piix3), =
&quot;isa.0&quot;));<br>
+<br>
+=C2=A0 =C2=A0 return piix3;<br>
+}<br>
+<br>
=C2=A0PCIBus *i440fx_init(const char *host_type, const char *pci_type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0PCII440FXState **pi440fx_state,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int *piix3_devfn,<br>
@@ -400,27 +430,8 @@ PCIBus *i440fx_init(const char *host_type, const char =
*pci_type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAM_EXPAN_SI=
ZE);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /* Xen supports additional interrupt routes from the PCI dev=
ices to<br>
-=C2=A0 =C2=A0 =C2=A0* the IOAPIC: the four pins of each PCI device on the =
bus are also<br>
-=C2=A0 =C2=A0 =C2=A0* connected to the IOAPIC directly.<br>
-=C2=A0 =C2=A0 =C2=A0* These additional routes can be discovered through AC=
PI. */<br>
-=C2=A0 =C2=A0 if (xen_enabled()) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 PCIDevice *pci_dev =3D pci_create_simple_<wbr>=
multifunction(b,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-1, true, TYPE_PIIX3_XEN_DEVICE);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 piix3 =3D PIIX3_PCI_DEVICE(pci_dev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_bus_irqs(b, xen_piix3_set_irq, xen_pci_slo=
t_get_pirq,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 piix3, XEN_PIIX_NU=
M_PIRQS);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 PCIDevice *pci_dev =3D pci_create_simple_<wbr>=
multifunction(b,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-1, true, TYPE_PIIX3_DEVICE);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 piix3 =3D PIIX3_PCI_DEVICE(pci_dev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_bus_irqs(b, piix3_set_irq, pci_slot_get_pi=
rq, piix3,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PIIX_NUM_PIRQS);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_bus_set_route_irq_fn(b, piix3_route_intx_p=
in_to_irq);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 piix3 =3D piix3_create(b, isa_bus);<br>
=C2=A0 =C2=A0 =C2=A0piix3-&gt;pic =3D pic;<br>
-=C2=A0 =C2=A0 *isa_bus =3D ISA_BUS(qdev_get_child_bus(<wbr>DEVICE(piix3), =
&quot;isa.0&quot;));<br>
-<br>
=C2=A0 =C2=A0 =C2=A0*piix3_devfn =3D piix3-&gt;dev.devfn;<br>
<br>
=C2=A0 =C2=A0 =C2=A0ram_size =3D ram_size / 8 / 1024 / 1024;<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--00000000000009e44005952bc33f--

