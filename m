Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8518C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 05:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802D820575
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 05:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMWBykQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802D820575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDLwp-0004PI-IO
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 01:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDLvg-0003pr-1f
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 01:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDLve-00048y-R2
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 01:35:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35783
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDLve-00046z-NM
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 01:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584250514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=frOLOEjQaJJpWC0i8QNqpWU1shmwCAN5m76/pYmbrFs=;
 b=SMWBykQ0hAHoxieT2M0TmbKyZ+lgpK18O5D0TYZz7u8qky6qgVPQqW1b0X5bROvKocNLy3
 cwURZ46ghvYCw/+2Fgm4NFE5SdxNb9iIN1SHwbf59uVepjB2nvUzMPT/YVrhEg0sttQ51I
 5Lytw7cjwz4zzZL/ekIF0siGB7tRxoM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-SLSX1MYtPCaazdoHI8A7nA-1; Sun, 15 Mar 2020 01:35:10 -0400
X-MC-Unique: SLSX1MYtPCaazdoHI8A7nA-1
Received: by mail-qv1-f69.google.com with SMTP id k16so12788301qvj.7
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 22:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JQzodnifkdCqmGoXvx0OYAMgKt0DHS9Cmdey6a0SLow=;
 b=GU11RTpehVEZPedgtBi50k9HcVVjfcT+nteppknQTjFP+PLzssOVr8TKD2yEHpSrGh
 F6Qufo2j8vb1XSYXAYFIvchfem4lroRDFzg2nL/YYGsTeeF8ePNDVBNZLIW/8WB5UFtj
 C/Y6DZtxIxjIttYFw/N2AI9vUN1nkgqw8yRm65A3i7F5hBsOZIIw2WYiK8IMDBtt/zLV
 8rhgR10dgcFHbWCq5SHokRAfi3+OjSKtDsK8687NfONSRmDeH85rhHFrWZwce0OdpjCe
 nyEZUhMoS4DnYBBYCkeb1ul0VF4DqkUOyhBv07qrTZWpdb8xzXY+wJUycI1pqNblyZDE
 g9lg==
X-Gm-Message-State: ANhLgQ1wMVYRwTcfXJUJreWvjk5cDM+OoXqFTbsc9z0lYRBYWP7UbT4w
 DNPCXbMzj2GVH0V/z15qGDkZzRbCeJ34VEecI3mt0nu3trzxsf9mkltYsmKI7Muz4D3f429RzCz
 +EDI2lai5LithcOA=
X-Received: by 2002:a05:620a:7f8:: with SMTP id
 k24mr16827702qkk.228.1584250509777; 
 Sat, 14 Mar 2020 22:35:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vshPGLVSe4vsDXxFTzsNzS8YJrxDCZs17lAU/MeRjnhBLwuDori4yumSCV3AZ821uIza/5+eQ==
X-Received: by 2002:a05:620a:7f8:: with SMTP id
 k24mr16827682qkk.228.1584250509497; 
 Sat, 14 Mar 2020 22:35:09 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 l188sm2774053qkc.106.2020.03.14.22.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2020 22:35:08 -0700 (PDT)
Date: Sun, 15 Mar 2020 01:35:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 2/8] hw/ide: Get rid of piix4_init function
Message-ID: <20200315013319-mutt-send-email-mst@kernel.org>
References: <cover.1584134074.git.balaton@eik.bme.hu>
 <3240656814c804513de08bdbbf318f2f590df241.1584134074.git.balaton@eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <3240656814c804513de08bdbbf318f2f590df241.1584134074.git.balaton@eik.bme.hu>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 10:14:34PM +0100, BALATON Zoltan wrote:
> This removes pci_piix4_ide_init() function similar to clean up done to
> other ide devices.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ide/piix.c    | 12 +-----------
>  hw/isa/piix4.c   |  5 ++++-
>  include/hw/ide.h |  1 -
>  3 files changed, 5 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index 8bcd6b72c2..3b2de4c312 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -208,17 +208,6 @@ static void pci_piix_ide_exitfn(PCIDevice *dev)
>      }
>  }
> =20
> -/* hd_table must contain 4 block drivers */
> -/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
> -PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int dev=
fn)
> -{
> -    PCIDevice *dev;
> -
> -    dev =3D pci_create_simple(bus, devfn, "piix4-ide");
> -    pci_ide_create_devs(dev, hd_table);
> -    return dev;
> -}
> -
>  /* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
>  static void piix3_ide_class_init(ObjectClass *klass, void *data)
>  {
> @@ -247,6 +236,7 @@ static const TypeInfo piix3_ide_xen_info =3D {
>      .class_init    =3D piix3_ide_class_init,
>  };
> =20
> +/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
>  static void piix4_ide_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 7edec5e149..0ab4787658 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -35,6 +35,7 @@
>  #include "hw/timer/i8254.h"
>  #include "hw/rtc/mc146818rtc.h"
>  #include "hw/ide.h"
> +#include "hw/ide/pci.h"
>  #include "migration/vmstate.h"
>  #include "sysemu/reset.h"
>  #include "sysemu/runstate.h"
> @@ -255,10 +256,12 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABus *=
*isa_bus,
>          *isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
>      }
> =20
> +    pci =3D pci_create_simple(pci_bus, pci->devfn + 1, "piix4-ide");
>      hd =3D g_new(DriveInfo *, ide_drives);
>      ide_drive_get(hd, ide_drives);
> -    pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
> +    pci_ide_create_devs(pci, hd);
>      g_free(hd);
> +

Why not move pci_create_simple down, and declare a new variable?
-    pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
+    pci_dev =3D pci_create_simple(pci_bus, pci->devfn + 1, "piix4-ide");
+    pci_ide_create_devs(pci_dev, hd);

makes it clearer what's going on imho.

>      pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
>      if (smbus) {
>          *smbus =3D piix4_pm_init(pci_bus, pci->devfn + 3, 0x1100,
> diff --git a/include/hw/ide.h b/include/hw/ide.h
> index 883bbaeb9b..21bd8f23f1 100644
> --- a/include/hw/ide.h
> +++ b/include/hw/ide.h
> @@ -12,7 +12,6 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int io=
base2, int isairq,
>                          DriveInfo *hd0, DriveInfo *hd1);
> =20
>  /* ide-pci.c */
> -PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int dev=
fn);
>  int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
> =20
>  /* ide-mmio.c */
> --=20
> 2.21.1


