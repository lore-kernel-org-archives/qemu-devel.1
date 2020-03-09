Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552E7C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 260CE20409
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6HhQtuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260CE20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBP9Q-0000qm-7m
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBP8a-0000CS-T6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBP8Y-00064i-V4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:36:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49005
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBP8Y-00064O-QW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583786190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wD6vZcXRaG39R8nB7Nwb8P9389zEZtKV2JYzfRAip/w=;
 b=H6HhQtuDS9PtotKWkUd93Mf1d3bZkXJA7x8zch8gB5jtY2gCv8F921Vjtn073z9eHaNraI
 vDxzyQewSw7ZlP7fO3oQ0C5c9vSxF0ZX935+ZMEPFO8xBdC131SIzeajrkiQFj/nicUqXM
 0YBNY9sN3QfLENs6lsQUf+qNS4ayotY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-WpdcVpkRPQi3-FyDO1NEoA-1; Mon, 09 Mar 2020 16:36:28 -0400
X-MC-Unique: WpdcVpkRPQi3-FyDO1NEoA-1
Received: by mail-wr1-f70.google.com with SMTP id p11so5717940wrn.10
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 13:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gCcEIxdfDGEuVQbiHnkew/NRhw04KBgfgm5q349vZpk=;
 b=GbRbPH0IENNMMA9eseEKIJsCmkRkSWb7R+McaW5hC7RosRuivHFp6Y++cqoM0dC6s+
 dWtGDoElaxgREffjGyx4mPJP2Du7Hl9RyYNTxbT70zj9h+/CPeY3VNNCgyM989vO8TUA
 OWx3Gpw0oSMV/PSZgkRmOdKGKHDnfkW7H09OUKokVzHEYnDPgkCNHqa2aE7uifBmVqJu
 1yzCwCyodt+V27AyLet5pwQfTMxuJSsHAXGaSlTrGRNIAmrQhuO6/QpEa36XI6UTDiEO
 cuuP1Yca6IUbI27J7m/ClpfBFfZ7wO67zBKQ+JQIakg/KIOKrtngsguTRYih+PDANdmA
 8gsA==
X-Gm-Message-State: ANhLgQ3mLYnsCLynTpkrwEndH7EXHLIa7ryCPkH4NOjoWZx6bAidI4Lu
 d3kPu9Gqsk7IPQZNdAxEYMoAjR2HYWNDDI6/tdZOyQuFBKJMAKX54jSxmpbv3N+0SF+uaZPYCkd
 ZR3qv/jh2QNB3Kb4=
X-Received: by 2002:a1c:59c6:: with SMTP id n189mr966177wmb.178.1583786187040; 
 Mon, 09 Mar 2020 13:36:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv3SwGpT3xweUpTVyFUIZDolCAbc03qC0RcoRqFk7KpTuPxwp8DElDkTURuhaB7UDrJqPB6FA==
X-Received: by 2002:a1c:59c6:: with SMTP id n189mr966155wmb.178.1583786186678; 
 Mon, 09 Mar 2020 13:36:26 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id x24sm956137wmc.36.2020.03.09.13.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 13:36:26 -0700 (PDT)
Date: Mon, 9 Mar 2020 16:36:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v3 3/3] via-ide: Also emulate non 100% native mode
Message-ID: <20200309163537-mutt-send-email-mst@kernel.org>
References: <cover.1583781493.git.balaton@eik.bme.hu>
 <ac37e5f5b86a3b2680c01d7b0d027dafd27a3ac7.1583781494.git.balaton@eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <ac37e5f5b86a3b2680c01d7b0d027dafd27a3ac7.1583781494.git.balaton@eik.bme.hu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-block@nongnu.org, philmd@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 08:18:13PM +0100, BALATON Zoltan wrote:
> Some machines operate in "non 100% native mode" where interrupts are
> fixed at legacy IDE interrupts and some guests expect this behaviour
> without checking based on knowledge about hardware. Even Linux has
> arch specific workarounds for this that are activated on such boards
> so this needs to be emulated as well.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v2: Don't use PCI_INTERRUPT_LINE in via_ide_set_irq()
> v3: Patch pci.c instead of local workaround for PCI reset clearing
>     PCI_INTERRUPT_PIN config reg
>=20
>  hw/ide/via.c            | 37 +++++++++++++++++++++++++++++--------
>  hw/mips/mips_fulong2e.c |  2 +-
>  include/hw/ide.h        |  3 ++-
>  3 files changed, 32 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index 096de8dba0..02d29809f2 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -1,9 +1,10 @@
>  /*
> - * QEMU IDE Emulation: PCI VIA82C686B support.
> + * QEMU VIA southbridge IDE emulation (VT82C686B, VT8231)
>   *
>   * Copyright (c) 2003 Fabrice Bellard
>   * Copyright (c) 2006 Openedhand Ltd.
>   * Copyright (c) 2010 Huacai Chen <zltjiangshi@gmail.com>
> + * Copyright (c) 2019-2020 BALATON Zoltan
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
>   * of this software and associated documentation files (the "Software"),=
 to deal
> @@ -25,6 +26,8 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/range.h"
> +#include "hw/qdev-properties.h"
>  #include "hw/pci/pci.h"
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
> @@ -111,11 +114,18 @@ static void via_ide_set_irq(void *opaque, int n, in=
t level)
>      } else {
>          d->config[0x70 + n * 8] &=3D ~0x80;
>      }
> -
>      level =3D (d->config[0x70] & 0x80) || (d->config[0x78] & 0x80);
> -    n =3D pci_get_byte(d->config + PCI_INTERRUPT_LINE);
> -    if (n) {
> -        qemu_set_irq(isa_get_irq(NULL, n), level);
> +
> +    /*
> +     * Some machines operate in "non 100% native mode" where PCI_INTERRU=
PT_LINE
> +     * is not used but IDE always uses ISA IRQ 14 and 15 even in native =
mode.
> +     * Some guest drivers expect this, often without checking.
> +     */
> +    if (!(pci_get_byte(d->config + PCI_CLASS_PROG) & (n ? 4 : 1)) ||
> +        PCI_IDE(d)->flags & BIT(PCI_IDE_LEGACY_IRQ)) {
> +        qemu_set_irq(isa_get_irq(NULL, (n ? 15 : 14)), level);
> +    } else {
> +        qemu_set_irq(isa_get_irq(NULL, 14), level);
>      }
>  }
> =20
> @@ -169,7 +179,8 @@ static void via_ide_realize(PCIDevice *dev, Error **e=
rrp)
> =20
>      pci_config_set_prog_interface(pci_conf, 0x8f); /* native PCI ATA mod=
e */
>      pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
> -    dev->wmask[PCI_INTERRUPT_LINE] =3D 0xf;
> +    dev->wmask[PCI_CLASS_PROG] =3D 5;

What's the story here? Why is class suddenly writeable?

> +    dev->wmask[PCI_INTERRUPT_LINE] =3D 0;
> =20
>      memory_region_init_io(&d->data_bar[0], OBJECT(d), &pci_ide_data_le_o=
ps,
>                            &d->bus[0], "via-ide0-data", 8);
> @@ -213,14 +224,23 @@ static void via_ide_exitfn(PCIDevice *dev)
>      }
>  }
> =20
> -void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
> +void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn,
> +                  bool legacy_irq)
>  {
>      PCIDevice *dev;
> =20
> -    dev =3D pci_create_simple(bus, devfn, "via-ide");
> +    dev =3D pci_create(bus, devfn, "via-ide");
> +    qdev_prop_set_bit(&dev->qdev, "legacy-irq", legacy_irq);
> +    qdev_init_nofail(&dev->qdev);
>      pci_ide_create_devs(dev, hd_table);
>  }
> =20
> +static Property via_ide_properties[] =3D {
> +    DEFINE_PROP_BIT("legacy-irq", PCIIDEState, flags, PCI_IDE_LEGACY_IRQ=
,
> +                    false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void via_ide_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -233,6 +253,7 @@ static void via_ide_class_init(ObjectClass *klass, vo=
id *data)
>      k->device_id =3D PCI_DEVICE_ID_VIA_IDE;
>      k->revision =3D 0x06;
>      k->class_id =3D PCI_CLASS_STORAGE_IDE;
> +    device_class_set_props(dc, via_ide_properties);
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>  }
> =20
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 4727b1d3a4..150182c62a 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -257,7 +257,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bu=
s, int slot, qemu_irq intc,
>      isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
> =20
>      ide_drive_get(hd, ARRAY_SIZE(hd));
> -    via_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1));
> +    via_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1), false);
> =20
>      pci_create_simple(pci_bus, PCI_DEVFN(slot, 2), "vt82c686b-usb-uhci")=
;
>      pci_create_simple(pci_bus, PCI_DEVFN(slot, 3), "vt82c686b-usb-uhci")=
;
> diff --git a/include/hw/ide.h b/include/hw/ide.h
> index d88c5ee695..2a7001ccba 100644
> --- a/include/hw/ide.h
> +++ b/include/hw/ide.h
> @@ -18,7 +18,8 @@ PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInf=
o **hd_table, int devfn);
>  PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int dev=
fn);
>  PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int dev=
fn);
>  int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
> -void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
> +void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn,
> +                  bool legacy_irq);
> =20
>  /* ide-mmio.c */
>  void mmio_ide_init_drives(DeviceState *dev, DriveInfo *hd0, DriveInfo *h=
d1);
> --=20
> 2.21.1
>=20
>=20


